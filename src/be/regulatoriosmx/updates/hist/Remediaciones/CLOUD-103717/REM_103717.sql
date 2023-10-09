/**********************************************************************************************************************/
/*No Bug                     :                                                                                        */
/*Título de la Historia      : REQ 101026 – ANULACIÓN DE PAGOS                                                        */
/*Fecha                      : 31/08/2018                                                                             */
/*Descripción del Problema   : Modificación cálculo IVA                                                               */
/*Descripción de la Solución : update/insert parametro reporte ESTCTA                                                 */
/*Autor                      : Sonia Rojas                                                                            */
/**********************************************************************************************************************/


use cob_conta
GO

if not exists (select 1 from cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'ESTCTA')
begin
   INSERT INTO cb_solicitud_reportes_reg (sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status)
   VALUES ('09/25/2019', 'ESTCTA', 9, 2019, 'P')

end
else
begin

   update cob_conta..cb_solicitud_reportes_reg
   set sr_status = 'I',
       sr_anio = 2019,
       sr_mes = 9
   where sr_reporte = 'ESTCTA'
end

go
