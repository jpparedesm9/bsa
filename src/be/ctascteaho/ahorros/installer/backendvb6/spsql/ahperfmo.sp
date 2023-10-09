/************************************************************************/
/*  Archivo           :  ahperfmo.sp                                    */
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
/*  Se encarga de totalizar las transacciones monetarias                */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR               RAZON                             */
/*  29/Ago/2003   Julissa Colorado    Emision inicial                   */
/*  22/Abr/2010   ACorrea             Migracion SQLSERVER/Integracion   */
/*  06/Sep/2010   LAlvarez            Optimizacion                      */
/*  04/May/2016   J. Salazar          Migracion COBIS CLOUD MEXICO      */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_inserta_rechazo')
  drop proc sp_inserta_rechazo
go

/****** Object:  StoredProcedure [dbo].[sp_inserta_rechazo]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_inserta_rechazo
(
  @t_show_version bit = 0,
  @i_param1       datetime,--Fecha de proceso
  @i_param2       smallint = null --Oficina
)
as
  declare
    @w_sp_name    varchar(30),
    @w_return     int,
    @w_fecha      smalldatetime,
    @w_campo      int,
    @w_campo_max  int,
    @w_procesadas int

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_inserta_rechazo'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  exec @w_return = cob_cuentas..sp_rechazo_moncc
    @i_fecha      = @i_param1,
    @i_producto   = 4,
    @i_tipo       ='M',
    @o_procesadas = @w_procesadas out

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
  values ('tm_valor') --12
  insert #campos
  values ('tm_chq_propios') --13  
  insert #campos
  values ('tm_chq_locales') --14 
  insert #campos
  values ('tm_chq_ot_plazas')--15 
  insert #campos
  values ('tm_efectivo') --16
  insert #campos
  values ('tm_impuesto') --17
  insert #campos
  values ('tm_valor_portes') --18 
  insert #campos
  values ('tm_interes') --19
  insert #campos
  values ('tm_saldo_interes')--20
  insert #campos
  values ('tm_valor_comision')--21
  insert #campos
  values ('tm_monto_imp')

  /******EXTRACCION DE TRANSACCIONES MONETARIAS **/
  select
    tm_fecha,
    tm_oficina,
    tm_oficina_cta,
    tm_moneda,
    tm_tipo_tran,
    tm_causa,
    tm_prod_banc,
    tm_clase_clte,
    tm_indicador,
    tm_cliente,
    tm_contador,
    tm_valor,
    tm_chq_propios,
    tm_chq_locales,
    tm_chq_ot_plazas,
    tm_efectivo,
    tm_impuesto,
    tm_valor_portes,
    tm_interes,
    tm_saldo_interes,
    tm_valor_comision,
    'cc_campo1' = campo
  into   #transacciones
  from   #campos,
         cob_remesas..re_ahtotal_tranmonet tr
  where  campo not in (select
                         cc_campo1
                       from   cob_remesas..re_concepto_contable
                       where  cc_tipo_tran = tr.tm_tipo_tran
                          and isnull(cc_causa,
                                     '0') in (tr.tm_causa, '0')
                          and isnull(cc_indicador,
                                     0) in (tr.tm_indicador, 0)
                          and cc_producto  = 4)
     and (tm_oficina_cta = null
           or null is null)
  order  by tm_oficina_cta
  if @@error <> 0
  begin
    print 'ERROR EN INSERCION  #transacciones'
    return 1
  end

  if not exists (select
                   count(1)
                 from   #transacciones)
  begin
    print 'NOT EXISTEN REGISTROS PARA PROCESAR'
    return 0
  end

  /******EXTRACCION DE  VALORES DE LOS CAMPOS QUE GENERAN MOVIMIENTO CONTABLE**** **/

  create table #rechazos
  (
    tm_fecha       datetime,
    tm_oficina     smallint,
    tm_oficina_cta smallint,
    tm_moneda      smallint,
    tm_tipo_tran   smallint,
    tm_causa       varchar(4),
    tm_prod_banc   smallint,
    tm_clase_clte  varchar(2),
    tm_indicador   tinyint,
    tm_cliente     int,
    campo          varchar(20),
    valor          money,
    tm_contador    int
  )

  select
    @w_campo = 12
  select
    @w_campo_max = count(1)
  from   #campos

  while @w_campo <= (@w_campo_max + 12)
  begin
    insert into #rechazos
      select
        tm_fecha,tm_oficina,tm_oficina_cta,tm_moneda,tm_tipo_tran,
        tm_causa,tm_prod_banc,tm_clase_clte,tm_indicador,tm_cliente,
        campo = cc_campo1,valor = (case
                   when cc_campo1 = 'tm_valor' then tm_valor
                   when cc_campo1 = 'tm_chq_propios' then tm_chq_propios
                   when cc_campo1 = 'tm_chq_locales' then tm_chq_locales
                   when cc_campo1 = 'tm_chq_ot_plazas' then tm_chq_ot_plazas
                   when cc_campo1 = 'tm_efectivo' then tm_efectivo
                   when cc_campo1 = 'tm_impuesto' then tm_impuesto
                   when cc_campo1 = 'tm_monto_imp' then tm_impuesto
                   when cc_campo1 = 'tm_valor_portes' then tm_valor_portes
                   when cc_campo1 = 'tm_interes' then tm_interes
                   when cc_campo1 = 'tm_saldo_interes' then tm_saldo_interes
                   when cc_campo1 = 'tm_valor_comision'then tm_valor_comision
                   else 0
                 end),tm_contador
      from   #transacciones

    if @@error <> 0
    begin
      print 'ERROR EN INSERCION  #rechazos'
      return 1
    end

    select
      @w_campo = @w_campo + 1
  end

  /*****	elimina los registros con valor 0 ***/
  delete #rechazos
  where  valor = 0

  /*****INSERTANDO DATO EN LA TABLA RE_RECHAZO_TRAN**********/
  insert into cob_remesas..re_rechazo_tran
              (rh_secuencial,rh_fecha,rh_oficina,rh_oficina_cta,rh_moneda,
               rh_transacion,rh_causa,rh_prod_banc,rh_producto,rh_clase_clte,
               rh_indicador,rh_campo,rh_valor,rh_base,rh_cliente,
               rh_procesado,rh_contador,rh_tipo)
    select
      row_number()
        over(
          order by tm_fecha),tm_fecha,tm_oficina,tm_oficina_cta,tm_moneda,
      tm_tipo_tran,tm_causa,tm_prod_banc,4,tm_clase_clte,
      tm_indicador,campo,valor,0,tm_cliente,
      'N',tm_contador,'M'
    from   #rechazos
    order  by tm_oficina
  if @@error <> 0
  begin
    print 'ERROR EN INSERCION  re_rechazo_tran'
    return 1
  end

  return 0

go

