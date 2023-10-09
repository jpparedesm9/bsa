// (Button) 
    task.executeCommand.CM_TLEGALPE_CLM = function(entities, executeCommandEventArgs) {
        
        var generalLegalPersonErrors = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_GENERALLNA_884218', false);
        var legalRepresentativeErrors = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_LEGALRENEE_282183', false);
        var economicInfoErrors = executeCommandEventArgs.commons.api.errors.getErrorsGroup('G_ECONOMILGE_495907', false);
        var hasErrors=false;
        
        
        
       if(entities.LegalPerson.tradename == null || entities.LegalPerson.businessName == null || entities.LegalPerson.constitutionPlaceCode == null || entities.LegalPerson.coverageCode == null || entities.LegalPerson.legalpersonTypeCode == null)
       {
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARIE_75883');
            hasErrors=true;
       }
        
        if(entities.LegalRepresentative.legalRepresentativeDescription == null || (entities.LegalRepresentative.undefinedEffectiveDate == false && entities.LegalRepresentative.effectiveDate == undefined )){
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARRE_36013');
            hasErrors=true;
        }
        
        if(entities.EconomicInformationLegalPerson.revenues == null || entities.EconomicInformationLegalPerson.expenses == null || entities.EconomicInformationLegalPerson.netWorth == null || entities.EconomicInformationLegalPerson.totalCapital == null || entities.EconomicInformationLegalPerson.relation == null){
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARSO_69331');
            hasErrors=true;
        }
        /*if(economicInfoErrors!=0){
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARSO_69331');
            hasErrors=true;
        }if(legalRepresentativeErrors!=0){
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARRE_36013');
            hasErrors=true;
        }if(generalLegalPersonErrors!=0){
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_REVISARIE_75883');
            hasErrors=true;
        }*/
        
        if(!hasErrors){
            executeCommandEventArgs.commons.execServer = true;
            executeCommandEventArgs.commons.serverParameters.LegalPerson = true;
            executeCommandEventArgs.commons.serverParameters.EconomicInformationLegalPerson = true;
            executeCommandEventArgs.commons.serverParameters.LegalRepresentative = true;
        
            if(entities.LegalRepresentative.undefinedEffectiveDate){
                var newDate=new Date();
                newDate.setFullYear(newDate.getFullYear()+100);
                entities.LegalRepresentative.effectiveDate=newDate;
            }
        }else{
            executeCommandEventArgs.commons.execServer = false;            
        }
    };