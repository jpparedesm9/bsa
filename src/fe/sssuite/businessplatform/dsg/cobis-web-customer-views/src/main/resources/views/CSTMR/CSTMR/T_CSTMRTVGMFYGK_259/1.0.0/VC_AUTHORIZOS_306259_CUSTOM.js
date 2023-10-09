/* variables locales de T_CSTMRTVGMFYGK_259*/
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

    
        var task = designerEvents.api.authorizationtransferform;
    

    //"TaskId": "T_CSTMRTVGMFYGK_259"
task.gridRowCommand.VA_CHECKBOXFCIBUWJ_653576 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.AuthorizationTransferRequest.data().length; i++) {
        if (i === index)
            entities.AuthorizationTransferRequest.data()[i].isChecked = !entities.AuthorizationTransferRequest.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.AuthorizationTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
            if((entities.AuthorizationTransferRequest.data()[i].isChecked === false)||(entities.AuthorizationTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.AuthorizationTransferRequest.data().length != 0) {
        for (var i = 0 ; i <= entities.AuthorizationTransferRequest.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.AuthorizationTransferRequest.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_953');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_987');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_987');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_953');
    }
    
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.AuthorizationTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
            if((entities.AuthorizationTransferRequest.data()[i].isChecked === false)||(entities.AuthorizationTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_987');
        args.commons.api.grid.showToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_953');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_953');
        args.commons.api.grid.showToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_987');
    }
};

    //showGridRowDetailIcon QueryView: QV_8174_44016
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_8174_44016 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

// (Button) 
task.executeCommand.CM_TCSTMRTV_C7T = function (entities, executeCommandEventArgs) {
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
    var authorize = false;
    if (entities.AuthorizationTransferRequest.data() != null) {
        var autorizationrequests = entities.AuthorizationTransferRequest.data();
        for (var i = 0; i < autorizationrequests.length; i++) {
            if (autorizationrequests[i].isChecked) {
                authorize = true;
                break;
            }
        }
    }
    if (authorize) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea autorizar la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = true;
                return true;
                break;
            }
        });
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCAU_39994');
        executeCommandEventArgs.commons.execServer = false;
    }
};

//Start signature to Callback event to CM_TCSTMRTV_C7T
task.executeCommandCallback.CM_TCSTMRTV_C7T = function(entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_8174_44016');
    } else {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
    
};

// (Button) 
task.executeCommand.CM_TCSTMRTV_R2T = function (entities, executeCommandEventArgs) {
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
    var reject = false;
    if (entities.AuthorizationTransferRequest.data() != null) {
        var autorizationrequests = entities.AuthorizationTransferRequest.data();
        for (var i = 0; i < autorizationrequests.length; i++) {
            if (autorizationrequests[i].isChecked) {
                reject = true;
                break;
            }
        }
    }
    if (reject) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea rechazar la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = false;

                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.label = 'Raz\u00f3n de Rechazo';
                nav.address = {
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_CSTMRPCOZHJII_971',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_AUTHORIZER_104971'
                };
                nav.queryParameters = {
                    mode: 2
                };
                nav.modalProperties = {
                    size: 'sm',
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, args.modelRow);

                return true;
                break;
            }
        });
    } else {
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCDR_77549');
        executeCommandEventArgs.commons.execServer = false;
    }

};

//undefined Entity: 
    task.executeQuery.Q_AUTHORRN_8174 = function(executeQueryEventArgs){
        executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//gridCommand (Button) QueryView: QV_8174_44016
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_8174_44016_953 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.AuthorizationTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

//gridCommand (Button) QueryView: QV_8174_44016
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_8174_44016_987 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.AuthorizationTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };

task.gridInitColumnTemplate.QV_8174_44016 = function (idColumn) {
        if (idColumn === 'isChecked') {
        return "<input type=\'checkbox\' name=\'isChecked\' id=\'VA_CHECKBOXFCIBUWJ_653576' #if (isChecked === true) {# checked #}# ng-click=\"vc.grids.QV_8174_44016.events.customRowClick($event, \'VA_CHECKBOXFCIBUWJ_653576', \'DispersionsRejected\', \'QV_8174_44016\')\"/>";
    }
    };

task.gridInitEditColumnTemplate.QV_8174_44016 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//gridInitDetailTemplate QueryView: QV_8174_44016
task.gridInitDetailTemplate.QV_8174_44016 = function (entities,gridInitDetailTemplateEventArgs) {
    gridInitDetailTemplateEventArgs.commons.execServer = false;
    //gridInitDetailTemplate
    var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CSTMRHRTWSVMF_499',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_AUTHORIZEN_812499'
    };
    nav.queryParameters = {
        mode: 8
    };
    nav.customDialogParameters = {
        idRequest: gridInitDetailTemplateEventArgs.modelRow.idRequest
    };

    nav.openDetailTemplate('QV_8174_44016', gridInitDetailTemplateEventArgs.modelRow);
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AuthorizationTransferForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
        
        if(onCloseModalEventArgs.result.resultArgs!=null && onCloseModalEventArgs.result.resultArgs!=undefined){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                
                if(entities.AuthorizationTransferRequest.data().length != 0){
                    for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
                        if(entities.AuthorizationTransferRequest.data()[i].isChecked === true){
                            entities.AuthorizationTransferRequest.data()[i].rejectionReason = onCloseModalEventArgs.result.resultArgs.rejectionReason;
                            onCloseModalEventArgs.commons.execServer = true;
                            break;
                        }
                    }
                }
                
            }
        }
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AuthorizationTransferForm
    task.onCloseModalEventCallback = function (entities, onCloseModalCallbackEventArgs){
        onCloseModalCallbackEventArgs.commons.execServer = false;
        if (onCloseModalCallbackEventArgs.success) {
            onCloseModalCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
            onCloseModalCallbackEventArgs.commons.api.grid.refresh('QV_8174_44016');
        } else {
            onCloseModalCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
        }
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: AuthorizationTransferForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.changeImageChecker(entities, renderEventArgs);
    };



}));