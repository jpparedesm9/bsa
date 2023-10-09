//gridBeforeEnterInLineRow QueryView: QV_4137_63627
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_4137_63627 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXLDM_787904');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_4137_63627', 'file');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_4137_63627', 'uploaded');
        };