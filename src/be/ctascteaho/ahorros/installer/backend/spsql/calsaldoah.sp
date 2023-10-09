/************************************************************************/
/*  Archivo:            calsaldoah.sp                                   */
/*  Stored procedure:   sp_ahcalcula_saldo                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 02-Mar-1993                                     */
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
/*  Este programa calcula el saldo para girar de una cuenta             */
/*  de ahorros.  Hace uso del stored procedure                          */
/*  sp_ahupdate_up_todate.                                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR       RAZON                                   */
/*  02-Mar-1993     S Ortiz     Emision inicial                         */
/*  04/Feb/2010     J.Loyo      Valida el Saldo Minimo de la            */
/*                              Cuenta y envia el saldo maximo          */
/*                              que puede tener una cuenta              */
/*  12/Ago/2013     C. Avendaño Variable @i_tran_ext para WS            */
/*  02/Mayo/2016    I. Yupa     Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahcalcula_saldo')
  drop proc sp_ahcalcula_saldo
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahcalcula_saldo
(  
  @t_debug            char(1) = 'N',
  @t_file             varchar(14) = null,
  @t_from             varchar(30) = null,
  @t_show_version     bit = 0, 
  @i_cuenta           int,
  @i_fecha            smalldatetime,
  @i_valida_saldo     char(1) = 'S',
  @i_monblq           char(1) = 'S',
  --No tiene en cuenta montos bloqueados en caso de embargo
  @i_is_batch         char(1) = 'N',
  @i_ofi              smallint = null,
  @i_tran_ext         char(1) = 'N',
  --CAV Valida que la transaccion sea por WS / N -> No
  @i_corresponsal     char(1) = 'N',--Req. 381 CB Red Posicionada
  @i_monto_trn        money = 0,
  -- Req 381 CB Red Posicionada - Validar cupo de la cuenta vs valor del movimiento a realizar     
  @i_trn              int = null,
  -- ADI: ORS 949 Codigo de transaccion para no validar cupo cuando es Nota Credito
  @o_saldo_para_girar money out,
  @o_saldo_contable   money out,
  @o_remesas          money = null out,
  @o_cta_banco        cuenta = null out,
  @o_moneda           tinyint= null out,
  @o_saldo_max        money = null out
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_12h            money,
    @w_24h            money,
    @w_48h            money,
    @w_remesas        money,
    @w_monto_sob      money,
    @w_monto_bloq     money,
    @w_cred_24        char(1),
    @w_linea_cr24h    money,
    @w_cred_rem       char(1),
    @w_linea_crrem    money,
    @w_saldo_minimo   money,
    @w_monto_consumos money,
    @w_monto_emb      money,
    @w_categoria      char(1),
    @w_tipo_ente      char(1),
    @w_rol_ente       char(1),
    @w_tipo_def       char(1),
    @w_prod_banc      smallint,
    @w_producto       tinyint,
    @w_tipo           char(1),
    @w_codigo         int,
    @w_disponible     money,
    @w_promedio1      money,
    @w_prom_disp      money,
    @w_valor_SML      money,
    @w_personalizada  char(1),
    @w_filial         tinyint,
    @w_oficina        smallint,
    @w_pais           varchar(2),
    @w_com_trna       money,
    @w_error          int,
    @w_sev            tinyint,
    @w_prod_bancario  smallint,--Req. 381 CB Red Posicionada     
    @w_cupo           money,
    @w_cupo_utilizado money,
    @w_fecha_ven_cupo datetime,
	@w_cod_pais       int,
	@w_cod_pais_col   int

  /*  Captura nombre del stored procedure   */
  select
    @w_sp_name = 'sp_ahcalcula_saldo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PBCB'

  if @@rowcount = 0
  begin
    select
      @w_error = 2609822,
      @w_sev = 0
    goto ERROR
  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /*  Carga de datos de cuenta de ahorros */
    select
      @w_12h = ah_12h,
      @w_24h = ah_24h,
      @w_48h = ah_48h,
      @w_remesas = ah_remesas,
      @w_cred_24 = ah_cred_24,
      @w_cred_rem = ah_cred_rem,
      @w_monto_bloq = ah_monto_bloq,
      @w_monto_emb = ah_monto_emb,
      @o_cta_banco = ah_cta_banco,
      @o_moneda = ah_moneda,
      @w_monto_consumos = ah_monto_consumos,
      @w_categoria = ah_categoria,
      @w_tipo_ente = ah_tipocta,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_tipo = ah_tipo,
      @w_codigo = ah_default,
      @w_disponible = ah_disponible,
      @w_promedio1 = ah_promedio1,
      @w_prom_disp = ah_prom_disponible,
      @w_personalizada = ah_personalizada,
      @w_filial = ah_filial,
      @w_oficina = ah_oficina
    from   cob_ahorros..ah_cuenta with (holdlock)
    where  ah_cuenta    = @i_cuenta
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    /*  Carga de datos de cuenta de ahorros */
    select
      @w_12h = ah_12h,
      @w_24h = ah_24h,
      @w_48h = ah_48h,
      @w_remesas = ah_remesas,
      @w_cred_24 = ah_cred_24,
      @w_cred_rem = ah_cred_rem,
      @w_monto_bloq = ah_monto_bloq,
      @w_monto_emb = ah_monto_emb,
      @o_cta_banco = ah_cta_banco,
      @o_moneda = ah_moneda,
      @w_monto_consumos = ah_monto_consumos,
      @w_categoria = ah_categoria,
      @w_tipo_ente = ah_tipocta,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_tipo = ah_tipo,
      @w_codigo = ah_default,
      @w_disponible = ah_disponible,
      @w_promedio1 = ah_promedio1,
      @w_prom_disp = ah_prom_disponible,
      @w_personalizada = ah_personalizada,
      @w_filial = ah_filial,
      @w_oficina = ah_oficina
    from   cob_ahorros..ah_cuenta with (holdlock)
    where  ah_cuenta = @i_cuenta
  end

  /*  Determina saldo minimo para cuentas de ahorros  */
  select
    @w_saldo_minimo = pd_saldo_minimo
  from   cobis..cl_producto
  where  pd_descripcion like 'CUENTA DE AHORROS'

  if @@rowcount <> 1
  begin
    /*  Producto no existe o definicion de producto no corresponde  */
    select
      @w_error = 101032,
      @w_sev = 0
    goto ERROR
  end

  /* Valida el producto para la oficina */

  if isnull(@i_ofi,
            0) <> 0
  begin
    exec @w_return = cobis..sp_val_prodofi
      @i_modulo  = 4,
      @i_oficina = @i_ofi
    if @w_return <> 0
      return @w_return
  end

  /*  Calculo de saldos  */
  if @w_cred_24 = 'S'
  begin
    select
      @w_linea_cr24h = lc_monto_aut
    from   cob_ahorros..ah_lincredito
    where  lc_cuenta    = @i_cuenta
       and lc_tipo      = 'L'
       and lc_fecha_aut <= @i_fecha
       and lc_fecha_ven >= @i_fecha
    if @@rowcount = 0
      select
        @w_linea_cr24h = 0
  end
  else
    select
      @w_linea_cr24h = 0

  if @w_cred_rem = 'S'
  begin
    select
      @w_linea_crrem = lc_monto_aut
    from   cob_ahorros..ah_lincredito
    where  lc_cuenta    = @i_cuenta
       and lc_tipo      = 'R'
       and lc_fecha_aut <= @i_fecha
       and lc_fecha_ven >= @i_fecha
    if @@rowcount = 0
      select
        @w_linea_crrem = 0
  end
  else
    select
      @w_linea_crrem = 0

  if @i_monblq = 'N'
    select
      @w_monto_bloq = 0

  select
    @o_saldo_para_girar = @w_disponible - @w_monto_bloq - @w_monto_consumos
                                                         - @w_monto_emb
  select
    @o_saldo_contable = @w_12h + @w_24h + @w_48h

  if @w_linea_cr24h < @o_saldo_contable
    select
      @o_saldo_para_girar = @o_saldo_para_girar + @w_linea_cr24h
  else
    select
      @o_saldo_para_girar = @o_saldo_para_girar + @o_saldo_contable

  if @w_linea_crrem < @w_remesas
    select
      @o_saldo_para_girar = @o_saldo_para_girar + @w_linea_crrem
  else
    select
      @o_saldo_para_girar = @o_saldo_para_girar + @w_remesas
  if @w_prod_banc = @w_prod_bancario
     and @i_is_batch = 'N'
     and @i_trn = 264
  begin
    select
      @w_cupo_utilizado = isnull(round(sum(vs_valor),
                                       2),
                                 0)
    from   cob_ahorros..ah_val_suspenso
    where  vs_cuenta    = @i_cuenta
       and vs_procesada = 'N'

    select top 1
      @w_fecha_ven_cupo = cc_fecha_vencimiento
    from   cob_remesas..re_mantenimiento_cupo_cb
    where  cc_cta_banco = @o_cta_banco
    order  by cc_fecha_ingreso desc,
              cc_hora_ingreso desc

    select top 1
      @w_cupo = isnull(cc_valor_cupo,
                       0)
    from   cob_remesas..re_mantenimiento_cupo_cb
    where  cc_cta_banco = @o_cta_banco
       and cc_tipo_mov  <> 'V'
    -- SE EXCLUYE CAMBIO DE VIGENCIA DADO QUE QUEDA MONTO EN CERO
    order  by cc_fecha_ingreso desc,
              cc_hora_ingreso desc

    if @i_monto_trn > ((@w_cupo - @w_cupo_utilizado) + @o_saldo_para_girar)
    begin
      /*  Fondos Insuficientes  */
      select
        @w_error = 251033,
        @w_sev = 0
      goto ERROR
    end

    if @w_fecha_ven_cupo < @i_fecha
    begin
      /*  Fecha de vencimiento superada  */
      select
        @w_error = 2101026,
        @w_sev = 0
      goto ERROR
    end
  end

  /*********** Validamos que se encuentre en  Colombia para hacer validaciones de Saldos Maximo y Minimo ******/

  select
    @w_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     /* Abraviatura del Pais donde se esta trabajando **/
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    /*No existe producto*/
    select
      @w_error = 351518,
      @w_sev = 0
    goto ERROR
  end
  /***  Validacion Saldo Minimo y Maximo de la Cuenta     ***/
  if @w_pais = 'CO' /***  con la Abraviatura de Colombia            ***/
  begin
    if @i_valida_saldo = 'S'
    /*** En caso de transacciones que no necesiten validar el saldo Minimo ***/
    begin
      /***** Llamados al sp_genera Costo para validar el saldo minimo de la cuenta  JLOYO ****/
      exec @w_return = cob_remesas..sp_genera_costos
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_batch       = @i_is_batch,
        @i_fecha       = @i_fecha,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @o_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_codigo,
        @i_servicio    = 'SMC',-- Nemonico del Salario Minimo de una Cuenta 
        @i_rubro       = 'SMI',--  Catalogo de rubro para saldo minimo
        @i_disponible  = @w_disponible,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disp,
        @i_personaliza = @w_personalizada,
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @o_valor_total = @w_com_trna out

      if @w_return <> 0
        return @w_return

      select
        @w_saldo_minimo = @w_com_trna

      /***** Llamado al sp_genera_costo para devolver el saldo maximo de la cuenta JLOYO ***************/

      exec @w_return = cob_remesas..sp_genera_costos
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_batch       = @i_is_batch,
        @i_fecha       = @i_fecha,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @o_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_codigo,
        @i_servicio    = 'SMC',-- Nemonico del Salario Minimo de una Cuenta 
        @i_rubro       = 'SMA',--  Catalogo de rubro para saldo Maximo
        @i_disponible  = @w_disponible,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disp,
        @i_personaliza = @w_personalizada,
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @o_valor_total = @o_saldo_max out

      if @w_return <> 0
        return @w_return

      select
        @w_valor_SML = pa_money
      from   cobis..cl_parametro
      where  pa_nemonico = 'SMV' /* VALOR DEL SALARIO MINIMO  **/
         and pa_producto = 'ADM'

      if @@rowcount = 0
      begin
        /*No existe producto*/
        select
          @w_error = 101085,
          @w_sev = 0
        goto ERROR
      end
      
	  select @w_cod_pais = pa_smallint
	  from cobis..cl_parametro
      where pa_nemonico ='CP'
	  
	  select @w_cod_pais_col =pa_pais from cobis..cl_pais
	  where pa_abreviatura  = 'COL'
	  
	  -- Si pais es Colombia lo el saldo maximo se multiplica por el salario minimo
	  if @w_cod_pais = @w_cod_pais_col
          if @w_valor_SML > 0
            /*** EL Saldo Maximo de la cuenta esta dado en Salarios Minimos ***/
            select
              @o_saldo_max = @o_saldo_max * @w_valor_SML
    end
  end
  select
    @o_saldo_contable = @o_saldo_contable + @w_disponible,
    @o_saldo_para_girar = @o_saldo_para_girar - @w_saldo_minimo,
    @o_remesas = @w_remesas

  if @o_saldo_para_girar < 0
    select
      @o_saldo_para_girar = 0

  return 0

  ERROR:
  if @i_tran_ext = 'N'
  begin
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror
        @t_debug = null,
        @t_file  = null,
        @t_from  = @w_sp_name,
        @i_num   = @w_error,
        @i_sev   = @w_sev

      if @w_sev = 1
        rollback tran
    end
    return @w_error
  end
  else
    return @w_error

go

