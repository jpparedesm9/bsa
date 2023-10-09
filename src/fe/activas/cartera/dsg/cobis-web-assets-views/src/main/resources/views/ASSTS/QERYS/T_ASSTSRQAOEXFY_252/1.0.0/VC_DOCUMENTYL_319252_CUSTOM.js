/* variables locales de T_ASSTSRQAOEXFY_252*/
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

    
        var task = designerEvents.api.querydocumentscycle;
    

    //"TaskId": "T_ASSTSRQAOEXFY_252"
function loadFindCustomer(nav,textInputName){
    nav.label = 'B\u00FAsqueda de Clientes';
    nav.customAddress = {
        id: 'findCustomer',
        url: '/customer/templates/find-customers-tpl.html'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                          }];
    nav.customDialogParameters = {
        mode: "findCustomer",
        controlName: textInputName
    };
    nav.modalProperties = {
        size: 'lg'
    };
};

    //showGridRowDetailIcon QueryView: QV_9533_13855
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_9533_13855 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

//DocumentsQuery Entity: 
    task.executeQuery.Q_DOCUMETN_9533 = function(executeQueryEventArgs){
        executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//gridInitDetailTemplate QueryView: QV_9533_13855
        //
        task.gridInitDetailTemplate.QV_9533_13855 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            //gridInitDetailTemplate
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

            nav.address = {
                moduleId: 'ASSTS',
                subModuleId: 'QERYS',
                taskId: 'T_ASSTSNTIMXUPV_411',
                taskVersion: '1.0.0',
                viewContainerId: 'VC_DOCUMENTSS_852411'
            };
            nav.queryParameters = {
                mode: 8
            };
            nav.customDialogParameters = {
                processInstance: gridInitDetailTemplateEventArgs.modelRow.processInstance,
                groupId: gridInitDetailTemplateEventArgs.modelRow.groupId,
                cycle: gridInitDetailTemplateEventArgs.modelRow.groupCycle,
                loan: gridInitDetailTemplateEventArgs.modelRow.loan
            };

            nav.openDetailTemplate('QV_9533_13855', gridInitDetailTemplateEventArgs.modelRow);
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryDocumentsCycle
    task.initData.VC_DOCUMENTYL_319252 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXFVY_775645');
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXLVP_311645');
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXKOK_630645');
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: QueryDocumentsCycle
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.params != undefined){
            if(onCloseModalEventArgs.result.params.controlName == "cliente"){
                entities.HeaderQueryDocuments.clientName = onCloseModalEventArgs.result.selectedData.name;
                entities.HeaderQueryDocuments.clientId=onCloseModalEventArgs.result.selectedData.code;
            }
            if(onCloseModalEventArgs.result.params.controlName == "grupo"){
                entities.HeaderQueryDocuments.groupName = onCloseModalEventArgs.result.selectedData.name;
                entities.HeaderQueryDocuments.groupId = onCloseModalEventArgs.result.selectedData.code;
            }
        }
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXFVY_775645 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"cliente");
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.groupName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXHUA_684645 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"grupo");
        
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXFVY_775645 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.groupName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXHUA_684645 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));