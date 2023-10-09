//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LoanDisbursementMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };