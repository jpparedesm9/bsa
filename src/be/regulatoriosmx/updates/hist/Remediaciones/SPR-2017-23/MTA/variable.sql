/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Solicitud Grupal
--Fecha                      : 17/11/2017
--Descripción del Problema   : Se agrega el registro de una variable que no está registrada al workflow 
--Descripción de la Solución : Generar el script para registrar la variable
--Autor                      : Ma. Jose Taco
/**********************************************************************************************************************/

use cob_workflow
go

DECLARE @w_codigo INT
SELECT @w_codigo = max(vb_codigo_variable) +1 FROM cob_workflow..wf_variable

if not exists (select 1 from cob_workflow..wf_variable where vb_abrev_variable     = 'CLINROCLIN')
begin

   INSERT INTO wf_variable (vb_codigo_variable, vb_nombre_variable, vb_abrev_variable, vb_desc_variable, vb_tipo_datos, vb_val_variable, vb_id_programa, vb_type, vb_subType, vb_catalogo, vb_expresion_validacion, vb_seudo_catalogo, vb_value_min, vb_value_operator, vb_value_max)
   VALUES (@w_codigo, 'Cliente Nro Ciclo Individual', 'CLINROCLIN', 'Cliente Número Ciclo Individual', 'INT', '0', NULL, 'CRE', 'ORI', '', NULL, NULL, NULL, '0', NULL)
end

GO