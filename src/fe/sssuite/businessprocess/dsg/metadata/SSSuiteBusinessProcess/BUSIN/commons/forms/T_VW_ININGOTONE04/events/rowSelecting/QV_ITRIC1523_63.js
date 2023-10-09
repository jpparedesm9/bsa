//gridRowSelecting QueryView: GridRefinancingOperations
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_ITRIC1523_63 = function(entities, gridRowSelectingEventArgs) {
    	// Selecciono las operaciones de la grilla de operaciones
    	entities.SelectedOperations = gridRowSelectingEventArgs.commons.api.grid.getSelectedRows('QV_ITRIC1523_63');
        gridRowSelectingEventArgs.commons.execServer = false;
    };