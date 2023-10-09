//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoadExternalAdvisor
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');
    };