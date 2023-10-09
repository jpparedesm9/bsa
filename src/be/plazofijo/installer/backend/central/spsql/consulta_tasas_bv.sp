/************************************************************************/
/*      Archivo:                contas_bv.sp                            */
/*      Stored procedure:       sp_consulta_tasas_bv                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 28/09/2001                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para la consulta de las     */
/*      tasas de los intereses vigentes por producto(tipo de deposito). */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      28/09/2001 Memito Saborio  Emision inicial                      */
/*      07/03/2002 Paul Borja      Cambios para cambio de presentacion en WEB */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_tasas_bv')
   drop proc sp_consulta_tasas_bv
go

create proc sp_consulta_tasas_bv(
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_tipo_deposito        varchar(5)      = '225',
@i_moneda               smallint        = 1,
@i_modo                 smallint        = 0,
@i_monto                varchar(5)      = NULL,  
@i_plazo                varchar(5)      = NULL,
@i_formato_fecha        int 		    = 101,
@i_val_monto            money           = 0)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               tinyint,
@w_tipo_deposito	    varchar(5),  
@w_num 		            smallint,
@w_param 	            smallint,
@w_registros 	        smallint

select @w_sp_name = 'sp_consulta_tasas_bv'

if @t_trn <> 14814
begin
  exec cobis..sp_cerror 
				@t_debug = @t_debug,
	      @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num = 141167
  return 1
end


if not exists(select * from pf_tipo_deposito
							where td_mnemonico = @i_tipo_deposito )
begin
 	print 'Tipo de deposito de plazo fijo no existe.'
 	return 1
end

if not exists(select * from cobis..cl_moneda
							where mo_moneda = @i_moneda)
begin
 	print 'Moneda ingresada no existe.'
 	return 1
end

-- PBO Parametro con el numero de plazos por tipo de deposito lo devuelvo y lo guardo
select 'Parametro' = count(distinct(ta_tipo_plazo)) 
from pf_tasa
where ta_tipo_deposito = @i_tipo_deposito
select  @w_param = count(distinct(ta_tipo_plazo)) 
from pf_tasa
where ta_tipo_deposito = @i_tipo_deposito

if @w_param = 0   -- PBO  01-04-2002
  select @w_param = 1    --  Para el caso de productos que no tienen tasas

-- PBO Calculo del rowcount de acuerdo a la cantidad de plazos inmediato menor a 20
select @w_num = 20%@w_param
select @w_registros = 20-@w_num
select @w_num  -- Lo devuelvo para siguientes

-- set rowcount @w_registros  -- PBO inicialmente se envía todo  01-04-2002
set rowcount 0

if @i_modo = 0
  select 
      'CodMonto' = pf_tasa.ta_tipo_monto,
      'Monto' = pf_monto.mo_descripcion,
      'CodPlazo' = pf_tasa.ta_tipo_plazo,
      'Plazo' = pf_plazo.pl_descripcion,
      'Fecha' = convert(char(10), pf_tasa.ta_fecha_mod, @i_formato_fecha),
      'Tasa' = pf_tasa.ta_vigente,
      'Monto Valor' = pf_monto.mo_monto_min
  from pf_tasa, pf_plazo, pf_monto
  where pf_tasa.ta_tipo_deposito = @i_tipo_deposito
    and pf_tasa.ta_moneda = @i_moneda
    and pf_tasa.ta_tipo_monto = pf_monto.mo_mnemonico
    and pf_tasa.ta_tipo_plazo = pf_plazo.pl_mnemonico
	order by pf_monto.mo_monto_min,  pf_plazo.pl_plazo_min  -- PBO


if @i_modo = 1 
  select 
      'CodMonto' = pf_tasa.ta_tipo_monto,
      'Monto' = pf_monto.mo_descripcion,
      'CodPlazo' = pf_tasa.ta_tipo_plazo,
      'Plazo' = pf_plazo.pl_descripcion,
      'Fecha' = convert(char(10), pf_tasa.ta_fecha_mod, @i_formato_fecha),
      'Tasa' = pf_tasa.ta_vigente,
      'Monto Valor' = pf_monto.mo_monto_min
  from pf_tasa, pf_plazo, pf_monto
  where pf_tasa.ta_tipo_deposito = @i_tipo_deposito
    and pf_tasa.ta_moneda = @i_moneda
    and pf_tasa.ta_tipo_monto = pf_monto.mo_mnemonico
    and pf_tasa.ta_tipo_plazo = pf_plazo.pl_mnemonico
    and pf_monto.mo_monto_min > @i_val_monto
	order by pf_monto.mo_monto_min,  pf_plazo.pl_plazo_min  -- PBO

   
set rowcount 0
return 0
go
