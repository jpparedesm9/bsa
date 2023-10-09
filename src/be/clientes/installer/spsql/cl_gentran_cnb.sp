/************************************************************************/
/*  Archivo:                cl_gentran_cnb.sp                           */
/*  Stored procedure:       sp_genera_tran_cnb                          */
/*  Base de datos:          cobIS                                       */
/*  Producto:               clientes                                    */
/*  Disenado por:           Alfredo Zamudio                             */
/*  Fecha de escritura:     23/01/2012                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa genera archivo de transacciones no conciliadas        */
/*  existentes en cobis.                                                */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA             AUTOR         RAZON                               */
/*  May/02/2016       DFu           Migracion CEN                       */
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
           where  name = 'sp_genera_tran_cnb')
  drop proc sp_genera_tran_cnb
go

create proc sp_genera_tran_cnb
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) -- parametro batch fecha
)
as
  declare
    @i_fecha_p      datetime,
    @w_periodicidad varchar(1),
    @w_sp_name      varchar(15),
    @w_slm          money,
    @w_s_app        varchar(50),
    @w_path         varchar(60),
    @w_cmd          varchar(255),
    @w_destino      varchar(255),
    @w_errores      varchar(255),
    @w_error        int,
    @w_comando      varchar(255),
    @w_cont         int,
    @w_mensaje      varchar(255),
    @w_usuario      varchar(24),
    @w_param        varchar(10),
    @w_msg          varchar(200),
    @w_cod_cliente  int,
    @w_prod         money,
    @w_commit       char(1),
    @w_campo        varchar(4000),
    @s_user         login,
    @t_trn          int,
    @w_contador     int

  select
    @w_sp_name = 'sp_genera_tran_cnb'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha_p = convert(datetime, @i_param1),
    @w_cont = 0,
    @w_commit = 'N'

  create table #cl_tran_temp
  (
    ts_tipo_reg int,
    ts_reg      varchar(4000)
  )

  if exists(select
              1
            from   sysobjects
            where  name = 'cl_tran_serv_cnb')
    drop table cl_tran_serv_cnb

  create table cl_tran_serv_cnb
  (
    ts_reg varchar(4000)
  )

  select
    @w_cont = count(1)
  from   cobis..ws_tran_servicio
  where  ts_tipo_tran = 26508
     and ts_fecha     = @i_fecha_p

  select
    @w_prod = sum (isnull(ts_monto,
                          0))
  from   cobis..ws_tran_servicio
  where  ts_tipo_tran = 26508
     and ts_fecha     = @i_fecha_p

  if @@rowcount = 0
  begin
    select
      @w_mensaje = 'NO EXISTEN TRANSACCIONES CNB EN COBIS',
      @w_error = 101248
    goto ERROR_FIN
  end

  insert into #cl_tran_temp
    select distinct
      1,convert(varchar, convert(varchar, @w_cont) + ',' + replace(convert(
                         varchar,
                                         @w_prod), '.', '') +
                                         ','
                       + convert(varchar(30), @i_fecha_p, 112))

  insert into #cl_tran_temp
    select
      2,'001' + ',' + --SE ENVIA VALOR FIJO A SOLICITUD DE PROCESSA
      isnull(convert(varchar, ts_terminal), 'serv_') + ','
      + isnull(convert(varchar, ts_ssn), 1) + ',' + isnull(convert(varchar,
      ts_campo6)
      , '') + ','
      + isnull(convert(varchar, ts_campo5), '000000') + ','
      + isnull(convert(varchar(30), ts_fecha, 121), convert(varchar, getdate(),
      121)
      )
      + ','
      + isnull(replace(convert(varchar(20), ts_monto), '.', ''), '000') + ','
      + isnull(convert(varchar, ts_num_tarjeta), '') + ','
      + isnull(convert(varchar, ts_prod_dest), '') + ','
      + isnull(convert(varchar, ts_banco_dest), '') + ','
      + isnull(convert(varchar, ts_prod_orig), '7') + ','
      + isnull(convert(varchar, ts_campo3), '') + ',' + 'REVERSADA' + ','
      + isnull(convert(varchar, ts_retorno), '') + ','
      + isnull(convert(varchar, ts_campo5), '000000') + ','
      + isnull(convert(varchar, ts_convenio), '') + ',' + isnull(convert(varchar
      ,
      ts_banco), '')
      + ',' + isnull(convert(varchar, ts_ssn), 1) + ',' + isnull(case
      ts_gcomision
      when 'S' then '1' when 'N' then '0' else '' end, '') + ','
      + isnull(convert(varchar, ts_usuario), '') + ',' + ',' + ',' + ',' + ',' +
      ','
      +
      ',' + ',' + ',' + ',' + ',' + isnull(case when ts_sec_corr is null then ''
      else
      ts_sec_corr end, '')
    from   cobis..ws_tran_servicio a
    where  ts_tipo_tran = 26508
       and ts_fecha     = @i_fecha_p
       and ts_ssn in
           (select
              ts_sec_corr
            from   cobis..ws_tran_servicio
            where  ts_tipo_tran = 26508
               and ts_fecha     = @i_fecha_p)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR AL INSERTAR TRANSACCIONES REVERSADAS',
      @w_error = 103100
    goto ERROR_FIN
  end

  insert into #cl_tran_temp
    select
      2,'001' + ',' + --SE ENVIA VALOR FIJO A SOLICITUD DE PROCESSA
      isnull(convert(varchar, ts_terminal), 'serv_') + ','
      + isnull(convert(varchar, ts_ssn), 1) + ',' + isnull(convert(varchar,
      ts_campo6)
      , '') + ','
      + isnull(convert(varchar, ts_campo5), '000000') + ','
      + isnull(convert(varchar(30), ts_fecha, 121), convert(varchar, getdate(),
      121)
      )
      + ','
      + isnull(replace(convert(varchar(20), ts_monto), '.', ''), '000') + ','
      + isnull(convert(varchar, ts_num_tarjeta), '') + ','
      + isnull(convert(varchar, ts_prod_dest), '') + ','
      + isnull(convert(varchar, ts_banco_dest), '') + ','
      + isnull(convert(varchar, ts_prod_orig), '7') + ','
      + isnull(convert(varchar, ts_campo3), '') + ',' + 'EXITOSA' + ','
      + isnull(convert(varchar, ts_retorno), '') + ','
      + isnull(convert(varchar, ts_campo5), '000000') + ','
      + isnull(convert(varchar, ts_convenio), '') + ',' + isnull(convert(varchar
      ,
      ts_banco), '')
      + ',' + isnull(convert(varchar, ts_ssn), 1) + ',' + isnull(case
      ts_gcomision
      when 'S' then '1' when 'N' then '0' else '' end, '') + ','
      + isnull(convert(varchar, ts_usuario), '') + ',' + ',' + ',' + ',' + ',' +
      ','
      +
      ',' + ',' + ',' + ',' + ',' + isnull(case when ts_sec_corr is null then ''
      else
      ts_sec_corr end, '')
    from   cobis..ws_tran_servicio a
    where  ts_tipo_tran = 26508
       and ts_fecha     = @i_fecha_p
       and ts_ssn not in (select
                            ts_sec_corr
                          from   cobis..ws_tran_servicio
                          where  ts_tipo_tran = 26508
                             and ts_fecha     = @i_fecha_p)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR TRANSACCIONES TRANSACCIONES EXITOSAS',
      @w_error = 103100
    goto ERROR_FIN
  end

  select
    @w_contador = count(1)
  from   #cl_tran_temp

  if @w_contador = 0
  begin
    select
      @w_mensaje = 'TRANSACCIONES CNB NO CARGADAS DESDE COBIS',
      @w_error = 103100
  end

  insert into cl_tran_serv_cnb
    select
      ts_reg
    from   #cl_tran_temp

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR AL INSERTAR EN LA TABLA cl_tran_serv_cnb',
      @w_error = 103100
    goto ERROR_FIN
  end

  /*Generacion Archivo Plano*/

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_mensaje = 'ERROR CARGANDO PARAMETRO BCP',
      @w_error = 1000002
    goto ERROR_FIN
  end

  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 204

  if @w_path is null
  begin
    select
      @w_mensaje =
      'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 1000003
    goto ERROR_FIN
  end

  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_tran_serv_cnb out '

  select
       @w_destino = @w_path + 'PLANO_TRAN_COBIS' + replace(convert(varchar,
                    @i_fecha_p, 102), '.',
                    '') + '.txt',
    @w_errores = @w_path + 'PLANO_TRAN_COBIS' + replace(convert(varchar,
                 @i_fecha_p,
                 102), '.',
                 '') + '_'
                 + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

  select
       @w_comando = @w_cmd + @w_destino + ' -b1000  -c -e' + @w_errores +
                    ' -t"|" '
                    + '-config ' +
                    @w_s_app + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo <PLANO_TRAN_COBIS.txt> '
    print 'Comando ' + isnull(@w_comando, '')
    select
      @w_mensaje = 'ERROR EN ARCHIVO PLANO!!!!!',
      @w_error = error_number()
    goto ERROR_FIN
  end

  drop table #cl_tran_temp

  ERROR_FIN:

  select
    @w_mensaje = @w_sp_name + ' ' + @w_mensaje
  declare @w_fecha datetime
  set @w_fecha = getdate()

  exec sp_errorlog
    @i_fecha     = @w_fecha,
    @i_error     = @w_error,
    @i_usuario   = @s_user,
    @i_tran      = @t_trn,
    @i_tran_name = @w_mensaje,
    @i_rollback  = 'N'

  return @w_error

go

