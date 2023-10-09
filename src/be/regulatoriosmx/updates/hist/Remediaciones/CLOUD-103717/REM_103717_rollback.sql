/**********************************************************************************************************************/
/*No Bug�������������������� :                                                                                        */
/*T�tulo de la Historia����� : REQ 101026 � ANULACI�N DE PAGOS                                                        */
/*Fecha��������������������� : 31/08/2018�                                                                            */
/*Descripci�n del Problema�� : Modificaci�n c�lculo IVA                                                               */
/*Descripci�n de la Soluci�n : update/insert parametro reporte ESTCTA                                                 */
/*Autor��������������������� : Sonia Rojas                                                                            */
/**********************************************************************************************************************/


use cob_conta
GO

if exists (select 1 from cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'ESTCTA')
begin

   update cob_conta..cb_solicitud_reportes_reg
   set sr_status = 'I',
       sr_anio = 2019,
       sr_mes = 9
   where sr_reporte = 'ESTCTA'
end

go
