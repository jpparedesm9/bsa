/************************************************************************/
/*  Archivo:                sp_valida_pagos_total_inc.sp                */
/*  Stored procedure:       sp_valida_pagos_total_inc                   */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Cartera                                     */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 10/Nov/2020                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*          				PROPOSITO                                   */
/* Valida los pagos para permitir el incremento	   					    */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 10/11/2020       PRO             	Emision Inicial                 */
/* 08/09/2022       DCU                 Req. #192491                    */ 
/************************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_valida_pagos_total_inc')
	drop proc sp_valida_pagos_total_inc
go

create proc [dbo].[sp_valida_pagos_total_inc](		
    @i_operacion		int				,
	@i_con_error		char(1)			='N',
	@i_fecha_ini_corte  datetime        = null,
	@i_fecha_fin_corte  datetime        = null,
	@o_respuesta		char(1)   		= null out
)
	
as
declare 
@w_sp_name       		varchar(32),
@w_error            	int,
@w_msg              	descripcion,
@w_iva					money,
@w_val_descuento 		money,
@w_val_descuento_aux 	money,
@w_operacion_desc   	int,
@w_toperacion			varchar(10),
@w_promocion			char(1),
@w_ciclos				int,
@w_dias_atraso			int,
@w_cliente				int,
@w_est_cancelado		int,
@w_separador			char(1),
@w_valores				varchar(30),
@w_variables			varchar(20),
@w_resultado			varchar(20),
@w_parent				varchar(20),
@w_factor				float,
@w_puntos				float,
@w_oper_padre			cuenta,
@w_oper_padre_int		int,
@w_fecha_proceso		datetime,
@w_pago_minimo			money,
@w_param_umbral 		money,
@w_num_pagos			int,
@w_saldo_capital		money,
@w_num_pag_inc          int


select 	@w_sp_name 		= 	'sp_valida_pagos_total_inc',
		@w_separador	=	'|',
		@o_respuesta	=	'S'
		
select @w_num_pag_inc = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'NPINLC'
and    pa_producto = 'CCA'

select op_operacion, op_monto, op_monto_aprobado,op_estado, op_cliente, op_banco, op_fecha_ini
into #operaciones_colectivas
from cob_cartera..ca_operacion
where op_operacion = @i_operacion 
	and op_toperacion = 'REVOLVENTE'

select operacion= op_operacion, fecha = min(tr_fecha_ref)
into #primer_desembolso
from #operaciones_colectivas,
cob_cartera..ca_transaccion
where op_operacion = tr_operacion
and tr_tran = 'DES'
and  tr_secuencial >0
and tr_estado <> 'RV'
group by op_operacion 

declare 
@w_operacion int,
@w_tipo  varchar(10),
@w_fecha datetime,
@w_monto money,
@w_saldo money,
@w_fecha_desembolso datetime,
@w_fecha_dividendo datetime,
@w_pago_completo   int,
@w_pago_parciales  int,
@w_pago  int,
@w_completo char(1),
@w_secuencial_completo int,
@w_secuencial_min int,  
@w_secuencial_max int,
@w_secuencial_aux int

select @w_operacion = 0

create table #datos_operacion (
secuencial int,
fecha      datetime,
tipo_tran  varchar(10),
monto      money,
fecha_mov  datetime)

select * into #datos_operacion_2  from #datos_operacion



create table #datos_pagos_total(
operacion int,
pago_completo int,
pago_parcial int)


while 1 = 1
begin
    
   select top 1 @w_operacion = op_operacion
   from #operaciones_colectivas
   where op_operacion > @w_operacion
   order by op_operacion
   
   if @@rowcount = 0 break 
   
   truncate table #datos_operacion
   
   insert into #datos_operacion
   (secuencial, fecha, tipo_tran, monto, fecha_mov) 
   select 
   tr_secuencial  ,
   tr_fecha_ref,
   tr_tran, 
   'valor' = sum(dtr_monto) * case when tr_tran = 'PAG' then -1 else 1 end,
   tr_fecha_mov
   from cob_cartera..ca_transaccion,
   cob_cartera..ca_det_trn
   where tr_operacion = @w_operacion--1342768
   and tr_operacion = dtr_operacion
   and tr_secuencial = dtr_secuencial
   and tr_secuencial > 0
   and tr_estado <> 'RV'
   and dtr_concepto = 'CAP'
   and tr_tran in ('DES', 'PAG')
   --and tr_fecha_mov >=	@i_fecha_ini_corte
   --and tr_fecha_mov <=	@i_fecha_fin_corte
   group by tr_secuencial,tr_fecha_ref, tr_tran, tr_fecha_mov
   order by tr_secuencial, tr_fecha_ref
   
   insert into #datos_operacion_2 
   select * 
   from #datos_operacion
   where fecha_mov >=	@i_fecha_ini_corte
   and fecha_mov <=	@i_fecha_fin_corte
   
   select @w_secuencial_min = min(secuencial) from #datos_operacion_2
   
   if exists (select 1 from #datos_operacion_2 where  secuencial = @w_secuencial_min and  tipo_tran = 'PAG')
   begin
      -- select @w_secuencial_max 
      
      select @w_secuencial_max = max(secuencial) 
      from #datos_operacion
      where secuencial < @w_secuencial_min
      and tipo_tran = 'DES'
   
      insert into #datos_operacion_2 
      select*
      from #datos_operacion
      where secuencial = @w_secuencial_max
      
      
      select @w_secuencial_aux = max(secuencial)
      from #datos_operacion
      where secuencial < @w_secuencial_max
      
      while exists (select 1 from #datos_operacion where secuencial = @w_secuencial_aux and  tipo_tran = 'DES')
      begin
            insert into #datos_operacion_2 
            select*
            from #datos_operacion
            where secuencial = @w_secuencial_aux
            
            select @w_secuencial_aux = max(secuencial)
            from #datos_operacion
            where secuencial < @w_secuencial_aux
            
      end 
      
   
   end 
   
   select * from #datos_operacion_2 order by secuencial 
   
   --select * from #datos_operacion order by fecha 
   
   select @w_fecha = '01/01/1900'
   select @w_secuencial_completo = 0
   select @w_saldo = 0
   select @w_pago_completo = 0
   select @w_pago_parciales = 0
   select @w_pago = 0
   select @w_completo = 'N'
   while 1 = 1
   begin
       select top 1 
       @w_fecha = fecha, 
       @w_tipo = tipo_tran, 
       @w_monto = monto,
       @w_secuencial_completo =secuencial 
       from #datos_operacion_2
       where secuencial > @w_secuencial_completo
       order by secuencial
   
       if @@rowcount = 0 goto SiguienteOperacion
       
       if @w_tipo = 'DES'
       begin
          select  @w_fecha_desembolso = @w_fecha
          select  @w_saldo = @w_saldo + @w_monto
          
          if @w_saldo < 0 select @w_saldo =  0
          
       end
       else 
       begin
           select @w_pago = @w_pago + 1
           
           select @w_fecha_dividendo = min(di_fecha_ven) 
           from cob_cartera..ca_dividendo
           where di_operacion =  @w_operacion
           and di_fecha_ven > @w_fecha_desembolso
           
           select  @w_saldo = @w_saldo + @w_monto
           
           if @w_fecha <= @w_fecha_dividendo and @w_saldo = 0
           begin
               select @w_completo = 'S'
           end
          
           if @w_saldo = 0
           begin
              if @w_completo = 'S'
                 select @w_pago_completo = @w_pago_completo + 1
              else   
                 select @w_pago_parciales = @w_pago_parciales+ @w_pago
              
              select @w_pago = 0
              select @w_completo = 'N'
           end
       end          
   end    
   
   SiguienteOperacion:
   
   if @w_saldo <> 0
      select @w_pago_parciales = @w_pago_parciales+ @w_pago
   
   insert into #datos_pagos_total values(@w_operacion,@w_pago_completo,@w_pago_parciales)
   
   
end


select 	@w_num_pagos = pago_completo 
from	#datos_pagos_total 


print '@w_operacion: ' + convert(varchar,@w_operacion) +' @w_num_pag_inc: ' + convert(varchar,@w_num_pag_inc) + ' @w_num_pagos: ' + convert(varchar,@w_num_pagos)

if(@w_num_pagos < @w_num_pag_inc)
begin
    select @o_respuesta = 'N'
	if(@i_con_error ='N')	return 0
	
end
return 0

go
