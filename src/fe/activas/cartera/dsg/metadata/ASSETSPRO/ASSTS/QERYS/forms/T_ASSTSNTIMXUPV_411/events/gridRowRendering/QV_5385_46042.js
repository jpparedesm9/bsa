//gridRowRendering QueryView: QV_5385_46042
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_5385_46042 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
	
    if (gridRowRenderingEventArgs.rowData.enableEditing != 'S')
    	gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_5385_46042','cmdEdition');

    //Funcionalidad para habilitar o deshabilitar el botón de descarga
	if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
	}else{
      //cambiar esto has corregir error de uid en gridRowUpdating
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
	}
};