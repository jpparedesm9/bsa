//Entity: ProjectionQuota
    //ProjectionQuota.projectionDate (DateField) View: ProjectionQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_FECHAPROYECCOIN_790517 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
    };