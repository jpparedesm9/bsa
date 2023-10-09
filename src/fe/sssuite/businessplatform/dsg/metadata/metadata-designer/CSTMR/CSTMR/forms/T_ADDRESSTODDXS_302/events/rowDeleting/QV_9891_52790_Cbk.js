//Start signature to callBack event to QV_9891_52790
    task.gridRowDeletingCallback.QV_9891_52790 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        
        if(!gridRowDeletingEventArgs.success){
        gridRowDeletingEventArgs.commons.api.grid.addRow('Phone',gridRowDeletingEventArgs.rowData);
    }
        
    };