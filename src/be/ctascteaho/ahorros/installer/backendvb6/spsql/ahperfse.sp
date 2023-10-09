/************************************************************************/
/*  Archivo           :  ahperfse.sp                                    */
/*  Base de datos     :  cob_ahorros                                    */
/*  Producto          :  Cuentas Ahorros                                */
/*  Disenado por      :  Julissa Colorado                               */
/*  Fecha de escritura:  28/ago/2003                                    */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Se encarga de totalizar las transacciones de servicio               */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR               RAZON                             */
/*  29/Ago/2003   Julissa Colorado    Emision inicial                   */
/*  22/Abr/2010   ACorrea             Migracion SQLSERVER/Integracion   */
/*  04/May/2016   J. Salazar          Migracion COBIS CLOUD MEXICO      */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_inserta_rechazo_ser')
  drop proc sp_inserta_rechazo_ser
go

/****** Object:  StoredProcedure [dbo].[sp_inserta_rechazo_ser]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_inserta_rechazo_ser
(
  @t_show_version bit = 0,
  @i_param1       datetime,--Fecha de proceso
  @i_param2       smallint = null,--Oficina
  @o_procesadas   int = 0 out
)
as
  declare
    @w_sp_name     varchar(30),
    @w_moneda      tinyint,
    @w_oficina     smallint,
    @w_oficina_cta smallint,
    @w_prod_banc   smallint,
    @w_categoria   char(1),
    @w_tipo_tran   smallint,
    @w_causa       varchar(4),
    @w_indicador   tinyint,
    @w_contador    int,
    @w_tipo_pers   varchar(10),
    @w_cliente     int,
    @w_return      int,
    @w_campo       varchar(25),
    @w_valor_tran  money,
    @w_base        money,
    @w_valor       money,
    @w_saldo       money,
    @w_monto       money,
    @w_interes     money,
    @w_contabiliza varchar(25),
    @w_fecha       smalldatetime,
    @w_secuencial  int,
    @w_cursor      smallint,
    @w_totaliza    char(1)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_inserta_rechazo_ser'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  -- Inicializacion de variables
  select
    @o_procesadas = 0
  select
    @w_secuencial = 0

  exec @w_return = cob_cuentas..sp_rechazo_moncc
    @i_fecha      = @i_param1,
    @i_producto   = 4,
    @i_tipo       ='S',
    @o_procesadas = @o_procesadas out

  if @w_return <> 0
  begin
    print 'Error generando informacion base para el reporte'
    return @w_return
  end

  /* Tabla Temporal para utilizacion de causales */

  create table #campos
  (
    campo varchar(25)
  )

  insert #campos
  values ('ts_valor')
  insert #campos
  values ('ts_saldo')
  insert #campos
  values ('ts_monto')
  insert #campos
  values ('ts_interes')

  -- Declaracion del cursor
  declare totales cursor for
    select
      ts_fecha,
      ts_oficina,
      ts_oficina_cta,
      ts_moneda,
      ts_tipo_transaccion,
      ts_causa,
      ts_prod_banc,
      ts_clase_clte,
      ts_indicador,
      ts_cliente,
      ts_contador,
      ts_valor,
      ts_saldo,
      ts_monto,
      ts_interes
    from   cob_remesas..re_ahtotal_transerv
    where  (ts_oficina = @i_param2
         or @i_param2 is null)
    order  by ts_oficina_cta
    for read only

  open totales
  fetch totales into @w_fecha,
                     @w_oficina,
                     @w_oficina_cta,
                     @w_moneda,
                     @w_tipo_tran,
                     @w_causa,
                     @w_prod_banc,
                     @w_tipo_pers,
                     @w_indicador,
                     @w_cliente,
                     @w_contador,
                     @w_valor,
                     @w_saldo,
                     @w_monto,
                     @w_interes

  while @@fetch_status = 0
  begin -- Insercion de los totales  
    select
      @w_cursor = 0

    declare totales_montter cursor for
      select
        campo
      from   #campos
      where  campo not in (select
                             cc_campo1
                           from   cob_remesas..re_concepto_contable
                           where  cc_tipo_tran = @w_tipo_tran
                              and isnull(cc_causa,
                                         '0') in (@w_causa, '0')
                              and isnull(cc_indicador,
                                         0) in (@w_indicador, 0)
                              and cc_producto  = 4)
      for read only

    open totales_montter
    fetch totales_montter into @w_contabiliza

    while @@fetch_status = 0
    begin
      select
        @w_cursor = 1,
        @w_valor_tran = 0,
        @w_base = 0

      if @w_contabiliza = 'ts_valor'
        select
          @w_valor_tran = @w_valor
      if @w_contabiliza = 'ts_saldo'
        select
          @w_valor_tran = @w_saldo
      if @w_contabiliza = 'tm_monto'
        select
          @w_valor_tran = @w_monto
      if @w_contabiliza = 'ts_interes'
        select
          @w_valor_tran = @w_interes

      select
        @w_secuencial = @w_secuencial + 1
      if @w_valor_tran > 0
      begin
        insert into cob_remesas..re_rechazo_tran
                    (rh_secuencial,rh_fecha,rh_oficina,rh_oficina_cta,rh_moneda,
                     rh_transacion,rh_causa,rh_prod_banc,rh_producto,
                     rh_clase_clte
                     ,
                     rh_indicador,rh_campo,rh_valor,rh_base,
                     rh_cliente,
                     rh_procesado,rh_contador,rh_tipo)
        values      ( @w_secuencial,@w_fecha,@w_oficina,@w_oficina_cta,@w_moneda
                      ,
                      @w_tipo_tran,@w_causa,@w_prod_banc,
                      4,@w_tipo_pers,
                      @w_indicador,@w_contabiliza,@w_valor_tran,@w_base,
                      @w_cliente
                      ,
                      'N',@w_contador,'S')

        if @@error <> 0
        begin
          print 'ERROR EN INSERCION  re_rechazo_tran'
          return 1
        end
      end

      fetch totales_montter into @w_contabiliza
    end /* while */

    if @w_cursor = 1
    begin
      close totales_montter
      deallocate totales_montter
    end

    select
      @w_cursor = 0

    LEER:
    fetch totales into @w_fecha,
                       @w_oficina,
                       @w_oficina_cta,
                       @w_moneda,
                       @w_tipo_tran,
                       @w_causa,
                       @w_prod_banc,
                       @w_tipo_pers,
                       @w_indicador,
                       @w_cliente,
                       @w_contador,
                       @w_valor,
                       @w_saldo,
                       @w_monto,
                       @w_interes
  end
  return 0

go

