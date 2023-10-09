/* variables locales de T_LOANSCDNOQLVK_282*/
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

    
        var task = designerEvents.api.memberrisklevelform;
    

    //"TaskId": "T_LOANSCDNOQLVK_282"
function openFindCustomer(nav){
      nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer'
            , url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER
            , files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                              }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
}

function setHeaderForm(customerData, eventArgs){    
    var taskHeader={};          
    LATFO.INBOX.addTaskHeader(taskHeader, 'title', customerData.name, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', customerData.documentType, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', customerData.documentId, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', customerData.code, 2);
	LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_MEMBERRLIL_519911');  
}

    //QualificationResultQuery Entity: 
    task.executeQuery.Q_QUALIFEL_7416 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//QualificationRangeQuery Entity: 
    task.executeQuery.Q_QUALIFTC_2992 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//RiskLevelQuery Entity: 
    task.executeQuery.Q_RISKLELL_4750 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MemberRiskLevelForm
    task.initData.VC_MEMBERRILV_790282 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var nav = initDataEventArgs.commons.api.navigation;
        openFindCustomer(nav);
        
    };

//Start signature to Callback event to VC_MEMBERRILV_790282
task.initDataCallback.VC_MEMBERRILV_790282 = function(entities, initDataCallbackEventArgs) {
//here your code
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: MemberRiskLevelForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = true;    
        var customerData = onCloseModalEventArgs.result.selectedData;
        entities.Member.customerId = customerData.code;        
        setHeaderForm(customerData, onCloseModalEventArgs);       
    };

//Start signature to Callback event to VC_MEMBERRILV_790282
task.onCloseModalEventCallback = function(entities, onCloseModalCallbackEventArgs) {
//here your code
};



}));