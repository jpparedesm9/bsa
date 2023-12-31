/************************************************************************/
/*   Archivo:             remantfecha.sp                                */
/*   Stored procedure:    sp_mant_fecha                                 */
/*   Base de datos:  	  cob_remesas                                   */
/*   Producto:            Plazo Fijo                                    */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  19 de Julio de 2016                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA". Su uso no autorizado queda expresamente prohibido asi    */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Creacion Stored Procedure Cascara para instalacion de Plazo Fijo   */
/*   Version Davivienda                                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/************************************************************************/
use cob_remesas
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_mant_fecha')
   drop proc sp_mant_fecha
go

create proc sp_mant_fecha(
@i_fecha                                   datetime,
@i_operacion                               char(1)          = null,
@i_numdias                                 smallint         = null, 
@o_fecha_proc                              varchar(12)      = null OUT,
@o_iguales                                 char(1)          = null OUT,
@o_anio                                    smallint         = null OUT,
@o_mes                                     smallint         = null OUT,
@o_dia                                     smallint         = null OUT,
@o_week                                    smallint         = null OUT,
@o_min                                     smallint         = null OUT,
@o_hora                                    smallint         = null OUT
)
as
declare	
@w_sp_name		                           varchar(30),	
@w_return                                  int,
@w_ciudad_matriz                           int,
@w_dia_ing                                 smallint,
@w_dia_proc                                smallint,
@w_prx_mes		                           varchar(10),
@w_fecha_prx_ec		                       datetime,
@w_fecha_pri_ec		                       datetime

print '@i_fecha ' + cast(@i_fecha as varchar)

if @i_operacion = 'D'
   select @o_dia = datepart(dw, @i_fecha) 

if @i_operacion = 'M' -- Devuelve fecha inicial de un rango 
   select @o_fecha_proc = convert(varchar(12),dateadd(dd,-@i_numdias,@i_fecha),101)

if @i_operacion = 'U' begin
   -- Determinar el codigo de la ciudad de feriados nacionales
   select @w_ciudad_matriz  = pa_int
   from cobis..cl_parametro
   where pa_producto = 'CTE'
   and pa_nemonico = 'CMA'
       
   if @@rowcount <> 1 begin
      exec cobis..sp_cerror
      @i_num       = 201196,
      @i_msg       = 'ERROR NO SE HA DEFINIDO CIUDAD DE FERIADOS NACIONALES'
      return 205031
   end

   select @w_dia_ing      = datepart(dd, @i_fecha)
   select @w_prx_mes      = convert(varchar(10), dateadd(mm, 1, @i_fecha), 101)
   select @w_fecha_prx_ec = convert(datetime, substring(@w_prx_mes, 1, 2) + '/' + '01' + '/' + substring(@w_prx_mes, 7, 4))
	
   exec @w_return   = cob_remesas..sp_fecha_habil
   @i_val_dif       = 'N',
   @i_efec_dia      = 'S',
   @i_fecha         = @w_fecha_prx_ec,        
   @i_oficina       =  1,                      
   @i_dif           = 'N',
   @w_dias_ret      = -1,
   @o_ciudad_matriz = @w_ciudad_matriz  out,
   @o_fecha_sig     = @w_fecha_prx_ec out
	
   if @w_return <> 0
      return @w_return
      
   select @o_fecha_proc = @w_fecha_prx_ec
      select @w_dia_proc = datepart(dd, @o_fecha_proc)
   
   if @w_dia_ing = @w_dia_proc
      select @o_iguales = 'S'
      else
      select @o_iguales = 'N'           
   end
 
if @i_operacion = 'P' begin
   select @o_fecha_proc = substring(convert(varchar(12),@i_fecha,101), 1, 2) + '/' +'01' + '/' + substring(convert(varchar(12),@i_fecha,101), 7, 4)
end
else begin
   select @o_dia = datepart(dd, @i_fecha)
   select @o_mes = datepart(mm, @i_fecha)
   select @o_anio = datepart(yy, @i_fecha)
   select @o_week = datepart(weekday, @i_fecha)
   select @o_hora = datepart(hh, @i_fecha)
   select @o_min = datepart(mi, @i_fecha)
end  

return 0

GO
