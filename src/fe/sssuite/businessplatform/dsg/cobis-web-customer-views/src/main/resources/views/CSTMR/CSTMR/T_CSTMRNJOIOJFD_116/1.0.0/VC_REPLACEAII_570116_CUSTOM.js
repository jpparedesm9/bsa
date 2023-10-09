/* variables locales de T_CSTMRNJOIOJFD_116*/
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

    
        var task = designerEvents.api.replacealtairaccount;
    

    //"TaskId": "T_CSTMRNJOIOJFD_116"


    //Entity: AltairAccount
    //AltairAccount. (Button) View: ReplaceAltairAccount
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONGWOYVMU_372715 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                mode: executeCommandEventArgs.commons.api.vc.mode,
                accountIndividual: entities.AltairAccount.oldAccountIndividual
            }});
    };

//Entity: AltairAccount
    //AltairAccount. (Button) View: ReplaceAltairAccount
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONZLMXZAV_282715 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.AltairAccount = true;
    };

//Start signature to Callback event to VA_VABUTTONZLMXZAV_282715
task.executeCommandCallback.VA_VABUTTONZLMXZAV_282715 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
                resultArgs: {
                    mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                    accountIndividual: entities.AltairAccount.newAccountIndividual
                }});
        
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: replaceAltairAccount
    task.initData.VC_REPLACEAII_570116 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.AltairAccount.personSecuential = initDataEventArgs.commons.api.parentVc.customDialogParameters.personSecuential;
        entities.AltairAccount.oldAccountIndividual = initDataEventArgs.commons.api.parentVc.customDialogParameters.oldAccount;
        entities.AltairAccount.newAccountIndividual = initDataEventArgs.commons.api.parentVc.customDialogParameters.newAccount;
    };

//Entity: AltairAccount
    //AltairAccount.newAccountIndividual (ComboBox) View: ReplaceAltairAccount
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NEWACCOUNTINVUL_794715 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.AltairAccount = true;
    };



}));