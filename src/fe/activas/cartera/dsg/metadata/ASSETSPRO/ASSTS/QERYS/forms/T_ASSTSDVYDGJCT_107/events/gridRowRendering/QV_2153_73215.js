//gridRowRendering QueryView: QV_2153_73215
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_2153_73215 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

	if (gridRowRenderingEventArgs.rowData.enableEditing != 'S')
    	gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_2153_73215','cmdEdition');//

    //Funcionalidad para habilitar o deshabilitar el botón de descarga
	if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
	}else{
      //cambiar esto has corregir error de uid en gridRowUpdating
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
	}
};