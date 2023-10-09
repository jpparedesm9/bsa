/************************************************************************/
/*      Archivo:                inactivacion_ah.sp                      */
/*      Stored procedure:       sp_inactivacion_ah                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Pedro Coello                            */
/*      Fecha de escritura:     19-Jun-2006                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la inactivacion de cuentas de Ahorros     */
/*      367 = Inactivacion de cuentas                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      19/jUN/2006     P. COELLO       EMISION INICIAL                 */
/*      04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_inactivacion_ah')
  drop proc sp_inactivacion_ah
go

/****** Object:  StoredProcedure [dbo].[sp_inactivacion_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_inactivacion_ah
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
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
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_filial       tinyint,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_turno        smallint = null,
  @i_alt          int = 0,
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada             
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_disponible    money,
    @w_moneda        smallint,
    @w_estado        char(1),
    @w_oficina       int,
    @w_prod_banc     smallint,
    @w_categoria     char(1),
    @w_tipocta_super char(1),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_inactivacion_ah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
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

  if @t_trn not in (367)
  begin
    /* Error en codigo de transaccion */
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
      @w_disponible = ah_disponible,
      @w_moneda = ah_moneda,
      @w_estado = ah_estado,
      @w_oficina = ah_oficina,
      @w_prod_banc = ah_prod_banc,
      @w_categoria = ah_categoria,
      @w_tipocta_super = ah_tipocta_super
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_estado    <> 'G'
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201004
      return 1
    end
  end
  else
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_disponible = ah_disponible,
      @w_moneda = ah_moneda,
      @w_estado = ah_estado,
      @w_oficina = ah_oficina,
      @w_prod_banc = ah_prod_banc,
      @w_categoria = ah_categoria,
      @w_tipocta_super = ah_tipocta_super
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_estado    <> 'G'

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201004
      return 1
    end
  end

  /* Validaciones */
  if @w_estado <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /* Transaccion de bloqueos a la cuenta */
  if @t_trn = 367
  begin
    /* Actualizacion de las tablas: ah_his_inmovilizadas y ah_cuenta */

    begin tran

    insert into ah_his_inmovilizadas
                (hi_cuenta,hi_saldo,hi_fecha)
    values      (@i_cta,@w_disponible,@s_date)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203038
      return 1

    --rollback tran
    end

    insert into ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_ctacte,ts_filial,ts_valor,ts_moneda,
                 ts_oficina,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,
                 ts_turno,ts_cta_banco)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@w_cuenta,@i_filial,@w_disponible,@w_moneda,
                 @w_oficina,@w_oficina,@w_prod_banc,@w_categoria,
                 @w_tipocta_super,
                 @i_turno,@i_cta)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    --rollback tran
    end

    update cob_ahorros..ah_cuenta
    set    ah_estado = 'I'
    where  ah_cta_banco = @i_cta

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205001
      return 1
    end

    commit tran
    return 0
  end

  return 0

go

