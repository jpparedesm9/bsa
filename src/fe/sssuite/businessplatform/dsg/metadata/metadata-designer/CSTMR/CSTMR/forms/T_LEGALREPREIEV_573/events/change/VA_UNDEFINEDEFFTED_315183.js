//Entity: LegalRepresentative
    //LegalRepresentative.undefinedEffectiveDate (CheckBox) View: LegalRepresentative
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_UNDEFINEDEFFTED_315183 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(changedEventArgs.newValue==true){
            changedEventArgs.commons.api.viewState.disable('VA_EFFECTIVEDATEEE_633183');
          
             entities.LegalRepresentative.effectiveDate=undefined;
        }else{
            changedEventArgs.commons.api.viewState.enable('VA_EFFECTIVEDATEEE_633183');
        }
        
    };