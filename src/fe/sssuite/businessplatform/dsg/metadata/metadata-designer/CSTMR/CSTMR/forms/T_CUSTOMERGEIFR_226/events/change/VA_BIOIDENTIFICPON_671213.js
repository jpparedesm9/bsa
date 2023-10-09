//Entity: NaturalPerson
    //NaturalPerson.bioIdentificationType (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOIDENTIFICPON_671213 = function(  entities, changedEventArgs ) {
    
    changedEventArgs.commons.execServer = false;
    
        if(changedEventArgs.newValue == 'INE'){
            changedEventArgs.commons.api.viewState.show('VA_BIOCICLKEOYOTBY_860213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOEMISSIONNRER_925213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOOCRWLTNZPKPV_627213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOREADERKEYGIL_809213');
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        }else if(changedEventArgs.newValue == 'IFE'){
            changedEventArgs.commons.api.viewState.hide('VA_BIOCICLKEOYOTBY_860213',true);
            changedEventArgs.commons.api.viewState.show('VA_BIOEMISSIONNRER_925213');
            changedEventArgs.commons.api.viewState.show('VA_BIOOCRWLTNZPKPV_627213');
            changedEventArgs.commons.api.viewState.show('VA_BIOREADERKEYGIL_809213');
            entities.NaturalPerson.bioCIC = null;
        }
        
    };