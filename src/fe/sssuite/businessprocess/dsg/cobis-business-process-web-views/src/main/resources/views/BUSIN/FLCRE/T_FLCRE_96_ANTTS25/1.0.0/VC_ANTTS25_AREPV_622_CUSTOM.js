<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
/* global designerEvents, console */ (function() {
    "use strict";

    // *********** COMENTARIOS DE AYUDA **************
    // Para imprimir mensajes en consola
    // console.log("executeCommand");

    // Para enviar mensaje use
    // eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando
	// comando personalizado');

    // Para evitar que se continue con la validación a nivel de servidor
    // eventArgs.commons.execServer = false;

    var task = designerEvents.api.parameterprinttask;

    // descomentar la siguiente linea para que siempre se ejecute el evento
	// change en todos los controles de cabecera.
    // task.changeWithError.allGroup = true;

    // descomentar la siguiente linea para que siempre se ejecute el evento
	// change en todos los controles de grilla.
    // task.changeWithError.allGrid = true;

    // **********************************************************
    // Eventos para COMANDOS DE TAREA
    // **********************************************************
    // Cancel (Button)
    task.executeCommand.CM_ANTTS25CAC75 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = executeCommandEventArgs.commons.api.navigation;
		nav.closeModal({});
		
    };

    // Continue (Button)
    task.executeCommand.CM_ANTTS25CTU91 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        // Crear entidades temporales
        entities.OriginalHeaderTmp = executeCommandEventArgs.commons.api.parentVc.customDialogParameters.OriginalHeader;
        entities.DocumentProductTmp = executeCommandEventArgs.commons.api.parentVc.customDialogParameters.DocumentProduct;
        
        var nav = executeCommandEventArgs.commons.api.navigation;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };
    
   
    task.executeCommandCallback.CM_ANTTS25CTU91 = function(entities, executeCommandCallbackEventArgs) {
    	
		var parentParameters = executeCommandCallbackEventArgs.commons.api.parentVc.customDialogParameters; 		
		var inst_proc=parentParameters.Task.processInstanceIdentifier;
		
        for (var i = 0; i <= entities.DocumentProductTmp.length - 1; i++) {
			if(entities.DocumentProductTmp[i].YesNot === true) {
				
				var reportName=reportName=entities.DocumentProductTmp[i].Template;
				
				var nameManager = entities.ParameterPrint.nameManager;
				var city = entities.ParameterPrint.city ? entities.ParameterPrint.city : "Quito";
				
				if(FLCRE.CONSTANTS.Report.LoanApplication===entities.DocumentProductTmp[i].Template){					
					var debtorP = null;// FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
					var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstDebtor',44],['cstName','nombreDeudor'],['cstId','123456789'],['cstTrId',entities.OriginalHeaderTmp.IDRequested],['cstAplId',entities.OriginalHeaderTmp.ApplicationNumber],['nameManager',nameManager],['city',city]];
					// var debtors = [];//entities.DebtorGeneral.data();
					// var count = 0;
					/*
					 * for (var j = 0; j < debtors.length; j++) {
					 * if(debtors[j].Role == 'C'){ count = count + 1;
					 * args.push(['cstCodeu'+count, debtors[j].CustomerCode]); } }
					 */						
				}else if(FLCRE.CONSTANTS.Report.PunishmentList===entities.DocumentProductTmp[i].Template){					
					var dueDate=parentParameters.Task.bussinessInformationStringTwo;					
					var args = [['report.module', 'credito'],['report.name', reportName],['type','PDF'],['instProc',inst_proc],['nameManager',nameManager],['city',city]];
				}else{					
					//var args = [['report.module', 'credito'],['report.name', reportName],['idCustomerTwo','0'],['idTramit',entities.OriginalHeaderTmp.IDRequested], ['idCity',city],['reportGuarantor',''],['idProcess',entities.OriginalHeaderTmp.ApplicationNumber], ['nameManager',nameManager],['city',city]];					               
               args = [['numOperation', entities.OriginalHeaderTmp.OpNumberBank.trim()], ['paymentTableHis', "N"]];
				}
				if(reportName!=''){
					BUSIN.REPORT.GenerarReporte(reportName,args);					
				}				
			}
		}		
    
        var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
		var nav = executeCommandCallbackEventArgs.commons.api.navigation;
		executeCommandCallbackEventArgs.commons.execServer = false;
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
		  var parentVc = parentApi.vc;
		  nav.closeModal({entities:entities});
		}
		else{
			nav.closeModal({});
		}	
    };
}());