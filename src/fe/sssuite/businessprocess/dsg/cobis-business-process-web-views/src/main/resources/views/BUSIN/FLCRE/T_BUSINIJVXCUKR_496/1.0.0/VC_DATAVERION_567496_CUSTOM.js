/* variables locales de T_BUSINIJVXCUKR_496*/
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

    
        var task = designerEvents.api.dataverificationquestions;
    

    //"TaskId": "T_BUSINIJVXCUKR_496"

    //Entity: QuestionsPartThree
    //QuestionsPartThree.enableView (TextInputBox) View: DataVerificationQuestions
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ENABLEVIEWUEGPD_225108 = function(  entities, changedEventArgs ) {
		changedEventArgs.commons.execServer = false;
		var viewState = changedEventArgs.commons.api.viewState;
		var grid = changedEventArgs.commons.api.grid;
		grid.disabledColumn('QV_5932_10558','answer');
		grid.disabledColumn('QV_7780_54457','answer');
		var ctrs = ['VC_DATAVERION_567496']
		BUSIN.API.disable(viewState, ctrs);        
    };

//Entity: QuestionsPartThree
    //QuestionsPartThree.result (TextInputBox) View: DataVerificationQuestions
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXRZX_100108 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: QuestionsPartThree
    //QuestionsPartThree. (Button) View: DataVerificationQuestions
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONWHZLTCH_588108 = function(  entities, executeCommandEventArgs ) {    
    executeCommandEventArgs.commons.execServer = true;

    //executeCommandEventArgs.commons.serverParameters.QuestionsPartThree = true;
};

//Entity: QuestionsPartThree
    //QuestionsPartThree. (Button) View: DataVerificationQuestions
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONWHZLTCH_588108 = function(  entities, executeCommandEventArgs ) {
		executeCommandEventArgs.commons.execServer = false;
		executeCommandEventArgs.commons.api.vc.rowData.answer = entities.QuestionsPartThree.result;        
    };

//QuestionsPartOneQuery Entity: 
    task.executeQuery.Q_QUESTINO_5932 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//QuestionsPartTwoQuery Entity: 
    task.executeQuery.Q_QUESTIRO_7780 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestions
task.initData.VC_DATAVERION_567496 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    //initDataEventArgs.commons.serverParameters.entityName = true;

    var idMember=initDataEventArgs.commons.api.parentVc.customDialogParameters.idMember;
    var idTramite=initDataEventArgs.commons.api.parentVc.customDialogParameters.idTramite;
    var productType=initDataEventArgs.commons.api.parentVc.customDialogParameters.productType;
	var applicationSubject= initDataEventArgs.commons.api.parentVc.customDialogParameters.applicationSubject;
	var enable = initDataEventArgs.commons.api.parentVc.customDialogParameters.enable;
    entities.Context.CustomerId=idMember;
    entities.Context.RequestId=idTramite;
    entities.Context.Type = productType;
	entities.Context.ApplicationSubject = applicationSubject;
	entities.Context.enable = enable;

};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestions
    task.initDataCallback.VC_DATAVERION_567496 = function (entities, initDataEventArgs){
		var viewState = initDataEventArgs.commons.api.viewState;
		var grid = initDataEventArgs.commons.api.grid;
		if(entities.Context.enable === 'N'){
			grid.disabledColumn('QV_5932_10558','answer');
			grid.disabledColumn('QV_7780_54457','answer');
			var ctrs = ['VC_DATAVERION_567496']
			BUSIN.API.disable(viewState, ctrs);
		}	        
    };



}));