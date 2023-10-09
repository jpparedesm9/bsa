/************************************************************************/
/*    Archivo:           ahtcogah.sp                                    */
/*    Stored procedure:  sp_cons_gral_ah                                */
/*  Base de datos:     cob_ahorros                                      */
/*  Producto:          Cuentas de Ahorros                               */
/*  Disenado por:      Mauricio Bayas/Sandra Ortiz                      */
/*  Fecha de escritura: 15-Dic-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de consulta general          */
/*    de cuentas de ahorros.                                            */
/*    235 = Consulta general de cuentas de ahorros.                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    15/Dic/1993    P Mena           Emision inicial                   */
/*    18/Nov/1994    J. Bucheli     Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*    18/Feb/1999    M. Sanguino    Personalizacion para Banco Caribe   */
/*    16/Jun/1999    R. Penarreta   IDB                                 */
/*    17/Mar/2005    L. Bernuil     Numero de Libreta en Consulta       */
/*    14/Jul/2006    R. Ramos       Adicion de fideicomiso              */
/*    27/Abr/2011    S.Molano       Req-000217, cons campos adicionales */
/*    02/May/2016    J. Calderon    Migración a CEN                     */
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
           where  name = 'sp_cons_gral_ah')
  drop proc sp_cons_gral_ah

go
create proc sp_cons_gral_ah
(
  @s_ssn           int,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_user          varchar(30) = null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,-- Localidad origen transaccion 
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,-- Origen de error:[A], [S] 
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
  @i_formato_fecha int = 101,
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada        
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_estado           char(1),
    @w_moneda           tinyint,
    @w_oficial          smallint,
    @w_pers_desc        direccion,
    @w_dir_ec           tinyint,
    @w_descdir_ec       direccion,
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_default          int,
    @w_ciclo            char(1),
    @w_categoria        char(1),
    @w_tipo_promedio    char(1),
    @w_tpromedio_des    descripcion,
    @w_tdef_des         descripcion,
    @w_rolente_des      descripcion,
    @w_ciclo_des        descripcion,
    @w_estado_des       descripcion,
    @w_mon_des          descripcion,
    @w_categ_des        descripcion,
    @w_oficial_des      descripcion,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_fecha_apertura   varchar(10),
    @w_fecha_prx_corte  varchar(10),
    @w_remesas          money,
    @w_fecha_ult_mov    varchar(10),
    @w_saldo_ult_corte  money,
    @w_saldo_ayer       money,
    @w_fecha_ult_corte  varchar(10),
    @w_zona             smallint,
    @w_parroq           smallint,
    @w_funcionario      char(1),
    @w_oficina1         smallint,
    @w_cliente1         int,
    @w_numlib           int,
    @w_personalizada    char(1),
    @w_embargada        char(1),
    @w_numsol           int,
    @w_monto_bloq       money,
    @w_fideicomiso      varchar(15),
    @w_contractual      char(1),
    @w_prod_banc        smallint,
    @w_tipocta          char(1),
    @w_alianza          int,
    @w_des_alianza      varchar(255),
    @w_prod_bancario    varchar(50) --Req. 381 CB Red Posicionada

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_cons_gral_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  --Modo de debug 
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
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

  if @t_trn <> 235
  begin
    --Error en codigo de transaccion 
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
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
      @w_moneda = ah_moneda,
      @w_dir_ec = ah_direccion_ec,
      @w_descdir_ec = ah_descripcion_ec,
      @w_fecha_apertura = convert(varchar(10), ah_fecha_aper, @i_formato_fecha),
      @w_fecha_prx_corte = convert(varchar(10), ah_fecha_prx_corte,
                           @i_formato_fecha
                           ),
      @w_categoria = ah_categoria,
      @w_tipo_def = ah_tipo_def,
      @w_default = ah_default,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_promedio = ah_tipo_promedio,
      @w_oficial = ah_oficial,
      @w_ciclo = ah_ciclo,
      @w_estado = ah_estado,
      @w_remesas = ah_remesas,
      @w_monto_bloq = ah_monto_bloq,
      @w_fecha_ult_mov = convert(varchar(10), ah_fecha_ult_mov, @i_formato_fecha
                         ),
      @w_saldo_ult_corte = ah_saldo_ult_corte,
      @w_saldo_ayer = ah_saldo_ayer,
      @w_fecha_ult_corte = convert(varchar(10), ah_fecha_ult_corte,
                           @i_formato_fecha
                           ),
      @w_zona = ah_zona,
      @w_parroq = ah_parroquia,
      @w_funcionario = ah_cta_funcionario,
      @w_oficina1 = ah_oficina,
      @w_cliente1 = ah_cliente,
      @w_numlib = ah_numlib,
      @w_personalizada = ah_personalizada,-- Adicion del campo de Personalizada,
      @w_numsol = ah_numsol,
      @w_fideicomiso = ah_fideicomiso,
      @w_prod_banc = ah_prod_banc,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    if @@rowcount <> 1
    begin
      -- No existe cuenta_banco 
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
      @w_moneda = ah_moneda,
      @w_dir_ec = ah_direccion_ec,
      @w_descdir_ec = ah_descripcion_ec,
      @w_fecha_apertura = convert(varchar(10), ah_fecha_aper, @i_formato_fecha),
      @w_fecha_prx_corte = convert(varchar(10), ah_fecha_prx_corte,
                           @i_formato_fecha
                           ),
      @w_categoria = ah_categoria,
      @w_tipo_def = ah_tipo_def,
      @w_default = ah_default,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_promedio = ah_tipo_promedio,
      @w_oficial = ah_oficial,
      @w_ciclo = ah_ciclo,
      @w_estado = ah_estado,
      @w_remesas = ah_remesas,
      @w_monto_bloq = ah_monto_bloq,
      @w_fecha_ult_mov = convert(varchar(10), ah_fecha_ult_mov, @i_formato_fecha
                         ),
      @w_saldo_ult_corte = ah_saldo_ult_corte,
      @w_saldo_ayer = ah_saldo_ayer,
      @w_fecha_ult_corte = convert(varchar(10), ah_fecha_ult_corte,
                           @i_formato_fecha
                           ),
      @w_zona = ah_zona,
      @w_parroq = ah_parroquia,
      @w_funcionario = ah_cta_funcionario,
      @w_oficina1 = ah_oficina,
      @w_cliente1 = ah_cliente,
      @w_numlib = ah_numlib,
      @w_personalizada = ah_personalizada,-- Adicion del campo de Personalizada,
      @w_numsol = ah_numsol,
      @w_fideicomiso = ah_fideicomiso,
      @w_prod_banc = ah_prod_banc,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

    if @@rowcount <> 1
    begin
      -- No existe cuenta_banco 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end

  -- Verificacion de cuentas de funcionarios para oficiales autorizados 
  if @w_funcionario = 'S'
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
      return 1
    end
  end

  --Calculo del saldo contable y saldo para girar de la cuenta 

  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    --@i_ofi                = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  --Envio de resultados al Front End 
  select
    @w_dir_ec,
    @w_descdir_ec,
    @w_fecha_apertura,
    @w_fecha_prx_corte,
    @w_monto_bloq,
    @w_fecha_ult_mov,
    @w_saldo_ult_corte,
    @w_saldo_ayer,
    @w_fecha_ult_corte,
    @w_zona,
    @w_parroq,
    @w_oficina1,
    @w_cliente1,
    @w_numsol,
    @w_fideicomiso,
    @w_prod_banc,
    @w_tipocta

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
    @w_tdef_des = valor
  from   cobis..cl_catalogo
  where  tabla  = (select
                     cobis..cl_tabla.codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_tdefault')
     and codigo = @w_tipo_def

  if @w_tipo_def = 'P'
      or @w_tipo_def = 'E'
  begin
    select
      @w_pers_desc = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
    from   cobis..cl_ente
    where  en_ente = @w_default

    select
      @w_tipo_def,
      @w_tdef_des,
      @w_default,
      @w_pers_desc
  end
  else if @w_tipo_def = 'G'
  begin
    select
      @w_pers_desc = gr_nombre
    from   cobis..cl_grupo
    where  gr_grupo = @w_default

    select
      @w_tipo_def,
      @w_tdef_des,
      @w_default,
      @w_pers_desc
  end
  else if @w_tipo_def = 'C'
      or @w_tipo_def = 'D'
    select
      @w_tipo_def,
      @w_tdef_des,
      @w_default,
      @w_pers_desc

  select
    @w_rolente_des = valor
  from   cobis..cl_catalogo
  where  tabla  = (select
                     cobis..cl_tabla.codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_rol_ente')
     and codigo = @w_rol_ente

  select
    @w_rol_ente,
    @w_rolente_des

  select
    @w_mon_des = mo_descripcion
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda

  select
    @w_moneda,
    @w_mon_des

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
    @w_ciclo_des = valor
  from   cobis..cl_catalogo
  where  tabla  = (select
                     cobis..cl_tabla.codigo
                   from   cobis..cl_tabla
                   where  tabla = 'ah_ciclo')
     and codigo = @w_ciclo

  select
    @w_ciclo,
    @w_ciclo_des

  --Determinacion de la fecha de cierre de cuenta 

  select
    'FECHA CANCELACION' = convert(char(10), hc_fecha, @i_formato_fecha)
  from   cob_ahorros..ah_his_cierre
  where  hc_cuenta = @w_cuenta

  --Determinacuion de los bloqueos existentes para la cuenta

  select
    'DESCRIPCION BLOQUEO' = substring(A.valor,
                                      1,
                                      25),
    'CAUSA' = substring(B.valor,
                        1,
                        30),
    'USUARIO' = cb_autorizante,
    'FECHA' = convert(varchar(10), cb_fecha, @i_formato_fecha)
  from   cob_ahorros..ah_ctabloqueada,
         cobis..cl_catalogo A,
         cobis..cl_catalogo B
  where  cb_cuenta = @w_cuenta
     and A.codigo  = cb_tipo_bloqueo
     and A.tabla   = (select
                        cobis..cl_tabla.codigo
                      from   cobis..cl_tabla
                      where  tabla = 'ah_tbloqueo')
     and B.codigo  = cb_causa
     and B.tabla   = (select
                        cobis..cl_tabla.codigo
                      from   cobis..cl_tabla
                      where  tabla = 'ah_causa_bloqueo_mov')
     and cb_estado = 'V'

  --Presentar campo de Numero de libreta 

  select
    @w_numlib

  --Para obtener el valor del campo de personalizada 

  select
    @w_personalizada

  --Para verificar si la cuenta esta embargada
  if exists (select
               1
             from   cob_ahorros..ah_embargo
             where  he_cta_banco = @i_cta
                and he_fecha_lev is null)
    select
      @w_embargada = 'S'
  else
    select
      @w_embargada = 'N'

  select
    @w_embargada

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
    @w_alianza = al_alianza,
    @w_des_alianza = isnull((al_nemonico + ' - ' + al_nom_alianza),
                            '  ')
  from   cobis..cl_alianza_cliente with (nolock),
         cobis..cl_alianza with (nolock)
  where  ac_ente    = @w_cliente1
     and ac_alianza = al_alianza
     and al_estado  = 'V'
     and ac_estado  = 'V'

  select
    @w_alianza

  select
    @w_des_alianza

  return 0

go

