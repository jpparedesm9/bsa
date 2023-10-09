/************************************************************************/
/*  Archivo:                condonacion_aho.sp                          */
/*  Stored procedure:       sp_condonacion_aho                          */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Migracion CEN                               */
/*  Fecha de escritura:     03/05/2016                                  */
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
/*    Este programa realiza la condonacion de los valores de ahorros    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR           RAZON                               */
/*    02/May/2016     J. Calderon     Migración a CEN                   */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_condonacion_aho')
  drop proc sp_condonacion_aho
go

create proc sp_condonacion_aho
(
  @t_show_version bit = 0
)
as
  declare
    @w_error         int,
    @w_sp_name       varchar(64),
    @w_fecha_proceso datetime,
    @w_commit        char(1),
    @w_msg           varchar(255),
    @w_prod_cb       int,
    @w_cliente       int,
    @w_ssn           int,
    @w_tarjeta       varchar(20),
    @w_cuenta        varchar(20),
    @w_oficina       int,
    @w_causa         varchar(4),
    @w_monto         money,
    @w_dias          int,
    @w_secuencial    int,
    @w_transaccion   int,
    @w_clase_clte    char(1),
    @w_producto      smallint,
    @w_cont          int,
    @w_moneda        int,
    @w_servidor      mensaje,
    @w_registros     int,
    @w_rowcount      int

  /* CARGA INICIAL DE VARIABLES DE TRABAJO */
   select  @w_sp_name = 'sp_condonacion_aho'
  
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select @w_commit = 'N',
    @w_transaccion = 754,
    @w_secuencial = 0,
    @w_cont = 1


  /* CARGA DE PARAMETROS GENERALES*/

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso with (nolock)

  --Parametro general producto para cuentas de corresponsalias
  select
    @w_prod_cb = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBCB'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL'
    goto ERROR
  end

  select
    @w_servidor = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  if @@rowcount = 0
  begin
    select
      @w_error = 190500,
      @w_msg = 'NO EXISTE NOMBRE DE SERVIDOR CENTRAL'
    goto ERROR
  end

  --Universo de ahorros con valor en suspenso
  select
    vs_cliente = ah_cliente,--Cliente
    vs_secuencial = vs_secuencial,
    vs_celular = convert(varchar(10), null),--Celular
    vs_tarjeta = convert(varchar(20), null),--Tarjeta
    vs_cuenta = ah_cta_banco,--Cuenta de ahorros
    vs_estado = convert(char(2), null),--Estado Tarjeta
    vs_oficina = convert(int, 0),--Oficina de enrolamiento
    vs_causal = vs_servicio,--Causal
    vs_monto = vs_valor,--Valor
    vs_dias = datediff(dd,
                       vs_fecha,
                       @w_fecha_proceso),--Dias Suspenso
    vs_fecha = @w_fecha_proceso,--Fecha Condonacion
    vs_condonar = 'N',
    vs_condonado = 'N',
    vs_clase_clte = ah_clase_clte,
    vs_producto = ah_prod_banc,
    vs_moneda = ah_moneda,
    vs_ofi_cta = ah_oficina
  into   #ah_val_susp
  from   cob_ahorros..ah_val_suspenso,
         cob_ahorros..ah_cuenta
  where  vs_cuenta    = ah_cuenta
     and ah_estado    <> 'C'
     and ah_prod_banc <> @w_prod_cb
     and vs_estado    = 'N'

  if @@rowcount = 0
  begin
    select
      @w_error = 251145,
      @w_msg = 'NO EXISEN VALORES EN SUSPENSO A CONDONAR PARA LA FECHA'
    goto ERROR
  end

  --Relaciones ordenadas por fecha
  select
    rc_tel_celular,
    rc_tarj_debito,
    rc_estado,
    rc_oficina,
    rc_cuenta,
    rc_cliente
  into   #ah_relaciones
  from   cob_remesas..re_relacion_cta_canal
  order  by rc_fecha

  if @@error <> 0
  begin
    select
      @w_error = 251122,
      @w_msg = 'ERROR ESTRUCTURA'
    goto ERROR
  end

  --Actualizacion de datos relacionados al enrolamiento
  update #ah_val_susp
  set    vs_celular = rc_tel_celular,
         vs_tarjeta = rc_tarj_debito,
         vs_estado = rc_estado,
         vs_oficina = isnull(rc_oficina,
                             0)
  from   #ah_relaciones
  where  rc_cuenta  = vs_cuenta
     and rc_cliente = vs_cliente

  if @@error <> 0
  begin
    select
      @w_error = 276005,
      @w_msg = 'ERROR AL ACTUALIZAR EL REGISTRO'
    goto ERROR
  end
  --Validacion de causa versus dias causados de valor en suspenso

  update #ah_val_susp
  set    vs_condonar = 'S'
  from   cob_remesas..re_equivalencias
  where  eq_tabla     = 'CAUSCOND'
     and eq_val_cfijo = vs_causal
     and vs_dias      > eq_val_num_ini

  select
    @w_error = @@error,
    @w_rowcount = @@rowcount

  if @w_error <> 0
  begin
    select
      @w_error = 276005,
      @w_msg = 'ERROR AL ACTUALIZAR EL REGISTRO'
    goto ERROR
  end

  if @w_rowcount = 0
  begin
    select
      @w_error = 251146,
      @w_msg = 'NO EXISTEN REGISTROS A CONDONAR - FAVOR VALIDAR PARAMETRIZACION'
    goto ERROR
  end

  exec @w_secuencial = ADMIN...rp_ssn

  insert into cob_ahorros..ah_tran_servicio
              (ts_usuario,ts_terminal,ts_tsfecha,ts_secuencial,ts_clase,
               ts_hora,ts_tipo_transaccion,ts_cliente,ts_oficina,ts_oficina_cta,
               ts_cta_banco,ts_estado,ts_saldo,ts_valor,ts_monto,
               ts_interes,ts_prod_banc,ts_moneda,ts_clase_clte,ts_causa,
               ts_indicador,ts_nodo,ts_ssn_branch,ts_cod_alterno)
    select
      'opbatch','consola',@w_fecha_proceso,@w_secuencial,'D',
      getdate(),@w_transaccion,vs_cliente,vs_ofi_cta,vs_ofi_cta,
      vs_cuenta,null,null,vs_monto,null,
      null,vs_producto,vs_moneda,vs_clase_clte,vs_causal,
      1,@w_servidor,vs_secuencial,row_number()
        over(
          order by vs_secuencial)
    from   #ah_val_susp
    where  vs_condonar = 'S'

  if @w_error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
    goto ERROR
  end

  update #ah_val_susp
  set    vs_condonado = 'S'
  from   cob_ahorros..ah_tran_servicio
  where  vs_condonar         = 'S'
     and ts_causa            = vs_causal
     and ts_ssn_branch       = vs_secuencial
     and ts_secuencial       = @w_secuencial
     and ts_tipo_transaccion = @w_transaccion
     and ts_tsfecha          = @w_fecha_proceso

  if @@error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
    goto ERROR
  end

  update cob_ahorros..ah_val_suspenso
  set    vs_estado = 'C',
         vs_procesada = 'S'
  from   #ah_val_susp a,
         ah_val_suspenso b
  where  a.vs_condonar   = 'S'
     and b.vs_valor      = a.vs_monto
     and b.vs_secuencial = a.vs_secuencial
     and b.vs_servicio   = a.vs_causal

  if @@error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
    goto ERROR
  end

  insert into cob_ahorros..ah_condonacion
              (co_ente,co_celular,co_tarjeta,co_cta_banco,co_estado_tar,
               co_oficina,co_causa,co_valor,co_dias,co_fecha,
               co_aplicativo)
    select
      vs_cliente,isnull(vs_celular,
             0),isnull(vs_tarjeta,
             0),vs_cuenta,isnull(vs_estado,
             ' '),
      vs_oficina,vs_causal,vs_monto,vs_dias,vs_fecha,
      4
    from   #ah_val_susp
    where  vs_condonado = 'S'

  if @@error <> 0
  begin
    select
      @w_error = 251147,
      @w_msg = 'ERROR AL GENERAR TABLA DE CONDONACION'
    goto ERROR
  end

  return 0

  ERROR:

  print 'Error: ' + cast(@w_error as varchar) + ' - Descripcion: '
        + cast(@w_msg as varchar(250))

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_programa    = @w_sp_name,
    @i_descripcion = @w_msg,
    @i_tran        = 0,
    @i_rollback    = 'S'

  return @w_error

  set nocount off

go

