//Entity: NaturalPerson
    //NaturalPerson.personPEP (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PERSONPEPVOMMIN_199213 = function(  entities, changedEventArgs ) {
        
       /* if(entities.NaturalPerson.personPEP){
            changedEventArgs.commons.api.viewState.enable('VA_CHARGEPUBGMPRKN_954213');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_CHARGEPUBGMPRKN_954213');
            entities.NaturalPerson.chargePub = null;
        }*/
        
        changedEventArgs.commons.execServer = false;
        
    };