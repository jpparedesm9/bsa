//gridRowRendering QueryView: QV_4851_97960
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_4851_97960 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_4851_97960', 'create');

    if (gridRowRenderingEventArgs.rowData.directionNumberInternal == -1) {
        gridRowRenderingEventArgs.rowData.directionNumberInternal = 0;
    }

    if (screenMode == 'Q') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        var dsAddress = entities.PhysicalAddress.data();
        for (var i = 0; i < dsAddress.length; i++) {
            var dsRow = dsAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_4851_97960', dsRow, 'edit');
        }

        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');

        var dsVirtualAddress = entities.VirtualAddress.data();
        for (var i = 0; i < dsVirtualAddress.length; i++) {
            var dsRow = dsVirtualAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'edit');
        }
    }

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', gridRowRenderingEventArgs.rowData, 'delete');
    }

};