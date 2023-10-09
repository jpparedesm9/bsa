//gridRowSelecting QueryView: GridApplicationsPrint
//Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelectingCallback.QV_ERPLI1480_97 = function (entities,gridRowSelectingCallbackEventArgs) {
    var a = 1;
    gridRowSelectingCallbackEventArgs.commons.execServer = false;

};