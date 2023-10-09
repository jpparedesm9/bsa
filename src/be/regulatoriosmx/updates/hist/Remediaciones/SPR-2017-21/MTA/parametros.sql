/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 18/10/2017
--Descripción del Problema   : Agregar parametros a la pantalla de Prospectos
--Descripción de la Solución : Agregar parametros a la pantalla de Prospectos
--Autor                      : MARIA JOSE TACO
--SQL                        : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_parametros.sql
/**********************************************************************************************************************/

use cobis
go

--PARAMETRO RECUPERADO DE SSS DE FECHA DE EXPIRACION PARA PANTALLA DE MANTENIMIENTO DE PERSONAS
delete from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('FVDI') AND pa_producto ='CLI'
go
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA DE VENCIMIENTO DE DOCUMENTO DE IDENTIDAD', 'FVDI', 'D', NULL, NULL, NULL, NULL, NULL, '2100-12-31', NULL, 'CLI')
GO
--PARAMETRO RECUPERADO DE SSS DE EDAD MINIMO DEL CLIENTE PARA PANTALLA DE MANTENIMIENTO DE PERSONAS
delete from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('EMRCLI') AND pa_producto ='CLI'
go
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EDAD MINIMA PARA EL REGISTRO DE UN CLIENTE', 'EMRCLI', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CLI')
GO



--PARAMETRO TIPO DE DIRECCION DOMICILIO O RESIDENCIA
delete from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('TDRE') AND pa_producto ='CLI'
go
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE DIRECCION DOMICILIO', 'TDRE', 'C', 'RE', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
GO

--PARAMETRO TIPO DE DIRECCION PARA EL NEGOCIO
delete from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('TDNE')AND pa_producto ='CLI'
go
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE DIRECCION PARA EL NEGOCIO', 'TDNE', 'C', 'AE', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
GO

----------------------------------
--SCRIPT PARA ELIMINAR PANTALLAS
----------------------------------
DECLARE @w_num int
SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_BUSINESS'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_BUSINESS'

SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_REFERENCES'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_REFERENCES'

SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_ADDRESS'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_ADDRESS'

SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_LEGAL_PERSON'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_LEGAL_PERSON'

SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_RLATION_CUSTOMER'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_RLATION_CUSTOMER'

SELECT @w_num = me_id FROM cew_menu where me_name = 'MNU_CUSTOMER_ADM'
delete cew_menu_role WHERE mro_id_menu=@w_num
delete cew_menu where me_name = 'MNU_CUSTOMER_ADM'

go


