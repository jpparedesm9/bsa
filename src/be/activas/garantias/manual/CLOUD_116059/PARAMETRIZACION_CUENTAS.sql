 use cob_conta 
 go 

--cuenta 
INSERT INTO dbo.cb_cuenta (cu_empresa, cu_cuenta, cu_cuenta_padre, cu_nombre, cu_descripcion, cu_estado, cu_movimiento, cu_nivel_cuenta, cu_categoria, cu_fecha_estado, cu_moneda, cu_sinonimo, cu_acceso, cu_presupuesto)
VALUES (1, '240191', '2401', 'CONTROL OPERATIVO CONTABLE DE GARANTIAS', 'CONTROL OPERATIVO CONTABLE DE GARANTIAS', 'V', 'S', 4, 'C', '07/02/2018', 0, NULL, 'A', NULL)
GO


--cuenta proceso
INSERT INTO dbo.cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre)
VALUES (6003, 1, '240191', 0, 0, '0', '1', '', '')
GO


select * into #cb_plan_general from cb_plan_general where pg_cuenta ='241302'

update #cb_plan_general set pg_cuenta = '240191'

update #cb_plan_general set pg_clave  = convert(varchar,pg_empresa)+ltrim(rtrim(pg_cuenta))+convert(varchar,pg_oficina)++convert(varchar,pg_area)


insert into cb_plan_general select * from #cb_plan_general


update cb_relparam set 
re_substring       = '240191'
where re_substring = '241302'


update cb_det_perfil set
dp_cuenta       = '240191'
where dp_cuenta ='241302'



update cobis..cl_parametro set 
pa_char ='240191'
where pa_nemonico = 'CTGARL'
and   pa_producto   = 'CCA'







--BOC GARANTIAS 


--Cuenta de garantías  --'240190'--CUENTA DE LA CONTABILIDAD GESBAN
--crear cuenta hermana 240191  CONTROL OPERATIVO CONTABLE DE GARANTIAS  (NUEVA) 
---select @w_cuenta = '241302'  --CUENTA ACTUAL



--BOC DE GARANTIA ANTES DEL BATCH. 
--0.-INSTALAR EL BOC DE GAR 
-- CREACION DEL PARAMETRO 241302
--CORRER EL BATCH HASTA LA SARTA 13 
--*********verificar el boc de garantias 

--1.- PARAMETRIA INCLUYL2 UPDATE PARAMETRO A LA CUENTA NUEVA 240191
--2.- SCRIPT DEL TRASLADO DE SALDOS  
--*********verificar la creacion de los asientos y comprobantes 

--3.- LLENA LA CUENTA NUEVA SCRIPT INICIALIZACION 
--*********verificar la creacion de los asientos y comprobantes

 --3.1 --EJECUTAR LA LINEA DE LA CONTABILIDAD 
--4.- REEJUCUTAR EL BOC 
--*********verificar el boc de garantias 

--CAMBIO DE FECHA-- SARTA 22
--LINEA  

