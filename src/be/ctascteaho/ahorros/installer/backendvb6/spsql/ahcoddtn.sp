/************************************************************************/
/* Archivo:                ahcoddtn.sp                                  */
/* Stored procedure:       sp_ahcoddtn                                  */
/* Base de datos:          cob_ahorros                                  */
/* Producto:               Ahorros                                      */
/* Disenado por:           Andres Diab                                  */
/* Fecha de escritura:     07/05/2012                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
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
/*                         PROPOSITO                                    */
/* Busca codigos para DTN asociados a un producto y  categoria.         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/* FECHA          AUTOR                  RAZON                          */
/* 07/05/2012     Andres Diab            Emision Inicial                */
/* 02/Mayo/2016   Ignacio Yupa           Migración a CEN                */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  id = object_id('sp_ahcoddtn'))
  drop proc sp_ahcoddtn
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahcoddtn
(
  @t_show_version bit = 0,
  @i_cuenta       varchar(24),
  @i_oficina      int,-- OFICINA DE LA CUENTA
  @i_prod_banc    smallint,-- PRODUCTO BANCARIO DE LA CUENTA
  @i_categoria    char(1),-- CATEGORIA DE LA CUENTA
  @i_tipocta      varchar(10),-- TIPO DE CUENTA ah_tipocta
  @o_codigo_dtn   char(2) = null out,
  @o_profinal     int = null out
)
as
  declare
    @w_sp_name       varchar(30),
    @w_msg           varchar(64),
    @w_error         int,
    @w_sucursal      smallint,
    @w_mercado       smallint,
    @w_fecha_proceso datetime

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ahcoddtn'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Fecha de proceso */
  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  /* Obtengo Sucursal */
  select
    @w_sucursal = of_regional
  from   cobis..cl_oficina
  where  of_oficina = @i_oficina
  if @w_sucursal is null
  begin
    select
      @w_msg = 'sp_ahcoddtn: NO EXISTE SUCURSAL PARA LA OFICINA DADA',
      @w_error = 250001
    goto ERROR
  end

  /* Obtengo Mercado */
  select
    @w_mercado = me_mercado
  from   cob_remesas..pe_mercado
  where  me_pro_bancario = @i_prod_banc
     and me_tipo_ente    = @i_tipocta
  if @w_mercado is null
  begin
    select
      @w_msg =
'sp_ahcoddtn: NO EXISTE CODIGO MERCADO PARA EL PRODUCTO Y TIPO DE CUENTA DADOS '
  ,
@w_error = 250002
  goto ERROR
end

  /* Obtengo Producto Final */
  select
    @o_profinal = pf_pro_final
  from   cob_remesas..pe_pro_final
  where  pf_sucursal = @w_sucursal
     and pf_mercado  = @w_mercado
  if @o_profinal is null
  begin
    select
      @w_msg =
      'sp_ahcoddtn: NO EXISTE PRODUCTO FINAL PARA LA SUCURSAL Y MERCADO DADOS',
      @w_error = 250003
    goto ERROR
  end

  select
    @o_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(pd_codigo_dtn)),
                          2)
  from   cob_ahorros..ah_param_dtn
  where  pd_sucursal  = @w_sucursal
     and pd_profinal  = @o_profinal
     and pd_categoria = @i_categoria
  if @o_codigo_dtn is null
  begin
    select
      @w_msg =
'sp_ahcoddtn: NO EXISTE CODIGO DTN PARA EL PRODUCTO FINAL Y CATEGORIA DADOS'
,
@w_error = 250004
goto ERROR
end

  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'Operador',
    @i_tran        = @w_error,
    @i_cuenta      = @i_cuenta,
    @i_descripcion = @w_msg

  return @w_error

go

