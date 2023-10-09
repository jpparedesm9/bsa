/********************************************************************************************************/
/*  Cobiscorp S.A.                                                                       				*/
/*  Proyecto COBIS Web Container                                                         				*/
/*  Nombre del Script               : 3.Insert_Print_Documento.sql                         				*/
/*  Tipo de Script                  : Estructura                                         				*/
/*  Numero de Solicitud/Referencia  :  			                                           				*/
/*  Objetivo                        : Script para rollback la tabla cr_imp_documento      				*/
/*  Fecha Creación                  : 10-DEC-2019                               		                */
/*  Autor                           : Generado                                    						*/
/*  Modificado                      : JHCH								                        		*/
/********************************************************************************************************/
use cobis
go

-------------
--  [Reporte 1] Consentimiento de seguros TUIIO Seguro + [Reporte 2]Consentimiento de seguros TUIIO Seguro+medico
------------------------------------------

if  exists(select 1 from cob_credito..cr_imp_documento where id_mnemonico='CSTUIIS' and id_toperacion='GRUPAL')
 begin
	delete from cob_credito..cr_imp_documento where id_mnemonico='CSTUIIS' and id_toperacion='GRUPAL'
 end

 
 
 
 
 
 
 
 
 
 
 
 