/*
DECLARE @w_numero int, 
@w_producto INT = 2


SELECT * from cobis..ad_tr_autorizada where ta_transaccion = 1718 and ta_producto = 2


SELECT * from cobis..ad_tr_autorizada where ta_transaccion = 1718 and ta_producto = 2
SELECT * from cobis..ad_pro_transaccion where pt_procedure = 1718 and pt_transaccion = 1718 and pt_producto = 2
SELECT * from cobis..cl_ttransaccion where tn_trn_code = 1718
SELECT * from cobis..ad_procedure where pd_procedure = 1718
*/

/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S143267 CC Formato KYC - Reporte
--Fecha                      : 31/10/2017
--Descripción del Problema   : Se agrega un sp nuevo por lo que no tiene las respectivas autorizaciones y registros
--Descripción de la Solución : Generar el script para registrar el sp en las tablas respectivas
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/


---------------------------------------------------------------------------------------
-------------------------Registrar Servicio de Consulta de KYC-------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_services_authorization.sql

use cobis
go

delete cts_serv_catalog
where csc_service_id = 'LoanGroup.ReportMaintenance.SearchKYC'

delete ad_servicio_autorizado
where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC'


declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


-------------------------
--SERVICIO CreateGroup
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('LoanGroup.ReportMaintenance.SearchKYC','cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchKYC', '', 1718)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
GO



--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- activa/credito   --sp_reporte_kyc
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_segur.sql
PRINT '--->> Registro de sp sp_reporte_kyc.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 1718
select @w_producto = 2
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_reporte_kyc','cobis','V',getdate(),'sp_rep_kyc.sp')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_numero, 'REPORTE KYC', '1718', 'ENVIAR INFORMACION PARA GENERAR REPORTE KYC')


insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
GO




---------------------------------------------------------------------------------------
-------------------------Crear tabla de Actividades Economicas-------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql


use cobis
go


IF OBJECT_ID ('dbo.cl_actividad_generica') IS NOT NULL
	DROP TABLE dbo.cl_actividad_generica
GO

CREATE TABLE dbo.cl_actividad_generica
	(
	acg_actividad_generica 		varchar(15) not null, --sector en el archivo
	acg_codigo_actividad 		varchar(10) not null, -- este es el código que tenemos que almacenar en el sistema.
	acg_actividad_especifica  	varchar(150) not null, ---- (cobis..cl_actividad_ec)
	acg_nombre_corto 			varchar(40),
	acg_nivel_riesgo 			varchar(15),
	acg_valor  					money
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_actividad_generica_Key
	ON dbo.cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad)
GO

---------------------------------------------------------------------------------------
---------------------------Truncate table y llenado de tabla---------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ac_descripcion' AND TABLE_NAME = 'cl_actividad_ec')
BEGIN
    ALTER TABLE cobis..cl_actividad_ec ADD ac_descripcion varchar(200) NULL 
END
else
begin
 	ALTER TABLE cobis..cl_actividad_ec ALTER COLUMN ac_descripcion varchar(200) NULL 
end


---------------------------------------------------------------------------------------
------------------Truncate table y llenado de tabla (cl_actividad_ec)------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : 5_sta_data.sql

truncate table cl_actividad_ec
go

--CAFETERIA


insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('7512016', 'AGENCIA DE TURISMO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6992011', 'AGENCIAS DE RIFAS Y SORTEOS (QUINIELAS Y LOTERIA)')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8711013', 'CAFETERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8831019', 'CENTRO NOCTURNO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911029', 'COMPRA DE CASA HABITACION')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6991013', 'COMPRAVENTA DE ARMAS DE FUEGO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6622022', 'COMPRAVENTA DE ARTICULOS DE FERRETERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6211015', 'COMPRAVENTA DE ARTICULOS DE LENCERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6215017', 'COMPRAVENTA DE ARTICULOS DE MERCERIA Y CEDERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6325048', 'COMPRAVENTA DE ARTICULOS REGIONALES CURIOSIDADES Y ARTESANIAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6811013', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES NUEVOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6812011', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES USADOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6212013', 'COMPRAVENTA DE CALZADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6124010', 'COMPRAVENTA DE CARNE DE AVES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911045', 'COMPRAVENTA DE CASAS Y OTROS INMUEBLES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6999017', 'COMPRAVENTA DE DIAMANTES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6323018', 'COMPRAVENTA DE DISCOS Y CASSETTES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132013', 'COMPRAVENTA DE DULCES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6721036', 'COMPRAVENTA DE EQUIPO DE PROCESAMIENTO ELECTRONICO DE DATOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6326020', 'COMPRAVENTA DE FLORES Y ADORNOS FLORALES NATURALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6112015', 'COMPRAVENTA DE FRUTAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6223010', 'COMPRAVENTA DE JUGUETES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132039', 'COMPRAVENTA DE LECHE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6112023', 'COMPRAVENTA DE LEGUMBRES Y HORTALIZAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6629010', 'COMPRAVENTA DE MATERIALES PARA CONSTRUCCION')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6231013', 'COMPRAVENTA DE MEDICINAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6312011', 'COMPRAVENTA DE MUEBLES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6225024', 'COMPRAVENTA DE OTRAS JOYAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6419015', 'COMPRAVENTA DE OTROS APARATOS ELECTRICOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6329016', 'COMPRAVENTA DE OTROS ARTICULOS PARA EL HOGAR')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6119011', 'COMPRAVENTA DE OTROS PRODUCTOS ALIMENTICIOS AGRICOLAS EN ESTADO NATURAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6216023', 'COMPRAVENTA DE OTROS PRODUCTOS TEXTILES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132055', 'COMPRAVENTA DE PAN Y PASTELES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6233019', 'COMPRAVENTA DE PAPELERIA Y ARTICULOS DE ESCRITORIO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6231021', 'COMPRAVENTA DE PERFUMES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6126032', 'COMPRAVENTA DE PESCADOS Y MARISCOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6623020', 'COMPRAVENTA DE PINTURAS BARNICES Y BROCHAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6815015', 'COMPRAVENTA DE REFACCIONES Y ACCESORIOS NUEVOS PARA AUTOS Y CAMIONES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6134019', 'COMPRAVENTA DE REFRESCOS AGUAS GASEOSAS Y AGUAS PURIFICADAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6225032', 'COMPRAVENTA DE RELOJES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6211023', 'COMPRAVENTA DE ROPA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6111017', 'COMPRAVENTA DE SEMILLAS Y GRANOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911053', 'COMPRAVENTA DE TERRENOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3319010', 'ELABORACION DE OBJETOS ARTISTICOS DE ALFARERIA Y CERAMICA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9501009', 'EMPLEADO DEL SECTOR PRIVADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9502007', 'EMPLEADO DEL SECTOR PUBLICO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8429046', 'EMPRESAS TRANSPORTADORAS DE VALORES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3997014', 'FABRICACION DE ARMAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3932010', 'FABRICACION DE ARTICULOS DE JOYERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3933018', 'FABRICACION DE ARTICULOS DE QUINCALLERIA Y BISUTERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3921013', 'FABRICACION DE RELOJES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8800002', 'JUEGOS DE FERIA Y APUESTAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8934011', 'LAVANDERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2023018', 'MOLINO DE NIXTAMAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8200001', 'MONTEPÍO Ó CASAS DE EMPEÑO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9504003', 'NEGOCIOS RELACIONADOS CON INTERNET')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8714017', 'NEVERIA Y REFRESQUERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8400003', 'NOTARÍAS PÚBLICAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8711021', 'RESTAURANTE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8933013', 'SALON DE BELLEZA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6800003', 'SERVICIOS DE BLINDAJE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8411019', 'SERVICIOS DE NOTARIAS PUBLICAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8719017', 'SERVICIOS EN MERENDEROS CENADURIAS Y PREPARACION DE ANTOJITOS Y PLATILLOS REGIONALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('04200002', 'SERVICIOS ESPECIALES PRESTADOS POR SUBCONTRATISTAS (DEMOLICIONES, CARPINTERIA, IMPERMIABILIZACIÓN, INST ESLECTRICAS, PINTURA, PLOMERIA)')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3932036', 'TALLADO DE PIEDRAS PRECIOSAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3516054', 'TALLER DE HERRERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3591022', 'TALLER DE HOJALATERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('4221016', 'TALLER DE PLOMERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8921018', 'TALLER DE REPARACION DE CALZADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8929020', 'TALLER DE REPARACION DE ROPA Y MEDIAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8911019', 'TALLER DE REPARACION GENERAL DE AUTOMOVILES Y CAMIONES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2412039', 'TALLER DE SASTRERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6131023', 'TIENDA DE ABARROTES Y MISCELANEA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8934029', 'TINTORERIA Y PLANCHADURIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2093011', 'TORTILLERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('7113012', 'TRANSPORTE EN AUTOMOVIL DE RULETEO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3212024', 'VULCANIZACION DE LLANTAS Y CAMARAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2413011', 'FABRICACION DE UNIFORMES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6512017', 'COMPRAVENTA DE GAS PARA USO DOMESTICO O COMERCIAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6216031', 'COMPRAVENTA DE TELAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6133029', 'COMPRAVENTA DE ALIMENTOS PARA AVES Y OTROS ANIMALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6122014', 'COMPRAVENTA DE CARNE DE RES Y OTRAS ESPECIES DE GANADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6231021', 'COMPRAVENTA DE PERFUMES')


---------------------------------------------------------------------------------------
------------------Truncate table y llenado de tabla (cl_actividad_ec)------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : 5_sta_data.sql


truncate table cl_actividad_generica
go

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '7512016', 'AGENCIA DE TURISMO', 'AGENCIA DE TURISMO', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '6992011', 'AGENCIAS DE RIFAS Y SORTEOS (QUINIELAS Y LOTERIA)', 'C/V DE LOTERIA', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8711013', 'CAFETERIA', 'CAFETERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8831019', 'CENTRO NOCTURNO', 'CENTRO NOCTURNO', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911029', 'COMPRA DE CASA HABITACION', 'C/V DE CASAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6991013', 'COMPRAVENTA DE ARMAS DE FUEGO', 'C/V DE ARMAS DE FUEGO', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6622022', 'COMPRAVENTA DE ARTICULOS DE FERRETERIA', 'C/V ART FERRETERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6211015', 'COMPRAVENTA DE ARTICULOS DE LENCERIA', 'C/V LENCERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6215017', 'COMPRAVENTA DE ARTICULOS DE MERCERIA Y CEDERIA', 'MERCERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO', 'C/V ART PARA REGALO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6325048', 'COMPRAVENTA DE ARTICULOS REGIONALES CURIOSIDADES Y ARTESANIAS', 'C/V ARTESANIAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6811013', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES NUEVOS', 'C/V DE AUTOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6812011', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES USADOS', 'C/V DE AUTOS USADOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6212013', 'COMPRAVENTA DE CALZADO', 'C/V CALZADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6124010', 'COMPRAVENTA DE CARNE DE AVES', 'POLLERIA', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911045', 'COMPRAVENTA DE CASAS Y OTROS INMUEBLES', 'C/V DE CASAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6999017', 'COMPRAVENTA DE DIAMANTES', 'C/V DE DIAMANTES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6323018', 'COMPRAVENTA DE DISCOS Y CASSETTES', 'C/V DISCOS Y CASSETTES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132013', 'COMPRAVENTA DE DULCES', 'C/V DE DULCES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6721036', 'COMPRAVENTA DE EQUIPO DE PROCESAMIENTO ELECTRONICO DE DATOS', 'C/V ART DE COMPUTACION', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6326020', 'COMPRAVENTA DE FLORES Y ADORNOS FLORALES NATURALES', 'FLORERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6112015', 'COMPRAVENTA DE FRUTAS', 'C/V DE FRUTAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6223010', 'COMPRAVENTA DE JUGUETES', 'C/V DE JUGUETES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132039', 'COMPRAVENTA DE LECHE', 'C/V DE LECHE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6112023', 'COMPRAVENTA DE LEGUMBRES Y HORTALIZAS', 'C/V DE VERDURAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6629010', 'COMPRAVENTA DE MATERIALES PARA CONSTRUCCION', 'C/V MATERIALES PARA CONSTRUCCIÓN', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6231013', 'COMPRAVENTA DE MEDICINAS', 'COMPRAVENTA DE MEDICINAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6312011', 'COMPRAVENTA DE MUEBLES', 'COMPRAVENTA DE MUEBLES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6225024', 'COMPRAVENTA DE OTRAS JOYAS', 'C/V DE JOYAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6419015', 'COMPRAVENTA DE OTROS APARATOS ELECTRICOS', 'C/V APARATOS ELECTRÓNICOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6329016', 'COMPRAVENTA DE OTROS ARTICULOS PARA EL HOGAR', 'C/V ARTICULOS PARA EL HOGAR', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6119011', 'COMPRAVENTA DE OTROS PRODUCTOS ALIMENTICIOS AGRICOLAS EN ESTADO NATURAL', 'VENTA DE PRODUCTOS NATURALES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS', 'C/V DE LACTEOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6216023', 'COMPRAVENTA DE OTROS PRODUCTOS TEXTILES', 'C/VPRODUCTOS TEXTILES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132055', 'COMPRAVENTA DE PAN Y PASTELES', 'PANADERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6233019', 'COMPRAVENTA DE PAPELERIA Y ARTICULOS DE ESCRITORIO', 'PAPELERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6231021', 'COMPRAVENTA DE PERFUMES', 'C/V DE PERFUES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6126032', 'COMPRAVENTA DE PESCADOS Y MARISCOS', 'C/V DE PESCADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6623020', 'COMPRAVENTA DE PINTURAS BARNICES Y BROCHAS', 'C/V DE PINTURAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6815015', 'COMPRAVENTA DE REFACCIONES Y ACCESORIOS NUEVOS PARA AUTOS Y CAMIONES', 'C/V REFACCIONES DE AUTO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6134019', 'COMPRAVENTA DE REFRESCOS AGUAS GASEOSAS Y AGUAS PURIFICADAS', 'C/V DE REFRESCOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6225032', 'COMPRAVENTA DE RELOJES', 'C/V RELOJES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6211023', 'COMPRAVENTA DE ROPA', 'C/V DE ROPA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6111017', 'COMPRAVENTA DE SEMILLAS Y GRANOS', 'C/V DE SEMILLAS Y GRANOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911053', 'COMPRAVENTA DE TERRENOS', 'C/V DE TERRENOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3319010', 'ELABORACION DE OBJETOS ARTISTICOS DE ALFARERIA Y CERAMICA', 'ALFARERIA Y CERAMICA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9501009', 'EMPLEADO DEL SECTOR PRIVADO', 'EMPLEADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9502007', 'EMPLEADO DEL SECTOR PUBLICO', 'EMPLEADO GOBIERNO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8429046', 'EMPRESAS TRANSPORTADORAS DE VALORES', 'TRANSPORTE DE VALORES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3997014', 'FABRICACION DE ARMAS', 'FABRICACIÓN DE ARMAS', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3932010', 'FABRICACION DE ARTICULOS DE JOYERIA', 'FABRICACION ART DE JOYERIA', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3933018', 'FABRICACION DE ARTICULOS DE QUINCALLERIA Y BISUTERIA', 'C/V BISUTERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3921013', 'FABRICACION DE RELOJES', 'FABRICACION REFLOJES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8800002', 'JUEGOS DE FERIA Y APUESTAS', 'JUEGOS DE FERIA Y APUESTAS', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8934011', 'LAVANDERIA', 'LAVANDERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '2023018', 'MOLINO DE NIXTAMAL', 'MOLINO DE NIXTAMAL', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8200001', 'MONTEPÍO Ó CASAS DE EMPEÑO', 'CASA DE EMPEÑO', 'PREVIO CCC', 9.991)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9504003', 'NEGOCIOS RELACIONADOS CON INTERNET', 'CYBERCAFE', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '8714017', 'NEVERIA Y REFRESQUERIA', 'NEVERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8400003', 'NOTARÍAS PÚBLICAS', 'NOTARÍAS PÚBLICAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8711021', 'RESTAURANTE', 'RESTAURANTE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8933013', 'SALON DE BELLEZA', 'SALON DE BELLEZA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '6800003', 'SERVICIOS DE BLINDAJE', 'BLINDAJE', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8411019', 'SERVICIOS DE NOTARIAS PUBLICAS', 'NOTARÍAS PÚBLICAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8719017', 'SERVICIOS EN MERENDEROS CENADURIAS Y PREPARACION DE ANTOJITOS Y PLATILLOS REGIONALES', 'C/V DE ANTOJITOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '04200002', 'SERVICIOS ESPECIALES PRESTADOS POR SUBCONTRATISTAS (DEMOLICIONES, CARPINTERIA, IMPERMIABILIZACIÓN, INST ESLECTRICAS, PINTURA, PLOMERIA)', 'CARPINTERO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3932036', 'TALLADO DE PIEDRAS PRECIOSAS', 'PIEDRAS PRECIOSAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3516054', 'TALLER DE HERRERIA', 'HERRERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3591022', 'TALLER DE HOJALATERIA', 'HOJALATERÍA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '4221016', 'TALLER DE PLOMERIA', 'PROMERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8921018', 'TALLER DE REPARACION DE CALZADO', 'REPARACIÓN DE CALZADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8929020', 'TALLER DE REPARACION DE ROPA Y MEDIAS', 'SASTRE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8911019', 'TALLER DE REPARACION GENERAL DE AUTOMOVILES Y CAMIONES', 'MECANICO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '2412039', 'TALLER DE SASTRERIA', 'SASTRE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6131023', 'TIENDA DE ABARROTES Y MISCELANEA', 'ABARROTES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8934029', 'TINTORERIA Y PLANCHADURIA', 'TINTORERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '2093011', 'TORTILLERIA', 'TORTILLERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '7113012', 'TRANSPORTE EN AUTOMOVIL DE RULETEO', 'TAXISTA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3212024', 'VULCANIZACION DE LLANTAS Y CAMARAS', 'VULCANIZADORA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '2413011', 'FABRICACION DE UNIFORMES', 'UNIFORMES Y ROPA DE TRABAJO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6512017', 'COMPRAVENTA DE GAS PARA USO DOMESTICO O COMERCIAL', 'C/V DE GAS', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6216031', 'COMPRAVENTA DE TELAS', 'C/V TELAS Y CASIMIRES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6133029', 'COMPRAVENTA DE ALIMENTOS PARA AVES Y OTROS ANIMALES', 'C/V ALIMENTO PARA ANIMALES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6122014', 'COMPRAVENTA DE CARNE DE RES Y OTRAS ESPECIES DE GANADO', 'CARNICERIA', 'MEDIO', 1.045)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO', 'TIENDA DE REGALOS', 'BAJO', 380)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS', 'CREMERIA', 'BAJO', 380)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6231021', 'COMPRAVENTA DE PERFUMES', 'C/V PERFUMES Y COSMETICOS', 'BAJO', 380)



--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_catalogo.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_actividad')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_actividad')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_actividad')
go




declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_actividad', 'ACTIVIDAD')


--Insertando Catalogos
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7512016', 'AGENCIA DE TURISMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6992011', 'C/V DE LOTERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8711013', 'CAFETERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8831019', 'CENTRO NOCTURNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911029', 'C/V DE CASAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6991013', 'C/V DE ARMAS DE FUEGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6622022', 'C/V ART FERRETERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6211015', 'C/V LENCERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6215017', 'MERCERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325030', 'C/V ART PARA REGALO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325048', 'C/V ARTESANIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6811013', 'C/V DE AUTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6812011', 'C/V DE AUTOS USADOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6212013', 'C/V CALZADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6124010', 'POLLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911045', 'C/V DE CASAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6999017', 'C/V DE DIAMANTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6323018', 'C/V DISCOS Y CASSETTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132013', 'C/V DE DULCES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6721036', 'C/V ART DE COMPUTACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6326020', 'FLORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6112015', 'C/V DE FRUTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6223010', 'C/V DE JUGUETES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132039', 'C/V DE LECHE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6112023', 'C/V DE VERDURAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6629010', 'C/V MATERIALES PARA CONSTRUCCIÓN', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231013', 'COMPRAVENTA DE MEDICINAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6312011', 'COMPRAVENTA DE MUEBLES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6225024', 'C/V DE JOYAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6419015', 'C/V APARATOS ELECTRÓNICOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6329016', 'C/V ARTICULOS PARA EL HOGAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6119011', 'VENTA DE PRODUCTOS NATURALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132047', 'C/V DE LACTEOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6216023', 'C/VPRODUCTOS TEXTILES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132055', 'PANADERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6233019', 'PAPELERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231021', 'C/V DE PERFUES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6126032', 'C/V DE PESCADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6623020', 'C/V DE PINTURAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6815015', 'C/V REFACCIONES DE AUTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6134019', 'C/V DE REFRESCOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6225032', 'C/V RELOJES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6211023', 'C/V DE ROPA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6111017', 'C/V DE SEMILLAS Y GRANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911053', 'C/V DE TERRENOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3319010', 'ALFARERIA Y CERAMICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9501009', 'EMPLEADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9502007', 'EMPLEADO GOBIERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8429046', 'TRANSPORTE DE VALORES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3997014', 'FABRICACIÓN DE ARMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3932010', 'FABRICACION ART DE JOYERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3933018', 'C/V BISUTERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3921013', 'FABRICACION REFLOJES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8800002', 'JUEGOS DE FERIA Y APUESTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8934011', 'LAVANDERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2023018', 'MOLINO DE NIXTAMAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8200001', 'CASA DE EMPEÑO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9504003', 'CYBERCAFE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8714017', 'NEVERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8400003', 'NOTARÍAS PÚBLICAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8711021', 'RESTAURANTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8933013', 'SALON DE BELLEZA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6800003', 'BLINDAJE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8411019', 'NOTARÍAS PÚBLICAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8719017', 'C/V DE ANTOJITOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04200002', 'CARPINTERO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3932036', 'PIEDRAS PRECIOSAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3516054', 'HERRERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3591022', 'HOJALATERÍA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4221016', 'PROMERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8921018', 'REPARACIÓN DE CALZADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8929020', 'SASTRE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8911019', 'MECANICO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2412039', 'SASTRE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6131023', 'ABARROTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8934029', 'TINTORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2093011', 'TORTILLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7113012', 'TAXISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3212024', 'VULCANIZADORA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2413011', 'UNIFORMES Y ROPA DE TRABAJO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6512017', 'C/V DE GAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6216031', 'C/V TELAS Y CASIMIRES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6133029', 'C/V ALIMENTO PARA ANIMALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6122014', 'CARNICERIA', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325030', 'TIENDA DE REGALOS', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132047', 'CREMERIA', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231021', 'C/V PERFUMES Y COSMETICOS', 'V')


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_actividad')
go