/* variables locales de T_CONDONATIOSNN_532*/
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

    
        var task = designerEvents.api.condonationdetailform;
    

    //"TaskId": "T_CONDONATIOSNN_532"

    //gridAfterLeaveInLineRow QueryView: QV_7324_98967
    //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
    task.gridAfterLeaveInLineRow.QV_7324_98967 = function (entities, gridAfterLeaveInLineRowEventArgs) {
        gridAfterLeaveInLineRowEventArgs.commons.execServer = true;
        
    };

//Entity: CondonationDetail
    //CondonationDetail.percentage (TextInputBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXTBY_391764 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_TEXTINPUTBOXVSD_563764._data;
        var selectedRow = changeEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        //Valida que se ingrese el rubro
        if (selectedRow.concept == '' || selectedRow.concept == null) {
            if (catalogData.length > 0) {
                selectedRow.concept = catalogData[0].code;
                selectedRow.description = catalogData[0].value;
            } else {
                changeEventArgs.commons.execServer = false;
                changeEventArgs.commons.messageHandler.showMessagesError("MSG_ASSTS_ELCAMPOOC_91834",true);
                return;
            }
        }
        
        //Obtener el indice de la fila seleccionada en el grid
        var entityIndex = -1;
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            if (selectedRow.uid ===  entities.CondonationDetail._data[i].uid) {
                entityIndex = i;
                break;
            }
        }

        var model = changeEventArgs.commons.api.vc.model;
        model.ServerParameter.selectedRow = entityIndex;
        //changeEventArgs.commons.serverParameters.CondonationDetail = true;
    };

//Entity: CondonationDetail
    //CondonationDetail.percentage (TextInputBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.VA_TEXTINPUTBOXTBY_391764 = function(  entities, changedEventArgs ) {
        var selectedRow = changeCallbackEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        selectedRow.set('valueToCondone', entities.ServerParameter.amount);
    };

//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXVSD_563764 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
        //Valida que se ingrese el rubro
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_TEXTINPUTBOXVSD_563764._data;
        var selectedRow = changeEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;

        if (selectedRow.concept == '' || selectedRow.concept == null) {
            if (catalogData.length > 0) {
                selectedRow.concept = catalogData[0].code;
                selectedRow.description = catalogData[0].value;
            } else {
                changeEventArgs.commons.execServer = false;
            }
        }
        if (selectedRow.percentage == 0) 
            changeEventArgs.commons.execServer = false;
        
        entities.ServerParameter.selectedRow = 0;
        //changeEventArgs.commons.serverParameters.CondonationDetail = true;
    };

//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.VA_TEXTINPUTBOXVSD_563764 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        selectedRow.set('valueToCondone', entities.ServerParameter.amount);
    };

// (Button) 
    task.executeCommand.CM_TCONDONA_NAN = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var cancelButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };

// (Button) 
    task.executeCommand.CM_TCONDONA_SS3 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var hasError = false;
        var msgResourceID = "";
        var selectedRow = executeCommandEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            if (entities.CondonationDetail._data[i].percentage > entities.ServerParameter.condonationPercentage) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18736"
                break;
            }
            if (entities.CondonationDetail._data[i].valueToCondone <= 0) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18737"
                break
            }
        }
        //valida que no ingrese mas de una vez el mismo rubro
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            var concept = entities.CondonationDetail._data[i].concept
            for (var j = i + 1; j < entities.CondonationDetail._data.length; j++) {
                if (entities.CondonationDetail._data[j].concept == concept) {
                    hasError = true;
                    msgResourceID = "ASSTS.MSG_ASSTS_NOPUEDEOR_19224";
                    break;
                }
            }
            if (hasError)
                break;
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        } else {
            var dataGrid = {
                data: entities.CondonationDetail
            }
            executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);
        }
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CondonationDetailForm
    task.initData.VC_CONDONATON_778532 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.ServerParameter.loanBankID = dialogParameters.bankNum;
        initDataEventArgs.commons.api.grid.addAllRows("CondonationDetail", dialogParameters.condonationDetail2._data, false);

    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CondonationDetailForm
    task.initDataCallback.VC_CONDONATON_778532 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        //entities.ServerParameter.condonationPercentage = 100;
        if (entities.ServerParameter.condonationPercentage == null || entities.ServerParameter.condonationPercentage == 0) 
            entities.ServerParameter.condonationPercentage = 100;
    };

//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXVSD_563764 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        var model=loadCatalogEventArgs.commons.api.vc.model;
        model.ServerParameter.loanBankID = loadCatalogEventArgs.commons.api.navigation.getCustomDialogParameters().bankNum;
        loadCatalogEventArgs.commons.serverParameters.ServerParameter = true;
        //loadCatalogEventArgs.commons.serverParameters.CondonationDetail = true;
    };



}));