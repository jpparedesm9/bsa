/************************************************************************/
/*  Archivo:                         cl_carrec.sp                       */
/*  Stored procedure:                sp_carga_reclamaciones             */
/*  Base de datos:                   cobis                              */
/*  Producto:                        Credito                            */
/*  Disenado por:                    Alfredo Zuluaga                    */
/*  Fecha de escritura:              13-AGO-2014                        */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Cargar archivo de reclamaciones de clientes a la tabla cl_mercado   */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR                    RAZON                          */
/*  14/08/2014  Alfredo Zuluaga          Emision Inicial                */
/*  02/05/2016  DFu                      Migracion CEN                  */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_carga_reclamaciones')
  drop proc sp_carga_reclamaciones
go

create proc sp_carga_reclamaciones
(
  @t_show_version bit = 0
)
as
  declare
    @i_fecha        datetime,
    @w_sp_name      varchar(20),
    @w_s_app        varchar(50),
    @w_path         varchar(50),
    @w_nombre       varchar(14),
    @w_nombre_cab   varchar(18),
    @w_cmd          varchar(255),
    @w_destino      varchar(2500),
    @w_errores      varchar(1500),
    @w_error        int,
    @w_comando      varchar(2500),
    @w_nombre_plano varchar(1500),
    @w_col_id       int,
    @w_columna      varchar(30),
    @w_cabecera     varchar(2500),
    @o_codigo_sig   int,
    @w_fuente       varchar(20),
    @w_observacion  varchar(255),
    @w_calificador  varchar(20),
    @w_calificacion varchar(20),
    @w_estado       varchar(20),
    @w_cont         int,
    @w_secuencial   int,
    @w_user         login,
    @w_tran         int,
    @w_term         varchar(30),
    @w_date         datetime,
    @w_srv          varchar(30),
    @w_lsrv         varchar(30),
    @w_ced_ruc      varchar(25),
    @w_tipo_ced     varchar(2),
    @w_mensaje      varchar(255)

  select
    @w_sp_name = 'sp_carga_reclamaciones'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if exists(select
              1
            from   cobis..sysobjects
            where  name = 'cl_carga_reclamaciones_tmp')
    drop table cl_carga_reclamaciones_tmp

  create table cl_carga_reclamaciones_tmp
  (
    ced_ruc  varchar(20) null,
    tipo_ced varchar(2) null
  )

  select
    @w_srv = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'SRVR'

  select
    @w_lsrv = @w_srv

  --Valores Variables
  select
    @w_mensaje = null,
    @w_fuente = 'SEGDEUVEN',
    @w_observacion = 'LISTADO RECLAMACIONES SEGDEUVEN',
    @w_calificador = 'batch',
    @w_calificacion = 'SEGDEUVEN',
    @w_estado = '025',
    @w_user = 'operador',
    @w_term = 'TERMX',
    @w_tran = 1285

  --Carga de Archivo de Devoluciones a estructura temporal
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_mensaje =
      'Error. No se encuentra el Path para el S_APP. Parametro: S_APP '
    goto ERRORFIN
  end

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2016

  if @w_path is null
  begin
    select
      @w_mensaje = 'Error. No se encuentra el Path para el Batch '
    goto ERRORFIN
  end

  --Cargue Archivo Plano de Reclamaciones
  select
    @w_cmd =
    @w_s_app + 's_app bcp -auto -login cobis..cl_carga_reclamaciones_tmp in '

  select
    @w_destino = @w_path + 'cl_reclamaciones.txt',
    @w_errores = @w_path + 'cl_reclamaciones.err'

  select
    @w_comando =
       @w_cmd + @w_destino + ' -b1000  -c -e' + @w_errores + ' -t"|" ' +
       '-config '
       +
       @w_s_app + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR REALIZANDO BCP DEL ARCHIVO: cl_reclamaciones.txt'
    goto ERRORFIN
  end

  select
    @w_cont = count(1)
  from   cobis..cl_carga_reclamaciones_tmp

  if @w_cont is null
      or @w_cont = 0
  begin
    select
      @w_mensaje =
      'NO CARGO ARCHIVO PLANO. REVISAR ARCHIVO EN LA RUTA ESPECIFICADA '
             + @w_path
      + 'cl_reclamaciones.txt'
    goto ERRORFIN
  end

  --Paso Archivo de Devoluciones de estructura temporal a tabla definitiva de clientes
  exec @w_secuencial = ADMIN...rp_ssn

  if @w_secuencial is null
  begin
    select
      @w_mensaje = 'NO GENERO SECUENCIAL. FAVOR REVISAR'
    goto ERRORFIN
  end

  --insercion en la transaccion de servicio del registro anterior
  insert into ts_mercado
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ced_ruc,nombre,
               fecha_ref,origen,calificador,calificacion,observacion,
               codigo,documento,ref_estado)
    select
      @w_secuencial,@w_tran,'A',getdate(),@w_user,
      @w_term,@w_srv,@w_lsrv,me_ced_ruc,me_nomlar,
      getdate(),me_fuente,me_calificador,me_calificacion,me_observacion,
      me_estado,0,me_estado
    from   cobis..cl_mercado with (nolock),
           cobis..cl_ente with (nolock)
    where  me_ced_ruc  = en_ced_ruc
       and me_tipo_ced = en_tipo_ced
       and me_estado   = @w_estado

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'Error en la Insercion de la tabla cobis..ts_mercado (reg. anterior). '
    goto ERRORFIN
  end

  insert into cl_mercado_his
              (me_secuencial_his,me_fecha,me_codigo,me_ced_ruc,me_documento,
               me_nombre,me_fecha_ref,me_calificador,me_calificacion,me_fuente,
               me_observacion,me_subtipo,me_tipo_ced,me_p_apellido,me_s_apellido
               ,
               me_fecha_mod,me_estado,me_nomlar,me_sexo,
               me_estado_mig,
               me_data)
    select
      @w_secuencial,me_fecha_ref,me_codigo,me_ced_ruc,me_documento,
      me_nombre,me_fecha_ref,me_calificador,me_calificacion,me_fuente,
      me_observacion,me_subtipo,me_tipo_ced,me_p_apellido,me_s_apellido,
      me_fecha_mod,me_estado,me_nomlar,me_sexo,null,
      ''
    from   cobis..cl_mercado with (nolock)
    where  me_estado = @w_estado

  if @@error <> 0
  begin
    select
      @w_mensaje =
'Error en la Insercion de datos anteriores de la tabla cobis..cl_mercado_his. '
  goto ERRORFIN
end

  delete cl_mercado
  where  me_estado = @w_estado

  if @@error <> 0
  begin
    select
      @w_mensaje =
'Error en la Eliminacion de datos anteriores de la tabla cobis..cl_mercado.'
goto ERRORFIN
end

  select
    *
  into   #temporal
  from   cobis..cl_carga_reclamaciones_tmp

  if @@error <> 0
  begin
    select
      @w_mensaje = 'Error en la Insercion de datos a la tabla #temporal'
    goto ERRORFIN
  end

  while 1 = 1
  begin
    select
      @w_mensaje = null

    set rowcount 1

    select
      @w_ced_ruc = ced_ruc,
      @w_tipo_ced = tipo_ced
    from   #temporal

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    delete #temporal
    where  ced_ruc  = @w_ced_ruc
       and tipo_ced = @w_tipo_ced

    set rowcount 0

    begin tran

    select
      @w_cont = count(1)
    from   cobis..cl_ente with (nolock)
    where  en_ced_ruc  = @w_ced_ruc
       and en_tipo_ced = @w_tipo_ced

    if @w_cont = 0
        or @w_cont is null
    begin
      select
        @w_mensaje = 'ERROR. LA CEDULA NO ES UN CLIENTE DE BANCAMIA. Cedula:  '
                     +
                     isnull
                            (@w_ced_ruc,
                            '-')
                     + ' Tipo Doc: ' + isnull(@w_tipo_ced, '-')
      goto ERRORSIG
    end

    exec @w_error = sp_cseqnos
      @i_tabla     = 'cl_mercado',
      @o_siguiente = @o_codigo_sig out

    if @w_error <> 0
    begin
      select
        @w_mensaje = 'Error Generando Secuenciales <cl_mercado> '
      goto ERRORSIG
    end

    insert into cl_mercado
                (me_codigo,me_ced_ruc,me_nombre,me_documento,me_fuente,
                 me_observacion,me_calificador,me_calificacion,me_fecha_ref,
                 me_subtipo,
                 me_tipo_ced,me_p_apellido,me_s_apellido,me_fecha_mod,me_estado,
                 me_nomlar,me_sexo)
      select
        @o_codigo_sig,en_ced_ruc,en_nombre,0,@w_fuente,
        @w_observacion,@w_calificador,@w_calificacion,getdate(),en_subtipo,
        en_tipo_ced,p_p_apellido,p_s_apellido,getdate(),@w_estado,
        en_nomlar,p_sexo
      from   cobis..cl_ente with (nolock)
      where  en_ced_ruc  = @w_ced_ruc
         and en_tipo_ced = @w_tipo_ced

    if @@error <> 0
    begin
      select
        @w_mensaje =
        'Error en la Insercion en la tabla cobis..cl_mercado. Cedula:  '
        + isnull(@w_ced_ruc, '-')
      goto ERRORSIG
    end

    --actualizar la mala referencia del cliente
    update cl_ente
    set    en_mala_referencia = 'S',
           en_cont_malas = isnull(en_cont_malas, 0) + 1
    where  en_ced_ruc  = @w_ced_ruc
       and en_tipo_ced = @w_tipo_ced

    if @@error <> 0
    begin
      select
        @w_mensaje =
        'Error en la Actualizacion de la tabla cobis..cl_ente. Cedula:  '
        + isnull(@w_ced_ruc, '-')
      goto ERRORSIG
    end

    --insercion en la transaccion de servicio del registro nuevo
    insert into ts_mercado
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ced_ruc,nombre,
                 fecha_ref,origen,calificador,calificacion,observacion,
                 codigo,documento,ref_estado)
      select
        @w_secuencial,@w_tran,'N',getdate(),@w_user,
        @w_term,@w_srv,@w_lsrv,en_ced_ruc,en_nomlar,
        getdate(),@w_fuente,@w_calificador,@w_calificacion,@w_observacion,
        null,0,@w_fuente
      from   cobis..cl_ente with (nolock)
      where  en_ced_ruc  = @w_ced_ruc
         and en_tipo_ced = @w_tipo_ced

    if @@error <> 0
    begin
      select
        @w_mensaje =
'Error en la Insercion de la tabla cobis..ts_mercado (reg. nuevo). Cedula:  '
      + isnull(@w_ced_ruc, '-')
  goto ERRORSIG
end

commit tran

ERRORSIG:
if @w_mensaje is not null
begin
  select
    @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje
  while @@trancount > 0
  begin
    rollback tran
  end

  --Insertar en tabla de errores
  insert into cobis..cl_error_log
              (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
               er_descripcion)
  values      ( getdate(),null,'batch',null,'sp_carga_reclamaciones',
                @w_mensaje )

  select
    @w_mensaje = null

end

end --fin while

  return 0

  ERRORFIN:
  if @w_mensaje is not null
  begin
    select
      @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje
    while @@trancount > 0
    begin
      rollback tran
    end

    print 'MENSAJE ERROR: ' + @w_mensaje

    return 1
  end

go

