//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanSearchForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
         entities.LoanSearchFilter.groupSummary='N'
    };