/************************************************************************/
/*   Archivo:             cliente_segmento.sp                           */
/*   Stored procedure:    sp_cliente_segmento                           */
/*   Base de datos:       Cobis                                         */
/*   Producto:            Cliente                                       */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  18 de Octubre de 2013                         */
/************************************************************************/
/*                             IMPORTANTE                               */
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
/*                             PROPOSITO                                */
/*   Valida si el cliente que tiene problemas de segmento recibio trama */
/*   de respuesta desde centrales de riego, para de esta manera         */
/*   actualizar el campo de validacion en la tabla de clientes          */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   18/Oct/2013        Oscar Saavedra    Emision Inicial ORS 000670    */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

set NOCOUNT on
GO

set ANSI_NULLS on
GO

set QUOTED_IDENTIFIER on
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cliente_segmento')
  drop proc sp_cliente_segmento
go

create proc sp_cliente_segmento
(
  @t_show_version bit = 0,
  @i_param1       datetime /*Fecha de Proceso*/
)
as
  declare
    @w_sp_name varchar(32),
    @w_error   int,
    @w_msg     varchar(256)

  select
    @w_sp_name = 'sp_cliente_segmento'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    a.codigo
  into   #Catalogo
  from   cobis..cl_catalogo as a,
         cl_tabla as b
  where  a.tabla = b.codigo
     and b.tabla = 'cl_segmento'

  print
'[Informacion Previa de Clientes con Problemas de Validacion Debido a Error en Segmento] '
      + convert(varchar(12), @i_param1, 103)
  print ''
  select
    en_ente,
    en_ced_ruc,
    en_doc_validado,
    en_mala_referencia,
    mo_segmento
  from   cobis..cl_ente,
         cobis..cl_mercado_objetivo_cliente,
         cobis..cl_informacion_ext
  where  en_ente          = mo_ente
     and en_ente          = in_ente
     and en_doc_validado  = 'N'
     and in_respuesta_con = '02'
     and in_tconsulta in ('03', '04')
     and mo_segmento not in (select
                               codigo
                             from   #Catalogo)
  order  by 1

  select
    cs_ente = en_ente,
    cs_ced_ruc = en_ced_ruc,
    cs_doc_validado = en_doc_validado,
    cs_mala_referencia = en_mala_referencia,
    cs_segmento = mo_segmento
  into   #cl_cliente_segmento
  from   cobis..cl_ente,
         cobis..cl_mercado_objetivo_cliente,
         cobis..cl_informacion_ext
  where  en_ente          = mo_ente
     and en_ente          = in_ente
     and en_doc_validado  = 'N'
     and in_respuesta_con = '02'
     and in_tconsulta in ('03', '04')
     and mo_segmento not in (select
                               codigo
                             from   #Catalogo)
  order  by 1

  update cobis..cl_ente
  set    en_doc_validado = 'S'
  from   #cl_cliente_segmento
  where  en_ente = cs_ente

  if @@error <> 0
  begin
    select
      @w_error = 105051,
      @w_msg =
      '[sp_cliente_segmento] Error en la Actulizacion del campo en_doc_validado'
    goto ERROR
  end

  update cobis..cl_mercado_objetivo_cliente
  set    mo_segmento = '01'
  from   #cl_cliente_segmento
  where  mo_ente = cs_ente

  if @@error <> 0
  begin
    select
      @w_error = 105078,
      @w_msg =
    '[sp_cliente_segmento] Error en la Actulizacion del campo mo_segmento'
    goto ERROR
  end

  print
'[Informacion Posterior de Clientes con Problemas de Validacion Debido a Error en Segmento] '
      + convert(varchar(12), @i_param1, 103)
  print ''
  select
    en_ente,
    en_ced_ruc,
    en_doc_validado,
    en_mala_referencia,
    mo_segmento
  from   cobis..cl_ente,
         cobis..cl_mercado_objetivo_cliente,
         #cl_cliente_segmento
  where  en_ente = mo_ente
     and en_ente = cs_ente
  order  by 1

  return 0

  ERROR:
  print @w_msg

  exec @w_error = sp_errorlog
    @i_fecha       = @i_param1,
    @i_error       = @w_error,
    @i_usuario     = 'op_batch',
    @i_tran        = 19041,
    @i_tran_name   = '',
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  return @w_error

go

