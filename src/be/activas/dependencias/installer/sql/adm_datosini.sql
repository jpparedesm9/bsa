use cobis
go

--Transacciones Bloqueadas
delete cobis..cl_tran_bloqueada
 where tr_codproducto = 7
   and tr_transaccion in (7058)
   
insert into cobis..cl_tran_bloqueada
(tr_codproducto,tr_abreviatura,tr_descripcion,tr_transaccion,tr_des_tran,tr_estado,tr_supervisor,tr_tipo_evento,tr_fecha_registro,tr_fecha_modificacion,tr_funcionario)
values
(7,'CCA','CARTERA',7058,'INGRESO DE ABONO','E','N','A',getdate(),getdate(),'admuser')
go

