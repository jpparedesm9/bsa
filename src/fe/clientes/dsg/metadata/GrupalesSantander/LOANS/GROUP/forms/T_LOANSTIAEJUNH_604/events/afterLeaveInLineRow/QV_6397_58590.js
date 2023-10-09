//gridAfterLeaveInLineRow QueryView: QV_6397_58590
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_6397_58590 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'uploaded');
        };