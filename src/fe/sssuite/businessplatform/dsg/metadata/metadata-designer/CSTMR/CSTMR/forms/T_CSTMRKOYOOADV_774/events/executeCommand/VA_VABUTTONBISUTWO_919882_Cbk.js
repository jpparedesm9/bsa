// (Button) 
    task.executeCommandCallback.VA_VABUTTONBISUTWO_919882 = function(  entities, executeCommandCallbackEventArgs ) {
        if (executeCommandCallbackEventArgs.success) {
            var documentTypes = executeCommandCallbackEventArgs.commons.api.vc.catalogs.VA_DOCUMENTTYPEMOR_836882.data();
            for (var i = 0; i < documentTypes.length; i++) {
                if (entities.NaturalPerson.documentType == documentTypes[i].code) {
                    entities.NaturalPerson.documentTypeDescription = documentTypes[i].value;
                    break;
                }
            }

            nombre2=entities.NaturalPerson.secondName;            
            apellido2=entities.NaturalPerson.secondSurname;
            
            if(nombre2 == undefined){
                nombre2 = '';
            }
            
            if(apellido2 == undefined){
                apellido2 = '';
            }
           /* if(entities.NaturalPerson.nationalityCode == null){
                entities.NaturalPerson.nationalityCode = pais;
            }*/
            
            //if(entities.NaturalPerson.typePerson == 'P'){
                nombreCompleto = entities.NaturalPerson.firstName + ' '+  nombre2 + ' '+ entities.NaturalPerson.surname + ' '+ apellido2;    
            /*}
            else if (entities.NaturalPerson.typePerson == 'C'){
                nombreCompleto = entities.LegalPerson;
            }*/
			
		    if(entities.NaturalPerson.nameGroup != undefined && entities.NaturalPerson.idGroup != undefined &&
			   entities.NaturalPerson.nameGroup != null && entities.NaturalPerson.idGroup != null){
				perteneceGroup = 'S'
				nombreGrupo = ' - ' + entities.NaturalPerson.nameGroup;
				idGrupo = entities.NaturalPerson.idGroup;
			}
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', nombreCompleto.toUpperCase(), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.NaturalPerson.documentTypeDescription, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.NaturalPerson.documentNumber, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.NaturalPerson.personSecuential, 2);
			if (perteneceGroup === 'S'){
				LATFO.INBOX.addTaskHeader(taskHeader, 'Grupo', idGrupo + nombreGrupo.toUpperCase(), 2);	
			}			
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_MODIFICRNF_489882');
			executeCommandCallbackEventArgs.commons.api.viewState.show('G_MODIFICRNF_489882'); 

			if(angular.isDefined(entities.Context.flag3) && entities.Context.flag3!=null && entities.Context.flag3!='S'){
                executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_IDENTIFICATICCN_494882');
                executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_DOCUMENTNUMBEER_711882'); 
            }
        }
        
    };