/************************************************************************/
/*   Archivo:             autorizacion_sarlaft.sp                       */
/*   Stored procedure:    sp_autorizacion_sarlaft                       */
/*   Base de datos:       cobis                                         */
/*   Producto:            Clientes                                      */
/*   Disenado por:        Oscar Saavedra - Edwin Jimenez                */
/*   Fecha de escritura:  14 de Agosto de 2013                          */
/************************************************************************/
/*                             IMPORTANTE                               */
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
/*                             PROPOSITO                                */
/*   Proceso Batcha que autoriza los clientes que presentan problemas   */
/*   para su autorizacion por medio del modulo de clientes              */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   14/Ago/2013        Oscar Saavedra    Emision Inicial ORS 000617    */
/*   15/Ago/2013        Edwin Jimenez     Emision Inicial ORS 000617    */
/*   02/May/2016        DFu               Migracion CEN                 */
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
           where  name = 'sp_autorizacion_sarlaft')
  drop proc sp_autorizacion_sarlaft
go

create proc sp_autorizacion_sarlaft
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name          char(30),
    @w_codigo           int,
    @w_error            int,
    @w_tipo_id          char(2),
    @w_nro_id           varchar(12),
    @w_nombrelargo      varchar(64),
    @w_observacion      varchar(255),
    @w_path             varchar(256),
    @w_table            varchar(256),
    @w_file             varchar(256),
    @w_msg              varchar(256),
    @w_sql              varchar(1024),
    @w_backup           varchar(128),
    @w_cmd              sysname,
    @w_fecha_proceso    datetime,
    @w_comando          varchar(500),
    @w_s_app            varchar(50),
    @w_bd               varchar(50),
    @w_fuente           varchar(250),
    @w_path_error_s_app varchar(250),
    @w_errores          varchar(250),
    @w_tabla            varchar(250)

  select
    @w_sp_name = 'sp_autorizacion_sarlaft'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*Creacion de la tabla donde se almacenaran los datos contenidos en el archivo plano*/
  if exists (select
               1
             from   sysobjects
             where  name  = 'cl_autorizacion_sarlaft'
                and xtype = 'U')
    drop table cl_autorizacion_sarlaft

  create table cl_autorizacion_sarlaft
  (
    as_cedruc      varchar(12),
    as_observacion varchar(254)
  )

  /*Parametro de Ubicacion del Archivo de Tramites MIR*/
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = 'cobis..sp_autorizacion_sarlaft'

  select
    @w_path_error_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    print @@rowcount
    print @w_path_error_s_app
    print @w_path
    print 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    return 1
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  /* Carga Parametros para el bcp */
  select
    @w_s_app = @w_path_error_s_app + 's_app',
    @w_cmd = @w_s_app + ' bcp ',
    @w_bd = 'cobis',
    @w_file = 'Autorizacion_Sarlaft.txt',
    @w_tabla = 'cl_autorizacion_sarlaft',
    @w_fuente = @w_path + @w_file,
    @w_errores = @w_path + @w_file + '.err'

  select
       @w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' in ' + @w_fuente +
                    ' -c -t"|" -auto -login '
                    + '-config '
                 + @w_s_app + '.ini > ' + @w_errores

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print @w_error
    return @w_error
  end

  /* Actualiza uno a uno los clientes y genera la transaccion de servicio*/
  while 1 = 1
  begin
    select top 1
      @w_tipo_id = en_tipo_ced,
      @w_nro_id = en_ced_ruc,
      @w_nombrelargo = en_nomlar,
      @w_observacion = as_observacion
    from   cl_ente,
           cl_autorizacion_sarlaft
    where  en_ced_ruc = as_cedruc

    if @@rowcount = 0
      break

    /*Actualiza Ente*/
    update cobis..cl_ente
    set    en_doc_validado = 'S',
           en_mala_referencia = 'N'
    where  en_ced_ruc = @w_nro_id

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR UPDATE CEDULA = ' + @w_nro_id,
        @w_error = 105027
      goto ERROR
    end

    exec sp_cseqnos
      @i_tabla     = 'cl_autorizacion_sarlaft',
      @o_siguiente = @w_codigo out

    /*Inserta Transaccion de Servicio*/
    insert into ts_aut_sarlaft_lista
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,tipo_documento,ced_ruc,
                 nombre,fecha_ref,origen,estado,tipo_aprobacion,
                 Descr_aprobacion,estado_autorizacion,descr_autorizacion,
                 observacion
                 ,fecha_mod,
                 ref_estado,oficina)
    values      ( @w_codigo,'1046','N',getdate(),'sa',
                  null,null,null,@w_tipo_id,@w_nro_id,
                  @w_nombrelargo,null,null,null,1,
                  'AUTORIZACION POR SCRIPT','S','APROBADO',@w_observacion,
                  getdate(
                  ),
                  'U',1)

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR TRN SERV ENTE = ' + @w_nro_id + ' SEC = ' + convert(varchar(12),@w_codigo),
        @w_error = 353515
      goto ERROR
    end

    delete cl_autorizacion_sarlaft
    where  as_cedruc = @w_nro_id
  end

  /*se revisa si todos los clientes fueron actualizados y posteriormente borrados*/
  if exists (select
               1
             from   cobis..cl_autorizacion_sarlaft)
  begin
    select
      @w_msg = 'LOS SIGUIENTES CLIENTES PRESENTAN INCONVENIENTES [CL_ENTE] '

    while 1 = 1
    begin
      select top 1
        @w_nro_id = as_cedruc
      from   cobis..cl_autorizacion_sarlaft

      if @@rowcount = 0
        break

      select
        @w_msg = @w_msg + convert(varchar(12), @w_nro_id) + ' '

      delete cl_autorizacion_sarlaft
      where  as_cedruc = @w_nro_id
    end

    select
      @w_error = 141050
    goto ERROR

  end

  return 0

  ERROR:
  print @w_msg
  exec @w_error = sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'op_batch',
    @i_tran        = 7946,
    @i_tran_name   = '',
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  return @w_error

go

