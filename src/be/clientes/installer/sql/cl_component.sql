use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
select @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Grupos')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=INGRESO', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end 

--Pantalla de documentos digitalizados

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_SCANNEDDEU_695486_TASK.html?SOLICITUD=GRUPAL')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Documentos Digitalizados', 'VC_SCANNEDDEU_695486_TASK.html?SOLICITUD=GRUPAL', 'views/LOANS/GROUP/T_LOANSCAIEJKDY_486/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Consulta Grupal espera automatica Cancelacion Credito

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=CONSULTA&TIPO=C')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos Consulta Espera Credito', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=CONSULTA&TIPO=C', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name)
end 

--Pantalla de Aprobar
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR')
begin
    INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    VALUES (@w_co_id, @w_mo_id, 'Grupos Aprobar Préstamo', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end

--Pantalla de Eliminar Participantes
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos Eliminar Participantes', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end
GO
--Pantallas para en modo consulta y espera para Credito Revolvente
USE cobis 
go
declare @w_co_id int
select @w_co_id = max(co_id) from an_component

select @w_co_id = @w_co_id + 1
IF NOT EXISTS(SELECT 1 FROM cobis..an_component WHERE 
               co_name='Ingreso de Datos - Individual Revolvente Consulta'
               AND co_class='VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=LCR&MODE=Q')
               BEGIN

                   INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
                   VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual Revolvente Consulta', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=LCR&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')
               end
GO
USE cobis 
go
declare 
@w_co_id_1 int,
@w_mo_id   int

select @w_co_id_1 = max(co_id) from an_component
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'

select @w_co_id_1 = @w_co_id_1 + 1
IF NOT EXISTS(SELECT 1 FROM cobis..an_component WHERE 
               co_name='Ingreso de Datos - Individual Revolvente Consulta Espera'
               AND co_class='VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=LCR&MODE=A&TIPO=C')
               BEGIN

INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_co_id_1, @w_mo_id, 'Ingreso de Datos - Individual Revolvente Consulta Espera', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=LCR&MODE=A&TIPO=C', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')
end
GO

-----------------------------------------
------- BIOMETRICOS ---------------------
-----------------------------------------
USE cobis 
go
declare 
@w_co_id_1 int
@w_mo_id   int

select @w_co_id_1 = max(co_id) from an_component

select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'

select @w_co_id_1 = @w_co_id_1 + 1
IF NOT EXISTS(SELECT 1 FROM cobis..an_component WHERE 
               co_name = 'VALIDACION BIOMETRICO'
               AND co_class='VC_BIOVALIDSA_412339_TASK.html')
               BEGIN

insert into cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values(@w_co_id_1,@w_mo_id,'VALIDACION BIOMETRICO','VC_BIOVALIDSA_412339_TASK.html','views/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339/1.0.0/','I',NULL,'WF')

end
GO

declare @w_component_id int,
		@w_module_id int
		
delete from an_component where co_name='Investigar Negocio' and co_class='VC_GENERALBSI_401479_TASK.html'

select @w_component_id = max(co_id) +1 from an_component
select @w_module_id = mo_id from an_module where mo_name='IBX.InboxOficial'

insert into an_component values(@w_component_id,@w_module_id,'VC_GENERALBSI_401479_TASK.html','views/BSSNS/CSTMR/T_BSSNSKNPPLXIB_479/1.0.0/','I',NULL,'WF')
go