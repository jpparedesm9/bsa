/* variables locales de T_ASSTSHPXNSQZA_469*/
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

    
        var task = designerEvents.api.voucherpaymentmail;
    

    //"TaskId": "T_ASSTSHPXNSQZA_469"
   
   task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
       
       if (args.model.Group.groupId != groupCode)
       {
           args.model.Group.groupId = groupCode;
            args.model.Group.groupName = groupName;
           
            args.model.Group.loanBalance = null;
            args.model.Group.collateralBalance = null;
            args.model.Group.groupStatus = null;
            args.model.Group.loanBalCurrencyNem = null;
            args.model.Group.colBalCurrencyNem = null;
       
       
            args.model.ProcessInstance.instanceId = null;
            args.model.ProcessInstance.activityId = null;
            args.model.ProcessInstance.company = null;
            args.model.ProcessInstance.transactionNumber = null;
            args.commons.api.viewState.disable("CM_TASSTSHP_4SA");
            args.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
       
       }else{
            args.model.Group.groupName = groupName;
       }
    };
    

    // (Button) 
    task.executeCommand.CM_TASSTSHP_4SA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        if (entities.ProcessInstance.transactionNumber == null)
        {
          executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GRUPONOAO_46111", true);
        }else
        {
            var itemReporte = "GarantiaLiquida";
            var args = [['numTran', entities.ProcessInstance.transactionNumber]];
            var tittle = cobis.translate('ASSTS.LBL_ASSTS_FICHADEAN_46919');
	   	   ASSETS.Utils.generarReporte (itemReporte, args, tittle);
        }   
            
    };

// (Button) 
    task.executeCommand.CM_TASSTSHP_ZAX = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;      
        if (entities.ProcessInstance.transactionNumber != null){
            executeCommandEventArgs.commons.execServer = true;
        }else {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GRUPONOAO_46111", true);   
        }
        
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Entity: Group
    //Group. (Button) View: VoucherPaymentMail
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONFPBVJYH_744873 = function(  entities, executeCommandEventArgs ) {
            executeCommandEventArgs.commons.execServer = true;
    };

//Start signature to Callback event to VA_VABUTTONFPBVJYH_744873
task.executeCommandCallback.VA_VABUTTONFPBVJYH_744873 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    executeCommandCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSHP_4SA");
    executeCommandCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
    
    if (executeCommandCallbackEventArgs.success)
    {
        switch(entities.Group.collateralPaymentStatus) {
        case 'S':
            executeCommandCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSHP_4SA");
            executeCommandCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSHP_ZAX");      
            break;
        case 'N':
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GARANTAEO_91614", true);//GARANTÍA LÍQUIDA YA HA SIDO CANCELADA  
            break;
        case null:
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_DATOSGAUA_97282", true);//DATOS DE GARANTÍA LÍQUIDA NO REGISTRADOS
            break;
        default:
            break;
        }
    }
};

//Entity: Group
    //Group.groupId (TextInputButton) View: VoucherPaymentMail
    
    task.textInputButtonEvent.VA_1491XAAAAMJTPOU_128873 = function( textInputButtonEventArgs ) {

    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDARR_52528');
    nav.customAddress = {
        id: "findCustomer",
        url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ["/customer/services/find-customers-srv.js"
                                           , "/customer/controllers/find-customers-ctrl.js"]
        }];
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: VoucherPaymentMail
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		document.getElementById('VA_1491XAAAAMJTPOU_128873').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSHP_4SA");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
    };



}));