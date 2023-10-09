//Entity: OriginalHeader
//OriginalHeader.AmountRequested (TextInputBox) View: T_HeaderView
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8602_OQUE134 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = false;
    entities.OriginalHeader.AmountAprobed = changeEventArgs.newValue;
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((changeEventArgs.newValue == null || changeEventArgs.newValue == 'null' ? 0 : changeEventArgs.newValue), 2), 0);
    LATFO.INBOX.updateTaskHeader(taskHeader, changeEventArgs, 'GR_WTTTEPRCES08_02');

};