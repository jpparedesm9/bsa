//Entity: EntidadInfo
//EntidadInfo.oficina (ComboBox) View: [object Object]
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ORIAHEADER8605_ORTR915 = function (entities, changeEventArgs) {
    changeEventArgs.commons.execServer = false;
    entities.EntidadInfo.oficina = entities.EntidadInfo.oficina == null || entities.EntidadInfo.oficina == '' || entities.EntidadInfo.oficina == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code + "" : entities.EntidadInfo.oficina;
    changeEventArgs.newValue = changeEventArgs.newValue == null || changeEventArgs.newValue == '' || changeEventArgs.newValue == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code + "" : changeEventArgs.newValue;
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', changeEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8605_ORTR915.get(changeEventArgs.newValue).value, 1);
    LATFO.INBOX.updateTaskHeader(taskHeader, changeEventArgs, 'GR_WTTTEPRCES08_02');
};