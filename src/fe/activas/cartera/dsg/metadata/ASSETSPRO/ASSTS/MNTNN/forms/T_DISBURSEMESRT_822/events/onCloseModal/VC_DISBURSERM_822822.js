//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: DisbursementReportsForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;    
    entities.DisbursementReports.code = onCloseModalEventArgs.result.resultArgs.code;
};