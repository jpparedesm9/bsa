//gridRowRendering QueryView: QV_3671_84200
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_3671_84200 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            //Funcionalidad para habilitar o deshabilitar el botón de descarga
			if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
				gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAND_747831','disabled',false);
                gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMNNN_749831','disabled',false);
			}else{
              //cambiar esto has corregir error de uid en gridRowUpdating
				gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAND_747831','disabled',false);
				gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAND_747831','disabled',false);
                gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMNNN_749831','disabled',false);
				gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_3671_84200',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMNNN_749831','disabled',false);
			}
        };