//gridRowRendering QueryView: QV_7463_28553
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7463_28553 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.viewState.enable('G_SCANNEDCIM_218611');

	if (typeRequest != CSTMR.CONSTANTS.TypeRequest.NORMAL){ //caso#162288
        gridRowRenderingEventArgs.commons.api.viewState.hide('VA_VABUTTONILJIEMT_921611');	
	}
	
    //Funcionalidad para habilitar o deshabilitar el botÃ³n de descarga
    if (gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null) {
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    } else {
        //cambiar esto has corregir error de uid en gridRowUpdating
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
        gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    }
    //Ocultar y desocultar columnas
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'customerName');
    gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'uploaded');
    if (angular.isDefined(gridRowRenderingEventArgs.commons.api.vc.parentVc)) {
        //aprobacion de prestamo
        //gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'cmdEdition');
    }
    
    if(screenMode == 'Q'){ //caso#162288 --se cambio el mode que estaba del caso 162288 a screenMode por problemas en pantalla   
        var ds = entities.ScannedDocumentsDetail.data();
        for (var i = 0; i < ds.length; i++) {   
            var dsRow = ds[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', dsRow, 'edit');            
        }
    }

    if (screenMode != 'Q' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        if (entities.Person.statusCode == 'A' && entities.Context.roleEnabledDataModRequest != 'S' && gridRowRenderingEventArgs.rowData.documentId == '010') {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611');
        }
    }
};