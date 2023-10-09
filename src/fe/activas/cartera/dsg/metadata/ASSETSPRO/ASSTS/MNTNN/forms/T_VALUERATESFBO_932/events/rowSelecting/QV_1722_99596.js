//gridRowSelecting QueryView: QV_1722_99596
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1722_99596 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        entities.ServerParameter.selectedRow = gridRowSelectingEventArgs.rowIndex;
        if (entities.ServerParameter.flag == false || entities.ServerParameter.flag == null) {
            entities.ServerParameter.flag = true;
        } else {
            entities.ServerParameter.flag = false;
        }
        //gridRowSelectingEventArgs.commons.serverParameters.TypeRates = true;
        
    };