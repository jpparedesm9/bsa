/************************************************************************/
/*    Archivo:        ahtcomon.sp                                       */
/*    Stored procedure:    sp_con_ahr_mon_ah                            */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto: Cuentas de Ahorros                                      */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*    Fecha de escritura: 26-Feb-1993                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
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
/*    Este programa realiza la transaccion de consulta de datos         */
/*    de cuentas de ahorros                                             */
/*    220 = Consulta de cuentas de ahorros.                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    22/Dic/1994     J. Bucheli   Personalizacion para Banco de        */
/*                                 la Produccion                        */
/*    03/May/1999    J. Salazar    Correccion en la devolucion de       */
/*                                 la descrip. del tipo de interes      */
/*    22/Mar/2000    G. George     Guardar pista de auditoria.          */
/*    04/Ago/2005    L. Bernuil    Devolver Patente Comercia            */
/*    14/Jul/2006    R. Ramos      Adicion de fideicomiso               */
/*    02/May/2016    J. Calderon   Migración a CEN                      */
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
           where  name = 'sp_con_ahr_mon_ah')
  drop proc sp_con_ahr_mon_ah
go

create proc [dbo].[sp_con_ahr_mon_ah]
(
  @s_ssn           int,
  @s_ssn_branch    int,
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
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_inforcuenta   char(1),
  @i_formato_fecha int=101,
  @i_turno         smallint = null,
  @i_escliente     char(1)= 'N',
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada    
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
    @w_remesas          money,
    @w_rem_hoy          money,
    @w_24h              money,
    @w_12h              money,
    @w_disponible       money,
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
    @w_monto_imp        money,
    @w_monto_consumos   money,
    @w_oficina_cta      smallint,
    @w_saldo_ayer       money,
    @w_tasa_hoy         real,
    @w_prod_banc        smallint,
    @w_desc_prod_banc   descripcion,
    @w_tipocta_super    char(1),
    @w_int_hoy          money,
    @w_int_mes          money,
    @w_monto_emb        money,
    @w_embargada        char(1),
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
    @w_saldo_mantval    money,
    @w_cuota            catalogo,
    @w_cuota_des        descripcion,
    @w_suspensos        money,--Para poder obtener los suspensos de la cuenta
    @w_rem_ayer         money,-- para mostrar las remesas ayer
    @w_patente          varchar(40),
    @w_fideicomiso      varchar(15),
    @w_tipocta          char(1),
    @w_contractual      char(1),
    @w_cliente          int,
    @w_alianza          int,
    @w_desalianza       varchar(255),
    @w_prod_bancario    varchar(50) --Req. 381 CB Red Posicionada

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_con_ahr_mon_ah'

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
      i_mon = @i_mon,
      i_inforcuenta = @i_inforcuenta
    exec cobis..sp_end_debug
  end

  if @t_trn <> 220
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 201048
  end

  select
    @w_suspensos = 0.00
  --Inicializamos la variable que obtendra el valor de los suspensos

  if @i_turno is null
    select
      @i_turno = @s_rol

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
      @w_cliente = ah_cliente
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
      return 251001
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
      @w_cliente = ah_cliente
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
      return 251001
    end
  end

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
     and @i_inforcuenta = 'N'
  begin
    if not exists (select
                     *
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
      return 201123
    end
  end

/* Validaciones */
/* No se valida que la cuenta se encuentre activa */
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

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /* Seleccionar los datos de la cuenta */
    select
      @w_oficina_cta = ah_oficina,
      @w_remesas = ah_remesas,
      @w_rem_hoy = ah_rem_hoy,
      @w_24h = ah_24h,
      @w_12h = ah_12h,
      @w_disponible = ah_disponible,
      @w_saldo_interes = ah_saldo_interes,
      @w_promedio1 = ah_promedio1,
      @w_promedio2 = ah_promedio2,
      @w_promedio3 = ah_promedio3,
      @w_promedio4 = ah_promedio4,
      @w_promedio5 = ah_promedio5,
      @w_promedio6 = ah_promedio6,
      @w_monto_bloq = ah_monto_bloq,
      @w_monto_emb = ah_monto_emb,
      @w_fecha_ult_mov = ah_fecha_ult_mov,
      @w_prom_disponible = ah_prom_disponible,
      @w_creditos_hoy = ah_creditos_hoy,
      @w_creditos = ah_creditos,
      @w_debitos_hoy = ah_debitos_hoy,
      @w_debitos = ah_debitos,
      @w_monto_imp = ah_monto_imp,
      @w_monto_consumos = ah_monto_consumos,
      @w_saldo_ayer = ah_saldo_ayer,
      @w_tasa_hoy = ah_tasa_hoy,
      @w_prod_banc = ah_prod_banc,
      @w_int_hoy = ah_int_hoy,
      @w_int_mes = ah_int_mes,
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
      @w_saldo_mantval = ah_saldo_mantval,
      @w_rem_ayer = ah_rem_ayer,
      @w_patente = ah_patente,
      @w_fideicomiso = ah_fideicomiso,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    /* Seleccionar los datos de la cuenta */
    select
      @w_oficina_cta = ah_oficina,
      @w_remesas = ah_remesas,
      @w_rem_hoy = ah_rem_hoy,
      @w_24h = ah_24h,
      @w_12h = ah_12h,
      @w_disponible = ah_disponible,
      @w_saldo_interes = ah_saldo_interes,
      @w_promedio1 = ah_promedio1,
      @w_promedio2 = ah_promedio2,
      @w_promedio3 = ah_promedio3,
      @w_promedio4 = ah_promedio4,
      @w_promedio5 = ah_promedio5,
      @w_promedio6 = ah_promedio6,
      @w_monto_bloq = ah_monto_bloq,
      @w_monto_emb = ah_monto_emb,
      @w_fecha_ult_mov = ah_fecha_ult_mov,
      @w_prom_disponible = ah_prom_disponible,
      @w_creditos_hoy = ah_creditos_hoy,
      @w_creditos = ah_creditos,
      @w_debitos_hoy = ah_debitos_hoy,
      @w_debitos = ah_debitos,
      @w_monto_imp = ah_monto_imp,
      @w_monto_consumos = ah_monto_consumos,
      @w_saldo_ayer = ah_saldo_ayer,
      @w_tasa_hoy = ah_tasa_hoy,
      @w_prod_banc = ah_prod_banc,
      @w_int_hoy = ah_int_hoy,
      @w_int_mes = ah_int_mes,
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
      @w_saldo_mantval = ah_saldo_mantval,
      @w_rem_ayer = ah_rem_ayer,
      @w_patente = ah_patente,
      @w_fideicomiso = ah_fideicomiso,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
  end

  /* Guardar tran. serv. en consulta monetaria sin costo para auditoria */
  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
               ts_usuario,
               ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
               ts_moneda,ts_oficina_cta,ts_hora,ts_saldo,ts_monto,
               ts_interes,ts_valor,ts_tipocta_super,ts_turno,ts_prod_banc,
               ts_rol_ente)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
               @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
               @i_mon,@w_oficina_cta,getdate(),@w_disponible,@w_prom_disponible,
               @w_saldo_contable,@w_saldo_para_girar,@w_tipocta_super,@i_turno,
               @w_prod_banc,
               @i_escliente)

  if @@error <> 0
  begin
    /* error en la insercion de la transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 203005
  end

  /* Envio de resultados al Front End */
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
    @w_cuota = cn_cuota
  from   cob_ahorros..ah_cuenta_navidad
  where  cn_cuenta = @w_cuenta

  select
    @w_cuota_des = valor
  from   cobis..cl_catalogo
  where  tabla  = (select
                     cobis..cl_tabla.codigo
                   from   cobis..cl_tabla
                   where  tabla = 'ah_cuota_navidad')
     and codigo = @w_cuota

  if exists (select
               1
             from   cobis..cl_parametro
             where  pa_producto = 'ADM'
                and pa_nemonico = 'ABPAIS')
  begin
    if exists (select
                 1
               from   cobis..cl_parametro
               where  pa_producto = 'ADM'
                  and pa_nemonico = 'ABPAIS'
                  and pa_char     <> 'CO')
      select
        @w_cuota,
        isnull(@w_cuota_des,
               'NO ES CTA. NAVIDAD')
  end
  else
    select
      @w_cuota,
      isnull(@w_cuota_des,
             'NO ES CTA. NAVIDAD')

  if exists (select
               1
             from   cob_ahorros..ah_embargo
             where  he_cta_banco = @i_cta
                and he_fecha_lev is null)
    select
      @w_embargada = 'S'
  else
  begin
    select
      @w_monto_emb = @w_monto_emb + sum(isnull(ca_saldo_pdte, 0))
    from   cobis..cl_cab_embargo
    where  ca_tipo_proceso       = 'B'
       and ((ca_cuenta_especifica  = 'S'
             and ca_producto           = 'AHO'
             and ca_nro_cta_especifica = @i_cta)
             or ca_cuenta_especifica  = 'N'
                and ca_ente in
                    (select
                       cl_cliente
                     from   cob_ahorros..ah_cuenta,
                            cobis..cl_cliente,
                            cobis..cl_det_producto
                     where  ah_cta_banco    = dp_cuenta
                        and cl_det_producto = dp_det_producto
                        and ah_cta_banco    = @i_cta
                        and ah_estado       <> 'C'))
    if isnull(@w_monto_emb,
              0) = 0
      select
        @w_embargada = 'N'
    else
      select
        @w_embargada = 'S'
  end

  --Para verificar cuenta contractual
  if exists (select
               1
             from   cob_remesas..re_cuenta_contractual
             where  cc_cta_banco = @i_cta
                and cc_estado    = 'A')
    select
      @w_contractual = 'S'
  else
    select
      @w_contractual = 'N'

  select
    @w_contractual
  select
    @w_tipocta

  /* LBM280205 -- Seccion para obtener el monto total de los suspensos a cobrar a la cuenta */

  select
    @w_suspensos = isnull(sum(vs_valor),
                          0.00)
  from   cob_ahorros..ah_val_suspenso
  where  vs_cuenta    = @w_cuenta
     and vs_estado    = 'N'
     and vs_procesada = 'N'

  select
    @w_alianza = al_alianza,
    @w_desalianza = isnull((al_nemonico + ' - ' + al_nom_alianza),
                           '  ')
  from   cobis..cl_alianza_cliente with (nolock),
         cobis..cl_alianza with (nolock)
  where  ac_ente    = @w_cliente
     and ac_alianza = al_alianza
     and al_estado  = 'V'
     and ac_estado  = 'V'

  select
    'Remesas' = @w_remesas,
    'Remesas Hoy.' = @w_rem_hoy,
    'Retenido 24 Horas' = @w_24h,
    'Retenido 12 Horas' = @w_12h,
    'Disponible' = @w_disponible,
    'Saldo cuenta' = @w_saldo_contable,
    'Saldo para girar' = @w_saldo_para_girar,
    'Saldo interes' = @w_saldo_interes,
    'Promedio 1' = @w_promedio1,
    'Promedio 2' = @w_promedio2,
    'Promedio 3' = @w_promedio3,
    'Promedio 4' = @w_promedio4,
    'Promedio 5' = @w_promedio5,
    'Promedio 6' = @w_promedio6,
    'Retencion Valores' = @w_monto_bloq,
    'Fecha Ultimo Mov.' = convert(varchar(10), @w_fecha_ult_mov,
                          @i_formato_fecha)
    ,
    'Prom. Disp.' = @w_prom_disponible,
    'Cred. Hoy' = @w_creditos_hoy,
    'Cred. Mes' = @w_creditos,
    'Deb. Hoy' = @w_debitos_hoy,
    'Deb. Mes' = @w_debitos,
    'IDB Mes' = @w_monto_imp,
    'Monto Consumos' = @w_monto_consumos,
    'Saldo Ayer' = @w_saldo_ayer,
    'Tasa Hoy' = @w_tasa_hoy,
    'Ultimo Interes' = @w_int_hoy,
    'Interes del Mes' = @w_int_mes,
    'Valores Embargados' = @w_monto_emb,
    'Cta Embargada' = @w_embargada,
    'Credito2' = @w_credito2,
    'Credito3' = @w_credito3,
    'Credito4' = @w_credito4,
    'Credito5' = @w_credito5,
    'Credito6' = @w_credito6,
    'Debito2' = @w_debito2,
    'Debito3' = @w_debito3,
    'Debito4' = @w_debito4,
    'Debito5' = @w_debito5,
    'Debito6' = @w_debito6,
    'Valores en Suspenso' = @w_suspensos,
    --'Mant. Valor'       = @w_saldo_mantval    
    'Rem. Ayer' = @w_rem_ayer,
    'Patente' = @w_patente,
    'Fideicomiso' = @w_fideicomiso,
    'Alianza' = @w_alianza,
    'Des Alianza' = @w_desalianza
  return 0

go

