//gridRowSelecting QueryView: QV_1987_24851
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1987_24851 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        var selectedAccount = gridRowSelectingEventArgs.rowData;
        gridRowSelectingEventArgs.commons.api.vc.closeModal(selectedAccount);
    };