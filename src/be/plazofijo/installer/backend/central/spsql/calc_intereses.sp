/************************************************************************/
/*      Archivo:                fcalcint.sp                             */
/*      Stored procedure:       sp_calc_intereses                       */
/*      Stored procedure:       sp_calc_intereses                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
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
/*      Funcion que realiza el calculo de los intereses                 */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      24-Oct-94  Juan Lam           Creacion                          */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_calc_intereses')
   drop proc sp_calc_intereses
go

create proc sp_calc_intereses (
@tasa                float,
@monto               decimal(30,16),
@dias_anio           smallint        = 360,
@num_dias            smallint        = 1,
@intereses           decimal(30,16)  output)
with encryption
as
declare
@w_numdecitasa       tinyint,
@w_numdecitasa2      float,
@w_tasa_temporal1    float,
@w_tasa_temporal2    float,
@w_factor            float,
@w_aplicafactor      char(2)

/*
V1 =  redondear (Tasa_nominal; Numdec_tasa_nominal) /100;
V2 =  V1 / Base_calculo
Factor =  redondear (V2 * Días_a_calcular ; Numdec)
Intereses = Monto * factor
*/

select @w_numdecitasa = pa_float
from   cobis..cl_parametro
where  pa_nemonico = 'NDT'
and    pa_producto = 'PFI'

select @w_numdecitasa2 = pa_float
from   cobis..cl_parametro
where  pa_nemonico = 'CDPCF'
and    pa_producto = 'PFI'

select @w_aplicafactor = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'AFSN'
and    pa_producto = 'PFI'

if @w_aplicafactor = 'S'
begin
   select @w_tasa_temporal1 = round(@tasa, @w_numdecitasa) /100
   select @w_tasa_temporal2 = @w_tasa_temporal1/@dias_anio
   select @w_factor         = round((@w_tasa_temporal2 * @num_dias),@w_numdecitasa2)
   select @intereses        = @monto * @w_factor
end
else
begin
   select @intereses = (@tasa * @monto * @num_dias) / (100 * @dias_anio)   
end

select @intereses
return
go
