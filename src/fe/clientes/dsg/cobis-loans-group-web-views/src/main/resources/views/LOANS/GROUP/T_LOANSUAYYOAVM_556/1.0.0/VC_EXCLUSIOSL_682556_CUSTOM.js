/* variables locales de T_LOANSUAYYOAVM_556*/

 
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

    
        var task = designerEvents.api.exclusionlist;
    

    //"TaskId": "T_LOANSUAYYOAVM_556"


    //Entity: CustomerExclusionList
    //CustomerExclusionList.customerName (TextInputButton) View: ExclusionList
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_1DMKLRVJHUHQTTF_212111 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
                

    if(changedEventArgs.newValue == ""){
       entities.CustomerExclusionList.customerId =null;
       }
        
    };

//Entity: CustomerExclusionList
    //CustomerExclusionList. (Button) View: ExclusionList
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONARFKGXV_821111 = function(  entities, executeCommandEventArgs ) {

    if (entities.CustomerExclusionList.customerId == '' && entities.CustomerExclusionList.score == '' ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.viewState.refreshData('VA_SCORENCQIGXRWIM_712111')
    }else{
        executeCommandEventArgs.commons.execServer = true; 
    }
        
    
   // executeCommandEventArgs.commons.api.grid.refresh("QV_9905_87019",{customerId:entities.CustomerExclusionList.customerId});
        //executeCommandEventArgs.commons.serverParameters.CustomerExclusionList = true;
    };

//Entity: Entity1
    //Entity1. (Button) View: ExclusionList
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONCMTSGNP_601111 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = false; 
        
        executeCommandEventArgs.commons.api.grid.refresh('QV_9905_87019', {customerId:entities.CustomerExclusionList.customerId});
    
    };

//undefined Entity: 
    task.executeQuery.Q_EXCLUSIR_9905 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ExclusionList
    task.initData.VC_EXCLUSIOSL_682556 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.CustomerExclusionList.score= "E";
        //initDataEventArgs.commons.api.viewState.disable('VA_1DMKLRVJHUHQTTF_212111');
        
    };

//Entity: Entity1
    //Entity1.attribute1 (TextInputButton) View: ExclusionList
    
    task.textInputButtonEvent.VA_1DMKLRVJHUHQTTF_212111 = function( textInputButtonEventArgs ) {

       textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js",
                 //"/customer/services/find-program-srv.js",
                   "/customer/controllers/find-customers-ctrl.js"]
         }];
        
        nav.customDialogParameters = {
        
        };    
    };

    task.closeModalEvent.findCustomer = function (args) {        
        var resp = args.commons.api.vc.dialogParameters;
		var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
		var CustomerName=  args.commons.api.vc.dialogParameters.customerType ==='C'?args.commons.api.vc.dialogParameters.commercialName:args.commons.api.vc.dialogParameters.name;
		var identification= args.commons.api.vc.dialogParameters.documentId;
		args.model.CustomerExclusionList.customerName  = customerCode +"-"+ CustomerName;
		args.model.CustomerExclusionList.customerId  = customerCode; 
        //args.model.Member.qualification='AMARILLO'
        //args.commons.api.vc.executeCommand('VA_1DMKLRVJHUHQTTF_212111', 'FindCustomer', undefined, true, false, 'VC_EXCLUSIOSL_682556', false);
     
    };

//gridRowDeleting QueryView: QV_9905_87019
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9905_87019 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.ExclusionListResult = true;
        };

//gridRowInserting QueryView: QV_9905_87019
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_9905_87019 = function (entities,gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = true;
            //gridRowInsertingEventArgs.commons.serverParameters.ExclusionListResult = true;
        };



}));