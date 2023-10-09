//Entity: Mail
    //Mail. (Button) View: GeneralForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONUBNHVJA_668739 = function(  entities, executeCommandEventArgs ) {
       
        executeCommandEventArgs.commons.serverParameters.Person = true;
        executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
        executeCommandEventArgs.commons.serverParameters.LegalPerson = true;
        executeCommandEventArgs.commons.serverParameters.SpousePerson = true;
        executeCommandEventArgs.commons.serverParameters.Context = true;
    
        entities.Person.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.Person.official = cobis.userContext.getValue(cobis.constant.USER_NAME);
        //G_GENERALKTA_486739
        
        var erroresNaturalPerson = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_GENERALSVX_509739', false);
        var erroresSpousePerson = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_GENERALEAO_954739',false);
        
        if(erroresNaturalPerson == 0 && entities.Person.typePerson == 'P' && ((erroresSpousePerson == 0 && entities.NaturalPerson.maritalStatusCode == casado) || ((erroresSpousePerson != 0 || erroresSpousePerson == 0) && entities.NaturalPerson.maritalStatusCode != casado))){
            if(entities.NaturalPerson.personSecuential != null && entities.NaturalPerson.personSecuential != undefined
               && entities.NaturalPerson.personSecuential != ""){
                entities.Person.operation = 'U';
            }else{
                entities.Person.operation = 'I';
            }
             return;
        }//else if (erroresNaturalPerson != 0 && entities.Person.typePerson == 'P' && erroresSpousePerson != 0 && (entities.NaturalPerson.maritalStatusCode == 'CA' || entities.NaturalPerson.maritalStatusCode == undefined)) {
        else if (erroresNaturalPerson != 0 && entities.Person.typePerson == 'P' && (entities.NaturalPerson.maritalStatusCode == casado || entities.NaturalPerson.maritalStatusCode == undefined)) {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_EXISTENLR_22307',true);
            return;
        }else if(entities.Person.typePerson == 'P' && erroresSpousePerson != 0){
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_EXISTENLR_22307',true);
            return;
        }
        //G_GENERALAIR_501739
        var erroresLegalPerson = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_GENERALAIR_501739', false);
        
         if(erroresLegalPerson == 0 && entities.Person.typePerson == 'C'){
            if(entities.LegalPerson.personSecuential != null && entities.LegalPerson.personSecuential != undefined 
             && entities.LegalPerson.personSecuential != ""){
             entities.Person.operation = 'U';
            }else{
                entities.Person.operation = 'I';
            }
            return;
         }else if (erroresLegalPerson != 0 && entities.Person.typePerson == 'C'){
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_EXISTENLR_22307',true);
            return;
         }
        if(entities.NaturalPerson.bioIdentificationType == 'INE'){
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        } else {
            entities.NaturalPerson.bioCIC = null;
        }
    };