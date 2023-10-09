/* variables locales de T_MBILEHJPNKLMQ_522*/
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

    
        var task = designerEvents.api.terminalmanagementform;
    

    //"TaskId": "T_MBILEHJPNKLMQ_522"


    //Entity: TerminalFiltro
    //TerminalFiltro.filterName (ComboBox) View: TerminalManagementForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_FILTERNAMECVENW_287748 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        var item = changedEventArgs.commons.api.vc.catalogs.VA_FILTERNAMECVENW_287748.data()
            .filter(function(i){ return i.code === changedEventArgs.newValue })[0];
                
        
        changedEventArgs.commons.api.viewState.label("VA_FILTERVALUEKKSF_591748", item.value);
        
    };

//undefined Entity: 
    task.executeQuery.Q_TERMINLA_5241 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
         executeQueryEventArgs.commons.serverParameters.Terminal = true;
    };

//Start signature to Callback event to Q_TERMINLA_5241
task.executeQueryCallback.Q_TERMINLA_5241 = function(entities, executeQueryCallbackEventArgs) {
//here your code
};

task.gridInitColumnTemplate.QV_5241_65721 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'mac'){
          return  "<div>"+
                       "{{dataItem.mac.toLowerCase()}}"+ 
                        "<a href='/CTSProxy/services/resources/cobis-cloud/device/licence/manager/{{dataItem.mac.toLowerCase()}}' style='float:right;'>"+
                        "<span class='fa fa-download' aria-hidden='true'></span><a>"+
                    "</div>";
        }
    
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
    
};

task.gridInitEditColumnTemplate.QV_5241_65721 = function (idColumn, gridInitColumnTemplateEventArgs) {
    
         if(idColumn === 'mac'){
          return  "<div>"+
                       "<input style='text-transform:lowercase' data-bind='value:mac'/>"+                        
                    "</div>";
        }
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//gridRowDeleting QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_5241_65721 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            gridRowDeletingEventArgs.commons.serverParameters.Terminal = true;
        };

//Start signature to Callback event to QV_5241_65721
task.gridRowDeletingCallback.QV_5241_65721 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

//gridRowInserting QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_5241_65721 = function (entities,gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = true;
            gridRowInsertingEventArgs.commons.serverParameters.Terminal = true;
        };

//Start signature to Callback event to QV_5241_65721
task.gridRowInsertingCallback.QV_5241_65721 = function(entities, gridRowInsertingCallbackEventArgs) {
//here your code
};

//gridRowUpdating QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5241_65721 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            gridRowUpdatingEventArgs.commons.serverParameters.Terminal = true;
        };

//Start signature to Callback event to QV_5241_65721
task.gridRowUpdatingCallback.QV_5241_65721 = function(entities, gridRowUpdatingCallbackEventArgs) {
//here your code
};



}));