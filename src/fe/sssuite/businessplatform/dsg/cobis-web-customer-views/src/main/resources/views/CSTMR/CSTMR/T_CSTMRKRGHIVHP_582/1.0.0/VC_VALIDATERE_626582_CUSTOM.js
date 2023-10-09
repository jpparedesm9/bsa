/* variables locales de T_CSTMRKRGHIVHP_582*/
var EXPIRED = '';
var ACTIVE = '';
var APPLIED = '';
var MAX_AMOUNT = 9999999999.99;

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

    
        var task = designerEvents.api.validatereferenceform;
    

    //"TaskId": "T_CSTMRKRGHIVHP_582"

task.cleanFields = function (entities,args) {
    entities.ReferenceReq.referenceNumber = '';
    entities.ReferenceReq.authorizedAmount = 0 ;
    entities.ReferenceReq.purchaseAmount = 0 ;
    entities.ReferenceInfor.refValidity  = null;
    entities.ReferenceInfor.refStatus  = null;
    entities.ReferenceInfor.operationDate  = null;
    entities.ReferenceInfor.operationTime  = null;
    entities.ReferenceInfor.authorizationNumber  = null;
    
    var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
    LATFO.UTILS.disableFields(args, controls, true);
}

    //Entity: ReferenceReq
    //ReferenceReq.purchaseAmount (TextInputBox) View: ValidateReferenceForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_3427XJKLLNQAQYE_228945 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        var controls = ['CM_TCSTMRKR_SMT'];
     LATFO.UTILS.disableFields(changedEventArgs, controls, true);
        
    };

//Entity: ReferenceReq
    //ReferenceReq.referenceNumber (TextInputBox) View: ValidateReferenceForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_5608FDSMYIVCMKB_809945 = function(  entities, changedEventArgs ) {
        //changedEventArgs.commons.serverParameters.ReferenceReq = true;
        EXPIRED = cobis.translate('CSTMR.LBL_CSTMR_CADUCADAA_62798');
        ACTIVE = cobis.translate('CSTMR.LBL_CSTMR_VIGENTEWR_13152');
        APPLIED = cobis.translate('CSTMR.LBL_CSTMR_APLICADOO_96730');
        entities.ReferenceInfor.authorizationNumber='';
        entities.ReferenceInfor.operationDate=null;
        entities.ReferenceInfor.operationTime=null;
        if(entities.ReferenceReq.referenceNumber != null && entities.ReferenceReq.referenceNumber != '' &&  
                entities.ReferenceReq.referenceNumber.length == entities.ReferenceReq.refLenght){
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;
        }
    };

//Start signature to Callback event to VA_5608FDSMYIVCMKB_809945
task.changeCallback.VA_5608FDSMYIVCMKB_809945 = function(entities, changeCallbackEventArgs) {
    if(changeCallbackEventArgs.success){
        if(entities.ReferenceInfor.refStatus == EXPIRED){ // C=CADUCADA

            var botonLabel = cobis.translate('CSTMR.LBL_CSTMR_ACEPTARZF_98506'),
            mensaje = cobis.translate('CSTMR.MSG_CSTMR_REFERENNI_70685'),
            titulo = cobis.translate('CSTMR.LBL_CSTMR_REFERENAD_67241');

            var buttons = [botonLabel],
            promise = cobis.showMessageWindow.confirm(mensaje, titulo, buttons);
            promise.then(function (response) {
                changeCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONTLJBFIX_730945','Compute', undefined, true, false, 'VC_VALIDATERE_626582', false);
            });
        }else{
            var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
            LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, false);
            controls = ['VA_5608FDSMYIVCMKB_809945'];
            LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, true);
        }
    }else{
        entities.ReferenceReq.referenceNumber = '';
        var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, true);
    }
};

//Entity: ReferenceReq
    //ReferenceReq.purchaseAmount (TextInputBox) View: ValidateReferenceForm
    
    task.customValidate.VA_3427XJKLLNQAQYE_228945 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        if(entities.ReferenceReq.purchaseAmount <= 0 || 
           entities.ReferenceReq.purchaseAmount > MAX_AMOUNT){//Monto debe ser mayor a 0 y menor a 10 000 000 000
            customValidateEventArgs.errorMessage = 'CSTMR.MSG_CSTMR_MONTODERR_29310';
            customValidateEventArgs.isValid = false;
            //entities.ReferenceReq.purchaseAmount = 0;
            //$('#VA_3427XJKLLNQAQYE_228945').text("0");
            $("#VA_3427XJKLLNQAQYE_228945").val("0");
        } else{
            customValidateEventArgs.isValid = true;
        }
    };

// (Button) 
    task.executeCommand.CM_TCSTMRKR_45T = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //$('#VA_3427XJKLLNQAQYE_228945').text(0);
        entities.ReferenceReq.purchaseAmount = 0;
        task.cleanFields(entities,executeCommandEventArgs);
        var controls = ['VA_5608FDSMYIVCMKB_809945'];
        LATFO.UTILS.disableFields(executeCommandEventArgs, controls, false);
    };

// (Button) 
    task.executeCommand.CM_TCSTMRKR_SMT = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to CM_TCSTMRKR_SMT
task.executeCommandCallback.CM_TCSTMRKR_SMT = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        entities.ReferenceInfor.refStatus = APPLIED;
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('CSTMR.LBL_CSTMR_LATRANSZA_43084', false, null, 6000);
    }
    
};

//Entity: ReferenceReq
//ReferenceReq. (Button) View: ValidateReferenceForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONMCMUPUS_172945 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;

    //executeCommandEventArgs.commons.serverParameters.ReferenceReq = true;
    
    
};

//Start signature to Callback event to VA_VABUTTONMCMUPUS_172945
task.executeCommandCallback.VA_VABUTTONMCMUPUS_172945 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        var controls = ['CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
        controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('CSTMR.MSG_CSTMR_TRANSACNA_95871',5000);
    }else{
        var controls = ['CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        
        controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
    }
};

//Entity: ReferenceReq
//ReferenceReq. (Button) View: ValidateReferenceForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONTLJBFIX_730945 = function(  entities, executeCommandEventArgs ) {
    executeCommandEventArgs.commons.execServer = false;
    task.cleanFields(entities,executeCommandEventArgs);
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ValidateReferenceForm
task.initData.VC_VALIDATERE_626582 = function (entities, initDataEventArgs){
    EXPIRED = cobis.translate('CSTMR.LBL_CSTMR_CADUCADAA_62798');
    ACTIVE = cobis.translate('CSTMR.LBL_CSTMR_VIGENTEWR_13152');
    APPLIED = cobis.translate('CSTMR.LBL_CSTMR_APLICADOO_96730');
    initDataEventArgs.commons.execServer = true;
    var controls = ['VA_4946SJPACVZFMWM_373945','VA_3427XJKLLNQAQYE_228945','VA_1SYTJLSFVGPZTLZ_730945',
                    'VA_2162OOPJZILSJIG_309945','VA_8931EJGJPFLRCLA_810945','VA_2008YZXDHFWCPDA_768945',
                    'VA_5204RGQEHWUBOFP_899945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
    LATFO.UTILS.disableFields(initDataEventArgs, controls, true);
    task.cleanFields(entities,initDataEventArgs);
};

//Start signature to Callback event to VC_VALIDATERE_626582
task.initDataCallback.VC_VALIDATERE_626582 = function(entities, initDataCallbackEventArgs) {
    $('#VA_5608FDSMYIVCMKB_809945').attr('maxlength', entities.ReferenceReq.refLenght);
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ValidateReferenceForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;
};



}));