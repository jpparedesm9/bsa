
/* variables locales de T_FLCRE_68_ITCII49*/

/* variables locales de T_VW_WTTTEPRCES08*/

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

    
        var task = designerEvents.api.printingactivity;
    

        //"TaskId": "T_FLCRE_68_ITCII49"
    var taskHeader = {};
    var parameterPrint = null;

    task.showButtons = function (args) {
        var api = args.commons.api;
        var parentParameters = args.commons.api.parentVc.customDialogParameters;
        //Boton Principal (Wizard)
        //initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
        //	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
        //}

        //Boton Secundario 1 (Wizard)
        //(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
        //(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
        //(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
        //(Tiene una limitacion de 5 axecute commands)

        if (parentParameters.Task.urlParams.Modo != undefined && parentParameters.Task.urlParams.Modo != null && parentParameters.Task.urlParams.Modo == FLCRE.CONSTANTS.Mode.Query) {
            args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        } else {
            args.commons.api.vc.parentVc.labelExecuteCommand1 = "Imprimir";
            args.commons.api.vc.parentVc.executeCommand1 = function () {
                args.commons.api.vc.executeCommand('CM_ITCII49ITT66', 'PrintOut', undefined, false, false, 'VC_ITCII49_TNYFM_899', false);
            }
        }
    };

    task.loadTaskHeader = function (entities, eventArgs) {

        var client = eventArgs.commons.api.parentVc.model.Task;
        var originalh = entities.OriginalHeader;
        entities.OriginalHeader.CurrencyRequested = 2;
        var customDialogParameters = eventArgs.commons.api.vc.parentVc.customDialogParameters;
		var typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;

        //Titulo de la cabecera (title)
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

        //Subtitulos de la cabecera		
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == 'null' ? '--' : originalh.IDRequested), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
        if(typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE)
		 {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', originalh.Term, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.generalData.paymentFrecuencyName, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
         }
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((originalh.OfficerName != null) ? originalh.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
        if(typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE)
		 {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
         }
        LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);

        //Actualizo el grupo de designer
        LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
    };

    //si todos los documentos tienen mÃ¡s de una impresiÃ³n pueden pasar
    task.validatePrints = function (entities, args) {
        var nextStep = true;
        var documents = entities.DocumentProduct.data();
        for (var i = 0; i < documents.length; i++) {
            if (parseInt(documents[i].NroImpressions) == 0) {
                nextStep = false;
                break;
            }
        }
        if (nextStep) {
            //permite continuar sin dar click en imprimir
            var parentApi = args.commons.api.parentApi();
            parentApi.vc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
    };

    //QueryView: GridDocumentProduct - Actualiza el Valor de la Entidad.
    // Funcion llamada al dar click en yes/not gracias al template creado en VA_DOCUNODCVW7303_YSNO533
    task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {
        args.commons.execServer = false;
        var index = args.rowIndex;
        for (var i = 0; i <= entities.DocumentProduct.data().length; i++) {
            if (i === index)
                entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
        }
        BUSIN.API.changeImageChecker(entities, args);
    };


    // REcupero los asltos
    task.closeModalEvent.VC_ANTTS25_AREPV_622 = function (args) {
        var parentApi = args.commons.api.parentApi();
        var parentVc = parentApi.vc;
        // Recupero el resultado
        var result = args.result;
        parameterPrint = {};
        parameterPrint.nameManager = result.nameManager;
        parameterPrint.city = result.city;

        if (args.result.entities != null && args.result.entities != undefined && args.result.entities != '') {
            var documents, documentTemp;
            documents = args.model.DocumentProduct.data();
            documentTemp = args.result.entities.DocumentProductTmp;
            for (var j = 0; j < documents.length; j++) {
                for (var i = 0; i < documentTemp.length; i++) {
                    if (documentTemp[i].Document != null && documents[j].Document == documentTemp[i].Document) {
                        // se replica la data faltante para enviar la entidad nueva
                        documentTemp[i].YesNot = documents[j].YesNot;

                        if (parentApi != undefined && documentTemp[i].YesNot == true) {
                            parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
                        }

                        console.log("documentProduct.NroImpressions->" + documents[j].NroImpressions + " documentProdTemp.NroImpressions->" + documentTemp[i].NroImpressions);
                        args.commons.api.grid.updateRow('DocumentProduct', j, documentTemp[i], false);
                    }
                }
            }
        }
    };


    	// (Button) 
task.executeCommand.CM_ITCII49ITT66 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    var executeExtendMedical=task.executeReportMedical(entities);
    var executeBasicReport = executeExtendMedical == true ? false : true;
    var isReportSecurity=false;
    var count = 0;
        for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
            if(entities.DocumentProduct.data()[i].YesNot === true){
                
                if(entities.DocumentProduct.data()[i].Nemonic=='CERCON' || entities.DocumentProduct.data()[i].Nemonic=='CERCONIND'){
                isReportSecurity=true;
                 if(executeBasicReport){
                     count = count + 1;
                    //imprimo siempre reprote basico
                    var report=entities.DocumentProduct.data()[i].Template.split("-")[0];
                    var args = 
                        [['report.module', 'cartera'],
                         ['report.name', report],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];	                
                    BUSIN.REPORT.GenerarReporte(report,args);	
                }
                if(executeExtendMedical){//imprimo reporte extendido 
                    count = count + 1;
                    var reports=entities.DocumentProduct.data()[i].Template.split("-");
                    var args = 
                        [['report.module', 'cartera'],
                         ['report.name', reports[0]],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];		                    
                    BUSIN.REPORT.GenerarReporte(reports[0],args);	
                    
                    args = 
                        [['report.module', 'cartera'],
                         ['report.name', reports[1]],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];	
                    BUSIN.REPORT.GenerarReporte(reports[1],args);	
                }
               
            } else if (entities.DocumentProduct.data()[i].Nemonic == 'SOPREREFI' || entities.DocumentProduct.data()[i].Nemonic == 'SOLPREGRU') {
                count = count + 1;
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite', entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic],
                            ['clientID', entities.DebtorGeneral.org_1.CustomerCode],
                            ['isGroup', 'S']];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            }else{
                count = count + 1;
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite',entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];		 
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template,args);	
            }


        }

    }
    //muestro mensaje si no existe un cliente para imprimir reporte basico y extendido 
    //if((!executeBasicReport && !executeExtendMedical) && isReportSecurity){
    //    executeCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate("BUSIN.LBL_BUSIN_NOEXISTUG_89480"));
    //    executeCommandEventArgs.commons.execServer = false;
    //}    

    if (count === 0) {
        executeCommandEventArgs.commons.execServer = false;
    }
    
};
/**
*
*method for execute report medical
*/
task.executeReportMedical=function(entities){
    var medicalIsPrint=false;
    if(entities.PrintClientsTeam!=undefined && entities.PrintClientsTeam.length>0){
        entities.PrintClientsTeam.forEach(function(clientMedical){
            if(clientMedical.typeSecure!=undefined && clientMedical.typeSecure=='EXTENDIDO'){
                medicalIsPrint=true;
            }
        });
    }
    return medicalIsPrint;
};

/**
*
*method for execute report basic
*/
task.executeReportBasic=function(entities){
    var basicIsPrint=false;
    if(entities.PrintClientsTeam!=undefined && entities.PrintClientsTeam.length>0){
        entities.PrintClientsTeam.forEach(function(clientMedical){
            if(clientMedical.typeSecure!=undefined && clientMedical.typeSecure=='BASICO'){
                basicIsPrint=true;
            }
        });
    }
    return basicIsPrint;
};

		// (Button) 
	task.executeCommandCallback.CM_ITCII49ITT66 = function (entities, executeCommandCallbackEventArgs) {
	    executeCommandCallbackEventArgs.commons.execServer = false;
        task.validatePrints(entities, executeCommandCallbackEventArgs);
	};


	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PrintingActivity
    task.initData.VC_ITCII49_TNYFM_899 = function (entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        if (parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined) {
            task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
        }
        if (parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined) {
            task.Etapa = parentParameters.Task.urlParams.ETAPA;
        }
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;

        var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.Office = office;
        entities.OriginalHeader.NumberLine = initDataEventArgs.commons.api.parentVc.model.Task.bussinessInformationStringOne;
        entities.generalData = {}; //entidad a mano -> para informacion
        entities.generalData.productTypeName = "";
        entities.generalData.paymentFrecuencyName = "";
        entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
        if (parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.NoHeader) { //en el caso que venga generico
            entities.generalData.Mode = "NH";
        } else {
            entities.generalData.Mode = "";
        }
        initDataEventArgs.commons.execServer = true;
    };

	    //Start signature to callBack event to VC_ITCII49_TNYFM_899
    task.initDataCallback.VC_ITCII49_TNYFM_899 = function (entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        if (parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.NoHeader) { //en el caso que venga generico

        } else {
            task.loadTaskHeader(entities, initDataEventArgs);
        }
        task.validatePrints(entities, initDataEventArgs);
    };


	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PrintingActivity
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.showButtons(renderEventArgs)
        BUSIN.API.changeImageChecker(entities, renderEventArgs);
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