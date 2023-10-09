//Entity: NaturalPerson
    //NaturalPerson.indefinite (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_INDEFINITEHGXSF_717213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.validarFechaNac(entities, changedEventArgs);
    };