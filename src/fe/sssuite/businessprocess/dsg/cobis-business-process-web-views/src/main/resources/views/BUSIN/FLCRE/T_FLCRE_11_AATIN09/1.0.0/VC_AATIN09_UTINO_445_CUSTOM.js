<!-- Designer Generator v 5.0.0.1506 - release SPR 2015-06 02/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskconsultationaccounts;
	var accountParameters;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.Boton siguiente (Button) View: ConsultationAccountsView 
    task.executeCommand.VA_COSIONUTIW1006_0000318 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //ChooseButton (Button) 
    task.executeCommand.CM_AATIN09SBN39 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = false;
		var result = {parameterAccount: accountParameters }
		executeCommandEventArgs.commons.api.vc.closeModal(result);
    };

    //**********************************************************
    //  Eventos de QUERY
    //**********************************************************    
    //QueryConsultationAccounts  Entity: ConsultationAccounts 
    task.executeQuery.Q_QUEYCNTA_0398 = function(executeQueryEventArgs) {
        //executeQueryEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //AccountSelecting QueryView: GridConsultationAccounts 
    task.gridRowSelecting.QV_QUEYC0398_15 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		accountParameters = gridRowSelectingEventArgs.rowData;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormConsultationAccounts 
    task.initData.VC_AATIN09_UTINO_445 = function(entities, initDataEventArgs) {
		//var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var parentParameters = initDataEventArgs.commons.api.parentVc.model.DisbursementIncome;
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE); 
        
		//setear cliente del inbox
		entities.CustomerEntity.CustomerId = parentParameters.ClientID;
		entities.CustomerEntity.Subsidiary = office.code;
		
		initDataEventArgs.commons.execServer = true;
		
    };

}());