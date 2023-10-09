//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
    var tipo = renderEventArgs.commons.api.parentVc.model.OriginalHeader.ProductType;
    if (tipo == 'GRUPAL') {
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_SIGN784');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_SPRD943');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_VALU262');
        
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MIMM127');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MAXU405');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MUPE771');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_RNCU443');
    }
    };