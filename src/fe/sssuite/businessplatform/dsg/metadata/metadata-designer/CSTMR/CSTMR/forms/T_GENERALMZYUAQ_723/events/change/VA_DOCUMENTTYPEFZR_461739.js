//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DOCUMENTTYPEFZR_461739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        entities.NaturalPerson.documentNumber =" ";
        //changedEventArgs.commons.serverParameters.NaturalPerson = true;
    };