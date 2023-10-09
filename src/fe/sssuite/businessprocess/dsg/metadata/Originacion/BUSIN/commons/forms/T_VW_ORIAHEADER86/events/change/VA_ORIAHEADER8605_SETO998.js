//Entity: EntidadInfo
//EntidadInfo.sector (ComboBox) View: [object Object]
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8605_SETO998 = function (entities, changeEventArgs) {
    entities.EntidadInfo.destinoEconomico = "";
    entities.EntidadInfo.destinoFinanciero = "";
    entities.EntidadInfo.otroDestino = "";
    changeEventArgs.commons.execServer = true;
    changeEventArgs.commons.serverParameters.EntidadInfo = true;
    changeEventArgs.commons.serverParameters.generalData = true;

};