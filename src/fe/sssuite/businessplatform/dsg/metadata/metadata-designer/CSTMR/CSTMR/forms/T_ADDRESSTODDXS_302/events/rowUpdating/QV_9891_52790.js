//gridRowUpdating QueryView: QV_9891_52790
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9891_52790 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            gridRowUpdatingEventArgs.commons.serverParameters.Phone = true;
            gridRowUpdatingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
            gridRowUpdatingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
        };