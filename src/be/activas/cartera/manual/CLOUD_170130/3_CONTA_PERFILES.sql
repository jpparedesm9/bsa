

Use cob_conta
go
declare @w_empresa int, @w_modulo int, @w_asiento int 
select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

select @w_modulo = 7



delete cob_conta..cb_det_perfil where dp_cuenta in 

(

'CAP_1311NE2',
'CAP_1311EX2',
'INT_1311NE2',
'INT_1311EX2',
'INT_5105NE2',
'INT_5105EX2'
)


-- 


--CCA_PRV

select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'CCA_PRV'

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',@w_asiento +1,'INT_1311NE2','CTB_OF','1',11120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',@w_asiento +2,'INT_5105NE2','CTB_OF','2',11120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',@w_asiento +3,'INT_1311EX2','CTB_OF','1',11121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',@w_asiento +4,'INT_5105EX2','CTB_OF','2',11121,'N','D', NULL, 'L')


--PAGO DE PRESTAMOS

select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'CCA_PAG'

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +1,'CAP_1311NE2','CTB_OF','2',10120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +2,'CAP_1311EX2','CTB_OF','2',10121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +3,'INT_1311NE2','CTB_OF','2',11120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +4,'INT_1311EX2','CTB_OF','2',11121,'N','D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +5,'COM_5321','CTB_OF','2',15120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +6,'COM_5321','CTB_OF','2',15121,'N','D', NULL, 'L')

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +7,'24010702','CTB_OF','2',12120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +8,'24010702','CTB_OF','2',12121,'N','D', NULL, 'L')

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +9,'24010702','CTB_OF','2',16120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',@w_asiento +10,'24010702','CTB_OF','2',16121,'N','D', NULL, 'L')




--CAMBIOS DE ESTADO 

select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'CCA_EST'
--No exigible
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+1,'CAP_1311NE2','CTB_OF','1',10120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+2,'INT_1311NE2','CTB_OF','1',11120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+3,'INT_5105NE2','CTB_OF','2',11120,'N','D', NULL, 'L')

--Exigible
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+4,'CAP_1311EX2','CTB_OF','1',10121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+5,'INT_1311EX2','CTB_OF','1',11121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',@w_asiento+6,'INT_5105EX2','CTB_OF','2',11121,'N','D', NULL, 'L')

--BOC


select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'BOC_ACT'
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',@w_asiento +1,'CAP_1311NE2','CTB_OF','1',10120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',@w_asiento +2,'CAP_1311EX2','CTB_OF','1',10121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',@w_asiento+3,'INT_1311NE2','CTB_OF','1',11120,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',@w_asiento+4,'INT_1311EX2','CTB_OF','1',11121,'N','D', NULL, 'L')
--CASTIGOS 


select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'CCA_CAS'
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',@w_asiento+1,'CAP_1311EX2','CTB_OF','1',10121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',@w_asiento+2,'INT_1311EX2','CTB_OF','1',11121,'N','D', NULL, 'L')


--VENCIMIENTO DE CUOTA 
select @w_asiento = max(dp_asiento) from  cob_conta..cb_det_perfil where dp_perfil = 'CCA_VEN'
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+1,'CAP_1311NE2','CTB_OF','2',10121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+2,'CAP_1311EX2','CTB_OF','1',10121,'N','D', NULL, 'L')

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+3,'INT_1311NE2','CTB_OF','2',11121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+4,'INT_1311EX2','CTB_OF','1',11121,'N','D', NULL, 'L')

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+5,'INT_5105NE2','CTB_OF','1',11121,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',@w_asiento+6,'INT_5105EX2','CTB_OF','2',11121,'N','D', NULL, 'L')


select * from cob_conta..cb_det_perfil where dp_cuenta in (

'CAP_1311NE2',
'CAP_1311EX2',
'INT_1311NE2',
'INT_1311EX2',
'INT_5105NE2',
'INT_5105EX2'
)




--CODIGOS VALOR DE LA CONTA 
-- 
delete cb_codigo_valor where cv_codval in(11012,10013,11013,10012)
INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 11012, 'INTERES CORRIENTE - VIGENTE - ETAPA2')


INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 10013, 'CAPITAL - VIGENTE -ETAPA2')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 11013, 'INTERES CORRIENTE - VIGENTE - ETAPA2')


INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 10012, 'CAPITAL - VIGENTE - ETAPA2')


select * from cb_codigo_valor where cv_codval in(11012,10013,11013,10012)

---CUENTAS PROCESO



select * into #cb_cuenta_proceso from cb_cuenta_proceso where 1 =2


insert into #cb_cuenta_proceso 
select 
cp_proceso = (case cu_movimiento when 'N' then 36411 else 6003 end),
cp_empresa = 1,
cp_cuenta  = cu_cuenta ,
cp_oficina = 0,
cp_area    = 0,
cp_imprima = '0',
cp_condicion = '1',
cp_texto = 'ETAPA2',
cp_quiebre = null
from cb_cuenta 
where  cu_nombre like '%ETAPA 2%'
and not exists(select 1 from cb_cuenta_proceso where cp_cuenta = cu_cuenta)

insert into cb_cuenta_proceso 
select * from #cb_cuenta_proceso 

--VERIFICACION 
select cu_movimiento ,cu_nombre, c.* 
from cb_cuenta_proceso c , cb_cuenta 
where cp_cuenta = cu_cuenta 
and cu_nombre like '%ETAPA 2%'

drop table #cb_cuenta_proceso
go 