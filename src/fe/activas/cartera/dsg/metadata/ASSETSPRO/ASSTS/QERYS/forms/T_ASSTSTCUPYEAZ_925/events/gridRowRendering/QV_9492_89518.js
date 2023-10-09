//gridRowRendering QueryView: QV_9492_89518
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_9492_89518 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            var i = gridRowRenderingEventArgs.rowIndex;
            if(entities.CreditCandidates.data()[i].officerReassignedId == 0){
                entities.CreditCandidates.data()[i].officerReassignedId = null;
            }
        };