//gridBeforeEnterInLineRow QueryView: QV_6397_58590
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_6397_58590 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXLEM_317904');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'file');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'uploaded');
        };