//gridRowRendering QueryView: QV_9303_67123
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_9303_67123 = function (entities, gridRowRenderingEventArgs) {

    gridRowRenderingEventArgs.commons.execServer = false;
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_9303_67123', 'create');

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'delete');

        if (posDataModRequest != null) {
            if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || entities.Context.roleEnabledDataModRequest != 'S' || entities.Context.mailState != 'N') {
                gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S' && entities.Context.mailState == 'N') {
                gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            }
        }
    }
    
    var grid = gridRowRenderingEventArgs.commons.api.grid;
    if(entities.CustomerTmp.paramVamail == 'S'){
        grid.addCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);
        grid.removeCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);

    } else {
        grid.addCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);
    }

};