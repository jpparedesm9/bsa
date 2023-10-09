/* variables locales de T_ASSTSCXBWUFVI_696*/
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

    
        var task = designerEvents.api.precancellationloanreference;
    

    //"TaskId": "T_ASSTSCXBWUFVI_696"
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
    args.model.Loan.clientName = customerCode + " - " + CustomerName;
    args.model.Loan.clientID = customerCode;
    
    //Limpiar cajas de texto antes de buscar
    args.model.PreCancellation.amountOP= '';
    args.model.PreCancellation.amountPRE ='';
    args.model.PreCancellation.isInsurenceChanged=false;
    args.model.PreCancellation.amountInsurence='';
    
};

    // (Button) 
    task.executeCommand.CM_TASSTSCX_S1_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
        if (entities.Loan.clientID == null)
        {
          executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ESNECESNI_47620", true);
        }else
        {
            var itemReporte = "PreCancellation";
            var args = [['clientID', entities.Loan.clientID],  ['amountPRE', entities.PreCancellation.amountPRE]]
            var tittle = cobis.translate('ASSTS.LBL_ASSTS_REFERENIN_30495');
	   	   ASSETS.Utils.generarReporte (itemReporte, args, tittle);
        }
    };

// (Button) 
    task.executeCommand.CM_TASSTSCX__8X = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
    };

// (Button) 
    task.executeCommandCallback.CM_TASSTSCX__8X = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        
    };

//Entity: Loan
//Loan. (Button) View: PreCancellationLoanReference
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONTGCIJOQ_898796 = function (entities, executeCommandEventArgs) {
    if (entities.Loan.clientID != null) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.api.viewState.enable("CM_TASSTSCX__8X");
        executeCommandEventArgs.commons.api.viewState.enable("CM_TASSTSCX_S1_");
    }
    else{
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ESNECESNI_47620", true);
    }
};

//Entity: Loan
//Loan. (Button) View: PreCancellationLoanReference
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommandCallback.VA_VABUTTONTGCIJOQ_898796 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    if (entities.PreCancellation.amountPRE == null || entities.PreCancellation.amountOP == null || entities.PreCancellation.amountPRE == '' || entities.PreCancellation.amountOP == '') {
        executeCommandEventArgs.commons.api.viewState.disable("CM_TASSTSCX__8X");
        executeCommandEventArgs.commons.api.viewState.disable("CM_TASSTSCX_S1_");
        executeCommandEventArgs.commons.messageHandler.showMessagesError("No existe registro para el Cliente ingresado", true);
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PreCancellationLoanReference
    task.initData.VC_PRECANCETA_713696 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
    };

//Entity: PreCancellation
    //PreCancellation.clientName (TextInputButton) View: PreCancellationLoanReference
    
    task.textInputButtonEvent.VA_CLIENTNAMESZXPR_236796 = function( textInputButtonEventArgs ) {

     textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
    nav.customAddress = {
        id: "findCustomer"
        , url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER
        , files: ["/customer/services/find-customers-srv.js"
             , "/customer/controllers/find-customers-ctrl.js"]
      }];
    nav.customDialogParameters = {};
        
    };

//Entity: Loan
    //Loan.clientName (TextInputButton) View: PreCancellationLoanReference
    
    task.textInputButtonEventGrid.VA_CLIENTNAMESZXPR_236796 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PreCancellationLoanReference
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        document.getElementById('VA_CLIENTNAMESZXPR_236796').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSCX__8X");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSCX_S1_"); 
        
    };



}));