//Entity: EntidadInfo
//EntidadInfo.tipoProducto (ComboBox) View: [object Object]
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8605_TIRC927 = function (entities, changeEventArgs) {
    changeEventArgs.commons.serverParameters.EntidadInfo = true;
    changeEventArgs.commons.serverParameters.OriginalHeader = true;
    changeEventArgs.commons.serverParameters.generalData = true;

    // Reinicio los valores del combo
    entities.OriginalHeader.CurrencyRequested = "";
    entities.EntidadInfo.destinoEconomico = "";
    entities.EntidadInfo.destinoFinanciero = "";
    entities.EntidadInfo.sector = "";

    changeEventArgs.commons.execServer = true;

};