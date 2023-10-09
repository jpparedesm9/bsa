
use cob_cartera
go


if not exists(select 1 from sys.indexes 
              where name = 'ca_cliente_tmp_2' 
              and object_id = OBJECT_ID('ca_cliente_tmp'))
begin              
    
--indices 
   create nonclustered index ca_cliente_tmp_2 on ca_cliente_tmp (clt_operacion,clt_cliente,clt_user)

end 



if not exists(select 1 from sys.indexes 
              where name = 'ca_qry_consulta_abono_2' 
              and object_id = OBJECT_ID('ca_qry_consulta_abono'))
begin              
    
--modificar del dia sp del dia con truncate 
   create  index ca_qry_consulta_abono_2 on ca_qry_consulta_abono (s_user)


end 




if not exists(select 1 from sys.indexes 
              where name = 'ca_consulta_rec_pago_tmp_1' 
              and object_id = OBJECT_ID('ca_consulta_rec_pago_tmp'))
begin 
--modificar del dia sp del dia con truncate 
   create  index ca_consulta_rec_pago_tmp_1 on ca_consulta_rec_pago_tmp (usuario)

end 