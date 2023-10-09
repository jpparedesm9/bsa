/************************************************************************/
/*      Archivo:                cembargo.sp                             */
/*      Stored procedure:       sp_consulta_embargo                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Este programa procesa consultas de Embargos // Congelamientos     */
/*         Borrado de           cl_cab_embargo, cl_det_embargo          */
/*         Busqueda de          cl_cab_embargo, cl_det_embargo          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    May/02/2016     DFu             Migracion CEN                     */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_consulta_embargo')
  drop proc sp_consulta_embargo
go

create proc sp_consulta_embargo
(
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cliente      int = null,
  @i_opcion       char(1) = null,
  @i_operacion    char(1) = null,
  @i_accion       char(1) = null,
  @i_secuencial   int = 0
)
as
  declare @w_sp_name char(30)

  select
    @w_sp_name = 'sp_consulta_embargo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --U2 V4

  if @t_trn = 1493
  begin
    if @i_operacion = 'S'
    begin
      if @i_accion = 'A'
      begin
        set rowcount 20
        select
          'SECUENCIAL  ' = ca_secuencial,
          'FECHA       ' = convert (char(10), ca_fecha, 101),
          'FECHA_OFI   ' = convert (char(10), ca_fecha_ofi, 101),
          'OFICIO      ' = ca_oficio,
          'SOLICITANTE ' = ca_solicitante,
          'DEMANDANTE  ' = ca_apellido_demandante + ' ' + ca_demandante,
          'MONTO       ' = ca_monto,
          'ESTADO      ' = ca_estado,
          'TIPO_PROCESO' = ca_tipo_proceso,
          'AUTORIZANTE ' = ca_autorizante,
          'SALDO_PDTE  ' = ca_saldo_pdte,
          'DEBITA_CTA  ' = ca_debita_cta,
          'OBSERVACION ' = ca_observacion
        from   cl_cab_embargo
        where  ca_ente         = @i_cliente
           and ca_tipo_proceso = @i_opcion
      end

      if @i_accion = 'B'
      begin
        set rowcount 20
        select
          'SECUENCIAL  ' = ca_secuencial,
          'FECHA       ' = convert (char(10), ca_fecha, 101),
          'FECHA_OFI   ' = convert (char(10), ca_fecha_ofi, 101),
          'OFICIO      ' = ca_oficio,
          'SOLICITANTE ' = ca_solicitante,
          'DEMANDANTE  ' = ca_apellido_demandante + ' ' + ca_demandante,
          'MONTO       ' = ca_monto,
          'ESTADO      ' = ca_estado,
          'TIPO_PROCESO' = ca_tipo_proceso,
          'AUTORIZANTE ' = ca_autorizante,
          'SALDO_PDTE  ' = ca_saldo_pdte,
          'DEBITA_CTA  ' = ca_debita_cta,
          'OBSERVACION ' = ca_observacion
        from   cl_cab_embargo
        where  ca_ente         = @i_cliente
           and ca_secuencial   > @i_secuencial
           and ca_tipo_proceso = @i_opcion
      end

      set rowcount 0
    end
  end

  if @t_trn = 1492
  begin
    if @i_operacion = 'Q'
    begin
      select distinct
        'SECUENCIAL' = de_secuencial,
        'SEC_MODULO' = de_sec_interno,
        'NUM_CUENTA ' = de_num_cuenta,
        'FECHA        ' = convert (char(10), de_fecha, 101),
        'MONTO               ' = de_monto,
        'PRODUCTO' = de_producto,
        'SUBPRODUCTO' = de_subproducto,
        'TIPO_BLOQUEO' = de_tipo_bloqueo,
        'ESTADO_LEVANTAMIENTO' = de_estado_levantamiento,
        'FECHA_LEVANTAMIENTO ' = convert (char(10), de_fecha_levantamiento, 101)
        ,
        'OBSERVACION    ' = de_observacion
      from   cl_cab_embargo,
             cl_det_embargo
      where  de_ente       = @i_cliente
         and de_ente       = ca_ente
         and de_secuencial = @i_secuencial

    end
  end
  return 0

go

