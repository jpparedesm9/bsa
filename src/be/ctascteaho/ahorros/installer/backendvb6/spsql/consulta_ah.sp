/************************************************************************/
/*  Archivo:            consulta_ah.sp                                  */
/*  Stored procedure:   sp_consulta_ah                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 26-Feb-1993                                     */
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
/*  Este programa realiza la transaccion de consulta de datos           */
/*  generales y datos financieros de cuentas de ahorros                 */
/*  230 = Consulta de cuentas.                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  26/Feb/1993     P Mena          Emision inicial                     */
/*  15/Dic/1993     P Mena          Personalizacion para Banco de       */
/*                                  Credito                             */
/*  03/May/1999     Johnmer Salazar Correccion en la devolucion de      */
/*                                  la descrip. del tipo de interes     */
/*  22/Mar/2000     George George   Guardar pista de auditoria.         */
/*  28/Feb/2005     L. Bernuil      Cambio de Campo Tasa Hoy            */
/*  24/Feb/2010     Raul Altamirano Consulta de Saldo en Caja           */
/*  15/Abr/2010     Erika Alvarez   Adic campo Total, mod. disponible   */
/*  07/feb/2013     D.Pulido        REQ330-Validacion identidad cliente */
/*  08/Ago/2014     C Avendano      REQ451 Cobro Com TD                 */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cob_ahorros
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consulta_ah')
  drop proc sp_consulta_ah
go

create proc sp_consulta_ah
(
  @s_ssn           int,
  @s_ssn_branch    int = null,--ALF
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_ssn_corr      int = null,
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_formato_fecha int = 101,
  @i_turno         smallint = null,
  @i_escliente     char(1) = 'N',
  @i_filial        smallint = 1,

  --ream 24.feb.2010 consulta de saldo en caja
  @i_caja          char(1) = 'N',
  @i_comision      money = 0,--REQ 203
  @i_causal        char(3) = '',--REQ 203
  @i_corresponsal  char(1) = 'N',--Req. 381 CB Red Posicionada      
  @o_nombre        varchar(64) out,
  @o_disponible    money = 0 out,
  @o_canje         money = 0 out,
  @o_remesas       money = 0 out,
  @o_vlrbloq       money = 0 out,
  @o_total         money = 0 out,
  @o_gmf           money = 0 out,
  @o_valiva        money = 0 out
--ream 24.feb.2010 consulta de saldo en caja
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_estado           char(1),
    @w_tipo_def         char(1),
    @w_moneda           tinyint,
    @w_oficial          smallint,
    @w_categoria        char(1),
    @w_tipo_promedio    char(1),
    @w_capitalizacion   char(1),
    @w_tpromedio_des    descripcion,
    @w_estado_des       descripcion,
    @w_mon_des          descripcion,
    @w_categ_des        descripcion,
    @w_oficial_des      descripcion,
    @w_capit_des        descripcion,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_funcionario      char(1),
    @w_oficina_cta      smallint,
    @w_control          int,
    @w_remesas          money,
    @w_rem_hoy          money,
    @w_24h              money,
    @w_12h              money,
    @w_disponible       money,
    @w_saldo_libreta    money,
    @w_saldo_interes    money,
    @w_promedio1        money,
    @w_promedio2        money,
    @w_promedio3        money,
    @w_promedio4        money,
    @w_promedio5        money,
    @w_promedio6        money,
    @w_monto_bloq       money,
    @w_fecha_ult_mov    smalldatetime,
    @w_prom_disponible  money,
    @w_creditos_hoy     money,
    @w_creditos         money,
    @w_debitos_hoy      money,
    @w_debitos          money,
    @w_linea            smallint,
    @w_monto_imp        money,
    @w_monto_consumos   money,
    @w_tasa_hoy         real,
    @w_prod_banc        smallint,
    @w_desc_prod_banc   descripcion,
    @w_tipocta_super    char(1),
    @w_monto_embargo    money,
    @w_credito2         money,
    @w_credito3         money,
    @w_credito4         money,
    @w_credito5         money,
    @w_credito6         money,
    @w_debito2          money,
    @w_debito3          money,
    @w_debito4          money,
    @w_debito5          money,
    @w_debito6          money,
    --ream 24.feb.2010 consulta de saldo en caja
    @w_num_con_mes      int,
    @w_total_trn        int,
    @w_tipo_com         char(1),
    --ream 24.feb.2010 consulta de saldo en caja
    @w_numcre           int,
    @w_numtot           int,
    @w_numco            int,
    @w_numdeb           int,
    @w_numtotcta        int,
    @w_tipocobro        char(1),
    @w_tipo_ente        char(1),
    @w_tipo             char(1),
    @w_numero           int,
    @w_nconmes          int,
    @w_ciudad_cta       int,
    @w_ciudad_loc       int,
    @w_codigo_pais      char(3),
    @w_cobro_comision   money,
    @w_rol_ente         char(1),
    @w_codigo           int,
    @w_personalizada    char(1),
    @w_producto         tinyint,
    @w_nom_cli          varchar(60),
    @w_cliente          int,--REQ 330
    @w_o_estado         int,--REQ 330 
    @w_tipo_ced         char(2),--REQ 330  
    @w_ced_ruc          numero,--REQ 330
    @w_msg_valida       varchar(64),--REQ 330 
    @w_ctitularidad     char(1),
    @w_prod_bancario    varchar(50),--Req. 381 CB Red Posicionada
    @w_cobro_td         money,--Valor comision Tarjeta Debito
    @w_servicio         char(4),
    @w_filial           tinyint

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_consulta_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
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
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  if @t_trn <> 230
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  if @i_turno is null --FES 10/06/2003 corrección por E: SP-TNG-03
    select
      @i_turno = @s_rol

  select
    @o_valiva = 0,
    @o_gmf = 0

  -- COBRO COMISIONES      
  if isnull(@i_comision,
            0) > 0
  begin
    exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv        = @s_srv,
      @s_ofi        = @s_ofi,
      @s_ssn        = @s_ssn,
      @s_ssn_branch = @s_ssn_branch,
      @s_user       = @s_user,
      @s_term       = 'Com-Cons',
      @t_trn        = 264,
      @t_corr       = 'N',
      @t_ssn_corr   = @t_ssn_corr,
      @i_cta        = @i_cta,
      @i_val        = @i_comision,
      @i_cau        = @i_causal,-- cobro de comisiones
      @i_mon        = @i_mon,
      @i_alt        = 2,
      @i_fecha      = @s_date,
      @i_cobiva     = 'S',
      @i_canal      = 4,
      @o_valiva     = @o_valiva out,
      @o_val_2x1000 = @o_gmf out

    if @w_return <> 0
      return @w_return
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado,
      @w_oficial = ah_oficial,
      @w_categoria = ah_categoria,
      @w_moneda = ah_moneda,
      @w_tipo_promedio = ah_tipo_promedio,
      @w_capitalizacion = ah_capitalizacion,
      @w_funcionario = ah_cta_funcionario,
      @w_tipocta_super = ah_tipocta_super,
      --ream 24.feb.2010 consulta de saldo en caja
      @w_prod_banc = ah_prod_banc,
      @w_categoria = ah_categoria,
      @w_tipo_ente = ah_tipocta,
      @w_tipo = ah_tipo,
      @w_producto = ah_producto,
      @w_codigo = ah_default,
      @w_personalizada = ah_personalizada,
      @w_nom_cli = ah_nombre,
      @w_num_con_mes = ah_num_con_mes,
      @w_total_trn = ah_num_deb_mes + ah_num_cred_mes + ah_num_con_mes,
      @w_control = ah_control,
      @w_oficina_cta = ah_oficina,
      @w_remesas = ah_remesas,
      @w_rem_hoy = ah_rem_hoy,
      @w_24h = ah_24h,
      @w_12h = ah_12h,
      @w_disponible = ah_disponible,
      @w_saldo_libreta = ah_saldo_libreta,
      @w_saldo_interes = ah_saldo_interes,
      @w_promedio1 = ah_promedio1,
      @w_promedio2 = ah_promedio2,
      @w_promedio3 = ah_promedio3,
      @w_promedio4 = ah_promedio4,
      @w_promedio5 = ah_promedio5,
      @w_promedio6 = ah_promedio6,
      @w_monto_bloq = ah_monto_bloq,
      @w_fecha_ult_mov = ah_fecha_ult_mov,
      @w_prom_disponible = ah_prom_disponible,
      @w_creditos_hoy = ah_creditos_hoy,
      @w_creditos = ah_creditos,
      @w_debitos_hoy = ah_debitos_hoy,
      @w_debitos = ah_debitos,
      @w_linea = ah_linea,
      @w_monto_imp = ah_monto_imp,
      @w_monto_consumos = ah_monto_consumos,
      @w_tasa_hoy = ah_tasa_hoy,
      @w_prod_banc = ah_prod_banc,
      @w_monto_embargo = ah_monto_emb,
      @w_credito2 = ah_creditos2,
      @w_credito3 = ah_creditos3,
      @w_credito4 = ah_creditos4,
      @w_credito5 = ah_creditos5,
      @w_credito6 = ah_creditos6,
      @w_debito2 = ah_debitos2,
      @w_debito3 = ah_debitos3,
      @w_debito4 = ah_debitos4,
      @w_debito5 = ah_debitos5,
      @w_debito6 = ah_debitos6,
      @w_filial = ah_filial,
      @w_nconmes = isnull(ah_num_con_mes,
                          0),
      @w_numtotcta = isnull(ah_num_con_mes, 0) + isnull(ah_num_cred_mes, 0) +
                     isnull
                     (
                     ah_num_deb_mes
                     , 0),
      --ream 24.feb.2010 consulta de saldo en caja
      @w_cliente = ah_cliente,--REQ330
      @w_ctitularidad = ah_ctitularidad
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    /* Chequeo de existencias */
    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end
  else
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado,
      @w_oficial = ah_oficial,
      @w_categoria = ah_categoria,
      @w_moneda = ah_moneda,
      @w_tipo_promedio = ah_tipo_promedio,
      @w_capitalizacion = ah_capitalizacion,
      @w_funcionario = ah_cta_funcionario,
      @w_tipocta_super = ah_tipocta_super,
      --ream 24.feb.2010 consulta de saldo en caja
      @w_prod_banc = ah_prod_banc,
      @w_categoria = ah_categoria,
      @w_tipo_ente = ah_tipocta,
      @w_tipo = ah_tipo,
      @w_producto = ah_producto,
      @w_codigo = ah_default,
      @w_personalizada = ah_personalizada,
      @w_nom_cli = ah_nombre,
      @w_num_con_mes = ah_num_con_mes,
      @w_total_trn = ah_num_deb_mes + ah_num_cred_mes + ah_num_con_mes,
      @w_control = ah_control,
      @w_oficina_cta = ah_oficina,
      @w_remesas = ah_remesas,
      @w_rem_hoy = ah_rem_hoy,
      @w_24h = ah_24h,
      @w_12h = ah_12h,
      @w_disponible = ah_disponible,
      @w_saldo_libreta = ah_saldo_libreta,
      @w_saldo_interes = ah_saldo_interes,
      @w_promedio1 = ah_promedio1,
      @w_promedio2 = ah_promedio2,
      @w_promedio3 = ah_promedio3,
      @w_promedio4 = ah_promedio4,
      @w_promedio5 = ah_promedio5,
      @w_promedio6 = ah_promedio6,
      @w_monto_bloq = ah_monto_bloq,
      @w_fecha_ult_mov = ah_fecha_ult_mov,
      @w_prom_disponible = ah_prom_disponible,
      @w_creditos_hoy = ah_creditos_hoy,
      @w_creditos = ah_creditos,
      @w_debitos_hoy = ah_debitos_hoy,
      @w_debitos = ah_debitos,
      @w_linea = ah_linea,
      @w_monto_imp = ah_monto_imp,
      @w_monto_consumos = ah_monto_consumos,
      @w_tasa_hoy = ah_tasa_hoy,
      @w_prod_banc = ah_prod_banc,
      @w_monto_embargo = ah_monto_emb,
      @w_credito2 = ah_creditos2,
      @w_credito3 = ah_creditos3,
      @w_credito4 = ah_creditos4,
      @w_credito5 = ah_creditos5,
      @w_credito6 = ah_creditos6,
      @w_debito2 = ah_debitos2,
      @w_debito3 = ah_debitos3,
      @w_debito4 = ah_debitos4,
      @w_debito5 = ah_debitos5,
      @w_debito6 = ah_debitos6,
      @w_filial = ah_filial,
      @w_nconmes = isnull(ah_num_con_mes,
                          0),
      @w_numtotcta = isnull(ah_num_con_mes, 0) + isnull(ah_num_cred_mes, 0) +
                     isnull
                     (
                     ah_num_deb_mes
                     , 0),
      --ream 24.feb.2010 consulta de saldo en caja
      @w_cliente = ah_cliente,--REQ330
      @w_ctitularidad = ah_ctitularidad
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

    /* Chequeo de existencias */
    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end

  --REQ 330 VALIDACION IDENTIFICACION CLIENTE

  if exists (select
               1
             from   cobis..cl_val_iden
             where  vi_transaccion = @t_trn
                and vi_estado      = 'V'
                and (vi_ind_causal  = 'N'
                      or (vi_ind_causal  = 'S'
                          and vi_causal      = @i_causal)))
  begin
    select
      cl_ced_ruc,
      en_tipo_ced
    into   #tabla_titul
    from   cobis..cl_cliente,
           cobis..cl_det_producto,
           cobis..cl_ente
    where  cl_det_producto = dp_det_producto
       and en_ente         = cl_cliente
       and cl_rol in ('T', 'C', 'F', 'U')
       and dp_cuenta       = @i_cta
       and dp_producto     = 4
       and dp_estado_ser   = 'V'

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
      return @w_return
    end

    while 1 = 1
    begin
      select
        @w_ced_ruc = cl_ced_ruc,
        @w_tipo_ced = en_tipo_ced
      from   #tabla_titul

      if @@rowcount = 0
        break

      -----------------------------------------------
      --inseta registro a validar la huella
      -----------------------------------------------
      exec @w_return = cobis..sp_consulta_homini
        @s_term        = @s_term,
        @s_ofi         = @s_ofi,
        @t_trn         = 1608,
        @i_operacion   = 'I',
        @i_titularidad = @w_ctitularidad,
        @i_tipo_ced    = @w_tipo_ced,
        @i_ced_ruc     = @w_ced_ruc,
        @i_ref         = @i_cta,
        @i_user        = @s_user,
        @i_id_caja     = 0,
        @i_trn         = @t_trn,
        @i_sec_cobis   = @s_ssn

      if @w_return <> 0
          or @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_return
        return @w_return
      end

      delete from #tabla_titul
      where  cl_ced_ruc  = @w_ced_ruc
         and en_tipo_ced = @w_tipo_ced

    end --END WHILE
    -----------------------------------------------
    --invocar al servicio de validacion de huella
    -----------------------------------------------
    exec @w_return = cobis..sp_consulta_homini
      @s_term      = @s_term,
      @s_ofi       = @s_ofi,
      @t_trn       = 1608,
      @i_operacion = 'V',
      @i_ref       = @i_cta,
      @i_user      = @s_user,
      @i_id_caja   = 0,
      @i_sec_cobis = @s_ssn,
      @i_trn       = @t_trn,
      @o_codigo    = @w_o_estado out,
      @o_mensaje   = @w_msg_valida out

    if @w_return <> 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
      return @w_return
    end

    -- VALIDACION MENSAJES RESTRICTIVOS HOMINI 
    if @w_o_estado <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_o_estado,
        @i_msg   = @w_msg_valida

      return @w_o_estado
    end
  end

  /* Validaciones */
  if @w_estado <> 'A'
  begin
    if (@i_caja = 'N'
        and @w_estado <> 'C')
        or @i_caja = 'S'
    begin
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002
      return 1
    end
  end

  if @i_caja = 'S' -- REQ 453 Solo cuando se consulta desde Caja.
  begin
    if exists (select
                 1
               from   cob_remesas..re_relacion_cta_canal
               where  rc_cuenta = @i_cta
                  and rc_canal  = 'TAR')
    begin
      select
        @w_servicio = valor
      from   cobis..cl_tabla t,
             cobis..cl_catalogo c
      where  t.tabla  = 'pe_comision_td'
         and t.codigo = c.tabla
         and c.codigo = convert(char, @t_trn)

      if @w_servicio is not null
      begin
        exec @w_return = cob_remesas..sp_genera_costos
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_fecha       = @s_date,
          @i_valor       = 1,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipo_ente,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @i_mon,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_codigo,
          @i_servicio    = @w_servicio,
          --Comision por retiro a cuentas con tarjeta debito
          @i_rubro       = '3',
          @i_disponible  = @w_disponible,
          @i_contable    = @w_saldo_contable,
          @i_promedio    = @w_promedio1,
          @i_prom_disp   = @w_prom_disponible,
          @i_personaliza = @w_personalizada,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina_cta,
          @o_valor_total = @w_cobro_td out --Valor comision Tarjeta Debito

        if @w_return <> 0
          return @w_return

        if @w_cobro_td > 0
        begin
          -- ND por  valor comision
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_ssn_branch = @s_ssn_branch,
            @s_user       = @s_user,
            @t_trn        = 264,
            @t_corr       = 'N',
            @t_ssn_corr   = @t_ssn_corr,
            @i_cta        = @i_cta,
            @i_val        = @w_cobro_td,
            @i_cau        = '160',-- causa cobro comision retiro con cheque  
            @i_mon        = @i_mon,
            @i_alt        = 7,
            @i_fecha      = @s_date,
            @i_cobiva     = 'S',
            @i_canal      = 4,
            @o_valiva     = @o_valiva out,
            @o_val_2x1000 = @o_gmf out

          if @w_return <> 0
            return @w_return
        end

      end
    end
  end

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
     and @i_caja = 'N'
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 1
    end
  end

  /* Calculo del saldo contable y saldo para girar de la cuenta */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

/* Seleccionar los datos de la cuenta */
/* --ream 24.feb.2010 consulta de saldo en caja
select  
@w_control         = ah_control,
@w_oficina_cta     = ah_oficina,
@w_remesas         = ah_remesas,
@w_rem_hoy         = ah_rem_hoy,
@w_24h             = ah_24h,
@w_12h             = ah_12h,
@w_disponible      = ah_disponible,
@w_saldo_libreta   = ah_saldo_libreta,
@w_saldo_interes   = ah_saldo_interes,
@w_promedio1       = ah_promedio1,
@w_promedio2       = ah_promedio2,
@w_promedio3       = ah_promedio3,
@w_promedio4       = ah_promedio4,
@w_promedio5       = ah_promedio5,
@w_promedio6       = ah_promedio6,
@w_monto_bloq      = ah_monto_bloq,
@w_fecha_ult_mov   = ah_fecha_ult_mov,
@w_prom_disponible = ah_prom_disponible,
@w_creditos_hoy    = ah_creditos_hoy,
@w_creditos        = ah_creditos,
@w_debitos_hoy     = ah_debitos_hoy,
@w_debitos         = ah_debitos,
@w_linea           = ah_linea,
@w_monto_imp       = ah_monto_imp,
@w_monto_consumos  = ah_monto_consumos,
@w_tasa_hoy        = ah_tasa_hoy,
@w_prod_banc       = ah_prod_banc,
@w_monto_embargo   = ah_monto_emb,
@w_credito2        = ah_creditos2,
@w_credito3        = ah_creditos3,
@w_credito4        = ah_creditos4,
@w_credito5        = ah_creditos5,
@w_credito6        = ah_creditos6,
@w_debito2         = ah_debitos2,
@w_debito3         = ah_debitos3,
@w_debito4         = ah_debitos4,
@w_debito5         = ah_debitos5,
@w_debito6         = ah_debitos6
from cob_ahorros..ah_cuenta
where ah_cta_banco = @i_cta
--ream 24.feb.2010 consulta de saldo en caja*/
  /* Guardar tran. serv. en consulta monetaria sin costo para auditoria */
  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
               ts_usuario,
               ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
               ts_moneda,ts_oficina_cta,ts_hora,ts_saldo,ts_monto,
               ts_interes,ts_valor,ts_cheque,ts_oficina_pago,ts_tipocta_super,
               ts_turno,ts_prod_banc,ts_rol_ente)
  values      ( @s_ssn,isnull(@s_ssn_branch,
                       @s_ssn),@t_trn,@s_date,@s_user,
                @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                @w_moneda,@w_oficina_cta,getdate(),@w_disponible,
                @w_prom_disponible,
                @w_saldo_contable,@w_saldo_para_girar,@w_control,@w_linea,
                @w_tipocta_super,
                @i_turno,@w_prod_banc,@i_escliente)

  if @@error <> 0
  begin
    /* error en la insercion de la transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  /* Envio de resultados al Front End */
  if @i_caja = 'N'
  begin
    select
      @w_mon_des = mo_descripcion
    from   cobis..cl_moneda
    where  mo_moneda = @w_moneda
    select
      @w_moneda,
      @w_mon_des

    select
      @w_estado_des = valor
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_estado_cta')
       and codigo = @w_estado
    select
      @w_estado,
      @w_estado_des

    select
      @w_categ_des = valor
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'pe_categoria')
       and codigo = @w_categoria
    select
      @w_categoria,
      @w_categ_des

    select
      @w_oficial_des = fu_nombre
    from   cobis..cl_funcionario,
           cobis..cc_oficial
    where  oc_oficial     = @w_oficial
       and fu_funcionario = oc_funcionario
    select
      @w_oficial,
      @w_oficial_des

    select
      @w_tpromedio_des = valor
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_tpromedio')
       and codigo = @w_tipo_promedio
    select
      @w_tipo_promedio,
      @w_tpromedio_des

    select
      @w_capit_des = valor
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_capitalizacion')
       and codigo = @w_capitalizacion

    select
      @w_capitalizacion,
      @w_capit_des

    select
      @w_desc_prod_banc = pb_descripcion
    from   cob_remesas..pe_pro_bancario
    where  pb_pro_bancario = @w_prod_banc
    select
      @w_prod_banc,
      @w_desc_prod_banc

    select
      'No. de Control' = @w_control,
      'Remesas' = @w_remesas,
      'Remesas Hoy.' = @w_rem_hoy,
      'Retenido 24 Horas' = @w_24h,
      'Retenido 12 Horas' = @w_12h,
      'Disponible' = @w_disponible,
      'Saldo cuenta' = @w_saldo_contable,
      'Saldo para girar' = @w_saldo_para_girar,
      'Saldo libreta' = @w_saldo_libreta,
      'Saldo interes' = @w_saldo_interes,
      'Promedio 1' = @w_promedio1,
      'Promedio 2' = @w_promedio2,
      'Promedio 3' = @w_promedio3,
      'Promedio 4' = @w_promedio4,
      'Promedio 5' = @w_promedio5,
      'Promedio 6' = @w_promedio6,
      'Retencion valores' = @w_monto_bloq,
      'Fecha Ultimo Mov.' = convert(varchar(10), @w_fecha_ult_mov,
                            @i_formato_fecha)
      ,
      'Prom. Disp' = @w_prom_disponible,
      'Cred. Hoy' = @w_creditos_hoy,
      'Cred. Mes' = @w_creditos,
      'Deb. Hoy' = @w_debitos_hoy,
      'Deb. Mes' = @w_debitos,
      'Linea Pen' = @w_linea,
      'IDB Mes' = @w_monto_imp,
      'Monto Embargado' = @w_monto_embargo,
      --'Tasa Hoy'         = @w_tasa_hoy,
      'Interés Acum' = @w_saldo_interes,
      'Credito2' = @w_credito2,
      'Credito3' = @w_credito3,
      'Credito4' = @w_credito4,
      'Credito5' = @w_credito5,
      'Credito6' = @w_credito6,
      'Debito2' = @w_debito2,
      'Debito3' = @w_debito3,
      'Debito4' = @w_debito4,
      'Debito5' = @w_debito5,
      'Debito6' = @w_debito6
  end
  else
  begin
    select
      @o_nombre = @w_nom_cli,
      @o_disponible = @w_saldo_para_girar + isnull(@i_comision, 0) + isnull(
                      @o_valiva
                      , 0) + isnull(
                      @o_gmf, 0),
      @o_canje = @w_12h + @w_24h,
      @o_remesas = @w_remesas,
      @o_vlrbloq = @w_monto_bloq + @w_monto_embargo + @w_monto_consumos
    select
      @o_total = @w_saldo_para_girar + @o_canje + @o_vlrbloq
    select
      @w_cobro_comision = 0

    select
      @w_codigo_pais = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'ABPAIS'
       and pa_producto = 'ADM'

    if @w_codigo_pais is null
      select
        @w_codigo_pais = 'PA'

    if @w_codigo_pais = 'CO' -- Colombia
    begin
      -- Consulta de ciudad para las oficinas de la cuenta
      -- y oficina con la que trabaja el sistema

      select
        @w_ciudad_cta = oc_centro
      from   cob_cuentas..cc_ofi_centro
      where  oc_oficina = @w_oficina_cta
      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201094
        return 201094
      end
      /*FRC-AHO-017-CobroComisiones CMU 2102110*/
      select
        @w_ciudad_loc = oc_centro
      from   cob_cuentas..cc_ofi_centro
      where  oc_oficina = @s_ofi

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201094
        return 201094
      end
    end

    update cob_ahorros..ah_cuenta
    set    ah_num_con_mes = isnull(ah_num_con_mes, 0) + 1
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

    if @@error <> 0
    begin
      /* error en la actualizacion de registro */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 1
    end
  end
  return 0

go


