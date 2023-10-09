//gridRowSelecting QueryView: GrdWarrantyPolicies
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_ERWRL4097_89 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };