
use cob_cartera 
go 


declare 
@w_operacionca int ,
@w_error     int   ,
@w_cat       float ,
@w_tir       float ,
@w_tea       float ,
@w_periodo_int  int,
@w_tplazo    catalogo,
@w_banco     cuenta ,
@w_interes   float,
@w_comision  float 


--DETERMINAR UNIVERSO DE LCR
select * into #operaciones_lcr 
from ca_operacion where op_tipo_amortizacion ='ROTATIVA'


select @w_operacionca = 0

while 1 = 1 begin


   select @w_interes = null,@w_comision = null,@w_error = 0,@w_cat = null

   select  top 1
   @w_operacionca         = op_operacion,
   @w_banco               = op_banco,
   @w_periodo_int          = op_periodo_int, 
   @w_tplazo              = op_tplazo
   from #operaciones_lcr
   where op_operacion> @w_operacionca   
   order by op_operacion asc
   
   if @@rowcount = 0 break 
   
   
   select @w_interes = ro_porcentaje 
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and ro_concepto    = 'INT'
   
   select @w_comision = ro_porcentaje 
   from ca_rubro_op
   where ro_operacion = @w_operacionca
   and ro_concepto    = 'COM'
   
   --OBTENER NUEVO VALOR CAT  
   
   exec @w_error = sp_tir
   @i_operacionca = @w_operacionca,
   @o_cat         = @w_cat out,
   @o_tir         = @w_tir out,
   @o_tea         = @w_tea out
   
   if @w_error <> 0 goto SIGUIENTE  
   

						 
   update ca_operacion set op_valor_cat = @w_cat where op_operacion = @w_operacionca
   
   print 'BANCO :'+@w_banco+' '+' PERIODICIDAD :'+convert(varchar,@w_periodo_int)+' TIPO DE PLAZO: '+convert(varchar,@w_tplazo)+' '+'INT: '+convert(varchar,@w_interes)+' '+'COM: '+convert(varchar,@w_comision)+' '+'CAT: '+convert(varchar,@w_cat)

   SIGUIENTE: 
end 


drop table #operaciones_lcr
go 

