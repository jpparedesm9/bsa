//Entity: NaturalPerson
    //NaturalPerson.birthDate (DateField) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIRTHDATEEXJMQR_157213 = function(  entities, changedEventArgs ) {
        
        var date1 = new Date(entities.NaturalPerson.birthDate);
        
        var birthday = date1;
        var today = new Date();
        var years = today.getFullYear() - birthday.getFullYear();

        // Reset birthday to the current year.
        birthday.setFullYear(today.getFullYear());

        // If the user's birthday has not occurred yet this year, subtract 1.
        if (today < birthday)
        {
            years--;
        }
        
        entities.NaturalPerson.age = years;
        
         if (task.FechaNacimiento(entities.NaturalPerson.birthDate,edadMin,edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }

        changedEventArgs.commons.execServer = false;
    
        
    };