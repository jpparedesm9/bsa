/************************************************************************/
/*  Archivo:            ahcobsus.sp                                     */
/*  Stored procedure:   sp_ahcobsus                                     */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Julio Navarrete/Xavier Bucheli   */
/*  Fecha de escritura: 25/Jun/1995                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Este programa procesa el cobro de Valores en suspenso para          */
/*  Cuentas de Ahorros.                                                 */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*  FECHA           AUTOR           RAZON                               */
/*  25/Jul/1995     J Navarrete V.  Emision inicial                     */
/*  09/Oct/1998     Juan F. Cadena  Personalizacion B. del Caribe       */
/*  20/Oct/1999     V.Molina        Cobro o no de imp                   */
/*  13/Ene/2000     V.Molina        Reubicacion del begin tran          */
/*  02/Mayo/2016    Ignacio Yupa    Migraci�n a CEN                     */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahcobsus')
  drop proc sp_ahcobsus
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

create proc sp_ahcobsus
(
  @t_show_version bit = 0,
  @s_srv          varchar(16),
  @s_ssn          int,
  @s_ssn_branch   int=null,
  @s_ofi          smallint,
  @s_date         datetime,
  @s_user         varchar(30) = null,
  @s_term         varchar(10) = 'consola',
  @s_rol          smallint=null,
  @i_cuenta       int,
  @i_sec          int,
  @i_valor        money,
  @i_cau          varchar(4),
  @i_linea        char(1) = 'N',
  @i_imp          char(1) = 'N',
  @i_turno        smallint = null,
  @i_corresponsal char(1) = 'N'
)
as
  declare
    @w_sp_name           varchar(30),
    @w_return            int,
    @w_saldo_para_girar  money,
    @w_saldo_contable    money,
    @w_cta_banco         varchar(16),
    @w_moneda            tinyint,
    @w_causa             varchar(4),
    @w_prod_banc         tinyint,
    @w_categoria         char(1),
    @w_disponible        money,
    @w_oficina           smallint,
    @w_tipocta_super     char(1),
    @w_cliente           int,
    @w_clase_clte        char(1),
    @w_tipocta           char(1),
    @w_vlr_sus_pendiente money,
    @w_valor             money,
    @w_saldomin          char(3)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ahcobsus'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --ACO 10ABR2010

  --INC 117053
  select
    @w_saldomin = isnull(an_saldomin,
                         'S')
  from   cob_remesas..re_accion_nd
  where  an_producto = 4
     and an_causa    = @i_cau

  /* Obtener los datos de la cuenta */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @s_date,
    @i_corresponsal     = @i_corresponsal,
    @i_valida_saldo     = @w_saldomin,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out,
    @o_cta_banco        = @w_cta_banco out,
    @o_moneda           = @w_moneda out
  if @w_return <> 0
    return @w_return

  select
    @s_ssn_branch = isnull(@s_ssn_branch,
                           @s_ssn)

  /* Lectura para login operador batch*/
  select
    @s_user = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  select
    @w_prod_banc = ah_prod_banc,
    @w_categoria = ah_categoria,
    @w_disponible = ah_disponible,
    @w_oficina = ah_oficina,
    @w_tipocta_super = ah_tipocta_super,
    @w_cliente = ah_cliente,
    @w_clase_clte = ah_clase_clte,
    @w_tipocta = ah_tipocta
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

  if @i_turno is null
    select
      @i_turno = @s_rol

  begin tran
  if round(@w_saldo_para_girar,
           0) > 0
  begin
    exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv          = @s_srv,
      @s_ofi          = @s_ofi,
      @s_ssn          = @s_ssn,
      @s_ssn_branch   = @s_ssn_branch,
      @s_rol          = @s_rol,
      @s_user         = @s_user,
      @s_term         = @s_term,
      @t_trn          = 264,
      @i_cta          = @w_cta_banco,
      @i_val          = @i_valor,
      @i_cau          = @i_cau,
      @i_mon          = @w_moneda,
      @i_fecha        = @s_date,
      @i_imp          = @i_imp,
      @i_cobsus       = 'S',
      @i_turno        = @i_turno,
      @i_cobiva       = 'S',
      @i_corresponsal = @i_corresponsal,
      @i_tran_ext     = 'S'
    if @w_return <> 0
      return @w_return

    update cob_ahorros..ah_val_suspenso
    set    vs_procesada = 'S',
           vs_estado = 'C'
    where  vs_cuenta     = @i_cuenta
       and vs_secuencial = @i_sec

  end
  else if @i_linea = 'S'
  begin
    exec cobis..sp_cerror
      @t_from = 'sp_ahcobsus',
      @i_num  = 251073
    return 251073
  end

  /* EXTRAE VALOR DEL VALOR EN SUSPENSO RECALCULADO AL NO CONTAR CON SUFICIENTE DINERO PARA COBRARLO COMPLETO */
  select
    @w_vlr_sus_pendiente = isnull(ts_valor,
                                  0)
  from   cob_ahorros..ah_tran_servicio
  where  ts_tipo_transaccion = 259
     and ts_secuencial       = @s_ssn

  if @w_vlr_sus_pendiente is null
    select
      @w_vlr_sus_pendiente = 0

  /* RESTAR VALOR DEL COBRO TOTAL - EL VALOR DE LA 259 PARA GENERAR CONTABILIDAD */
  select
    @w_valor = round(@i_valor,
                     2) - round(@w_vlr_sus_pendiente,
                                2)

  /* Inserto la transaccion de servicio */

  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,
               ts_causa,
               ts_tsfecha,ts_usuario,ts_terminal,ts_cta_banco,ts_nodo,
               ts_valor,ts_oficina,ts_oficina_cta,ts_saldo,ts_accion,
               ts_ciclo,ts_mercantil,ts_prod_banc,ts_categoria,ts_tipocta_super,
               ts_turno,ts_moneda,ts_indicador,ts_cliente,ts_clase_clte,
               ts_interes,ts_monto)
  values      ( @s_ssn,@s_ssn_branch,0,303,@i_cau,
                @s_date,@s_user,@s_term,@w_cta_banco,@s_srv,
                @w_valor,@s_ofi,@w_oficina,@w_disponible,'C',
                'S',@i_linea,@w_prod_banc,@w_categoria,@w_tipocta_super,
                @i_turno,@w_moneda,1,@w_cliente,@w_clase_clte,
                @w_vlr_sus_pendiente,@i_valor)

  if @@error <> 0
  begin
    /* Error en insercion de transaccion de servicio */
    if @i_linea = 'S'
    begin
      exec cobis..sp_cerror
        @t_from = 'sp_ahcobsus',
        @i_num  = 203005
      return 203005
    end
    else
    begin
      exec cob_ahorros..sp_errorlog
        @i_fecha       = @s_date,
        @i_error       = 203005,
        @i_tran        = 303,--Cobro valores en suspenso
        @i_usuario     = 'opbatch',
        @i_descripcion = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO CUENTA',
        @i_programa    = 'sp_ahcobsus_batch'
    end
  end

  if @i_corresponsal = 'S'
     and exists(select
                  1
                from   cob_remesas..re_mantenimiento_cb
                where  mc_cod_cb = @s_ofi)
  begin
    --Se genera transacción de servicio para disminución 
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,
                 ts_oficina,
                 ts_usuario,ts_terminal,ts_correccion,ts_ssn_corr,ts_reentry,
                 ts_origen,ts_nodo,ts_tsfecha,ts_cta_banco,ts_moneda,
                 ts_valor,ts_interes,ts_indicador,ts_causa,ts_prod_banc,
                 ts_categoria,ts_oficina_cta,ts_observacion,ts_tipocta_super,
                 ts_clase_clte,
                 ts_cliente,ts_hora)
    values      (@s_ssn,@s_ssn,1,751,@s_ofi,
                 @s_user,@s_term,'N',null,'N',
                 'L',@s_srv,@s_date,@w_cta_banco,0,
                 @w_valor,null,1,'52',@w_prod_banc,
                 @w_categoria,@w_oficina,('AUMENTO CUPO CB POSICIONADO ' + cast(
                                          @s_ofi as varchar)),@w_tipocta_super,
                 @w_clase_clte,
                 @w_cliente,getdate())
  end
  if @@error <> 0
  begin
    /* Error en insercion de transaccion de servicio */
    if @i_linea = 'S'
    begin
      exec cobis..sp_cerror
        @t_from = 'sp_ahcobsus',
        @i_num  = 203005
      return 203005
    end
    else
    begin
      exec cob_ahorros..sp_errorlog
        @i_fecha       = @s_date,
        @i_error       = 203005,
        @i_tran        = 303,--Cobro valores en suspenso
        @i_usuario     = 'opbatch',
        @i_descripcion = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO CUENTA',
        @i_programa    = 'sp_ahcobsus_batch'
    end
  end

  commit tran
  return 0

go

