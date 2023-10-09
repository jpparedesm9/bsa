/* variables locales de T_MBILEJIXXTPVT_502*/
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

    
        var task = designerEvents.api.mobilemanagementform;
    

    //"TaskId": "T_MBILEJIXXTPVT_502"

    //MobileQuery Entity: 
task.executeQuery.Q_MOBILEVP_5973 = function (executeQueryEventArgs) {

    if ((executeQueryEventArgs.parameters.imei == null || executeQueryEventArgs.parameters.imei == "") && (executeQueryEventArgs.parameters.official == null || executeQueryEventArgs.parameters.official == "")) {
        executeQueryEventArgs.commons.messageHandler.showTranslateMessagesError('MBILE.MSG_MBILE_NOSEHAILD_62966');        
        executeQueryEventArgs.commons.execServer = false;
    } else {
        executeQueryEventArgs.commons.execServer = true;
    }

};

//Entity: Mobile
//Mobile. (Button) View: MobileManagementForm

task.gridRowCommand.VA_GRIDROWCOMMMNAN_851846 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = true;
    gridRowCommandEventArgs.commons.serverParameters.none = true;

    //gridRowCommandEventArgs.commons.serverParameters.Mobile = true;
};

//Entity: Mobile
    //Mobile. (Button) View: MobileManagementForm
    
    task.gridRowCommandCallback.VA_GRIDROWCOMMMNAN_851846 = function(  entities, gridRowCommandCallbackEventArgs ) {

    gridRowCommandCallbackEventArgs.commons.execServer = false;
    
        if (gridRowCommandCallbackEventArgs.success) {
            gridRowCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('MBILE.MSG_MBILE_SEHAGUALT_30818', '', 2000, false);
        }
        
    };

//Entity: MobileFilter
    //MobileFilter.usuario (ComboBox) View: MobileManagementForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_USUARIOWWQAXUFI_984846 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.MobileFilter = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: MobileManagementForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
        if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Mobile', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Mobile', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
       /* onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONARDXFFJ_694846', 'FindMobile', undefined, true, false, 'VC_MOBILEMATM_689502', false);*/
      }
        
    };

//gridRowDeleting QueryView: QV_5973_95309
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_5973_95309 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.Mobile = true;
        };

//gridRowDeleting QueryView: QV_5973_95309
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeletingCallback.QV_5973_95309 = function (entities,gridRowDeletingCallbackEventArgs) {
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            
        };



}));