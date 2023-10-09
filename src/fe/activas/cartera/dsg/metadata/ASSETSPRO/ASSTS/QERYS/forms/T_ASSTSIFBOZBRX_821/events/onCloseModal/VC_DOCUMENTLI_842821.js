//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: QueryDocumentsByFilter
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;
    if (onCloseModalEventArgs.result.params != undefined) {
        entities.HeaderQueryDocuments.clientName = onCloseModalEventArgs.result.selectedData.name;
        entities.HeaderQueryDocuments.clientId = onCloseModalEventArgs.result.selectedData.code;
        entities.HeaderQueryDocuments.clientType = onCloseModalEventArgs.result.selectedData.customerType;

        if (entities.HeaderQueryDocuments.clientType == 'S' || entities.HeaderQueryDocuments.clientType == 'G') {
            onCloseModalEventArgs.commons.api.viewState.label("VA_CLIENTIDBZOEDEE_140698", "ASSTS.LBL_ASSTS_GRUPOOBAY_84995");
        } else {
            onCloseModalEventArgs.commons.api.viewState.label("VA_CLIENTIDBZOEDEE_140698", "ASSTS.LBL_ASSTS_CLIENTEWV_22561");
        }
    }

};