use cobis
go
--Insercion de servicios
if not exists(select 1 from cobis..cts_serv_catalog where csc_service_id = 'LoanGroup.ScannedDocuments.QueryScannedDocuments')
begin
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ScannedDocuments.QueryScannedDocuments','cobiscorp.ecobis.loangroup.service.IScannedDocuments',
'queryScannedDocuments','Consulta de documentos por miembros del grupo',21365,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.ScannedDocuments.QueryScannedDocuments',2,'R',0,getdate(),3,'V',getdate())
end
go
--Update
if not exists(select 1 from cobis..cts_serv_catalog where csc_service_id = 'LoanGroup.ScannedDocuments.UpdateScannedDocuments')
begin
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ScannedDocuments.UpdateScannedDocuments','cobiscorp.ecobis.loangroup.service.IScannedDocuments',
'updateScannedDocuments','Actualización de documentos por miembros del grupo',21365,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.ScannedDocuments.UpdateScannedDocuments',2,'R',0,getdate(),3,'V',getdate())
end
go

if exists(select 1 from cobis..cts_serv_catalog where csc_service_id = 'LoanGroup.ScannedDocuments.UpdateScannedDocuments' and csc_method_name = 'queryScannedDocuments')
begin
update cobis..cts_serv_catalog
set csc_method_name = 'updateScannedDocuments',
csc_description = 'Actualización de documentos por miembros del grupo'
where csc_service_id = 'LoanGroup.ScannedDocuments.UpdateScannedDocuments'
end
go

--Insercion del catalogo
if not exists(select 1 from cobis..cl_tabla where tabla = 'cr_doc_digitalizado')
begin
  print 'cr_doc_digitalizado'
  declare @w_tabla smallint
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','PAGARES','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','REGLAMENTO INTERNO','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','IDENTIFICACION OFICIAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','COMPROBANTE DE DOMICILIO','V') 
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AVISO DE PRIVACIDAD','V')    
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AUTORIZACION DE CONSULTA BURO DE CREDITO','V') 
end
else
begin
	delete cl_catalogo_pro
	from cl_tabla
	where tabla in ('cr_doc_digitalizado')
	and codigo = cp_tabla
	
	delete cl_catalogo
	from cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado')
	and cl_tabla.codigo = cl_catalogo.tabla
	
	delete cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado')
	
	
  print 'cr_doc_digitalizado'
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','PAGARES','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','REGLAMENTO INTERNO','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','IDENTIFICACION OFICIAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','COMPROBANTE DE DOMICILIO','V') 
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AVISO DE PRIVACIDAD','V')    
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AUTORIZACION DE CONSULTA BURO DE CREDITO','V') 
end
go

--Insercion del catalogo cr_doc_digitalizado_ind
if not exists(select 1 from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind')
begin
  print 'cr_doc_digitalizado'
  declare @w_tabla smallint
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_ind','Documentos digitalizados para clientes individuales')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V')   
end
else
begin
	delete cl_catalogo_pro
	from cl_tabla
	where tabla in ('cr_doc_digitalizado_ind')
	and codigo = cp_tabla
	
	delete cl_catalogo
	from cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado_ind')
	and cl_tabla.codigo = cl_catalogo.tabla
	
	delete cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado_ind')
	
  print 'cr_doc_digitalizado_ind'
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_ind','Documentos digitalizados para clientes individuales')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V')  
end
go

--Insercion del catalogo cr_doc_digitalizado_flujo_ind
if not exists(select 1 from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_flujo_ind')
begin
  print 'cr_doc_digitalizado'
  declare @w_tabla smallint
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_flujo_ind','Documentos digitalizados para flujo individual')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V') 
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AVISO DE PRIVACIDAD INDIVIDUAL / AVAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','AUTORIZACION BURO INDIVIDUAL / AVAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','IDENTIFICACION FRONTAL INDIVIDUAL / AVAL','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'009','IDENTIFICACION TRASERA INDIVIDUAL / AVAL','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'010','COMPROBANTE DOMICILIO INDIVIDUAL / AVAL','V')    
end
else
begin
	delete cl_catalogo_pro
	from cl_tabla
	where tabla in ('cr_doc_digitalizado_flujo_ind')
	and codigo = cp_tabla
	
	delete cl_catalogo
	from cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado_flujo_ind')
	and cl_tabla.codigo = cl_catalogo.tabla
	
	delete cl_tabla
	where cl_tabla.tabla in ('cr_doc_digitalizado_flujo_ind')
	
  print 'cr_doc_digitalizado_flujo_ind'
  select @w_tabla = max(codigo)+ 1 from cl_tabla
  insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_flujo_ind','Documentos digitalizados para flujo individual')
  insert into cl_catalogo_pro values ('CRE', @w_tabla)
  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AVISO DE PRIVACIDAD INDIVIDUAL / AVAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','AUTORIZACION BURO INDIVIDUAL / AVAL','V')
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','IDENTIFICACION FRONTAL INDIVIDUAL / AVAL','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'009','IDENTIFICACION TRASERA INDIVIDUAL / AVAL','V')  
  insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'010','COMPROBANTE DOMICILIO INDIVIDUAL / AVAL','V')  
end
go


use cob_credito
go
--Creacion de la tabla
IF OBJECT_ID ('dbo.cr_documento_digitalizado') IS NOT NULL
	DROP TABLE dbo.cr_documento_digitalizado
begin

CREATE TABLE cr_documento_digitalizado
    (
    dd_inst_proceso    	int not null,
    dd_cliente     	   	int not null,
    dd_grupo  		   	int not null,
    dd_fecha   			datetime not null,
    dd_tipo_doc   		char (10) not null,
    dd_cargado     		char (1) null,
	dd_extension		char(8) null
    )
	


create nonclustered index cr_documento_digitalizado_key 
on cr_documento_digitalizado(dd_inst_proceso, dd_cliente, dd_grupo, dd_tipo_doc)
end
go

--Insercion de la pantalla en an_component
-----------------------------------------------------------------------------------
print 'Inicio Registro de Pantalla de Documentos Digitalizados'
go

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

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_SCANNEDDEU_695486_TASK.html?SOLICITUD=GRUPAL')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Documentos Digitalizados', 'VC_SCANNEDDEU_695486_TASK.html?SOLICITUD=GRUPAL', 'views/LOANS/GROUP/T_LOANSCAIEJKDY_486/1.0.0/', 'I', NULL, @w_prod_name)
end 
GO


--Insercion de la pantalla en an_component
-----------------------------------------------------------------------------------
print 'Inicio Registro de Pantalla de Documentos Digitalizados Flujo Individual'
go

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

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_SCANNEDDMO_244525_TASK.html?SOLICITUD=NORMAL')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Documentos Digitalizados Flujo Individual', 'VC_SCANNEDDMO_244525_TASK.html?SOLICITUD=NORMAL', 'views/CSTMR/CSTMR/T_CSTMRNSVOOQTG_525/1.0.0/', 'I', NULL, @w_prod_name)
end 
GO

