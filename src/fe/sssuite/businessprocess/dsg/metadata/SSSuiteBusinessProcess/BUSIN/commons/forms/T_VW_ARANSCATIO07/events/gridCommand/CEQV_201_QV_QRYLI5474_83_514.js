//gridCommand (Button) QueryView: GridCustomer
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_QRYLI5474_83_514 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_QRYLI5474_83');
        var wPrincipal = selectedRow[0] != undefined ? selectedRow[0].Principal : false;
        if (FLCRE.UTILS.CUSTOMER.deleteCustomerGeneral(gridExecuteCommandEventArgs, true)) {
            gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_SGCSLERER_06336');
            //Si se eliminó el cliente principal, se marca el primer cliente del grid como principal
            if (wPrincipal) {
                task.setPrincipalCustomer(entities, gridExecuteCommandEventArgs);
            }
        }
    };