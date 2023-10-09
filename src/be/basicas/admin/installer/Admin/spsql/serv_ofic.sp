/*************************************************************************/
/*  Archivo            : serv_ofic.sp                                    */
/*  Stored procedure   : sp_serv_ofic                                    */
/*  Base de datos      : cobis                                           */
/*  Producto           : ADMIN                                           */
/*  Disenado por       : Omar Garcia                                     */
/*  Fecha de escritura : 24-02-2015                                      */
/*************************************************************************/
/*                  IMPORTANTE                                           */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  COBISCORP SA,representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                 */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier autorizacion o agregado hecho por alguno de sus            */
/*  usuario sin el debido consentimiento por escrito de la               */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante             */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Procedimiento que inserta, elimina y busca servicios asociados       */
/*  a una oficina                                                        */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR                    RAZON                           */
/*  24/Feb/2014 Omar Garcia              Emision Inicial                 */
/*  11-04-2016  BBO                Migracion Sybase-Sqlserver FAL        */
/*************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_serv_ofic')
   drop proc sp_serv_ofic
go

create proc sp_serv_ofic (
   @s_ssn                   int = NULL,
   @s_user                  login = NULL,
   @s_sesn                  int = NULL,
   @s_term                  varchar(32) = NULL,
   @s_date                  datetime = NULL,
   @s_srv                   varchar(30) = NULL,
   @s_lsrv                  varchar(30) = NULL, 
   @s_rol                   smallint = NULL,
   @s_ofi                   smallint = NULL,
   @s_org_err               char(1) = NULL,
   @s_error                 int = NULL,
   @s_sev                   tinyint = NULL,
   @s_msg                   descripcion = NULL,
   @s_org                   char(1) = NULL,
   @t_show_version          bit = 0,
   @t_debug                 char(1) = 'N',
   @t_file                  varchar(14) = null,
   @t_from                  varchar(32) = null,
   @t_trn                   smallint =NULL,
   @i_operacion             varchar(1),
   @i_filial                tinyint = null,
   @i_oficina               smallint = null,
   @i_cat_serv              char(10) = null,
   @i_modo                  tinyint=NULL)
as
   declare
      @w_sp_name          varchar(32),
      @w_today            datetime,
      @w_var              int,
      @w_aux              tinyint,   
      @w_codigo           int,
      @w_departamento     smallint,
      @w_filial           tinyint,
      @w_oficina          smallint,
      @w_descripcion      descripcion,
      @w_o_departamento   smallint,
      @w_o_oficina        smallint,
      @w_nivel            tinyint,
      @v_departamento     smallint,
      @v_filial           tinyint,
      @v_oficina          smallint,
      @v_descripcion      descripcion,
      @v_o_departamento   smallint,
      @v_o_oficina        smallint,
      @v_nivel            tinyint,
      @o_departamento     tinyint,
      @o_filial           tinyint,
      @o_finombre         descripcion,
      @o_oficina          smallint,
      @o_lonombre         descripcion,
      @o_descripcion      descripcion,
      @o_o_departamento   smallint,
      @o_o_oficina        smallint,
      @o_denombre         descripcion,
      @o_nivel            tinyint,
      @w_return           int,
      @w_cmdtransrv       varchar(64),
      @w_nt_nombre        varchar(32),
      @w_num_nodos        smallint,    
      @w_contador         smallint,
      @w_clave            int

   select @w_sp_name = 'sp_serv_ofic'
   
   /*--VERSIONAMIENTO--*/
   if @t_show_version = 1
      begin
         print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
         return 0
      end
   /*--FIN DE VERSIONAMIENTO--*/
   
   if @t_trn = 15389
      begin
	     if @i_cat_serv is not null
            begin
               /*--Validando que el codigo de catalogo sea el correcto--*/
               if not exists(select 1 
                           from cl_tabla t,cl_catalogo c
                           where t.tabla='cl_servicio'
                           and c.tabla=t.codigo
                           and c.codigo=@i_cat_serv)
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file      = @t_file,
                        @t_from      = @w_sp_name,
                        @i_num      = 157932                        
                     /*El servicio ya esta asociado a esa oficina*/
                     return 1
                  end
            end			
	  
         /*-- Insert--*/
         if @i_operacion = 'I'
            begin            
               /*--Validando que el servicio no este duplicado--*/
               if exists(select 1 from cl_ofic_servicio
                        where os_filial=@i_filial 
                        and os_oficina=@i_oficina
                        and os_cat_servicio=@i_cat_serv)
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file      = @t_file,
                        @t_from      = @w_sp_name,
                        @i_num      = 157930                        
                     /*El servicio ya esta asociado a esa oficina*/
                     return 1
                  end

               begin tran
                  insert into cl_ofic_servicio (os_oficina,os_filial,os_cat_servicio)
                     values (@i_oficina,@i_filial, @i_cat_serv)                     
                     
                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 153071                           
                        /*Error en creacion de servicio financiero*/
                        return 1
                     end
                     
                  /*Transaccion servicio - servicio financiero */
                  insert into ts_serv_ofic (secuencia, tipo_transaccion, clase, fecha,
                                       oficina_s, usuario, terminal_s, srv, lsrv,hora,
                                       oficina, filial, servicio)
                     values (@s_ssn, 15389, 'N', @s_date,
                           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,getdate(),   
                           @i_oficina, @i_filial, @i_cat_serv)
                        
                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 153027
                        /* 'Error en creacion de transaccion de servicio financiero'*/
                        return 1
                     end
                     
               commit tran            
               return 0

            end
         
         /*--Delete--*/      
         if @i_operacion = 'D'         
            begin
               begin tran
                  /*--Eliminando el servicio financiero--*/
                  delete from cl_ofic_servicio
                     where os_oficina=@i_oficina
                     and os_filial=@i_filial
                     and os_cat_servicio=@i_cat_serv
                     
                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 157211                           
                        /*Error en eliminacion de servicio financiero*/
                        return 1
                     end
                  
                  /*Transaccion eliminacion servicio - servicio financiero */
                  insert into ts_serv_ofic (secuencia, tipo_transaccion, clase, fecha,
                                       oficina_s, usuario, terminal_s, srv, lsrv,hora,
                                       oficina, filial, servicio)
                     values (@s_ssn, 15389, 'B', @s_date,
                           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,getdate(),   
                           @i_oficina, @i_filial, @i_cat_serv)
                        
                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 157216
                        /* 'Error en eliminacion de transaccion de servicio financiero'*/
                        return 1
                     end
                  
               commit tran
               return 0
            end
            
         /*--Busqueda de todas los servicios asociados a una oficina--*/
         if @i_operacion = 'S'
            begin
               set rowcount 20
			   if (@i_modo = 0) or (@i_modo is null)
			      begin
                     select 'CODIGO'=c.codigo, 
                        'SERVICIO'=c.valor
                        from cl_ofic_servicio s,cl_tabla t, cl_catalogo c
                        where t.codigo=c.tabla
						and s.os_cat_servicio=c.codigo
						and t.tabla='cl_servicio'
						and s.os_oficina=@i_oficina
                        and s.os_filial=@i_filial
                        order by c.codigo
                  
                        if @@rowcount=0
                           begin
                              exec sp_cerror
                                 @t_debug = @t_debug,
                                 @t_file  = @t_file,
                                 @t_from  = @w_sp_name,
                                 @i_num   = 157937
                              set rowcount 0
                              return 1
                              /*--No existen servicios financieros asociados a la oficina--*/
                           end
				  end
				  
				 if @i_modo=1
				    begin
                     select 'CODIGO' = c.codigo, 
                        'SERVICIO' = c.valor
                        from cl_ofic_servicio s,cl_tabla t, cl_catalogo c
                        where t.codigo = c.tabla
						and s.os_cat_servicio = c.codigo
						and t.tabla = 'cl_servicio'
						and s.os_oficina = @i_oficina
                        and s.os_filial = @i_filial
						and c.codigo > @i_cat_serv
                        order by c.codigo
                  
                        /*--Correccion de Siguientes--*/                             
                        if @@rowcount=0
                           begin
                              exec sp_cerror
                                 @t_debug = @t_debug,
                                 @t_file  = @t_file,
                                 @t_from  = @w_sp_name,
                                 @i_num   = 157938
                              set rowcount 0
                              return 1
                              /*--No existen más servicios financieros asociados a la oficina--*/
                           end
					end
            end   
            
         /*--Query con un servicio especifico--*/
         if @i_operacion = 'Q'
            begin
               
               select 'CODIGO'=c.codigo, 
                  'SERVICIO'=c.valor
                  from cl_ofic_servicio s,cl_tabla t, cl_catalogo c
                  where s.os_oficina=@i_oficina
                  and s.os_filial=@i_filial
                  and s.os_cat_servicio=@i_cat_serv
                  and s.os_cat_servicio=c.codigo
                  and t.codigo=c.tabla
                  and t.tabla='cl_servicio'
                  and c.codigo=@i_cat_serv
                  
                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 157931                           
                        /*--El servicio financiero no esta asociado a la oficina--*/
                        return 1
                     end                  
            end
            
      end
   else
      begin
         exec sp_cerror
            @t_debug    = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num    = 151051                  
         /*--No corresponde codigo de transaccion--*/
         return 1
      end

return 0      
go
