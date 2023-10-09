/* variables locales de T_LOANSYBASRMCC_810*/
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

    
        var task = designerEvents.api.simulationcreditrenovations;
    

    //"TaskId": "T_LOANSYBASRMCC_810"


    //Entity: FilterSimulation
    //FilterSimulation.amountRequest (TextInputBox) View: SimulationCreditRenovations
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AMOUNTREQUESTTT_231753 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        
    };

//Entity: FilterSimulation
    //FilterSimulation.nameClient (TextInputBox) View: SimulationCreditRenovations
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_NAMECLIENTMUUTS_510753 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        
    };

//Entity: FilterSimulation
    //FilterSimulation.term (ComboBox) View: SimulationCreditRenovations
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TERMFQAXXSBCLOQ_177753 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        
    };

// (Button)
task.executeCommand.CM_TLOANSYB_04A = function (entities, executeCommandEventArgs) {
	executeCommandEventArgs.commons.execServer = false;

  let nameRemplaceSpace = entities.FilterSimulation.nameClient.replace(/ /g,"")

	var args = [
		["report.module", "cartera"],
		["report.name", "tablaSimulacion"],
		["nameRequested", nameRemplaceSpace],
		["termRequested", entities.FilterSimulation.term],
		["amountRequested", entities.FilterSimulation.amountRequest],
	];
	LATFO.UTILS.generarReporte(null, args);
};

// (Button) 
    task.executeCommand.CM_TLOANSYB_148 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;

        entities.FilterSimulation = null;
        executeCommandEventArgs.commons.api.grid.removeAllRows("InformationSimulation")
        
    };

//undefined Entity:  
    task.executeQuery.Q_INATIOOM_2798 = function(executeQueryEventArgs){ 
         executeQueryEventArgs.commons.execServer = true; 
         executeQueryEventArgs.commons.serverParameters.FilterSimulation = true; 
    };;

//Start signature to Callback event to Q_INATIOOM_2798
task.executeQueryCallback.Q_INATIOOM_2798 = function(entities, executeQueryCallbackEventArgs) {
//here your code
   executeQueryCallbackEventArgs.commons.api.viewState.enable('CM_TLOANSYB_04A');
   executeQueryCallbackEventArgs.commons.api.viewState.enable('CM_TLOANSYB_148');
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: SimulationCreditRenovations
    task.initData.VC_SIMULATIEE_163810 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        initDataEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        initDataEventArgs.commons.api.viewState.disable('CM_TLOANSYB_148');
        
    };



}));