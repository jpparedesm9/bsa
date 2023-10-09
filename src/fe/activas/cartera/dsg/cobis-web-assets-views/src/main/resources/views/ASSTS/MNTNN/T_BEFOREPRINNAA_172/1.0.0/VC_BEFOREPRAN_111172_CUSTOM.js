/* variables locales de T_BEFOREPRINNAA_172*/
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

    
        var task = designerEvents.api.beforeprintpaymentform;
    

    //"TaskId": "T_BEFOREPRINNAA_172"

	var secuentialIng;

    // (Button) 
task.executeCommand.CM_TBEFOREP_5TF = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    if (entities.PrintingPaymentInfo.data().length == 0){
        var dataGrid = {sequential: '0', beforeButton: false}    
    }
    else{
        var dataGrid = {sequential: secuentialIng, beforeButton: true}    
    }
    executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);        
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BeforePrintPaymentForm
    task.initData.VC_BEFOREPRAN_111172 = function (entities, initDataEventArgs){
		initDataEventArgs.commons.execServer = true;
		var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.loanInstancia;
		commons.execServer = true;        
    };

//gridRowSelecting QueryView: QV_5858_58779
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5858_58779 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        secuentialIng=gridRowSelectingEventArgs.rowData.secuentialIng;	

    };



}));