/************************************************************************/
/*   Archivo:              sp_sync_device.sp                            */
/*   Stored procedure:     sp_sync_device.sp                            */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         SMO                                          */
/*   Fecha de escritura:   22/12/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   El programa sincroniza clientes grupos solcitudes y cuestionarios  */
/*   al dispositivo de un oficial									    */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      22/12/2017     SMO              Emision Inicial                 */
/*      23/12/2019     SRO              Modificación Colectivos         */
/*      13/06/2023     ACH              209581-Ajustes nueva prospecciOn*/
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_sync_device')
drop proc sp_sync_device
go

CREATE proc sp_sync_device (
    @s_user		login = null,
    @i_oficial 	INT
)
AS

declare @w_login varchar(20)

select @w_login = fu_login
from cobis..cl_funcionario, cobis..cc_oficial
where oc_funcionario = fu_funcionario
and oc_oficial = @i_oficial

--dejar como sincronizados los registros que estaban como pendientes
update cob_sincroniza..si_sincroniza_det
set sid_descargado = 1
where sid_secuencial in (
  select si_secuencial
  from cob_sincroniza..si_sincroniza
  where si_usuario = @w_login
  and si_estado in ('P')
)

update cob_sincroniza..si_sincroniza
set si_estado = 'S'
where si_usuario = @w_login
and si_estado in ('P')

--dejar como eliminados los registros que estaban en proceso de descarga
update cob_sincroniza..si_sincroniza_det
set sid_descargado = 1
where sid_secuencial in (
  select si_secuencial
  from cob_sincroniza..si_sincroniza
  where si_usuario = @w_login
  and si_estado in ('D')
)

update cob_sincroniza..si_sincroniza
set si_estado = 'E'
where si_usuario = @w_login
and si_estado in ('D')

--sincronizar clientes
EXEC cob_sincroniza..sp_sinc_arch_xml
@i_param1 ='Q',
@i_param2=0,
@i_param3=5,
@i_oficial=@i_oficial

--sincronizar grupos
EXEC cobis..sp_xml_grupos
@i_oficial=@i_oficial,
@s_user=@s_user,
@i_operacion = 'F'

--sincronizar solicitudes
EXEC cob_credito..sp_sync_cuestionarios
@i_oficial       = @i_oficial

--sincronizar cuestionarios
EXEC cob_credito..sp_sync_solicitudes
@i_oficial       = @i_oficial


--sincronizar etapa documentos lcr
EXEC cob_credito..sp_sync_document_lcr 
@i_oficial      = @i_oficial

--sincronizar etapa documentos colectivos
EXEC cob_credito..sp_sync_document_col
@i_oficial      = @i_oficial

--Sincroniza cuestionarios Verificar Datos (Individual y Revolvente)
EXEC cob_credito..sp_sync_verificar_datos
@i_oficial      = @i_oficial

GO
