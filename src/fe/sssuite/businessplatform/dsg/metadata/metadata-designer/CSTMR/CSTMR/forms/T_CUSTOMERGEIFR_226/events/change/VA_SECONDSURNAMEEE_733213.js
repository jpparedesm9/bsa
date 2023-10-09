//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_SECONDSURNAMEEE_733213 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.secondSurname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.NaturalPerson.secondSurname = null;
    } 
    
        
};