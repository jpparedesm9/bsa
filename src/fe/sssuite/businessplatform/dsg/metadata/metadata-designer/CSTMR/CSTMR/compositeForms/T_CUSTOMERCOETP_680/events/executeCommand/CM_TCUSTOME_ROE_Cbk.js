//Start signature to Callback event to CM_TCUSTOME_ROE 
task.executeCommandCallback.CM_TCUSTOME_ROE = function(entities, executeCommandCallbackEventArgs) {
	var taskHeader = {};
	var nombreCompleto = '';
	var nombre2 = '';
	var apellido2 = '';
	
	if(entities.NaturalPerson.bioRenapoResult == 'S'){
		executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TCUSTOME_ROE');//Renapo
		executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_T01');//Guardar
		
		nombre2 = entities.NaturalPerson.secondName;
		apellido2 = entities.NaturalPerson.secondSurname;
        
		if (nombre2 == undefined || nombre2 == null) {
            nombre2 = '';
        }

        if (apellido2 == undefined || apellido2 == null) {
            apellido2 = '';
        }
			
		if (entities.NaturalPerson.typePerson == 'P') {
			nombreCompleto = entities.NaturalPerson.firstName + ' ' + nombre2 + ' ' + entities.NaturalPerson.surname + ' ' + apellido2;
		} else if (entities.NaturalPerson.typePerson == 'C') {
			nombreCompleto = entities.LegalPerson;
		}

        var controlsE = ['VA_EXPIRATIONDAEET_157213','VA_NATIONALITYCEUD_733213','VA_NATIONALITYCEDE_860213',
		                'VA_MARITALSTATUDCC_635213'
        ];
		LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controlsE, false);

        var controlsD = ['VA_DOCUMENTNUMBRRE_960213'
        ];
		LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controlsD, true);
		
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', nombreCompleto.toUpperCase(), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.NaturalPerson.documentTypeDescription, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.NaturalPerson.documentNumber, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.NaturalPerson.personSecuential, 2);
		LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_LEGALPEARR_339688');		
        executeCommandCallbackEventArgs.commons.api.viewState.show('G_LEGALPEARR_339688');
        task.validarCampos(entities, executeCommandCallbackEventArgs);
    }
};