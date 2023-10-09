//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ConciliationManualSearchForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    var grid = onCloseModalEventArgs.commons.api.grid;
    
    if (onCloseModalEventArgs.closedViewContainerId == "findCustomer") {
        onCloseModalEventArgs.commons.execServer = false;
        
        var resp = onCloseModalEventArgs.result.selectedData;
        var title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';

        if (resp != null) {
            entities.ConciliationManualSearchFilter.customCode = resp.code;
            entities.ConciliationManualSearchFilter.customType = resp.customerType;

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
        onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMCODEETRCB_211547", title);
        
    } else if (onCloseModalEventArgs.closedViewContainerId == "VC_CONCILIAAA_437806") {
        onCloseModalEventArgs.commons.execServer = true;
        
        var dialogCloseResult = onCloseModalEventArgs.dialogCloseResult;
        var result = onCloseModalEventArgs.result;
        
        if (dialogCloseResult == 1) {
            onCloseModalEventArgs.commons.execServer = false;
            grid.refresh('QV_9498_31225');
        }else if (dialogCloseResult == undefined && result == true) {
            onCloseModalEventArgs.commons.execServer = false;
            grid.refresh('QV_9498_31225');
        }else{
            entities.ConciliationManualSearchFilter.observation = result;
            /*var listConciliationManual = entities.ConciliationManualSearch.data();
            listConciliationManual.forEach(function(row) {
                if (row.isSelected) {
                    row.observation = result;
                }
            });*/
        }
        
    } else {
        grid.refresh('QV_9498_31225');
    }
};