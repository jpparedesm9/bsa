/* variables locales de T_MBILEKTPCSLCM_549*/
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

    
        var task = designerEvents.api.mobilepopupform;
    

    //"TaskId": "T_MBILEKTPCSLCM_549"
var LONG_IMEI = 15;
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

    //Entity: Mobile
//Mobile. (Button) View: MobilePopUpForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONODIGQRB_255864 = function (entities, executeCommandEventArgs) {

    if ((entities.Mobile.imei == null || entities.Mobile.imei == "") || (entities.Mobile.imei != null && entities.Mobile.imei.length >= LONG_IMEI)) {
        executeCommandEventArgs.commons.execServer = true;
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('MBILE.MSG_MBILE_ELIMEIINO_31530');
        executeCommandEventArgs.commons.serverParameters.Mobile = false;
    }

};

//Entity: Mobile
    //Mobile. (Button) View: MobilePopUpForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONODIGQRB_255864 = function(  entities, executeCommandCallbackEventArgs ) {

        executeCommandCallbackEventArgs.commons.execServer = false;
        var nav = executeCommandCallbackEventArgs.commons.api.navigation;
        var catalogs=executeCommandCallbackEventArgs.commons.api.vc.catalogs;
        
        entities.Mobile.typeDescription=task.findValueInCatalog(entities.Mobile.type,
                            catalogs.VA_TEXTINPUTBOXMYG_290864.data());
        entities.Mobile.officialDescription=task.findValueInCatalog(entities.Mobile.official,
                            catalogs.VA_TEXTINPUTBOXJOU_670864.data());
							
        if(entities.Mobile.officialDescription===null || entities.Mobile.officialDescription===""||entities.Mobile.officialDescription==='null'){
            entities.Mobile.officialDescription = 'NO EXISTE OFICIAL';
        }
		
        entities.Mobile.deviceStatusDescription=task.findValueInCatalog(entities.Mobile.deviceStatus,
                            catalogs.VA_DEVICESTATUSGNK_898864.data());
        
        if(executeCommandCallbackEventArgs.success){
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.Mobile
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Registro creado exitosamente','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Registro actualizado exitosamente','', 2000,false);
        }
    }
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: MobilePopUpForm
task.initData.VC_MOBILEPOPP_688549 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    if ((entities.Mobile.deviceStatus === null) || (entities.Mobile.deviceStatus === '')) {
        entities.Mobile.deviceStatus = 'P';
    }

    if (initDataEventArgs.commons.api.vc.mode === initDataEventArgs.commons.constants.mode.Insert) {
        initDataEventArgs.commons.api.viewState.disable('VA_DEVICESTATUSGNK_898864');              
        entities.Mobile.imei = null;
        entities.Mobile.official = null;
        entities.Mobile.allowUpdate = true;
    } else if (initDataEventArgs.commons.api.vc.mode === initDataEventArgs.commons.constants.mode.Update) {
        initDataEventArgs.commons.api.viewState.enable('VA_DEVICESTATUSGNK_898864');
    }
    
    if(entities.Mobile.deviceStatus == 'P'){
        initDataEventArgs.commons.api.viewState.disable('VA_ALLOWUPDATETLLJ_672864');
    }
};

//Entity: Mobile
    //Mobile.official (ComboBox) View: MobilePopUpForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXJOU_670864 = function( loadCatalogDataEventArgs ) {

        loadCatalogDataEventArgs.commons.execServer = true;
        
        loadCatalogDataEventArgs.commons.serverParameters.Mobile = true;
    };

//Entity: Mobile
    //Mobile.official (ComboBox) View: MobilePopUpForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_TEXTINPUTBOXJOU_670864 = function( entities, loadCatalogCallbackDataEventArgs ) {

    loadCatalogCallbackDataEventArgs.commons.execServer = false;
        
    };



}));