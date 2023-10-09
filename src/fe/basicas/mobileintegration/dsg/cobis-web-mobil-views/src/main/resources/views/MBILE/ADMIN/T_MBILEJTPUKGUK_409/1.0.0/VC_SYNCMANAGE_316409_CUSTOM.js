/* variables locales de T_MBILEJTPUKGUK_409*/
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

    
        var task = designerEvents.api.syncmanagementform;
    

    //"TaskId": "T_MBILEJTPUKGUK_409"
var processDate = new Date();

task.fechaProceso= function( email ){
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function
(processDateServer) {
            processDate = new Date(processDateServer);
        });
};

    //Entity: SyncFilter
    //SyncFilter.dateEntry (DateField) View: SyncManagementForm
    
    task.customValidate.VA_DATEFIELDAUXOXK_867984 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        
        if(entities.SyncFilter.dateEntry != null){
            if(entities.SyncFilter.dateEntry.getTime() > processDate.getTime()){
                customValidateEventArgs.isValid = false;
                customValidateEventArgs.errorMessage='MBILE.MSG_MBILE_LAFECHAEL_47318';
            }
        }
        
    };

//Entity: SyncFilter
    //SyncFilter.dateSync (DateField) View: SyncManagementForm
    
    task.customValidate.VA_DATEFIELDUDYIQJ_570984 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        customValidateEventArgs.isValid = true;
        
        if(entities.SyncFilter.dateSync != null){
            if(entities.SyncFilter.dateSync.getTime() > processDate.getTime()){
                customValidateEventArgs.isValid = false;
                customValidateEventArgs.errorMessage='MBILE.MSG_MBILE_LAFECHAAR_64842';
            }
        }
        
    };

//Entity: SyncFilter
    //SyncFilter. (Button) View: SyncManagementForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONOORWXZG_436984 = function(  entities, executeCommandEventArgs ) {
        
        executeCommandEventArgs.commons.execServer = true;
        
        if((entities.SyncFilter.user === "") || (entities.SyncFilter.user === null)){
            if((entities.SyncFilter.dateSync === "") || (entities.SyncFilter.dateSync === null)){
                if((entities.SyncFilter.state === "") || (entities.SyncFilter.state === null)){
                    if((entities.SyncFilter.dateEntry === "") || (entities.SyncFilter.dateEntry === null)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('MBILE.MSG_MBILE_PORFAVOEE_79439', true);
                        executeCommandEventArgs.commons.execServer = false;
                        executeCommandEventArgs.commons.api.grid.removeAllRows('Sync');
                    }
                }
            }
        }
        
        //executeCommandEventArgs.commons.serverParameters.SyncFilter = true;
    };

//Entity: SyncFilter
    //SyncFilter. (Button) View: SyncManagementForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONOORWXZG_436984 = function(  entities, executeCommandCallbackEventArgs ) {

    executeCommandCallbackEventArgs.commons.execServer = false;
    
        
    };

//Entity: SyncFilter
    //SyncFilter.user (ComboBox) View: SyncManagementForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCYY_583984 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.SyncFilter = true;
    };

//Entity: SyncFilter
    //SyncFilter.user (ComboBox) View: SyncManagementForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_TEXTINPUTBOXCYY_583984 = function( entities, loadCatalogCallbackDataEventArgs ) {

    loadCatalogCallbackDataEventArgs.commons.execServer = false;
    
        
    };

//gridRowUpdating QueryView: QV_5753_91072
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5753_91072 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.Sync = true;
        };

//gridRowUpdating QueryView: QV_5753_91072
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdatingCallback.QV_5753_91072 = function (entities,gridRowUpdatingCallbackEventArgs) {
            gridRowUpdatingCallbackEventArgs.commons.execServer = false;
            
        };



}));