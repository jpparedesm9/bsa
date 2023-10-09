use cob_cartera
go 


declare @s_date datetime , @w_commit char(1) , @w_msg descripcion 


select @s_date = fp_fecha from cobis..ba_fecha_proceso
select @w_commit = 'N'

select * , 'ELIMINAR'= 'S', monto = convert(money,0) , monto_contable = convert(money,0)
into #transacciones
from cob_cartera..ca_transaccion 
where tr_tran     = 'GAR'
and   tr_estado   = 'CON'
and   tr_secuencial > 0
and   tr_fecha_ref = '03/15/2019'
and   tr_observacion = 'CONSTITUIR GARANTIA'
and   tr_banco    in ( 
'33123',
'33129',
'33135',
'95255',
'95257',
'95265',
'95408',
'97702',
'28131',
'28137',
'28183',
'28712',
'28881',
'29101',
'59255',
'59303',
'97807',
'98546',
'57291',
'57307',
'57319',
'57383',
'57937',
'58288',
'58331',
'97062',
'97355',
'97620',
'97625',
'97903',
'57447',
'58118',
'59165',
'60356',
'95012',
'97265',
'97393',
'97555',
'97564',
'95024',
'95055',
'95073',
'96390',
'96399',
'96404',
'97079',
'97626',
'85'   ,
'96527',
'96537',
'96540',
'96543',
'96548',
'96563',
'96842',
'93578',
'93597',
'93983',
'94236',
'94470',
'94978',
'97685',
'98648',
'53760',
'53762',
'53763',
'53765',
'54671',
'54719',
'55120',
'58300',
'97051',
'59154',
'59166',
'59170',
'59176',
'59180',
'95253',
'95714',
'97445',
'97915',
'97810',
'97815',
'97818',
'97823',
'97826',
'97828',
'97832',
'97834',
'97836',
'57613',
'57626',
'59523',
'59774',
'59788',
'95128',
'96430',
'96434',
'98374',
'15375',
'22309',
'22811',
'23833',
'25150',
'46250',
'58143',
'59202',
'94934',
'95084',
'95096',
'95104',
'95109',
'96426',
'98332',
'98489',
'98625',
'91701',
'91705',
'96608',
'97494',
'97509',
'98131',
'98386',
'98863',
'95267',
'95273',
'97251',
'97260',
'97998',
'98007',
'98099',
'98451',
'98557',
'93611',
'93616',
'93620',
'94048',
'94958',
'96511',
'97353',
'98748',
'25744',
'27030',
'28605',
'28891',
'28972',
'58347',
'59113',
'60437',
'96963',
'22732',
'24220',
'48207',
'95987',
'96005',
'96068',
'96070',
'96596',
'7734',
'7741' ,
'8060' ,
'8068' ,
'8671' ,
'55007',
'96446',
'96452',
'29107',
'29122',
'29945',
'29977',
'30246',
'30250',
'59360',
'59577',
'96386',
'96387',
'96397',
'96670',
'96678',
'97354',
'97711',
'98437',
'15335',
'16209',
'27504',
'53710',
'53990',
'54913',
'54966',
'96545',
'97797',
'10674',
'20052',
'20064',
'24528',
'31200',
'54911',
'57159',
'57379',
'88976',
'90171',
'90201',
'95772',
'95784',
'96980',
'96981',
'97114',
'28362',
'28386',
'28429',
'28768',
'28780',
'28865',
'57963',
'58704',
'97012',
'97016',
'97197',
'97434',
'374'  ,
'379'  ,
'382'  ,
'384'  ,
'25802',
'25805',
'30278',
'30878',
'95871',
'95896',
'96254',
'96275',
'96334',
'96394',
'96695',
'98963',
'97356',
'97902',
'97963',
'97976',
'97988',
'98125',
'98846',
'98850')


--QUEDAN LAS MALAS

update  #transacciones set 
ELIMINAR = 'X',
monto    = op_monto *0.1 
from ca_operacion 
where op_cliente= convert(int,tr_banco) 
and   op_oficina   = tr_ofi_oper 
and   op_estado    <> 3 

select banco = tr_banco, secuencial = max(tr_secuencial)  into #buenas 
from #transacciones
where ELIMINAR = 'X'
group by tr_banco

update #transacciones set 
ELIMINAR = 'N'
from #buenas 
where tr_banco      = banco 
and   tr_secuencial = secuencial 

update #transacciones set
ELIMINAR = 'S',
monto    =  0
where 
ELIMINAR = 'X'


update #transacciones set
monto_contable  =  st_saldo
from cob_conta_tercero..ct_saldo_tercero 
where st_cuenta ='241302'
and st_ente     = convert(int,tr_banco)  
and st_periodo  = 2019
and st_corte    = 90
and st_oficina  = tr_ofi_oper 
 

--reverso

select * into #ca_transaccion from ca_transaccion where 1=2
select * into #ca_det_trn     from ca_det_trn     where 1=2


insert into #ca_transaccion(
tr_secuencial,       tr_fecha_mov,        tr_toperacion,
tr_moneda,           tr_operacion,        tr_tran,
tr_en_linea,         tr_banco,            tr_dias_calc,
tr_ofi_oper,         tr_ofi_usu,          tr_usuario,
tr_terminal,         tr_fecha_ref,        tr_secuencial_ref,
tr_estado,           tr_observacion,      tr_gerente,
tr_gar_admisible,    tr_reestructuracion,
tr_calificacion,     tr_fecha_cont,       tr_comprobante)
select 
-1 * c.tr_secuencial,  @s_date,               c.tr_toperacion,
c.tr_moneda,           c.tr_operacion,        c.tr_tran,
c.tr_en_linea,         c.tr_banco,            c.tr_dias_calc,
c.tr_ofi_oper,         c.tr_ofi_usu,          'usrbatch', -- LAS REVERSAS SE HARAN CON LA MISMA OFICINA DE LA TRANSACCION ORIGINAL
'MAR-15-19',           c.tr_fecha_ref,        c.tr_secuencial,
'ING',                 c.tr_observacion,      c.tr_gerente,
c.tr_gar_admisible,    c.tr_reestructuracion,
c.tr_calificacion,     @s_date,               c.tr_comprobante
from   ca_transaccion c , #transacciones t
where  c.tr_operacion   = t.tr_operacion 
and    c.tr_secuencial  = t.tr_secuencial
and    t.ELIMINAR       = 'S'



insert into #ca_det_trn(
dtr_secuencial,     dtr_operacion,    dtr_dividendo,
dtr_concepto,       dtr_estado,       dtr_periodo,
dtr_codvalor,       dtr_monto,        dtr_monto_mn,
dtr_moneda,         dtr_cotizacion,   dtr_tcotizacion,
dtr_afectacion,     dtr_cuenta,       dtr_beneficiario, dtr_monto_cont)
select 
-1*dtr_secuencial,  dtr_operacion, dtr_dividendo,
dtr_concepto,
dtr_estado,         dtr_periodo,                  dtr_codvalor,
dtr_monto,          dtr_monto_mn,                 dtr_moneda,
dtr_cotizacion,     isnull(dtr_tcotizacion,''),   dtr_afectacion,
dtr_cuenta,         dtr_beneficiario,             0
from   #transacciones, ca_det_trn 
where  tr_secuencial   = dtr_secuencial
and    tr_operacion    = dtr_operacion
and    ELIMINAR        = 'S'



select tr_banco, tr_ofi_oper, sum (dtr_monto) 
from #ca_transaccion , #ca_det_trn 
where tr_operacion = dtr_operacion 
and   tr_secuencial = dtr_secuencial
group by tr_banco, tr_ofi_oper
order by tr_banco, tr_ofi_oper


--INICIO ATOMICIDAD 
select @w_commit = 'N'

if @@trancount = 0 begin 
   select @w_commit = 'S'
   begin tran 
end


insert into ca_transaccion
select *from #ca_transaccion

if @@error  <> 0 begin 
  select @w_msg = 'ERROR: AL INSERTAR EN LA CA_TRANSACCION' 
  goto   ERROR
end

insert into ca_det_trn 
select * from #ca_det_trn 

if @@error  <> 0 begin 
  select @w_msg = 'ERROR: AL INSERTAR EN LA CA_DET_TRANSACCION' 
  goto   ERROR
end



update ca_transaccion set 
tr_estado       = 'RV',
tr_observacion  = 'TRX REVERSADA POR CAUSAL DE INC EN GAR LIQ'
from  #transacciones t ,ca_transaccion c
where t.tr_operacion  = c.tr_operacion
and   t.tr_secuencial = c.tr_secuencial  
and   t.ELIMINAR      = 'S'

if @@error  <> 0 begin 
  select @w_msg = 'ERROR: AL ACTUALIZAR EN LA CA_TRANSACCION' 
  goto   ERROR
end


if @w_commit = 'S' begin 
   select @w_commit = 'N'
   commit tran 
end

select 
cliente      = ms_cliente, 
tipo_msg     =   ms_tipo_msg, 
ms_max_id    = max(ms_msg_id)  
into #msg_borrar 
from cob_bvirtual..bv_b2c_msg
where ms_respuesta is null
group by ms_cliente, ms_tipo_msg
having count(1) >=2


delete cob_bvirtual..bv_b2c_msg 
from #msg_borrar  
where cliente    = ms_cliente
and tipo_msg     = ms_tipo_msg 
and ms_max_id    = ms_msg_id  


ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
   rollback tran 
end

drop table #transacciones
go 
 
drop table #buenas 
go 

drop table #ca_transaccion 
go 

drop table #ca_det_trn
go


drop  table  #msg_borrar
go 

