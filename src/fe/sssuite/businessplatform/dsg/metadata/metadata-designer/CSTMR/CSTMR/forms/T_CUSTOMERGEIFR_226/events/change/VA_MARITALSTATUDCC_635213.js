//Entity: NaturalPerson
    //NaturalPerson.maritalStatusCode (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_MARITALSTATUDCC_635213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        
        if((entities.NaturalPerson.maritalStatusCode != casado)&&(entities.NaturalPerson.maritalStatusCode != unionLibre)){
            changedEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');  
        }else {
            changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONSTVQSJN_350425','FindCustomer', undefined, true, false, 'VC_CUSTOMERUU_138604', false);
            changedEventArgs.commons.api.viewState.show('VC_GQKQIIYSWN_251604');

        }
        
         task.validationMarried( entities, changedEventArgs);
    };