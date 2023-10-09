/************************************************************************/
/*       Archivo:                mdfunc.sp                              */
/*       Stored procedure:       sp_funcion_1                           */
/*       Base de datos:          cob_mdinero                            */
/*       Producto:               MESA DE DINERO                         */ 
/*       Disenado por:           R. Minga Vallejo /L. Carrasco          */
/************************************************************************/
/*                             IMPORTANTE                               */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes  exclusivos  para el  Ecuador  de la     */
/*    'NCR CORPORATION'.                                                */
/*    Su  uso no autorizado  queda expresamente  prohibido asi como     */
/*    cualquier   alteracion  o  agregado  hecho por  alguno de sus     */
/*    usuarios   sin el debido  consentimiento  por  escrito  de la     */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/*                             PROPOSITO                                */
/*                                                                      */
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR                  RAZON          */
/*   09/29/2003        Ricardo Alvarez     Ajuste Ley 514 COLOMBIA   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_funcion_1')
   drop proc sp_funcion_1
go
create proc sp_funcion_1 (
   @t_debug                varchar(2)     = 'N',
   @i_operacion            char (10),
   @i_modo                 tinyint        = NULL,
   @i_tipo                 char (1)       = NULL,
   @i_fechai               datetime       = NULL,
   @i_fechaf               datetime       = NULL,
   @i_mes                  int            = NULL,
   @i_dias                 int            = NULL,
   @i_tipcal               tinyint        = NULL,
   @i_dia_pago             tinyint        = NULL,      --*-*LEY 514 para COLOMBIA
   @i_batch                int            = 1,         --*-*LEY 514 para COLOMBIA
   @o_dias                 int            = NULL out,
   @o_fecha                datetime       = NULL out
)
with encryption
as
declare
   @w_mesi                 float,
   @w_mesf                 float,
   @w_diai                 int, 
   @w_diaf                 int, 
   @w_dias                 int,
   @w_dias1                int,           --*-*
   @w_msg                  varchar(70),   --*-*
   @w_fechaf               datetime,
   @w_mes                  int,
   @w_anio                 int,
   @w_charmes              char(2),
   @w_chardias             char(2),
   @w_residuo_anio         int, --xca 06/Ene/99 Anio Viciesto
   @w_intmes               int, --xca 06/Ene/99 Anio Viciesto
   @w_intdia               int,  --xca 06/Ene/99 Anio Viciesto
   @w_mes_comer            int, --xca 05/abr/99 dia 31 
   @w_dias_comer           int,  --xca 05/abr/99 dia 31
   @w_mes_ini              int, --xca 09/abr/99 dia 31 
   @w_residuo_mes          int, --xca 09/abr/99 dia 31 
   @w_quociente_anio       int,  --xca 09/abr/99 dia 31 
   @w_error                varchar(50),
   @w_ult_dia_mes_pago     int,            --*-*LEY 514 para COLOMBIA
   @w_dias_int_fcom	   smallint,	--*-*				RVVUNICA   
   @w_aplicar_febrero_com  char(1),
   @w_debug                char(1),
   @w_ult_dia_fechaf       int
 
 select @w_debug = 'N'
 
/* ** Diferencia entre dos fechas tomando meses de 30 dias ** */
if @i_operacion = 'DIFE30'
begin

	select @w_aplicar_febrero_com = 'S'

   	if datepart(dd, @i_fechai) = 31 begin
   	   select @i_fechai = dateadd(dd, -1, @i_fechai)
   	end

   	    if datepart(dd, @i_fechaf) = 31 and datepart(dd, @i_fechai) >= 30 
   	    begin
   	       select @i_fechaf = dateadd(dd, -1, @i_fechaf)
   	end


        if @t_debug = 'S' print 'i_fechai' +  cast(@i_fechai as varchar)
        if @t_debug = 'S' print 'i_fechaf' +  cast(@i_fechaf as varchar)
        if @t_debug = 'S' print '--' 

	select @w_dias = 0
	while @i_fechai < @i_fechaf
	begin

		select @w_dias_int_fcom = 1

		--*-* SI ES ULTIMO DÍA DE FEBRERO CALCULA LOS DIAS QUE LE FALTAN PARA CUMPLIR 30 DIAS
		select @w_ult_dia_mes_pago = datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@i_fechai))*(-1),dateadd(mm,1,@i_fechai)))


		--*-* SI ES UN 31 NO DEBE CALCULAR
		if datepart(dd,@i_fechai) = 31 
		   select @w_dias_int_fcom = 0
		
		
		if datepart(mm,@i_fechai) = 2 and datepart(dd,@i_fechai) = @w_ult_dia_mes_pago 
		   select @w_dias_int_fcom = 30 - @w_ult_dia_mes_pago  + 1
		
		select @w_dias = @w_dias + @w_dias_int_fcom
	  
		-- aumenta fecha
		select @i_fechai = dateadd(dd,1,@i_fechai)

        	if @t_debug = 'S' print 'w_dias' +  cast(@w_dias as varchar)
        	if @t_debug = 'S' print 'i_fechai' +  cast(@i_fechai as varchar)

	end

	select @o_dias = @w_dias
   
	return 0
end

/* ** Retorna una fecha cualquiera sumando un numero de meses ** */

if @i_operacion = 'SUMMES'
begin
   /* @i_fechai  fecha a la que se suma los meses */
   /* @i_mes     meses que se suman a @i_fecha (periodo de vencimiento
      de cupones 1=mensual  6=semestral */
   /* @i_tipcal  si es 0 toma meses de 30 dias, si es 1 toma mes con 
      dias corridos */ 
  
 
   select @w_anio = datepart(yy,@i_fechai)
   select @w_mes = datepart(mm,@i_fechai) + @i_mes

   if @w_mes > 0
   begin
      select @w_anio = @w_anio + (@w_mes-1)/12
      select @w_mes = @w_mes % 12 
   end
   else
   begin
      select @w_anio = @w_anio + (@w_mes-12)/12
      select @w_mes = 12 + (@w_mes % 12 )
   end

   if @w_mes = 0
      select @w_mes = 12

   /* Toma meses de 30 dias */
   if @i_tipcal = 0
   begin
      if datepart(dd,@i_fechai) > 28 and @w_mes = 2
         if @w_anio / 4.0 = @w_anio/4
            select @w_dias = 29  /* anio bisiesto */
         else
            select @w_dias = 28  /* anio normal */
      else 
         if datepart(dd,@i_fechai) > 30 and (@w_mes in (4,6,9,11))
            select @w_dias = 30
         else
            select @w_dias = datepart(dd,@i_fechai)
   end
   else
   begin
      /* Cuando debe retornar obligatoriamente con el ultimo dia del mes */
      select @w_dias = convert(int,substring('312831303130313130313031',@w_mes*2-1,2))
      if @w_mes = 2 and @w_anio / 4.0 =  @w_anio / 4
      select @w_dias = 29
   end

   if @w_dias > 9
      select @w_chardias = convert(char(2),@w_dias)
   else
      select @w_chardias = '0' + convert(char(1),@w_dias)
   
   if @w_mes > 9
      select @w_charmes = convert(char(2),@w_mes)
   else
      select @w_charmes = '0' + convert(char(1),@w_mes)

   if @w_charmes IS NULL or @w_chardias IS NULL OR @w_anio IS NULL
   begin
      exec cobis..sp_cerror
         @i_msg        = 'Fecha invalida',
         @i_num           = 999999
      select @w_fechaf = NULL
   end
   else
   begin
      --set arithabort arith_overflow off
      select @w_fechaf = convert(datetime,@w_charmes+'/'+@w_chardias+'/'+convert(char(4),@w_anio))
      if @@Error <> 0
      begin
         select @w_error = 'Fecha invalida ' + @w_charmes+'/'+@w_chardias+'/'+convert(char(4),@w_anio)
         exec cobis..sp_cerror
            @i_msg        = @w_error,
            @i_num           = 999999
      end
         --set arithabort arith_overflow on
   end

   /* Se coloca en formato mm/dd/yy pues este dato regresa al sp para proceso, no va al front - end */
   select @o_fecha = convert(char(10),@w_fechaf,101)
end

/* ** Retorna una fecha cualquiera sumando un numero de dias ** */
if @i_operacion = 'SUMDIA'
begin
	select @w_aplicar_febrero_com = 'S'

   	if datepart(dd, @i_fechai) = 31 begin
   	   select @i_fechai = dateadd(dd, -1, @i_fechai)
   	end

        select @w_aplicar_febrero_com = 'S'

	select @o_fecha = @i_fechai
	select @w_dias = 0
 
        
        if @t_debug = 'S' print '@o_fecha ' + cast(@o_fecha as varchar)
        if @t_debug = 'S' print '@i_dias ' + cast(@i_dias as varchar)
        
	while @w_dias < @i_dias
	begin

		select @w_dias_int_fcom = 1
		--*-* SI ES UN 31 NO DEBE CALCULAR

		if datepart(dd,@o_fecha) = 31
		select @w_dias_int_fcom = 0

		--*-* SI ES ULTIMO DÍA DE FEBRERO CALCULA LOS DIAS QUE LE FALTAN PARA CUMPLIR 30 DIAS
		select @w_ult_dia_mes_pago = datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@o_fecha))*(-1),dateadd(mm,1,@o_fecha)))

		
		if datepart(mm,@o_fecha) = 2 and datepart(dd,@o_fecha) = @w_ult_dia_mes_pago begin

		   if ( (@i_dias - (@w_dias + 1)) = 0 )  --si es febrero y la fecha final tambien es ultimno dia febrero no aplica fecha comercial
	   	      select @w_aplicar_febrero_com = 'N'

		   if @w_aplicar_febrero_com = 'S'
		      select @w_dias_int_fcom = 30 - @w_ult_dia_mes_pago  + 1

        end		
			
		-- aumenta fecha
		select @o_fecha = dateadd(dd,1,@o_fecha)
		select @w_dias = @w_dias + @w_dias_int_fcom

        if @t_debug = 'S' print '@w_dias ' + cast(@w_dias as varchar)
        if @t_debug = 'S' print '@o_fecha ' + cast(@o_fecha as varchar)


		-- validacion para cuando ultimo dia del ciclo cae en 31
		if @w_dias  = @i_dias  begin

		
            if datepart(dd,@o_fecha) = 31 and datepart(dd, @i_fechai) >= 30 
            begin  -- AL HACER DIFERENCIA 31 NO SE CUENTA POR ESO AL HACER SUMA NO SE DEBE CONTEMPLAR
		       select @o_fecha = dateadd(dd,1,@o_fecha)
		       select @w_dias = @w_dias + @w_dias_int_fcom
		    end

		    
            if datepart(dd,@o_fecha) = 31 and datepart(dd, @i_fechai) = 1 
            begin  -- DIA DE APERTURA 1 DEL MES
		       select @o_fecha = dateadd(dd,1,@o_fecha)
		       select @w_dias = @w_dias + @w_dias_int_fcom
		    end
		    
            if datepart(dd,@o_fecha) = 30 and  @i_dia_pago = 31 begin -- FECHAS DE VENCIMIENTO INGRESADO POR FRONT END CAE EN 31 
		       select @o_fecha = dateadd(dd,1,@o_fecha)
		    end

         end

	end  
	
	select @w_fechaf = @o_fecha
   
FINAL:

   if @i_batch = 1       --*-*
   begin

   
      exec sp_funcion_1 @i_operacion = 'DIFE30',
                @i_fechai   = @i_fechai,
                @i_fechaf   = @w_fechaf,
                @i_dia_pago = @i_dia_pago,
                @o_dias     = @w_dias1  out
if @t_debug = 'S' print 'i_fechai:'+cast(@i_fechai as varchar) + ' w_fechaf:'+cast(@w_fechaf as varchar)+  ' @i_dias:'+ cast(@i_dias as varchar)+ ' @w_dias1:'+ cast(@w_dias1 as varchar)
      
      if @i_dias <> @w_dias1 and datepart(dd, @w_fechaf) <> 31 
      begin
         select @w_msg = 'Operacion debe negociarse a' + ' ' + convert(varchar,@w_dias1) + ' ' + 'dias'
         exec cobis..sp_cerror
            /*@t_debug        = @t_debug,
            @t_file        = @t_file,
            @t_from        = @w_sp_name,*/
            @i_msg         = @w_msg,
            @i_num         = 141154
         return 1    
      end
   end

   select @o_fecha = convert(char(10),@w_fechaf,101)
   --print 'mdfunc.sp --> o_fecha:%1!',@o_fecha
end
                                                                                                                                                                                                                                       
go
