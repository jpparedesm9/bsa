//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CreditCandidates
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.changeImageChecker(entities, renderEventArgs);
    };