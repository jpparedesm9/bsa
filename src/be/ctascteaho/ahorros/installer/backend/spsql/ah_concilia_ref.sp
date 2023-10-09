/************************************************************************/
/*      Archivo:                ah_concilia_ref.sp                      */
/*      Stored procedure:       sp_concilia_referidos                   */
/*      Base de datos:          cobis                                   */
/*      Producto:               cobis                                   */
/*      Disenado por:           Luisa Bernal                            */
/*      Fecha de escritura:     08/07/2015                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*                                                                      */
/*      Este programa tiene como propósito conciliar las transaccion-   */
/*      es generadas de abono nota credito por el proceso de redención  */
/*     de puntos por REFERIDOS                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*   02/May/2016        J. Calderon     Migración a CEN                 */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

set nocount on

if exists (select
             1
           from   sysobjects
           where  name = 'sp_concilia_referidos')
  drop proc sp_concilia_referidos
go

create proc sp_concilia_referidos
(
  @t_show_version bit = 0,
  @i_param1       datetime -- fecha de proceso batch
)
as
  declare
    @w_sp_name varchar(32),
    @w_comando varchar(255),
    @w_path    varchar(100),
    @w_msg     varchar(100),
    @w_error   int,
    @w_fecha   date

  /* Captura del nombre del Store Procedure */

  select  @w_sp_name = 'sp_concilia_referidos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = convert (date, @i_param1, 103)

  /*inicializacion variables de trabajo*/

  select
    @w_sp_name = 'sp_concilia_referidos'
  ----------

  /*VALIDA QUE LLEGUE EL PARAMETRO 1*/
  if @i_param1 is null
  begin
    select
      @w_msg = 'Error, Fecha de proceso no enviada',
      @w_error = 801085
    goto ERRORFIN
  end

  /* PATH ORIGEN */

  select
    @w_path = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'PATHEA'

  if @w_path is null
  begin
    select
      @w_msg = 'ERROR CARGANDO LA RUTA DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 4000002

    goto ERRORFIN
  end

  -- datos que coinciden
  update cob_externos..ex_abonos_referidos
  set    ar_estado = 'CONCILIADO',
         ar_fecha_cobis = ts_hora,
         ar_valor_cobis = ts_monto,
         ar_cod_aut_cobis = ts_ssn,
         ar_fecha_corte = @w_fecha
  from   cobis..ws_tran_servicio,
         cob_externos..ex_abonos_referidos
  where  ts_canal      = 4
     and ts_estado     = 'A'
     and ar_cuenta     = ts_banco_orig
     and ar_numero_id  = ts_campo2
     and ar_valor_ref  = ts_monto
     and ar_tipo_id    = ts_campo1
     and ar_causa      = ts_campo4
     and ts_ref_texto1 = ar_cod_aut_ref
     --Codigo autorizacion - sms o callcenter
     and @w_fecha      = convert (date, ts_fecha, 103)
     and ar_estado is null

  if @@error <> 0
  begin
    select
      @w_msg = 'No fue posible actualizar conciliadas en cob_externos',
      @w_error = 2600005

    goto ERRORFIN
  end

  ---actualiza los registros que no se encuentran en base de datos COBIS
  update cob_externos..ex_abonos_referidos
  set    ar_estado = 'NC NO APLICADA',
         ar_fecha_corte = @w_fecha
  from   cobis..ws_tran_servicio
  where  @w_fecha = convert (date, ar_fecha_ref, 103)
     and ar_causa = 31
     and (ar_cod_aut_cobis not in (select
                                     ts_ssn
                                   from   cobis..ws_tran_servicio)
           or ar_cod_aut_cobis is null)
     and ar_estado is null

  if @@error <> 0
  begin
    select
      @w_msg = 'No fue posible actualizar no aplicadas en cob_externos',
      @w_error = 2600005

    goto ERRORFIN
  end

  --registros  que no existen en cob_externos y estan en cobis
  insert into cob_externos..ex_abonos_referidos
              (ar_cuenta,ar_tipo_id,ar_numero_id,ar_causa,ar_valor_ref,
               ar_fecha_ref,ar_cod_aut_ref,ar_estado,ar_cod_aut_cobis,
               ar_fecha_cobis,
               ar_valor_cobis,ar_fecha_corte)
    select
      ts_banco_orig,ts_campo1,ts_campo2,ts_campo4,ts_monto,
      ts_hora_est,ts_ref_texto1,'NC APLICADA',ts_ssn,ts_hora,
      ts_monto,@w_fecha
    from   cobis..ws_tran_servicio
    where  ts_canal  = 4
       and ts_estado = 'A'
       and ts_campo4 = 31
       and @w_fecha  = convert(date, ts_fecha, 103)
       and ts_ssn not in (select
                            ar_cod_aut_cobis
                          from   cob_externos..ex_abonos_referidos)

  if @@error <> 0
  begin
    select
      @w_msg = 'No fue posible insertar aplicadas ex_abonos_referidos',
      @w_error = 2600005
    goto ERRORFIN
  end

  return 0
  ------------------------------------------------------------------------------------------------- 

  ERRORFIN:
begin
  exec cob_conta_super..sp_errorlog
    @i_operacion    = 'I',
    @i_fecha_fin    = @i_param1,
    @i_fuente       = @w_sp_name,
    @i_origen_error = '28016',
    @i_descrp_error = @w_msg

  select
    @w_msg = isnull (convert(varchar(20), @w_error), 0) + ' - ' + @w_msg

  --CREA EL COMANDO PARA EXPORTAR LA TABLA TEMPORAL
  select
    @w_comando = 'echo ' + @w_msg + ' > ' + @w_path + 'CONCILIACION_REFERIDOS_'
                 +
                        cast (@w_fecha
                        as varchar )
                 + '.lis'
  --EJECUTAR CON CMDSHELL
  exec @w_error = xp_cmdshell
    @w_comando

  --CONTROL DE ERROR
  if @w_error <> 0
  begin
    select
      @w_error = 1234567,
      @w_msg = 'ERROR AL CREAR EL ARCHIVO PARA: CONCILIACION_REFERIDOS.lis'
    goto ERRORFIN
  end
  return 0
end

go

