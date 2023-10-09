/* variables locales de T_LOANSTATUSNGH_840*/
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

    
        var task = designerEvents.api.loanstatuschangeform;
    

    /*"TaskId": "T_LOANSTATUSNGH_840",*/
    //Your code here

    //Entity: Loan
    //Loan.newStatus (ComboBox) View: LoanStatusChangeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NEWSTATUSLZHCOE_110722 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
		loadCatalogDataEventArgs.commons.api.vc.parentVc.customDialogParameters.otherParam = {OPERATIONTYPEID:loadCatalogDataEventArgs.commons.api.vc.model.Loan.operationTypeID,STATUS:loadCatalogDataEventArgs.commons.api.vc.model.Loan.status}
		
		//loadCatalogDataEventArgs.commons.api.vc.model Object {Entity4: Object}
    };



}));