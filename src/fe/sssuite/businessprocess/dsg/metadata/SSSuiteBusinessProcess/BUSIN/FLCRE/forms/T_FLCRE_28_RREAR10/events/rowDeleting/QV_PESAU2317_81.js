//gridRowDeleting QueryView: GridPersonalGuarantor
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_PESAU2317_81 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            
        };