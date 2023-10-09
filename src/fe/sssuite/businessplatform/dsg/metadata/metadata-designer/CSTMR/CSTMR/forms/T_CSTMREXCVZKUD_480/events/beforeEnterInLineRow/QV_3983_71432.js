//gridBeforeEnterInLineRow QueryView: QV_3983_71432
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_3983_71432 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.focus('VA_TEXTINPUTBOXWBE_947760');
            
        };