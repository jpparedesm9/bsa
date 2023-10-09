//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ProjectionQuotaFormMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        entities.ProjectionQuota.typeCalculation = 'S';
        var api = renderEventArgs.commons.api;
        api.vc.viewState.VA_TIPOUWNWJMGVYCI_648517.disabled = false;
        ASSETS.Header.setDataStyle("VC_PROJECTIIU_405244", "VC_XAGJYCIGBI_296244", entities, renderEventArgs);
    };