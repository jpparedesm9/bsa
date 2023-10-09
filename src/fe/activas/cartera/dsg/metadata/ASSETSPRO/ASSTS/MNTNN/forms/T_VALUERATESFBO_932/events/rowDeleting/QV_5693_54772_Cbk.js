//Start signature to callBack event to QV_5693_54772
    task.gridRowDeletingCallback.QV_5693_54772 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        //Refrescar e grid de valores de tasa
        if (entities.ServerParameter.refresGrid2Flag == false || entities.ServerParameter.refresGrid2Flag == null) {
            entities.ServerParameter.refresGrid2Flag = true;
        } else {
            entities.ServerParameter.refresGrid2Flag = false;
        }
    };