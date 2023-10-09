/* variables locales de T_LOANDETAILPPP_874*/
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

    
        var task = designerEvents.api.loandetailpopupform;
    

    //"TaskId": "T_LOANDETAILPPP_874"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanDetailPopupForm
    task.initData.VC_LOANDETAUL_310874 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var customParams = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		entities.Loan = customParams.Loan;
		$("#VA_VASIMPLELABELLL_441816").parent().parent().parent().find(".control-label").remove();//Delete title label
		entities.Loan.startDate = kendo.toString(entities.Loan.startDate, "d");
		entities.Loan.endDate = kendo.toString(entities.Loan.endDate, "d");
		entities.Loan.feeEndDate = kendo.toString(entities.Loan.feeEndDate, "d")
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanDetailPopupForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
    };



}));