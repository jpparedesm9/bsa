/* variables locales de T_VALUERATESFBO_932*/
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

    
        var task = designerEvents.api.valuerates;
    

    //"TaskId": "T_VALUERATESFBO_932"

    //Entity: ServerParameter
    //ServerParameter.flag (CheckBox) View: ValueRates
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_FLAGOBWXTOSONWQ_358476 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };

//Entity: ServerParameter
    //ServerParameter.refresGrid2Flag (CheckBox) View: ValueRates
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRID2FLGA_953476 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };

//Entity: ServerParameter
    //ServerParameter.refresGridFlag (CheckBox) View: ValueRates
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRIDFLGAA_521476 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ValueRates
    task.initData.VC_VALUERATEE_334932 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: ValueRates
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
         onCloseModalEventArgs.commons.execServer = false;
        var isAccept;
        
        if (onCloseModalEventArgs.closedViewContainerId == 'VC_TYPERATEDA_850545') {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                isAccept = onCloseModalEventArgs.result;
            }
            if (isAccept) {
                //Refrescar e grid de tipos de tasas
                if (entities.ServerParameter.refresGridFlag == false || entities.ServerParameter.refresGridFlag == null) {
                    entities.ServerParameter.refresGridFlag = true;
                } else {
                    entities.ServerParameter.refresGridFlag = false;
                }
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == 'VC_RATESMODAL_789953') {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                isAccept = onCloseModalEventArgs.result;
            }
            if (isAccept) {
                //Refrescar e grid de valores de tasa
                if (entities.ServerParameter.refresGrid2Flag == false || entities.ServerParameter.refresGrid2Flag == null) {
                    entities.ServerParameter.refresGrid2Flag = true;
                } else {
                    entities.ServerParameter.refresGrid2Flag = false;
                }
            }
        }
        
    };

//gridRowDeleting QueryView: QV_1722_99596
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_1722_99596 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.TypeRates = true;
    };

//Start signature to callBack event to QV_1722_99596
    task.gridRowDeletingCallback.QV_1722_99596 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        gridRowDeletingEventArgs.commons.api.grid.removeAllRows("Rates");
        
    };

//gridRowDeleting QueryView: QV_5693_54772
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_5693_54772 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.Rates = true;
    };

//Start signature to callBack event to QV_5693_54772
    task.gridRowDeletingCallback.QV_5693_54772 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        //Refrescar e grid de valores de tasa
        if (entities.ServerParameter.refresGrid2Flag == false || entities.ServerParameter.refresGrid2Flag == null) {
            entities.ServerParameter.refresGrid2Flag = true;
        } else {
            entities.ServerParameter.refresGrid2Flag = false;
        }
    };

//gridRowSelecting QueryView: QV_1722_99596
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1722_99596 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        entities.ServerParameter.selectedRow = gridRowSelectingEventArgs.rowIndex;
        if (entities.ServerParameter.flag == false || entities.ServerParameter.flag == null) {
            entities.ServerParameter.flag = true;
        } else {
            entities.ServerParameter.flag = false;
        }
        //gridRowSelectingEventArgs.commons.serverParameters.TypeRates = true;
        
    };

//gridRowSelecting QueryView: QV_5693_54772
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5693_54772 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        //gridRowSelectingEventArgs.commons.serverParameters.Rates = true;
    };



}));