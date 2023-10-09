USE cob_cartera
GO

declare @w_codigo_valor int
select @w_codigo_valor = 144

--SE ELIMINA CODIGO VALOR YA USADO EN OTRO REQUERIMIENTO PARA EVITAR PISAR 
if exists(select * from ca_producto where cp_producto = 'FALLECIDO' and cp_codvalor=143)
begin
	delete from ca_producto where cp_producto = 'FALLECIDO' and cp_codvalor=143
	delete from cob_conta..cb_det_perfil where dp_perfil ='CCA_RPA' and dp_codval=143
end

delete from ca_producto where cp_producto = 'FALLECIDO' and cp_codvalor=@w_codigo_valor
INSERT INTO ca_producto VALUES('FALLECIDO','FALLECIDO','OTRO',0,@w_codigo_valor,'N','S','N',0,'N',NULL,'FALLECIDO','D','V','T',NULL,NULL)


update ca_producto
set cp_pago = 'S'
where cp_producto = 'GAR_DEB'


delete from cob_conta..cb_det_perfil where dp_perfil ='CCA_RPA' and dp_codval=@w_codigo_valor
delete from cob_conta..cb_relparam where re_parametro ='F_PAGO' and re_clave='FALLECIDO'

insert into cob_conta..cb_det_perfil values(1,7,'CCA_RPA',11,'F_PAGO','CTB_OF',1,@w_codigo_valor,'N','O',NULL,'L')
insert into cob_conta..cb_relparam values(1,'F_PAGO','FALLECIDO','50502605',7,'CTB_OF','D')

go
--SE AUTORIZA OFICINAS A CUENTA
insert into cob_conta..cb_plan_general
select 1,'50502605',pg_oficina,pg_area,'150502605'+convert(varchar(5),pg_oficina)+convert(varchar(5),pg_area)
from cob_conta..cb_plan_general where pg_cuenta='131190010101'
and pg_oficina not in (select pg_oficina from cob_conta..cb_plan_general where pg_cuenta='50502605')

go
