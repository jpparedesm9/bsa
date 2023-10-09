/************************************************************************/
/*  Archivo:            datepart.sp           				*/
/*  Stored procedure:   sp_datepart                                     */
/*  Base de datos:      cobis                  				*/
/*  Producto:           ADMIN                                           */
/*  Disenado por:       Juan Carlos Ruales                              */
/*  Fecha de escritura: 06-Ene-2009                 			*/
/************************************************************************/
/*                       IMPORTANTE             			*/
/*                                                                      */
/*  Este programa es parte de los paquetes bancarios propiedad de   	*/
/*  "MACOSA", representantes exclusivos para el Ecuador de la   	*/
/*  "NCR CORPORATION".                      				*/
/*  Su uso no autorizado queda expresamente prohibido asi como  	*/
/*  cualquier alteracion o agregado hecho por alguno de sus     	*/
/*  usuarios sin el debido consentimiento por escrito de la     	*/
/*  Presidencia Ejecutiva de MACOSA o su representante.     		*/
/************************************************************************/
/*                         PROPOSITO          				*/
/*                                                                      */
/*  Este programa devuelve valores relacionados con la fecha de      	*/
/*  ingreso enviada.             					*/
/************************************************************************/
/*                     MODIFICACIONES              			*/
/*                                                                      */
/*  FECHA           AUTOR         RAZON               			*/
/*  06/Ene/2009     JRU           Emision Inicial                       */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_datepart')
   drop proc sp_datepart
go

create procedure sp_datepart
(
   @i_fecha 	 datetime,      	 --Parametro obligatorio fecha
   @i_formato    smallint = 101,	 --Parametro con el formato de la fecha defaul mm/dd/yyyy
   @i_factor     smallint = 0,	         --Parametro con la cantidad de dias, meses o años que se desean a¤adir o restar dependiendo del signo
   @i_parte      char(2)  = 'dd',        --Parametro que indica si se  dicionan/restan dias. meses o años
   @o_anio  	 smallint = null out,  	 --Parametro de salida opcional, retorna año
   @o_mes   	 smallint = null out,    --Parametro de salida opcional, retorna mes
   @o_dia   	 smallint = null out,    --Parametro de salida opcional, retorna dia
   @o_week  	 smallint = null out,    --Parametro de salida opcional, retorna la semana de la fecha ingresada
   @o_weekday  	 smallint = null out,    --Parametro de salida opcional, retorna dia de la semana de la fecha ingresada
   @o_fecha  	 varchar(20) = null out, --Parametro de salida opcional, retorna la fecha ingresada con formato MM/DD/YYYY
   @o_fechaf 	 varchar(20) = null out, --Parametro de salida opcional, retorna la fecha ingresada con el formato indicado en @i_formato
   @o_fecha_f  	 varchar(20) = null out, --Parametro de salida opcional, retorna el primer dia del mes de acuerdo a la fecha ingresada
   @o_fecha_u  	 varchar(20) = null out, --Parametro de salida opcional, retorna el ultimo dia del mes de acuerdo a la fecha ingresada
   @o_fecha_6  	 varchar(20) = null out, --Parametro de salida opcional, retorna la fecha resultante de restar 6 dias de la fecha enviada
   @o_fecha_x  	 varchar(20) = null out  --Parametro de salida opcional, retorna la fecha resultante de restar/sumar x dias de la fecha enviada


)
as 
   
   select @o_anio    = datepart(yy,@i_fecha)
   select @o_mes     = datepart(mm, @i_fecha)
   select @o_dia     = datepart(dd, @i_fecha)
   select @o_week    = datepart(wk, @i_fecha)
   select @o_weekday = datepart(dw, @i_fecha)
   select @o_fechaf  = convert(char,@i_fecha,@i_formato) 	
   select @o_fecha_f = convert(char,dateadd(dd,-(datepart(dd,@i_fecha))+1,@i_fecha),@i_formato)
   select @o_fecha   = convert(char,@i_fecha,101)
   select @o_fecha_u = convert(char(10),dateadd (dd,-1,dateadd (mm,1,convert(char,datepart(mm,@i_fecha)) + '/01/' + convert(char,datepart(yy,@i_fecha)))), 101) 
   select @o_fecha_6 = convert(varchar(10),dateadd(dd,1,dateadd(dd,-6,@i_fecha)),@i_formato)
   select @o_fecha_x = CASE @i_parte
		            WHEN 'dd' THEN convert(varchar(10),dateadd(dd,@i_factor,@i_fecha),@i_formato)
                            WHEN 'mm' THEN convert(varchar(10),dateadd(mm,@i_factor,@i_fecha),@i_formato)
                            WHEN 'yy' THEN convert(varchar(10),dateadd(yy,@i_factor,@i_fecha),@i_formato)
                            WHEN 'dw' THEN convert(varchar(10),dateadd(dw,@i_factor,@i_fecha),@i_formato)
                       END
go
