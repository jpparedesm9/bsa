/* variables locales de T_CSTMRTCAJUPXM_188*/
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

    
        var task = designerEvents.api.transferrequestform;
    

    //"TaskId": "T_CSTMRTCAJUPXM_188"
task.gridRowCommand.VA_CHECKBOXQELWHKO_910231 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.CustomerTransferRequest.data().length; i++) {
        if (i === index)
            entities.CustomerTransferRequest.data()[i].isChecked = !entities.CustomerTransferRequest.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.CustomerTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.CustomerTransferRequest.data().length -1 ; i++ ){
            if((entities.CustomerTransferRequest.data()[i].isChecked === false)||(entities.CustomerTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.CustomerTransferRequest.data().length != 0) {
        for (var i = 0 ; i <= entities.CustomerTransferRequest.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.CustomerTransferRequest.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_627');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_386');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_386');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_627');
    }
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.CustomerTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.CustomerTransferRequest.data().length -1 ; i++ ){
            if((entities.CustomerTransferRequest.data()[i].isChecked === false)||(entities.CustomerTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_386');
        args.commons.api.grid.showToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_627');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_627');
        args.commons.api.grid.showToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_386');
    }
};

    //Entity: CustomerTransferRequest
    //CustomerTransferRequest.isChecked (CheckBox) View: TransferRequestForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CHECKBOXQELWHKO_910231 = function(entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = true;
        //changedEventArgs.commons.serverParameters.CustomerTransferRequest = true;
    };

//Entity: TransferRequest
    //TransferRequest.idCause (ComboBox) View: TransferRequestForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IDCAUSEQFBLDBCT_306231 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        if (entities.TransferRequest.idCause === "7")
            changedEventArgs.commons.api.viewState.show('VA_DESCRIPTIONCSAA_539231');
        else
            changedEventArgs.commons.api.viewState.hide('VA_DESCRIPTIONCSAA_539231');
        
    };

//Entity: TransferRequest
//TransferRequest.isAll (CheckBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ISALLNMRJFGEEEH_511231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    entities.TransferRequest.marketType = null;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");

    if (entities.TransferRequest.isGroup !== 'S') {
        if (entities.TransferRequest.isAll == 'S') {
            changedEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
        } else {
            changedEventArgs.commons.api.viewState.enable('VA_MARKETTYPEMWHWP_950231');
        }
    }
};

//Entity: TransferRequest
//TransferRequest.isGroup (RadioButtonList) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ISGROUPLIZMPQWJ_431231 = function (entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;
    if (entities.TransferRequest.isGroup === 'S') {
        changedEventArgs.commons.api.grid.showColumn('QV_9850_34524', 'creditAmount');
        changedEventArgs.commons.api.grid.showColumn('QV_9850_34524', 'weeksDelay');
        changedEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
        changedEventArgs.commons.api.viewState.disable('VA_ISALLNMRJFGEEEH_511231');
        entities.TransferRequest.marketType = null;
        entities.TransferRequest.isAll = 'N';
    } else {
        changedEventArgs.commons.api.grid.hideColumn('QV_9850_34524', 'creditAmount');
        changedEventArgs.commons.api.grid.hideColumn('QV_9850_34524', 'weeksDelay');
        changedEventArgs.commons.api.viewState.enable('VA_MARKETTYPEMWHWP_950231');
        changedEventArgs.commons.api.viewState.enable('VA_ISALLNMRJFGEEEH_511231');
    }
    //changedEventArgs.commons.api.grid.removeAllRows('CustomerTransferRequest');
    if (changedEventArgs.oldValue != null) {
        var filtro = {
            ejecucion: 0
        }
        changedEventArgs.commons.api.vc.parentVc = {}
        changedEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        changedEventArgs.commons.api.grid.refresh("QV_9850_34524");
    }
};

//Entity: TransferRequest
//TransferRequest.marketType (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_MARKETTYPEMWHWP_950231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};

//Entity: TransferRequest
//TransferRequest.officeOriginId (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_OFFICEORIGINDII_127231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};

//Entity: TransferRequest
//TransferRequest.officialOriginId (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_OFFICIALORIGIII_648231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};

//Entity: TransferRequest
    //TransferRequest.descriptionCause (TextInputBox) View: TransferRequestForm
    
    task.customValidate.VA_DESCRIPTIONCSAA_539231 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        if (entities.TransferRequest.idCause === "7" && entities.TransferRequest.descriptionCause ==""){
            var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_ESNECESPM_76519');
            customValidateEventArgs.errorMessage = errorMessage;
            customValidateEventArgs.isValid = false;
        }
        else {
            customValidateEventArgs.isValid = true;
        }
        
    };

//Entity: TransferRequest
//TransferRequest.marketType (ComboBox) View: TransferRequestForm
task.customValidate.VA_MARKETTYPEMWHWP_950231 = function (entities, customValidateEventArgs) {
    customValidateEventArgs.commons.execServer = false;
    if (entities.TransferRequest.isAll == 'N' && (entities.TransferRequest.marketType == '' || entities.TransferRequest.marketType == null || entities.TransferRequest.marketType == undefined)) {
        var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_TIPODEMDD_28306');
        customValidateEventArgs.errorMessage = errorMessage;
        customValidateEventArgs.isValid = false;
    } else {
        customValidateEventArgs.isValid = true;
    }
};

//Entity: TransferRequest
    //TransferRequest.officialDestinationId (ComboBox) View: TransferRequestForm
    
    task.customValidate.VA_OFFICIALDESTDNN_244231 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        if (entities.TransferRequest.officialDestinationId == entities.TransferRequest.officialOriginId){
            var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_ELOFICIEA_76583');
            customValidateEventArgs.errorMessage = errorMessage;
            customValidateEventArgs.isValid = false;
        }
        else {
            customValidateEventArgs.isValid = true;
        }
    };

// (Button) 
task.executeCommand.CM_TCSTMRTC_CTS = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.serverParameters.TransferRequest = true;
    var createRequest = false;
    if (entities.CustomerTransferRequest.data() != null) {
        var requests = entities.CustomerTransferRequest.data();
        for (var i = 0; i < requests.length; i++) {
            if (requests[i].isChecked) {
                createRequest = true;
                break;
            }
        }
    }

    if (createRequest) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea crear la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = true;
                executeCommandEventArgs.commons.serverParameters.TransferRequest = true;
                executeCommandEventArgs.commons.serverParameters.CustomerTransferRequest = true;
                return true;
                break;
            }
        });
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCRU_94493');
        executeCommandEventArgs.commons.execServer = false;
    }


};

// (Button) 
    task.executeCommandCallback.CM_TCSTMRTC_CTS = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        if (executeCommandCallbackEventArgs.success) {
            //Set del campo HiddenInCompleted para poder continuar la tarea
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9850_34524');
        } else {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORENRR_59536');
        }
    };

//CustomerTransferRequestQuery Entity: 
task.executeQuery.Q_CUSTOMNS_9850 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = false;
    if (executeQueryEventArgs.commons.api.vc.model.CustomerTransferRequest.data().length === 0) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }

    if (executeQueryEventArgs.parameters.officeId != null && executeQueryEventArgs.parameters.officeId != null) {
        executeQueryEventArgs.commons.execServer = true;
        executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_9850_34524', ['customerId'], executeQueryEventArgs);
    }
};

//gridCommand (Button) QueryView: QV_9850_34524
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9850_34524_386 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.CustomerTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

//gridCommand (Button) QueryView: QV_9850_34524
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9850_34524_627 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.CustomerTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

task.gridInitColumnTemplate.QV_9850_34524 = function (idColumn) {
        if (idColumn === 'isChecked') {
        return "<input type=\'checkbox\' name=\'isChecked\' id=\'VA_CHECKBOXQELWHKO_910231' #if (isChecked === true) {# checked #}# ng-click=\"vc.grids.QV_9850_34524.events.customRowClick($event, \'VA_CHECKBOXQELWHKO_910231', \'DispersionsRejected\', \'QV_9850_34524\')\"/>";
    }
    };

task.gridInitEditColumnTemplate.QV_9850_34524 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: TransferRequestForm
task.initData.VC_TRANSFERUR_363188 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
    initDataEventArgs.commons.api.viewState.disable('VA_ISALLNMRJFGEEEH_511231');
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: TransferRequestForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.changeImageChecker(entities, renderEventArgs);
    };



}));