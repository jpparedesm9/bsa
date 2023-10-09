/* variables locales de T_BSSNSKNPPLXIB_479*/
var taskHeader = {};
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

    
        var task = designerEvents.api.generalbusinessdata;
    

    //"TaskId": "T_BSSNSKNPPLXIB_479"
var openFindCustomer = function (eventArgs) {
    var nav = eventArgs.commons.api.navigation;
    nav.label = cobis.translate('BSSNS.LBL_BSSNS_BSQUEDASL_68505');
    nav.customAddress = {
        id: "findCustomer",
        url: "/customer/templates/find-customers-tpl.html",
        module: "customer",
        useMinification: false
    };
    nav.scripts = {
        module: cobis.modules.CUSTOMER,
        files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.customDialogParameters = {
    };
    nav.openCustomModalWindow('findCustomer');

};

var callManualForm = function (eventArgs, customerId, groupId) {
    var nav = eventArgs.commons.api.navigation;
	var task = eventArgs.commons.api.vc.parentVc.model.InboxContainerPage.Task;
	var processInstance = eventArgs.commons.api.vc.parentVc.model.Task.processInstanceIdentifier;
    nav.customAddress = {
        id: "GeneralBusinessInformation",
        url: "/BSSNS/manual/GeneralBusinessInformation.html",
        module: "customer",
        useMinification: false
    };
    nav.scripts = {
        module: cobis.modules.CUSTOMER,
        files: ['/BSSNS/manual/controller/controler.js', '/BSSNS/manual/directives/PrincipalDirective.js', '/BSSNS/manual/services/business-customer-srv.js']
    };
    nav.customDialogParameters = {
        customerId: customerId,
        taskHeader: (angular.isDefined(nav.customDialogParameters.taskHeader) && nav.customDialogParameters.taskHeader !== null) ? taskHeader : {},
		task:		task,
		processInstance:processInstance
    };
    nav.registerCustomView(groupId);
}

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GeneralBusinessData
task.initData.VC_GENERALBSI_401479 = function (entities, initDataEventArgs) {
  initDataEventArgs.commons.execServer = false;
  var customDialogParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
  //Instancia de proceso
    entities.Customer.processInstance = (angular.isDefined(customDialogParameters) && customDialogParameters!==null && customDialogParameters.Task!==null) ? customDialogParameters.Task.processInstanceIdentifier : null;
    
    if(entities.Customer.processInstance!==null){
        initDataEventArgs.commons.execServer = true;
    }else{
        console.log("Error al obtener la instancia de proceso");
    }
    
    //openFindCustomer(initDataEventArgs);
    //entities.Customer.customerId = 5;

};

//Start signature to Callback event to VC_GENERALBSI_401479
task.initDataCallback.VC_GENERALBSI_401479 = function(entities, initDataCallbackEventArgs) {
    if(initDataCallbackEventArgs.success && angular.isDefined(entities.Customer) && entities.Customer!==null){
       //Cabecera
        var firstName = entities.Customer.customerName;
        var secondName = entities.Customer.customerSecondName;
        var lastName = entities.Customer.customerLastName;
        var secondLastName = entities.Customer.customerSecondLastName;
        var fullName = entities.Customer.customerFullName;
        var customerCompleteName = null;
        
        if(fullName!==null){
           customerCompleteName = fullName;
           }else{
               if(firstName!==null){
                  customerCompleteName = firstName;
                  }
               if (secondName!==null){
                   customerCompleteName += " " + secondName;
               }
               if (lastName!==null){
                   customerCompleteName += " " + lastName;
               }
               if (secondLastName!==null){
                   customerCompleteName += " " + secondLastName;
               }
           }
        
        
        BSSNS.INBOX.addTaskHeader(taskHeader, 'title', customerCompleteName.toUpperCase(), 0);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.Customer.identificationType!==null ? entities.Customer.identificationType : "", 1);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.Customer.customerIdentification!==null ? entities.Customer.customerIdentification : "", 1);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.Customer.customerId!==null ? entities.Customer.customerId : "", 2);
        			
        BSSNS.INBOX.updateTaskHeader(taskHeader, initDataCallbackEventArgs, 'G_GENERALSSA_700568'); 
        
        
        //Invocacion pantalla manual
        callManualForm(initDataCallbackEventArgs,entities.Customer.customerId,'G_GENERALUSS_474568');
    }
    
   
     
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: GeneralBusinessData
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;
    console.log("Ingresa a onCloseModalEvent");
    
};



}));