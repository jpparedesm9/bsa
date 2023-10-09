//gridRowRendering QueryView: QV_7978_25243
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7978_25243 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//ocultar lupa
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        if (stage == LOANS.CONSTANTS.Stage.INGRESO || stage == LOANS.CONSTANTS.Stage.APROBAR || stage == LOANS.CONSTANTS.Stage.ELIMINAR) {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla en la etapa de ingreso PXSG
			gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'delete');//Se oculta boton de Eliminar enla etapa de ingreso PXSG
            
        }
        if (stage == 'APROBAR') {
		    gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData,      'delete');
            //ocultar columnas vacias
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','cmdEdition');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//mostrar lupa
	   }
    }
};