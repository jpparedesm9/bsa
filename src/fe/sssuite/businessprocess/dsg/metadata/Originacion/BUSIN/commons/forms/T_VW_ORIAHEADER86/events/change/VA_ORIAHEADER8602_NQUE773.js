//Entity: OriginalHeader
//OriginalHeader.PaymentFrequency (ComboBox) View: T_HeaderView
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8602_NQUE773 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = true;
    var vs = changeEventArgs.commons.api.viewState;
    // changeEventArgs.commons.serverParameters.OriginalHeader = true;
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', changeEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8602_NQUE773.get(changeEventArgs.newValue).value, 0);
    LATFO.INBOX.updateTaskHeader(taskHeader, changeEventArgs, 'GR_WTTTEPRCES08_02');

    vs.suffix('VA_ORIAHEADER8602_TERM237', changeEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8602_NQUE773.get(changeEventArgs.newValue).value);

};