/* variables locales de T_SOLIDARITYYPN_463*/
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

    
        var task = designerEvents.api.solidaritypaymentform;
    

    //"TaskId": "T_SOLIDARITYYPN_463"

    //Entity: SolidarityPayment
    //SolidarityPayment.modificationFee (TextInputBox) View: SolidarityPaymentForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_MODIFICATIONEEE_697860 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    changedEventArgs.commons.serverParameters.SolidarityPayment = true;
    changedEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
    
    //changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONBGFXHFC_174860', undefined, true, false, 'VC_SOLIDARIEN_259463', false);
    
};

//Start signature to Callback event to VA_MODIFICATIONEEE_697860
task.changeCallback.VA_MODIFICATIONEEE_697860 = function(entities, changeCallbackEventArgs) {
//here your code
    
    if(changeCallbackEventArgs.success){
        if(entities.SolidarityPaymentDetail._data.length != 0){
            if(entities.SolidarityPayment.modificationFeeAux == entities.SolidarityPaymentDetail._data["0"].dividend){
                changeCallbackEventArgs.commons.api.grid.enabledColumn('QV_6669_21119', 'paymentAmount');
                changeCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONXDXARLH_873860');
            } else{
                changeCallbackEventArgs.commons.api.grid.disabledColumn('QV_6669_21119', 'paymentAmount');
                changeCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
            }
        } else {
            changeCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
        }
        
    }
    
};

//Entity: SolidarityPayment
    //SolidarityPayment. (Button) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONBGFXHFC_174860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.SolidarityPayment = true;
    executeCommandEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
    
};

//Start signature to Callback event to VA_VABUTTONBGFXHFC_174860
task.executeCommandCallback.VA_VABUTTONBGFXHFC_174860 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    if(executeCommandCallbackEventArgs.success){
        entities.SolidarityPayment.modificationFeeAux = entities.SolidarityPayment.modificationFee;
        if(entities.SolidarityPaymentDetail._data.length != 0){
            if(entities.SolidarityPayment.modificationFeeAux == entities.SolidarityPaymentDetail._data["0"].dividend){
                executeCommandCallbackEventArgs.commons.api.grid.enabledColumn('QV_6669_21119', 'paymentAmount'); 
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONXDXARLH_873860');
            } else{
                executeCommandCallbackEventArgs.commons.api.grid.disabledColumn('QV_6669_21119', 'paymentAmount');
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
            }
        } else {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
        }
    }
    
};

//Entity: Entity16
    //Entity16. (Button) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXDXARLH_873860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.Entity16 = true;
    };

//Start signature to Callback event to VA_VABUTTONXDXARLH_873860
task.executeCommandCallback.VA_VABUTTONXDXARLH_873860 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.LBL_ASSTS_LOSDATOCN_90286', '', 2000, false);
    }
};

//Entity: SolidarityPayment
    //SolidarityPayment. (ImageButton) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VAIMAGEBUTTONNN_542860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    
        if(entities.SolidarityPayment.modificationFee>1){
            entities.SolidarityPayment.modificationFee = entities.SolidarityPayment.modificationFee - 1;
        }
        
    };

//Entity: SolidarityPayment
    //SolidarityPayment. (ImageButton) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VAIMAGEBUTTONNN_792860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    
        if(entities.SolidarityPayment.modificationFee<entities.SolidarityPayment.maxFee){
            entities.SolidarityPayment.modificationFee = entities.SolidarityPayment.modificationFee + 1;
        }
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: SolidarityPaymentForm
task.initData.VC_SOLIDARIEN_259463 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    
    initDataEventArgs.commons.serverParameters.SolidarityPayment = true;
    initDataEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
};

//Start signature to Callback event to VC_SOLIDARIEN_259463
task.initDataCallback.VC_SOLIDARIEN_259463 = function(entities, initDataCallbackEventArgs) {
//here your code
    
    if(initDataCallbackEventArgs.success){
        entities.SolidarityPayment.modificationFeeAux = entities.SolidarityPayment.modificationFee;
    }
    
    
};

//gridRowUpdating QueryView: QV_6669_21119
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_6669_21119 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            //gridRowUpdatingEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
        };



}));