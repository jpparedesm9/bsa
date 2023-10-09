Use cob_conta
go

declare @w_empresa	int,
		@w_fecha 	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_area')
begin
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

   delete from cob_conta..cb_cuenta_proceso where cp_proceso = 36411
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1311900101', 0, 0, 0, 1, 'CAP VIG NE', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1311900301', 0, 0, 0, 1, 'INT VIG NE', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1311900102', 0, 0, 0, 1, 'CAP VIG EX', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1311900302', 0, 0, 0, 1, 'INT VIG EX', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1361900102', 0, 0, 0, 1, 'CAP VEN NE', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1361900101', 0, 0, 0, 1, 'CAP VEN EX', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36411, @w_empresa, '1361900301', 0, 0, 0, 1, 'INT VEN EX', NULL)
   insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre)values (6003,   @w_empresa, '14019006', 0, 0, '0', '1', '', '')
end
else
	print 'NO EXISTE TABLA cb_area'

go

delete from cob_conta..cb_cuenta_proceso where cp_proceso = 36419
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (36419, 1, '1391506190', 1, 1, 0, 1, 'PROVISIONES', NULL)
go

delete from cob_conta..cb_cuenta_asociada where ca_proceso = 36419
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 1, 1, '139150619001', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 2, 1, '139150619002', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 3, 1, '139150619003', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 4, 2, '139150619004', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 5, 2, '139150619005', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 6, 2, '139150619006', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 7, 3, '', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 8, 4, '', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 9 , 5, '139150619007', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 10, 5, '139150619008', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 11, 5, '139150619009', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 12, 5, '139150619010', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 13, 5, '139150619011', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 14, 5, '139150619012', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 15, 5, '139150619013', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 16, 5, '139150619014', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 17, 5, '139150619015', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 18, 5, '139150619016', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 19, 5, '139150619017', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 20, 5, '139150619018', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 21, 5, '139150619019', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 22, 5, '139150619020', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 23, 5, '139150619021', 1, 1, 'D')
INSERT INTO cob_conta..cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred) VALUES (1, '1391506190', 1, 1, 36419, 24, 6, '', 1, 1, 'D')
go


delete from cob_conta..cb_cuenta_proceso where cp_proceso in (6003)
go

insert into  cb_cuenta_proceso 
select distinct 6003,1,cu_cuenta,0,0,0,1,'','' 
from 
cob_conta..cb_cuenta, cob_conta..cb_relparam
where cu_cuenta = re_substring
and cu_movimiento = 'S'
and re_parametro <> 'PRO_1391'
and re_producto   = '7'
union
select distinct 6003,1,cu_cuenta,0,0,0,1,'',''
from cob_conta..cb_cuenta, cob_conta..cb_det_perfil
where cu_cuenta = dp_cuenta
and cu_movimiento = 'S'
and dp_producto   = '7'
go


delete from cob_conta..cb_cuenta_proceso where cp_proceso in (6005)
go
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '1', 0, 0, '0', NULL, NULL, NULL)
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '2', 0, 0, '0', NULL, NULL, NULL)
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '3', 0, 0, '0', NULL, NULL, NULL)
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '4', 0, 0, '0', NULL, NULL, NULL)
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '5', 0, 0, '0', NULL, NULL, NULL)
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre) values (6005, 1, '6', 0, 0, '0', NULL, NULL, NULL)

go

