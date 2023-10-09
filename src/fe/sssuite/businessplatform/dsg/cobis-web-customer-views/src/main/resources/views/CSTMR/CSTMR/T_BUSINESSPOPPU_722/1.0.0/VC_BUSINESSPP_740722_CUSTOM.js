/* variables locales de T_BUSINESSPOPPU_722*/
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

    
        var task = designerEvents.api.businesspopupform;
    

    //"TaskId": "T_BUSINESSPOPPU_722"

    //Entity: Business
    //Business.dateBusiness (DateField) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DATEBUSINESSBNU_397246 = function(  entities, changedEventArgs ) {
        
    changedEventArgs.commons.execServer = true;
    
        
    };

//Entity: Business
    //Business.dateBusiness (DateField) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.VA_DATEBUSINESSBNU_397246 = function(  entities, changedCallbackEventArgs ) {

    changedCallbackEventArgs.commons.execServer = false;
    
        
    };

//Entity: Business
    //Business.resources (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RESOURCESXCAKTO_414246 = function(  entities, changedEventArgs ) {
        if(changedEventArgs.newValue == 'OT'){
            changedEventArgs.commons.api.viewState.enable('VA_WHICHRESOURCEEE_338246');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_WHICHRESOURCEEE_338246');
            entities.Business.whichResource = null;
        }
        changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: Business
    //Business.typeLocal (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TYPELOCALUWBLBM_820246 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;
    /*if(entities.Business.typeLocal == '3'){ //Mismo que Domicilio (Opción del combo para ejecución)
        
        if(entities.Business.numberOfBusiness == null){
            entities.Business.numberOfBusiness = 0;
        }
        if(entities.Business.timeActivity == null){
            entities.Business.timeActivity = 0;
        }
        if(entities.Business.timeBusinessAddress == null){
            entities.Business.timeBusinessAddress = 0;
        }
        if(entities.Business.mountlyIncomes == null){
            entities.Business.mountlyIncomes = 0;
        }
        if(entities.Business.economicActivity == null){
            entities.Business.economicActivity = '';
        }
        if(entities.Business.turnaround == null){
            entities.Business.turnaround = '';
        }
        if(entities.Business.resources == null){
            entities.Business.resources = '';
        }
        
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.Business = true;
        changedEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    } else {
        changedEventArgs.commons.execServer = false;
        
        if(entities.Business.timeActivity == 0){
            entities.Business.timeActivity = null;
        }
        if(entities.Business.timeBusinessAddress == 0){
            entities.Business.timeBusinessAddress = null;
        }
        if(entities.Business.mountlyIncomes == 0){
            entities.Business.mountlyIncomes = null;
        }
        if(entities.Business.economicActivity == ''){
            entities.Business.economicActivity = null;
        }
        if(entities.Business.turnaround == ''){
            entities.Business.turnaround = null;
        }
        if(entities.Business.resources == ''){
            entities.Business.resources = null;
        }
        
        entities.Business.street = null;
        entities.Business.numberOfBusiness = null;
        entities.Business.postalCode = null;
        
    }*/
    
    
    //changedEventArgs.commons.serverParameters.Business = true;
};

//Entity: Business
    //Business.typeLocal (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.changeCallback.VA_TYPELOCALUWBLBM_820246 = function(  entities, changedCallbackEventArgs ) {
    /*
    if(entities.Business.numberOfBusiness == 0){
        entities.Business.numberOfBusiness = null;
    }
    if(entities.Business.timeActivity == 0){
        entities.Business.timeActivity = null;
    }
    if(entities.Business.timeBusinessAddress == 0){
        entities.Business.timeBusinessAddress = null;
    }
    if(entities.Business.mountlyIncomes == 0){
        entities.Business.mountlyIncomes = null;
    }
    if(entities.Business.economicActivity == ''){
        entities.Business.economicActivity = null;
    }
    if(entities.Business.turnaround == ''){
        entities.Business.turnaround = null;
    }
    if(entities.Business.resources == ''){
        entities.Business.resources = null;
    }
    */
    changedCallbackEventArgs.commons.execServer = false;
    
};

//Entity: Business
    //Business.whichResource (TextInputBox) View: BusinessPopupForm
    
    task.customValidation.VA_WHICHRESOURCEEE_338246 = function( customValidationEventArgs ) {
      return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 4, 30); 
    };

//Entity: Business
    //Business. (Button) View: BusinessPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONYULNPZK_374246 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    
    executeCommandEventArgs.commons.serverParameters.Business = true;
    executeCommandEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    
    if(entities.Business.numberOfBusiness == null){
        entities.Business.numberOfBusiness = 0;
    }
    if(entities.Business.timeActivity == null){
        entities.Business.timeActivity = 0;
    }
    if(entities.Business.timeBusinessAddress == null){
        entities.Business.timeBusinessAddress = 0;
    }
    if(entities.Business.mountlyIncomes == null){
        entities.Business.mountlyIncomes = 0;
    }
    
    
};

//Start signature to Callback event to VA_VABUTTONYULNPZK_374246
task.executeCommandCallback.VA_VABUTTONYULNPZK_374246 = function(entities, executeCommandCallbackEventArgs) {
    //here your code
    if(executeCommandCallbackEventArgs.success){
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.Business
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        }
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BusinessPopupForm
    task.initData.VC_BUSINESSPP_740722 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        if(entities.Business.numberOfBusiness == 0){
            entities.Business.numberOfBusiness = null;
        }
        if(entities.Business.timeActivity == 0){
            entities.Business.timeActivity = null;
        }
        if(entities.Business.timeBusinessAddress == 0){
            entities.Business.timeBusinessAddress = null;
        }
        if(entities.Business.mountlyIncomes == 0){
            entities.Business.mountlyIncomes = null;
        }
        if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){
            //entities.Business.country=484//MEXICO
            entities.Business.customerCode=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmpBusiness.code;
            
        }
        initDataEventArgs.commons.api.viewState.hide('VA_TURNAROUNDZKHZG_712246');
        initDataEventArgs.commons.api.viewState.hide('VA_MOUNTLYINCOMSEE_419246');
        initDataEventArgs.commons.api.viewState.disable('VA_WHICHRESOURCEEE_338246');
        entities.Business.turnaround='A';     
    };

//Entity: Business
    //Business.colony (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_COLONYYSQOLWTXJ_927246 = function( loadCatalogDataEventArgs ) {
    
    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};

//Entity: Business
    //Business.country (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_COUNTRYIIWTTPSU_839246 = function( loadCatalogDataEventArgs ) {
    
    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};

//Entity: Business
    //Business.economicActivity (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ECONOMICACTIITI_682246 = function( loadCatalogDataEventArgs ) {

        loadCatalogDataEventArgs.commons.execServer = true;
        
        loadCatalogDataEventArgs.commons.serverParameters.Business = true;
    };

//Entity: Business
    //Business.economicActivity (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_ECONOMICACTIITI_682246 = function( entities, loadCatalogCallbackDataEventArgs ) {

    loadCatalogCallbackDataEventArgs.commons.execServer = false;
    
        
    };

//Entity: Business
    //Business.municipality (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_MUNICIPALITYALV_646246 = function( loadCatalogDataEventArgs ) {
    
    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};

//Entity: Business
    //Business.state (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_STATEILWSIRFUNE_256246 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: BusinessPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;
    
    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null:locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0){
        parameters[params[0]] = params[1];
    }
    
    if (parameters != null && parameters.modo != null && parameters.modo != undefined  && parameters.modo == 'Q'){
        var controls = ['VC_BUSINESSPP_740722'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);        
    }
    
    
    
    if(entities.Business.resources == 'OT'){
        renderEventArgs.commons.api.viewState.enable('VA_WHICHRESOURCEEE_338246');
    }

};



}));