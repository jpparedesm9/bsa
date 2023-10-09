/* variables locales de T_ECONOMICACPOT_751*/
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

    
        var task = designerEvents.api.economicactivitypopupform;
    

    //"TaskId": "T_ECONOMICACPOT_751"
var msgIDResourse = "";
task.calculateAntiquity = function (economicActivity) {
    var startDate = economicActivity.startdateActivity;
    var today = new Date();
    var antiquity = 0;
    
    if (startDate != null) {
        var d1Y = startDate.getFullYear();
        var d2Y = today.getFullYear();
        var d1M = startDate.getMonth();
        var d2M = today.getMonth();

        antiquity = (d2M+12*d2Y)-(d1M+12*d1Y);
    }

    economicActivity.antiquity = antiquity;
}

task.validateEconomicActivityData = function (EconomicActivity) {
    msgIDResourse = '';
    
    if (EconomicActivity.economicSector == null || EconomicActivity.economicSector == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOLG_31964'; 
        return false;
    }
    if (EconomicActivity.subSector == null || EconomicActivity.subSector == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOTL_36929'; 
        return false;
    }
    if (EconomicActivity.economicActivity == null || EconomicActivity.economicActivity == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOMO_47217'; 
        return false;
    }
    if (EconomicActivity.description == null || EconomicActivity.description == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPODG_19434'; 
        return false;
    }
    if (EconomicActivity.principal == null || EconomicActivity.principal == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOLO_76706'; 
        return false;
    }
    if (EconomicActivity.startdateActivity == null || EconomicActivity.startdateActivity == '') {
        EconomicActivity.startdateActivity = '';
    } else {
        var today = new Date();
        if (EconomicActivity.startdateActivity > today) {
            EconomicActivity.startdateActivity = today;
        }
    }
    if (EconomicActivity.environment == null || EconomicActivity.environment == '') {
        EconomicActivity.environment = '';
    }
    if (EconomicActivity.propertyType == null || EconomicActivity.propertyType == '') {
        EconomicActivity.propertyType = '';
    }
    if (EconomicActivity.numberEmployees == null) {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPODG_30371'; 
        return false;
    } else {
        if (EconomicActivity.numberEmployees < 0) {
            msgIDResourse = 'CSTMR.MSG_CSTMR_ELNMEROAD_90901'; 
            return false;
        }
    }
    if (EconomicActivity.antiquity == null) {
        EconomicActivity.antiquity = 0;
    }
    if (EconomicActivity.affiliate == null || EconomicActivity.affiliate == '') {
        EconomicActivity.affiliate = '';
    } else {
        if (EconomicActivity.affiliate == 'S' && (EconomicActivity.placeAffiliation == null || EconomicActivity.placeAffiliation == '')) {
            EconomicActivity.placeAffiliation = '';
            EconomicActivity.affiliate = 'S';
        }
    }
    return true;
}

    // (Button) 
task.executeCommand.CM_TECONOMI_2A8 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var cancelButton = false;
    executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
};

// (Button) 
task.executeCommand.CM_TECONOMI_RSP = function(entities, executeCommandEventArgs) {
    var d = new Date();
    /* Seteando valores para campos no usados en Santander */
    entities.EconomicActivity.authorized = 'S';
    entities.EconomicActivity.startdateActivity = '';
    entities.EconomicActivity.startdateActivity = d.getDate();
    entities.EconomicActivity.environment = '';
    entities.EconomicActivity.propertyType = 'N/A';
    entities.EconomicActivity.antiquity = 0;
    entities.EconomicActivity.affiliate = '';
    entities.EconomicActivity.placeAffiliation = '';
    entities.EconomicActivity.affiliate = 'S';
    
    executeCommandEventArgs.commons.execServer = true;
    var dataOk = true;
    dataOk = task.validateEconomicActivityData(entities.EconomicActivity);
    if (!dataOk) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError(msgIDResourse,true);
        executeCommandEventArgs.commons.execServer = false;
    }
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
};

//Start signature to callBack event to CM_TECONOMI_RSP
task.executeCommandCallback.CM_TECONOMI_RSP = function(entities, executeCommandCallbackEventArgs) {
    var aceptButton = true;
    executeCommandCallbackEventArgs.commons.api.navigation.closeModal(aceptButton);
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: EconomicActivityPopupForm
task.initData.VC_ECONOMICOU_167751 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    
    if (initDataEventArgs.commons.api.vc.mode == 1) {
        entities.EconomicActivity.personSecuential = initDataEventArgs.commons.api.parentVc.model.NaturalPerson.personSecuential;
        task.calculateAntiquity(entities.EconomicActivity);
    }
    
    entities.EconomicActivity.authorized = 'S';
     if(entities.EconomicActivity.secuential==0)
    {
    entities.EconomicActivity.economicSector='III'
    entities.EconomicActivity.subSector='U'
    }
    initDataEventArgs.commons.api.viewState.disable('VA_ECONOMICSECTORO_655887');
    initDataEventArgs.commons.api.viewState.disable('VA_SUBSECTORFKJIRP_876887');
    initDataEventArgs.commons.api.viewState.hide('VA_PRINCIPALJAQWIU_928887');
    initDataEventArgs.commons.api.viewState.hide('VA_DESCRIPTIONGSVS_438887');
    initDataEventArgs.commons.api.viewState.hide('VA_NUMBEREMPLOYEEE_936887');
    
    entities.EconomicActivity.description='S';
    entities.EconomicActivity.numberEmployees=1;
    entities.EconomicActivity.principal='N'

};

//Entity: EconomicActivity
//EconomicActivity.economicActivity (ComboBox) View: EconomicActivityPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_ECONOMICACTIYTT_504887 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EconomicActivity = true;
};

//Entity: EconomicActivity
//EconomicActivity.subSector (ComboBox) View: EconomicActivityPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_SUBSECTORFKJIRP_876887 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EconomicActivity = true;
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: EconomicActivityPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;

    var api = renderEventArgs.commons.api;

    if (api.parentVc.model.Entity1.screenMode == 'Q') {
        api.viewState.disable('VA_SECUENTIALWARUP_426887');
        api.viewState.disable('VA_ECONOMICSECTORO_655887');
        api.viewState.disable('VA_SUBSECTORFKJIRP_876887');
        api.viewState.disable('VA_ECONOMICACTIYTT_504887');
        api.viewState.disable('VA_DESCRIPTIONGSVS_438887');
        api.viewState.disable('VA_PRINCIPALJAQWIU_928887');
        api.viewState.disable('VA_STARTDATEACTIYI_966887');
        api.viewState.disable('VA_ANTIQUITYAOXEZY_723887');
        api.viewState.disable('VA_NUMBEREMPLOYEEE_936887');
        api.viewState.disable('VA_AUTHORIZEDRYTPO_449887');
        api.viewState.disable('VA_AFFILIATEEORSHU_858887');
        api.viewState.disable('VA_PLACEAFFILIAOTT_272887');
        api.viewState.disable('VA_ENVIRONMENTRONU_551887');
        api.viewState.disable('VA_PROPERTYTYPEDLF_626887');
        api.viewState.disable('CM_TECONOMI_RSP');
    }

};



}));