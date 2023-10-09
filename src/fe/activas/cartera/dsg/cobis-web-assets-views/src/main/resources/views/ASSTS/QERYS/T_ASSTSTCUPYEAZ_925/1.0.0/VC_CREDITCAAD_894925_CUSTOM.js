/* variables locales de T_ASSTSTCUPYEAZ_925*/
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

    
        var task = designerEvents.api.creditcandidates;
    

    //"TaskId": "T_ASSTSTCUPYEAZ_925"
task.gridRowCommand.VA_CHECKBOXXPZAELV_726782 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.CreditCandidates.data().length; i++) {
        if (i === index)
            entities.CreditCandidates.data()[i].isChecked = !entities.CreditCandidates.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.CreditCandidates.data().length != 0){
        for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
            if((entities.CreditCandidates.data()[i].isChecked === false)||(entities.CreditCandidates.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.CreditCandidates.data().length != 0) {
        for (var i = 0 ; i <= entities.CreditCandidates.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.CreditCandidates.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_895');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_819');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_819');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_895');
    }
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.CreditCandidates.data().length != 0){
        for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
            if((entities.CreditCandidates.data()[i].isChecked === false)||(entities.CreditCandidates.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_819');
        args.commons.api.grid.showToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_895');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_895');
        args.commons.api.grid.showToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_819');
    }
};

    // (Button) 
    task.executeCommand.CM_TASSTSTC_95A = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var filtro = {
            action: "A"
        };
        executeCommandEventArgs.commons.api.vc.parentVc = {}
        executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        var verifica = false;
        if(entities.CreditCandidates.data().length != 0){
            for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
                if(entities.CreditCandidates.data()[i].isChecked === true){
                    verifica = true;
                    if((entities.CreditCandidates.data()[i].periodicity === null) || (entities.CreditCandidates.data()[i].periodicity === '') || (entities.CreditCandidates.data()[i].periodicity === undefined)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBEDEFAE_12359');
                        executeCommandEventArgs.commons.execServer = false;
                        break;
                    } else if((entities.CreditCandidates.data()[i].description === null) || (entities.CreditCandidates.data()[i].description === '') || (entities.CreditCandidates.data()[i].description === undefined)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBEDEFRC_94935');
                        executeCommandEventArgs.commons.execServer = false;
                        break;
                    }
                }
            }
        }
        if(!verifica){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBESELTC_84593');
            executeCommandEventArgs.commons.execServer = false;
        }
    };

//Start signature to Callback event to CM_TASSTSTC_95A
task.executeCommandCallback.CM_TASSTSTC_95A = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9492_89518');
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.MSG_ASSTS_LATRANSLO_19347');
    }
};

// (Button) 
    task.executeCommand.CM_TASSTSTC_U29 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var filtro = {
            action: "P"
        };
        executeCommandEventArgs.commons.api.vc.parentVc = {}
        executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        
        var verifica = false;
        if(entities.CreditCandidates.data().length != 0){
            for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
                if(entities.CreditCandidates.data()[i].isChecked === true){
                    verifica = true;
					// Por caso#161681
                    //if((entities.CreditCandidates.data()[i].description != null) && (entities.CreditCandidates.data()[i].description != '')){
                    //    //executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('ASSTS.MSG_ASSTS_ALPOSPODI_25615');
                    //    break;
                    //}
                }
            }
        }
        if(!verifica){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBESELTC_84593');
            executeCommandEventArgs.commons.execServer = false;
        }
    };

//Start signature to Callback event to CM_TASSTSTC_U29
task.executeCommandCallback.CM_TASSTSTC_U29 = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9492_89518');
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.MSG_ASSTS_LATRANSLO_19347');
    }
};

// (Button) 
    task.executeCommand.CM_TASSTSTC_YQ9 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var filtro = {
            action: "D"
        };
        executeCommandEventArgs.commons.api.vc.parentVc = {}
        executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        
        var verifica = false;
        if(entities.CreditCandidates.data().length != 0){
            for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
                if(entities.CreditCandidates.data()[i].isChecked === true){
                    verifica = true;
                    if((entities.CreditCandidates.data()[i].description === null) || (entities.CreditCandidates.data()[i].description === '') || (entities.CreditCandidates.data()[i].description === undefined)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBEDEFRC_94935');
                        executeCommandEventArgs.commons.execServer = false;
                        break;
                    }
                }
            }
        }
        if(!verifica){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBESELTC_84593');
            executeCommandEventArgs.commons.execServer = false;
        }
    };

//Start signature to Callback event to CM_TASSTSTC_YQ9
task.executeCommandCallback.CM_TASSTSTC_YQ9 = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9492_89518');
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.MSG_ASSTS_LATRANSLO_19347');
    }
};

//CreditCandidatesQuery Entity: 
    task.executeQuery.Q_CREDITNT_9492 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//gridCommand (Button) QueryView: QV_9492_89518
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9492_89518_819 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

//gridCommand (Button) QueryView: QV_9492_89518
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9492_89518_895 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

task.gridInitColumnTemplate.QV_9492_89518 = function (idColumn) {
        if (idColumn === 'isChecked') {
            return "<input type=\'checkbox\' name=\'isChecked\' id=\'VA_CHECKBOXXPZAELV_726782' #if (isChecked === true) {# checked #}# ng-click=\"vc.grids.QV_9492_89518.events.customRowClick($event, \'VA_CHECKBOXXPZAELV_726782', \'DispersionsRejected\', \'QV_9492_89518\')\"/>";
        }
    };

task.gridInitEditColumnTemplate.QV_9492_89518 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//gridRowRendering QueryView: QV_9492_89518
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_9492_89518 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            var i = gridRowRenderingEventArgs.rowIndex;
            if(entities.CreditCandidates.data()[i].officerReassignedId == 0){
                entities.CreditCandidates.data()[i].officerReassignedId = null;
            }
        };

//Entity: CreditCandidates
    //CreditCandidates.officerReassignedId (ComboBox) View: CreditCandidates
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQAF_920782 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CreditCandidates = true;
    };

//Start signature to Callback event to VA_TEXTINPUTBOXQAF_920782
task.loadCatalogCallback.VA_TEXTINPUTBOXQAF_920782 = function(entities, loadCatalogCallbackEventArgs) {
//here your code
};

//Entity: CreditCandidates
    //CreditCandidates.officerAssignedId (ComboBox) View: CreditCandidates
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQRC_115782 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CreditCandidates = true;
    };

//Start signature to Callback event to VA_TEXTINPUTBOXQRC_115782
task.loadCatalogCallback.VA_TEXTINPUTBOXQRC_115782 = function(entities, loadCatalogCallbackEventArgs) {
//here your code
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: CreditCandidates
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.resultArgs != null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('CreditCandidates', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CreditCandidates
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.changeImageChecker(entities, renderEventArgs);
    };

//gridRowUpdating QueryView: QV_9492_89518
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9492_89518 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            if(gridRowUpdatingEventArgs.rowData.officerReassignedId == gridRowUpdatingEventArgs.rowData.officerAssignedId){
                gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ERRORNOSI_38798");
                gridRowUpdatingEventArgs.commons.execServer = false;
                gridRowUpdatingEventArgs.rowData.officerReassignedId = null;
            }
        };

//Start signature to Callback event to QV_9492_89518
task.gridRowUpdatingCallback.QV_9492_89518 = function(entities, gridRowUpdatingCallbackEventArgs) {
//here your code
};



}));