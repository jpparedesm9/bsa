//Start signature to callBack event to VA_VABUTTONECKBAAP_763218
    task.executeCommandCallback.VA_VABUTTONECKBAAP_763218 = function(entities, executeCommandEventArgs) {
       if(executeCommandEventArgs.success){
            var taskHeader = {};
            
            if(entities.CustomerTmp != undefined){
				entities.CustomerTmp.code=entities.LegalPerson.personSecuential;
			}
            if(entities.LegalPerson.constitutionPlaceCode==0){
                    entities.LegalPerson.constitutionPlaceCode=undefined;
            }
            if(entities.LegalRepresentative.undefinedEffectiveDate){
                entities.LegalRepresentative.effectiveDate=undefined;
            }
			
			executeCommandEventArgs.commons.api.viewState.enable('CM_TLEGALPE_CLM');
			if(showHeader){
				LATFO.INBOX.addTaskHeader(taskHeader,'title',entities.LegalPerson.businessName,0);	
				LATFO.INBOX.addTaskHeader(taskHeader,'No. de Identificaci\u00f3n',entities.LegalPerson.documentNumber,1);
				LATFO.INBOX.addTaskHeader(taskHeader,'Tipo de Identificaci\u00f3n',entities.LegalPerson.documentTypeDescription,1);
                LATFO.INBOX.addTaskHeader(taskHeader,'C\u00f3digo del cliente',entities.LegalPerson.personSecuential,2);
                //LATFO.INBOX.addTaskHeader(taskHeader,'RAZON SOCIAL',entities.LegalPerson.tradename,0);
				LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandEventArgs, 'G_LEGALPEARR_339688');			
				executeCommandEventArgs.commons.api.viewState.show('G_LEGALPEARR_339688');
			}else{
                //Para VCC
				executeCommandEventArgs.commons.api.viewState.hide('G_LEGALPEARR_339688');

			}
        }else{
             entities.LegalPerson.personSecuential=undefined;
            executeCommandEventArgs.commons.api.viewState.disable('CM_TLEGALPE_CLM');
        }

    };