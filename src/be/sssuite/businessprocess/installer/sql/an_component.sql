
use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

SELECT @w_prod_name = 'WF' 
SELECT @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=E')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=E', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=Q')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual Consulta', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
	                                                                       
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Impresion de Documentos Modal')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Impresion de Documentos Modal', 'VC_ITCII49_TNYFM_899_TASK.html', 'views/BUSIN/FLCRE/T_FLCRE_68_ITCII49/1.0.0/', 'I', NULL, @w_prod_name) 
end 

---------->>>>>>>>>> se regulaiza con lo que esta en prod y estara por el caso 194284 Dia de Pago
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Tabla de Amortización - Grupal')
begin
    insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Grupal', 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, @w_prod_name)
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Tabla de Amortización - Modo Consulta')
begin
    insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Modo Consulta', 'VC_TPYEP21_FAETL_814_TASK.html?SOLICITUD=INDIVIDUAL&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, @w_prod_name)
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Tabla de Amortización - Individual')
begin
    insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Individual', 'VC_TPYEP21_FAETL_814_TASK.html?SOLICITUD=INDIVIDUAL', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, @w_prod_name)
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Tabla de Amortización - Grupal Consulta')
begin
    insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Grupal Consulta', 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, @w_prod_name)
end

--Cuestionario

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Verificación de Datos - GRUPAL')
begin
    INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos - GRUPAL', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Verificación de Datos - INDIVIDUAL')
begin
    INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos - INDIVIDUAL', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=NORMAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end


--Solicitud Grupal espera automatica

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Ingreso de Datos - Grupal Consulta Espera')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Grupal Consulta Espera', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=GRUPAL&MODE=A', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Solicitud Grupal espera automatica Cancelacion Credito

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Ingreso de Datos - Grupal Consulta Espera Credito')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Grupal Consulta Espera Credito', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=GRUPAL&MODE=A&TIPO=C', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Individual espera automatica

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Ingreso de Datos - Individual Consulta Espera')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual Consulta Espera', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=A', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Solicitud Individual espera automatica Cancelacion Credito

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Ingreso de Datos - Individual Consulta Espera Credito')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual Consulta Espera Credito', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=A&TIPO=C', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Documentos Digitalizados - Consulta Colectivo
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Documentos Digitalizados - Consulta Colectivo')
begin
   INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
   VALUES (@w_co_id, @w_co_mo_id, 'Documentos Digitalizados - Consulta Colectivo', 'VC_SCANNEDDMO_244525_TASK.html?SOLICITUD=COLECTIVOS&MODE=Q', 'views/CSTMR/CSTMR/T_CSTMRNSVOOQTG_525/1.0.0/', 'I', NULL, 'WF')
end

--Biometricos GRUPAL

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'VALIDACION BIOMETRICO')
begin
   insert an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
   values (@w_co_id, @w_mo_id,  'VALIDACION BIOMETRICO', 'VC_BIOVALIDSA_412339_TASK.html?SOLICITUD=GRUPAL', 'views/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339/1.0.0/','I', NULL, 'WF')
end

--Biometricos LCR


SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'VALIDACION BIOMETRICO LCR')
begin
   insert an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
   values (@w_co_id, @w_mo_id,  'VALIDACION BIOMETRICO LCR', 'VC_BIOVALIDSA_412339_TASK.html?SOLICITUD=LCR', 'views/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339/1.0.0/','I', NULL, 'WF')
end 
GO

delete from an_component where co_name in ('Grupos Renovación','Ingreso de Datos - Grupal Renovación','Grupos Aprobar Préstamo Renovación','Grupos Consulta Renovación')

declare @w_id int

select @w_id = max(co_id) + 1 from an_component

INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id, 73216, 'Grupos Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=INGRESO&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+1, 18, 'Ingreso de Datos - Grupal Renovación', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=GRUPAL&Tipo=R', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')

INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+2, 73216, 'Grupos Aprobar Préstamo Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+3, 86018, 'Grupos Consulta Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=CONSULTA&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

go