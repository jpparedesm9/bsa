//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CustomerDataVerification
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        var ctr = ['IdCustomer', 'VerifyData', 'DateVerification', 'UserVerification', 'EffectiveDate'];
        BUSIN.API.GRID.addColumnsStyle('QV_QURRF6164_42', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
    };