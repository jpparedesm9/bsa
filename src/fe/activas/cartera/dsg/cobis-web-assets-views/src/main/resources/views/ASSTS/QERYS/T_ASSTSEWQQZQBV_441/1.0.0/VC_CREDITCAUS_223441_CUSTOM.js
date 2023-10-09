/* variables locales de T_ASSTSEWQQZQBV_441*/
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

    
        var task = designerEvents.api.creditcandidatespopupform;
    

    //"TaskId": "T_ASSTSEWQQZQBV_441"


    //Entity: CreditCandidates
    //CreditCandidates. (Button) View: CreditCandidatesPopUpForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONEFSSZUP_619342 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.CreditCandidates = true;
    };

//Start signature to Callback event to VA_VABUTTONEFSSZUP_619342
task.executeCommandCallback.VA_VABUTTONEFSSZUP_619342 = function(entities, executeCommandCallbackEventArgs) {
    
    if(executeCommandCallbackEventArgs.success){
        var str = entities.CreditCandidates.description;
        entities.CreditCandidates.auxText = str.substring(0, 30);;
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
        resultArgs: {
            index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
            mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
            data: entities.CreditCandidates
        }});

        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.LBL_ASSTS_TRANSACEC_23845','', 2000,false);
        }
        
    }
    
    
};

//Entity: CreditCandidates
    //CreditCandidates.officerReassignedId (ComboBox) View: CreditCandidatesPopUpForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICERREASSNII_499342 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CreditCandidates = true;
    };

//Start signature to Callback event to VA_OFFICERREASSNII_499342
task.loadCatalogCallback.VA_OFFICERREASSNII_499342 = function(entities, loadCatalogCallbackEventArgs) {
//here your code
};



}));