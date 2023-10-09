//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CollectiveAdvisorsRoles
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.grid.refresh("QV_7238_33339");
    };