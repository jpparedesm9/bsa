use cob_credito
go

declare 
@w_ente            int,
@w_ente_str        varchar(8)  

select @w_ente = en_ente from cobis..cl_ente where en_ced_ruc = 'USUARIOB2C'

if not exists (select 1 from cob_credito..cr_b2c_registro where rb_cliente = @w_ente)
begin
   insert into cob_credito..cr_b2c_registro (rb_registro_id, rb_id_inst_proc, rb_cliente, rb_fecha_ingreso, rb_fecha_vigencia, rb_fecha_reg_exitoso)
   values ('000000', 0, @w_ente, '2021-11-26', '2025-10-26', NULL)
end


select * from cob_credito..cr_b2c_registro where rb_cliente = @w_ente
