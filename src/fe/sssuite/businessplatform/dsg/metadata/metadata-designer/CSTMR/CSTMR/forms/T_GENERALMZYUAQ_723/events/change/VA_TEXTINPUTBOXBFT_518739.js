//Entity: Person
    //Person.typePerson (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    //Tipo de documento
    task.change.VA_TEXTINPUTBOXBFT_518739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        //changedEventArgs.commons.serverParameters.Person = true;
        if (entities.Person.typePerson == "P"){            
            changedEventArgs.commons.api.viewState.hide('G_GENERALAIR_501739');
            changedEventArgs.commons.api.viewState.hide('G_GENERALEAO_954739'); 
            changedEventArgs.commons.api.viewState.show('G_GENERALKTA_486739');
            task.clearNaturalPerson(entities);
            task.clearLegalPerson(entities);
            task.clearSpousePerson(entities);
        }
       if (entities.Person.typePerson == "C"){
           changedEventArgs.commons.api.viewState.hide('G_GENERALKTA_486739');
           changedEventArgs.commons.api.viewState.hide('G_GENERALEAO_954739');
           changedEventArgs.commons.api.viewState.show('G_GENERALAIR_501739');
           task.clearNaturalPerson(entities);
           task.clearLegalPerson(entities);
           task.clearSpousePerson(entities);
        }
        

    };