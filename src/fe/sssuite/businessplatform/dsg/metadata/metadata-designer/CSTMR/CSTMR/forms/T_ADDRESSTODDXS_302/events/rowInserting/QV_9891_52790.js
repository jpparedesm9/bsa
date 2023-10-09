//gridRowInserting QueryView: QV_9891_52790
//Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
task.gridRowInserting.QV_9891_52790 = function (entities, gridRowInsertingEventArgs) {
    var api = gridRowInsertingEventArgs.commons.api;
    
    if(gridRowInsertingEventArgs.rowData.phoneType == ''){
    
    }
    if (gridRowInsertingEventArgs.rowData.phoneType == ''){
        gridRowInsertingEventArgs.commons.execServer = false;
        gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
        removedFromApi=true;
        gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_INGRESAOO_57765'));
    }
    if (gridRowInsertingEventArgs.rowData.phoneNumber == ''){
        gridRowInsertingEventArgs.commons.execServer = false;
        gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
        removedFromApi=true;
        gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_INGRESAEL_32500'));
    }
    else{
        
        if(entities.PhysicalAddress.addressId==0){
            gridRowInsertingEventArgs.commons.execServer = false;
            gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_PARAPODRR_49279'));
            gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
            removedFromApi=true;
        }else{
            gridRowInsertingEventArgs.commons.execServer = true;
            gridRowInsertingEventArgs.commons.serverParameters.Phone = true;
            gridRowInsertingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
            gridRowInsertingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
        }
    }
};