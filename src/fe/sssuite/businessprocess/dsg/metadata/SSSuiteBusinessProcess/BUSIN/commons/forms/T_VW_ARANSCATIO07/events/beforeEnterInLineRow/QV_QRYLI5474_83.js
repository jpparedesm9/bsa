//gridBeforeEnterInLineRow QueryView: GridCustomer
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_QRYLI5474_83 = function (entities, gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            var deleteNewRow = false;
            FLCRE.UTILS.CUSTOMER.openFindCustomer(entities, gridBeforeEnterInLineRowEventArgs, {}, deleteNewRow);
        };