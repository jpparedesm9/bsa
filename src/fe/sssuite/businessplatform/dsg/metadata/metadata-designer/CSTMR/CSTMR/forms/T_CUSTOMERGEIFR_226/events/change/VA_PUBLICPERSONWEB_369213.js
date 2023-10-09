//Entity: NaturalPerson
    //NaturalPerson.publicPerson (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PUBLICPERSONWEB_369213 = function(  entities, changedEventArgs ) {
        
        if(entities.NaturalPerson.publicPerson){
            changedEventArgs.commons.api.viewState.enable('VA_RELCHARGEPUBFLT_742213');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_RELCHARGEPUBFLT_742213');
            entities.NaturalPerson.relChargePub = null;
        }
        
        
    changedEventArgs.commons.execServer = false;
    
        
    };