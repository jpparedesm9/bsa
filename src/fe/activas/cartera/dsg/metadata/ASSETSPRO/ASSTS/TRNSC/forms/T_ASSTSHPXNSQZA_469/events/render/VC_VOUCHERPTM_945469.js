//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: VoucherPaymentMail
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		document.getElementById('VA_1491XAAAAMJTPOU_128873').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSHP_4SA");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
    };