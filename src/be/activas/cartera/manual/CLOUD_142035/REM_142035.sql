

use cob_cartera
go

declare 
@w_operacion           int = 0,
@w_cliente             int,
@w_num_div             int,
@w_monto_int_desp      money,
@w_int_espera          varchar(15),
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_moneda              int,
@w_oficina             int,
@w_toperacion          varchar(10),
@w_error               int,
@w_cuotas_a_desplazar  int,
@w_fecha_desp          datetime,
@w_fecha_ini           datetime,
@w_secuencial_des      int,
@w_fecha_desembolso    datetime,
@w_fecha_ven           datetime ,
@w_msg                 varchar(100),
@w_secuencial          int 

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

select @w_fecha_ven = '06/01/2020' --Fecha desde la cual las operaciones desplazadas tiene problemas 

--67 OPERACIONES 
select 
operacion    = op_operacion,
banco        = op_banco,
moneda       = op_moneda,
oficina      = op_oficina,
cliente      = op_cliente
into #operaciones 
from ca_operacion 
where op_banco in (
'211380037962',
'211380037970',
'211380037988',
'211380037995',
'211380038003',
'211380038011',
'211380038029',
'211380038037',
'211420030754',
'211420030762',
'211420030770',
'211420030788',
'211420030795',
'211420030804',
'211420030812',
'211420030820',
'211780043173',
'211780043181',
'211780043198',
'211780043207',
'211780043215',
'211780043223',
'213020019863',
'213020019871',
'213020019889',
'213020019896',
'213020019904',
'213020019912',
'213240009297',
'213240009306',
'213240009314',
'213240009322',
'213240009330',
'213240009348',
'213240009355',
'213240009363',
'213240009371',
'213240009389',
'213240009396',
'213240009405',
'213240009413',
'213240009421',
'213240009439',
'213240009447',
'213240010965',
'213240010973',
'213240010981',
'213240010998',
'213240011006',
'213240011014',
'213240011022',
'213450002166',
'213450002174',
'213450002182',
'213450002199',
'213450002208',
'213450002216',
'213450002224',
'213450002232',
'214800084052',
'214800084060',
'214800084078',
'214800084086',
'214800084093',
'214800084102',
'214800084110',
'214800084128'
)



select 'SITUACION INCIAL '
select  
di_operacion,
di_dividendo, 
di_estado, 
di_dias_cuota, 
di_fecha_ven 
into #error 
from ca_dividendo 
where  di_estado = 2
and di_dias_cuota >80
and  di_fecha_ven >@w_fecha_proceso
and  di_fecha_ini >= '03/28/2020'
and di_operacion in (select operacion from #operaciones)

select distinct 
a.de_banco, e.*,fecha_proceso=@w_fecha_proceso  
from #error e, ca_desplazamiento a
where  di_operacion =de_operacion 
and di_operacion in (select operacion from #operaciones)



select @w_operacion = 0

  
select 'MONTOS ESPERA ANTES DE LA CORRECCION '
select operacion = am_operacion , cuota = sum(am_cuota) from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto



while 1 = 1 begin

   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco,
   @w_moneda       = moneda,
   @w_oficina      = oficina,
   @w_cliente      = cliente
   from #operaciones 
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 
   
   --OBTENEMOS SECUENCIAL DEL REVERSO DEL DSP
   select @w_secuencial =isnull(max(tr_secuencial),0) 
   from ca_transaccion 
   where tr_operacion = @w_operacion 
   and tr_tran = 'DSP'
   and tr_secuencial >0 and tr_estado <> 'RV'
   
   if @w_secuencial  = 0 begin 
      print 'ERROR NO EXISTE SECUENCIAL DE REVERSO DSP'
	  goto Siguiente
   end 
   
    ----REVERSAR TRANSACCIONES DSP   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_banco       = @w_banco,
   @i_secuencial  = @w_secuencial,
   @i_operacion   = 'R'
   
    if @w_error <> 0 begin 
      select @w_error ,@w_banco
      goto Siguiente
   end 
  
  --OBTENEMOS LA FECHA DE VENCIMIENTO DEL DSP 
   select @w_fecha_ven = max(de_fecha_fin) from  ca_desplazamiento where de_banco= @w_banco
   and de_estado = 'A'
   
   if @w_fecha_ven is null  begin 
      print 'ERROR NO EXISTE FECHA VEN DEL DSP'
      goto Siguiente
   end 
   
   --LLEVAMOS OPERACIONES ATRAS HACIA AL FECHA FIN DEL PRIMER PERIODO DSP  
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_ven   ,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select @w_error ,@w_banco
      goto Siguiente
  end 
  
  --APLICAMOS EL DSP EN LA FECHA FIN DEL PRIMER PERIODO 
  --ESTO CON LA FINALIDAD DE INFLAR LOS DIAS DE LA CUOTA 
   exec @w_error=sp_desplazamiento	
   @i_banco          = @w_banco  ,
   @i_cliente        = @w_cliente,
   @i_fecha_valor    = @w_fecha_ven ,--fecha de proceso
   @i_cuotas         = 4 ,
   @i_archivo        = 'ArchivoDESREP_16062020.txt' ,--nombre del archivo
   @i_cuota_vencida  = 'N' ,
   @i_genera_int_esp = 'S'       ,
   @o_msg             = @w_msg out 
   

    if @w_error <> 0 begin 
      select @w_error ,@w_banco
      goto Siguiente
   end 
    

   --LLEVAMOS LA OPERACION A HOY   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_proceso   ,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select @w_error ,@w_banco
      goto Siguiente
  end 
   
  
  
   Siguiente:   
   
   
end




select 'VERIFICACION DE MONTOS ESPERA POSTERIOR'
select
operacion = am_operacion , 
cuota = sum(am_cuota) 
into #verificaciones 
from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto

select 
operacion, 
cuota, 
sum(de_int_dsp) 
from 
#verificaciones , ca_desplazamiento 
where de_operacion = operacion
and de_estado = 'A'
group by operacion,cuota

select 'VERIFICACION DE ESTADOS DEL DIVIDENDO POSTERIOR'

select  
di_operacion,
di_dividendo, 
di_estado, 
di_dias_cuota, 
di_fecha_ven 
into #error2 
from ca_dividendo 
where  di_estado = 2
and di_dias_cuota >80
and  di_fecha_ven >@w_fecha_proceso
and  di_fecha_ini >= '03/28/2020'
and di_operacion in (select operacion from #operaciones)

select distinct 
a.de_banco, e.*,fecha_proceso=@w_fecha_proceso  
from #error2 e, ca_desplazamiento a
where  di_operacion =de_operacion 
and di_operacion in (select operacion from #operaciones)



drop table #operaciones
drop table #verificaciones
drop table #error
drop table #error2




go
