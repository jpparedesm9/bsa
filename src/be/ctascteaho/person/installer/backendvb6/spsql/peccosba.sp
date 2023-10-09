/************************************************************************/
/*      Archivo:                peccosba.sp                             */
/*      Stored procedure:       sp_consulta_costo_batch                 */
/*      Base de datos:          cob_remesas                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Oswaldo Ligua                           */
/*      Fecha de escritura:     27-Feb-2004                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
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
/*      Programa que consulta el costo del rubro de un servicio. Esta   */
/*      consulta es para ejecutarse en batch                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    27/Feb/2004     O. Ligua        Emision inicial              */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                  */
/************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consulta_costo_batch')
  drop proc sp_consulta_costo_batch
go

create proc sp_consulta_costo_batch
(
  @t_show_version    bit = 0,
  @i_fecha           datetime,
  @i_categoria       catalogo,
  @i_rol_ente        char(1),
  @i_tipo_def        char(1),
  @i_producto        tinyint,
  @i_tipo            char(1),
  @i_default         int,
  @i_personalizada   char(1),
  @i_filial          tinyint,
  @i_oficina         smallint,
  @i_sucursal        smallint,
  @i_moneda          smallint,
  @i_prod_banc       smallint,
  @i_tipocta         varchar(3),
  @i_promedio1       money,
  @i_contable        money,
  @i_disponible      money,
  @i_prom_disponible money,
  @i_servicio        char(4),
  @i_rubro           varchar(10),
  @i_paquete         int = null,--CLE 11042006
  @o_msg_error       descripcion output,
  @o_tasa            float output
)
as
  declare
    @w_sp_name       descripcion,
    @w_return        int,
    @w_tipo_atributo char(1),
    @w_monto         money,
    @w_mensaje       descripcion

  select
    @w_sp_name = 'sp_consulta_costo_batch'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /************ VALIDA SI LA CUENTA PERTENECE A UN PAQUETE **************/
  if @i_paquete is not null
  begin
    select
      @i_producto = gp_prod_cobis_pq,
      @i_prod_banc = gp_prod_banc_pq,
      @i_categoria = gp_categoria_pq
    from   pa_gestion_paquete
    where  gp_numpq     = @i_paquete
       and gp_estado_pq = 'A'

    if @@rowcount = 0
    begin
      select
        @w_mensaje = 'Procesando *** 0 ... Paquete ' + convert(varchar(10),
                     @i_paquete
                     )
      print @w_mensaje
      select
        @o_msg_error = 'ERROR AL BUSCAR EL PAQUETE DEL PRODUCTO ' + convert(
                       varchar
                       (
                                                 10 ), @i_paquete
                                                 )
      return 1
    end

  end

  if @i_personalizada = 'N'
  begin --1
    /* Cta. NO Personalizada */
    select
      @w_tipo_atributo = tipo_atributo
    from   tempdb..pe_tipo_atributo
    where  filial       = @i_filial
       and sucursal     = @i_sucursal
       and producto     = @i_producto
       and moneda       = @i_moneda
       and pro_bancario = @i_prod_banc
       and tipo_cta     = @i_tipocta
       and servicio     = @i_servicio
       and rubro        = @i_rubro
    if @@rowcount <> 1
    begin --2
      select
        @w_mensaje = 'Procesando *** 1 ... Atributo ' + rtrim(@i_servicio) +
                     ' rubro'
                     +
                            rtrim(
                            @i_rubro)
      print @w_mensaje
      select
        @o_msg_error = 'ERROR AL BUSCAR EL TIPO DE ATRIBUTO ' + rtrim(
                       @i_servicio
                       )
                       +
                                                 ' rubro' + rtrim
                                                 ( @i_rubro)
      return 1
    end --2

    if @w_tipo_atributo = 'B' /* Saldo promedio */
      select
        @w_monto = @i_promedio1
    else if @w_tipo_atributo = 'C' /* Saldo Contable */
      select
        @w_monto = @i_contable
    else if @w_tipo_atributo = 'A' /* Saldo Disponible */
      select
        @w_monto = @i_disponible
    else if @w_tipo_atributo = 'E' /* Promedio Disponible */
      select
        @w_monto = @i_prom_disponible
    else
      select
        @w_monto = $1

    if @i_servicio = 'SOCA'
      select
        @o_tasa = valor / 100
      from   tempdb..soca
      where  tipo_ente     = @i_tipocta
         and pro_bancario  = @i_prod_banc
         and filial        = @i_filial
         and sucursal      = @i_sucursal
         and producto      = @i_producto
         and moneda        = @i_moneda
         and categoria     = @i_categoria
         and servicio_dis  = @i_servicio
         and rubro         = @i_rubro
         and tipo_atributo = @w_tipo_atributo
         and rango_desde   <= @w_monto
         and rango_hasta   > @w_monto
    else if @i_servicio = 'SCON'
      select
        @o_tasa = valor / 100
      from   tempdb..scon
      where  tipo_ente     = @i_tipocta
         and pro_bancario  = @i_prod_banc
         and filial        = @i_filial
         and sucursal      = @i_sucursal
         and producto      = @i_producto
         and moneda        = @i_moneda
         and categoria     = @i_categoria
         and servicio_dis  = @i_servicio
         and rubro         = @i_rubro
         and tipo_atributo = @w_tipo_atributo
         and rango_desde   <= @w_monto
         and rango_hasta   > @w_monto

    if @@rowcount <> 1
    begin --2
      select
        @w_mensaje = 'Procesando *** 2 ... Error tabla ' + rtrim(@i_servicio) +
                     ' Rubro'
                            + rtrim(
                            @i_rubro)
      print @w_mensaje
      select
        @o_msg_error = 'ERROR EN TABLA TMP DE PERSONALIZACION ' + rtrim(
                       @i_servicio
                       )
                       +
                                                 ' Rubro'
                       + rtrim(@i_rubro)
      return 1
    end --2
  end --1
  else
  begin --1
    /* Cta. Personalizada */
    exec @w_return = cob_remesas..sp_genera_costos
      @t_from        = @w_sp_name,
      @i_fecha       = @i_fecha,
      @i_valor       = 1,
      @i_categoria   = @i_categoria,
      @i_tipo_ente   = @i_tipocta,
      @i_rol_ente    = @i_rol_ente,
      @i_tipo_def    = @i_tipo_def,
      @i_prod_banc   = @i_prod_banc,
      @i_producto    = @i_producto,
      @i_moneda      = @i_moneda,
      @i_tipo        = @i_tipo,
      @i_codigo      = @i_default,
      @i_servicio    = @i_servicio,
      @i_rubro       = @i_rubro,
      @i_disponible  = @i_disponible,
      @i_contable    = @i_contable,
      @i_promedio    = @i_promedio1,
      @i_prom_disp   = @i_prom_disponible,
      @i_personaliza = @i_personalizada,
      @i_filial      = @i_filial,
      @i_oficina     = @i_oficina,
      @i_paquete     = @i_paquete,
      @o_valor_total = @o_tasa out
    if @w_return <> 0
    begin --2
      select
        @w_mensaje = 'Procesando *** 3 ... Error genera Costo ' + rtrim(
                     @i_servicio
                     )
                     +
                            ' Rubro'
                     + rtrim(@i_rubro)
      print @w_mensaje
      select
        @o_msg_error = 'Error Genera Costo ' + rtrim(@i_servicio) + ' Rubro' +
                       rtrim
                       (
                                                 @i_rubro)
      return @w_return
    end --2
  end --1

  return 0

go 
