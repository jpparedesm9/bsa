/************************************************************************/
/*      Archivo:        ah_depo2_locrem_fe.sp                           */
/*  Stored procedure:   sp_ah_depo2_locrem_fe                           */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Julio Navarrete/Javier Bucheli                  */
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
/*  FECHA         AUTOR         RAZON                                   */
/*  25/Feb/1993   J Navarrete   Emision inicial                         */
/*  02/Mayo/2016  Ignacio Yupa  Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depo2_locrem_fe')
  drop proc sp_ah_depo2_locrem_fe
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depo2_locrem_fe
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_ssn_branch    int = null,
  @p_lssn          int = null,  
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @p_rssn_corr     int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_ejec          char(1) = null,
  @s_org           char(1),
  @t_trn           int,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_efe           money,
  @i_loc           money,
  @i_plaz          money,
  @i_ind           tinyint,
  @i_cau           char(3),
  @i_credit        money,
  @i_fecha_efec    datetime,
  @i_oficina       smallint,
  @i_mon           tinyint,
  @i_dep           smallint,
  @i_sld_caja      money = 0,--RAN: migracion COBIS Explorer
  @i_idcaja        int = 0,--RAN: migracion COBIS Explorer
  @i_idcierre      int = 0,--RAN: migracion COBIS Explorer  
  @i_fecha_valor_a datetime = null,--RAN: migracion COBIS Explorer  
  @i_filial        tinyint = 0,--RAN: migracion COBIS Explorer  
  @i_canal         tinyint = 4,--4 CAJAS
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(60) out,
  @o_aj_int        money out,
  @o_aj_cap        money out,
  @o_aj_ret        money out,
  @o_fecha         datetime out,
  @o_ofi_cta       smallint out,
  @o_cliente       int = null out,
  @o_clase_clte    char(1) = null out,
  @o_cedula        varchar(20) out
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_oficial_nombre varchar(60),
    @w_cuenta         int,
    @w_filial_p       tinyint,
    @w_oficina_p      smallint,
    @w_pide_aut       char(1),
    @w_factor         int,
    @w_tipo_promedio  char(1),
    @w_oficial        smallint,
    @w_signo          char(1),
    @w_estado         char(1),
    @w_efe            money,
    @w_loc            money,
    @w_rem            money,
    @w_prod_banc      tinyint,
    @w_marca          char(1),
    @w_categoria      char(1),--MVE AH00007
    @w_tipocta_super  char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depo2_locrem_fe'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C',
      @w_estado = null
  else
    select
      @w_factor = -1,
      @w_signo = 'D',
      @w_estado = 'R'

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_cta,
    @i_moneda    = @i_mon,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial_p out,
    @o_oficina   = @w_oficina_p out

  if @w_return <> 0
    return @w_return

  /*  Deposito completo */
  begin tran

  exec @w_return = cob_ahorros..sp_deposito_ncredito_fe
    @s_srv           = @s_srv,
    @s_lsrv          = @s_lsrv,
    @s_ofi           = @s_ofi,
    @s_ssn           = @s_ssn,
    @s_user          = @s_user,
    @s_ssn_branch    = @s_ssn_branch,
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @t_trn           = @t_trn,
    @t_corr          = @t_corr,
    @t_ssn_corr      = @t_ssn_corr,
    @i_filial        = @w_filial_p,
    @i_ofi           = @s_ofi,
    @i_cuenta        = @w_cuenta,
    @i_efe           = @i_efe,
    @i_loc           = @i_loc,
    @i_plaz          = @i_plaz,
    @i_mon           = @i_mon,
    @i_credit        = @i_credit,
    @i_ind           = @i_ind,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_fecha_efec    = @i_fecha_efec,
    @i_marca         = @w_marca,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_aj_int        = @o_aj_int out,
    @o_aj_cap        = @o_aj_cap out,
    @o_aj_ret        = @o_aj_ret out,
    @o_nombre        = @o_nombre out,
    @o_fecha         = @o_fecha out,
    @o_ofi_cta       = @o_ofi_cta out,
    @o_prod_banc     = @w_prod_banc out,
    @o_clase_clte    = @o_clase_clte out,
    @o_categoria     = @w_categoria out,
    @o_tipocta_super = @w_tipocta_super out,--AH00007 MVE
    @o_cedula        = @o_cedula out,
    @o_cliente       = @o_cliente out
  if @w_return <> 0
    return @w_return

  select
    @w_efe = 0,
    @w_loc = 0,
    @w_rem = 0

  if @s_org = 'S'
  begin
    if @t_trn = 315
    begin
      if @i_ind = 1
        select
          @w_efe = @i_credit

      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @s_rol,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'R',
        @i_corr       = @t_corr,
        @i_efectivo   = @w_efe,
        @i_adj_int    = @o_aj_int,
        @i_adj_cap    = @o_aj_cap,
        @i_idcaja     = @i_idcaja,
        @i_filial     = @i_filial,
        @i_saldo_caja = @i_sld_caja,
        @i_idcierre   = @i_idcierre,
        @i_causa      = @i_cau

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
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,signo,indicador,remoto_ssn,
                   moneda,causa,fecha_efec,valor,saldocont,
                   oficina_cta,saldodisp,departamento,interes,saldoint,
                   val_cheque,prod_banc,canal,categoria,clase_clte,
                   estado,oficial,tipocta_super,ssn_branch,cliente)
      values      ( @s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                    @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                    @s_date,@i_cta,@w_signo,@i_ind,@p_lssn,
                    @i_mon,@i_cau,@i_fecha_efec,@i_credit,@o_sldcont,
                    @o_ofi_cta,@o_slddisp,@i_dep,@o_aj_cap,@o_aj_int,
                    @o_aj_ret,@w_prod_banc,4,@w_categoria,@o_clase_clte,
                    @w_estado,@w_oficial,@w_tipocta_super,@s_ssn_branch,
                    @o_cliente
      )

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end

      if @w_factor = -1
      begin
        update cob_ahorros..ah_tran_monet
        set    tm_estado = @w_estado,
               tm_sec_correccion = @s_ssn_branch
        where  tm_ssn_branch = @t_ssn_corr
           and tm_estado is null

        if @@rowcount <> 1
        begin
          /* No encontrs el registro en monetarias */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251067
          return 251067
        end
      end
    end
  end
  else if @s_org = 'U'
  begin
    if @t_trn = 315
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @s_rol,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'L',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_efe,
        @i_adj_int    = @o_aj_int,
        @i_adj_cap    = @o_aj_cap,
        @i_saldo_caja = @i_sld_caja,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_filial     = @i_filial,
        @i_causa      = @i_cau

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
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,signo,indicador,remoto_ssn,
                   moneda,causa,fecha_efec,valor,saldocont,
                   oficina_cta,saldodisp,departamento,interes,saldoint,
                   val_cheque,prod_banc,canal,categoria,clase_clte,
                   estado,oficial,tipocta_super,ssn_branch,cliente)
      --,        marca_inu)
      values      ( @s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                    @t_corr,@p_rssn_corr,@t_rty,'L',@s_srv,
                    @s_date,@i_cta,@w_signo,@i_ind,@p_lssn,
                    @i_mon,@i_cau,@i_fecha_efec,@i_credit,@o_sldcont,
                    @o_ofi_cta,@o_slddisp,@i_dep,@o_aj_cap,@o_aj_int,
                    @o_aj_ret,@w_prod_banc,4,@w_categoria,@o_clase_clte,
                    @w_estado,@w_oficial,@w_tipocta_super,@s_ssn_branch,
                    @o_cliente
      )
      --,     @w_marca)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end

      if @w_factor = -1
      begin
        update cob_ahorros..ah_tran_monet
        set    tm_estado = @w_estado,
               tm_sec_correccion = @s_ssn_branch
        where  tm_ssn_branch = @t_ssn_corr
           and tm_estado is null

        if @@rowcount <> 1
            or @@error <> 0
        begin
          /* No encontrs el registro en monetarias */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251067
          return 251067
        end
      end
    end
  end

  commit tran
  return 0

go

