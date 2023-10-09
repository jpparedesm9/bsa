
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 96425: Mejoras al kit de crédito
--Fecha                      : 12/07/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/


--------------------------------------------------------------------------------------------
-- ACTUALIZA CATALOGO
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-96425/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql

use cobis
go


SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
FROM cobis..cl_tabla WHERE tabla = 'cr_doc_digitalizado_ind')

SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
FROM cobis..cl_tabla WHERE tabla = 'cr_doc_digitalizado')

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CRE'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')                                              
and cl_tabla.codigo = cl_catalogo.tabla

go                                       
delete cl_tabla                          
 where cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')                                    
go

--cr_doc_digitalizado_ind
print 'cr_doc_digitalizado_ind'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_ind','Documentos digitalizados para clientes individuales')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','REPORTE DE CREDITO EXTERNO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','REPORTE DE CREDITO INTERNO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','SOLICITUD DE CREDITO CORTA','V') 

--cr_doc_digitalizado
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','PAGARES','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','REGLAMENTO INTERNO','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','IDENTIFICACION OFICIAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','COMPROBANTE DE DOMICILIO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AVISO DE PRIVACIDAD','V')    
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AUTORIZACION DE CONSULTA BURO DE CREDITO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','CONSENTIMIENTO INDIVIDUAL','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','FORMATO DE DOMICILIACION','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'009 ','SOLICITUD DE CREDITO COMPLEMENTARIA','V') 


update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'
go

SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
FROM cobis..cl_tabla WHERE tabla = 'cr_doc_digitalizado_ind')

SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo 
FROM cobis..cl_tabla WHERE tabla = 'cr_doc_digitalizado')