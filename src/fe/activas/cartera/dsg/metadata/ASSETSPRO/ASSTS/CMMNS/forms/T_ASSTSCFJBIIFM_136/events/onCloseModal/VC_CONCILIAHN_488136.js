//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ConciliationSearchForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
        onCloseModalEventArgs.commons.execServer = false;
    if (onCloseModalEventArgs.closedViewContainerId == "findCustomer") {
        var resp = onCloseModalEventArgs.result.selectedData;
        var title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';

        if (resp != null) {
            entities.ConciliationSearchFilter.customerCode = resp.code;
            entities.ConciliationSearchFilter.customerType = resp.customerType;

            switch (resp.customerType) {
            case 'P':
                title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
                break;
            case 'C':
                title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
                break;
            case 'S':
                title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
                break;
            case 'G':
                title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
                break;
            }
        }

        onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMERCODEVGG_397314", title);
    } else {
        var grid = onCloseModalEventArgs.commons.api.grid;
        grid.refresh('QV_9564_85454');
    }

};