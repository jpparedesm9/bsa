/************************************************************************/
/*      Archivo:                fcalmon.sp                              */
/*      Stored procedure:       sp_calc_cotiza                          */
/*      Stored procedure:       sp_calc_cotiza                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 06/Sep/95                               */
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
/*      Funcion que realiza el calculo de la cotizacion de              */
/*      una moneda con respecto a otra                                  */
/*                         			MODIFICACIONES                          */
/*  10/09/2001		MEMITO SABORIO 		Devuelve el tipo de cambio o factor */
/*                                  o tambien un select con los datos.  */
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

if exists (select 1 from sysobjects where name = 'sp_calc_cotiza')
   drop proc sp_calc_cotiza
go

create proc sp_calc_cotiza (
@s_ssn               int             = null,
@s_user              login           = null,
@s_term              varchar(30)     = null,
@s_date              datetime        = null,
@s_srv               varchar(30)     = null,
@s_lsrv              varchar(30)     = null,
@s_ofi               smallint        = null,
@s_rol               smallint        = NULL,
@t_debug             char(1)         = 'N',
@t_file              varchar(10)     = null,
@t_from              varchar(32)     = null,
@t_trn               smallint        = null,
@i_operacion         char(1),
@i_fecha	         datetime        = null,
@i_moneda1 	         smallint,
@i_moneda2 	         smallint        = 0,  
@i_empresa           tinyint         = 1,
@o_factor 	         float           = null  out,
@i_cualcambio        char(1)         = 'C', --C Compra, V Venta solo si @i_solotip = 'S'
@i_usafecha          char(1)         = 'N', --Utiliza la fecha obligatoriamente
@i_solotip           char(1)         = 'N')
with encryption
as
declare         
@w_sp_name           varchar(32),
@w_cot1		         float,
@w_cot2		         float,
@w_cot3		         float,
@w_cot4		         float,
@w_cotiza 	         float, 
@w_fecha_max	     datetime,
@w_moneda_base       tinyint  


select @w_sp_name = 'sp_calc_cotiza'

/** SE VERIFICA QUE LA TRANSACCION ESTE FUNCIONAL **/
if @t_trn <> 14439  --and @i_operacion <> 'Q'
begin
  exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141112
      /*  'Error en codigo de transaccion' */
  return 1
end  

/** SE OBTIENE LA MONEDA BASE DEL PAIS **/
select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
    exec cobis..sp_cerror
    @t_debug=@t_debug,
    @t_file=@t_file,
    @t_from=@w_sp_name, 
    @i_num = 601018
    return  1
end 

/** OPERACION DE BUSQUEDA DE EXISTENCIA                     **/
/** PARA ESTE NO UTILIZA LAS ULTIMAS 3 VARIABLES DE ENTRADA **/
if @i_operacion = 'S'
begin
  set rowcount 20
  select 'MONEDA'     = mo_descripcion,
	 'COTIZACION' = co_compra_billete
  from cobis..cl_moneda, pf_cotizacion
  where co_moneda = mo_moneda
  and co_fecha = @i_fecha
  and co_moneda > @i_moneda1
  order by co_hora
  
  return 0
end

/*** SE OBTIENE EL ULTIMO TIPO DE CAMBIO Y FACTOR DE LA TABLA DE COTIZACION ***/
if @i_usafecha = 'N' 
begin
   set rowcount 1
   select @w_cot1 = 1, @w_cot3 = 1, @w_cot2 = 1
   
   if @i_moneda1 <> @w_moneda_base
   begin
      select @w_cot1 = co_compra_billete,
      @w_cot3 = co_conta ,
      @w_cot4 = co_venta_billete  -- GES 03/19/2001 CUZ-002-018
      from pf_cotizacion                   
      where co_moneda = @i_moneda1
      and co_fecha = @s_date
      order by co_hora desc
      if @@rowcount = 0
      begin
         --print '1'
         exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 141136
         /*  'Rango no valido' */
         return 1 
      end 	 	
   end	

   --select @w_cot2 = 1, @w_cot4 = 1
   
   if @i_moneda2 <> @w_moneda_base
   begin
      select @w_cot2 = co_compra_billete, -- GES 03/27/2001 Se cambia por venta 
      @w_cot3 = co_conta ,
      @w_cot4 = co_venta_billete 
      from pf_cotizacion
      where co_moneda = @i_moneda2
        and co_fecha = @s_date
      order by co_hora desc
      if @@rowcount = 0
      begin
         --print 'imoneda 2 %1! moneda base %2!', @i_moneda2, @w_moneda_base
         exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
          @t_from       = @w_sp_name,
         @i_num        = 141136
         /*  'Rango no valido' */
         return 1
      end   
   end
   set rowcount 0
   select @o_factor = @w_cot1/@w_cot2, @w_cotiza = @w_cot1/@w_cot2
   
   if @i_solotip = 'N'
   begin
      select @w_cotiza, @w_cot1, @w_cot2, @w_cot3, @w_cot4
   end
   else 
   begin
      if @i_cualcambio = 'C' 
         select @o_factor = @w_cot2
      else
         select @o_factor = @w_cot4
   end
   return 0
end
else 
begin
   --*** Obtener la fecha maxima de la tabla de tipos de cambio ***
   SELECT @w_fecha_max = max(co_fecha) 
   FROM pf_cotizacion
   WHERE co_moneda = @i_moneda2
   AND co_fecha <= @i_fecha

   --*** Obtener tipo de cambios para la fecha solicitada ***
   SELECT @w_cot4 = isnull(co_venta_billete,0), @w_cot2 = isnull(co_compra_billete,0)
   FROM pf_cotizacion
   WHERE co_moneda = @i_moneda2
     AND co_fecha = @i_fecha

   if @w_cot4 = 0 or @w_cot2 = 0 
--*** Si para la fecha solicitada el tipo de cambio es 0 tomar la fecha  ***
--*** maxima de tipo de cambio para la moneda solicitada                 ***
      SELECT @w_cot4 = co_venta_billete, @w_cot2 = co_compra_billete 
      FROM pf_cotizacion
      WHERE co_moneda = @i_moneda2
      AND co_fecha = @w_fecha_max

   if @w_cot2 = 0 or @w_cot4 = 0 
   begin
      exec cobis..sp_cerror
      @t_debug=@t_debug,
      @t_file=@t_file,
      @t_from=@w_sp_name, 
      @i_num = 601018
      return  1
   end

--*** Obtener la fecha máxima de la tabla de tipos de cambio ***
   SELECT @w_fecha_max = max(co_fecha) 
   FROM pf_cotizacion
   WHERE co_moneda = @i_moneda1
     AND co_fecha <= @i_fecha

--*** Obtener tipo de cambios para la fecha solicitada ***
   SELECT @w_cot3 = isnull(co_venta_billete,0), @w_cot1 = isnull(co_compra_billete,0)
   FROM pf_cotizacion
   WHERE co_moneda = @i_moneda1
     AND co_fecha = @i_fecha

   if @w_cot3 = 0 or @w_cot1 = 0 
--*** Si para la fecha solicitada el tipo de cambio es 0 tomar la fecha  ***
--*** máxima de tipo de cambio para la moneda solicitada                 ***
      SELECT @w_cot3 = co_venta_billete, @w_cot1 = co_compra_billete 
      FROM pf_cotizacion
      WHERE co_moneda = @i_moneda1
      AND co_fecha = @w_fecha_max

   if @w_cot1 = 0 or @w_cot3 = 0 
   begin
      exec cobis..sp_cerror
      @t_debug=@t_debug,
      @t_file=@t_file,
      @t_from=@w_sp_name, 
      @i_num = 601018
      return  1
   end

   select @o_factor = @w_cot1/@w_cot2, @w_cotiza = @w_cot1/@w_cot2

   if @i_solotip = 'N'
   begin
      select @w_cotiza, @w_cot1, @w_cot2, @w_cot3, @w_cot4
   end
   else 
   begin
      if @i_cualcambio = 'C' 
         select @o_factor = @w_cot2
      else
         select @o_factor = @w_cot4
      end
   return 0
end
go
