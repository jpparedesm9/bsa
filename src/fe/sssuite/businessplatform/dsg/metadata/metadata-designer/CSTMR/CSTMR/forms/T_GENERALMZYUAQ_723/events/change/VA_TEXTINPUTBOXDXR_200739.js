//Entity: LegalPerson
    //LegalPerson.documentNumber (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXDXR_200739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.LegalPerson = true;
    };