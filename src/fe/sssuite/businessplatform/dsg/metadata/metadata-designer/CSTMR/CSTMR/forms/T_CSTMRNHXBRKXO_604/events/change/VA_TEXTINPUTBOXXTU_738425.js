//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXXTU_738425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.secondName;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 3) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
        entities.SpousePerson.secondName = null;
    }
    
};