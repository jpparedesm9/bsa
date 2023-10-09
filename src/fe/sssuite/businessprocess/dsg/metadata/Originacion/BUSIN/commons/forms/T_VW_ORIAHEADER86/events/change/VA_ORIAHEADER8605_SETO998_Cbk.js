//Start signature to callBack event to VA_ORIAHEADER8605_SETO998
task.changeCallback.VA_ORIAHEADER8605_SETO998 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = false;
    changeEventArgs.commons.api.viewState.label('VA_ORIAHEADER8605_OEIO709', entities.generalData.labelOtroDestino)
};