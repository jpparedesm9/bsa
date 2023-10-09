use cob_ahorros
go

/************************************************************************/
/*      Archivo:                up_ctahorro.sp                          */
/*      Stored procedure:       sp_up_ctahorro                          */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     10-Mar-1993                             */
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
/*      Este programa realiza la transaccion de actualizacion critica   */
/*      de los datos ingresados en apertura de cuentas de ahorros.      */
/*      202 = Actualizacion critica de cuentas de ahorros.              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10/Mar/1993     P. Mena        Emision inicial                 */
/*      14/Dic/1994     J. Bucheli     Personalizacion para Banco de   */
/*                                     la Produccion                   */
/*      30/Oct/1998     M. Sanguino    Parametro producto bancario     */
/*      20/Feb/1999     M. Sanguino    Personalizacion B. del Caribe   */
/*      25/Sep/1999     J. Cadena      Revision Banco del Caribe       */
/*      07/Abr/2005     L. Bernuil     Permitir Saldo Cero             */
/*      03/Ago/2005     L. Bernuil     Modificar campo Patente         */
/*      12/Jul/2006     R. Ramos       Adicion de fideicomiso          */
/*      16/Ago/2006     H. Ayarza      Direcciones con estado N        */
/*      30/Ago/2006     H. Ayarza      Pista del campo Estado Cta y    */
/*                                     Permite SldoCero.               */
/*      19/Oct/2006     P. Coello      Cuenta se modifica direcci½n de */
/*                                     entrega de estado de cuenta     */
/*                                     Actualizar tambien cabecera     */
/*                                     de estado de cuenta del mes actual   */
/*      17/Feb/2010     J. Loyo        Manejo de la fecha de efectivizacion */
/*                                     teniendo el sabado como habil    */
/*      02/Mayo/2016    Walther Toledo Migración a CEN                  */
/*      29/Sept/2016    Juan Tagle     Se agrega Cta Relacionada        */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_up_ctahorro')
  drop proc sp_up_ctahorro
go

create proc sp_up_ctahorro
(
  @s_ssn             int,
  @s_ssn_branch      int,
  @s_srv             varchar(30),
  @s_user            varchar(30),
  @s_sesn            int,
  @s_term            varchar(10),
  @s_date            datetime,
  @s_org             char(1),
  @s_ofi             smallint,/* Localidad origen transaccion */
  @s_rol             smallint = 1,
  @s_org_err         char(1) = null,/* Origen de error:[A], [S] */
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_msg             mensaje = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_rty             char(1) = 'N',
  @t_trn             smallint,
  @t_show_version    bit = 0,
  @i_cta             cuenta,
  @i_mon             tinyint,
  @i_nombre          descripcion,
  @i_nombre1         char(64),
  @i_cedruc1         char(13),
  @i_direc           tinyint,
  @i_prodbanc        smallint,
  @i_cli_ec          int,
  @i_ofl             smallint,
  @i_tprom           char(1),
  @i_ciclo           char(1),
  @i_categ           char(1),
  @i_capit           char(1),
  @i_pers            char(1) = 'N',
  @i_tipodir         char(1),
  @i_casillero       varchar(10) = null,
  @i_agencia         smallint = 11,
  @i_origen          varchar(3) = null,
  @i_numlib          int,
  @i_valor           money,
  @i_depini          tinyint,
  @i_cli1            int,
  @i_promotor        smallint= 0,
  @i_direc_dv        tinyint = null,
  @i_tipodir_dv      char(1) = null,
  @i_casillero_dv    varchar(10) = null,
  @i_agencia_dv      smallint = 0,
  @i_cli_dv          int,
  @i_tipocta_super   char(1) = 'P',
  @i_turno           smallint = null,
  @i_causa           char(1),
  @i_titularidad     char(1),-- AVI 8-Jun-2005 G.Bank
  @i_estado_cuenta   char(1) = 'N',
  @i_permite_sldcero char(1) = 'N',
  @i_patente         varchar(40),
  @i_fideicomiso     varchar(15) = null,--RRB
  @i_cta_banco_rel   cuenta = null,
  @o_oficina_cta     smallint out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_est              char(1),
    @w_cuenta           int,
    @w_cliente          int,
    @w_producto         tinyint,
    @w_filial           tinyint,
    @w_ced_ruc          numero,
    @w_nombre           descripcion,
    @w_nombre1          char(64),
    @w_cedruc1          char(13),
    @w_direccion_ec     tinyint,
    @w_prodbanc         smallint,
    @w_descdir_ec       direccion,
    @w_cliente_ec       int,
    @w_zona             smallint,
    @w_parroquia        int,
    @w_sector           smallint,
    @w_oficial          smallint,
    @w_tipo_promedio    char(1),
    @w_ciclo            char(1),
    @w_categoria        char(1),
    @w_capitalizacion   char(1),
    @w_tipodir          char(1),
    @o_fecha_prx_corte  varchar(10),
    @w_mes_sig          datetime,
    @w_mes_sigc         varchar(10),
    @w_prx_mes          varchar(10),
    @w_dia_pri          varchar(10),
    @w_ult_dia_mes      datetime,
    @w_ciudad_matriz    int,
    @w_dia_hoy          smallint,
    @w_fecha_prx_ec     datetime,
    @w_fecha_hoy        datetime,
    @w_dia_ciclo        varchar(2),
    @w_tmp              tinyint,
    @w_origen           varchar(3),
    @w_promotor         smallint,
    @v_nombre           descripcion,
    @v_nombre1          char(64),
    @v_cedruc1          char(13),
    @v_direccion_ec     tinyint,
    @v_descdir_ec       direccion,
    @v_cliente_ec       int,
    @v_zona             smallint,
    @v_parroquia        int,
    @v_sector           smallint,
    @v_oficial          smallint,
    @v_prodbanc         smallint,
    @v_tipo_promedio    char(1),
    @v_ciclo            char(1),
    @v_categoria        char(1),
    @v_capitalizacion   char(1),
    @v_origen           varchar(3),
    @w_funcionario      char(10),
    @w_funcio           char(1),
    @w_aux              char(10),
    @w_numlib           int,
    @w_valor            money,
    @w_oficina_cta      smallint,
    @w_tipo_ente        char(1),
    @w_direccion_dv     tinyint,
    @w_tipodir_dv       char(1),
    @w_zona_dv          smallint,
    @w_parroquia_dv     int,
    @w_descdir_dv       direccion,
    @v_direccion_dv     tinyint,
    @v_zona_dv          smallint,
    @v_parroquia_dv     int,
    @v_descdir_dv       direccion,
    @w_cliente_dv       int,
    @v_promotor         smallint,
    @v_tipocta_super    char(1),
    @w_tipocta_super    char(1),
    @w_meses_prx_capita integer,
    @w_fecha_prx_capita datetime,
    @v_fecha_prx_capita datetime,
    @w_ofi_cifrada      smallint,
    @w_oficina_social   tinyint,
    @w_levblo           char(1),
    @w_tipo_bloqueo     char(3),
    @w_secuencial       int,
    @w_mensaje          varchar(30),
    @w_titularidad      char(1),
    @w_patente          varchar(40),
    @w_fideicomiso      varchar(15),
    @v_fideicomiso      varchar(15),
    @w_msg              char(80),
    @w_estado_cuenta    char(1),
    @w_permite_sldcero  char(1),
    @v_estado_cuenta    char(1),
    @v_permite_sldcero  char(1),
    @w_fecha_ini        datetime,
    @w_oficina_reg      smallint,
	@v_cta_banco_rel    cuenta,
	@w_cta_banco_rel    cuenta

/* Observacion : Cuando se modifique la categoria, tambien se modificara
                 el tipo de interes, con el mismo valor */
  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_up_ctahorro'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_fecha_ini = convert(varchar, datepart(mm, @s_date)) + '/01/' + convert(
                                varchar, datepart(yy
                                , @s_date))

  if @i_turno is null
    select
      @i_turno = @s_rol

  --Modo de debug
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
      i_nombre = @i_nombre,
      i_nombre1 = @i_nombre1,
      i_cedruc1 = @i_cedruc1,
      i_direc = @i_direc,
      i_prodbanc = @i_prodbanc,
      i_cli_ec = @i_cli_ec,
      i_ofl = @i_ofl,
      i_tprom = @i_tprom,
      i_ciclo = @i_ciclo,
      i_categ = @i_categ,
      i_capit = @i_capit,
      i_casillero = @i_casillero,
      i_agencia = @i_agencia,
      i_tipodir = @i_tipodir,
      i_numlib = @i_numlib,
      i_cli1 = @i_cli1
    exec cobis..sp_end_debug
  end

  --Validacion del codigo de transaccion
  --Actualizacion critica de cuentas corrientes

  if @t_trn <> 202
  begin
    --Error en codigo de transaccion
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  --Variables de trabajo
  select
    @w_cuenta = ah_cuenta,
    @w_cliente = ah_cliente,
    @w_producto = ah_producto,
    @w_prodbanc = ah_prod_banc,
    @w_ced_ruc = ah_ced_ruc,
    @w_est = ah_estado,
    @w_nombre = ah_nombre,
    @w_direccion_ec = ah_direccion_ec,
    @w_descdir_ec = ah_descripcion_ec,
    @w_cliente_ec = ah_cliente_ec,
    @w_zona = ah_zona,
    @w_parroquia = ah_parroquia,
    @w_sector = ah_sector,
    @w_oficial = ah_oficial,
    @w_tipo_promedio = ah_tipo_promedio,
    @w_ciclo = ah_ciclo,
    @w_categoria = ah_categoria,
    @w_capitalizacion = ah_capitalizacion,
    @w_tipodir = ah_tipo_dir,
    @w_origen = ah_origen,
    @w_numlib = ah_numlib,
    @w_oficina_cta = ah_oficina,
    @w_nombre1 = ah_nombre1,
    @w_cedruc1 = ah_cedruc1,
    @w_tipo_ente = ah_tipocta,
    @w_promotor = ah_promotor,
    @w_tipodir_dv = ah_tipodir_dv,
    @w_direccion_dv = ah_direccion_dv,
    @w_descdir_dv = ah_descripcion_dv,
    @w_zona_dv = ah_zona_dv,
    @w_parroquia_dv = ah_parroquia_dv,
    @w_cliente_dv = ah_cliente_dv,
    @w_fecha_prx_capita = ah_fecha_prx_capita,
    @w_tipocta_super = ah_tipocta_super,
    @w_numlib = ah_numlib,
    @w_titularidad = ah_ctitularidad,-- AVI 8-Jun-2005 GBank
    @w_patente = ah_patente,
    @w_estado_cuenta = ah_estado_cuenta,
    @w_permite_sldcero = ah_permite_sldcero,
    @w_fideicomiso = ah_fideicomiso
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta

  --  and        ah_moneda    = @i_mon

  select
    @o_oficina_cta = @w_oficina_cta

  if @@rowcount <> 1
  begin
    --No existe cuenta_banco
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  select @w_cta_banco_rel = isnull(ca_cta_banco_rel,'')  -- cta donde iran los intereses por NC
  from   cob_ahorros..ah_cuenta_aux
  where  ca_cta_banco = @i_cta
 
  if @w_tipo_ente = 'I'
  begin
    select
      @w_ofi_cifrada = oc_oficina
    from   cob_ahorros..ah_oficina_ctas_cifradas
    where  oc_oficina = @s_ofi
       and oc_estado  = 'V'

    if @@rowcount = 0
    begin
      -- Oficina no autorizada para cuentas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251081
      return 251081
    end
  end

  -- VALIDACION PARA QUE LA CUENTA DE SERVICIO SOCIAL (origen = '9')
  -- SOLO SE ACTUALICE EN LA OFICINA MATRIZ

  select
    @w_oficina_social = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'OMAT'

  if @w_origen = '9'
     and @s_ofi <> @w_oficina_social
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251084
    return 251084
  end

  select
    @v_tipocta_super = @w_tipocta_super

  --Comparacion si el tipo de cuenta ha sido modificado

  if @w_tipocta_super = @i_tipocta_super
    select
      @w_tipocta_super = null,
      @v_tipocta_super = null
  else
    select
      @w_tipocta_super = @i_tipocta_super

  --Obtencion  de la filial

  select
    @w_filial = of_filial
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  select
    @w_fecha_hoy = @s_date

  select
    @w_dia_hoy = datepart(dd,
                          @w_fecha_hoy)

  --Obtencion de la ciudad de la oficina Matriz para el calculo de la fecha de proximo corte
/*** Se hace mediante el llamado al sp_fecha_habil  ***/
  --select @w_ciudad_matriz  = pa_int
  --from cobis..cl_parametro
  --where pa_producto = 'CTE'
  --and pa_nemonico = 'CMA'

  --Validacion del oficial de la cuenta de ahorros

  if @i_ofl = 0
  begin
    -- Oficial no puede ser cero
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101036
    return 1
  end

  if not exists (select
                   fu_funcionario
                 from   cobis..cl_funcionario,
                        cobis..cc_oficial
                 where  fu_funcionario = oc_funcionario
                    and oc_oficial     = @i_ofl)
  begin
    --No existe oficial
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101036
    return 1
  end

  -- Validacion del tipo de Promedion
  exec @w_return = cobis..sp_catalogo
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'ah_tpromedio',
    @i_operacion = 'E',
    @i_codigo    = @i_tprom

  if @w_return <> 0
  begin
    --No existe tipo de promedio
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201019
    return 1
  end

  --Validacion de la categoria

  exec @w_return = cobis..sp_catalogo
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'pe_categoria',
    @i_operacion = 'E',
    @i_codigo    = @i_categ

  if @w_return <> 0
  begin
    -- No existe categoria
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201018
    return 1
  end

  -- Validacion del tipo de capitalizacion

  exec @w_return = cobis..sp_catalogo
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'ah_capitalizacion',
    @i_operacion = 'E',
    @i_codigo    = @i_capit

  if @w_return <> 0
  begin
    -- No existe periodo de capitalizacion
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251009
    return 1
  end

  -- Validacion de que la cuenta se ecuentre activa
  if @w_est <> 'A'
  begin
    --Cuenta no activa o cancelada
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  -- Validacion de la regional
  select
    @w_oficina_reg = isnull(of_sucursal,
                            of_regional)
  from   cobis..cl_oficina
  where  of_oficina = @w_oficina_cta

  -- validacion que el producto bancario este definido para la cuenta
  if not exists (select distinct
                   pf_pro_final
                 from   cob_remesas..pe_pro_final,
                        cob_remesas..pe_mercado,
                        cob_remesas..pe_pro_bancario
                 where  pf_filial       = @w_filial
                    and pf_sucursal     = @w_oficina_reg
                    and pf_producto     = @w_producto
                    and pf_moneda       = @i_mon
                    and me_tipo_ente    = @w_tipo_ente
                    and pf_tipo         = 'R'
                    and me_mercado      = pf_mercado
                    and me_pro_bancario = pb_pro_bancario
                    and me_pro_bancario = @i_prodbanc)
    if @@rowcount <> 1
    begin
      /* Error Producto para tipo ente Titular  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201203
      return 1
    end

  /* Verificacion si modificaron el numero de libreta     EGA */

  if @i_numlib <> @w_numlib
    select
      @w_levblo = 'S'

  if @w_levblo = 'S'
     and @i_causa = 'A'
  begin
    --Determinacion de bloqueo de cuenta
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo,
      @w_secuencial = cb_secuencial
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and cb_tipo_bloqueo = '3'

    if @@rowcount = 0
    begin
      select
        @w_mensaje = 'Libreta no ha sido anulada: '

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 1
    end
  end

  --Si es canje de libreta no debe estar bloqueada movimientos   EGA
  if @w_levblo = 'S'
     and @i_causa = 'C'
  begin
    --Determinacion de bloqueo de cuenta
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and cb_tipo_bloqueo = '3'

    if @@rowcount <> 0
    begin
      select
        @w_mensaje = 'Libreta Bloqueada Dep/Retiro:'

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 1
    end
  end

  select
    @v_direccion_ec = @w_direccion_ec,
    @v_descdir_ec = @w_descdir_ec,
    @v_cliente_ec = @w_cliente_ec,
    @v_zona = @w_zona,
    @v_sector = @w_sector,
    @v_oficial = @w_oficial,
    @v_tipo_promedio = @w_tipo_promedio,
    @v_ciclo = @w_ciclo,
    @v_prodbanc = @w_prodbanc,
    @v_categoria = @w_categoria,
    @v_capitalizacion = @w_capitalizacion,
    @v_nombre1 = @w_nombre1,
    @v_cedruc1 = @w_cedruc1,
    @v_promotor = @w_promotor,
    @v_direccion_dv = @w_direccion_dv,
    @v_zona_dv = @w_zona_dv,
    @v_parroquia_dv = @w_parroquia_dv,
    @v_descdir_dv = @w_descdir_dv,
    @v_fecha_prx_capita = @w_fecha_prx_capita,
    @v_estado_cuenta = @w_estado_cuenta,
    @v_permite_sldcero = @w_permite_sldcero,
    @v_fideicomiso = @w_fideicomiso,
	@v_cta_banco_rel = @w_cta_banco_rel

  -- Actualizacion de los campos permisibles de actualizar
  if @w_nombre = @i_nombre
    select
      @w_nombre = null,
      @v_nombre = null
  else
    select
      @w_nombre = @i_nombre

  --Para Personalizacion Banco Caribe
  if @w_nombre1 = @i_nombre1
    select
      @w_nombre1 = '',
      @v_nombre1 = ''
  else
    select
      @w_nombre1 = @i_nombre1

  if @w_cedruc1 = @i_cedruc1
    select
      @w_cedruc1 = '',
      @v_cedruc1 = ''
  else
    select
      @w_cedruc1 = @i_cedruc1

  select
    @w_parroquia = 0,
    @w_zona = 0,
    @w_sector = 0

  if @i_tipodir = 'D'
  begin
    select
      @w_descdir_ec = di_descripcion,
      @w_parroquia = isnull(di_ciudad,
                            0)
    from   cobis..cl_direccion
    where  di_ente      = @i_cli_ec
       and di_direccion = @i_direc

    select
      @w_direccion_ec = @i_direc

  end

  if @i_tipodir = 'C'
  begin
    select
      @w_descdir_ec = cs_valor + ' | '
                      + (select
                           zp_descripcion
                         from   cobis..cl_codpos
                         where  zp_coddep  = x.cs_provincia
                            and zp_codzona = x.cs_emp_postal)
                      + ' | '
                      + (select
                           pv_descripcion
                         from   cobis..cl_provincia
                         where  pv_provincia = x.cs_provincia)
                      + ' | '
                      + (select
                           pa_descripcion
                         from   cobis..cl_provincia,
                                cobis..cl_pais
                         where  x.cs_provincia = pv_provincia
                            and pv_pais        = pa_pais),
      @w_parroquia = isnull(cs_ciudad,
                            0),
      @w_zona = cs_provincia
    from   cobis..cl_casilla x,
           cobis..cl_suc_correo
    where  cs_ente      = @i_cli_ec
       and cs_casilla   = @i_direc
       and cs_sucursal  = sc_sucursal
       and cs_provincia = sc_provincia
       and cs_provincia is not null

    if @@rowcount = 0
    begin
      select
        @w_descdir_ec = cs_valor + ' | '
                        + (select
                             zp_descripcion
                           from   cobis..cl_codpos
                           where  zp_coddep  = x.cs_provincia
                              and zp_codzona = x.cs_emp_postal)
                        + ' | '
                        + (select
                             pv_descripcion
                           from   cobis..cl_provincia
                           where  pv_provincia = x.cs_provincia)
                        + ' | '
                        + (select
                             pa_descripcion
                           from   cobis..cl_provincia,
                                  cobis..cl_pais
                           where  x.cs_provincia = pv_provincia
                              and pv_pais        = pa_pais),
        @w_parroquia = isnull(cs_ciudad,
                              0),
        @w_zona = isnull(cs_provincia,
                         0)
      from   cobis..cl_casilla x,
             cobis..cl_provincia
      where  cs_ente      = @i_cli_ec
         and cs_casilla   = @i_direc
         and cs_provincia = pv_provincia

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201098
        return 1
      end
    end

    select
      @w_direccion_ec = @i_direc
  end

  if @i_tipodir = 'R'
  begin
    select
      @w_descdir_ec = 'RETENCION EN ' + of_nombre
    from   cobis..cl_oficina
    where  of_filial  = @w_filial
       and of_oficina = @i_agencia

    select
      @i_cli_ec = 0,
      @i_direc = 0
    select
      @w_direccion_ec = @i_direc
  end

  if @i_tipodir = 'S'
  begin
    if @i_casillero is not null
      select
        @w_descdir_ec = 'CASILLERO # ' + @i_casillero

    select
      @i_cli_ec = 0,
      @i_direc = 0
    select
      @w_direccion_ec = @i_direc
  end

  if @i_tipodir = 'N' --HA20060816
  begin
    select
      @w_descdir_ec = 'NO IMPRIME ESTADO CUENTA'
    select
      @i_cli_ec = 0,
      @i_direc = 0
    select
      @w_direccion_ec = 0
  end

  --Direccion de  Cheques devueltos
  select
    @w_parroquia_dv = 0,
    @w_zona_dv = 0

  if @i_tipodir_dv = 'D'
  begin
    --COMENTA LHO 082307, en la insercion en sp_apertura_ah, la dir_dv no se obtiene de esta menera sino con los campos barrio, calle, casa y descripcion
  /*select @w_descdir_dv = di_descripcion,
         @w_parroquia_dv  = isnull(di_ciudad,0)
  from  cobis..cl_direccion
  where  di_ente = @i_cli_dv
  and  di_direccion = @i_direc_dv*/
    --LHO 082307
    select
      @w_descdir_dv = rtrim(ltrim(di_descripcion)),
      @w_parroquia_dv = isnull(di_ciudad,
                               0)
    from   cobis..cl_direccion
    where  di_ente      = @i_cli_dv
       and di_direccion = @i_direc_dv

    select
      @w_direccion_dv = @i_direc_dv

  end

  if @i_tipodir_dv = 'C'
  begin
    select
      @w_descdir_dv = cs_valor + ' | '
                      + (select
                           zp_descripcion
                         from   cobis..cl_codpos
                         where  zp_coddep  = x.cs_provincia
                            and zp_codzona = x.cs_emp_postal)
                      + ' | '
                      + (select
                           pv_descripcion
                         from   cobis..cl_provincia
                         where  pv_provincia = x.cs_provincia)
                      + ' | '
                      + (select
                           pa_descripcion
                         from   cobis..cl_provincia,
                                cobis..cl_pais
                         where  x.cs_provincia = pv_provincia
                            and pv_pais        = pa_pais),
      @w_parroquia_dv = isnull(cs_ciudad,
                               0),
      @w_zona_dv = cs_provincia
    from   cobis..cl_casilla x,
           cobis..cl_suc_correo
    where  cs_ente      = @i_cli_dv
       and cs_casilla   = @i_direc_dv
       and cs_sucursal  = sc_sucursal
       and cs_provincia = sc_provincia
       and cs_provincia is not null

    if @@rowcount = 0
    begin
      select
        @w_descdir_dv = cs_valor + ' | '
                        + (select
                             zp_descripcion
                           from   cobis..cl_codpos
                           where  zp_coddep  = x.cs_provincia
                              and zp_codzona = x.cs_emp_postal)
                        + ' | '
                        + (select
                             pv_descripcion
                           from   cobis..cl_provincia
                           where  pv_provincia = x.cs_provincia)
                        + ' | '
                        + (select
                             pa_descripcion
                           from   cobis..cl_provincia,
                                  cobis..cl_pais
                           where  x.cs_provincia = pv_provincia
                              and pv_pais        = pa_pais),
        @w_parroquia_dv = isnull(cs_ciudad,
                                 0),
        @w_zona_dv = isnull(cs_provincia,
                            0)
      from   cobis..cl_casilla x,
             cobis..cl_provincia
      where  cs_ente      = @i_cli_dv
         and cs_casilla   = @i_direc_dv
         and cs_provincia = pv_provincia

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201098
        return 1
      end
    end

    select
      @w_direccion_dv = @i_direc_dv

  end

  if @i_tipodir_dv = 'R'
  begin
    select
      @w_descdir_dv = 'RETENCION EN ' + of_nombre
    from   cobis..cl_oficina
    where  of_filial  = @w_filial
       and of_oficina = @i_agencia_dv

    select
      @i_cli_dv = 0,
      @i_direc_dv = 0
    select
      @w_direccion_dv = @i_direc_dv
  end

  if @i_tipodir_dv = 'S'
  begin
    if @i_casillero_dv is not null
      select
        @w_descdir_dv = 'CASILLERO # ' + @i_casillero_dv
    select
      @i_cli_dv = 0,
      @i_direc_dv = 0
    select
      @w_direccion_dv = @i_direc_dv
  end

  -- Calculo de la fecha del proximo corte de estado de cuenta
  if @i_ciclo = '3'
  begin
    select
      @w_mes_sig = dateadd(mm,
                           1,
                           @w_fecha_hoy)
    select
      @w_mes_sigc = convert(varchar(10), @w_mes_sig, 101)
    select
      @w_dia_pri = substring(@w_mes_sigc, 1, 3) + '01' + substring(@w_mes_sigc,
                   6,
                   5
                   )
    --       select  @w_ult_dia_mes = dateadd(dd,-1,convert(datetime,@w_dia_pri))

    --       while 1 = 1
    --       begin
    --           if exists (select 1 from cobis..cl_dias_feriados
    --                       where df_ciudad  = @w_ciudad_matriz
    --                         and df_fecha = @w_ult_dia_mes)
    --             select @w_ult_dia_mes = dateadd(dd, -1, @w_ult_dia_mes)
    --           else
    --             break
    --        end

    select
      @w_ult_dia_mes = convert(datetime, @w_dia_pri)

  /*** La determinacion del anterior dia laboral  se           ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif       = 'N',
      @i_efec_dia      = 'S',
      @i_fecha         = @w_ult_dia_mes,
      @i_oficina       = @s_ofi,
      @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
      @w_dias_ret      = -1,/*** Dia anterior habil          ***/
      @o_ciudad_matriz = @w_ciudad_matriz out,
      @o_fecha_sig     = @w_ult_dia_mes out

    if @w_return <> 0
      return @w_return

    select
      @o_fecha_prx_corte = convert(varchar(10), @w_ult_dia_mes, 101)

  end
  else
  begin
    select
      @w_dia_ciclo = substring(valor,
                               1,
                               2)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'cc_ciclo')
       and codigo = @i_ciclo

    select
      @w_tmp = convert(tinyint, @w_dia_ciclo)

    if @w_dia_hoy < @w_tmp
    begin
      select
        @w_prx_mes = convert(varchar(10), @w_fecha_hoy, 101)
      select
        @o_fecha_prx_corte =
        substring(@w_prx_mes, 1, 3) + @w_dia_ciclo + substring(
        @w_prx_mes, 6, 5)
    end
    else
    begin
      select
        @w_prx_mes = convert(varchar(10), dateadd(month,
                                                  1,
                                                  @w_fecha_hoy), 101)
      select
        @o_fecha_prx_corte = substring(@w_prx_mes, 1, 2) + '/' + @w_dia_ciclo +
                             '/'
                             +
                             substring(@w_prx_mes, 7
                             , 4)
    end

    select
      @w_fecha_prx_ec = convert(datetime, @o_fecha_prx_corte)

    --       while 1 = 1
    --         begin
    --           if exists (
    --                      select  * from    cobis..cl_dias_feriados
    --                       where  df_ciudad = @w_ciudad_matriz
    --                         and  df_fecha = @w_fecha_prx_ec)
    --             select @w_fecha_prx_ec = dateadd(dd,-1,@w_fecha_prx_ec)
    --           else
    --             break
    --        end

  /*** La determinacion del anterior dia laboral  se           ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif       = 'N',
      @i_efec_dia      = 'S',
      @i_fecha         = @w_fecha_prx_ec,
      @i_oficina       = @s_ofi,
      @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
      @w_dias_ret      = -1,/*** Dia anterior habil          ***/
      @o_ciudad_matriz = @w_ciudad_matriz out,
      @o_fecha_sig     = @w_fecha_prx_ec out

    if @w_return <> 0
      return @w_return

    select
      @o_fecha_prx_corte = convert(varchar(10), @w_fecha_prx_ec, 101)
  end

  /*   Campos no modificados graba null tran.servicio tipo 'A' actual  */
  if @w_oficial = @i_ofl
    select
      @w_oficial = null,
      @v_oficial = null
  else
    select
      @w_oficial = @i_ofl

  if @w_tipo_promedio = @i_tprom
    select
      @w_tipo_promedio = null,
      @v_tipo_promedio = null
  else
    select
      @w_tipo_promedio = @i_tprom

  if @w_ciclo = @i_ciclo
    select
      @w_ciclo = null,
      @v_ciclo = null
  else
    select
      @w_ciclo = @i_ciclo

  if @w_categoria = @i_categ
    select
      @w_categoria = null,
      @v_categoria = null
  else
    select
      @w_categoria = @i_categ

  if @w_capitalizacion = @i_capit
    select
      @w_capitalizacion = null,
      @v_capitalizacion = null
  else
  begin
    select
      @w_capitalizacion = @i_capit
    if @i_capit = 'D'
    begin
      select
        @w_fecha_prx_capita = dateadd(dd,
                                      1,
                                      @w_fecha_hoy)
      while 1 = 1
      begin
        if exists (select
                     1
                   from   cobis..cl_dias_feriados
                   where  df_ciudad = @w_ciudad_matriz
                      and df_fecha  = @w_ult_dia_mes)
          select
            @w_fecha_prx_capita = dateadd(dd,
                                          1,
                                          @w_ult_dia_mes)
        else
          break
      end
    end
    else
    begin
      if @i_capit = 'M'
        select
          @w_meses_prx_capita = datepart(mm,
                                         @w_fecha_hoy)
      if @i_capit = 'B'
        select
          @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 2) +
                                1
      if @i_capit = 'T'
        select
          @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 3) +
                                1
      if @i_capit = 'S'
        select
          @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 6) +
                                1

      select
        @w_ult_dia_mes = pe_fecha_fin
      from   cob_ahorros..ah_periodo
      where  pe_capitalizacion = @i_capit
         and pe_periodo        = @w_meses_prx_capita

      while 1 = 1
      begin
        if exists (select
                     1
                   from   cobis..cl_dias_feriados
                   where  df_ciudad = @w_ciudad_matriz
                      and df_fecha  = @w_ult_dia_mes)
          select
            @w_ult_dia_mes = dateadd(dd,
                                     -1,
                                     @w_ult_dia_mes)
        else
          break
      end
      select
        @w_fecha_prx_capita = @w_ult_dia_mes
    end
  end

  if @w_origen = @i_origen
    select
      @w_origen = null,
      @v_origen = null
  else
    select
      @w_origen = @i_origen

  --   if @w_prodbanc = @i_prodbanc
  --      select @w_prodbanc = null,
  --               @v_prodbanc = null
  --     else
  select
    @w_prodbanc = @i_prodbanc

  if @w_promotor = @i_promotor
    select
      @w_promotor = null,
      @v_promotor = null
  else
    select
      @w_promotor = @i_promotor

  if @w_fideicomiso = @i_fideicomiso
    select
      @w_fideicomiso = null,
      @v_fideicomiso = null
  else
  begin
    select
      @w_fideicomiso = @i_fideicomiso
    if exists (select
                 1
               from   cob_ahorros..ah_embargo
               where  he_cta_banco = @i_cta
                  and he_fecha_lev is null)
    begin
      select
        @w_msg = '[' + @w_sp_name + '] '
                 +
'EXISTE UN EMBARGO CON MONTO PENDIENTE, NO SE PUEDE MODIFICAR FIDEICOMISO'
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_msg   = @w_msg,
@i_num   = 201072
return 201072
end
end

  --INI-HA20060830
  if @w_estado_cuenta = @i_estado_cuenta
    select
      @w_estado_cuenta = null,
      @v_estado_cuenta = null
  else
    select
      @w_estado_cuenta = @i_estado_cuenta

  if @w_permite_sldcero = @i_permite_sldcero
    select
      @w_permite_sldcero = null,
      @v_permite_sldcero = null
  else
    select
      @w_permite_sldcero = @i_permite_sldcero
  --FIN-HA20060830

  /* Validacion que el cliente titular de la cuenta sea un funcionario */

  select
    @w_funcionario = en_tipo_vinculacion
  from   cobis..cl_ente
  where  en_ente = @w_cliente

  select
    @w_aux = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CFU'

  if @w_funcionario <> @w_aux
    select
      @w_funcio = 'N'
  else
  begin
    if (select
          count(1)
        from   cobis..cl_catalogo
        where  tabla in
               (select
                  codigo
                from   cobis..cl_tabla
                where  tabla = 'ah_producto_funcionario')
               and codigo = convert(varchar(10), @i_prodbanc)
               and estado = 'V') > 0
    begin
      select
        @w_funcio = 'S'
    end
    else
    begin
      select
        @w_funcio = 'N'
    end
  end

  -- Actualizacion de las tablas: ah_cuenta, ah_act_capitalizacion y cl_det_producto
  begin tran
  update cob_ahorros..ah_cuenta
  set    ah_nombre = @i_nombre,
         ah_direccion_ec = @i_direc,
         ah_descripcion_ec = @w_descdir_ec,
         ah_cliente_ec = @i_cli_ec,
         ah_zona = @w_zona,
         ah_sector = @w_sector,
         ah_parroquia = @w_parroquia,
         ah_oficial = @i_ofl,
         ah_tipo_promedio = @i_tprom,
         ah_ciclo = @i_ciclo,
         ah_prod_banc = @i_prodbanc,
         ah_categoria = @i_categ,
         ah_capitalizacion = @i_capit,
         ah_personalizada = @i_pers,
         ah_tipo_dir = @i_tipodir,
         ah_agen_ec = @i_agencia,
         ah_fecha_prx_corte = @o_fecha_prx_corte,
         ah_cta_funcionario = @w_funcio,
         ah_origen = @i_origen,
         ah_dep_ini = @i_depini,
         ah_numlib = @i_numlib,
         ah_nombre1 = @i_nombre1,
         ah_cedruc1 = @i_cedruc1,
         ah_cliente1 = @i_cli1,
         ah_promotor = @i_promotor,
         ah_direccion_dv = @i_direc_dv,
         ah_tipodir_dv = @i_tipodir_dv,
         ah_descripcion_dv = @w_descdir_dv,
         ah_zona_dv = @w_zona_dv,
         ah_parroquia_dv = @w_parroquia_dv,
         ah_cliente_dv = @i_cli_dv,
         ah_agen_dv = @i_agencia_dv,
         ah_fecha_prx_capita = @w_fecha_prx_capita,
         ah_tipocta_super = @i_tipocta_super,
         ah_estado_cuenta = @i_estado_cuenta,
         ah_permite_sldcero = @i_permite_sldcero,
         ah_ctitularidad = @i_titularidad,-- AVI 8-Jun-2005 GBank
         ah_patente = @i_patente,
         ah_fideicomiso = @i_fideicomiso
  where  ah_cuenta = @w_cuenta

  if @@rowcount <> 1
  begin
    --Error en actualizacion de registro en ah_cuenta
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 1
  end

  -- Busqueda de valores para ah_cuenta_aux
  -- Si producto bancario es de aporte social adicional
  if (@i_prodbanc in (select pa_int from   cobis..cl_parametro where  pa_producto = 'AHO' and  pa_nemonico = 'PCAASA' ))
  begin
  	-- guardar cta_banco_rel
  	select @w_cta_banco_rel = @i_cta_banco_rel
  
  	update cob_ahorros..ah_cuenta_aux
  	set ca_cta_banco_rel = @w_cta_banco_rel
  	where  ca_cuenta = @w_cuenta
  	
    if @@rowcount <> 1
    begin
  	  /* Error en creacion de registro en ah_cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253001
      return 1
    end     
  end	
	
  /* Si existe un registro en ah_act_capitalizacion, se lo actualiza; caso
     contrario se lo inserta. Esta tabla sirve para actualizar los periodos
     de capitalizacion. Posteriormente sera leida por un proceso batch */

  if exists (select
               ac_capitalizacion
             from   cob_ahorros..ah_act_capitalizacion
             where  ac_cta_banco = @i_cta)
  begin
    update cob_ahorros..ah_act_capitalizacion
    set    ac_capitalizacion = @i_capit
    where  ac_cta_banco = @i_cta

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en ah_act_capitalizacion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255007
      return 1
    end
  end
  else
  begin
    insert into cob_ahorros..ah_act_capitalizacion
                (ac_cta_banco,ac_capitalizacion)
    values      (@i_cta,@i_capit)

    if @@error <> 0
    begin
      /* Error en insercion de tabla actualiza capitalizacion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253005
      return 1
    end
  end

  update cobis..cl_det_producto
  set    dp_oficial_cta = @i_ofl,
         dp_direccion_ec = @i_direc,
         dp_descripcion_ec = @w_descdir_ec,
         --dp_sub_tipo       = @i_prodbanc,
         dp_monto = @i_valor
  where  dp_cuenta   = @i_cta
     and dp_producto = 4

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en cl_det_producto */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105050
    return 1
  end

  update ah_estado_cta
  set    ec_direccion_ec = @i_direc,
         ec_descripcion_ec = @w_descdir_ec,
         ec_zona = @w_zona,
         ec_parroquia = @w_parroquia,
         ec_sector = @w_sector,
         ec_tipo_dir = @i_tipodir
  where  ec_cta_banco = @i_cta
     and ec_fecha_prx_corte between @w_fecha_ini and @s_date

  if @@error <> 0
  begin
    /* Error en actualizacion de cabecera de estado de cuenta */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 205033
    return 1
  end

/* Creacion de transaccion de servicio */
  /* Registro Previo */
  insert into cob_ahorros..ah_tsapertura
              (secuencial,ssn_branch,alterno,tipo_transaccion,oficina,
               usuario,terminal,reentry,clase,tsfecha,
               cta_banco,filial,oficial,origen,moneda,
               cliente,ced_ruc,estado,cliente_ec,direccion_ec,
               ciclo,categoria,producto,tipo_promedio,tipo_interes,
               descripcion_ec,capitalizacion,origen_cta,numlib,monto,
               cuenta,oficina_cta,nombre1,cedula1,prod_banc,
               promotor,tipocta_super,turno,accion,tipo,
               estado_cta,permite_sldcero,fideicomiso,
			   cta_relacionada)
  values      (@s_ssn,@s_ssn_branch,20,@t_trn,@s_ofi,
               @s_user,@s_term,@t_rty,'P',@s_date,
               @i_cta,@w_filial,@v_oficial,@s_org,@i_mon,
               @w_cliente,@w_ced_ruc,'A',@v_cliente_ec,@v_direccion_ec,
               @v_ciclo,@v_categoria,@w_producto,@v_tipo_promedio,@w_categoria,
               @v_descdir_ec,@v_capitalizacion,@v_origen,@w_numlib,@w_valor,
               @w_cuenta,@w_oficina_cta,@v_nombre1,@v_cedruc1,@v_prodbanc,
               @v_promotor,@v_tipocta_super,@i_turno,@i_causa,@i_titularidad,
               @v_estado_cuenta,@v_permite_sldcero,@v_fideicomiso,
			   @v_cta_banco_rel)
  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  /* Registro Actual */
  insert into cob_ahorros..ah_tsapertura
              (secuencial,ssn_branch,alterno,tipo_transaccion,oficina,
               usuario,terminal,reentry,clase,tsfecha,
               cta_banco,filial,oficial,origen,moneda,
               cliente,ced_ruc,estado,cliente_ec,direccion_ec,
               ciclo,categoria,producto,tipo_promedio,descripcion_ec,
               capitalizacion,origen_cta,numlib,monto,cuenta,
               oficina_cta,nombre1,cedula1,prod_banc,promotor,
               tipocta_super,turno,accion,tipo,estado_cta,
               permite_sldcero,fideicomiso,
			   cta_relacionada)
  values      (@s_ssn,@s_ssn_branch,30,@t_trn,@s_ofi,
               @s_user,@s_term,@t_rty,'A',@s_date,
               @i_cta,@w_filial,@w_oficial,@s_org,@i_mon,
               @w_cliente,@w_ced_ruc,'A',@w_cliente_ec,@w_direccion_ec,
               @w_ciclo,@w_categoria,@w_producto,@w_tipo_promedio,@w_descdir_ec,
               @w_capitalizacion,@w_origen,@i_numlib,@i_valor,@w_cuenta,
               @w_oficina_cta,@w_nombre1,@w_cedruc1,@w_prodbanc,@w_promotor,
               @w_tipocta_super,@i_turno,@i_causa,@i_titularidad,
               @w_estado_cuenta,
               @w_permite_sldcero,@w_fideicomiso,
			   @w_cta_banco_rel)
  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  select
    @o_fecha_prx_corte

  commit tran

go

