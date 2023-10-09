//Entity: Alicuota
//Alicuota.CtaCertificada (ComboBox) View: [object Object]
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8608_TTCD057 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = false;

    var viewState = changeEventArgs.commons.api.viewState;
    if (entities.Alicuota.Alicuota == "N" && entities.Alicuota.CtaCertificada !== null) {
        viewState.enableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
        viewState.disableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
    }
    
};