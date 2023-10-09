//gridRowInserting QueryView: GridCustomer
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_QRYLI5474_83 = function (entities, gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = false;
            FLCRE.UTILS.CUSTOMER.removeEmptyCustomerByCode(entities, gridRowInsertingEventArgs, 0);
            var lastClientId = gridRowInsertingEventArgs.rowData.CustomerId;
            FLCRE.UTILS.CUSTOMER.removeDuplicateCustomerByCode(entities, gridRowInsertingEventArgs, lastClientId);
            
        };