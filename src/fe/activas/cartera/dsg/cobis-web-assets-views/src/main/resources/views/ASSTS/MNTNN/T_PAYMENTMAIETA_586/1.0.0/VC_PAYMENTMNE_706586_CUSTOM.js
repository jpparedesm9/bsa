/* variables locales de T_PAYMENTMAIETA_586*/
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

    
        var task = designerEvents.api.paymentMaintenance;
    

    //"TaskId": "T_PAYMENTMAIETA_586"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Payment maintenance
    task.initData.VC_PAYMENTMNE_706586 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to callBack event to VC_PAYMENTMNE_706586
    task.initDataCallback.VC_PAYMENTMNE_706586 = function(entities, initDataEventArgs) {
        //here your code
    };

//MethodsRetentionQuery Entity: 
    task.executeQuery.Q_METHODIR_7546 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };


//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: Payment maintenance
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
         onCloseModalEventArgs.commons.execServer = false;
		var isAccept;
		
		
		if (typeof onCloseModalEventArgs.result === "boolean") {
                isAccept = onCloseModalEventArgs.result;
            }
            if (isAccept) {
			
                onCloseModalEventArgs.commons.api.grid.refresh("QV_7546_25470",{param:{}});				
            }
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: Payment maintenance
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
    };

//gridRowDeleting QueryView: QV_7546_25470
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_7546_25470 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Start signature to callBack event to QV_7546_25470
    task.gridRowDeletingCallback.QV_7546_25470 = function(entities, gridRowDeletingEventArgs) {
        //here your code
    };



}));