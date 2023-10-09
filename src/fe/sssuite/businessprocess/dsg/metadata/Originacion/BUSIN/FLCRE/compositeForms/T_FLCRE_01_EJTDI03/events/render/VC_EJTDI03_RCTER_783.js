//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RejectedApplication

    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.showButtons(renderEventArgs);
    };