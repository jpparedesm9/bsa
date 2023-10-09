//gridRowRendering QueryView: QV_7269_22799
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7269_22799 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    if(screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_7269_22799', 'create');               
        var dsRef = entities.References.data();
        for (var i = 0; i < dsRef.length; i++) {   
            var dsRow = dsRef[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7269_22799', dsRow, 'delete');   
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_7269_22799', dsRow, 'edit');
        }
    }
            
};