/************************************************************************/
/*  Archivo:            ahtdepini.sp                                    */
/*  Stored procedure:   sp_ah_trn_depo_inicial                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Andres Diab                                     */
/*  Fecha de escritura: 20-Dic-2011                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*  Este programa valida la realizacion del deposito inicial para       */
/*  activacion de cuentas de ahorro                                     */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR            RAZON                                */
/*  20-Dic-2011   Andres Diaz      Emision Inicial                      */
/*  02/Mayo/2016  Ignacio Yupa     Migración a CEN                      */
/*  22/Sep/2016     T. Baidal       Validacion si es batch y se inicio  */
/*                                  una transaccion se hace commit para */
/*                                  no inconsistencia de num de transac */  
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_trn_depo_inicial')
  drop proc sp_ah_trn_depo_inicial
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_trn_depo_inicial
(
  @s_user         login = null,
  @s_ofi          smallint = null,
  @s_date         datetime = null,  
  @t_file         varchar(10) = null,
  @t_debug        char(1) = 'N',
  @t_trn          int,
  @t_show_version bit = 0,
  @i_ssn_branch   int = null,--SECUENCIAL BRANCH
  @i_ssn_corr     int = null,--SECUENCIAL TRN REVERSADA
  @i_causal       varchar(3) = '0',
  @i_moneda       tinyint = 0,
  @i_cta_banco    cuenta,
  @i_estado       char(1),
  @i_oficina      smallint,
  @i_correccion   char(1),
  @i_batch        char(1) = 'N'
)
as
  declare
    @w_return     int,
    @w_sp_name    varchar(30),
    @w_fecha_act  datetime,
    @w_dep_ini    tinyint,
    @w_estado     char(1),
    @w_secuencial int,
    @w_trns       int,
	@w_error      int,
    @w_mensaje    varchar(132),
	@w_sev        tinyint

  select
    @w_fecha_act = getdate(),
    @w_sp_name = 'sp_ah_trn_depo_inicial'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if not exists(select
                  1
                from   cob_ahorros..ah_trn_deposito_inicial
                where  di_tran   = @t_trn
                   and di_causal = @i_causal
                   and di_estado = 'V')
  begin
    return 0
  end

  if @i_correccion = 'S'
     and @i_ssn_corr is null
  begin
    select @w_error = 255001,
	       @w_mensaje = 'SECUENCIAL DE TRANSACCION REVERSADA NO PUEDE SER NULO'
    goto ERROR
  end

  if @i_correccion = 'N'
     and @i_estado = 'G'
    select
      @w_dep_ini = 0,-- DEPOSITO INICIAL REALIZADO
      @w_estado = 'A',
      @w_secuencial = @i_ssn_branch,
      @w_fecha_act = getdate()

  else --Reverso Deposito Inicial
  begin
    if @i_correccion = 'S'
    begin
      if exists (select
                   1
                 from   cob_ahorros..ah_tran_servicio
                 where  ts_tipo_transaccion = 201
                    and ts_cta_banco        = @i_cta_banco
                    and ts_sec_correccion   = @i_ssn_corr
                    and @i_estado           = 'A')
      begin
        select
          @w_trns = count(1)
        from   cob_ahorros..ah_tran_monet
        where  tm_cta_banco  = @i_cta_banco
           and tm_signo      = 'C'
           and tm_correccion <> 'S'

        if @w_trns >= 2
        --si existe mas de una transaccion significa que la cuenta queda con saldo y debe quedar en estado activa
        begin
          select
            @w_estado = 'A',
            @w_dep_ini = 0
        end
        else
          select
            @w_dep_ini = 1,-- DEPOSITO INICIAL NO REALIZADO
            @w_estado = 'G',
            @w_secuencial = null,
            @w_fecha_act = null
      end
      else
      begin
        if exists(select
                    1
                  from   cob_ahorros_his..ah_his_servicio
                  where  hs_tipo_transaccion = 201
                     and hs_cta_banco        = @i_cta_banco
                     and hs_sec_correccion   = @i_ssn_corr
                     and @i_estado           = 'A')
        begin
          select
            @w_dep_ini = 1,-- DEPOSITO INICIAL NO REALIZADO
            @w_estado = 'G',
            @w_secuencial = null,
            @w_fecha_act = null
        end
        else
          return 0
      end
    end
    else
      return 0
  end

  begin tran

  /* ACTUALIZA MAESTRO DE AHORROS */
  update cob_ahorros..ah_cuenta with (rowlock)
  set    ah_estado = @w_estado,
         ah_dep_ini = @w_dep_ini
  where  ah_cta_banco = @i_cta_banco
  if @@rowcount <> 1
  begin
      select @w_error = 255001
      goto ERROR
  end

  if exists (select
               1
             from   cob_ahorros..ah_tran_servicio
             where  ts_tipo_transaccion = 201
                and ts_cta_banco        = @i_cta_banco)
  begin
    /* ACTUALIZA TRANSACCION DE APERTURA DE CTA AHORROS */
    update cob_ahorros..ah_tran_servicio with (rowlock)
    set    ts_sec_correccion = @w_secuencial,
           ts_estado = @w_estado,
           ts_fecha_ven = @w_fecha_act
    where  ts_tipo_transaccion = 201
       and ts_cta_banco        = @i_cta_banco
       and ts_oficina_cta      = @i_oficina
       and ts_moneda           = @i_moneda
    if @@error <> 0
    begin
	    select @w_error = 145005
        goto ERROR
    end
  end
  else
  begin
    /* ACTUALIZA TRANSACCION HISTORICA DE APERTURA DE CTA AHORROS */
    update cob_ahorros_his..ah_his_servicio with (rowlock)
    set    hs_sec_correccion = @w_secuencial,
           hs_estado = @w_estado,
           hs_fecha_ven = @w_fecha_act
    where  hs_tipo_transaccion = 201
       and hs_cta_banco        = @i_cta_banco
       and hs_oficina_cta      = @i_oficina
       and hs_moneda           = @i_moneda
    if @@error <> 0
    begin
	    select @w_error = 145005
        goto ERROR
    end
  end

  commit tran

  return 0

ERROR:
if @i_batch = 'N'
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_mensaje,
	@i_sev   = @w_sev
end
return @w_error
go

