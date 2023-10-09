//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXJTN_514425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.surname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.SpousePerson.surname = null;
    }
    
        
};