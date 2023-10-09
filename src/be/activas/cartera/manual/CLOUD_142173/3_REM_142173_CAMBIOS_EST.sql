use cob_cartera
go 


declare 
@w_operacion           int = 0,
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_oficina             int,
@w_error               int,
@w_fecha_est           datetime ,
@w_msg                 varchar(100) ,
@w_ciudad_nacional     int  ,
@w_fecha_res           datetime 

-- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES -------
select @w_ciudad_nacional = isnull(pa_int,9999)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--FECHA PROCESO
select  @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso


--FECHA DE LA REESTRUTURACION 
select @w_fecha_res = '05/28/20'

--OPERACIONES CON DESPLAZAMIENTOS APLICADOS 
select 
operacion = de_operacion 
into #dsp
from ca_desplazamiento
where de_estado    = 'A'
and de_banco 
in (
'214810030624',
'214810030632',
'214810030640',
'214810030657',
'214810030665',
'214810030673',
'214810030681',
'213100007722',
'213100007730',
'213100007748',
'213100007755',
'213100007763',
'213100007771',
'213100007789',
'213100007796'
)
group by de_operacion



--BUSCAMOS TODAS LAS TRANSACCIONES EST QUE TENGAN DESPLAZAMIENTO
select 
operacion     = tr_operacion,
banco         = tr_banco,
fecha_ref     = tr_fecha_ref,
oficina       = convert(int, null)
into #operaciones   
from ca_transaccion ,#dsp
where tr_operacion = operacion 
and tr_secuencial >0 
and tr_estado <> 'RV'
and tr_tran  = 'EST'


update #operaciones set 
oficina  = op_oficina 
from ca_operacion 
where op_operacion = operacion


select 'ANTES DE FECHA VALOR', count(1)
from #operaciones 

select @w_operacion = 0 

while 1 = 1 begin

   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco,
   @w_oficina      = oficina,
   @w_fecha_est    = fecha_ref
   from #operaciones 
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 
   
   --SE DETECTO QUE EN ALGUNAS FECHAS EST ESTABAN COMO FERIADO
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_est) 
      select @w_fecha_est = dateadd(dd, -1, @w_fecha_est) 
    
   
   --FECHA VALOR AL DIA DEL EST --PARA RECALCULAR EL ESTADO 
   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_est,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select 'ERROR FV FECHA EST', @w_error ,@w_banco
      goto Siguiente
   end 
   
   
   
   
   --FECHA VALOR AL DIA DE LA RES  
    exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_res,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select 'ERROR FV A FECHA RES ',@w_error ,@w_banco
      goto Siguiente
   end 
   
   
   --REESTRUTURACIONES 
   exec  @w_error = cob_cartera..sp_reestructuracion_covid19
   @i_banco                  = @w_banco,
   @i_cuotas_adicionales     = 8,
   @o_msg                    = @w_msg out 
   
   if @w_error <> 0 begin 
      select 'error RES ', @w_error, 'banco',@w_banco
      goto Siguiente 
   end 
   
   
      --FECHA VALOR AL PRESENTE 
    exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_proceso,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select 'ERROR FV A FECHA RES ',@w_error ,@w_banco
      goto Siguiente
   end 
   
     
   
   Siguiente:   
   
 end   
 
 
 
   
select 'VERIFICACION'
select op_estado, op_fecha_ult_proceso, op_operacion 
from ca_operacion 
where op_operacion in ( select operacion from #dsp)
and op_estado = 2 

select tr_tran, tr_banco, tr_estado,tr_secuencial,* from ca_transaccion 
where tr_banco 
in ( select banco from #operaciones)
and tr_tran = 'RES'


select di_operacion , count(di_dividendo) 
from ca_dividendo 
where di_operacion  in ( select operacion from #operaciones)
group by di_operacion 

select am_operacion, am_concepto, sum(am_cuota) from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA','IVA_ESPERA','SEGAD')
group by am_operacion , am_concepto

select op_fecha_ult_proceso,* from ca_operacion 
where op_operacion in (select operacion from #operaciones)

    
   
drop table #dsp
drop table #operaciones
   
   