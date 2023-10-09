//gridBeforeEnterInLineRow QueryView: QV_7463_28553
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_7463_28553 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXTFB_124611');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'file');
	    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'uploaded');
        };