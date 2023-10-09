
    /************************************************************/
    /*******************Service Operations Script*********************/
    /************************************************************/
    /*   This code was generated by CEN-SG.                     */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/

    use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportZurich.ReportZurichInformation')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportZurich', csc_method_name = 'reportZurichInformation', csc_description = '', csc_trn = 775100 WHERE csc_service_id = 'Sales.Cloud.ConsultingReportZurich.ReportZurichInformation'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportZurich', 'reportZurichInformation', '', 775100)
      GO
    
      IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Sales.Cloud.ConsultingReportZurich.ReportZurichInformation')
      begin
        DELETE ad_servicio_autorizado WHERE ts_servicio = 'Sales.Cloud.ConsultingReportZurich.ReportZurichInformation'
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',10,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',12,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',16,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',29,7,'R',0,getdate(),'V',getdate())
      end
      ELSE
      begin
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',10,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',12,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',16,7,'R',0,getdate(),'V',getdate())
        INSERT INTO ad_servicio_autorizado values ('Sales.Cloud.ConsultingReportZurich.ReportZurichInformation',29,7,'R',0,getdate(),'V',getdate())
      end
      GO