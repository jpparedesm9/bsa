/************************************************************************/
/*      Archivo:                vermig.sp                               */
/*      Stored procedure:       sp_verifica_migracion                   */
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
/*                              PROPOSITO                               */
/*      Este script cambia a las op.  de plazo fijo a estado activo,    */
/*      Realiza contabilizacion y puede ser reversado en mismo dia      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      11/16/01   Gabriela Estupinan Emision Inicial                   */ 
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_verifica_migracion') IS   NOT NULL
   drop proc sp_verifica_migracion
go

create proc sp_verifica_migracion(
@s_ssn                    int             = NULL,
@s_user                   login           = NULL,
@s_term                   varchar(30)     = NULL,
@s_date                   datetime        = NULL,
@s_sesn                   int             = NULL,
@s_srv                    varchar(30)     = NULL,
@s_lsrv                   varchar(30)     = NULL,
@s_ofi                    smallint        = NULL,
@s_rol                    smallint        = NULL,
@t_debug                  char(1)         = 'N',
@t_file                   varchar(10)     = NULL,
@t_from                   varchar(32)     = NULL,
@t_trn                    smallint        = NULL)
with encryption
as
declare
@w_return                 int,
@w_fecha_valor            datetime,
@w_fecha_ven              datetime,
@w_fecha_ult_pg_int       datetime,
@w_fecha_pg_int           datetime,
@w_ult_fecha_calculo      datetime,
@w_dias		              int,
@w_fecha_manana           datetime,
@w_monto                  money,
@w_base_calculo           smallint,
@w_tasa                   float,
@w_intereses              money,
@w_op_int_ganado          money,
@w_op_num_banco           cuenta,
@w_diferencia             money,
@w_operacion              int,
@w_op_total_int_ganados   money,
@w_valor_cuota            money,
@w_op_int_estimado        money,
@w_op_total_int_estimado  money,
@w_op_total_int_pagados   money,
@w_op_num_dias            smallint

select @w_operacion = 0

delete pf_errores_migracion

while 1 = 1
begin 
     set rowcount 1 
     select @w_op_num_banco = op_num_banco,
     @w_fecha_valor = op_fecha_valor,
     @w_fecha_ven = op_fecha_ven,
     @w_fecha_ult_pg_int = op_fecha_ult_pg_int,
     @w_fecha_pg_int = op_fecha_pg_int,
     @w_ult_fecha_calculo = op_ult_fecha_calculo,
     @w_monto = op_monto,
     @w_base_calculo = op_base_calculo,
     @w_tasa = op_tasa,
     @w_op_int_ganado = op_int_ganado,
     @w_operacion = op_operacion,
     @w_op_total_int_ganados = op_total_int_ganados,
     @w_op_int_estimado = op_int_estimado,
     @w_op_total_int_estimado = op_total_int_estimado,
     @w_op_total_int_pagados = op_total_int_pagados,
     @w_op_num_dias = op_num_dias
     from pf_operacion
    where op_operacion > @w_operacion
    and op_estado = 'ACT'
    and op_toperacion <> '212'
   
     if @@rowcount = 0
        break

     select @w_fecha_manana = dateadd(dd, 1, @w_ult_fecha_calculo)

     /*   CALCULO DE INTERESES GANADOS */    
      
     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', --03/dic/98
     @i_fechai   = @w_fecha_ult_pg_int, --03/dic/98
     @i_fechaf   = @w_fecha_manana, --03/dic/98
     @o_dias     = @w_dias out --03/dic/98   


     exec sp_calc_intereses @monto     = @w_monto,
                            @dias_anio = @w_base_calculo,
                            @tasa      = @w_tasa,
                            @num_dias  = @w_dias,
                            @intereses = @w_intereses out 

     select @w_diferencia = @w_intereses - @w_op_int_ganado
     if abs(@w_diferencia) > 1
     begin
        select @w_valor_cuota = cu_valor_cuota
        from pf_cuotas, pf_operacion
        where cu_operacion = op_operacion
        and cu_fecha_pago = op_fecha_pg_int
        and op_estado = 'ACT'
        if @@rowcount = 0
           print 'error no existe cupon operacion %1!'+ cast( @w_operacion as varchar)
         
        if @w_valor_cuota <> @w_op_int_ganado  
        begin
            insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Interes ganado', 'op_int_ganado',@w_intereses, @w_op_int_ganado, @w_diferencia, @w_dias)
--            print 'diferencia en interes ganado deposito %1! w_intereses %2! w_op_int_ganado %3! diferencia %4!', @w_op_num_banco, @w_intereses, @w_op_int_ganado, @w_diferencia
        end
     end 


     /*   CALCULO DE TOTAL INTERESES GANADOS */    

      
     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', 
     @i_fechai   = @w_fecha_valor, 
     @i_fechaf   = @w_fecha_manana, 
     @o_dias     = @w_dias out 

--     print '@w_dias %1!', @w_dias

     exec sp_calc_intereses @monto     = @w_monto,
                            @dias_anio = @w_base_calculo,
                            @tasa      = @w_tasa,
                            @num_dias  = @w_dias,
                            @intereses = @w_intereses out 

     select @w_diferencia = @w_intereses - @w_op_total_int_ganados
     if abs(@w_diferencia) > 1
     begin
        insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Total Interes ganado', 'op_total_int_ganado' , @w_intereses, @w_op_total_int_ganados, @w_diferencia, @w_dias)
--        print 'diferencia en total interes ganado deposito %1! w_intereses %2! w_op_total_int_ganados %3! diferencia %4!', @w_op_num_banco, @w_intereses, @w_op_total_int_ganados, @w_diferencia
     end 

     /* CALCULO INTERES ESTIMADO */
      
     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', 
     @i_fechai   = @w_fecha_ult_pg_int, 
     @i_fechaf   = @w_fecha_pg_int, 
     @o_dias     = @w_dias out 

--     print '@w_dias %1!', @w_dias

     exec sp_calc_intereses @monto     = @w_monto,
                            @dias_anio = @w_base_calculo,
                            @tasa      = @w_tasa,
                            @num_dias  = @w_dias,
                            @intereses = @w_intereses out 

     select @w_diferencia = @w_intereses - @w_op_int_estimado
     if abs(@w_diferencia) > 1
     begin
        insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Interes estimado', 'op_int_estimado' , @w_intereses, @w_op_int_estimado, @w_diferencia, @w_dias)
--        print 'diferencia en interes estimado %1! w_intereses %2! w_op_int_estimado %3! diferencia %4!', @w_op_num_banco, @w_intereses, @w_op_int_estimado, @w_diferencia
     end 


     /* CALCULO TOTAL INTERES ESTIMADO */

     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', 
     @i_fechai   = @w_fecha_valor, 
     @i_fechaf   = @w_fecha_ven, 
     @o_dias     = @w_dias out 

--     print '@w_dias %1!', @w_dias

     exec sp_calc_intereses @monto     = @w_monto,
                            @dias_anio = @w_base_calculo,
                            @tasa      = @w_tasa,
                            @num_dias  = @w_dias,
                            @intereses = @w_intereses out 

     select @w_diferencia = @w_intereses - @w_op_total_int_estimado
     if abs(@w_diferencia) > 1
     begin
        insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Total Interes estimado', 'op_total_int_estimado', @w_intereses, @w_op_total_int_estimado, @w_diferencia, @w_dias)
--        print 'diferencia en total interes estimado %1! w_intereses %2! w_op_total_int_estimado %3! diferencia %4!', @w_op_num_banco, @w_intereses, @w_op_total_int_estimado, @w_diferencia
     end 


     /* CALCULO DE INTERESES PAGADOS  */

     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', 
     @i_fechai   = @w_fecha_valor, 
     @i_fechaf   = @w_fecha_ult_pg_int, 
     @o_dias     = @w_dias out 

     select @w_intereses = sum(cu_valor_cuota)
     from pf_cuotas
     where cu_operacion = @w_operacion
     and cu_fecha_pago < @w_fecha_manana

     select @w_diferencia = @w_intereses - @w_op_total_int_pagados
     if abs(@w_diferencia) > 1
     begin
        insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Total Interes pagados', 'op_total_int_pagados', @w_intereses, @w_op_total_int_pagados, @w_diferencia, @w_dias)     
     end 
       

     /* CALCULO DE FECHAS DE VENCIMIENTO */
      
     exec @w_return = sp_funcion_1 
     @i_operacion = 'DIFE30', 
     @i_fechai   = @w_fecha_valor, 
     @i_fechaf   = @w_fecha_ven, 
     @o_dias     = @w_dias out 

     select @w_diferencia = @w_dias - @w_op_num_dias
     if abs(@w_diferencia) >= 1
     begin
        insert into pf_errores_migracion values (@w_op_num_banco, @w_operacion, 'Plazo deposito', 'op_num_dias',@w_dias, @w_op_num_dias, @w_diferencia, @w_dias) 
     end 
     
     
end
go