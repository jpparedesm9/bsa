//gridRowRendering QueryView: undefined
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_6397_58590 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            //Funcionalidad para habilitar o deshabilitar el botón de descarga
            if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
				gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
			}else{
              //cambiar esto has corregir error de uid en gridRowUpdating
                gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
				gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
			}
            
            //Ocultar y desocultar columnas
			gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'file');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'uploaded');
        };