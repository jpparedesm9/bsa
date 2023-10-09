//Entity: EntidadInfo
//EntidadInfo.insurancePackage (ComboBox) View: T_HeaderView
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_INSURANCEPACKEG_674R86 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;

    if (changedEventArgs.newValue == 'EXTENDIDO') {
        changedEventArgs.commons.api.viewState.enable('VA_TERMMEDICALAISS_991R86');
    } else {
        changedEventArgs.commons.api.viewState.disable('VA_TERMMEDICALAISS_991R86');
        entities.EntidadInfo.termMedicalAssistance = null;
    }
};