//gridRowInserting QueryView: Borrowers
//Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
task.gridRowInserting.QV_BOREG0798_55 = function (entities, gridRowInsertingEventArgs) { // RowInserting
    // QueryView:								// Borrowers
    //SMO no debe lanzar
    gridRowInsertingEventArgs.commons.execServer = false;
    FLCRE.UTILS.CUSTOMER.removeEmptyDebtorByCode(entities, gridRowInsertingEventArgs, 0);
    //task.validateDebtor(entities, gridRowInsertingEventArgs); SMO no existe en grupales

    //Controla que no ingrese un deudor ya existente en la grilla
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var count = 0;
        var countDeudores = 0;
        for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
            var row = entities.DebtorGeneral.data()[i];
            if (row.CustomerCode == gridRowInsertingEventArgs.rowData.CustomerCode) {
                count++;
            }
        }
        if (count >= 2) {
            gridRowInsertingEventArgs.cancel = true;
            gridRowInsertingEventArgs.commons.execServer = false;

            if (!passInitData) {
                gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BOWREDYXT_24458');
                passInitData = false;
            }
        }
    }

};