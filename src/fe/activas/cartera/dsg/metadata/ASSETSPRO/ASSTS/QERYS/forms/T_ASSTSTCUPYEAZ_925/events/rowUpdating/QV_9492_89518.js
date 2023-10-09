//gridRowUpdating QueryView: QV_9492_89518
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9492_89518 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            if(gridRowUpdatingEventArgs.rowData.officerReassignedId == gridRowUpdatingEventArgs.rowData.officerAssignedId){
                gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ERRORNOSI_38798");
                gridRowUpdatingEventArgs.commons.execServer = false;
                gridRowUpdatingEventArgs.rowData.officerReassignedId = null;
            }
        };