/********************************************************************/
/*  Archivo:                nav_ah_cierre.sp                        */
/*  Stored procedure:       sp_nav_ah_cierre                        */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*  Fecha de escritura:     18-Feb-1993                             */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa realiza la transaccion de cierre de cuentas       */
/*  de ahorros navidad.                                             */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA           AUTOR           RAZON                           */
/*  08/Jul/2003                     Emision inicial BDF             */
/*  04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_nav_ah_cierre')
  drop proc sp_nav_ah_cierre
go

/****** Object:  StoredProcedure [dbo].[sp_nav_ah_cierre]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_nav_ah_cierre
(
  @s_ssn                  int,
  @s_srv                  varchar(30) = null,
  @s_user                 varchar(30) = null,
  @s_sesn                 int,
  @s_term                 varchar(10),
  @s_date                 datetime,
  @s_org                  char(1),
  @s_ofi                  smallint = 1,
  @s_rol                  smallint = 1,
  @s_ssn_branch           int=null,
  @t_debug                char(1) = 'N',
  @t_file                 varchar(14) = null,
  @t_from                 varchar(32) = null,
  @t_rty                  char(1) = 'N',
  @t_trn                  smallint,
  @t_ejec                 char(1) = null,
  @t_corr                 char(1) = 'N',
  @t_ssn_corr             int = null,
  @t_show_version         bit = 0,
  @p_rssn_corr            int = null,
  @p_lssn                 int = null,
  @i_oficina              smallint = 1,
  @i_cta                  cuenta,
  @i_mon                  tinyint,
  @i_sldlib               money = 0,
  @i_val                  money,
  @i_nctrl                smallint = 0,
  @i_orden                char(1) = '1',
  @i_causa                char(3) = '1',--Por solicitud del cliente
  @i_aut                  descripcion = null,
  @i_turno                smallint = null,
  @i_filial               tinyint = 1,
  @i_opcion               char(1),

  --Q consulta saldo de cancelacion  --C cancelacion  
  @i_sld_caja             money = 0,
  @i_idcierre             int = 0,
  @i_idcaja               int = 0,
  @i_canal                smallint = 4,
  @o_sldcont              money = null out,
  @o_slddisp              money = null out,
  @o_sldint               money = null out,
  @o_control              int = null out,
  @o_nombre               varchar(30) = null out,
  @o_int_cap              money = null out,
  @o_impuesto             money = null out,
  @o_multa                money = null out,
  @o_prod_banc            smallint = null out,
  @o_categoria            char(1) = null out,
  @o_monto_imp            money = null out,
  @o_monto_imp_ret        money = null out,
  @o_tipo_exoneracion_imp char(2) = null out,
  @o_tipocta_super        char(1) = null out,
  @o_sldmantval           money = 0 out --Saldo por Mantenimiento de valor
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_date        varchar(10),
    @w_cuenta      int,
    @w_oficina_cta int,
    @w_comentario  descripcion,
    @w_retiro      money,
    @w_factor      int,
    @w_signo       char(1),
    @w_oficina_p   smallint,
    @w_monto_imp   money

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_nav_ah_cierre'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
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

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Valida si se ha aperturado caja */
  if @s_org = 'U'
  begin
    if @i_idcaja = 0 -- Version ATX --
    begin
      if not exists (select
                       1
                     from   cob_remesas..re_caja
                     where  cj_oficina     = @s_ofi
                        and cj_rol         = @s_rol
                        and cj_operador    = @s_user
                        and cj_moneda      = @i_mon
                        and cj_transaccion = 15)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201063
        return 1
      end

    end
    else -- Version Branch Explorer --
    begin
      exec @w_return= cob_remesas..sp_verifica_caja
        @t_trn    = 213,
        @i_user   = @s_user,
        @i_ofi    = @s_ofi,
        @i_srv    = @s_srv,
        @i_date   = @s_date,
        @i_filial = @i_filial,
        @i_mon    = @i_mon,
        @i_idcaja = @i_idcaja

      if @w_return <> 0
        return @w_return

    end
  end

  if @i_opcion = 'Q' --- Consulta de saldo
  begin
    exec @w_return = sp_cons_cierre_ah
      @s_ssn    = @s_ssn,
      @s_srv    = @s_srv,
      @s_user   = @s_user,
      @s_sesn   = @s_sesn,
      @s_term   = @s_term,
      @s_date   = @s_date,
      @s_org    = @s_org,
      @s_ofi    = @s_ofi,
      @s_rol    = @s_rol,
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @t_from,
      @t_rty    = @t_rty,
      @t_trn    = 214,
      @i_filial = @i_filial,
      @i_oficina= @i_oficina,
      @i_cta    = @i_cta,
      @i_mon    = @i_mon,
      @o_retiro = @w_retiro out
    if @w_return <> 0
      return @w_return

    if @t_ejec = 'R'
    begin
      select
        'results_submit_rpc',
        r_sld_disp = @w_retiro

      exec cob_remesas..sp_resultados_branch_caja
        @i_sldcaja  = @i_sld_caja,
        @i_idcierre = @i_idcierre,
        @i_ssn_host = @s_ssn
    end
  end
  else if @i_opcion = 'C' --Cancelacion 
  begin
    begin tran

    --Levanta bloqueo contra debitos

    exec @w_return = sp_bloqueo_mov_ah
      @s_ssn         = @s_ssn,
      @s_ssn_branch  = @s_ssn_branch,
      @s_srv         = @s_srv,
      @s_user        = @s_user,
      @s_sesn        = @s_sesn,
      @s_term        = @s_term,
      @s_date        = @s_date,
      @s_ofi         = @s_ofi,
      @s_rol         = @s_rol,
      @s_org         = @s_org,
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @t_from,
      @t_trn         = 212,
      @i_cta         = @i_cta,
      @i_mon         = @i_mon,
      @i_tbloq       = '2',--Bloqueo contra debitos
      @i_aut         = @s_user,
      @i_causa       = '7',--Orden de BDF
      @i_solicit     = 'BDF',
      @o_oficina_cta = @w_oficina_cta out,
      @i_observacion = @w_comentario,
      @i_turno       = @i_turno

    if @w_return <> 0
    begin
      rollback tran
      return @w_return
    end

    --Cancela la cuenta
    exec @w_return = sp_cierre_ctah
      @s_ssn                  = @s_ssn,
      @s_srv                  = @s_srv,
      @s_user                 = @s_user,
      @s_sesn                 = @s_sesn,
      @s_term                 = @s_term,
      @s_date                 = @s_date,
      @s_org                  = @s_org,
      @s_ofi                  = @s_ofi,/* Localidad origen transaccion */
      @s_rol                  = @s_rol,
      @s_ssn_branch           = @s_ssn_branch,
      @t_debug                = @t_debug,
      @t_file                 = @t_file,
      @t_from                 = @t_from,
      @t_rty                  = @t_rty,
      @t_trn                  = 213,
      @t_ejec                 = @t_ejec,
      @i_oficina              = @i_oficina,
      @i_cta                  = @i_cta,
      @i_mon                  = @i_mon,
      @i_sldlib               = @i_sldlib,
      @i_val                  = @i_val,
      @i_nctrl                = @i_nctrl,
      @i_orden                = @i_orden,
      @i_causa                = @i_causa,
      @i_aut                  = @s_user,
      @i_turno                = @i_turno,
      @i_filial               = @i_filial,
      @i_sld_caja             = @i_sld_caja,
      @i_idcierre             = @i_idcierre,
      @i_idcaja               = @i_idcaja,
      @i_canal                = @i_canal,
      @o_sldcont              = @o_sldcont out,
      @o_slddisp              = @o_slddisp out,
      @o_sldint               = @o_sldint out,
      @o_nombre               = @o_nombre out,
      @o_control              = @o_control out,
      @o_int_cap              = @o_int_cap out,
      @o_impuesto             = @o_impuesto out,
      @o_multa                = @o_multa out,
      @o_prod_banc            = @o_prod_banc out,
      @o_categoria            = @o_categoria out,
      @o_monto_imp            = @w_monto_imp out,
      @o_sldmantval           = @o_sldmantval out,
      @o_monto_imp_ret        = @o_monto_imp_ret out,
      @o_tipo_exoneracion_imp = @o_tipo_exoneracion_imp out,
      @o_tipocta_super        = @o_tipocta_super out

    if @w_return <> 0
    begin
      rollback tran
      return @w_return
    end

    if @s_org = 'S'
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
        @i_cta_banco  = @i_cta
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 1
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
        return 1
      end

      insert into cob_ahorros..ah_cierre
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,ret_efe,ret_chq,remoto_ssn,
                   moneda,saldo_lib,control,signo,saldocont,
                   saldodisp,saldoint,impuesto,multa,oficina_cta,
                   alterno,prod_banc,categoria,monto_imp,tipo_exoneracion,
                   ssn_branch,tipocta_super,turno,hora,canal)
      values      (@s_ssn,213,@s_ofi,@s_user,@s_term,
                   @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                   @s_date,@i_cta,@i_val,null,@p_lssn,
                   @i_mon,@i_sldlib,@o_control,@w_signo,@o_sldcont,
                   @o_slddisp,@o_sldint,@o_impuesto,@o_multa,@w_oficina_cta,
                   3,@o_prod_banc,@o_categoria,@o_monto_imp_ret,
                   @o_tipo_exoneracion_imp,
                   @s_ssn_branch,@o_tipocta_super,@i_turno,getdate(),@i_canal)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 1
      end
    end
    else if @s_org = 'U'
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
        @i_cta_banco  = @i_cta
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 1
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
        return 1
      end

      insert into cob_ahorros..ah_cierre
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,ret_efe,ret_chq,remoto_ssn,
                   moneda,saldo_lib,control,signo,saldocont,
                   saldodisp,saldoint,impuesto,multa,oficina_cta,
                   alterno,prod_banc,categoria,monto_imp,tipo_exoneracion,
                   ssn_branch,tipocta_super,turno,hora,canal)
      values      (@s_ssn,213,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@s_srv,
                   @s_date,@i_cta,@i_val,null,@p_lssn,
                   @i_mon,@i_sldlib,@o_control,@w_signo,@o_sldcont,
                   @o_slddisp,@o_sldint,@o_impuesto,@o_multa,@w_oficina_cta,
                   3,@o_prod_banc,@o_categoria,@o_monto_imp_ret,
                   @o_tipo_exoneracion_imp,
                   @s_ssn_branch,@o_tipocta_super,@i_turno,getdate(),@i_canal)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 1
      end
    end

    if @t_ejec = 'R'
    begin
      select
        'results_submit_rpc',
        r_nombre = @o_nombre,
        r_sld_int = @o_sldint,
        r_sld_mantval = @o_sldmantval,
        r_multa = @o_multa,
        r_sld_disp = @o_slddisp

      exec cob_remesas..sp_resultados_branch_caja
        @i_sldcaja  = @i_sld_caja,
        @i_idcierre = @i_idcierre,
        @i_ssn_host = @s_ssn

    end

    commit tran
  end
  return 0

go

