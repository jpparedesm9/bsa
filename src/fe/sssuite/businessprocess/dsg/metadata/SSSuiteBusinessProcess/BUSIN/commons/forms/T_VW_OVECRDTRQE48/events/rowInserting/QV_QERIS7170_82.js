//gridRowInserting QueryView: GridDistributionLine
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_QERIS7170_82 = function (entities, gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = false;
            
        };