//Entity: NaturalPerson
    //NaturalPerson.firstName (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXWXT_116739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.NaturalPerson.firstName;
    //    var indexs = text.indexOf(".");
    //    if(indexs != -1){
    //        var sub = text.substring(0, indexs.length);
    //        if(sub != 'MA.'){
    //            changedEventArgs.commons.messageHandler.showTranslateMessagesError('El punto solo se permite en MA.',true);
    //            entities.NaturalPerson.firstName = null;
    //        }
    //        indexs = 0;
    //    }
        var splitText = text == null ? null : text.split(" ");
        var countWhitespaces = splitText == null? 0 : splitText.length-1;
        if (countWhitespaces > 3) {
            changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
            entities.NaturalPerson.firstName = null;
        }	
    };