/************************************************************************/
/*  Archivo:            sp_ambito.sp                                    */
/*  Stored procedure:   sp_ambito                                       */
/*  Base de datos:      cobis                                           */
/*  Producto:           Admin                                           */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP", representantes exclusivos para el Ecuador de la        */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Este stored permite el mantenimiento de la tabla                    */
/*  ad_ambito                                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/* 28/Abr/2015  Omar Garcia              Emision Inicial                */
/* 21-04-2016   BBO                      Migracion SYB-SQL FAL          */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_ambito')
   drop proc sp_ambito
go

create proc sp_ambito(
   @s_ssn              int         = null,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = NULL,
   @s_org_err          char(1)     = NULL,
   @s_error            int         = NULL,
   @s_sev              tinyint     = NULL,
   @s_msg              descripcion = NULL,
   @s_org              char(1)     = NULL,
   @t_debug            char(1)     = 'N',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              smallint    = null,
   @t_show_version     bit         = 0,   
   @i_operacion        char(1)     = null,  
   @i_modo             int         = null,  
   @i_secuencial       int         = null,   
   @i_cargo            char(10)    = null,
   @i_tipo_ambito      char(10)    = null,
   @i_ambito           char(10)    = null,
   @i_estado           char(1)     = null,
   @i_siguiente        int         = 0,
   @i_usuario          login       = null
   
)
as
declare @w_today      datetime,
  @w_sp_name          varchar(32),
  @w_return           int,
  @w_msg              varchar(100),  
  @w_siguiente        int,
  @w_secuencial       int,
  @w_cargo            char(10),
  @w_tipo_ambito      char(10),
  @w_ambito           char(10),
  @w_estado           char(1),
  @v_secuencial       int,
  @v_ambito           char(10),
  @v_tipo_ambito      char(10),
  @v_cargo            char(10),
  @v_estado           char(1)
  
select @w_today = @s_date
select @w_sp_name = 'sp_ambito'

--VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1
begin
    print 'Stored procedure sp_ambito, Version 1.0.0.0'
    return 0
end

--VALIDANDO QUE EXISTA EL SECUENCIAL DE AMBITO

--VALIDACIONES DE CATALOGOS
--CARGO
if @i_cargo is not null
   begin
   --VALIDANDO QUE EL CODIGO DE CATALOGO DE CARGO SEA EL CORRECTO
      if not exists(select 1 
                  from cl_tabla t,cl_catalogo c
                  where t.tabla='cl_cargo'
                  and c.tabla=t.codigo
                  and c.codigo=@i_cargo)
         begin
            exec sp_cerror
               @t_debug   = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num     = 101012
               --NO EXISTE CARGO
            return 1
         end
   end

--TIPO DE AMBITO
if @i_tipo_ambito is not null
   begin
   --VALIDANDO QUE EL CODIGO DE CATALOGO DE TIPO DE AMBITO SEA EL CORRECTO
      if not exists(select 1 
                  from cl_tabla t,cl_catalogo c
                  where t.tabla='cl_tipo_ambito'
                  and c.tabla=t.codigo
                  and c.codigo=@i_tipo_ambito)
         begin
            exec sp_cerror
               @t_debug   = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num     = 157950
               --NO EXISTE TIPO DE AMBITO
            return 1
         end
   end

--AMBITO
if @i_ambito is not null
   begin
   --VALIDANDO QUE EL CODIGO DE AMBITO SEA EL CORRECTO
      if not exists(select 1 
                  from cl_tabla t,cl_catalogo c
                  where t.tabla='cl_ambito'
                  and c.tabla=t.codigo
                  and c.codigo=@i_ambito)
         begin
            exec sp_cerror
               @t_debug   = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num     = 157951
               --NO EXISTE TIPO DE AMBITO
            return 1
         end
   end

--INSERCION
if @i_operacion = 'I'
   begin
      if @t_trn = 15406
         begin
            --VALIDANDO QUE EL CARGO NO TENGA UN AMBITO CREADO PREVIAMENTE
            if exists(select 1 from ad_ambito
                     where am_cargo = @i_cargo)
               begin
                  exec sp_cerror
                     @t_debug   = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
                     @i_num     = 157953                        
                     --EL CARGO YA TIENE UN AMBITO CREADO
                  return 1
               end

            --OBTENIENDO EL ULTIMO VALOR DE SECUENCIAL
            select @w_secuencial = isnull(max(am_secuencial),0) + 1
               from ad_ambito

            begin tran
               insert into ad_ambito (am_secuencial, am_cargo, am_cod_tipo_ambito, am_cod_ambito,am_estado )
                  values (@w_secuencial, @i_cargo, @i_tipo_ambito, @i_ambito, @i_estado)

               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 153101
                        --ERROR EN INSERCION DE AMBITO
                     return 1
                  end

               --TRANSACCION SERVICIO DATOS NUEVOS
               insert into ts_ambito (secuencia, tipo_transaccion, clase, fecha,
                  oficina_s, usuario, terminal_s, srv, lsrv,
                  sec_ambito,cargo,tipo_ambito,ambito,estado)
               values (@s_ssn, 15406, 'N', @s_date,
                  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                  @w_secuencial,@i_cargo,@i_tipo_ambito,@i_ambito,@i_estado)

               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 153102
                        --ERROR EN TRANSACCION DE SERVICIO DE AMBITO
                     return 1
                  end

            commit tran
            return 0

         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end
   
--ACTUALIZACION
if @i_operacion = 'U'
   begin
      if @t_trn = 15407
         begin
            --VALIDANDO QUE EL SECUENCIAL DEL AMBITO EXISTA
            if not exists(select 1 from ad_ambito
                     where am_secuencial = @i_secuencial)
               begin
                  exec sp_cerror
                     @t_debug   = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
                     @i_num     = 157954
                     --CODIGO DE AMBITO INCORRECTO
                  return 1
               end

            --CARGANDO LOS DATOS PREVIOS DEL AMBITO
            select 
               @w_secuencial = am_secuencial,
               @w_cargo = am_cargo,
               @w_tipo_ambito = am_cod_tipo_ambito,
               @w_ambito = am_cod_ambito,
               @w_estado = am_estado
            from ad_ambito 
            where am_secuencial = @i_secuencial

            --GUARDANDO LOS DATOS PREVIOS EN VARIABLES
            select 
               @v_secuencial = @w_secuencial,
               @v_cargo = @w_cargo,
               @v_tipo_ambito = @w_tipo_ambito,
               @v_ambito = @w_ambito,
               @v_estado = @w_estado
               
            --VERIFICANDO CAMBIOS EN LOS CAMPOS
            if @w_cargo = @i_cargo
               select @w_cargo = null, @v_cargo = null
            else
               select @w_cargo = @i_cargo

            if @w_tipo_ambito = @i_tipo_ambito
               select @w_tipo_ambito = null, @v_tipo_ambito = null
            else
               select @w_tipo_ambito = @i_tipo_ambito

            if @w_ambito = @i_ambito
               select @w_ambito = null, @v_ambito = null
            else
               select @w_ambito = @i_ambito

            if @w_estado = @i_estado
               select @w_estado = null, @v_estado = null
            else
               select @w_estado = @i_estado
               
            begin tran
               --ACTUALIZANDO LOS DATOS
               update ad_ambito set 
                  am_cargo           = @i_cargo,
                  am_cod_tipo_ambito = @i_tipo_ambito,
                  am_cod_ambito      = @i_ambito,
                  am_estado          = @i_estado
               where am_secuencial = @i_secuencial
               
               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 157224
                        --ERROR EN ACTUALIZACION DE AMBITO
                     return 1
                  end
                  
               -- TRANSACCION DE SERVICIOS DATOS PREVIOS
               insert into ts_ambito (secuencia, tipo_transaccion, clase, fecha,
                  oficina_s, usuario, terminal_s, srv, lsrv,
                  sec_ambito,cargo,tipo_ambito,ambito,estado)
               values (@s_ssn, 15407, 'P', @s_date,
                  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                  @v_secuencial,@v_cargo,@v_tipo_ambito,@v_ambito,@v_estado)

               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 153102
                        --ERROR EN TRANSACCION DE SERVICIO DE AMBITO
                     return 1
                  end

               -- TRANSACCION DE SERVICIOS DATOS ACTUALIZADOS
               insert into ts_ambito (secuencia, tipo_transaccion, clase, fecha,
                  oficina_s, usuario, terminal_s, srv, lsrv,
                  sec_ambito,cargo,tipo_ambito,ambito,estado)
               values (@s_ssn, 15407, 'A', @s_date,
                  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                  @i_secuencial,@w_cargo,@w_tipo_ambito,@w_ambito,@w_estado)

               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 153102
                        --ERROR EN TRANSACCION DE SERVICIO DE AMBITO
                     return 1
                  end

            commit tran
            return 0
         end
      else 
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--ELIMINACION
if @i_operacion = 'D'
   begin
      if @t_trn = 15408
         begin
            --CARGANDO LOS DATOS DEL AMBITO
            select 
               @w_secuencial = am_secuencial,
               @w_cargo = am_cargo,
               @w_tipo_ambito = am_cod_tipo_ambito,
               @w_ambito = am_cod_ambito,
               @w_estado = am_estado
            from ad_ambito 
            where am_secuencial = @i_secuencial

            --VALIDANDO QUE EL SECUENCIAL DEL AMBITO EXISTA
            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num     = 157954
                     --CODIGO DE AMBITO INCORRECTO
                  return 1
               end

            begin tran
               --ELIMINANDO EL AMBITO
               delete from ad_ambito
               where am_secuencial = @i_secuencial
               
               if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 157225
                        --ERROR EN ELIMINACION DE AMBITO
                     return 1
                  end
                  
                  -- TRANSACCION DE SERVICIOS DATOS ELIMINADOS
                  insert into ts_ambito (secuencia, tipo_transaccion, clase, fecha,
                     oficina_s, usuario, terminal_s, srv, lsrv,
                     sec_ambito,cargo,tipo_ambito,ambito,estado)
                  values (@s_ssn, 15408, 'B', @s_date,
                     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                     @w_secuencial,@w_cargo,@w_tipo_ambito,@w_ambito,@w_estado)

                  if @@error != 0
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file    = @t_file,
                           @t_from    = @w_sp_name,
                           @i_num     = 153102
                           --ERROR EN TRANSACCION DE SERVICIO DE AMBITO
                        return 1
                     end
            commit tran
            return 0
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--CONSULTA DE TODOS
if @i_operacion = 'S'
   begin
      if @t_trn = 15409
         begin
            set rowcount 20
            select 
               'Codigo' = am.am_secuencial,
               'Cargo'  = cca.valor,
               'Tipo de Ambito' = cta.valor,
               'Ambito'         = ca.valor,
               'Estado'         = ce.valor
            from ad_ambito am
            --JOIN CON CARGO
            left join cobis..cl_tabla tca ON tca.tabla = 'cl_cargo' 
            left join cobis..cl_catalogo cca ON convert(varchar(10) , am.am_cargo ) = cca.codigo and tca.codigo=cca.tabla

            --JOIN CON TIPO DE AMBITO
            left join cobis..cl_tabla tta ON tta.tabla = 'cl_tipo_ambito' 
            left join cobis..cl_catalogo cta ON convert(varchar(10) , am.am_cod_tipo_ambito ) = cta.codigo and tta.codigo=cta.tabla

            --JOIN CON AMBITO
            left join cobis..cl_tabla ta ON ta.tabla = 'cl_ambito' 
            left join cobis..cl_catalogo ca ON convert(varchar(10) , am.am_cod_ambito ) = ca.codigo and ta.codigo=ca.tabla

            --JOIN CON ESTADO DE AMBITO
            left join cobis..cl_tabla te ON te.tabla = 'cl_estado_ambito' 
            left join cobis..cl_catalogo ce ON convert(varchar(10) , am.am_estado ) = ce.codigo and te.codigo=ce.tabla

            where (am.am_cargo = @i_cargo or @i_cargo is null ) 
            and (am.am_cod_tipo_ambito = @i_tipo_ambito or @i_tipo_ambito is null ) 
            and (am.am_cod_ambito = @i_ambito or @i_ambito is null ) 
            and (am.am_estado = @i_estado or @i_estado is null )
            and (am.am_secuencial > @i_siguiente or @i_siguiente = 0)
            
            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num        = 157955
                  return 1
               end

         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end
   
--CONSULTA DE DATOS ESPECIFICOS
if @i_operacion = 'Q'
   begin
      if @t_trn = 15409
         begin
            select 
               'CODIGO'          = am.am_secuencial,
               'COD_CARGO'       = am.am_cargo,
               'CARGO'           = cca.valor,
               'COD_TIPO_AMBITO' = am.am_cod_tipo_ambito,
               'TIPO DE AMBITO'  = cta.valor,
               'COD_AMBITO'      = am.am_cod_ambito,
               'AMBITO'          = ca.valor,
               'COD_ESTADO'      = am.am_estado,
               'ESTADO'          = ce.valor
            from ad_ambito am
            --JOIN CON CARGO
            left join cobis..cl_tabla tca ON tca.tabla = 'cl_cargo' 
            left join cobis..cl_catalogo cca ON convert(varchar(10) , am.am_cargo ) = cca.codigo and tca.codigo=cca.tabla

            --JOIN CON TIPO DE AMBITO
            left join cobis..cl_tabla tta ON tta.tabla = 'cl_tipo_ambito' 
            left join cobis..cl_catalogo cta ON convert(varchar(10) , am.am_cod_tipo_ambito ) = cta.codigo and tta.codigo=cta.tabla

            --JOIN CON AMBITO
            left join cobis..cl_tabla ta ON ta.tabla = 'cl_ambito' 
            left join cobis..cl_catalogo ca ON convert(varchar(10) , am.am_cod_ambito ) = ca.codigo and ta.codigo=ca.tabla

            --JOIN CON ESTADO DE AMBITO
            left join cobis..cl_tabla te ON te.tabla = 'cl_estado_ambito' 
            left join cobis..cl_catalogo ce ON convert(varchar(10) , am.am_estado ) = ce.codigo and te.codigo=ce.tabla

            where am.am_secuencial = @i_secuencial

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num        = 157951
                  return 1
               end
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end
   
--CONSULTA DE AMBITO POR CARGO
if @i_operacion = 'C'
   begin
      if @t_trn = 15409
         begin
            --OBTENIENDO EL CARGO
            --USUARIO DE CONEXION
            if @i_modo = 0
               begin
                  select @w_cargo = convert(varchar(10), fu_cargo)
                  from cl_funcionario
                  where fu_login = @s_user
               end
            --USUARIO ESPECIFICO
            else if @i_modo = 1
               begin
                  select @w_cargo = convert(varchar(10), fu_cargo)
                  from cl_funcionario
                  where fu_login = @i_usuario
               end            

            --OBTENINDO EL TIPO DE AMBITO POR EL CARGO
            select 
               'COD_AMBITO' = am.am_cod_ambito,
               'AMBITO'  = cta.valor
            from ad_ambito am

            --JOIN CON TIPO DE AMBITO
            left join cobis..cl_tabla tta ON tta.tabla = 'cl_ambito' 
            left join cobis..cl_catalogo cta ON convert(varchar(10) , am.am_cod_ambito ) = cta.codigo and tta.codigo=cta.tabla
            where am.am_cargo = @w_cargo

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num        = 157951
                  return 1
               end
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end


return 0
go

