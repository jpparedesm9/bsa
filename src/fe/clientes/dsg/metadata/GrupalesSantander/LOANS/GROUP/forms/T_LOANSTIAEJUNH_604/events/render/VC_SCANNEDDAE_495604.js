//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ScannedDocumentsDetail
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'file');
        renderEventArgs.commons.api.grid.hideColumn('QV_4137_63627', 'file');
    };