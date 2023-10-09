// (Button) 
    task.executeCommand.CM_TCUSTOME_T26 = function(entities, executeCommandEventArgs) {
        var docsValidated = true;
        if(entities.VirtualAddress._data.length == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORREEI_58179', true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
         if(entities.PhysicalAddress._data.length < 2){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LASDIREON_70625', true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        
        if (task.FechaNacimiento(entities.NaturalPerson.birthDate, edadMin, edadMax) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
            executeCommandEventArgs.commons.execServer = false;
        }
        else {
            executeCommandEventArgs.commons.execServer = true;
            entities.EconomicInformation.monthlyIncome="10";
            entities.EconomicInformation.expenseLevel="1";

            if(entities.NaturalPerson.hasProblems==null){
                entities.NaturalPerson.hasProblems=false;
            }
            if(entities.NaturalPerson.personPEP==null){
                entities.NaturalPerson.personPEP=false;
            }
            if(entities.NaturalPerson.isLinked==null){
                entities.NaturalPerson.isLinked=false;
            }
            if(entities.EconomicInformation.sales==null) {
               entities.EconomicInformation.sales=0; 
            }
            entities.NaturalPerson.santanderCode = entities.Person.santanderCode;
            //Caso 155939
            //entities.CustomerTmpReferences.code=entities.NaturalPerson.personSecuential;
        }
        if(entities.NaturalPerson.bioIdentificationType == 'INE'){
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        } else {
            entities.NaturalPerson.bioCIC = null;
        }
        
      };