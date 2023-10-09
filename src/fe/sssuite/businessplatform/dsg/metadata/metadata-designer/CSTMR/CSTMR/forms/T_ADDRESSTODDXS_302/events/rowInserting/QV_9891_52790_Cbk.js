//Start signature to callBack event to QV_9891_52790
    task.gridRowInsertingCallback.QV_9891_52790 = function(entities, gridRowInsertingEventArgs) {
        if(!gridRowInsertingEventArgs.success){
            gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
            removedFromApi=true;
        }
    };