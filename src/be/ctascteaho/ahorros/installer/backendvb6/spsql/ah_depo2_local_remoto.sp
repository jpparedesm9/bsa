/************************************************************************/
/*  Archivo:            ah_depo2_local_remoto.sp                        */
/*  Stored procedure:   sp_ah_depo2_local_remoto                        */
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
/*      Deposito completo tanto local como remoto.                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Feb/1993 J. Navarrete    Emision inicial                         */
/*  18/Oct/1996 J. Cadena       Reversos: Bco. de Prestamos             */
/*  12/Sep/2000 Y. Rivero       Requerimiento de los Totales de         */
/*                              cajero (optimizacion de los re--        */
/*                              portes de TOTALES DE OPERADOR           */
/*                              (ATX) y TOTALES DE OFICINA (TA)         */
/*  03/Oct/2000 X. Gellibert    Optimizaciones                          */
/*  20/Jun/2001 R. Penarreta    Branch II                               */
/*  14/nov/2002 Edison Lincango Branch Explorer                         */
/*  2004/04/22  Carlos Cruz D.  Manejo del modo masivo en BDF           */
/*  18/Mar/2005 L.Bernuil       Agregar campo @i_cau al llamar          */
/*                              al sp_deposito_ncredito                 */
/*  02/May/2016 Ignacio Yupa    Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depo2_local_remoto')
  drop proc sp_ah_depo2_local_remoto
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depo2_local_remoto
(
  @s_ssn           int,
  @s_ssn_branch    int = null,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @p_lssn          int = null,  
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @p_rssn_corr     int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @s_org           char(1),
  @t_trn           int,
  @t_ejec          char(1) = null,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_sldlib        money,
  @i_ind           tinyint,
  @i_cau           char(3),
  @i_dep           smallint,
  @i_credit        money,
  @i_nctrl         int,
  @i_mon           tinyint,
  @i_oficina       smallint,
  @i_sp            char(1) = 'N',
  @i_concep        varchar(30) = null,
  @i_ncontrol      int,
  @i_lpend         int,
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,-- ELI 14/11/2002 
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,-- FIN ELI 14/11/2002 

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_estado_masivo int = 0,--CCR MODO MASIVO
  @i_prop_masivo   money = 0,--CCR MODO MASIVO
  @i_val_masivo    money = 0,--CCR MODO MASIVO
  @i_usateller     char(1) ='N',
  @i_canal         smallint = 4,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_control       int out,
  @o_nombre        varchar(50) out,
  @o_cliente       int = null out,
  @o_patente       varchar(40) = null out,
  @o_int_cap       money out,
  @o_lineas        int out,
  @o_usa           char(1) out,
  @o_sldlib        money out,
  @o_nctrl         smallint out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_tipocta_super char(1) out
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_oficial_nombre varchar(30),
    @w_cuenta         int,
    @w_filial_p       tinyint,
    @w_oficina_p      smallint,
    @w_pide_aut       char(1),
    @w_factor         int,
    @w_tipo_promedio  char(1),
    @w_oficial        smallint,
    @w_signo          char(1),
    @w_efe            money,
    @w_prop           money,
    @w_loc            money,
    @w_sldlib         money,
    @w_rem            money,
    @w_estado         char(1),
    @w_tran_especial  int,
    @w_prop_masivo    money,--CCR MODO MASIVO
    @w_val_masivo     money --CCR MODO MASIVO

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depo2_local_remoto'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C'
  else
    select
      @w_factor = -1,
      @w_signo = 'D'

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @i_cta_banco    = @i_cta,
    @i_moneda       = @i_mon,
    @o_cuenta       = @w_cuenta out,
    @o_filial       = @w_filial_p out,
    @o_oficina      = @w_oficina_p out,
    @o_tipo_promedio= @w_tipo_promedio out,
    @o_oficial      = @w_oficial out
  if @w_return <> 0
    return @w_return

  select
    @o_oficina_cta = @w_oficina_p

  /*  Deposito completo */

  if @w_factor = -1
  begin
    if @t_trn = 251
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     where  tm_moneda        = @i_mon
                        and tm_valor         = @i_efe
                        and tm_estado is null
                        and tm_ssn_branch    = @t_ssn_corr
                        and tm_oficina       = @s_ofi
                        and tm_tipo_tran     = @t_trn
                        and tm_cta_banco     = @i_cta
                        and tm_chq_propios   = @i_prop
                        and tm_chq_locales   = @i_loc
                        and tm_chq_ot_plazas = @i_plaz
                        --and tm_saldo_lib    = @i_sldlib
                        and tm_usuario       = @s_user)
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    if @t_trn = 255
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     where  tm_moneda       = @i_mon
                        and tm_valor        = @i_credit
                        and tm_estado is null
                        and tm_ssn_branch   = @t_ssn_corr
                        and tm_oficina      = @s_ofi
                        and tm_cta_banco    = @i_cta
                        and tm_saldo_lib    = @i_sldlib
                        and tm_indicador    = @i_ind
                        and tm_causa        = @i_cau
                        and tm_departamento = @i_dep
                        and tm_concepto     = @i_concep
                        and tm_usuario      = @s_user)
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
  end

  begin tran

  exec @w_return = cob_ahorros..sp_deposito_ncredito
    @s_ssn          = @s_ssn,
    @s_ssn_branch   = @s_ssn_branch,
    @s_srv          = @s_srv,
    @s_lsrv         = @s_lsrv,
    @s_user         = @s_user,
    @s_sesn         = @s_sesn,
    @s_term         = @s_term,
    @s_ofi          = @s_ofi,
    @s_rol          = @s_rol,
    @s_org          = @s_org,
    @s_date         = @s_date,
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @t_trn          = @t_trn,
    @t_ejec         = @t_ejec,
    @t_corr         = @t_corr,
    @t_ssn_corr     = @t_ssn_corr,
    @i_cuenta       = @w_cuenta,
    @i_efe          = @i_efe,
    @i_prop         = @i_prop,
    @i_loc          = @i_loc,
    @i_plaz         = @i_plaz,
    @i_mon          = @i_mon,
    @i_sldlib       = @i_sldlib,
    @i_nctrl        = @i_nctrl,
    @i_credit       = @i_credit,
    @i_ind          = @i_ind,
    @i_dep          = @i_dep,
    @i_factor       = @w_factor,
    @i_fecha        = @s_date,
    @i_ncontrol     = @i_ncontrol,
    @i_lpend        = @i_lpend,
    --CCR BRANCH III
    @i_fecha_valor_a= @i_fecha_valor_a,
    @i_usateller    = @i_usateller,
    @i_cau          = @i_cau,
    @o_sldcont      = @o_sldcont out,
    @o_slddisp      = @o_slddisp out,
    @o_nombre       = @o_nombre out,
    @o_patente      = @o_patente out,
    @o_control      = @o_control out,
    @o_int_cap      = @o_int_cap out,
    @o_lineas       = @o_lineas out,
    @o_usa          = @o_usa out,
    @o_sldlib       = @w_sldlib out,
    @o_nctrl        = @o_nctrl out,
    @o_prod_banc    = @o_prod_banc out,
    @o_categoria    = @o_categoria out,
    @o_clase_clte   = @o_clase_clte out,
    @o_tipocta_super= @o_tipocta_super out

  select
    @o_sldlib = @w_sldlib

  if @i_usateller = 'N'
  begin
    if @w_return = 2
    begin
      commit tran --OJO
      return @w_return
    end
  end

  if @w_return <> 0
    return @w_return

  if @w_factor = -1
    select
      @w_estado = 'R'

  select
    @w_efe = 0,
    @w_prop = 0,
    @w_loc = 0,
    @w_rem = 0

  /* Buscar si existe transaccion especial */
  select
    @w_tran_especial = te_tran_final
  from   cob_remesas..re_tran_especiales
  where  te_tran_original = @t_trn
     and te_causas        = @i_cau

  if @@rowcount = 0
    select
      @w_tran_especial = @t_trn

  if @s_org = 'S'
  begin
    if @t_trn = 251
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
        @i_ofi          = @i_oficina,
        @i_rol          = @i_turno,
        @i_user         = @s_srv,
        @i_mon          = @i_mon,
        @i_trn          = @t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'R',
        @i_corr         = @t_corr,
        @i_efectivo     = @i_efe,
        @i_cheque       = @i_prop,
        @i_chq_locales  = @i_loc,
        @i_chq_ot_plaza = @i_plaz,
        @i_ssn          = @s_ssn,
        @i_cta_banco    = @i_cta,
        @i_filial       = @i_filial,-- ELI 14/11/2002
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002

      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_deposito
                  (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,efectivo,propios,
                   locales,ot_plazas,remoto_ssn,moneda,interes,
                   saldo_lib,control,fecha_efec,signo,saldocont,
                   saldodisp,saldoint,oficina_cta,estado,prod_banc,
                   categoria,tipocta_super,turno,hora,canal,
                   cliente,clase_clte)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                   @s_term,@t_corr,@p_rssn_corr,@t_rty,'R',
                   @s_srv,@s_date,@i_cta,@i_efe,@i_prop,
                   @i_loc,@i_plaz,@p_lssn,@i_mon,null,
                   @i_sldlib,@o_control,null,@w_signo,@o_sldcont,
                   @o_slddisp,null,@w_oficina_p,@w_estado,@o_prod_banc,
                   @o_categoria,@o_tipocta_super,@i_turno,getdate(),@i_canal,
                   @o_cliente,@o_clase_clte)
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
    else if @t_trn = 255
    begin
      if @i_ind = 1
        select
          @w_efe = @i_credit
      else if @i_ind = 2
        select
          @w_prop = @i_credit
      else if @i_ind = 3
        select
          @w_loc = @i_credit
      else if @i_ind = 4
        select
          @w_rem = @i_credit

      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
        @i_ofi          = @i_oficina,
        @i_rol          = @i_turno,
        @i_user         = @s_srv,
        @i_mon          = @i_mon,
        @i_trn          = @w_tran_especial,--@t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'R',
        @i_corr         = @t_corr,
        @i_efectivo     = @w_efe,
        @i_cheque       = @w_prop,
        @i_chq_locales  = @w_loc,
        @i_chq_ot_plaza = @w_rem,
        @i_ssn          = @s_ssn,
        @i_cta_banco    = @i_cta,
        @i_filial       = @i_filial,-- ELI 14/11/2002
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,signo,indicador,
                   remoto_ssn,moneda,causa,fecha_efec,saldo_lib,
                   valor,control,interes,saldocont,saldodisp,
                   saldoint,departamento,oficina_cta,concepto,estado,
                   prod_banc,categoria,tipocta_super,turno,hora,
                   canal,cliente,clase_clte)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                   @s_term,@t_corr,@p_rssn_corr,@t_rty,'R',
                   @s_srv,@s_date,@i_cta,@w_signo,@i_ind,
                   @p_lssn,@i_mon,@i_cau,null,@i_sldlib,
                   @i_credit,@o_control,null,@o_sldcont,@o_slddisp,
                   null,@i_dep,@w_oficina_p,@i_concep,@w_estado,
                   @o_prod_banc,@o_categoria,@o_tipocta_super,@i_turno,getdate()
                   ,
                   @i_canal,@o_cliente,@o_clase_clte)
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
    if @t_trn = 251
    begin
    /* Actualizacion de Totales de cajero */
      --CCR MODO MASIVO *******
      if @i_estado_masivo = 1
      begin
        select
          @w_prop_masivo = @i_prop,
          @w_val_masivo = @i_efe

        select
          @i_efe = @i_val_masivo,
          @i_prop = @i_prop_masivo
      end
      --FIN CCR ***************

      exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
        @i_ofi          = @s_ofi,
        @i_rol          = @i_turno,
        @i_user         = @s_user,
        @i_mon          = @i_mon,
        @i_trn          = @t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'L',
        @i_corr         = @t_corr,
        @i_efectivo     = @i_efe,
        @i_cheque       = @i_prop,
        @i_chq_locales  = @i_loc,
        @i_chq_ot_plaza = @i_plaz,
        @i_ssn          = @s_ssn,
        @i_cta_banco    = @i_cta,
        @i_filial       = @i_filial,-- ELI 14/11/2002
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
      --CCR MODO MASIVO *******
      if @i_estado_masivo = 1
      begin
        select
          @i_efe = @w_val_masivo,
          @i_prop = @w_prop_masivo
      end
      --FIN CCR ***************

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_deposito
                  (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,efectivo,propios,
                   locales,ot_plazas,remoto_ssn,moneda,interes,
                   saldo_lib,control,fecha_efec,signo,saldocont,
                   saldodisp,saldoint,oficina_cta,estado,prod_banc,
                   categoria,tipocta_super,turno,hora,canal,
                   cliente,clase_clte)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                   @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                   @s_srv,@s_date,@i_cta,@i_efe,@i_prop,
                   @i_loc,@i_plaz,@p_lssn,@i_mon,null,
                   @i_sldlib,@o_control,null,@w_signo,@o_sldcont,
                   @o_slddisp,null,@w_oficina_p,@w_estado,@o_prod_banc,
                   @o_categoria,@o_tipocta_super,@i_turno,getdate(),@i_canal,
                   @o_cliente,@o_clase_clte)
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
    else
    begin
      if @t_trn = 255
      begin
        if @i_ind = 1
          select
            @w_efe = @i_credit
        else if @i_ind = 2
          select
            @w_prop = @i_credit
        else if @i_ind = 3
          select
            @w_loc = @i_credit
        else if @i_ind = 4
          select
            @w_rem = @i_credit

        /* Actualizacion de Totales de cajero */
        exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_user,
          @i_mon          = @i_mon,
          @i_trn          = @w_tran_especial,--@t_trn,
          @i_nodo         = @s_srv,
          @i_tipo         = 'L',
          @i_corr         = @t_corr,
          @i_efectivo     = @w_efe,
          @i_cheque       = @w_prop,
          @i_chq_locales  = @w_loc,
          @i_chq_ot_plaza = @w_rem,
          @i_ssn          = @s_ssn,
          @i_cta_banco    = @i_cta,
          @i_filial       = @i_filial,-- ELI 14/11/2002
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002
        if @w_return <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 205000
          return 205000
        end

        /*  Transaccion monetaria  */
        insert into cob_ahorros..ah_notcredeb
                    (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                     terminal,correccion,sec_correccion,reentry,origen,
                     nodo,fecha,cta_banco,signo,indicador,
                     remoto_ssn,moneda,causa,interes,saldo_lib,
                     valor,control,fecha_efec,saldocont,saldodisp,
                     saldoint,departamento,oficina_cta,concepto,estado,
                     prod_banc,categoria,tipocta_super,turno,hora,
                     canal,cliente,clase_clte)
        values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                     @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                     @s_srv,@s_date,@i_cta,@w_signo,@i_ind,
                     @p_lssn,@i_mon,@i_cau,null,@i_sldlib,
                     @i_credit,@o_control,null,@o_sldcont,@o_slddisp,
                     null,@i_dep,@w_oficina_p,@i_concep,@w_estado,
                     @o_prod_banc,@o_categoria,@o_tipocta_super,@i_turno,getdate
                     ()
                     ,
                     @i_canal,@o_cliente,@o_clase_clte)
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
  end

  if @w_factor = -1
  begin
    if @t_trn = 251
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado
      where  tm_moneda        = @i_mon
         and tm_valor         = @i_efe
         and tm_estado is null
         and tm_ssn_branch    = @t_ssn_corr
         and tm_oficina       = @s_ofi
         and tm_cta_banco     = @i_cta
         and tm_chq_propios   = @i_prop
         and tm_chq_locales   = @i_loc
         and tm_chq_ot_plazas = @i_plaz
         --and tm_saldo_lib   = @i_sldlib
         and tm_usuario       = @s_user

      if @@rowcount <> 1
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    end

    if @t_trn = 255
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado
      where  tm_moneda       = @i_mon
         and tm_valor        = @i_credit
         and tm_estado is null
         and tm_ssn_branch   = @t_ssn_corr
         and tm_oficina      = @s_ofi
         and tm_cta_banco    = @i_cta
         and tm_saldo_lib    = @i_sldlib
         and tm_indicador    = @i_ind
         and tm_causa        = @i_cau
         and tm_departamento = @i_dep
         and tm_concepto     = @i_concep
         and tm_usuario      = @s_user

      if @@rowcount <> 1
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    end

  end

  commit tran

  return 0

go

