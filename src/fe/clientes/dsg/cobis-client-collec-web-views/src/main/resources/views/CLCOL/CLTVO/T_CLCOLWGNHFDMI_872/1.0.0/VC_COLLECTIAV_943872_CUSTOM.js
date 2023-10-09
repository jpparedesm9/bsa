/* variables locales de T_CLCOLWGNHFDMI_872*/
var activate = false;
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

    
        var task = designerEvents.api.collectiveadvisorsroles;
    

    //"TaskId": "T_CLCOLWGNHFDMI_872"


    //Entity: CollectiveRole
    //CollectiveRole.collective (ComboBox) View: CollectiveAdvisorsRoles
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_COLLECTIVESPPQW_866380 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    entities.CollectiveRole.collectiveDescription =  changedEventArgs.commons.api.viewState.selectedText('VA_COLLECTIVESPPQW_866380', changedEventArgs.newValue);
        
    };

//Entity: CollectiveRole
    //CollectiveRole.role (ComboBox) View: CollectiveAdvisorsRoles
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ROLERJQVGOOROND_932380 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    activate = true;
    entities.CollectiveRole.roleDescription =  changedEventArgs.commons.api.viewState.selectedText('VA_ROLERJQVGOOROND_932380', changedEventArgs.newValue);
    entities.CollectiveRole.official = null;
    entities.CollectiveRole.collective = null;
    entities.CollectiveRole.collectiveDescription = null;
    changedEventArgs.commons.api.viewState.refreshData('VA_OFFICIALYYQHLMI_968380');    
    };

// (Button) 
    task.executeCommand.VA_VABUTTONUCULYAE_906380 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
        
    };

//Start signature to Callback event to VA_VABUTTONUCULYAE_906380
task.executeCommandCallback.VA_VABUTTONUCULYAE_906380 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("CLCOL.MSG_CLCOL_REGISTRSE_24783", null, 6000, false);
    }
    executeCommandCallbackEventArgs.commons.api.grid.refresh("QV_7238_33339");
};

//undefined Entity: 
    task.executeQuery.Q_COLLECER_7238 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;;

//Start signature to Callback event to Q_COLLECER_7238
task.executeQueryCallback.Q_COLLECER_7238 = function(entities, executeQueryCallbackEventArgs) {
//here your code
};

//Entity: CollectiveRole
    //CollectiveRole.collective (ComboBox) View: CollectiveAdvisorsRoles
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COLLECTIVESPPQW_866380 = function( loadCatalogDataEventArgs ) {

        loadCatalogDataEventArgs.commons.execServer = true;
    
        loadCatalogDataEventArgs.commons.serverParameters.CollectiveRole = true;
    };

//Entity: CollectiveRole
    //CollectiveRole.official (ComboBox) View: CollectiveAdvisorsRoles
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICIALYYQHLMI_968380 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        if(activate){
            loadCatalogDataEventArgs.commons.execServer = true;
        }
        loadCatalogDataEventArgs.commons.serverParameters.CollectiveRole = true;
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CollectiveAdvisorsRoles
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.grid.refresh("QV_7238_33339");
    };

//Start signature to Callback event to QV_7238_33339
task.gridRowDeletingCallback.QV_7238_33339 = function(entities, gridRowDeletingCallbackEventArgs) {
    if(gridRowDeletingCallbackEventArgs.success){
        gridRowDeletingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("CLCOL.MSG_CLCOL_REGISTRIO_58575", null, 6000, false);
    }
    gridRowDeletingCallbackEventArgs.commons.api.grid.refresh("QV_7238_33339");
};



}));