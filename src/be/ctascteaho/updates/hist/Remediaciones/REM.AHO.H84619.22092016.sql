/*************************************************************************************/
--No Historia				 : H84619
--Título de la Historia		 : Paso de datos a cob_conta_super
--Fecha					     : 09/22/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de equivalencias de catalogos
--Autor						 : Jorge Salazar Andrade
--Instalador                 : validacion_equivalencias.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/ParamMX/sql
/*************************************************************************************/

use cob_conta_super
go

delete sb_equivalencias 
 where eq_catalogo  = 'TIPRODUCTO'
   and eq_valor_cat = 'DPF'
go

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TIPRODUCTO', 'DPF', '14', 'DEPOSITOS A PLAZO FIJO', 'V')
go


/*************************************************************************************/
--No Historia				 : H84619
--Título de la Historia		 : Paso de datos a cob_conta_super
--Fecha					     : 09/22/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de parametro CIUN: CODIGO CIUDAD FERIADOS NACIONALES
--Autor						 : Jorge Salazar Andrade
--Instalador                 : adm_param.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql
/*************************************************************************************/

USE cobis
GO

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CIUN' 
   AND pa_producto = 'ADM'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CIUDAD FERIADOS NACIONALES', 'CIUN', 'I', NULL, NULL, NULL, 9999, NULL, NULL, NULL, 'ADM')
GO

