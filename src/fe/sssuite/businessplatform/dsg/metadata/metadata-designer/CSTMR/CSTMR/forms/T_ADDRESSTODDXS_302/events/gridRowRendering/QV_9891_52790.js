//gridRowRendering QueryView: QV_9891_52790
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_9891_52790 = function (entities, gridRowRenderingEventArgs) {

    gridRowRenderingEventArgs.commons.execServer = false;
    var scannedDocumentsDetailList = gridRowRenderingEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = gridRowRenderingEventArgs.commons.api.vc.parentVc.model.Context;

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }

    if (parameters != null && parameters.modo != 'Q' && gridRowRenderingEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9891_52790', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'delete');

        if (posDataModRequest != null && entities.PhysicalAddress.addressType == 'RE') {
            if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || context.roleEnabledDataModRequest != 'S' || context.addressState != 'N') {
                gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'edit');

            } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && context.addressState == 'N') {
                gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'edit');
            }
        }
    }
    
    var grid = gridRowRenderingEventArgs.commons.api.grid;
    if(entities.PhysicalAddress.paramVASMS == 'S'){
        grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
        grid.removeCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);

    } else {
        grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
    }
    
    if(gridRowRenderingEventArgs.rowData.phoneType != 'C'){
        grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436');
    }

};