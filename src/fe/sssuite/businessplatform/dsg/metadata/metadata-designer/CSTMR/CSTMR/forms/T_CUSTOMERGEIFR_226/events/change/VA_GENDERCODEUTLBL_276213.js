//Entity: NaturalPerson
    //NaturalPerson.genderCode (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_GENDERCODEUTLBL_276213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.validationMarried( entities, changedEventArgs);
    };