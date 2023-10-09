/************************************************************************/
/*  Archivo:                ahconsumo.sp                                */
/*  Stored procedure:       sp_ahconsumo                                */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas Ahorros                             */
/*  Disenado por:           Marco Sanguino                              */
/*  Fecha de escritura:     25-Jun-1999                                 */
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
/*  Este programa realiza la transaccion de bloqueos por consumos       */
/*   305 = Bloqueos por Consumos ATM                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA           AUTOR           RAZON                           */
/*  25/Jun/1999     M. Sanguino     Emision inicial                     */
/*  12/Jul/1999     M. Sanguino     Personalizacion B. Caribe (ATM)     */
/*  09/Sep/1999     Johnmer Salazar Envio de resultados a ATM           */
/*  18/Oct/1999     Johnmer Salazar Eliminar la llamada a la nota       */
/*                                  de debito automatica                */
/*  19/Oct/1999     Johnmer Salazar Eliminar calculo de numero de       */
/*                                  transacciones gratis                */
/*  30/Nov/1999     Juan F. Cadena  Campo hc_levantado                  */
/*  02/Mayo/2016    Ignacio Yupa    Migración a CEN                     */
/************************************************************************/

use cob_ahorros
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_ahconsumo')
  drop proc sp_ahconsumo
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahconsumo
(
  @s_ssn          int,
  @s_ssn_branch   int = null,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int = null,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,  
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_tarjeta      cuenta,
  @i_valor        money = null,
  @i_atm_server   char(1) = 'N',
  @i_srvorg       varchar(8) = null,
  @i_num_trans    int = 0,
  @i_cliente      int = null,
  @i_comision     money = 0,
  @i_turno        smallint = null,
  @o_clave        int out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_cuenta             int,
    @w_oficina            smallint,
    @w_est                char(1),
    @w_clave              varchar(6),
    @w_filial             tinyint,
    @w_dias_consumos      tinyint,
    @w_num_bloqueos       smallint,
    @w_producto           tinyint,
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_saldo1             money,
    @w_saldo              money,
    @w_tipo_bloqueo       char(1),
    @w_estado_consumo     char(1),
    @w_estado             char(1),
    @w_mensaje            mensaje,
    @w_monto_consumos     money,
    @w_fecha              datetime,
    @w_ciudad_matriz      int,
    @w_fecha_hoy          varchar(8),
    @w_aleatorio          varchar(4),
    @w_clave_int          int,
    @w_clave_previa       varchar(11),
    @w_sec                int,
    @w_cheque_ini         int,
    @w_tasa_imp           float,
    @w_usadeci            char(1),
    @w_numdeci            tinyint,
    @w_mon                tinyint,
    @w_tipo_exonerado_imp char(2),
    @w_monto_imp          money,
    @w_prod_banc          smallint,
    @w_categoria          char(1),
    @w_secuencial         int,
    @w_funcionario        varchar(10),
    @w_nemonico_atm       varchar(5),
    @w_num_trans          int,
    @w_causa_atm          varchar(3),
    @w_comision           money,
    @w_disponible         money,
    @w_12h                money,
    @w_24h                money,
    @w_remesas            money,
    @w_monto_blq          money,
    @w_estado_cta         char(1),
    @w_letra_funcionario  varchar(10),
    @w_valor              money,
    @w_comision_imp       money,
    @w_tipocta_super      char(1)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_ahconsumo'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_ssn_branch = @s_ssn_branch,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_corr = @t_corr,
      t_ssn_corr = @t_ssn_corr,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_tarjeta = @i_tarjeta,
      i_valor = @i_valor,
      i_atm_server = @i_atm_server,
      i_srvorg = @i_srvorg,
      i_num_trans = @i_num_trans,
      i_cliente = @i_cliente,
      i_comision = @i_comision
    exec cobis..sp_end_debug
  end

  if @t_trn <> 305
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_producto = 4,
    @w_estado_consumo = 'I'

  -- valida la existencia de la cuenta
  select
    @w_cuenta = ah_cuenta
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_estado    <> 'G' /* Cuenta de Gerencia */
  if @@rowcount = 0
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201004
    return 1
  end

  /* Calculo del saldo contable y saldo para girar de la cuenta */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  select
    @w_est = ah_estado,
    @w_filial = ah_filial,
    @w_oficina = ah_oficina,
    @w_monto_consumos = ah_monto_consumos,
    @w_mon = ah_moneda,
    @w_categoria = ah_categoria,
    @w_prod_banc = ah_prod_banc,
    @w_disponible = ah_disponible,
    @w_12h = ah_12h,
    @w_24h = ah_24h,
    @w_remesas = ah_remesas,
    @w_monto_blq = ah_monto_bloq,
    @w_estado_cta = ah_estado,
    @w_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta

  if @i_atm_server = 'S'
  begin
    select
      @w_comision = @i_comision,
      @w_causa_atm = '17'
  end

  if @t_corr = 'S' /* Modo Reverso */
  begin
    select
      @w_estado_consumo = 'D',
      @w_estado = 'R'

    select
      @w_clave_int = clave
    from   cob_ahorros..ah_tsconsumo
    where  secuencial       = @t_ssn_corr
       and tipo_transaccion = @t_trn
       and usuario          = @s_user
       and oficina          = @s_ofi
       and cta_banco        = @i_cta
       and valor            = @i_valor
       and moneda           = @w_mon
       and tarjeta          = @i_tarjeta
       and estado_consumo   = 'I'
       and estado is null
    if @@rowcount <> 1
    begin
      /* No encontro el registro en tran servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 1
    end

    select
      @w_valor = hc_valor,
      @w_monto_imp = hc_valor_imp,
      @w_comision = hc_comision,
      @w_comision_imp = hc_comision_imp
    from   cob_remesas..re_his_consumo
    where  hc_tarjeta = @i_tarjeta
       and hc_clave   = @w_clave_int
       and hc_estado  = 'I'
    if @@rowcount <> 1
    begin
      /* No encontro el registro en historico de consumo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201241
      return 1
    end

    begin tran

    /*  Actualizacion de la tabla de historico de consumos */
    delete cob_remesas..re_his_consumo
    where  hc_tarjeta = @i_tarjeta
       and hc_clave   = @w_clave_int
       and hc_estado  = 'I'

    if @@error <> 0
    begin
      /* Error en eliminacion de historico de consumo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 207025
      return 1
    end

    /*  Actualizacion de cuenta */
    update ah_cuenta
    set    ah_monto_consumos = ah_monto_consumos - (@w_valor + @w_monto_imp +
                                                    @w_comision +
                                                           @w_comision_imp)
    where  ah_cuenta = @w_cuenta

    if @@error <> 0
    begin
      /* Error en actualizacion de cuenta corriente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205001
      return 1
    end

    update cob_ahorros..ah_tsconsumo
    set    estado = @w_estado
    where  secuencial       = @t_ssn_corr
       and tipo_transaccion = @t_trn
       and usuario          = @s_user
       and oficina          = @s_ofi
       and cta_banco        = @i_cta
       and valor            = @i_valor
       and moneda           = @w_mon
       and tarjeta          = @i_tarjeta
       and estado_consumo   = 'I'

    if @@error <> 0
    begin
      /* Error en actualizacion de tran servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205043
      return 1
    end

  end
  else
  begin -- modo normal
    select
      @w_estado = null,
      @w_estado_consumo = 'I'

    /* Busqueda de la tasa del impuesto */
    select
      @w_tasa_imp = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'TIDB'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 201196
      return 201196
    end

    /* Encuentra parametro de decimales */
    select
      @w_usadeci = mo_decimales
    from   cobis..cl_moneda
    where  mo_moneda = @w_mon

    if @w_usadeci = 'S'
    begin
      select
        @w_numdeci = pa_tinyint
      from   cobis..cl_parametro
      where  pa_producto = 'CTE'
         and pa_nemonico = 'DCI'
      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201196
        return 1
      end
    end
    else
      select
        @w_numdeci = 0

    /*  Determinacion de bloqueo de cuenta  */
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta = @w_cuenta
       and cb_estado = 'V'
       and cb_tipo_bloqueo in ('3', '2')
    if @@rowcount <> 0
    begin
      select
        @w_mensaje = rtrim (valor)
      from   cobis..cl_catalogo
      where  tabla  = (select
                         codigo
                       from   cobis..cl_tabla
                       where  tabla = 'ah_tbloqueo')
         and codigo = @w_tipo_bloqueo
      select
        @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201008,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 1
    end
    -- Determinar el secuencial para el re_his_consumo

    select
      @w_secuencial = siguiente + 1
    from   cobis..cl_seqnos
    where  tabla = 're_his_consumo'

    if @@rowcount <> 1
    begin
      /* Error en secuencial de Historico de protestos */

      exec cobis..sp_cerror
        @i_num = 208037
      return 208037

    end

    update cobis..cl_seqnos
    set    siguiente = @w_secuencial
    where  tabla = 're_his_consumo'

    if @@rowcount <> 1
    begin
      /* Error en secuencial de Historico de protestos */

      exec cobis..sp_cerror
        @i_num = 208038
      return 208038

    end

    /* Validaciones */
    if @w_est <> 'A'
    begin
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002
      return 1
    end

    /* Encontrar el codigo de la ciudad de feriados nacionales */

    select
      @w_ciudad_matriz = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
       and pa_nemonico = 'CMA'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201196
      return 1
    end

    /*  Encuentra dias maximo para la bloqueo por consumos */

    select
      @w_dias_consumos = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'REM'
       and pa_nemonico = 'DBCA'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111020,
        @i_msg = 'ERROR EN PARAMETRO DE DIAS DE CONFORMACION'
      return 111020
    end

    if @w_tasa_imp > 0
    begin
      /* Verificar que la cuenta este exonerada */
      select
        @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
      from   cob_remesas..re_exoneracion_impuesto
      where  ei_producto = 'AHO'
         and ei_cuenta   = @w_cuenta
      if @@rowcount = 1
        select
          @w_tasa_imp = 0.0
    end

    /* CALCULO DEL MONTO DE IDB */
    if @w_tasa_imp > 0
    begin
      select
        @w_monto_imp = round((@i_valor * @w_tasa_imp),
                             @w_numdeci),
        @w_comision_imp = round((@w_comision * @w_tasa_imp),
                                @w_numdeci)
    end
    else
      select
        @w_monto_imp = $0,
        @w_comision_imp = $0

    if @w_saldo_para_girar < (@i_valor + @w_monto_imp + @w_comision +
                              @w_comision_imp)
    begin
      /* Valor a bloquear execede el saldo para girar */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201072
      return 1
    end

    select
      @w_monto_consumos = @w_monto_consumos + (@i_valor + @w_monto_imp +
                                               @w_comision
                                               +
                                                            @w_comision_imp)

    set rowcount 1

    select
      @w_fecha = dl_fecha
    from   cob_ahorros..ah_dias_laborables
    where  dl_ciudad   = @w_ciudad_matriz
       and dl_num_dias = @w_dias_consumos
    order  by dl_fecha
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 125013
      return 1
    end

    set rowcount 0

    /* Generacion de la Clave */

    select
      @w_clave_previa = convert(char(11), @s_ssn)
    select
      @w_clave = right(@w_clave_previa,
                       6)

    while 1 = 1
    begin
      if exists (select
                   *
                 from   cob_remesas..re_his_consumo
                 where  hc_cuenta = @i_cta
                    and hc_clave  = convert(int, @w_clave))
      begin
        select
          @w_fecha_hoy = convert(varchar(8), getdate(), 8)
        select
          @w_aleatorio = substring(@w_fecha_hoy, 4, 2) + substring(@w_fecha_hoy,
                         7
                         ,
                         2)
        select
          @w_clave_int = convert(int, @w_clave) + convert (int, @w_aleatorio)
        select
          @w_clave = convert(varchar(6), @w_clave_int)

      end
      else
        break
    end

    select
      @w_clave_int = convert(int, @w_clave)

    begin tran

    /* Actualizar los campos de conformacion en la tabla ah_cuenta */

    update cob_ahorros..ah_cuenta
    set    ah_monto_consumos = @w_monto_consumos
    where  ah_cuenta = @w_cuenta

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en ah_cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205001
      return 1
    end

    /* Insercion en la tabla re_his_consumo */

    insert into cob_remesas..re_his_consumo
                (hc_secuencial,hc_producto,hc_cuenta,hc_fecha,hc_fecha_fin,
                 hc_valor,hc_valor_imp,hc_tarjeta,hc_estado,hc_clave,
                 hc_oficina,hc_comision,hc_comision_imp,hc_causa,hc_levantado)
    values      (@w_secuencial,@w_producto,@i_cta,@s_date,@w_fecha,
                 @i_valor,@w_monto_imp,@i_tarjeta,@w_estado_consumo,
                 convert(int, @w_clave),
                 @s_ofi,@w_comision,@w_comision_imp,@w_causa_atm,'N')

    if @@error <> 0
    begin
      /* Error en creacion de registro en re_his_consumo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203047
      return 1
    end
  end

  /* Insercion en transaccion de servicio */

  insert into cob_ahorros..ah_tsconsumo
              (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
               terminal,oficina,reentry,origen,correccion,
               ssn_corr,remoto_ssn,cta_banco,fecha,valor,
               moneda,hora,tarjeta,estado,estado_consumo,
               clave,comision,comision_imp,monto_imp,causa,
               prod_banc,categoria,tipocta_super,turno)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
               @s_term,@s_ofi,@t_rty,@s_org,@t_corr,
               @t_ssn_corr,@s_ssn_branch,@i_cta,@w_fecha,@i_valor,
               @w_mon,getdate(),@i_tarjeta,@w_estado,@w_estado_consumo,
               convert(int, @w_clave),@w_comision,@w_comision_imp,@w_monto_imp,
               @w_causa_atm,
               @w_prod_banc,@w_categoria,@w_tipocta_super,@i_turno)
  if @@error <> 0
  begin
    /* Error en insercion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  select
    @o_clave = convert(int, @w_clave)

  /* Envio de resultados a ATM */
  if @i_atm_server = 'S'
  begin
    select
      @w_clave = convert(varchar(6), @o_clave)
    select
      @w_clave = replicate('0', 6-datalength(@w_clave)) + @w_clave
    select
      'results_submit_rpc',
      r_ofi_cta = @w_oficina,
      r_sld_disp = @w_disponible,
      r_sld_cont = @w_saldo_contable,
      r_sld_girar = @w_saldo_para_girar,
      r_sld_12h = @w_12h,
      r_sld_24h = @w_24h,
      r_sld_rem = @w_remesas,
      r_monto_blq = @w_monto_blq,
      r_estado_cta = @w_estado_cta,
      r_ssn_host = @s_ssn,
      r_fecha_cont = @s_date,
      r_comision_host = @w_comision,
      r_numautor = @w_clave
  end

  commit tran
  return 0

go

