//gridRowDeleting QueryView: GWarrantyDetail
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_WANTY5919_76 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            
        };