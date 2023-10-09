//Start signature to Callback event to VA_TERMMEDICALAISS_991R86
task.loadCatalogCallback.VA_TERMMEDICALAISS_991R86 = function (entities, loadCatalogCallbackEventArgs) {
    if (entities.EntidadInfo.insurancePackage == 'EXTENDIDO') {
        if (entities.EntidadInfo.termMedicalAssistance == null) {
            entities.EntidadInfo.termMedicalAssistance = "";
        }
    } else {
        entities.EntidadInfo.termMedicalAssistance = null;
    }
};
