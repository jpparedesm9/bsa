//gridRowDeleting QueryView: QV_9891_52790
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9891_52790 = function (entities, gridRowDeletingEventArgs) {
            if(!removedFromApi){
                gridRowDeletingEventArgs.commons.execServer = true;
                gridRowDeletingEventArgs.commons.serverParameters.Phone = true;
                gridRowDeletingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
                gridRowDeletingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
            }else{
                gridRowDeletingEventArgs.commons.execServer = false;
                removedFromApi=false;
            }
        };