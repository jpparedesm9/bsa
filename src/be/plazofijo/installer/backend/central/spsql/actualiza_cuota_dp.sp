/*sp_actualiza_cuota_dp*/
/************************************************************************/
/*      Archivo:                a_cuodia.sp                             */
/*      Stored procedure:       sp_actualiza_cuota_dp                   */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 21-Feb-2004                             */
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
/*      Este script realiza la actualizaci¢n de una cuota una vez graba-*/
/*      dos la nueva tasa y el nuevo valor de la operacion, en incre-   */
/*      mentos/reducciones/cambio de tasa.                              */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      21-Feb-2004  N. Silva           Emision Inicial.                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_cuota_dp' and type = 'P')
     drop proc sp_actualiza_cuota_dp
go
create proc sp_actualiza_cuota_dp (
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
          
          @i_fecha_proceso        datetime        = NULL,
          @i_op_operacion         int             = NULL,
          @i_dia_pago             int             = NULL,
          @i_en_linea             char(1)         = 'S',
          @i_plazo_ant            int             = 0,
          @i_fpago_ant            catalogo        = NULL,     
          @i_fecha_pg_int_ant     datetime        = NULL,
          @i_cuota       int       = 0, --CVA Jun-12-06
          @i_modifica             char(1)         = 'N'  --CVA Jun-29-06 para escalonados
)
with encryption
as
declare @w_sp_name              descripcion,
          @w_return               int,
          @w_error                int,
          @w_secuencial           int,
          @w_fecha_hoy            datetime,
          @w_cont                 int,
          @w_fecha_prox_pg        datetime,
          @w_int_estimado         decimal(30,16),
          @w_op_total_int_estimado   money,
          @w_fpago                catalogo,
          @w_op_dias_reales       char(1),  
          @w_moneda               tinyint,
          @w_ppago                catalogo, 
          @w_oficina_oper         smallint,
          @w_ajuste               money,
          @w_factor                smallint,
          @w_pp_factor_en_meses   int,
          @w_op_tot_int_pagados   money,
          @w_op_tot_int_ganados   money,
          
          /* Variables de Cuotas */
          @w_op_tasa               float,
          @w_op_int_estimado       money,
          @w_op_monto              money,
          @w_op_tcapitalizacion    char(1),
          @w_op_base_calculo       int,
          @w_op_num_banco          cuenta,
          @w_op_int_ganado         money,
          @w_op_fecha_ven          datetime,
          @w_op_ente               int, 
          @w_tcapitalizacion       char(1),
          @w_num_dias              int,
          @w_op_num_dias           int,
          @w_total_int_estimado    money,         
          @w_int_ganado_ven        money, 
          @w_total_cuotas          int,
          
          /* Variables de Operacion */
          @w_cu_cuota              int, 
          @w_cu_valor_cuota        money,
          @w_cu_capital            money,
          @w_cu_num_dias           int,
          @w_cu_fecha_pago         datetime,
          @w_cu_fecha_pago_ant     datetime,
          @w_cu_fecha_ult_pago_ant     datetime,
          @w_cu_fecha_ult_pago     datetime,
          @w_op_fecha_pg_int       datetime,
          @w_interes_neto          money,
          @w_dias_dif              smallint,
          @w_plazo_total           int,
          @w_vencimiento           char(1),
          @c_tolerancia            int,
          @w_op_fecha_valor        fecha,
          @w_plazo_calc            int,
          @w_camb_fpago            char(1),
          @w_op_fecha_ult_pg_int        datetime,
          @w_op_fecha_ult_pago_int_ant  datetime,
          @w_usadeci              char(1),
          @w_numdeci              tinyint


-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name       = 'sp_actualiza_cuota_dp',
       @s_user          = isnull(@s_user,'SYSTEM'),
       @s_term          = isnull(@s_term,'CONSOLA'),
       @i_fecha_proceso = isnull(@i_fecha_proceso,@s_date),  
       @s_date          = @i_fecha_proceso,
       @s_srv           = isnull(@s_srv,@@servername),
       @s_lsrv          = isnull(@s_lsrv,@@servername),
       @t_debug         ='N',
       @t_file          ='SQR',
       @w_error         = 0

select @w_vencimiento = 'N'
select @c_tolerancia = 0, @w_plazo_calc = 0

--------------------------------------------------------------
-- Acceso a operacion para obtener el nuevo valor de la cuota
--------------------------------------------------------------
select @w_op_num_banco       = op_num_banco,
       @w_op_tasa            = op_tasa,
       @w_op_int_estimado    = op_int_estimado,
       @w_op_total_int_estimado = op_total_int_estimado,
       @w_total_int_estimado    = op_total_int_estimado,
       @w_op_monto           = op_monto,
       @w_op_tcapitalizacion = op_tcapitalizacion,
       @w_op_base_calculo    = op_base_calculo,
       @w_op_int_ganado      = op_int_ganado,
       @w_op_fecha_ven       = op_fecha_ven,
       @w_op_ente            = op_ente,
       @w_fpago              = op_fpago,
       @w_moneda             = op_moneda,
       @w_ppago              = op_ppago,
       @w_num_dias           = op_num_dias,
       @w_op_num_dias        = op_num_dias,
       @w_oficina_oper       = op_oficina,
       @w_op_dias_reales     = op_dias_reales,
       @w_op_fecha_valor     = op_fecha_valor,
       @w_op_tot_int_pagados = op_total_int_pagados,
       @w_op_tot_int_ganados = op_total_int_ganados,
       @w_op_fecha_ult_pg_int = op_fecha_ult_pg_int,
       @w_op_fecha_ult_pago_int_ant = op_fecha_ult_pago_int_ant,
       @w_op_fecha_pg_int     = op_fecha_pg_int
  from cob_pfijo..pf_operacion
 where op_operacion = @i_op_operacion

if isnull(@w_op_tcapitalizacion ,'N') = 'S'
   select @w_op_monto = @w_op_monto


------------------------------------------------------------
-- Grabar las cuotas en un archivo historico para el reverso
-------------------------------------------------------------
insert into cob_pfijo..pf_cuotas_his(
       ch_ente          , ch_operacion, ch_cuota   , ch_fecha_pago,
       ch_valor_cuota   , ch_retencion, ch_capital , ch_fecha_crea,
       ch_moneda        , ch_oficina  , ch_num_dias, ch_estado,
       ch_fecha_ult_pago, ch_tasa     , ch_ppago   , ch_base_calculo, 
       ch_fecha_grab)
select cu_ente          , cu_operacion, cu_cuota   , cu_fecha_pago,
       cu_valor_cuota   , cu_retencion, cu_capital , cu_fecha_crea,
       cu_moneda        , cu_oficina  , cu_num_dias, cu_estado,
       cu_fecha_ult_pago, cu_tasa     , cu_ppago   , cu_base_calculo,
       @s_date
 from cob_pfijo..pf_cuotas
 where cu_operacion =  @i_op_operacion

------------------------------------------- 
-- Obtener el Factor de Conversion en Meses
-------------------------------------------
select @w_pp_factor_en_meses = pp_factor_en_meses
  from cob_pfijo..pf_ppago
 where pp_codigo = @w_ppago and pp_estado = 'A'   

----------------------------------------------------------------
-- obtener el numero de dias en los periodos de pago homogeneos
----------------------------------------------------------------
select @w_factor = 0

if @w_fpago in ('PER','PRA')
begin
     select @w_factor = pp_factor_en_meses * 30
     from pf_ppago
     where pp_codigo = @w_ppago
     if @@rowcount = 0
     begin
          select @w_error = 141071
          goto ERROR
     end

     if @w_factor = 0
     begin
          print 'Factor debe ser mayor que cero.' 
          return 1
     end
end

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
     select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
     where pa_nemonico = 'DCI'
          and pa_producto = 'PFI'
end
else
     select @w_numdeci = 0

select @w_cont = 0,@w_interes_neto = 0, @w_cu_num_dias = 0

------------------------------------------
-- Acceso a la tabla de detalle de cuotas
------------------------------------------
declare cursor_actualiza_cuota cursor
for select cu_cuota,
           cu_valor_cuota,
           cu_capital,
           cu_num_dias,
           cu_fecha_pago,
           cu_fecha_ult_pago
      from cob_pfijo..pf_cuotas
     where cu_fecha_pago = @i_fecha_pg_int_ant --Cuota Proximo Pago Vigente
       and cu_estado     = 'V'
       and cu_operacion  = @i_op_operacion
     order by cu_cuota

---------------------------------------
-- Acceso a primer registro del cursor
---------------------------------------
open cursor_actualiza_cuota
fetch cursor_actualiza_cuota into
      @w_cu_cuota,
      @w_cu_valor_cuota,
      @w_cu_capital,
      @w_cu_num_dias,
      @w_cu_fecha_pago,
      @w_cu_fecha_ult_pago

while @@fetch_status <> -1
begin
     if @@fetch_status = -2
     begin
          close cursor_actualiza_cuota
          deallocate cursor_actualiza_cuota
          raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
          return 1
     end 

     select @w_cont = @w_cont + 1
     
     if @w_cont = 1
          select @w_cu_fecha_ult_pago_ant = @w_cu_fecha_ult_pago
     else
          select @w_cu_fecha_ult_pago_ant = @w_cu_fecha_pago_ant
    

     if @w_cu_fecha_pago_ant is not null
          select @w_cu_fecha_ult_pago = @w_cu_fecha_pago_ant

     -----------------------------------------------------------------------------
     -- Obtener numero de dias para obtener la siguiente fecha de pago de interes
     -----------------------------------------------------------------------------
     select @w_cu_num_dias = (@w_pp_factor_en_meses*30)             
     
     select  @w_cu_fecha_pago  = dateadd(mm,@w_pp_factor_en_meses, @w_cu_fecha_ult_pago_ant) 

     --CVA Ene-9-05 Por cambio de proceso en cal_mod al obtener la proxima fecha de pago
     if @w_cu_fecha_pago <> @w_op_fecha_pg_int 
          select @w_cu_fecha_pago = @w_op_fecha_pg_int 

     ----------------------------------------------------------------------
     -- Para incluir la proxima fecha de pago definida por el usuario 
     ----------------------------------------------------------------------
     exec sp_dia_pago 
          @i_fecha               = @w_cu_fecha_pago,
          @i_dia_pago            = @i_dia_pago,
          @o_fecha_proximo_pago  = @w_cu_fecha_pago out

     select @w_dias_dif = datediff(dd,@w_cu_fecha_pago,@w_op_fecha_ven)
     
     select @w_num_dias = datediff(dd,@w_cu_fecha_ult_pago_ant,@w_cu_fecha_pago)
     
     select @w_cu_num_dias = datediff(dd,@w_cu_fecha_ult_pago_ant,@w_cu_fecha_pago)

    
     if isnull(@w_op_dias_reales,'N') = 'N' and @w_fpago = 'PER'
     begin 
          ---------------------------------------------------------------------
          -- Para incluir la proxima fecha de pago definida por el usuario 
          ----------------------------------------------------------------------
          exec sp_dia_pago 
               @i_fecha               = @w_cu_fecha_pago,
               @i_dia_pago            = @i_dia_pago,
               @o_fecha_proximo_pago  = @w_cu_fecha_pago out

          ------------------------------       
          -- Calculo de plazo comercial
          ------------------------------
          exec sp_fecha_comercial
               @i_fecha_inicial   = @w_cu_fecha_ult_pago_ant, 
               @i_fecha_ultima    = @w_cu_fecha_pago, 
               @o_dias            = @w_cu_num_dias out

          -------------------------------------------------
          -- Evaluacion para cuotas finales al vencimiento
          -------------------------------------------------
          select @w_plazo_total = datediff(dd,@w_op_fecha_valor,@w_op_fecha_ven)
          select @w_plazo_calc  = @w_plazo_calc + @w_cu_num_dias
          select @w_dias_dif    = @w_plazo_total - @w_plazo_calc

          -----------------------------------------
          -- Ajuste de cuotas en d¡as comerciales
          -----------------------------------------
          if (@w_dias_dif > 0 and @w_dias_dif < 30)
          begin
               select @w_vencimiento = 'S'
               select @w_cu_fecha_pago = @w_op_fecha_ven

               if @w_dias_dif < @c_tolerancia
                    select @w_cu_num_dias = @w_dias_dif + 30
               else
                    select @w_cu_num_dias = @w_dias_dif
          end 

          -------------------------------------------------------------------------
          -- Control para cuando los d¡as segun la fecha fijada son menores que 30
          -------------------------------------------------------------------------
          if @w_cu_num_dias < 30 and @w_vencimiento = 'N'
          begin
               select @w_plazo_calc  = @w_plazo_calc - @w_cu_num_dias
               select @w_cu_num_dias = 30
               select @w_plazo_calc  = @w_plazo_calc + @w_cu_num_dias
          end
     end

     if isnull(@w_op_dias_reales,'N') = 'S' and @w_ppago = 'PER'
     begin
          if @w_fpago = 'PER' and (@w_dias_dif > 0 and @w_dias_dif < @c_tolerancia)
          begin
               select @w_cu_fecha_pago = @w_op_fecha_ven
               select @w_cu_num_dias   = datediff(dd,@w_cu_fecha_ult_pago_ant,@w_op_fecha_ven)      
          end              
     end

     if @w_dias_dif < 0
     begin
          select @w_cu_fecha_pago = @w_op_fecha_ven
          select @w_cu_num_dias = datediff(dd,@w_cu_fecha_ult_pago_ant,@w_op_fecha_ven)             
     end       


     exec sp_calc_intereses
          @tasa        = @w_op_tasa,
          @monto       = @w_op_monto,
          @dias_anio   = @w_op_base_calculo,
          @num_dias    = @w_cu_num_dias,
          @intereses   = @w_int_estimado out

     select @w_int_estimado = round(@w_int_estimado,@w_numdeci)
     
     if @w_op_tcapitalizacion = 'N'
     begin
          if @w_op_fecha_ven <=  @w_cu_fecha_pago
          begin
               ---------------------------------------------
               -- Ajuste de la £ltima cuota
               ---------------------------------------------
               if ((@w_interes_neto + @w_int_estimado) <> @w_total_int_estimado)
               begin
                    select @w_int_estimado = @w_total_int_estimado - @w_interes_neto
               end
          end
   
          select @w_interes_neto = round((@w_interes_neto + @w_int_estimado), @w_numdeci)
     end       

     --Solo para las siguientes cuotas cambiar el recalcular el valor de  op_int_estimado
     if @w_cont > 1
          select @w_op_int_estimado = @w_int_estimado

    --print  'Update Cuota Nro. %1!, cu_fecha_pago %2!, @w_cu_fecha_ult_pago_ant %3!, @w_op_int_estimado %4!, @w_num_dias %5!', @w_cu_cuota, @w_cu_fecha_pago,@w_cu_fecha_ult_pago_ant,@w_op_int_estimado,@w_cu_num_dias

     ------------------------------
     -- Actualizacion de la cuota
     ------------------------------
     UPDATE cob_pfijo..pf_cuotas 
     set cu_valor_cuota = @w_op_int_estimado,
          cu_valor_neto  = @w_op_int_estimado,
          cu_capital     = @w_op_monto,
          cu_tasa        = @w_op_tasa,
          cu_num_dias    = @w_cu_num_dias,
          cu_fecha_pago  = @w_cu_fecha_pago,
          cu_fecha_ult_pago = @w_cu_fecha_ult_pago_ant,
          cu_ppago       = @w_ppago,
          cu_fecha_mod   = @s_date
     where cu_cuota     = @w_cu_cuota
          and cu_operacion = @i_op_operacion
     if @@error<> 0
     begin
          close cursor_actualiza_cuota
          deallocate cursor_actualiza_cuota
          select @w_error = 145052
          goto ERROR
     end

     ------------------------------------------------
     -- Nuevo valor para capitalizacion de intereses
     ------------------------------------------------
     if @w_op_tcapitalizacion = 'S'
          select @w_op_monto = @w_op_monto + @w_op_int_estimado

     select @w_cu_fecha_pago_ant = @w_cu_fecha_pago

     fetch cursor_actualiza_cuota into
          @w_cu_cuota,
          @w_cu_valor_cuota,
          @w_cu_capital,
          @w_cu_num_dias,
          @w_cu_fecha_pago,
          @w_cu_fecha_ult_pago

end /* while cursor_actualiza_cuota */
close cursor_actualiza_cuota
deallocate cursor_actualiza_cuota

---------------------------------------------------
--ELIMINAR LAS CUOTAS SIGUIENTES
---------------------------------------------------
--I. CVA Jul-12-06 Si se hizo un cambio de fecha valor no entra al cursor de arriba si el dia de pago cambia
if @w_cu_cuota is null and @i_cuota > 0
     select @w_cu_cuota = @i_cuota

--F. CVA Jul-12-06 Si se hizo un cambio de fecha valor 

if exists (select 1 from pf_cuotas 
             where cu_operacion = @i_op_operacion 
               and cu_cuota     > @w_cu_cuota)
begin   
--   print 'eliminando resto de cuotas %1!', @w_cu_cuota
     delete from pf_cuotas 
     where cu_operacion  = @i_op_operacion
          and cu_cuota      > @w_cu_cuota
     if @@error<> 0
     begin
          select @w_error = 145052
          goto ERROR
     end
end 

----------------------------------------------------------
-- REGENERAR TABLA DE CUOTAS
----------------------------------------------------------
select @w_cont = 0,@w_int_ganado_ven = 0, @w_cu_fecha_pago = null
 
select @w_cu_fecha_pago = max(cu_fecha_pago),
       @w_cont          = max(cu_cuota)
from pf_cuotas
where cu_operacion = @i_op_operacion

--Si esta cambiando de al Vencimiento a Periodica
--para que genere las cuotas desde la fecha de cambio
--print '@w_cu_fecha_pago %1!, @i_fpago_ant %2!, @w_fpago %3!', @w_cu_fecha_pago, @i_fpago_ant, @w_fpago
if (@w_cu_fecha_pago is null and @i_fpago_ant = 'VEN') and @w_fpago = 'PER'
begin       
     if  @w_op_fecha_ult_pago_int_ant > @w_op_fecha_ult_pg_int 
          select @w_cu_fecha_pago  = @w_op_fecha_ult_pago_int_ant
     else
          select @w_cu_fecha_pago  = @w_op_fecha_ult_pg_int 


     select @w_camb_fpago = 'S'
     select @w_int_ganado_ven = @w_op_tot_int_ganados - @w_op_tot_int_pagados         
     select @w_cu_num_dias    = datediff(dd,@w_op_fecha_valor,@s_date)
end 
else
     select @w_op_fecha_pg_int = null   


if @w_cu_fecha_pago is not null and @w_op_fecha_ven > @w_cu_fecha_pago
begin
     ------------------------------------------------------------
     -- Proceso para calculo de cuotas en operaciones periodicas
     ------------------------------------------------------------
     select @w_num_dias = @w_op_num_dias - @w_cu_num_dias
     select @w_cont     = @w_cont + 1

     --print 'Inserta cuotas a partir de @w_cu_fecha_pago %1!, @w_num_dias %2!, @w_cont %3!', @w_cu_fecha_pago, @w_num_dias, @w_cont
     
     exec @w_return = cob_pfijo..sp_cuotas
          @s_ssn                = @s_ssn,
          @s_srv                = @s_srv,
          @s_lsrv               = @s_lsrv,
          @s_user               = @s_user,
          @s_sesn               = @s_sesn,
          @s_term               = @s_term,
          @s_date               = @s_date,
          @s_ofi                = @s_ofi,
          @s_rol                = @s_rol,
          @t_trn                = 14146,
          @i_elimina_cuota      = 'N',
          @i_contador           = @w_cont, 
          @i_op_ente            = @w_op_ente,
          @i_op_operacion       = @i_op_operacion,
          @i_op_fecha_valor     = @w_cu_fecha_pago,
          @i_op_fecha_ven       = @w_op_fecha_ven,
          @i_op_monto           = @w_op_monto,
          @i_op_tasa            = @w_op_tasa,
          @i_op_num_dias        = @w_num_dias,
          @i_op_ppago           = @w_ppago,
          @i_op_retienimp       = 'N',
          @i_op_moneda          = @w_moneda,
          @i_op_oficina         = @w_oficina_oper,
          @i_op_fpago           = @w_fpago,
          @i_op_base_calculo    = @w_op_base_calculo,
          @i_op_tcapitalizacion = @w_op_tcapitalizacion,
          @i_op_anio_comercial  = 'N',
          @i_op_dias_reales     = @w_op_dias_reales,
          @i_camb_fpago         = @w_camb_fpago,
          @i_int_ganado         = @w_int_ganado_ven,
          @i_int_estimado       = @w_op_int_estimado,
          @i_tot_int_estimado   = @w_op_total_int_estimado,
          @i_tot_int_pagados    = @w_op_tot_int_pagados,
          @i_op_fecha_pg_int    = @w_op_fecha_pg_int,
          @i_modifica           = @i_modifica   --CVA Jun-29-06
     if @w_return <> 0        
     begin
          exec cobis..sp_cerror
               @t_debug         = @t_debug,
               @t_file          = @t_file,
               @t_from          = @w_sp_name,
               @i_num           = 143049
          return 1
     end             
end 

----------------------------------
-- Obtener interes total estimado
----------------------------------
select @w_total_int_estimado = 0, @w_total_cuotas = 0

select @w_total_int_estimado = sum(cu_valor_cuota)
from cob_pfijo..pf_cuotas
where cu_operacion = @i_op_operacion

select @w_cont =  max(cu_cuota) 
from pf_cuotas
where cu_operacion = @i_op_operacion

--I. CVA Oct-31-06 En w_total_int_estimado ya esta considerado lo pagado por adelantado
--Cambio de Ven a Per y las cuotas se generar a partir de la fecha actual menos lo pagado
--if @i_fpago_ant = 'VEN' and @w_fpago = 'PER'
--   select @w_total_int_estimado = @w_total_int_estimado +  @w_op_tot_int_pagados
--F. CVA Oct-31-06

if @w_total_int_estimado > 0 and (@w_total_int_estimado < @w_op_total_int_estimado)
begin
     select @w_ajuste = 0
     select @w_ajuste = @w_op_total_int_estimado - @w_total_int_estimado

     --print '1. @w_op_total_int_estimado %1!, @w_total_int_estimado %2!, ajuste %3!' , @w_op_total_int_estimado, @w_total_int_estimado, @w_ajuste

     update pf_cuotas
     set cu_valor_cuota = cu_valor_cuota + @w_ajuste,
           cu_valor_neto  = cu_valor_cuota + @w_ajuste
     where cu_operacion    = @i_op_operacion
          and cu_cuota        = @w_cont
     if @@error <> 0
     begin
          select @w_error = 145052
          goto ERROR
     end
end

if @w_total_int_estimado > 0 and (@w_total_int_estimado > @w_op_total_int_estimado)
begin
     select @w_ajuste = 0, @w_cu_valor_cuota = 0
     select @w_ajuste = @w_total_int_estimado - @w_op_total_int_estimado 

     --CVA Oct-31-06
     --Para los dpfs en que la ultima cuota puede ser cero entonces debe 
     --restar el ajusto de la penultima cuota 
     select @w_cu_valor_cuota = cu_valor_cuota
     from pf_cuotas
     where cu_operacion    = @i_op_operacion
          and cu_cuota        = @w_cont

     if @w_cu_valor_cuota = 0
          select @w_cont = @w_cont - 1

    --print '2. @w_op_total_int_estimado %1!, @w_total_int_estimado %2!, ajuste %3!, @w_cont %4!' , @w_op_total_int_estimado, @w_total_int_estimado, @w_ajuste, @w_cont

     update pf_cuotas
     set  cu_valor_cuota = cu_valor_cuota - @w_ajuste,
          cu_valor_neto  = cu_valor_cuota - @w_ajuste
     where cu_operacion    = @i_op_operacion
          and cu_cuota        = @w_cont
     if @@error <> 0
     begin
          select @w_error = 145052
          goto ERROR
     end

end
 
return 0

-------------------
-- Manejo de Error
-------------------
ERROR:
   if @i_en_linea = 'S'
   begin
       rollback
       exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error

   end
   else
   begin
        exec sp_errorlog 
             @i_fecha   = @s_date,
             @i_error   = @w_error,
             @i_usuario = @s_user,
             @i_tran    = @t_trn,
             @i_cuenta  = @w_op_num_banco
   end

   return @w_error
go
