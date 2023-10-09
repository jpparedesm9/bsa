//gridRowSelecting QueryView: GridAmortizationTable
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QUYOI3312_16 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            entities.PaymentPlan.selectingQuotaIndex = gridRowSelectingEventArgs.rowIndex;
        };