//gridRowRendering QueryView: QV_6359_40398
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6359_40398 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if(screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6359_40398', 'create');        
        var dsBusiness = entities.Business.data();
        for (var i = 0; i < dsBusiness.length; i++) {   
            var dsRow = dsBusiness[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6359_40398', dsRow, 'delete');   
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_6359_40398', dsRow, 'edit');
        }
        
    }
            
};