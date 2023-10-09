/*************************************************************************/
/*  Archivo            : func_ofic.sp                                    */
/*  Stored procedure   : sp_func_ofic                                    */
/*  Base de datos      : cobis                                           */
/*  Producto           : ADMIN                                           */
/*  Disenado por       : Jose Guamani                                    */
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
/*  25/Feb/2014 Jose Guamani             Emision Inicial                 */
/*  11-04-2016  BBO                      Migracion Sybase-Sqlserver FAL  */
/*************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select 1 from sysobjects where name = 'sp_func_ofic')
   drop proc sp_func_ofic
go

create proc sp_func_ofic (
   @s_ssn                 int = NULL,
   @s_user                login = NULL,
   @s_sesn                int = NULL,
   @s_term                varchar(32) = NULL,
   @s_date                datetime = NULL,
   @s_srv                 varchar(30) = NULL,
   @s_lsrv                varchar(30) = NULL, 
   @s_rol                 smallint = NULL,
   @s_ofi                 smallint = NULL,
   @s_org_err             char(1) = NULL,
   @s_error               int = NULL,
   @s_sev                 tinyint = NULL,
   @s_msg                 descripcion = NULL,
   @s_org                 char(1) = NULL,
   @t_show_version        bit = 0,
   @t_debug               char(1) = 'N',
   @t_file                varchar(14) = null,
   @t_from                varchar(32) = null,
   @t_trn                 smallint =NULL,
   @i_operacion           varchar(1),
   @i_filial              tinyint = null,
   @i_oficina             smallint = null,
   @i_funcionar           smallint=null
)
as
 declare
    @w_sp_name            varchar(32),
    @w_today              datetime,
    @w_var                int,
    @w_aux                tinyint,   
    @w_codigo             int,
    @w_departamento       smallint,
    @w_filial             tinyint,
    @w_oficina            smallint,
    @w_descripcion        descripcion,
    @w_o_departamento     smallint,
    @w_o_oficina          smallint,
    @w_nivel              tinyint,
    @v_departamento       smallint,
    @v_filial             tinyint,
    @v_oficina            smallint,
    @v_descripcion        descripcion,
    @v_o_departamento     smallint,
    @v_o_oficina          smallint,
    @v_nivel              tinyint,
    @o_departamento       tinyint,
    @o_filial             tinyint,
    @o_finombre           descripcion,
    @o_oficina            smallint,
    @o_lonombre           descripcion,
    @o_descripcion        descripcion,
    @o_o_departamento     smallint,
    @o_o_oficina          smallint,
    @o_denombre           descripcion,
    @o_nivel              tinyint,
    @w_return             int,
    @w_cmdtransrv         varchar(64),
    @w_nt_nombre          varchar(32),
    @w_num_nodos          smallint,    
    @w_contador           smallint,
    @w_clave              int,
    @w_errmsj             int,
    @o_secuencial         int,
	@w_oficfunc           int

   select @w_sp_name = 'sp_func_ofic'
   
   --VERSIONAMIENTO
   if @t_show_version = 1
   begin
      print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
      return 0
   end
   
   -- VALIDACION DE TRANSACCIONES
   if @t_trn <> 15392
   begin
      exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 151051                  
       --NO CORRESPONDE CODIGO DE TRANSACCION
      RETURN 151051
   END

   --VALIDACION MENSAJE ERROR
   if @i_funcionar > 0
      select @w_errmsj = 157936
   else
      select @w_errmsj = 157934
   
   
-- INSERT
if @i_operacion = 'I'
   begin      
  
   --SECUENCIAL TABLA
    exec sp_cseqnos
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_tabla    = 'cl_ofic_func',
         @o_siguiente= @o_secuencial out
     
   --VALIDACION: RELACION OFICINA - SUPERVISOR NO EXISTA
      if exists(select 1 
                  from cl_ofic_func
                 where of_filial     = @i_filial 
                   and of_oficina    = @i_oficina
                   and of_funcionar  = @i_funcionar)
                   --and of_secuencial = @o_secuencial)
       begin
          exec sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 157933                        
             --EL SUPERVISOR YA ESTA ASOCIADO A ESA OFICINA
          return 157933
       end
            
       begin tran
          insert into cl_ofic_func (of_secuencial,of_oficina, of_filial, of_funcionar)
                            values (@o_secuencial,@i_oficina, @i_filial, @i_funcionar)
          if @@error != 0
          begin
             exec sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 153095                     
              --ERROR EN CREACION DE RELACION OFICINA - SUPERVISOR
              return 153095
          end
            
          --TRANSACCION OFICINA -SUPERVISOR 
          insert into ts_ofic_func (secuencia,  tipo_transaccion,   clase,       fecha, 
                                    oficina_s,  usuario,            terminal_s,  srv,
                                    lsrv,       hora,               filial,      oficina,
                                    funcionario)
                            values (@s_ssn,     15392,              'N',         @s_date,
                                    @s_ofi,     @s_user,            @s_term,     @s_srv, 
                                    @s_lsrv,    getdate(),          @i_filial,   @i_oficina,
                                    @i_funcionar)
                   
          if @@error != 0
             begin
                exec sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 153096
                 --'ERROR EN CREACION DE TRANSACCION OFICNA SUPERVISOR
                 return 153096
              end      
                  
       commit tran            
              
       return 0
   end
      
--DELETE
if @i_operacion = 'D'         
begin
   --VALIDAR ROLES DE UN SUPERVISOR
      select @w_oficfunc  = of_secuencial
       from cl_ofic_func  
      where of_oficina   = @i_oficina
        and of_filial    = @i_filial
        and of_funcionar = @i_funcionar

    if exists(select  1 from cl_ofic_func_rol
           where or_oficfunc   = @w_oficfunc)
    begin
       exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157228
            --'ERROR, NO SE PUEDE ELIMINAR EL SUPERVISOR TIENE ROLES ASIGNADOS
       return 157228
    end

    begin tran
        
      --ELIMINANDO SUPERVISOR DE OFICINA
      delete from cl_ofic_func
                 where of_oficina   = @i_oficina
                   and of_filial    = @i_filial
                   and of_funcionar = @i_funcionar
         
      if @@error != 0
         begin
            exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 157213               
            --ERROR AL ELIMINAR RELACION OFICINA - SUPERVISOR
            return 157213
         end
      
      --TRANSACCION OFICINA - SUPERVISOR
      insert into ts_ofic_func (secuencia, tipo_transaccion, clase,      fecha,
                                oficina_s, usuario,          terminal_s, srv, 
                                lsrv,      hora,             filial,     oficina,
                                funcionario)
                        values (@s_ssn,    15392,            'B',        @s_date,
                                @s_ofi,    @s_user,          @s_term,    @s_srv, 
                                @s_lsrv,   getdate(),        @i_filial,  @i_oficina,
                                @i_funcionar)
            
      if @@error != 0
         begin
            exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 153096
            --ERROR EN CREACION DE TRANSACCION DE SERVICIO FINANCIERO
            return 153096
         end
      
   commit tran
   
   return 0
end
         
--BUSQUEDA DE TODAS LOS SUPERVISORS ASOCIADOS A UNA OFICINA
if @i_operacion = 'S'
   begin
      set rowcount 20
      select 'CODIGO'     = f.fu_funcionario,   
             'NOMBRE'     = f.fu_nombre,
             'SECUENCIAL' = o.of_secuencial
        from cl_ofic_func o,cl_funcionario f
       where o.of_funcionar = f.fu_funcionario
         and o.of_oficina   = @i_oficina
         and o.of_filial    = @i_filial
         and (@i_funcionar is null or f.fu_funcionario > @i_funcionar)
         order by f.fu_funcionario
   
      if @@rowcount=0
         begin
            exec sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = @w_errmsj
            set rowcount 0
            return 1
            --NO HAY REGISTROS
         end
       set rowcount 0
    end   
          
--BUSQUEDA DE UN FUCNIONARIO POR ID
if @i_operacion = 'Q'
   begin
      select 'CODIGO'=f.fu_funcionario,   
             'NOMBRE'=f.fu_nombre,
             'SECUENCIAL' = o.of_secuencial
      from cl_ofic_func o,cl_funcionario f
     where o.of_funcionar= f.fu_funcionario
       and o.of_oficina  = @i_oficina
       and o.of_filial   = @i_filial
       and o.of_funcionar= @i_funcionar
   
      if @@rowcount=0
         begin
            exec sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 157935
            set rowcount 0
            return 1
            --NO HAY MAS REGISTROS
         end  
end
   
return 0      
go


