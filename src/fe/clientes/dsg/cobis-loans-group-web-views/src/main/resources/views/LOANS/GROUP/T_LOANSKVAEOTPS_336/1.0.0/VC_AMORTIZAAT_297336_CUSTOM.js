/* variables locales de T_LOANSKVAEOTPS_336*/
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

    
        var task = designerEvents.api.amortizationtable;
    

    //"TaskId": "T_LOANSKVAEOTPS_336"
task.showHeaderGrid = function (entities, renderEventArgs) {
            renderEventArgs.commons.execServer = false;
            var itemsNumber = entities.Item.length;
            var indexEndColumn = 14;
            var i;
            for (i = 1; i < itemsNumber; i++) {
                renderEventArgs.commons.api.grid.title("QV_6763_19315", "item" + i, entities.Item[i].concept, null, null);
            }
            for (i = itemsNumber ; i < indexEndColumn; i++) {
                renderEventArgs.commons.api.grid.hideColumn("QV_6763_19315",
                        "item" + i);
            }
        }

    //undefined Entity: 
    task.executeQuery.Q_AMORTIOZ_6763 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Start signature to Callback event to Q_AMORTIOZ_6763
task.executeQueryCallback.Q_AMORTIOZ_6763 = function(entities, executeQueryCallbackEventArgs) {
//here your code
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: AmortizationTable
    task.initData.VC_AMORTIZAAT_297336 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
		entities.Amount.oldOperation=initDataEventArgs.commons.api.navigation.getCustomDialogParameters().operation;
        initDataEventArgs.commons.api.vc.model.Item = {};
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to VC_AMORTIZAAT_297336
task.initDataCallback.VC_AMORTIZAAT_297336 = function(entities, initDataCallbackEventArgs) {
   task.showHeaderGrid(entities,initDataCallbackEventArgs);
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: AmortizationTable
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
    };



}));