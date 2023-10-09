//Start signature to callBack event to QV_1722_99596
    task.gridRowDeletingCallback.QV_1722_99596 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        gridRowDeletingEventArgs.commons.api.grid.removeAllRows("Rates");
        
    };