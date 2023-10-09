--El día de ayer se se le asignó la tarea a la analista Teresita Andraca Mejía 
--de la sucursal de Renacimiento (lo cual no corresponde, ya que los roles se 
--encontraban incorrectos, con el ususario de Ervin Prado se hizo la reasignacion), 
--se solicita por favor que se reasigne el grupo a la sucursal de Yautepec, y 
--el kit de bienvenida hacer la correccion de los datos del analista correcto 
--y el nombre del gerente correcto.
--
--ID GRUPO: 1164
--NOMBRE: TLAYACAPAN
--
--NOMBRE DEL ANALISTA:GUADALUPE GUERRERO (REYES) (gguerrero)-- NO ERA CHAVEZ, SE CORRIEGE
--NOMBRE DEL GERENTE: EDER MANUEL VALENCIA MONTES (emvalencia)

--ESTA CON tandraca -- TERESITA ANDRACA MEJIA -- aNALISTA
--ESTA CON kfajardo -- KENIA FAJARDO MAGANDA -- GERENTE

--GERENTE
update cob_workflow..wf_asig_actividad
set    aa_id_destinatario = 223-- RESPALDO W 253
WHERE  aa_id_asig_act = 10757 
and    aa_id_inst_act = 21090

GO

--ANALISTA
update cob_workflow..wf_asig_actividad
set    aa_id_destinatario = 219 --RESPALDO W 247
WHERE  aa_id_asig_act = 10735 
and    aa_id_inst_act = 21048
GO


--1039
