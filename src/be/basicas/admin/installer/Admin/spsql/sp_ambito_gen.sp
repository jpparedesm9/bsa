/************************************************************************/
/*  Archivo:            sp_ambito_gen.sp                                */
/*  Stored procedure:   sp_ambito_gen                                   */
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
/*  Este stored permite la generación, consulta y eliminación           */
/*  de ambitos                                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/* 04/May/2015  Omar Garcia              Emision Inicial                */
/* 11/May/2015  Omar Garcia              Correccion de error en ambito  */
/*                                       Sub-Regional                   */
/* 11-03-2016   BBO                      Migracion Sybase-Sqlserver FAL */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_ambito_gen')
   drop proc sp_ambito_gen
go

create proc sp_ambito_gen(
   @s_ssn              int         = null out,
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
   @i_oficina          smallint    = null,
   @i_siguiente        int         = 0,
   @i_regional         char(10)    = null,
   @i_subregional      char(10)    = null,
   @i_usuario          login       = null,
   @i_ssn              int         = null,
   @i_dev_ssn          int         = 0
   
)
as
declare @w_today      datetime,
  @w_sp_name          varchar(32),
  @w_return           int,
  @w_msg              varchar(100),  
  @w_oficina          smallint,
  @w_estado           char(1),
  @w_cargo            char(10),
  @w_ambito           char(10),
  @w_regional         char(10),
  @w_subregional      char(10),
  @w_secuencial       int,
  @w_cantidad         int,
  @w_usuario          login

select @w_today = @s_date
select @w_sp_name = 'sp_ambito_gen'

--VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1
begin
    print 'Stored procedure sp_ambito_gen, Version 4.0.0.1'
    return 0
end

if @i_operacion = 'I'
   begin
      if @t_trn = 15410
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

            --VALIDANDO QUE EL USUARIO TENGA UN AMBITO
            select @w_estado = am_estado,
               @w_ambito = am_cod_ambito
            from ad_ambito
            where am_cargo = @w_cargo

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_num       = 157956
                     --NO EXISTE AMBITO PARA EL CARGO DEL FUNCIONARIO
                  return 1
               end

            --VALIDANDO QUE EL AMBITO ESTE VIGENTE
            if @w_estado != 'V'
               begin
                  exec sp_cerror
                     @t_debug      = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_num       = 157957
                     --AMBITO NO VIGENTE
                  return 1
               end

            --ASIGNANDO EL USUARIO
            if @i_usuario is not null
               select @w_usuario = @i_usuario
            else
               select @w_usuario = @s_user

            --AMBITO NACIONAL(1)
            if @w_ambito = 'NAC'
               begin
                  select @w_cantidad = count(of_oficina) from cl_oficina

                  declare curNacional cursor for
                     select  of_oficina
                     from cl_oficina
                     order by of_oficina

                  --ABRIENDO EL CURSOR
                  open curNacional
                  fetch curNacional into  @w_oficina

                  if @@fetch_status = -1  --sqlstatus: mig syb-sqls 11032016
                   begin
                      --CERRANDO EL CURSOR
                      close curNacional
                      deallocate curNacional

                      exec sp_cerror
                         @t_debug      = @t_debug,
                         @t_file      = @t_file,
                         @t_from      = @w_sp_name,
                         @i_num       = 710004
                         --ERROR AL MANEJAR EL CURSOR
                      return 1
                   end
                  
                  --HACIENDO EL CICLO DE INSERCIONES

                  while @@fetch_status = 0   --sqlstatus: mig syb-sqls 11032016
                     begin

                        --OBTENIENDO EL ULTIMO VALOR DE SECUENCIAL
                        select @w_secuencial = isnull(max(at_secuencial),0) + 1
                        from ad_ambito_tmp

                        begin tran
                           --INSERTANDO EN REGISTRO TEMPORAL DE AMBITO
                           insert into ad_ambito_tmp (at_secuencial ,at_user, at_ssn, at_oficina, at_fecha)
                           values (@w_secuencial,@w_usuario, @s_ssn, @w_oficina, @s_date)

                           if @@error != 0
                              begin                                 
                                 --CERRANDO EL CURSOR
                                 close curNacional
                                 deallocate curNacional

                                 exec sp_cerror
                                    @t_debug   = @t_debug,
                                    @t_file    = @t_file,
                                    @t_from    = @w_sp_name,
                                    @i_num     = 153103
                                    --ERROR EN INSERCION DE REGISTRO TEMPORAL DE AMBITO
                                 return 1
                              end
                        commit tran

                        fetch curNacional INTO  @w_oficina

                     end 

                     --CERRANDO EL CURSOR
                     close curNacional
                     deallocate curNacional

                     if @i_dev_ssn = 1
                        select @s_ssn
               end

            --AMBITO REGIONAL(2)
            if @w_ambito = 'REG'
               begin
                  --VALIDANDO QUE LA OFICINA TENGA REGIONAL
                  select @w_regional = of_regional
                  from cl_oficina 
                  where of_oficina = @s_ofi

                  if @w_regional is null
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file    = @t_file,
                           @t_from    = @w_sp_name,
                           @i_num     = 157958
                           --LA OFICINA DE CONEXION NO TIENE REGIONAL
                        return 1
                     end

                  declare curRegional cursor for
                     select  of_oficina
                     from cl_oficina
                     where of_regional = @w_regional

                  --ABRIENDO EL CURSOR
                  open curRegional
                  fetch curRegional into  @w_oficina
                  
                  if @@fetch_status = -1  --sqlstatus: mig syb-sqls 11032016
                   begin
                      --CERRANDO EL CURSOR
                      close curRegional
                      deallocate curRegional

                      exec sp_cerror
                         @t_debug      = @t_debug,
                         @t_file      = @t_file,
                         @t_from      = @w_sp_name,
                         @i_num       = 710004
                         --ERROR AL MANEJAR EL CURSOR
                      return 1
                   end

                  --HACIENDO EL CICLO DE INSERCIONES
                  while @@fetch_status = 0   --sqlstatus: mig syb-sqls 11032016 
                     begin

                        --OBTENIENDO EL ULTIMO VALOR DE SECUENCIAL
                        select @w_secuencial = isnull(max(at_secuencial),0) + 1
                        from ad_ambito_tmp

                        begin tran
                           --INSERTANDO EN REGISTRO TEMPORAL DE AMBITO
                           insert into ad_ambito_tmp (at_secuencial ,at_user, at_ssn, at_oficina, at_fecha)
                           values (@w_secuencial ,@w_usuario, @s_ssn, @w_oficina, @s_date)

                           if @@error != 0
                              begin
                                 --CERRANDO EL CURSOR
                                 close curRegional
                                 deallocate curRegional

                                 exec sp_cerror
                                    @t_debug   = @t_debug,
                                    @t_file    = @t_file,
                                    @t_from    = @w_sp_name,
                                    @i_num     = 153103
                                    --ERROR EN INSERCION DE REGISTRO TEMPORAL DE AMBITO
                                 return 1
                              end

                        commit tran

                        fetch curRegional INTO  @w_oficina
                     end 

                     --CERRANDO EL CURSOR
                     close curRegional
                     deallocate curRegional

                     if @i_dev_ssn = 1
                        select @s_ssn
               end

            --AMBITO SUB-REGIONAL(3)
            if @w_ambito = 'SUB'
               begin
                  --VALIDANDO QUE LA OFICINA TENGA SUB-REGIONAL
                  select @w_subregional = of_subregional
                  from cl_oficina 
                  where of_oficina = @s_ofi

                  if @w_subregional is null
                     begin
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file    = @t_file,
                           @t_from    = @w_sp_name,
                           @i_num     = 157959
                           --LA OFICINA DE CONEXION NO TIENE SUB-REGIONAL
                        return 1
                     end

                  declare curSubregional cursor for
                     select  of_oficina
                     from cl_oficina
                     where of_subregional = @w_subregional

                  --ABRIENDO EL CURSOR
                  open curSubregional
                  fetch curSubregional into  @w_oficina

                  if @@fetch_status = -1  --sqlstatus: mig syb-sqls 11032016
                  begin
                      --CERRANDO EL CURSOR
                      close curSubregional
                      deallocate curSubregional

                      exec sp_cerror
                         @t_debug      = @t_debug,
                         @t_file      = @t_file,
                         @t_from      = @w_sp_name,
                         @i_num       = 710004
                         --ERROR AL MANEJAR EL CURSOR
                      return 1
                   end
                  
                  --HACIENDO EL CICLO DE INSERCIONES
                  while @@fetch_status = 0   --sqlstatus: mig syb-sqls 11032016
                  begin

                        --OBTENIENDO EL ULTIMO VALOR DE SECUENCIAL
                        select @w_secuencial = isnull(max(at_secuencial),0) + 1
                        from ad_ambito_tmp

                        begin tran
                           --INSERTANDO EN REGISTRO TEMPORAL DE AMBITO
                           insert into ad_ambito_tmp (at_secuencial ,at_user, at_ssn, at_oficina, at_fecha)
                           values (@w_secuencial ,@w_usuario, @s_ssn, @w_oficina, @s_date)

                           if @@error != 0
                              begin
                                 --CERRANDO EL CURSOR
                                 close curSubregional
                                 deallocate curSubregional

                                 exec sp_cerror
                                    @t_debug   = @t_debug,
                                    @t_file    = @t_file,
                                    @t_from    = @w_sp_name,
                                    @i_num     = 153103
                                    --ERROR EN INSERCION DE REGISTRO TEMPORAL DE AMBITO
                                 return 1
                              end

                        commit tran

                        fetch curSubregional INTO  @w_oficina
                     end 

                     --CERRANDO EL CURSOR
                     close curSubregional
                     deallocate curSubregional

                     if @i_dev_ssn = 1
                        select @s_ssn
               end

            --ABITO OFICINA (4)
            if @w_ambito = 'OFI'
               begin
                  --OBTENIENDO EL ULTIMO VALOR DE SECUENCIAL
                  select @w_secuencial = isnull(max(at_secuencial),0) + 1
                  from ad_ambito_tmp

                  begin tran
                     --INSERTANDO EN REGISTRO TEMPORAL DE AMBITO
                     insert into ad_ambito_tmp (at_secuencial ,at_user, at_ssn, at_oficina, at_fecha)
                     values (@w_secuencial ,@w_usuario, @s_ssn, @s_ofi, @s_date)

                     if @@error != 0
                        begin
                           exec sp_cerror
                              @t_debug   = @t_debug,
                              @t_file    = @t_file,
                              @t_from    = @w_sp_name,
                              @i_num     = 153103
                              --ERROR EN INSERCION DE REGISTRO TEMPORAL DE AMBITO
                           return 1
                        end

                  commit tran

                  if @i_dev_ssn = 1
                     select @s_ssn
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

if @i_operacion = 'D'
   begin
      if @t_trn = 15411
         begin
            --VERIFICANDO QUE EXISTAN REGISTROS
            /*
            if not exists (select 1 from ad_ambito_tmp
                        where at_fecha <= @s_date)
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file    = @t_file,
                        @t_from    = @w_sp_name,
                        @i_num     = 157960
                        --NO EXISTEN REGISTROS DE AMBITO PREVIOS A LA FECHA ACTUAL
                     return 1
                  end
            */

            --DEPURAR(ELIMINA TODOS LOS REGISTROS ANTERIORES A LA FEHCA DE PROCESO SDATE)
            if @i_modo = 0
               begin
                  begin tran
                     delete from ad_ambito_tmp
                     where at_fecha <= @s_date
                     
                     if @@error != 0
                        begin
                           exec sp_cerror
                              @t_debug   = @t_debug,
                              @t_file    = @t_file,
                              @t_from    = @w_sp_name,
                              @i_num     = 157226
                              --ERROR EN ELIMINACION DE REGISTRO TEMPORAL DE AMBITO
                           return 1
                        end

                     --REGISTRO DE TRANSACCION DATOS ELIMINADOS
                     insert into ts_ambito_tmp (secuencia, tipo_transaccion, clase, fecha,
                        oficina_s, usuario, terminal_s, srv, lsrv)
                     values (@s_ssn, 15410, 'B', @s_date,
                        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv)

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
               end
            --ELIMINAR LOS REGISTROS DE UN USUARIO
            else if @i_modo = 1
               begin
                  begin tran
                     delete from ad_ambito_tmp
                     where at_user = @s_user
                     and at_ssn = @s_ssn
                     
                     if @@error != 0
                        begin
                           exec sp_cerror
                              @t_debug   = @t_debug,
                              @t_file    = @t_file,
                              @t_from    = @w_sp_name,
                              @i_num     = 157226
                              --ERROR EN ELIMINACION DE REGISTRO TEMPORAL DE AMBITO
                           return 1
                        end

                     --REGISTRO DE TRANSACCION DATOS ELIMINADOS
                     insert into ts_ambito_tmp (secuencia, tipo_transaccion, clase, fecha,
                        oficina_s, usuario, terminal_s, srv, lsrv)
                     values (@s_ssn, 15410, 'B', @s_date,
                        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv)

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
      
if @i_operacion = 'S'
   begin
      if @t_trn = 15412
         begin
            set rowcount 20
            select
               'Codigo'         = a.at_secuencial,
               'Login'          = f.fu_login,
               'Nombre'         = f.fu_nombre,
               'Cargo'          = cca.valor,
               'Cod. Oficina'   = a.at_oficina,
               'Nombre Oficina' = o.of_nombre
            from ad_ambito_tmp a
            inner join cobis..cl_funcionario f ON f.fu_login = a.at_user
            inner join cobis..cl_oficina o ON o.of_oficina = a.at_oficina
            left join cobis..cl_tabla tca ON tca.tabla = 'cl_cargo' 
            left join cobis..cl_catalogo cca ON convert(varchar(10) , f.fu_cargo ) = cca.codigo and tca.codigo=cca.tabla
            where a.at_user = @i_usuario
            and a.at_ssn = @i_ssn
            and (a.at_secuencial > @i_siguiente or @i_siguiente = 0)

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
