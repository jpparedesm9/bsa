/************************************************************************/
/*   Stored procedure:     sp_actualiza_seg                             */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                                  IMPORTANTE                          */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA                    AUTOR                       RAZON           */
/* 02/may/2016              DFu                  Migracion CEN          */
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
           where  name = 'sp_actualiza_seg')
  drop proc sp_actualiza_seg
go

create proc sp_actualiza_seg
(
  @t_show_version bit = 0
)
as
  declare @w_sp_name char(30)

  select
    @w_sp_name = 'sp_actualiza_seg'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  print 'total de datos mal asignado en el segmento'
  select
    mo_segmento,
    count(*)
  from   cobis..cl_mercado_objetivo_cliente
  where  len(mo_segmento) <> 2
  group  by mo_segmento
  with rollup

  print ' Datos de segmento en 1'
  select
    count(*)
  from   cobis..cl_mercado_objetivo_cliente
  where  convert(int, mo_segmento) = 1
     and len (mo_segmento)         <> 2

  print 'Actualizacion de 01'
  update cobis..cl_mercado_objetivo_cliente
  set    mo_segmento = '01'
  where  convert(int, mo_segmento) = 1
     and len(mo_segmento)         <> 2

  if @@error <> 0
  begin
    print 'Error en Actualizacion de 01'
  end

  print ' Datos de segmento en 2'
  select
    count(*)
  from   cobis..cl_mercado_objetivo_cliente
  where  convert(int, mo_segmento) = 2
     and len (mo_segmento)         <> 2

  print ' Actualizacion de 02'
  update cobis..cl_mercado_objetivo_cliente
  set    mo_segmento = '02'
  where  convert(int, mo_segmento) = 2
     and len (mo_segmento)         <> 2

  if @@error <> 0
  begin
    print 'Error en Actualizacion de 02'
  end

  print ' Datos de segmento en 3'
  select
    count(*)
  from   cobis..cl_mercado_objetivo_cliente
  where  convert(int, mo_segmento) = 3
     and len (mo_segmento)         <> 2

  print ' Actualizacion de 03'
  update cobis..cl_mercado_objetivo_cliente
  set    mo_segmento = '03'
  where  convert(int, mo_segmento) = 3
     and len (mo_segmento)         <> 2

  if @@error <> 0
  begin
    print 'Error en Actualizacion de 03'
  end

  print 'total de datos mal asignado finalmente'
  select
    mo_segmento,
    count(*)
  from   cobis..cl_mercado_objetivo_cliente
  where  len(mo_segmento) <> 2
  group  by mo_segmento
  with rollup

  select
    *
  from   cobis..cl_mercado_objetivo_cliente
  where  len(mo_segmento) <> 2

  print 'Segmento NULL'
  select
    count(1)
  from   cobis..cl_mercado_objetivo_cliente
  where  mo_segmento is null

  update cobis..cl_mercado_objetivo_cliente
  set    mo_segmento = '01'
  where  mo_segmento is null

  if @@error <> 0
  begin
    print 'Error en Actualizacion de segmento null'
  end

  update cobis..cl_ente
  set    en_sector = '000000'
  where  en_sector is null

  if @@error <> 0
  begin
    print 'Error en Actualizacion de sector null'
  end

  return 0

go

