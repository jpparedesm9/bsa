

declare @i_transaccion int
select @i_transaccion = 252

select * from cob_remesas..re_concepto_contable
where cc_producto = 4
and cc_tipo_tran = @i_transaccion

select * from cob_remesas..re_trn_perfil
where tp_producto = 4
and tp_tipo_tran = @i_transaccion

select * from cob_conta..cb_det_perfil
where dp_empresa = 1
and dp_producto = 4
and dp_perfil = (select tp_perfil
		   from cob_remesas..re_trn_perfil
		  where tp_producto = 4
		    and tp_tipo_tran = @i_transaccion)

print 'PARAMETRO PARA EL DEBITO'
print ''
select * from cob_conta..cb_parametro
where pa_empresa = 1
and pa_parametro = (select dp_cuenta from cob_conta..cb_det_perfil
		     where dp_empresa = 1
  		       and dp_producto = 4
		       and dp_debcred = 1
		       and dp_perfil = (select tp_perfil
		   		          from cob_remesas..re_trn_perfil
					  where tp_producto = 4
					    and tp_tipo_tran = @i_transaccion))
print 'PARAMETRO PARA EL CREDITO'
print ''
select * from cob_conta..cb_parametro
where pa_empresa = 1
and pa_parametro = (select dp_cuenta from cob_conta..cb_det_perfil
		     where dp_empresa = 1
  		       and dp_producto = 4
		       and dp_debcred = 2
		       and dp_perfil = (select tp_perfil
		   		          from cob_remesas..re_trn_perfil
					  where tp_producto = 4
					    and tp_tipo_tran = @i_transaccion))

print 'POSIBLES CUENTAS CONTABLES PARA EL DEBITO'
print ''
select * from cob_conta..cb_relparam 
where re_parametro = (select pa_parametro from cob_conta..cb_parametro
			where pa_empresa = 1
			and pa_parametro = (select dp_cuenta from cob_conta..cb_det_perfil
					     where dp_empresa = 1
			  		       and dp_producto = 4
					       and dp_debcred = 1
					       and dp_perfil = (select tp_perfil
		   					          from cob_remesas..re_trn_perfil
								  where tp_producto = 4
								    and tp_tipo_tran = @i_transaccion)))

print 'POSIBLES CUENTAS CONTABLES PARA EL CREDITO'
print ''
select * from cob_conta..cb_relparam 
where re_parametro = (select pa_parametro from cob_conta..cb_parametro
			where pa_empresa = 1
			and pa_parametro = (select dp_cuenta from cob_conta..cb_det_perfil
					     where dp_empresa = 1
			  		       and dp_producto = 4
					       and dp_debcred = 2
					       and dp_perfil = (select tp_perfil
		   					          from cob_remesas..re_trn_perfil
								  where tp_producto = 4
								    and tp_tipo_tran = @i_transaccion)))