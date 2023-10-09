//Entity: ExtendsQuota
    //ExtendsQuota.extendsDate (DateField) View: ExtendsQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer2497 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;    
        
       // entities.CurrentQuotas.quota = changeEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].quota;
        //entities.CurrentQuotas.endDate= changeEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate;
        //changeEventArgs.commons.serverParameters.ExtendsQuota = true;
    };