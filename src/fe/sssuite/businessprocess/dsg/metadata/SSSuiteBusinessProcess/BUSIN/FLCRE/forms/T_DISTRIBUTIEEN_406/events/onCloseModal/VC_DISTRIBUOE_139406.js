//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: undefined
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    onCloseModalEventArgs.commons.execServer = false;
    // onCloseModalEventArgs.commons.serverParameters.entityName = true;
};