/************************************************************************/
/*      Archivo               : pe_atrib.sp                             */
/*      Store Procedure       : sp_crea_atrib                           */
/*      Base de Datos         : cob_remesas                             */
/*      Producto              : Personalizacion                         */
/*      Disenado por          :                                         */
/*      Fecha de escritura    : 04 dic 1994                             */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*       Este programa crea los atributos en una tabla temporal         */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*        FECHA             AUTOR                 RAZON                 */
/*      02/Mayo/2016   Roxana Sánchez    Migración a CEN                */
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
           where  name = 'sp_crea_atrib')
  drop proc sp_crea_atrib
go

create proc sp_crea_atrib
(
  @t_show_version bit = 0
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_crea_atrib'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if exists (select
               *
             from   tempdb..sysobjects
             where  name = 'pe_tipo_atributo')
    drop table tempdb..pe_tipo_atributo

  select
    tipo_atributo = tr_tipo_atributo,
    filial = pf_filial,
    sucursal = pf_sucursal,
    producto = pf_producto,
    pro_bancario = me_pro_bancario,
    tipo_cta = me_tipo_ente,
    moneda = tr_moneda,
    servicio = sd_nemonico,
    rubro = sp_rubro
  into   tempdb..pe_tipo_atributo
  from   pe_mercado,
         pe_pro_final,
         pe_servicio_per,
         pe_servicio_dis,
         pe_tipo_rango
  where  tr_estado       = 'V'
     and tr_tipo_rango   = sp_tipo_rango
     and me_mercado      = pf_mercado
     and sp_pro_final    = pf_pro_final
     and sp_servicio_dis = sd_servicio_dis
     and pf_moneda       = tr_moneda

  create index pe_atributo_key
    on tempdb..pe_tipo_atributo ( filial, sucursal, producto, moneda,
  pro_bancario, tipo_cta, servicio, rubro)

go 
