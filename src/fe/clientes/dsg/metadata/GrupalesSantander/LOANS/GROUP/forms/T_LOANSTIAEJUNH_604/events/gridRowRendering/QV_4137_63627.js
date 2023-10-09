//gridRowRendering QueryView: QV_4137_63627
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_4137_63627 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            //Funcionalidad para habilitar o deshabilitar el botón de descarga
            if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
				gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_4137_63627',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAA_412904','disabled',false);
			}else{
              //cambiar esto has corregir error de uid en gridRowUpdating
                gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_4137_63627',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAA_412904','disabled',false);
				gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_4137_63627',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAA_412904','disabled',false);
			}
            
            //Ocultar y desocultar columnas
			gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_4137_63627', 'file');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_4137_63627', 'uploaded');
        };