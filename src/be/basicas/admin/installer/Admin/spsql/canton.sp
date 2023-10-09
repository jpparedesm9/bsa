/************************************************************************/
/*  Archivo:              canton.sp                                     */
/*  Stored procedure:     sp_canton                                     */
/*  Base de datos:        cobis                                         */
/*  Producto:             Administrador                                 */
/*  Disenado por:         Jose Guamani                                  */
/*  Fecha de escritura:   02-Mar-2015                                   */
/************************************************************************/
/*  IMPORTANTE                                                          */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*          PROPOSITO                                                   */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Busqueda de provincia                                               */
/*         MODIFICACIONES                                               */
/*  FECHA       AUTOR         RAZON                                     */
/*  02/Mar/15   J.Guamani     Emision Inicial                           */
/*  21/Abr/16   BBO           Migracion SYB-SQL FAL                     */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_canton')
   drop proc sp_canton

go
create proc sp_canton (
   @s_ssn                int           = NULL,
   @s_user               login         = NULL,
   @s_sesn               int           = NULL,
   @s_term               varchar(32)   = NULL,
   @s_date               datetime      = NULL,
   @s_srv                varchar(30)   = NULL,
   @s_lsrv               varchar(30)   = NULL, 
   @s_rol                smallint      = NULL,
   @s_ofi                smallint      = NULL,
   @s_org_err            char(1)       = NULL,
   @s_error              int           = NULL,
   @s_sev                tinyint       = NULL,
   @s_msg                descripcion   = NULL,
   @s_org                char(1)       = NULL,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(32)   = null,
   @t_trn                smallint      = NULL,
   @t_show_version       bit           = 0,
   @i_operacion          varchar(2),
   @i_modo               tinyint       = null,
   @i_tipo               varchar(1)    = null,
   --
   @i_canton             int           = null,
   @i_descripcion        descripcion   = null,
   @i_estado             estado        = null,
   @i_municipio          catalogo      = null,
   @i_provincia          int           = null
)
as
declare @w_today         datetime,
   @w_sp_name            varchar(32),
   @w_cambio             int,
   @w_codigo             int,
   @w_transaccion        int,
   @v_descripcion        descripcion,
   @w_server_logico      varchar(10),
   @w_num_nodos          smallint,    
   @w_contador           smallint,
   @w_cmdtransrv         varchar(60),
   @w_nt_nombre          varchar(30),
   @w_clave              int,
   @w_return             int,
   @w_codigo_c           varchar(10),
   @w_canton             int,
   @w_descripcion        descripcion,
   @w_municipio          catalogo,
   @w_estado             estado,
   @v_canton             int,
   @v_municipio          catalogo,
   @v_estado             estado,
   @w_errmsj             int 
   
select @w_today   = @s_date,
       @w_sp_name = 'sp_canton'

if @t_show_version = 1
begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
end


--VALIDACION MENSAJE ERROR
   if @i_canton > 0 
      select @w_errmsj = 151173
   else
      select @w_errmsj = 151172
   

-- INSERT
if @i_operacion = 'I'
   begin
      if @t_trn = 15397
      begin
      
         -- VERIFICACION DE CLAVE FORANEA
         -- MUNICIPIO
         select @w_codigo = null
         from  cl_municipio
         where mu_municipio= @i_municipio
         if @@rowcount = 0
          begin
             exec sp_cerror
             --NO EXISTE EL MUNICIPIO
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 157940
             return 1
          end
     
         --EXISTE EL CANTON - MUNICIPIO
         if exists(select 1 
                     from cl_canton
                    where ca_canton   = @i_canton
                      and ca_municipio  = @i_municipio)
         begin
             exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 157947     
                --EL CANTON YA ESTA ASOCIADO AL MUNICIPIO EXISTE
             return 157947
         end
     
         begin tran
            -- INSERT CL_CANTON
            insert into cl_canton (ca_canton,  ca_descripcion,  ca_municipio,  ca_estado)
                           values (@i_canton,  @i_descripcion,  @i_municipio,  @i_estado)
            if @@error != 0
            begin
               exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 153099
                  --ERROR EN CREACION DE CANTON
               return 1
            end
         
            -- TRANSACCION SERVICIO - CANTON
            insert into ts_canton(
                            secuencia,    tipo_transaccion,      clase,        fecha,
                            oficina_s,    usuario,               terminal_s,   srv, 
                            lsrv,         hora,                  canton,       descripcion, 
                            municipio,     estado)
                    values (@s_ssn,       15397,                 'N',          @s_date,
                            @s_ofi,       @s_user,               @s_term,      @s_srv,
                            @s_lsrv,      getdate(),             @i_canton,    @i_descripcion, 
                            @i_municipio, 'V')
            
            if @@error != 0
            begin
               exec sp_cerror
                -- 'ERROR EN CREACION DE TRANSACCION'
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 153100 
               return 1
            end
         commit tran
   
     -- ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
         select @w_codigo_c = convert(varchar(10), @i_canton)
            exec 
               @w_return       = sp_catalogo
               @s_ssn          = @s_ssn,
               @s_user         = @s_user,
               @s_sesn         = @s_sesn,
               @s_term         = @s_term,
               @s_date         = @s_date,
               @s_srv          = @s_srv,
               @s_lsrv         = @s_lsrv,
               @s_rol          = @s_rol,
               @s_ofi          = @s_ofi,
               @s_org_err      = @s_org_err,
               @s_error        = @s_error,
               @s_sev          = @s_sev,
               @s_msg          = @s_msg,
               @s_org          = @s_org,
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @t_trn          = 584,
               @i_operacion    = 'I',
               @i_tabla        = 'cl_canton',
               @i_codigo       = @w_codigo_c,
               @i_descripcion  = @i_descripcion,
               @i_estado       = 'V'
         
               if @w_return != 0
               return @w_return
         
            return 0
      end
   else
      begin
         exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
          /*  'NO CORRESPONDE CODIGO DE TRANSACCION' */
         return 1
      end
end

-- UPDATE
if @i_operacion = 'U'
   begin
      if @t_trn = 15398
      begin
         -- VERIFICACION DE CLAVE FORANEA         
         select @w_codigo = null
         from  cl_municipio
         where mu_municipio= @i_municipio
         if @@rowcount = 0
         begin
            exec sp_cerror
            -- 'NO EXISTE EL MUNICIPIO'
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 157940
            return 1
         end
         
         select 
               @w_descripcion  = ca_descripcion,
               @w_municipio    = ca_municipio,
               @w_estado       = ca_estado
          from cl_canton
         where ca_canton = @i_canton
         
         select @v_descripcion = @w_descripcion
         select @v_municipio   = @w_municipio
         select @v_estado      = @w_estado
         
         if @w_descripcion = @i_descripcion
            select @w_descripcion = null, @v_descripcion = null
         else
            select @w_descripcion = @i_descripcion
 
         if @w_municipio = @i_municipio
            select @w_municipio = null, @v_municipio = null
         else
            select @w_municipio = @i_municipio
         
         if @w_estado = @i_estado
            select @w_estado = null, @v_estado = null
         else
           --select @w_estado = @i_estado  
         begin
            if @i_estado = 'C'
            begin
               if exists (
                  select *
                    from cl_ciudad
                   where ci_canton = @i_canton
                    )
               begin
                  exec sp_cerror
                     @t_debug   = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
                     @i_num     = 157222
                    -- Existe referencia en ciudad 
                  return 1
               end
            end
        end
            
         begin tran
            -- UPDATE CANTON
            update cl_canton
               set ca_descripcion = @i_descripcion,
                   ca_municipio   = @i_municipio,
                   ca_estado      = @i_estado
             where ca_canton = @i_canton 
            
            if @@error != 0
            begin
             exec sp_cerror
                @t_debug   = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
                @i_num      = 157221
                --ERROR EN ACTUALIZACION DE CANTON
             return 1
            end
            -- TRANSACCION CANTON
            insert into ts_canton (
                    secuencia,    tipo_transaccion,   clase,        fecha,
                    oficina_s,    usuario,            terminal_s,   srv, 
                    lsrv,         hora,               canton,       descripcion, 
                    municipio,    estado)
            values (@s_ssn,       15398,               'P',          @s_date,--pendiente trans
                    @s_ofi,       @s_user,            @s_term,      @s_srv,
                    @s_lsrv,      getdate(),          @i_canton,    @v_descripcion, 
                    @v_municipio, @v_estado)

            if @@error != 0
            begin
               exec sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
                @i_num     = 157220
                  /* 'Error en creacion de transaccion'*/
               return 1
            end
     
            insert into ts_canton (
                    secuencia,    tipo_transaccion,   clase,        fecha,
                    oficina_s,    usuario,            terminal_s,   srv, 
                    lsrv,         hora,               canton,       descripcion, 
                    municipio,    estado)
            values (@s_ssn,       15398,              'A',          @s_date,
                    @s_ofi,       @s_user,            @s_term,      @s_srv,
                    @s_lsrv,      getdate(),          @i_canton,    @w_descripcion, 
                    @w_municipio, @w_estado)
         
            if @@error != 0
            begin
               exec sp_cerror
                @t_debug   = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
                @i_num      = 157220
               /* 'Error en creacion de transaccion'*/
               return 1
            end
         commit tran
         
         select @w_codigo_c = convert(varchar(10), @i_canton)
          exec @w_return = sp_catalogo
             @s_ssn           = @s_ssn,
             @s_user          = @s_user,
             @s_sesn          = @s_sesn,
             @s_term          = @s_term,   
             @s_date          = @s_date,   
             @s_srv           = @s_srv,   
             @s_lsrv          = @s_lsrv,   
             @s_rol           = @s_rol,
             @s_ofi           = @s_ofi,
             @s_org_err       = @s_org_err,
             @s_error         = @s_error,
             @s_sev           = @s_sev,
             @s_msg           = @s_msg,
             @s_org           = @s_org,
             @t_debug         = @t_debug,   
             @t_file          = @t_file,
             @t_from          = @w_sp_name,
             @t_trn           = 585,
             @i_operacion     = 'U',
             @i_tabla         = 'cl_canton',
             @i_codigo        = @w_codigo_c,
             @i_descripcion   = @i_descripcion,
             @i_estado        = @i_estado   
          if @w_return != 0
             return @w_return
         
            return 0
         
      end
      else
      begin
         exec sp_cerror
          @t_debug    = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num    = 151051
          /*  'No corresponde codigo de transaccion' */
         return 1
      end
end

-- SEARCH
if @t_trn = 15399
begin
   --TODOS LOS REGISTROS
   if @i_operacion = 'S'
      begin
         set rowcount 20
            select 
              'CODIGO' = ca_canton,
              'CANTON' = substring(ca_descripcion,1,20),
              'COD. PAIS' =pa_pais,
              'PAIS'   =substring(pa_descripcion,1, 20),
              --'COD. DEPARTAMENTO'=dp_departamento,
              --'DEPARTAMENTO' = substring(dp_descripcion,1,20),
              'COD. PROVINCIA'=pv_provincia,
              'PROVINCIA'=substring(pv_descripcion,1, 20),
              'COD. MUNICIPIO' = mu_municipio,
              'MUNICIPIO' = substring(mu_descripcion,1,20),
              'ESTADO' = ca_estado
           from  cl_pais, cl_provincia, cl_municipio,  cl_canton   --cl_depart_pais
           where /*pa_pais=dp_pais
             and dp_departamento= pv_depart_pais 
             and*/ pv_provincia=mu_cod_prov 
             and mu_municipio=ca_municipio
             --and(ca_canton > @i_canton or @i_canton is null)            
            order by ca_canton
           
           if @@rowcount = 0
              exec sp_cerror
              -- 'NO EXISTEN DATOS'
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @w_sp_name,
              @i_num= @w_errmsj
           set rowcount 0
           return 0
      end
  --POR ID CANTON
      if @i_operacion = 'Q'
      begin
         select 'CODIGO' = ca_canton,
                'CANTON' = ca_descripcion,
                'COD. MUNICIPIO'=ca_municipio,
                'MUNICIPIO' = mu_descripcion,
                'ESTADO'    =ca_estado
          from cl_canton,cl_municipio
         where ca_municipio = mu_municipio
           and ca_canton = @i_canton
              --and    ca_municipio=@i_municipio
         if @@rowcount = 0
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num      = 157948
           --   'No existe dato en catalogo'
         return 0
      end
  
  --CANTONES POR MUNICIPIO
      if @i_operacion = 'M'
      begin
         set rowcount 20
           select 
              'CODIGO' = ca_canton,
              'CANTON' = substring(ca_descripcion,1,20),
              'COD. MUNICIPIO' = ca_municipio,
              'MUNICIPIO' = mu_descripcion,
              'ESTADO' = ca_estado
           from   cl_canton,cl_municipio
           where  ca_municipio = mu_municipio
            and ca_municipio = @i_municipio
            and(ca_canton > @i_canton or @i_canton is null)
            and ca_estado='V'
            order by ca_canton asc
           
           if @@rowcount = 0
              exec sp_cerror
              -- 'NO EXISTEN DATOS'
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @w_sp_name,
              @i_num= @w_errmsj 
           set rowcount 0
           return 0
      end
      if @i_operacion = 'H'
      begin
         if @i_tipo = 'A'
         begin
           set rowcount 20
           select 
                 'CODIGO' = ca_canton,
                 'CANTON' = substring(ca_descripcion,1,20),
                 'COD. MUNICIPIO' = ca_municipio,
                 'MUNICIPIO' = mu_descripcion,
                 'ESTADO' = ca_estado
                  from   cl_provincia, cl_municipio,  cl_canton
                  where  pv_provincia=mu_cod_prov 
                    and mu_municipio=ca_municipio
                    and pv_provincia=@i_provincia
                    and (ca_municipio = @i_municipio or @i_municipio is null)
                    and(ca_canton > @i_canton or @i_canton is null)
                  and ca_estado='V'
            order by ca_canton asc
           
           if @@rowcount = 0
              exec sp_cerror
              -- 'NO EXISTEN DATOS'
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @w_sp_name,
              @i_num= @w_errmsj 
           set rowcount 0
           return 0
         end 
         if @i_tipo = 'V'
		 begin
             select 'DESCRIPCION' = ca_descripcion
               from cl_canton
              where ca_canton = @i_canton

             if @@rowcount = 0
                exec sp_cerror
                @t_debug   = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
                @i_num      = 157948
             return 0
          end
      end
  
   end
   else
      begin
      exec sp_cerror
         --  'NO CORRESPONDE CODIGO DE TRANSACCION'
         @t_debug = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num = 151051
      return 1
      end


go
   
   
