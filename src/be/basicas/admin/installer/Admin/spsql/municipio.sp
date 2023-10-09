/*************************************************************************/
/*  Archivo            : municipio.sp                                    */
/*  Stored procedure   : sp_municipio                                    */
/*  Base de datos      : cobis                                           */
/*  Producto           : ADMIN                                           */
/*  Disenado por       : Omar Garcia                                     */
/*  Fecha de escritura : 27-02-2015                                      */
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
/*  Procedimiento que inserta, actualiza, elimina y busca municipios     */
/*                                                                       */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR                    RAZON                           */
/*  27/Feb/2014 Omar Garcia              Emision Inicial                 */
/*  11-04-2016  BBO          Migracion Sybase-Sqlserver FAL             */
/*************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_municipio')
   drop proc sp_municipio
go

create proc sp_municipio (
   @s_ssn                int = NULL,
   @s_user               login = NULL,
   @s_sesn               int = NULL,
   @s_term               varchar(32) = NULL,
   @s_date               datetime = NULL,
   @s_srv                varchar(30) = NULL,
   @s_lsrv               varchar(30) = NULL, 
   @s_rol                smallint = NULL,
   @s_ofi                smallint = NULL,
   @s_org_err            char(1) = NULL,
   @s_error              int = NULL,
   @s_sev                tinyint = NULL,
   @s_msg                descripcion = NULL,
   @s_org                char(1) = NULL,
   @t_debug              char(1) = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(32) = null,
   @t_trn                smallint = NULL,
   @t_show_version       bit = 0,
   @i_operacion          varchar(2),
   @i_modo               tinyint = null,
   @i_tipo               varchar(1) = null,
   @i_municipio          catalogo = null,
   @i_descripcion        descripcion = null,
   @i_cod_provincia      int = null, 
   @i_estado             estado = null,
   @i_municipio_alf      descripcion = null,
   @i_valor              descripcion = null
)
as
   declare @w_today      datetime,
      @w_sp_name         varchar(32),
      --@w_cambio          int,
      @w_codigo          int,
      @w_descripcion     descripcion,
      @w_cod_provincia   int,
      --@w_cod_depart      catalogo,
      @w_estado          estado,
      --@w_cod_pais        smallint,
      --@w_transaccion     int,
      @v_descripcion     descripcion,
      @v_cod_provincia   int,
      --@v_cod_depart      catalogo,      
      @v_estado          estado,
      --@v_cod_pais        smallint,
      --@o_provincia       int,
      --@w_server_logico   varchar(10),
      --@w_num_nodos       smallint,    
      --@w_contador        smallint,
      --@w_cmdtransrv      varchar(60),
      --@w_nt_nombre       varchar(30),
      --@w_clave           int,
      @w_return          int,
      @w_codigo_c        varchar(10)

   select @w_today=@s_date,
      @w_sp_name = 'sp_municipio'
   
   --VERSIONAMIENTO
   if @t_show_version = 1
      begin
         print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
         return 0
      end
   --FIN DE VERSIONAMIENTO

   if @t_trn != 15396 
      begin
         exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151051
         --NO CORRESPONDE CODIGO DE TRANSACCION
         return 1
      end
   else
      begin
         --VERIFICACION DE LLAVES FORANEAS
         --VERIFICACION DE CODIGO DE PROVINCIA
         if (@i_cod_provincia is not null)
            begin
               select @w_codigo = null
               from cl_provincia p
               where p.pv_provincia = @i_cod_provincia         
           
               if @@rowcount = 0
                  begin
                     exec sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 157942
                     --COIGO DE PROVINCIA INCORRECTO
                     return 1
                  end
            end         
      
         --INSERT
         if @i_operacion = 'I'
            begin
               --VALIDACION DE DUPLICIDAD DE MUNICIPIO
               if exists (select 1  
                  from cl_municipio m
                  where m.mu_municipio = @i_municipio)
               begin
                  exec sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 157941
                  --YA EXISTE MUNICIPIO
                  return 1
               end
                  
               begin tran
                  insert into cl_municipio (mu_municipio,   mu_descripcion, 
                                            mu_cod_prov,    mu_estado)
                     values (@i_municipio,   @i_descripcion,   @i_cod_provincia, 'V')

                     if @@error != 0
                        begin
                           exec sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 153097
                           --ERROR EN LA CREACION DE MUNICIPIO
                           return 1
                        end
                     
                  --TRANSACCION SERVICIO - MUNICIPIO
                  insert into ts_municipio (secuencia,     tipo_transaccion,   clase,         fecha,
                                            oficina_s,     usuario,            terminal_s,    srv,
                                            lsrv,          hora,               cod_municipio, descripcion,
                                            cod_provincia, estado)
                     values (@s_ssn,           15396,               'N', @s_date,
                             @s_ofi,           @s_user,             @s_term,
                             @s_srv,           @s_lsrv,getdate(),   @i_municipio,
                             @i_descripcion,   @i_cod_provincia,    @i_estado)
                              
                     if @@error != 0
                        begin
                           exec sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 153027
                           --ERROR EN CREACION DE TRANSACCION DE SERVICIOS
                           return 1
                        end
               commit tran

               --ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
               select @w_codigo_c = convert(varchar(10), @i_municipio)
               exec @w_return     = sp_catalogo
                  @s_ssn         = @s_ssn,
                  @s_user        = @s_user,
                  @s_sesn        = @s_sesn,
                  @s_term        = @s_term,   
                  @s_date        = @s_date,   
                  @s_srv         = @s_srv,   
                  @s_lsrv        = @s_lsrv,   
                  @s_rol         = @s_rol,
                  @s_ofi         = @s_ofi,
                  @s_org_err     = @s_org_err,
                  @s_error       = @s_error,
                  @s_sev         = @s_sev,
                  @s_msg         = @s_msg,
                  @s_org         = @s_org,
                  @t_debug       = @t_debug,   
                  @t_file        = @t_file,
                  @t_from        = @w_sp_name,
                  @t_trn         = 584,
                  @i_operacion   = 'I',
                  @i_tabla       = 'cl_municip_seccion',
                  @i_codigo      = @w_codigo_c,
                  @i_descripcion = @i_descripcion,
                  @i_estado      = 'V'   
                  
               if @w_return != 0
                  return @w_return
                  
               return 0
            end
            
         --UPDATE
         if @i_operacion = 'U'
            begin
               --OBTENIENDO EL VALOR ANTERIOR DE LOS CAMPOS DEL REGISTRO
               select @w_descripcion = mu_descripcion,
                  @w_cod_provincia  = mu_cod_prov,
                  @w_estado         = mu_estado
                  from cl_municipio
                  where mu_municipio = @i_municipio

                  select @v_descripcion   = @w_descripcion
                  select @v_cod_provincia = @w_cod_provincia
                  select @v_estado        = @w_estado

               --DESCRIPCION
               if @w_descripcion = @i_descripcion
                  select @w_descripcion = null, @v_descripcion = null
               else
                  select @w_descripcion = @i_descripcion

               --CODIGO DE PROVINCIA   
               if @w_cod_provincia = @i_cod_provincia
                  select @w_cod_provincia = null, @v_cod_provincia = null
               else
                  select @w_cod_provincia = @i_cod_provincia

               --ESTADO   
               if @w_estado = @i_estado
                  select @w_estado = null, @v_estado = null
               else
                  begin
                     if @i_estado = 'C'
                  begin
                           if exists (select 1 
                                   from cl_canton c, cl_municipio m
                               where c.ca_municipio = m.mu_municipio
                               and c.ca_municipio = @i_municipio)
                              begin
                                 exec sp_cerror
                                    @t_debug = @t_debug,
                                    @t_file  = @t_file,
                                    @t_from  = @w_sp_name,
                                    @i_num   = 157219
                                 --EXISTE REFERENCIA EN CANTON
                                 return 1
                              end                       
                        end
                     else
                        begin
                           --VALIDANDO LA VIGENCIA DE LA PROVINCIA
                           if exists (select 1  
                              from cl_provincia
                              where pv_provincia = @i_cod_provincia
                              and pv_estado = 'C')
                              
                              begin
                                 exec sp_cerror
                                    @t_debug = @t_debug,
                                    @t_file  = @t_file,
                                    @t_from  = @w_sp_name,
                                    @i_num   = 157943
                                 --PROVINCIA NO VIGENTE
                                 return 1
                              end
                        end

                     select @w_estado = @i_estado
                  end

               begin tran
                  --UPDATE MUNICIPIO
                  update cl_municipio
                     set mu_descripcion  = @i_descripcion,
                        mu_cod_prov      = @i_cod_provincia,
                        mu_estado        = @i_estado
                     where  mu_municipio = @i_municipio

                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug = @t_debug,
                           @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 105038
                        --ERROR EN ACTUALIZACION DE PROVINCIA
                        return 1
                     end

                  --TRANSACCION SERVICIOS - MUNICIPIOS
                  --PREVIO
                  insert into ts_municipio (secuencia,       tipo_transaccion,   clase,
                                            fecha,           oficina_s,          usuario,
                                            terminal_s,      srv,   lsrv,        hora,
                                            cod_municipio,   descripcion,        cod_provincia,
                                            estado)
                  values (@s_ssn,             15396,       'P',            @s_date,
                          @s_ofi,             @s_user,     @s_term,        @s_srv,
                          @s_lsrv,            getdate(),   @i_municipio,   @v_descripcion,
                          @v_cod_provincia,   @v_estado)

                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug = @t_debug,
                           @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 157217
                        --ERROR EN CREACION DE TRANSACCION DE SERVICIOS
                        return 1
                     end
                  
                  --ACTUAL
                  insert into ts_municipio (secuencia,       tipo_transaccion,   clase,
                                            fecha,           oficina_s,          usuario,
                                            terminal_s,      srv,   lsrv,        hora,
                                            cod_municipio,   descripcion,        cod_provincia,
                                            estado)
                  values (@s_ssn,             15396,       'A',            @s_date,
                          @s_ofi,             @s_user,     @s_term,        @s_srv,
                          @s_lsrv,            getdate(),   @i_municipio,   @w_descripcion,
                          @w_cod_provincia,   @w_estado)

                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug = @t_debug,
                           @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 157217
                        --ERROR EN CREACION DE TRANSACCION DE SERVICIOS
                        return 1
                     end
               commit tran

               select @w_codigo_c = convert(varchar(10), @i_municipio)
               
               exec @w_return     = sp_catalogo
                  @s_ssn         = @s_ssn,
                  @s_user        = @s_user,
                  @s_sesn        = @s_sesn,
                  @s_term        = @s_term,   
                  @s_date        = @s_date,   
                  @s_srv         = @s_srv,   
                  @s_lsrv        = @s_lsrv,   
                  @s_rol         = @s_rol,
                  @s_ofi         = @s_ofi,
                  @s_org_err     = @s_org_err,
                  @s_error       = @s_error,
                  @s_sev         = @s_sev,
                  @s_msg         = @s_msg,
                  @s_org         = @s_org,
                  @t_debug       = @t_debug,   
                  @t_file        = @t_file,
                  @t_from        = @w_sp_name,
                  @t_trn         = 585,
                  @i_operacion   = 'U',
                  @i_tabla       = 'cl_municip_seccion',
                  @i_codigo      = @w_codigo_c,
                  @i_descripcion = @i_descripcion,
                  @i_estado      = @i_estado
                  
               return 0            
            end
            
         --SEARCH
         if @i_operacion = 'S'
            begin
               set rowcount 20
               if (@i_modo = 0 or @i_modo is null)
                  begin
                     select 
                        'CODIGO'        = mu_municipio,
                        'MUNICIPIO'         = substring(mu_descripcion,1,20),
                        'COD. PAIS.'        = p.pa_pais,
                        'PAIS'              = substring(p.pa_descripcion,1,20),
                        --'COD. DEPARTAMENTO' = d.dp_departamento,
                        --'DEPARTAMENTO'      = substring(d.dp_descripcion,1,20),
                        'COD. PROVINCIA'    = pr.pv_provincia,
                        'PROVINCIA'         = substring(pr.pv_descripcion,1,20),
                        'ESTADO'            = mu_estado
                     from   cl_municipio m, cl_provincia pr,
                            cl_pais p --, cl_depart_pais d
                     where m.mu_cod_prov     = pr.pv_provincia
                       --and pr.pv_depart_pais = d.dp_departamento
                       --and d.dp_pais         = p.pa_pais                
                     order by mu_municipio
                     
                     if @@rowcount=0
                        begin
                           exec sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 157945
                           set rowcount 0
                           return 1
                           --NO EXISTEN MUNICIPIOS
                        end
                  end
                  
               if @i_modo = 1 
                  begin
                     select 'CODIGO'         = mu_municipio,
                        'MUNICIPIO'         = substring(mu_descripcion,1,20),
                        'COD. PAIS.'        = p.pa_pais,
                        'PAIS'              = substring(p.pa_descripcion,1,20),
                        --'COD. DEPARTAMENTO' = d.dp_departamento,
                        --'DEPARTAMENTO'      = substring(d.dp_descripcion,1,20),
                        'COD. PROVINCIA'    = pr.pv_provincia,
                        'PROVINCIA'         = substring(pr.pv_descripcion,1,20),
                        'ESTADO'            = mu_estado
                     from   cl_municipio m, cl_provincia pr,
                       cl_pais p, cl_depart_pais d
                     where m.mu_cod_prov     = pr.pv_provincia
                       --and pr.pv_depart_pais = d.dp_departamento
                       --and d.dp_pais         = p.pa_pais                       
                       and m.mu_municipio    > @i_municipio
                     order by mu_municipio
                
                     if @@rowcount = 0
                        begin
                           exec sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 157944
                              --NO EXISTEN MAS MUNICIPIOS
                           set rowcount 0
                          return 1
                        end
                  end

            end

         --QUERY
         if @i_operacion = 'Q'
            begin
                 select 'CODIGO'         = mu_municipio,
                      'MUNICIPIO'         = substring(mu_descripcion,1,20),
                      'COD. PAIS.'        = p.pa_pais,
                      'PAIS'              = substring(p.pa_descripcion,1,20),
                      --'COD. DEPARTAMENTO' = d.dp_departamento,
                      --'DEPARTAMENTO'      = substring(d.dp_descripcion,1,20),
                      'COD. PROVINCIA'    = pr.pv_provincia,
                      'PROVINCIA'         = substring(pr.pv_descripcion,1,20),
                      'ESTADO'            = mu_estado
               from   cl_municipio m, cl_provincia pr,
                       cl_pais p, cl_depart_pais d
               where   m.mu_cod_prov     = pr.pv_provincia
                       --and     pr.pv_depart_pais = d.dp_departamento
                       --and     d.dp_pais         = p.pa_pais
                       and     m.mu_estado       = 'V'
                       and     m.mu_municipio    = @i_municipio
                  
               if @@rowcount = 0
                  begin
                     exec sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 157940
                        --NO EXISTEN EL MUNICIPIO
                     set rowcount 0
                     return 1
                  end
            end

         --HELP
         if @i_operacion = 'H'
            begin
               if @i_tipo = 'A'
                  begin
                     set rowcount 20
                     if @i_modo = 0
                        begin
                           select 'COD.'        = mu_municipio,
                              'MUNICIPIO'      = mu_descripcion,
                              'COD. PROVINCIA' = pv_provincia,
                              'PROVINCIA'      = pv_descripcion
                           from cl_municipio m, cl_provincia p
                           where m.mu_cod_prov = p.pv_provincia
                           and  m.mu_cod_prov    = @i_cod_provincia
                           and  mu_estado        = 'V'
                        end
                        
                        if @@rowcount=0
                           begin
                              exec sp_cerror
                                 @t_debug = @t_debug,
                                 @t_file  = @t_file,
                                 @t_from  = @w_sp_name,
                                 @i_num   = 157945
                              set rowcount 0
                              return 1
                              --NO EXISTEN MUNICIPIOS
                           end
                        
                     if @i_modo = 1
                        begin
                           select 'COD.'       = mu_municipio,
                              'MUNICIPIO'      = mu_descripcion,
                              'COD. PROVINCIA' = pv_provincia,
                              'PROVINCIA'      = pv_descripcion
                           from cl_municipio m, cl_provincia p
                           where m.mu_cod_prov = p.pv_provincia
                           and  m.mu_cod_prov    = @i_cod_provincia
                           and  mu_estado        = 'V'
                           and  m.mu_municipio > @i_municipio
                           
                           if @@rowcount = 0
                              begin
                                 exec sp_cerror
                                    @t_debug   = @t_debug,
                                    @t_file      = @t_file,
                                    @t_from      = @w_sp_name,
                                    @i_num      = 157944
                                    --NO EXISTEN MAS MUNICIPIOS
                                 set rowcount 0
                                 return 1
                              end 
                        end
                  end
                  
               if @i_tipo = 'V'
                  begin
                     select mu_descripcion 
                     from cl_municipio
                     where mu_municipio = @i_municipio
                     and mu_estado = 'V'
                     
                     if @@rowcount = 0
                        begin
                           exec sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 157940
                              --NO EXISTE EL MUNICIPIO
                           set rowcount 0
                           return 1
                        end
                  end

               --BUSQUEDA ALFABETICA
               if @i_tipo = 'B'
                  begin
                     set rowcount 20
                     if @i_modo = 0
                        begin
                           select 'COD.'        = mu_municipio,
                              'MUNICIPIO'      = mu_descripcion,
                              'COD. PROVINCIA' = pv_provincia,
                              'PROVINCIA'      = pv_descripcion
                           from cl_municipio m, cl_provincia p
                           where m.mu_cod_prov = p.pv_provincia
                           and  m.mu_cod_prov    = @i_cod_provincia
                           and  mu_estado        = 'V'
                           and  mu_descripcion like @i_valor
                           order by mu_descripcion

                           if @@rowcount=0
                              begin
                                 exec sp_cerror
                                    @t_debug = @t_debug,
                                    @t_file  = @t_file,
                                    @t_from  = @w_sp_name,
                                    @i_num   = 157945
                                 set rowcount 0
                                 return 1
                                 --NO EXISTEN MUNICIPIOS
                              end
                           
                        end
                        
                     else if @i_modo = 1
                        begin
                           select 'COD.'        = mu_municipio,
                              'MUNICIPIO'      = mu_descripcion,
                              'COD. PROVINCIA' = pv_provincia,
                              'PROVINCIA'      = pv_descripcion
                           from cl_municipio m, cl_provincia p
                           where m.mu_cod_prov = p.pv_provincia
                           and  m.mu_cod_prov    = @i_cod_provincia
                           and  mu_estado        = 'V'
                           and  mu_descripcion > @i_municipio_alf
                           and  mu_descripcion like @i_valor
                           order by mu_descripcion
                           
                           if @@rowcount = 0
                              begin
                                 exec sp_cerror
                                    @t_debug   = @t_debug,
                                    @t_file      = @t_file,
                                    @t_from      = @w_sp_name,
                                    @i_num      = 157944
                                    --NO EXISTEN MAS MUNICIPIOS
                                 set rowcount 0
                                 return 1
                              end
                        end
                  end
            end
      end

return 0      
go

   
