
/********************************************************************************************************/
/*  Cobiscorp S.A.                                                                       				*/
/*  Proyecto COBIS Web Container                                                         				*/
/*  Nombre del Script               : 3.Insert_Print_Documento.sql                         				*/
/*  Tipo de Script                  : Estructura                                         				*/
/*  Numero de Solicitud/Referencia  :  			                                           				*/
/*  Objetivo                        : Script para insertar registros en la tabla cr_imp_documento       */
/*  Fecha Creación                  : 10-DEC-2019                               		                */
/*  Autor                           : Generado                                    						*/
/*  Modificado                      : JHCH								                        		*/
/********************************************************************************************************/
use cobis
go

declare
  @w_secuencial_act     smallint,
  @segnostabla          smallint


select @segnostabla=id_documento
from cob_credito..cr_imp_documento

update cobis..cl_seqnos set siguiente= @segnostabla
where tabla = 'cr_imp_documento'


--- consultar el siguiente actual
select @w_secuencial_act = siguiente
from   cobis..cl_seqnos
where  tabla = 'cr_imp_documento'

select @w_secuencial_act
------------------------------------------
--  [Reporte 1] Consentimiento de seguros TUIIO Seguro + [Reporte 2]Consentimiento de seguros TUIIO Seguro+medico
------------------------------------------
delete cob_credito..cr_imp_documento  where id_mnemonico='CSTUIIS' and id_toperacion='GRUPAL'

if  not exists(select 1 from cob_credito..cr_imp_documento where id_mnemonico='CERCON' and id_toperacion='GRUPAL')
begin
	select @w_secuencial_act  = @w_secuencial_act  +  1
	INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
    VALUES (@w_secuencial_act, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimiento-SecureConsent', 'P', NULL, NULL)

	select 'Insertando CSTUIIS con operacion GRUPAL' as 'print'
	select  @w_secuencial_act as 'value segnos'
end else begin
    update cob_credito..cr_imp_documento set
	id_template = 'certificadoConsentimiento-SecureConsent'
	where id_mnemonico = 'CERCON'
 
 end
/*------------------------------------------
-- SIN USO 
------------------------------------------ 
 if  not exists(select 1 from cob_credito..cr_imp_documento where id_mnemonico='CSTUIISM' and id_toperacion='GRUPAL')
 begin
	select @w_secuencial_act  = @w_secuencial_act  +  1
	insert cob_credito..cr_imp_documento(id_documento,id_toperacion,id_producto, id_moneda, id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio)
	values(@w_secuencial_act,'GRUPAL','CRE',0,'Consentimiento de seguros TUIIO Seguro + Médico','CSTUIISM','O','SecureConsentMedical','P','','')
	
	select 'Insertando CSTUIISM con operacion GRUPAL' as 'print'
	select  @w_secuencial_act as 'value segnos'
 end
 */

go
