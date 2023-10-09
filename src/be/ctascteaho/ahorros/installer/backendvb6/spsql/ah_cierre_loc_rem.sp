/************************************************************************/
/*  Archivo:            ah_cierre_loc_rem.sp                            */
/*  Stored procedure:   sp_ah_cierre_loc_rem                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 25-Feb-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de:                         */
/*      Cierre de cuenta local como remoto.                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR          RAZON                                    */
/*  07/Jun/1994 J Navarrete    Emision inicial                          */
/*  2004/03/10  Carlos Cruz D. Se pasa la variable @i_minuta            */
/*  12/12/2006  R.Linares      se agrego @i_val_inac                    */
/*  19/MAR/2007 P. Coello      ENVIO DE PARAMETRO PARA INCIDAR          */
/*                             SI SE COBRA O NO LA MULTA POR CIE        */
/*                             RRE ANTICIPADO                           */
/*  24/Mar/2010 C. Munoz       Se agrega codigo beneficiario Bancamia 016*/
/*  02/May/2016 Ignacio Yupa   Migraci�n a CEN                          */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_cierre_loc_rem')
  drop proc sp_ah_cierre_loc_rem
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cierre_loc_rem
(
  @s_ssn                  int,
  @s_srv                  varchar(30),
  @s_lsrv                 varchar(30),
  @s_user                 varchar(30),
  @s_sesn                 int,
  @s_term                 varchar(10),
  @s_date                 datetime,
  @s_ofi                  smallint,/* Localidad origen transaccion */
  @s_rol                  smallint,
  @s_org                  char(1),
  @s_ssn_branch           int = null,  
  @t_corr                 char(1) = 'N',
  @t_ssn_corr             int = null,
  @t_ejec                 char(1) = null,-- ELI 28/11/2002
  @p_lssn                 int = null,
  @p_rssn_corr            int = null,
  @t_debug                char(1) = 'N',
  @t_file                 varchar(14) = null,
  @t_from                 varchar(32) = null,
  @t_rty                  char(1) = 'N',
  @t_trn                  int,
  @t_show_version         bit= 0,
  @i_cta                  cuenta,
  @i_val                  money,
  @i_sldlib               money,
  @i_oficina              smallint,
  @i_cau                  varchar(3),
  @i_ord                  char(1),
  @i_aut                  login,
  @i_nctrl                int,
  @i_mon                  tinyint,
  @i_turno                smallint = null,
  @i_sld_caja             money = 0,
  @i_idcierre             int = 0,
  @i_filial               smallint = 1,
  @i_idcaja               int = 0,
  @i_ctatrn               cuenta = null,--Nro de cuenta para la transf de cierre
  @i_producto             varchar(3) = null,
  -- Tipo de cuenta para la transf de cierre
  @i_tadmin               tinyint = 0,
  -- Diferencia el cierre desde caja o term adminis
  @i_fcancel              char(1) = null,
  --Forma de cancelación T=transferencia C=cheque
  @i_cobra                tinyint = 0,
  @i_minuta               varchar(30) = null,
  @i_observacion          varchar(120)= null,
  @i_observacion1         varchar(120)= null,
  @i_val_inac             char(1) = 'S',
  --PARA VALIDAR O NO LA INACTIVIDAD ROL 12122006
  @i_cobra_multa_ant      char(1) = 'S',
  --  PCO COBRAR MULTA POR CIERRE ANTICIPADO O NO
  @i_canal                smallint = 4,
  @i_codbene              int = null,
  @i_ejec_marca           char(1) = 'S',
  -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF     
  @i_gmf_reintegro        money = 0,
  @o_sldcont              money out,
  @o_slddisp              money out,
  @o_sldint               money out,
  @o_control              int out,
  @o_nombre               varchar(30) out,
  @o_cliente              int = null out,
  @o_int_cap              money out,
  @o_impuesto             money out,
  @o_multa                money out,
  @o_oficina_p            smallint out,
  @o_prod_banc            smallint = null out,
  @o_categoria            char(1) = null out,
  @o_monto_imp_ret        money = null out,
  @o_tipo_exoneracion_imp char(2) = null out,
  @o_tipocta_super        char(1) = null out,
  @o_clase_clte           char(1) = null out,
  @o_valir                money = null out,
  @o_int_perdido          money = null out,
  @o_gmf_valcie           money = null out,
  @o_gmf_reitengro_cie    money = null out
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(30),
    @w_oficial_nombre    varchar(30),
    @w_cuenta            int,
    @w_filial_p          tinyint,
    @w_oficina_p         smallint,
    @w_pide_aut          char(1),
    @w_factor            int,
    @w_tipo_promedio     char(1),
    @w_oficial           smallint,
    @w_signo             char(1),
    @w_monto_imp         money,
    @w_secuencial        int,
    @w_idlote            int,
    @w_val3              money,
    @w_indicador         tinyint,
    @w_gmf_valcie        money,
    @w_gmf_reitengro_cie money

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cierre_loc_rem'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      p_lssn = @p_lssn,
      t_corr = @t_corr,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_val = @i_val,
      i_sldlib = @i_sldlib,
      i_cau = @i_cau,
      i_ord = @i_ord,
      i_aut = @i_aut,
      i_nctrl = @i_nctrl,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'D'
  else
    select
      @w_factor = -1,
      @w_signo = 'C'

  if @i_turno is null --FES modificación por E:SP-TNG-03
    select
      @i_turno = @s_rol

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_cta,
    @i_moneda    = @i_mon,
    @i_val_inac  = @i_val_inac,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial_p out,
    @o_oficina   = @w_oficina_p out,
    @o_tpromedio = @w_tipo_promedio out,
    @o_oficial   = @w_oficial out
  if @w_return <> 0
    return @w_return

  select
    @o_oficina_p = @w_oficina_p

  begin tran
  exec @w_return = cob_ahorros..sp_cierre_ctah
    @s_ssn               = @s_ssn,
    @s_srv               = @s_srv,
    @s_user              = @s_user,
    @s_sesn              = @s_sesn,
    @s_term              = @s_term,
    @s_date              = @s_date,
    @s_org               = @s_org,
    @s_ofi               = @s_ofi,
    @s_rol               = @s_rol,
    @s_ssn_branch        = @s_ssn_branch,
    @t_debug             = @t_debug,
    @t_file              = @t_file,
    @t_from              = @w_sp_name,
    @t_rty               = @t_rty,
    @t_trn               = @t_trn,
    @t_ejec              = @t_ejec,-- ELI 28/11/2002 
    --@i_filial               = @w_filial_p,
    @i_oficina           = @w_oficina_p,
    @i_cta               = @i_cta,
    @i_val               = @i_val,
    @i_mon               = @i_mon,
    @i_sldlib            = @i_sldlib,
    @i_nctrl             = @i_nctrl,
    @i_causa             = @i_cau,
    @i_orden             = @i_ord,
    @i_aut               = @i_aut,
    @i_turno             = @i_turno,
    @i_filial            = @i_filial,
    @i_idcaja            = @i_idcaja,
    @i_idcierre          = @i_idcierre,
    @i_sld_caja          = @i_sld_caja,
    @i_ctatrn            = @i_ctatrn,
    @i_producto          = @i_producto,
    @i_tadmin            = @i_tadmin,
    @i_fcancel           = @i_fcancel,
    @i_cobra             = @i_cobra,
    @i_observacion       = @i_observacion,
    @i_observacion1      = @i_observacion1,
    @i_cobra_multa_ant   = @i_cobra_multa_ant,--PCOELLO MARZO DEL 2007
    @i_canal             = @i_canal,
    @i_codbene           = @i_codbene,
    @i_ejec_marca        = @i_ejec_marca,
    -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF 
    @i_gmf_reintegro     = @i_gmf_reintegro,
    @o_sldcont           = @o_sldcont out,
    @o_slddisp           = @o_slddisp out,
    @o_sldint            = @o_sldint out,
    @o_nombre            = @o_nombre out,
    @o_cliente           = @o_cliente out,
    @o_control           = @o_control out,
    @o_int_cap           = @o_int_cap out,
    @o_impuesto          = @o_impuesto out,
    @o_multa             = @o_multa out,
    @o_prod_banc         = @o_prod_banc out,
    @o_categoria         = @o_categoria out,
    @o_monto_imp         = @w_monto_imp out,
    @o_monto_imp_ret     = @o_monto_imp_ret out,
    --@o_tipo_exoneracion_imp = @o_tipo_exoneracion_imp out,
    @o_tipocta_super     = @o_tipocta_super out,
    @o_clase_clte        = @o_clase_clte out,
    @o_secuencial        = @w_secuencial out,
    @o_idlote            = @w_idlote out,
    @o_valir             = @o_valir out,
    @o_int_perdido       = @o_int_perdido out,
    @o_indicador         = @w_indicador out,
    @o_gmf_valcie        = @w_gmf_valcie out,
    @o_gmf_reitengro_cie = @w_gmf_reitengro_cie out
  if @w_return <> 0
    return @w_return

  if @s_org = 'S'
  begin
    if @i_tadmin = 0
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @i_oficina,
        @i_rol        = @i_turno,
        @i_user       = @s_srv,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'R',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @i_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja,
        @i_cta_banco  = @i_cta,
        @i_cau        = @i_cau
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end

  /*  Transaccion monetaria  */
    /* Inicio Cambios BRANCHII 02-jul-01*/

    if exists (select
                 1
               from   cob_ahorros..ah_cierre
               where  ssn_branch = @s_ssn_branch
                  and oficina    = @s_ofi
                  and @w_factor  = 1)
    begin
      /* Error en creacion de registro en ah_cierre */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251079
      return 251079
    end

    --print '@o_slddisp2: %1!',@o_slddisp
    --print '@o_multa2: %1!',@o_multa
    select
      @w_val3 = isnull(@i_val,
                       0) - isnull(@o_multa,
                                   0) - isnull(@o_valir,
                                               0)
    -- - isnull(@o_int_perdido,0) --PCOELLO NO SE RESTA EL INTERES NO CAPITALIZADO

    if @i_cobra = 0
    begin
      insert into cob_ahorros..ah_cierre
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,ret_efe,ret_chq,remoto_ssn,
                   moneda,saldo_lib,control,signo,saldocont,
                   saldodisp,saldoint,impuesto,--multa,
                   oficina_cta,alterno,
                   prod_banc,categoria,monto_imp,tipo_exoneracion,ssn_branch,
                   tipocta_super,turno,forma_pago,cheque,ctadestino,
                   serial,hora,canal,cliente,indicador,
                   base_gmf,clase_clte,causa)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                   @s_date,@i_cta,@i_val,null,@p_lssn,
                   @i_mon,@i_sldlib,@o_control,@w_signo,@o_sldcont,
                   @o_slddisp,@o_sldint,@o_impuesto,--@o_multa,
                   @w_oficina_p,6,
                   @o_prod_banc,@o_categoria,@o_monto_imp_ret,
                   @o_tipo_exoneracion_imp,
                   isnull(@s_ssn_branch,
                          @s_ssn),
                   @o_tipocta_super,@i_turno,isnull(@i_fcancel,
                          'E'),@w_secuencial,@i_ctatrn,
                   @i_minuta,getdate(),@i_canal,@o_cliente,@w_indicador,
                   @w_gmf_valcie,@o_clase_clte,@i_cau)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end
    end
  end
  else if @s_org = 'U'
  begin
    if @i_tadmin = 0
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @i_turno,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'L',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @i_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja,
        @i_cta_banco  = @i_cta,
        @i_cau        = @i_cau
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 1
      end
    end

  /*  Transaccion monetaria  */
    /* Inicio Cambios BRANCHII 02-jul-01 */

    if exists (select
                 1
               from   cob_ahorros..ah_cierre
               where  ssn_branch = @s_ssn_branch
                  and oficina    = @s_ofi
                  and @w_factor  = 1)
    begin
      /* Error en creacion de registro en ah_cierre */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251079
      return 251079
    end

    --print '@o_slddisp3: %1!',@o_slddisp
    --print '@o_multa3: %1!',@o_multa
    --select @w_val3 = isnull(@i_val,0) - isnull(@o_multa,0) - isnull(@o_valir,0) -- - isnull(@o_int_perdido,0) --PCOELLO NO SE RESTA EL INTERES NO CAPITALIZADO
    select
      @w_val3 = isnull(@i_val,
                       0) - isnull(@o_valir,
                                   0)
    -- - isnull(@o_int_perdido,0) --PCOELLO YA NO ES NECESARIO RESTAR LA MULTA

    if @i_cobra = 0
    begin
      insert into cob_ahorros..ah_cierre
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,ret_efe,ret_chq,remoto_ssn,
                   moneda,saldo_lib,control,signo,saldocont,
                   saldodisp,saldoint,impuesto,--multa,
                   oficina_cta,alterno,
                   prod_banc,categoria,monto_imp,tipo_exoneracion,ssn_branch,
                   tipocta_super,turno,forma_pago,cheque,ctadestino,
                   serial,hora,canal,cliente,indicador,
                   base_gmf,clase_clte,causa)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@s_srv,
                   @s_date,@i_cta,@w_val3,null,@p_lssn,
                   @i_mon,@i_sldlib,@o_control,@w_signo,@o_sldcont,
                   @o_slddisp,@o_sldint,@o_impuesto,--@o_multa,
                   @w_oficina_p,6,
                   @o_prod_banc,@o_categoria,@o_monto_imp_ret,
                   @o_tipo_exoneracion_imp,
                   isnull(@s_ssn_branch,
                          @s_ssn),
                   @o_tipocta_super,@i_turno,isnull(@i_fcancel,
                          'E'),@w_secuencial,@i_ctatrn,
                   @i_minuta,getdate(),@i_canal,@o_cliente,@w_indicador,
                   @w_gmf_valcie,@o_clase_clte,@i_cau)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end
    end
    select
      @o_nombre
    select
      @o_cliente
    select
      @o_control
    select
      @o_int_cap
    select
      @o_sldint
    select
      @o_impuesto
    select
      @o_multa
    select
      @o_oficina_p
    select
      @w_monto_imp
  end
  commit tran
  return 0

go

