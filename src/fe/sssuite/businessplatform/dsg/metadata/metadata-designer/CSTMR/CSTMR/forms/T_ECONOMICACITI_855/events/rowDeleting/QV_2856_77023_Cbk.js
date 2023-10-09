//Start signature to callBack event to QV_2856_77023
task.gridRowDeletingCallback.QV_2856_77023 = function(entities, gridRowDeletingCallbackEventArgs) {
    //Refrescar el grid 
    if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
        entities.Entity1.refreshGrid = true;
    } else {
        entities.Entity1.refreshGrid = false;
    }
};