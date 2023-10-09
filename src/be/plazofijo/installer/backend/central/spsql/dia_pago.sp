/*diapago.sp*/
/************************************************************************/
/*      Archivo:                diapago.sp                              */
/*      Stored procedure:       sp_dia_pago                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Nidia Silva                             */
/*      Fecha de documentacion: 24-May-2005                             */
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
/*      Este procedimiento devuelve la fecha de pr¢ximo pago de         */
/*      acuerdo con el dia de pago elegido por el usuario               */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR              RAZON                          */
/*      24-May-2005   G. Arboleda        Emsion Inicial                 */
/*      17-May-06     Clotilde Vargas    Agregar tolerancia y 1er dia   */            
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type ='P' and name = 'sp_dia_pago')
   drop proc sp_dia_pago
go

create procedure sp_dia_pago( 
@i_fecha               datetime,
@i_dia_pago            tinyint,
@o_fecha_proximo_pago  datetime out)
with encryption
as
declare
   	@w_anio_prox_pago       smallint,-- GAR GB-DP00120
   	@w_mes_prox_pago        tinyint, -- GAR GB-DP00120
   	@w_max_dias_mes         tinyint, -- GAR GB-DP00120
	@w_cont                 int,	 -- CVA May-09-06 
	@w_di_mes               char(2),
	@w_di_anio              char(4),
   	@w_di_dias              char(2),
	@w_di_mes_int           int,
    @w_di_anio_int          int,
	@w_di_dias_int          int,
	@w_dias_orig            int,
    @w_dia_tolerancia       tinyint,
    @w_dia_tolerancia_neg   int,
	@w_meses_di             int            



begin
   -------------------------------
   -- Inicializacion de variables
   -------------------------------
   select @w_cont = 0,
          @w_dia_tolerancia = 15,
          @w_dia_tolerancia_neg  = -15

   select @w_meses_di = 1

   --------------------------------------------------------------------------	 				
   -- Obtener fecha de proximo pago de interes y controles para dias de pago
   --------------------------------------------------------------------------
   while  @w_cont = 0
   begin	
   
      -------------------------------------------------------
      -- Obtener las partes de la fecha original enviada
      -------------------------------------------------------		
      select @w_di_mes_int   = datepart(mm, @i_fecha),
             @w_di_anio_int  = datepart(yy, @i_fecha),
             @w_dias_orig    = datepart(dd, @i_fecha),
             @w_di_dias_int  = @i_dia_pago,
             @w_cont         = 0
                                              
       if (@w_dias_orig - @i_dia_pago) >= @w_dia_tolerancia
          select @w_di_mes_int = @w_di_mes_int + 1   

      ----------------------
      -- Control para meses 
      ----------------------
      if @w_di_mes_int >= 13
      begin
         select @w_di_anio_int = @w_di_anio_int + 1
         select @w_di_mes_int  = 1
      end
                        
      if (@w_dias_orig - @i_dia_pago) <= @w_dia_tolerancia_neg
         select @w_di_mes_int = @w_di_mes_int - 1   

      ----------------------------------------------
      -- Control para primer mes del siguiente añio
      ----------------------------------------------                   
      if @w_di_mes_int = 0
         select @w_di_mes_int = @w_di_mes_int + 1   

      ------------------------
      -- Control dias del mes
      ------------------------
      if @w_di_mes_int in (4,6,9,11) and @w_di_dias_int > 30
          select @w_di_dias_int = 30
   
      --------------------------------
      -- Verificacion de año biciesto
      --------------------------------
      if @w_di_mes_int = 2 and @w_di_dias_int > 28
         if @w_di_anio_int % 4 = 0
            select @w_di_dias_int = 29
         else
            select @w_di_dias_int = 28

      --------------------------------------------------------
      -- Obtener la nueva fecha en base al dia de pago fijado
      --------------------------------------------------------
      select @w_di_mes  = convert(char(2), @w_di_mes_int),
             @w_di_anio = convert(char(4), @w_di_anio_int),
             @w_di_dias = convert(char(2), @w_di_dias_int)
      
      select @o_fecha_proximo_pago = convert(datetime, @w_di_mes + '/' +
            		                  	convert(char(2),  @w_di_dias) + '/' +
         	                                          @w_di_anio)      

      select @w_cont = 1

   end --Del while

end



--print 'diapago.sp'
return 0
go
