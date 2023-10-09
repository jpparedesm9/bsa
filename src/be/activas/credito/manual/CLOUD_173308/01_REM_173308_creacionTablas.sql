------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>
------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>
use cob_cartera
go

IF OBJECT_ID ('dbo.lista_cliente_caso173308') IS NOT NULL
	DROP table dbo.lista_cliente_caso173308
GO

create table lista_cliente_caso173308(
	ente int,
	periodicidad varchar(10),
	asesor varchar(14),
	fecha_ven datetime,
	oficial int,
	oficina int,
	es_cliente char(1),
	tiene_solicitud char(1),
	tiene_oficial_jer char(1),
	procesado char(1),
	est_wf varchar(255),
	est_fun varchar(255),
	rol_wf varchar(255),
	error varchar(255)
)

--SELECT * FROM cob_workflow..wf_inst_proceso WHERE io_campo_1 IN (331222,258262,230377)
--SELECT * FROM lista_cliente_caso173308 where ente IN (311866)
insert into lista_cliente_caso173308 values (286450, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (257219, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (331222, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (258262, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (230377, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (264617, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (339776, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (269178, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (343117, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (300470, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (339715, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (354818, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (318585, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (315234, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (311866, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (364355, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (339341, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (283376, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (338127, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (379836, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (335062, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (339685, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (364048, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (271192, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (277526, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (285098, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (303122, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (308977, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (264628, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (259980, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (301164, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (229956, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (301630, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (390031, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (235006, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (351678, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (306970, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (390466, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (300211, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (339558, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (316398, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (391180, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (343862, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (308385, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (340492, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (236084, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (255191, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (401214, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (364056, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (221894, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (317930, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (264575, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (328590, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (369227, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (362392, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (411305, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (265987, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (198417, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (415642, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
insert into lista_cliente_caso173308 values (417175, 'BW', '', '01/01/1990', 0, 0, 'N', 'N', 'N', 'N','','','', '')
go

update cob_workflow..wf_inst_proceso
set io_estado = 'TER'
where io_campo_1 in (select ente from lista_cliente_caso173308)
and io_campo_4 <> 'GRUPAL'
and io_estado = 'EJE'

update lista_cliente_caso173308
set oficial = en_oficial,
    oficina = en_oficina
from cobis..cl_ente
where ente = en_ente

update lista_cliente_caso173308
set es_cliente = 'S'
from cobis..cl_ente_aux
where ente = ea_ente
and ea_estado = 'A'

update lista_cliente_caso173308
set tiene_solicitud = 'S'
from cob_workflow..wf_inst_proceso
where io_campo_1 = ente
and io_campo_4 <> 'GRUPAL'
and io_estado = 'EJE'

update lista_cliente_caso173308
set asesor = fu_login,
    tiene_oficial_jer = 'S'
from cobis..cc_oficial, cobis..cl_funcionario
where oficial = oc_oficial
and oc_funcionario = fu_funcionario

update lista_cliente_caso173308
set est_wf = us_estado_usuario
from cob_workflow..wf_usuario 
where us_login = asesor

update lista_cliente_caso173308
set est_fun = fu_estado
from cobis..cl_funcionario
where fu_login = asesor

update lista_cliente_caso173308
SET rol_wf = convert(VARCHAR(30), ro_id_rol) + '-' + ro_nombre_rol
from cob_workflow..wf_usuario, cob_workflow..wf_usuario_rol, cob_workflow..wf_rol
where us_login = asesor
and us_id_usuario = ur_id_usuario
and ur_id_rol = ro_id_rol

update lista_cliente_caso173308 
set fecha_ven = fp_fecha
from cobis..ba_fecha_proceso

SELECT * FROM lista_cliente_caso173308

go

