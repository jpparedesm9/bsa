//Entity: NaturalPerson
    //NaturalPerson.maritalStatusCode (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXJOG_550739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        //task.showHideSpouceInformation(entities, changedEventArgs);
    };