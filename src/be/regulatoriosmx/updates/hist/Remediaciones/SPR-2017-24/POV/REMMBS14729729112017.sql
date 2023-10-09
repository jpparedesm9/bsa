
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S147297 CC017 Seguros - Digitalizacion
--Fecha                      : 29/11/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_doc_digitalizado')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_doc_digitalizado')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cr_doc_digitalizado')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla



--cr_doc_digitalizado
insert into cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','PAGARES','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','REGLAMENTO INTERNO','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','IDENTIFICACION OFICIAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','COMPROBANTE DE DOMICILIO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AVISO DE PRIVACIDAD','V')    
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AUTORIZACION DE CONSULTA BURO DE CREDITO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','CONSENTIMIENTO INDIVIDUAL','V')  


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CRE', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cr_doc_digitalizado')
go

--------------------------------------------------------------------------------------------
-- Crear PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_parametro.sql

USE cobis
GO

delete cobis..cl_parametro
 where pa_producto = 'CRE'
   and pa_nemonico in ('EMICI', 'EMACI')
go

delete cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico in ('CTASTD')
go


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EDAD MINIMA CONSENTIMIENTO INDIVIDUAL', 'EMICI', 'T', NULL, 18, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EDAD MAXIMA CONSENTIMIENTO INDIVIDUAL', 'EMACI', 'T', NULL, 75, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

INSERT INTO cobis..cl_parametro VALUES('PAGO SEGURO', 'CTASTD', 'C', '65506362078', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

GO

--------------------------------------------------------------------------------------------
-- Crear Perfil
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_perfiles.sql

USE cob_conta
go


if not exists (select 1 from cob_conta..cb_perfil where pe_perfil = 'CCA_SEG' and pe_empresa = 1 and pe_producto = 7)
begin
	insert into cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
	values (1,7,'CCA_SEG','PAGO SEGURO')
end

if not exists (select 1 from cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEG' and dp_empresa = 1 and dp_producto = 7 and dp_asiento = 1)
begin
	insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
	values (1, 7, 'CCA_SEG', 1, '11020202', 'CTB_OF', '1', 10010, 'N', 'O', NULL, 'L')
end

if not exists (select 1 from cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEG' and dp_empresa = 1 and dp_producto = 7 and dp_asiento = 2)
begin
	insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
	values (1, 7, 'CCA_SEG', 2, '240123', 'CTB_OF', '2', 10010, 'N', 'O', NULL, 'L')
end
