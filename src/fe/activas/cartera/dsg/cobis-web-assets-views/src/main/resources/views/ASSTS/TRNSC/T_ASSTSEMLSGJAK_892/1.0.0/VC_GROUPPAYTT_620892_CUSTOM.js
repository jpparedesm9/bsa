/* variables locales de T_ASSTSEMLSGJAK_892*/
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

    
        var task = designerEvents.api.grouppayment;
    

        task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
        args.model.GroupPaymentFilter.group = groupCode;
    };

    task.executeCommand.customComand = function (entities, args) {
        if (entities.GroupPayment.data().length > 0) {
            if (hasExpiredQuotas(entities.GroupPayment.data())) {
                args.commons.execServer = false;
				args.commons.api.viewState.hide('G_GROUPPAYMY_137946');
                args.commons.messageHandler.showMessagesInformation("ASSTS.LBL_ASSTS_ELGRUPOVC_74474", true);
            } else {
                args.commons.api.viewState.show('G_GROUPPAYMY_137946');
                args.commons.execServer = true;
            }
        } else {
            args.commons.api.viewState.hide('G_GROUPPAYMY_137946');
            args.commons.execServer = false;
        }
    };

    function getMaxValueAmountAllowed(entities) {
        if (entities.GroupPaymenInfo.totalAmount <= entities.GroupPaymenInfo.collateralBalance) {
            return entities.GroupPaymenInfo.totalAmount;
        }
        return entities.GroupPaymenInfo.collateralBalance;
    };

    function hasExpiredQuotas(dataGroupPayment) {
        var numberElementWithhasExpiredQuotas = 0;

        dataGroupPayment.forEach(function (groupPayment) {
            if (groupPayment.expiredQuotas === 0) {
                numberElementWithhasExpiredQuotas++;
            }
        });

        if (numberElementWithhasExpiredQuotas === dataGroupPayment.length) {
            return true;
        }
        return false;

    };

    //Entity: GroupPaymenInfo
//GroupPaymenInfo.valueAmountUseGuarantee (TextInputBox) View: GroupPayment

task.customValidate.VA_VALUEAMOUNTUARE_193946 = function (entities, customValidateEventArgs) {
    if (customValidateEventArgs.currentValue > getMaxValueAmountAllowed(entities)) {
        customValidateEventArgs.errorMessage = customValidateEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_ELVALORGO_54922') + " $" + getMaxValueAmountAllowed(entities);
        customValidateEventArgs.isValid = false;
    } else {
        customValidateEventArgs.isValid = true;
    }
};

//Entity: GroupPaymenInfo
    //GroupPaymenInfo. (Button) View: GroupPayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRSJMLRR_647946 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.GroupPaymenInfo = true;
    };

    //Start signature to Callback event to VA_VABUTTONRSJMLRR_647946
    task.executeCommandCallback.VA_VABUTTONRSJMLRR_647946 = function (entities, executeCommandCallbackEventArgs) {
        if (executeCommandCallbackEventArgs.success) {
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9025_57410');
        }
    };

//Q_GROUPPTY_9025 Entity: 
task.executeQuery.Q_GROUPPTY_9025 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = true;    
};

    //Start signature to Callback event to Q_GROUPPTY_9025
    task.executeQueryCallback.Q_GROUPPTY_9025 = function (entities, executeQueryCallbackEventArgs) {
        executeQueryCallbackEventArgs.commons.api.vc.executeCommand('customComand', 'customComand', null, false, false, '', false);
    };

//Entity: GroupPaymentFilter
//GroupPaymentFilter.group (TextInputButton) View: GroupPayment

task.textInputButtonEvent.VA_GROUPUQEWUGMETV_318946 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDARR_52528');
    nav.customAddress = {
        id: "findCustomer",
        url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ["/customer/services/find-customers-srv.js"
                                           , "/customer/controllers/find-customers-ctrl.js"]
        }];
};

//Entity: GroupPaymentFilter
    //GroupPaymentFilter.group (TextInputButton) View: GroupPayment
    
    task.textInputButtonEventGrid.VA_GROUPUQEWUGMETV_318946 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));