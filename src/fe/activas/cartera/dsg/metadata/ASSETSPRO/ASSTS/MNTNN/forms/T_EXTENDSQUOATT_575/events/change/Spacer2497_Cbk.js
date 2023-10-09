//Entity: ExtendsQuota
    //ExtendsQuota.extendsDate (DateField) View: ExtendsQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.Spacer2497 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        if (entities.ExtendsQuotaExt._data.length>0){
             changeEventArgs.commons.api.viewState.show('G_EXTENDSUUA_352662');
        }else{
           changeEventArgs.commons.api.viewState.hide('G_EXTENDSUUA_352662');       
        } 
        
    };