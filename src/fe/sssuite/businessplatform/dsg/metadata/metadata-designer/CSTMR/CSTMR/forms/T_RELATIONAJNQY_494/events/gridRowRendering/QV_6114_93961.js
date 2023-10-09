//gridRowRendering QueryView: QV_6114_93961
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6114_93961 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if (screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6114_93961', 'create'); 
        var dsRelation = entities.RelationPerson.data();
        for (var i = 0; i < dsRelation.length; i++) {   
            var dsRow = dsRelation[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6114_93961', dsRow, 'delete');            
        }
    
    }
            
};