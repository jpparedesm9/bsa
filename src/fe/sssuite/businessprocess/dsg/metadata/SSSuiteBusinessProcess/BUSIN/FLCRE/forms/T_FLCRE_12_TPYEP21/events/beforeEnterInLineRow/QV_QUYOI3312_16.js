//gridBeforeEnterInLineRow QueryView: GridAmortizationTable
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_QUYOI3312_16 = function (entities, gridBeforeEnterInLineRowEventArgs) {
            if(entities.PaymentPlan.tableType !='MANUAL'){
                gridABeforeEnterInLineRowEventArgs.cancel=true;
            }else{
                gridABeforeEnterInLineRowEventArgs.cancel=false;
            }
             gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
            
        };