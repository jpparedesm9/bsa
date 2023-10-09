<!-- Designer Generator v 5.0.0.1519 - release SPR 2015-19 02/10/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.reportcreditapplicationstatus;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.button (Button) View: reportCreditApplicationStatus
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_ERREPIATNA7928_0000878 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
		 var reportParameters, regional, agency, user, status, creditType;
		 regional = entities.ReportFilter.regional?entities.ReportFilter.regional:"";
		 agency = entities.ReportFilter.agency?entities.ReportFilter.agency:"";
		 user = entities.ReportFilter.oficialCredit?entities.ReportFilter.oficialCredit:"";
		 status = entities.ReportFilter.status?entities.ReportFilter.status:"";
		 creditType = entities.ReportFilter.creditType?entities.ReportFilter.creditType:"";
		//reportParameters="report.module=credito&report.name=reportCreditApplicationStatus&report.type=PDF&regional="+regional+
		 //"&agency="+agency+"&user="+user+"&status="+status+"&creditType="+creditType;
		 //cobis.container.tabs.openNewTab("ctsConsole","${contextPath}/cobis/web/reporting/actions/reportingService?"+reportParameters ,"",true);
		 reportParameters = [['report.module','credito'],['report.name','reportCreditApplicationStatus'],['regional',regional],['agency',agency],['user',user],['status',status],['creditType',creditType]];
		 BUSIN.REPORT.GenerarReporte('reportCreditApplicationStatus',reportParameters);
    };

    //Entity: ReportFilter
    //ReportFilter.status (ComboBox) View: reportCreditApplicationStatus
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_ERREPIATNA7928_ESTO635 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
		
    };

    //Entity: ReportFilter
    //ReportFilter.agency (ComboBox) View: reportCreditApplicationStatus
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_ERREPIATNA7928_GENA971 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: ReportFilter
    //ReportFilter.oficialCredit (ComboBox) View: reportCreditApplicationStatus
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_ERREPIATNA7928_ICID114 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

   

    //Entity: ReportFilter
    //ReportFilter.creditType (ComboBox) View: reportCreditApplicationStatus
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_ERREPIATNA7928_RITP149 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: ReportFilter
    //ReportFilter.status (ComboBox) View: reportCreditApplicationStatus
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_ERREPIATNA7928_ESTO635 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
		return [{code:"T", value:"Todos"},{code:"N", value:"En Tramite"},{code:"A", value:"Aprobado"},{code:"Z", value:"Rechazados"}]
    };
	
	

    //Entity: ReportFilter
    //ReportFilter.agency (ComboBox) View: reportCreditApplicationStatus
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_ERREPIATNA7928_GENA971 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //Entity: ReportFilter
    //ReportFilter.oficialCredit (ComboBox) View: reportCreditApplicationStatus
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_ERREPIATNA7928_ICID114 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		// Para enviar solo la entidad que se necesita en el load		
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OriginalHeader = true;
    };

    //Entity: ReportFilter
    //ReportFilter.creditType (ComboBox) View: reportCreditApplicationStatus
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_ERREPIATNA7928_RITP149 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };
	
	//**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: formReportCreditApplicationStatus 
    task.initData.VC_ECSTS94_ORLII_828 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
		entities.OriginalHeader={};
		entities.OriginalHeader.Office = 1;
    };
	
	task.render = function (entities, renderEventArgs) {
		renderEventArgs.commons.execServer = false;		
	};


}());