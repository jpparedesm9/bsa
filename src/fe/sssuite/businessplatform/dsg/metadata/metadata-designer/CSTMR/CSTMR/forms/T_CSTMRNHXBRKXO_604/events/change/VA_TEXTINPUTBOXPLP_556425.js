//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXPLP_556425 = function(  entities, changedEventArgs ) {
    
    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.secondSurname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.SpousePerson.secondSurname = null;
    }
    
        
};