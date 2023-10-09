/* variables locales de T_REFERENCESPPP_957*/
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

    
        var task = designerEvents.api.referencespopupform;
    

    //"TaskId": "T_REFERENCESPPP_957"

task.findValueInCatalog=function(code,data){
    if(code==null){
        return null;
    }else{
        code=code.toString();
    }
    for(var i=0;i<data.length;i++){
        if(data[i].code == code){
            return data[i].value;
        }		
    }
    return null;
};


    //Entity: References
    //References.email (TextInputBox) View: ReferencesPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_EMAILUGHMHUTNDX_801331 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;
    
    if(!LATFO.UTILS.validarEmail(entities.References.email)){
         changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
    }
};

//Entity: References
    //References.homePhone (TextInputBox) View: ReferencesPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_HOMEPHONEZHJHRI_767331 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
		if(/^[0-9]*$/.test(entities.References.homePhone)==false){
			entities.References.homePhone = '';
			changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_SOLOSEPEM_70414',true);
		} 
          
         if(entities.References.homePhone.length!=10){
			changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELNMEROND_10800',true);
		} 
          
        
    };

//Entity: References
    //References.cellPhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_CELLPHONEKFGUJA_158331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != '')){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };

//Entity: References
    //References.homePhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_HOMEPHONEZHJHRI_767331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != '')){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };

//Entity: References
    //References.officePhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_OFFICEPHONEGMFI_991331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != "")){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };

//Entity: References
    //References. (Button) View: ReferencesPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONLYUTEBY_858331 = function(  entities, executeCommandEventArgs ) {
    
    if(entities.References.homePhone.length!=10){
			executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELNMEROND_10800',true);
          executeCommandEventArgs.commons.execServer = false;
		} 
    else{

    executeCommandEventArgs.commons.execServer = true;
    
    executeCommandEventArgs.commons.serverParameters.References = true;
    executeCommandEventArgs.commons.serverParameters.CustomerTmpReferences = true;
    entities.References.relationship='AB';
    if(entities.References.numberOfReferences == null){
        entities.References.numberOfReferences = 0;
    }
    if(entities.References.knownTime == null){
        entities.References.knownTime = 0;
    }
    }
};

//Start signature to Callback event to VA_VABUTTONLYUTEBY_858331
task.executeCommandCallback.VA_VABUTTONLYUTEBY_858331 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if(executeCommandCallbackEventArgs.success){
        var catalogs=executeCommandCallbackEventArgs.commons.api.vc.catalogs;
        entities.References.relationship=task.findValueInCatalog(entities.References.relationship,
                            catalogs.VA_RELATIONSHIPOYM_385331.data());
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.References
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        }
    }
    
    
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReferencesPopupForm
task.initData.VC_REFERENCPP_688957 = function (entities, initDataEventArgs){
    
    initDataEventArgs.commons.execServer = false;
	initDataEventArgs.commons.api.viewState.hide('VA_SECONDLASTNAEEE_703331');
    initDataEventArgs.commons.api.viewState.hide('VA_RELATIONSHIPOYM_385331');
    
    if(entities.References.numberOfReferences == 0){
        entities.References.numberOfReferences = null;
    }
    if(entities.References.knownTime == 0){
        entities.References.knownTime = null;
    }
        

    if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){
        entities.References.country=484//MEXICO
        entities.References.customerCode=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmpReferences.code;
    }
    
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ReferencesPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null:locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0){
        parameters[params[0]] = params[1];
    }

    if (parameters != null && parameters.modo != null && parameters.modo != undefined  && parameters.modo == 'Q'){
        var controls = ['VC_REFERENCPP_688957'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);        
    }
};



}));