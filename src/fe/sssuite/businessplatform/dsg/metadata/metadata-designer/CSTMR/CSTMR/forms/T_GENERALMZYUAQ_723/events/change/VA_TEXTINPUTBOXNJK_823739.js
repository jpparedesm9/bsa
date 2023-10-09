//Entity: NaturalPerson
//NaturalPerson.documentNumber (TextInputBox) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXNJK_823739 = function (entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;

    if (entities.Context.renapoByCurp == 'S') {
        entities.NaturalPerson.firstName = null;
        entities.NaturalPerson.secondName = null;
        entities.NaturalPerson.surname = null;
        entities.NaturalPerson.secondSurname = null;
        entities.NaturalPerson.birthDate = null;
        entities.NaturalPerson.genderCode = null;
        entities.NaturalPerson.countyOfBirth = null;
    }

};