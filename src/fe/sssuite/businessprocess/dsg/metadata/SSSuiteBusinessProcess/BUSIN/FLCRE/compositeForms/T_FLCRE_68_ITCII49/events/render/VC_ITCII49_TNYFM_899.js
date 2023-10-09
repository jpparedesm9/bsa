//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PrintingActivity
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.showButtons(renderEventArgs)
        BUSIN.API.changeImageChecker(entities, renderEventArgs);
    };