/*************************************************************************/
/*   Archivo:              REM_161141_wf_variable_proceso.sql            */
/*   Stored procedure:     REM_161141_wf_variable_proceso.sql            */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         wcg                                           */
/*   Fecha de escritura:   Agosto 2021                                	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   	Script para la creacion de registro en wf_variable_proceso       */
/*      para el caso #161141                                             */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Agosto/2021         Wismark Castro        Emision inicial       */
/*                                                                       */
/*************************************************************************/
use cob_workflow
go

declare 
@w_id_variable     smallint,
@w_id_programa     int,
@w_codigo_proceso  int,
@w_version_proceso int

SELECT @w_id_variable = vb_codigo_variable,
@w_id_programa = vb_id_programa FROM cob_workflow..wf_variable 
WHERE vb_abrev_variable = 'MNCRE'


select @w_codigo_proceso = pr_codigo_proceso from cob_workflow..wf_proceso 
where  pr_nombre_proceso = 'SOLICITUD DE CREDITO INDIVIDUAL REVOLVENTE'

select @w_version_proceso = vp_version_proceso from cob_workflow..wf_version_proceso 
where vp_codigo_proceso = @w_codigo_proceso
and vp_estado = 'PRD'

DELETE cob_workflow..wf_variable_proceso WHERE vr_codigo_variable= @w_id_variable

INSERT INTO cob_workflow..wf_variable_proceso (vr_codigo_variable, vr_codigo_proceso, vr_version_proceso, vr_id_programa, vr_valor_inicial, vr_guardar_log)
VALUES (@w_id_variable, @w_codigo_proceso, @w_version_proceso, @w_id_programa, '0', 1)
GO
