//gridAfterLeaveInLineRow QueryView: QV_3983_71432
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_3983_71432 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_3983_71432');
            
        };