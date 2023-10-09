//gridBeforeEnterInLineRow QueryView: Borrowers
    //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function (entities, gridBeforeEnterInLineRowEventArgs) {
        gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
        
    };