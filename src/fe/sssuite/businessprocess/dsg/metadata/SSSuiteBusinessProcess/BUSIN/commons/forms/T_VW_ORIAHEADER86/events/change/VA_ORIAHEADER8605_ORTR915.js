//Entity: EntidadInfo
    //EntidadInfo.oficina (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_ORTR915 = function(entities, changedEventArgs) {
        //changedEventArgs.commons.execServer = false;       
        //SMO validar en el servidor está execServer=true
        changedEventArgs.commons.execServer = true;
        entities.EntidadInfo.oficina = entities.EntidadInfo.oficina == null || entities.EntidadInfo.oficina == '' || entities.EntidadInfo.oficina == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code +"" : entities.EntidadInfo.oficina;
        changedEventArgs.newValue = changedEventArgs.newValue == null || changedEventArgs.newValue == '' || changedEventArgs.newValue == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code +"" : changedEventArgs.newValue;
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',changedEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8605_ORTR915.get(changedEventArgs.newValue).value,1);
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };