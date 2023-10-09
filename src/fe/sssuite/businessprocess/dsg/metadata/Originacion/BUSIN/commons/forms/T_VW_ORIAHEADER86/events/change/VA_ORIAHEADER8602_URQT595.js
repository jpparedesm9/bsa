//Entity: OriginalHeader
//OriginalHeader.CurrencyRequested (ComboBox) View: [object Object]
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8602_URQT595 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = false;
    var val = "USD";
    var vs = changeEventArgs.commons.api.viewState;
    // if(changeEventArgs.newValue=="0"){
    // val="BOB"
    // }else{
    // val="USD"
    // }
    vs.suffix('VA_ORIAHEADER8602_OQUE134', val);
    vs.suffix('VA_ORIAHEADER8602_MICI826', val);

    LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', val, 0);
    LATFO.INBOX.updateTaskHeader(taskHeader, changeEventArgs, 'GR_WTTTEPRCES08_02');

};