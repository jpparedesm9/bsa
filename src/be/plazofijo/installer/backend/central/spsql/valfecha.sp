/************************************************************************/
/*      Archivo:                valfecha.sp                             */
/*      Stored procedure:       sp_valida_fecha                         */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script cambia a las op.  de plazo fijo a estado activo     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      Abr-11-07  Clotilde Vargas  Se agrega flag para obtener la      */
/*                                  fecha valor laborable si se requiere*/
/*      28-Ago-2007 N. Silva        Correcci¢n variables de salida      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_valida_fecha')
   drop proc sp_valida_fecha
go

create proc sp_valida_fecha(
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_sesn                 int             = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_fecha                datetime        = NULL,
      @i_toperacion           catalogo        = NULL,
      @i_plazo                int             = NULL,
      @i_modo                 smallint        = NULL, --04/04/2000 Fecha Comercial
      @i_fecha_fin            datetime        = NULL, --04/04/2000 Fecha Comercial
      @i_flag_renovaut        char(1)         = 'N', -- 06-Abr-2000 xca para renovaut
      @i_flag_valfvdnl        char(1)         = 'S',   --CVA Abr-11-07
      @i_tran_sabado          char(1)         = 'S', -- GES 05/11/01 CUZ-009-030
      @i_max_ttransito        tinyint         = 0,
      @i_dias_reales          char(1)         = 'N',
      @i_formato_fecha        int             = 101, 
      @i_dia_pago             int             = NULL,     --*-*
      @i_batch                int             = 1,     --*-*
      @i_nem_tipo_deposito    varchar(20)     = null,
      @o_num_dias_labor       tinyint         = 0 out  -- 06-Abr-2000 xca para renovaut
)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
        @w_fecha_hoy                    datetime,
        @w_dia_pago                     int,  --*-*
        @w_fecha_temp                   datetime,
        @w_dias                         tinyint,
        @w_dias_360                     int,--04/04/2000 Fecha Comercial
        @w_resultado                    char(1),
        @w_resultado1                   char(1),

        @w_fecha_valor_con_hold         datetime,
        @w_fecha_vencimiento_con_hold   datetime,
        @w_fecha_valor                  datetime,
        @w_fecha_vencimiento            datetime,
        @w_fecha_aux_ven                datetime,
        @w_resul_validacion             char(1),
        @w_cuenta_dias                  tinyint,
        @w_plazo_hold                   int,  --LIM 13/DIC/2005
        @w_tipo_deposito                int

---------------------------------------------------
-- Inicializacion
---------------------------------------------------
select @w_sp_name = 'sp_valida_fecha'
select @w_resultado = '0'
select @w_resultado1 = '0'

 
/**  VERIFICAR CODIGO DE TRANSACCION DE ACTIVACION  **/

if  ( @t_trn <> 14446)
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141040
      return 1
end

if @i_nem_tipo_deposito is not null and @i_nem_tipo_deposito <> '' begin

   select   @w_tipo_deposito = 0

   select   @w_tipo_deposito = isnull(td_tipo_deposito,0)
   from     pf_tipo_deposito
   where    td_mnemonico = @i_nem_tipo_deposito

--print 'i_nem ' + convert(char(30), @i_nem_tipo_deposito)
--print 'w_tipodepo '  + convert(char(30),@w_tipo_deposito)

end

if @t_debug = 'S' print ' i_nem_tipo_deposito ' + cast(@i_nem_tipo_deposito as varchar)
if @t_debug = 'S' print ' w_tipo_deposito ' + cast(@w_tipo_deposito as varchar)


if @w_tipo_deposito = 0 or @w_tipo_deposito is null begin
      exec cobis..sp_cerror
         @t_debug	= @t_debug,
         @t_file		= @t_file,
         @t_from		= @w_sp_name,
         @i_num		= 141115
      return 141115
end


select @w_dia_pago = isnull(@i_dia_pago, datepart(dd,@i_fecha_fin) ) --*-*




if @t_debug = 'S' print ' i_modo ' + cast(@i_modo as varchar)

----------------------------------------------
-- Dias Comerciales
----------------------------------------------
if @i_modo = 0
begin
   exec sp_funcion_1 
      @i_operacion = 'DIFE30',
      @i_fechai    = @i_fecha,
      @i_fechaf    = @i_fecha_fin,
      @i_dia_pago  = @w_dia_pago,   --*-*
      @i_batch     = @i_batch,   --*-*
      @o_dias      = @w_dias_360 out
   select convert(varchar,@w_dias_360)
   return 0
end


-------------------------------------------------------------
-------------------------------------------------------------
-- CALCULOS SIN LOS DIAS DE HOLD
-------------------------------------------------------------
-------------------------------------------------------------

----------------------------------------------------------
-- Toma la fecha valor y calcula el pr›ximo d­a laborable
----------------------------------------------------------

select @w_fecha_hoy = convert(datetime, convert (varchar,@i_fecha,101)) 


if @t_debug = 'S' print ' i_flag_valfvdnl ' + cast(@i_flag_valfvdnl as varchar)


if @i_flag_valfvdnl = 'S'
   exec sp_primer_dia_labor 
        @t_debug       = @t_debug, 
        @t_file        = @t_file,
        @t_from        = @w_sp_name, 
        @i_fecha       = @w_fecha_hoy,
        @s_ofi         = @s_ofi,
        @i_tipo_deposito = @w_tipo_deposito,
        --@i_tran_sabado = @i_tran_sabado,  -- GES 05/10/01 CUZ-009-031
             --@i_operacion   = 'F', -- la fecha valor solo con feriados nacionales, no locales
        @o_fecha_labor = @w_fecha_temp out
else
   select @w_fecha_temp = @i_fecha


if @t_debug = 'S' print ' valfec dialabor w_fecha_hoy ' + cast(@w_fecha_hoy as varchar)
if @t_debug = 'S' print ' valfec dialabor w_fecha_temp ' + cast(@w_fecha_temp as varchar)

-----------------------------------------------------------------
-- Si la fecha valor es diferente del d­a calculado
-- quiere decir que la fecha valor estaba en un d­a no laborable
-----------------------------------------------------------------

if @w_fecha_hoy <> @w_fecha_temp
   select @w_resultado = '1'

select @w_fecha_valor = @w_fecha_temp


----------------------------------------------------------
-- Calcula la fecha de vencimiento
----------------------------------------------------------
if @i_dias_reales = 'S'
begin
   select @w_fecha_aux_ven = dateadd(dd,@i_plazo,@w_fecha_temp) 
end
else
begin
   exec sp_funcion_1 
        @i_operacion = 'SUMDIA',
        @i_fechai    = @w_fecha_temp, 
        @i_dias      = @i_plazo,
        @i_dia_pago  = @w_dia_pago, --*-*
        @i_batch     = @i_batch, --*-*        
        @o_fecha     = @w_fecha_aux_ven out
end

if @t_debug = 'S' print ' 1 w_fecha_temp ' + cast(@w_fecha_temp as varchar)
if @t_debug = 'S' print ' 2 i_plazo ' + cast(@i_plazo as varchar)
if @t_debug = 'S' print ' 3 w_fecha_aux_ven ' + cast(@w_fecha_aux_ven as varchar)


----------------------------------------------------------
-- Toma la proxima fecha laborable (Vencimiento)
----------------------------------------------------------
exec sp_primer_dia_labor 
     @t_debug       = @t_debug, 
     @t_file        = @t_file,
     @t_from        = @w_sp_name, 
     @i_fecha       = @w_fecha_aux_ven,
     @s_ofi         = @s_ofi,
     @i_tipo_deposito = @w_tipo_deposito,
     @o_fecha_labor = @w_fecha_temp out


if @t_debug = 'S' print ' 4 valfec dialabor w_fecha_temp ' + cast(@w_fecha_temp as varchar)

-----------------------------------------------------------------
-- Si la fecha de vencimiento es diferente del d­a calculado
-- quiere decir que la fecha de vencimiento era en un d­a no laborable
-----------------------------------------------------------------

if @w_fecha_aux_ven <> @w_fecha_temp
begin
   select @w_resultado1 = '2'
   select @w_dias = datediff(dd,@w_fecha_aux_ven,@w_fecha_temp)
end

select @w_fecha_vencimiento = @w_fecha_temp

select  @w_resul_validacion = 'N'

if @w_resultado = '1'  and @w_resultado1 = '2'    -- si fecha valor y fecha vencimiento fueron cambiadas
   select @w_resul_validacion = 'T'
else
begin
   if @w_resultado = '1'                         -- si solo fecha valor fue cambiada
      select @w_resul_validacion = 'A'
   if @w_resultado1 = '2'                        -- si solo fecha de vencimiento fue cambiada
      select @w_resul_validacion = 'V'    
   
end

select @t_debug = 'N'

if @t_debug = 'S' print ' 4.1 w_resultado' + cast(@w_resultado as varchar)
if @t_debug = 'S' print ' 4.2 w_resultado1' + cast(@w_resultado1 as varchar)
if @t_debug = 'S' print ' 4.3 w_resul_validacion' + cast(@w_resul_validacion as varchar)


-------------------------------------------------------------
-------------------------------------------------------------
-- CALCULOS CON LOS DIAS DE HOLD
-------------------------------------------------------------
-------------------------------------------------------------
select @w_cuenta_dias = 1
select @w_fecha_temp =  @w_fecha_valor

if @i_max_ttransito > 0
begin

   -- Calcula el pr›ximo d­a hÿbil
   exec sp_primer_dia_labor 
        @t_debug       = @t_debug, 
        @t_file        = @t_file,
        @t_from        = @w_sp_name, 
        @i_fecha       = @w_fecha_temp,
        @s_ofi         = @s_ofi,
        @i_tran_sabado = @i_tran_sabado,  -- GES 05/10/01 CUZ-009-031
        @i_operacion   = 'C',
        @i_ttransito   = @i_max_ttransito,   --20-Sep-2005 xca
        @i_tipo_deposito = @w_tipo_deposito,
        @o_fecha_labor = @w_fecha_temp out
end

select @w_fecha_valor_con_hold = @w_fecha_temp

----------------------------------------------------------
-- Calcula la fecha de vencimiento
----------------------------------------------------------
if @i_dias_reales = 'S'
begin
   select @w_fecha_aux_ven = dateadd(dd,@i_plazo,@w_fecha_temp) 
   select @w_plazo_hold = datediff(dd,@w_fecha_valor_con_hold,  @w_fecha_vencimiento_con_hold)  --LIM 13/DIC/2005
end
else
begin
   exec sp_funcion_1
        @i_operacion = 'SUMDIA',
        @i_fechai    = @w_fecha_temp, 
        @i_dias      = @i_plazo,
        @i_dia_pago  = @w_dia_pago, --*-*
        @i_batch     = @i_batch, --*-*        
        @o_fecha     = @w_fecha_aux_ven out,
        @o_dias      = @w_plazo_hold    out    --LIM 13/DIC/2005

end


if @t_debug = 'S' print ' 5 w_fecha_temp ' + cast(@w_fecha_temp as varchar)
if @t_debug = 'S' print ' 6 i_plazo ' + cast(@i_plazo as varchar)
if @t_debug = 'S' print ' 7 w_fecha_aux_ven ' + cast(@w_fecha_aux_ven as varchar)
if @t_debug = 'S' print ' 8 w_plazo_hold ' + cast(@w_plazo_hold as varchar)

----------------------------------------------------------
-- Toma la proxima fecha laborable (Vencimiento)
----------------------------------------------------------

exec sp_primer_dia_labor 
     @t_debug       = @t_debug, 
     @t_file        = @t_file,
     @t_from        = @w_sp_name, 
     @i_fecha       = @w_fecha_aux_ven,
     @s_ofi         = @s_ofi,
     @i_tipo_deposito = @w_tipo_deposito,
     @o_fecha_labor = @w_fecha_temp out


if @t_debug = 'S' print ' 9 vlafec dialabor w_fecha_temp ' + cast(@w_fecha_temp as varchar)


select @w_fecha_vencimiento_con_hold = @w_fecha_temp
if @i_dias_reales = 'S'                              
begin
   select @w_plazo_hold = datediff(dd,@w_fecha_valor_con_hold,  @w_fecha_vencimiento_con_hold)  --LIM 13/DIC/2005
end
else                          -- GAL 26/AGO/2009 - RVVUNICA
begin
   exec sp_funcion_1
      @i_operacion = 'DIFE30',
      @i_fechai    = @w_fecha_valor_con_hold,
      @i_fechaf    = @w_fecha_vencimiento_con_hold,
      @i_dia_pago  = @w_dia_pago,
      @i_batch     = @i_batch,
      @o_dias      = @w_plazo_hold out
end

if @t_debug = 'S' print ' 10.1 w_fecha_valor_con_hold ' + cast(@w_fecha_valor_con_hold as varchar)
if @t_debug = 'S' print ' 10.2 w_fecha_vencimiento_con_hold ' + cast(@w_fecha_vencimiento_con_hold as varchar)
if @t_debug = 'S' print ' 10.3 w_plazo_hold ' + cast(@w_plazo_hold as varchar)

-------------------------------------------
-- DEVUELVE LOS RESULTADOS
-------------------------------------------

select convert(varchar,@w_fecha_temp,@i_formato_fecha)

select @w_resul_validacion,
       @w_dias,
       convert(varchar, @w_fecha_valor, @i_formato_fecha),
       convert(varchar, @w_fecha_vencimiento, @i_formato_fecha),
       convert(varchar, @w_fecha_valor_con_hold, @i_formato_fecha),
       convert(varchar, @w_fecha_vencimiento_con_hold, @i_formato_fecha),
       @w_plazo_hold                   --LIM 13/DIC/2005

if @i_flag_renovaut = 'S' -- 06-Abr-2000 xca determina si este sp es llamado de renovaut.sp
   if @w_resultado1 = '2' 
      select @o_num_dias_labor = @w_dias -- 06-Abr-2000 xca envia a renovaut.sp numero de dias adicionales

go
