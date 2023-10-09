//gridRowSelecting QueryView: QV_5858_58779
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5858_58779 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        secuentialIng=gridRowSelectingEventArgs.rowData.secuentialIng;	

    };