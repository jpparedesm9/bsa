
/* variables locales de T_FLCRE_13_RPUME79*/

/* variables locales de T_VW_SHCTRATNIW77*/

/* variables locales de T_VW_DOCUNODCVW73*/

(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.reprintdocument;
    

    //"TaskId": "T_FLCRE_13_RPUME79"
var selectedApplication;

task.closeModalEvent.findCustomer = function (args) {
         var resp = args.commons.api.vc.dialogParameters;
		 //args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive ;
         args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive +"-"+resp.name;
         args.model.SearchCriteriaPrintingDocuments.group =   resp.isGroup;
    };

task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {		
        args.commons.execServer = false;		
        var index = args.rowIndex;								
		for (var i = 0; i<=entities.DocumentProduct.data().length; i++)
		{			
			if (i === index)
				entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
		}
};

    	// (Button) 
task.executeCommand.CM_RPUME79PRN97 = function(entities, executeCommandEventArgs) {
    //No se ejecuta en el servidor
    executeCommandEventArgs.commons.execServer = true;
    entities.OriginalHeader = {};
    entities.OriginalHeader.IDRequested = entities.SearchCriteriaPrintingDocuments.codeProcess;
    entities.OriginalHeader.TypeRequest = entities.SearchCriteriaPrintingDocuments.FlowType;
    entities.OriginalHeader.ApplicationNumber = selectedApplication[0].ApplicationCode;
    //validar si imprimo el seguro :basico o extendido
    var executeExtendMedical = task.executeReportMedical(entities);
    var executeBasicReport = executeExtendMedical == true ? false : true;
    var isReportSecurity = false;
    var count = 0;
    //entities.OriginalHeader.IDRequested = 1;
    for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
        if (entities.DocumentProduct.data()[i].YesNot === true) {
            
            if (entities.DocumentProduct.data()[i].Nemonic == 'CERCON'|| entities.DocumentProduct.data()[i].Nemonic == 'CERCONIND') {
                isReportSecurity = true;
                if (executeBasicReport) {
                    //imprimo siempre reprote basico
                    count = count + 1;
                    var report = entities.DocumentProduct.data()[i].Template.split("-")[0];
                    var args = [
                        ['report.module', 'cartera'],
                        ['report.name', report],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(report, args);
                }
                if (executeExtendMedical) { //imprimo reporte extendido 
                    count = count + 1;
                    var reports = entities.DocumentProduct.data()[i].Template.split("-");
                    var args = [
                        ['report.module', 'cartera'],
                        ['report.name', reports[0]],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(reports[0], args);

                    args = [
                        ['report.module', 'cartera'],
                        ['report.name', reports[1]],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(reports[1], args);
                }
            } else if (entities.DocumentProduct.data()[i].Nemonic == 'SOPREREFI' || entities.DocumentProduct.data()[i].Nemonic == 'SOLPREGRU') {
                count = count + 1;

                var clientId = 0;
                var group = 'N';

                if (entities.SearchCriteriaPrintingDocuments.CustomerId != null && entities.SearchCriteriaPrintingDocuments.group != null && entities.SearchCriteriaPrintingDocuments.CustomerId != '' && entities.SearchCriteriaPrintingDocuments.CustomerId != undefined) {
                    var customerId = entities.SearchCriteriaPrintingDocuments.CustomerId;
                    var split = customerId.split('-'); // [ 'codigo', 'nombre' ]
                    clientId = split[0]; // codigo

                    if (entities.SearchCriteriaPrintingDocuments.group) {
                        group = 'S';
                    }
                }
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite', entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic],
                            ['clientID', clientId],
                            ['isGroup', group]];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            } else {
                count = count + 1;
                var args = [
                    ['report.module', 'cartera'],
                    ['report.name', entities.DocumentProduct.data()[i].Template],
                    ['idTramite', entities.OriginalHeader.IDRequested],
                    ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                ];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            }
        }
    }
    //muestro mensaje si no existe un cliente para imprimir reporte basico y extendido 
    //if ((!executeBasicReport && !executeExtendMedical) && isReportSecurity) {
    //    executeCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate("BUSIN.LBL_BUSIN_NOEXISTUG_89480"));
    //}
    if (count === 0) {
        executeCommandEventArgs.commons.execServer = false;
    }
};

/**
 *
 *method for execute report medical
 */
task.executeReportMedical = function(entities) {
    var medicalIsPrint = false;
    if (entities.PrintClientsTeam != undefined && entities.PrintClientsTeam.length > 0) {
        entities.PrintClientsTeam.forEach(function(clientMedical) {
            if(clientMedical.typeSecure != undefined && clientMedical.typeSecure == 'EXTENDIDO'){
                medicalIsPrint = true;
            }
        });
    }
    return medicalIsPrint;
};


/**
 *
 *method for execute report basic
 */
task.executeReportBasic = function(entities) {
    var basicIsPrint = false;
    if (entities.PrintClientsTeam != undefined && entities.PrintClientsTeam.length > 0) {
        entities.PrintClientsTeam.forEach(function(clientMedical) {
            if (clientMedical.typeSecure != undefined && clientMedical.typeSecure == 'BASICO') {
                basicIsPrint = true;
            }
        });
    }
    return basicIsPrint;
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RePrintDocument
    task.initData.VC_RPUME79_RERNO_643 = function (entities, initDataEventArgs){
        var ctrs=['VA_SHCTRATNIW7705_AMTI124'], viewState = initDataEventArgs.commons.api.viewState; 
		BUSIN.API.hide(viewState,ctrs);	
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Official');         
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Selection');         
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'OfficialName');         
		initDataEventArgs.commons.execServer = false;
        
    };

	//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.FlowType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SHCTRATNIW7705_LTYE544 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
		var ctrs=['VA_SHCTRATNIW7705_AMTI124'], viewState = changeEventArgs.commons.api.viewState, nemonicReclamos = entities.Context.Type ;
		if(entities.SearchCriteriaPrintingDocuments.FlowType === nemonicReclamos){
			BUSIN.API.show(viewState,ctrs);
		}else {
			BUSIN.API.hide(viewState,ctrs);
		}
        
    };

	//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_SHCTRATNIW7705_0000829 = function(  entities, executeCommandEventArgs ) {
        // executeCommandEventArgs.commons.execServer = false;
		 executeCommandEventArgs.commons.api.grid.resizeGridColumn('QV_ERPLI1480_97', 'PrincipalDebtor',260);
	//	executeCommandEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Official'); 
		if( (entities.SearchCriteriaPrintingDocuments.CustomerId != null && entities.SearchCriteriaPrintingDocuments.CustomerId != ""  )|| (entities.SearchCriteriaPrintingDocuments.FlowType != null && entities.SearchCriteriaPrintingDocuments.FlowType != ""  )|| (entities.SearchCriteriaPrintingDocuments.IdApplication != null && entities.SearchCriteriaPrintingDocuments.IdApplication != "" )
			|| (entities.SearchCriteriaPrintingDocuments.alternateCode != null && entities.SearchCriteriaPrintingDocuments.alternateCode != ""  )){
			executeCommandEventArgs.commons.execServer = true;
		}else{		
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_YMTNTEREI_83156');
			executeCommandEventArgs.commons.execServer = false;
		}
        executeCommandEventArgs.commons.api.grid.removeAllRows('DocumentProduct');        
    };

	//QueryApplications Entity: Applications
    task.executeQuery.Q_ERPLITON_1480 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters.Applications = true;
    };

	//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.FlowType (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_SHCTRATNIW7705_LTYE544 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        
    };

	//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.CustomerId (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SHCTRATNIW7705_SMID298 = function( textInputButtonEventArgs ) {
        var nav = textInputButtonEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CTMESERCH_53064');	
		nav.customAddress = {
						id: "findCustomer",
						url: "customer/templates/find-customers-tpl.html"
		};
		nav.modalProperties = {
						size: 'lg'
		};
		nav.scripts = [{
						module: cobis.modules.CUSTOMER,
						files: ["/customer/services/find-customers-srv.js",
										//"/customer/services/find-program-srv.js",
										"/customer/controllers/find-customers-ctrl.js"]
		}];
		
		nav.customDialogParameters = {
		};
        
    };

	//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.CustomerId (TextInputButton) View: T_SearchCriteriaApplicationView
    
    task.textInputButtonEventGrid.VA_SHCTRATNIW7705_SMID298 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

	//gridRowSelecting QueryView: GridApplicationsPrint
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelecting.QV_ERPLI1480_97 = function (entities, gridRowSelectingEventArgs) {
    selectedApplication = gridRowSelectingEventArgs.commons.api.grid.getSelectedRows('QV_ERPLI1480_97');
    entities.SearchCriteriaPrintingDocuments.codeProcess=selectedApplication[0].CreditCode;
    entities.SearchCriteriaPrintingDocuments.typeProcess=selectedApplication[0].FlowType;
     gridRowSelectingEventArgs.commons.execServer = true;

};

	//gridRowSelecting QueryView: GridApplicationsPrint
//Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelectingCallback.QV_ERPLI1480_97 = function (entities,gridRowSelectingCallbackEventArgs) {
    var a = 1;
    gridRowSelectingCallbackEventArgs.commons.execServer = false;

};

	//gridCommand (Button) QueryView: GridDocumentProduct
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_QDMNT8051_16_143 = function (entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DocumentProduct = true;
        BUSIN.API.checker(entities, gridExecuteCommandEventArgs);
    };

	//gridCommand (Button) QueryView: GridDocumentProduct
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_QDMNT8051_16_659 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DocumentProduct = true;
        BUSIN.API.checker(entities, gridExecuteCommandEventArgs);
    };

	task.gridInitColumnTemplate.QV_QDMNT8051_16 = function (idColumn) {
    if (idColumn === 'YesNot') {
        return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', \'QV_QDMNT8051_16\')\"/>";
    }
};

	task.gridInitEditColumnTemplate.QV_QDMNT8051_16 = function (idColumn) {
    //no utilizado
};

	//gridRowSelecting QueryView: GridDocumentProduct
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QDMNT8051_16 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };



}));