/* variables locales de T_TESTWKHELVLBD_756*/
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

    
        var task = designerEvents.api.projectothercharges;
    

    //"TaskId": "T_TESTWKHELVLBD_756"

    //Entity: OtherCharges
    //OtherCharges.value (TextInputBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_2011UKZSBSFRWRA_245872 = function(  entities, changedEventArgs ) {
        var value = entities.OtherCharges.value;  
        var valueMax = entities.OtherCharges.valueMax;  
        var valueMin = entities.OtherCharges.valueMin;  
        var reference = entities.OtherCharges.reference;  
        if (value.length > 20) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11975",true);
            return;
        }
        if (reference != null){
            if (value > valueMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11973",true);
            return;
            }
            if (value < valueMin) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11974",true);
                return;
            }            
        }                
        changeEventArgs.commons.execServer = false;
    };

//Entity: OtherCharges
    //OtherCharges.divUp (TextInputBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DIVUPQPVWWEQDNI_233872 = function(  entities, changedEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var iniDiv = entities.OtherCharges.iniDiv   
        var divUp = entities.OtherCharges.divUp
        if (divUp < 0){
            changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11972",true); 
               return;
        }        
        if (iniDiv < 0){
             changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11977",true); 
               return;
        }
        if (iniDiv > divUp){
           changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
    };

//Entity: OtherCharges
    //OtherCharges.iniDiv (TextInputBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_INIDIVGJKPNKHJF_695872 = function(  entities, changedEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var iniDiv = entities.OtherCharges.iniDiv      
        if (iniDiv < 0){
             changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11977",true); 
               return;
        }
    };

//Entity: OtherCharges
    //OtherCharges.concept (ComboBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXUFN_810872 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.OtherCharges = true;
    };

//Start signature to callBack event to VA_TEXTINPUTBOXUFN_810872
    task.changeCallback.VA_TEXTINPUTBOXUFN_810872 = function(entities, changeEventArgs) {
        var api = changeEventArgs.commons.api;
        var balanceOp = entities.OtherCharges.balanceOp;
        var balanceDesemp = entities.OtherCharges.balanceDesemp;        
        var categoryType = entities.OtherCharges.categoryType;        
        if(categoryType != null){
            if(categoryType.trim() ==='Q'){
                if (balanceOp.trim() === 'N' && balanceDesemp.trim() === 'N'){
                    api.viewState.enable("VA_BASECALCULATONI_509872");
                }else{
                    api.viewState.disable("VA_BASECALCULATONI_509872");
                }
            }    
            else{
            api.viewState.disable("VA_BASECALCULATONI_509872");
            }
        }
         else{
            api.viewState.disable("VA_BASECALCULATONI_509872");
        }
        //here your code
    };

// (Button) 
    task.executeCommand.CM_TTESTWKH_NN5 = function(entities, executeCommandEventArgs) {
        var mode = executeCommandEventArgs.commons.api.vc.mode;
        var concept = entities.OtherCharges.concept;
        var iniDiv = entities.OtherCharges.iniDiv;
        var divUp = entities.OtherCharges.divUp;
        var commentary = entities.OtherCharges.commentary;
        var value = entities.OtherCharges.value;
        var reference = entities.OtherCharges.reference;
    var valueMax = entities.OtherCharges.valueMax;
    var valueMin = entities.OtherCharges.valueMin;
        executeCommandEventArgs.commons.execServer = false;
        if ((iniDiv < 0) || iniDiv > 32767){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11968",true); 
           return;
        }
        if ((divUp < 0) || divUp > 32767){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11968",true); 
           return;
        }
        if (iniDiv > divUp){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
        if (iniDiv > divUp){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
        if (value < 0){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11978",true); 
           return;
        }
        if (reference != null){
            if (value > valueMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11973",true);
            return;
            }
            if (value < valueMin) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11974",true);
                return;
            }            
        }       
        if (mode === 1){
            //if (concept.trim() === ''){
            //   executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11970",true); 
            //   return;
            //}            
            //if (commentary.trim() === ''){
            //   executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11971",true); 
            //   return;
            //}           
            //executeCommandEventArgs.commons.messageHandler.showMessagesInformation("ASSTS.MSG_ASSTS_SEDEBERZE_11979", true);
        }       
        
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
      
    };

// (Button) 
    task.executeCommandCallback.CM_TTESTWKH_NN5 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false; 
        var api = executeCommandEventArgs.commons.api
        var response = { };
        api.vc.closeModal(response);
        
    };

// (Button) 
    task.executeCommand.CM_TTESTWKH_T57 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;        
        var api = executeCommandEventArgs.commons.api
        var response = { };
        api.vc.closeModal(response); 
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ProjectOtherCharges
    task.initData.VC_TESTBKYOLO_973756 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;          
        var api = initDataEventArgs.commons.api;
        var mode = initDataEventArgs.commons.api.vc.mode;
        if (mode === 2){
            initDataEventArgs.commons.api.vc.parentVc.customDialogParameters.entity = initDataEventArgs.commons.api.vc.parentVc.model.Loan;
            initDataEventArgs.commons.execServer = true;          
            api.viewState.disable("VA_TEXTINPUTBOXUFN_810872");            
            api.viewState.disable("VA_COMMENTARYRPSHX_258872");
            api.viewState.disable("VA_2011UKZSBSFRWRA_245872");
            api.viewState.disable("VA_BASECALCULATONI_509872");
        }
        else{
            api.viewState.enable("VA_TEXTINPUTBOXUFN_810872");
            api.viewState.enable("VA_COMMENTARYRPSHX_258872");
            api.viewState.enable("VA_2011UKZSBSFRWRA_245872");
            api.viewState.disable("VA_BASECALCULATONI_509872");
        }
    };

//Entity: OtherCharges
    //OtherCharges.concept (ComboBox) View: ProjectOtherCharges
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXUFN_810872 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.api.vc.parentVc.customDialogParameters.entity = loadCatalogEventArgs.commons.api.vc.parentVc.model.Loan;
        loadCatalogEventArgs.commons.execServer = true;        
        //loadCatalogEventArgs.commons.serverParameters.OtherCharges = true;
    };



}));