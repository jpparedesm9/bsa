//Entity: OriginalHeader
//OriginalHeader.Term (TextInputBox) View: T_HeaderView
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8602_TERM237 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = true;
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', changeEventArgs.newValue, 0);
    LATFO.INBOX.updateTaskHeader(taskHeader, changeEventArgs, 'GR_WTTTEPRCES08_02');

};