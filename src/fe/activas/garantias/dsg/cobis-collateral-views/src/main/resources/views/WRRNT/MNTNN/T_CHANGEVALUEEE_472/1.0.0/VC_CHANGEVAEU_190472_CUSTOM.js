/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.changevalue;

//"TaskId": "T_CHANGEVALUEEE_472"

// (Button) 
    task.executeCommand.CM_TCHANGEV_742 = function(entities, executeCommandEventArgs) {
        //var msgConfirm = "WRRNT.LBL_WRRNT_ESTSEGUCM_38694";
        var newValue = 0.0;
        
        if (entities.Warranty.percent==0)
            newValue = entities.GenericTransaction.newValue;
        else
            newValue = entities.GenericTransaction.newValue*entities.Warranty.percent/100;
            
        var msgConfirmPercent = cobis.translate("WRRNT.LBL_WRRNT_ESTSEGUCM_38694");
        var msgConfirmNewValue = cobis.translate("WRRNT.LBL_WRRNT_ESTSEGUGL_81455");
        
        var msgConfirm= msgConfirmPercent +" " + entities.Warranty.percent +" "+ msgConfirmNewValue +" "+ newValue;

        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm(msgConfirm).then(function(resp){
            var response = false;
				switch(resp.buttonIndex){
					case 0 : //CANCEL
							executeCommandEventArgs.commons.execServer = false;
							break;
					case 1 : //ACCEPT													
				            executeCommandEventArgs.commons.execServer = true;
							response = true;
							break;
				}
				return response;
			});
    };

//Start signature to Callback event to CM_TCHANGEV_742
task.executeCommandCallback.CM_TCHANGEV_742 = function(entities, executeCommandCallbackEventArgs) {
    
    
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
        if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.Warranty.externalCode);
        } 
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(true); 
    }
};

// (Button) 
    task.executeCommand.CM_TCHANGEV_VN0 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal(true); 
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ChangeValue
    task.initData.VC_CHANGEVAEU_190472 = function (entities, initDataEventArgs){
        var warranty = initDataEventArgs.commons.api.vc.customDialogParameters.warranty;
        entities.Warranty.externalCode = warranty.externalCode;
        entities.Warranty.custody = warranty.custody;
        entities.Warranty.type = warranty.type;
        entities.Warranty.office = warranty.subsidiary;
         initDataEventArgs.commons.execServer = true;
        
    };

//Start signature to Callback event to VC_CHANGEVAEU_190472
task.initDataCallback.VC_CHANGEVAEU_190472 = function(entities, initDataCallbackEventArgs) {
   
};


}());