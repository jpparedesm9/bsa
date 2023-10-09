//Start signature to Callback event to VA_VABUTTONQGYEKJY_245213
task.executeCommandCallback.VA_VABUTTONQGYEKJY_245213 = function(entities, executeCommandCallbackEventArgs) {
    //here your code
    if (executeCommandCallbackEventArgs.success) {

        var taskHeader = {};
        var nombreCompleto = '';
        var nombre2 = '';
        var apellido2 = '';
        var nombreGrupo = '';
        var idGrupo = '';
        var perteneceGroup = 'N';
        var renapo = 'N';
        var collective = '';
        var collectiveLevel = '';

        balanceFlag = false;

        //Asignacion de la consulta de parametros
        edadMax = entities.Context.maximumAge;
        edadMin = entities.Context.minimumAge;
        casado = entities.Context.married;
        unionLibre = entities.Context.freeUnion;
        pais = entities.Context.flag1;
        padre = entities.Context.parents;
        hijo = entities.Context.son;
        conyugue = entities.Context.couple;
        renapo = entities.Context.renapo;
        collective = entities.Context.collective;
        collectiveLevel = entities.Context.collectiveLevel;

        dirResidencia = entities.Context.flag2;
        dirNegocio = entities.Context.flag3;
        
        if (entities.Person.personSecuential == 256051) {
            entities.Person.blocked = 'BLOQUEADO PLD';
            executeCommandCallbackEventArgs.commons.api.viewState.show('VA_BLOCKEDZUOBRBYZ_833213');
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_STATUSCODEMPXFC_766213');
        } else {
            entities.Person.blocked = '';
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_BLOCKEDZUOBRBYZ_833213');
            executeCommandCallbackEventArgs.commons.api.viewState.show('VA_STATUSCODEMPXFC_766213');
        }

        if (!entities.DemographicData.residenceCountry) {
            entities.DemographicData.residenceCountry = pais;
        }
        if (screenMode != 'Q'){
            executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TCUSTOME_T01');
        }
        if (showHeader) {
            var documentTypes = executeCommandCallbackEventArgs.commons.api.vc.catalogs.VA_DOCUMENTTYPEAQM_964213.data();
            for (var i = 0; i < documentTypes.length; i++) {
                if (entities.NaturalPerson.documentType == documentTypes[i].code) {
                    entities.NaturalPerson.documentTypeDescription = documentTypes[i].value;
                    break;
                }
            }

            nombre2 = entities.NaturalPerson.secondName;
            apellido2 = entities.NaturalPerson.secondSurname;

            if (nombre2 == undefined) {
                nombre2 = '';
            }

            if (apellido2 == undefined) {
                apellido2 = '';
            }
            if (entities.NaturalPerson.nationalityCode == null) {
                entities.NaturalPerson.nationalityCode = pais;
            }

            if (entities.NaturalPerson.typePerson == 'P') {
                nombreCompleto = entities.NaturalPerson.firstName + ' ' + nombre2 + ' ' + entities.NaturalPerson.surname + ' ' + apellido2;
            } else if (entities.NaturalPerson.typePerson == 'C') {
                nombreCompleto = entities.LegalPerson;
            }

            if (entities.NaturalPerson.bioIdentificationType == null || entities.NaturalPerson.bioIdentificationType.trim() == "") {
                entities.NaturalPerson.bioIdentificationType = 'IFE';
            }
            if (entities.NaturalPerson.bioIdentificationType == 'INE') {
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_BIOCICLKEOYOTBY_860213');
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_BIOEMISSIONNRER_925213');
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_BIOOCRWLTNZPKPV_627213');
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_BIOREADERKEYGIL_809213');
            } else if (entities.NaturalPerson.bioIdentificationType == 'IFE') {
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_BIOCICLKEOYOTBY_860213');
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_BIOEMISSIONNRER_925213');
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_BIOOCRWLTNZPKPV_627213');
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_BIOREADERKEYGIL_809213');
            }

            if (entities.NaturalPerson.nameGroup != undefined && entities.NaturalPerson.idGroup != undefined &&
                entities.NaturalPerson.nameGroup != null && entities.NaturalPerson.idGroup != null) {
                perteneceGroup = 'S'
                nombreGrupo = ' - ' + entities.NaturalPerson.nameGroup;
                idGrupo = entities.NaturalPerson.idGroup;
            }
            //nombreCompleto = entities.NaturalPerson.firstName + ' '+ entities.NaturalPerson.secondName + ' '+ entities.NaturalPerson.surname + ' '+ entities.NaturalPerson.secondSurname;
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', nombreCompleto.toUpperCase(), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.NaturalPerson.documentTypeDescription, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.NaturalPerson.documentNumber, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.NaturalPerson.personSecuential, 2);
            if (perteneceGroup === 'S') {
                LATFO.INBOX.addTaskHeader(taskHeader, 'Grupo', idGrupo + nombreGrupo.toUpperCase(), 2);
            }
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_LEGALPEARR_339688');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_LEGALPEARR_339688');
            task.validarCampos(entities, executeCommandCallbackEventArgs);
        } else {
            //Para VCC e Inbox
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_LEGALPEARR_339688'); //('G_CUSTOMEREH_172638');
        }
        entities.Person.santanderCode = entities.NaturalPerson.santanderCode;


        task.validationMarried(entities, executeCommandCallbackEventArgs);
        //executeCommandCallbackEventArgs.commons.api.errors.validateInput('VA_MARITALSTATUDCC_635213');

        if (entities.NaturalPerson.maritalStatusCode == 'DI' || entities.NaturalPerson.maritalStatusCode == 'VI' ||
            entities.NaturalPerson.maritalStatusCode == 'SO') {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
        }

        //cASO209990
        if (entities.Context.renapo == 'S' && entities.Context.renapoByCurp == 'N' && entities.NaturalPerson.bioRenapoResult != 'S' && entities.NaturalPerson.statusCode == 'P') {
            var controls = ['VA_FIRSTNAMEFPYKAF_649213', 'VA_SECONDNAMESJJYD_721213', 'VA_SURNAMESONBWSJR_285213', 'VA_SECONDSURNAMEEE_733213', 'VA_BIRTHDATEEXJMQR_157213', 'VA_COUNTYOFBIRTHHH_881213',
                'VA_GENDERCODEUTLBL_276213'
            ];
            LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
        }
		
		//cASO209990
		executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TCUSTOME_ROE');//Renapo
        if (entities.Context.renapo == 'S' && entities.Context.renapoByCurp == 'S' && entities.NaturalPerson.bioRenapoResult != 'S') {
            var controls = ['VA_FIRSTNAMEFPYKAF_649213', 'VA_SECONDNAMESJJYD_721213', 'VA_SURNAMESONBWSJR_285213', 'VA_SECONDSURNAMEEE_733213', 
			'VA_BIRTHDATEEXJMQR_157213', 'VA_COUNTYOFBIRTHHH_881213','VA_GENDERCODEUTLBL_276213','VA_NATIONALITYCEUD_733213','VA_MARITALSTATUDCC_635213',
			'VA_NATIONALITYCEDE_860213'
            ];
			LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
						
			var controlEnable = ['VA_DOCUMENTNUMBRRE_960213'];
			LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controlEnable, false);
			
            executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T01');//Guardar
			executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T6S');//Buro
			executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_ROE');//Renapo
        }
		
        //cASO209990		
		if (entities.Context.renapo == 'S' && entities.Context.renapoByCurp != 'S' && entities.NaturalPerson.bioRenapoResult != 'S') {
            var controlsD = ['VA_FIRSTNAMEFPYKAF_649213', 'VA_SECONDNAMESJJYD_721213', 'VA_SURNAMESONBWSJR_285213', 'VA_SECONDSURNAMEEE_733213', 
			'VA_GENDERCODEUTLBL_276213','VA_COUNTYOFBIRTHHH_881213', 'VA_BIRTHDATEEXJMQR_157213'
            ];
			LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controlsD, false);
			
			executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TCUSTOME_ROE');//Renapo
		}
		
        //error estado civil
        executeCommandCallbackEventArgs.commons.api.viewState.disableValidation('VA_MARITALSTATUDCC_635213', VisualValidationTypeEnum.Required);

        /* Se recarga el catalogo de oficiales */
        executeCommandCallbackEventArgs.commons.api.viewState.refreshData('VA_OFFICERCODEBNMM_892213');

        //Eliminacion de validacion de requerido en caso de tener informacion
        executeCommandCallbackEventArgs.commons.api.viewState.focus('VA_BIOIDENTIFICPON_671213');

        if (screenMode == 'Q') {

            var controls = ['G_CUSTOMEGNN_387213','G_CUSTOMEEAN_819213','G_CUSTOMENEF_379213','G_CUSTOMEEAG_441213','G_CUSTOMEFRR_977213',
                           'G_DEMOGRAHHH_501794','G_CUSTOMERES_756425','G_SCANNEDCIM_218611','VA_TEXTINPUTBOXTFB_124611',
                           'VA_GRIDROWCOMMMNDD_972611','G_SCANNEDDSD_789611','G_SCANNEDOLM_531611','QV_7463_28553',
                           'G_ECONOMICNC_571168',,'G_ADDRESSHQX_118566','G_ADDRESSHTB_233566','G_ADDRESSLJO_139566',
                           'G_ADDRESSXST_172566','CM_TADDRESS_C49','G_BUSINESSSS_687304','G_BUSINESSSS_972304','QV_6114_93961',
                           'G_REFERENSES_691576','G_REFERENESE_254576','G_RELATIONNN_434954','G_RELATIONNN_730954',
                           'G_RELATIONNN_320954','G_COMPLEMETQ_738642','CM_TCUSTOME_T01','CM_TCUSTOME_2_9','CM_TCUSTOME_T6S'];
            LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
            
        }


    } else {
        entities.NaturalPerson.personSecuential = undefined;
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TCUSTOME_T01');
    }

    if (entities.NaturalPerson.nationalityCodeAux == 0) {
        entities.NaturalPerson.nationalityCodeAux = null;
    }

    if (entities.NaturalPerson.countyOfBirth == 0) {
        entities.NaturalPerson.countyOfBirth = null;
    }
    if (entities.EconomicInformation.businessYears == 0) {
        entities.EconomicInformation.businessYears = null;
    }
    if (entities.NaturalPerson.monthsInForce == 1) {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Informaci\u00f3n No Vigente, por favor actualizar datos del cliente', '', 20000, false);

    }
    if (entities.NaturalPerson.nationalityCodeAux == null) {
        entities.NaturalPerson.nationalityCodeAux = "1";
    }
    if (!entities.EconomicInformation.isLinked) {
        entities.EconomicInformation.relationId = "001";
    }

    if (entities.NaturalPerson.hasAlert == 'S') {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_CLIENTEBE_42174', '', 20000, false);
        //url de la pantalla de cunsulta de alertas
        /*var url = "/CTSProxy/services/cobis/web/views/CSTMR/CSTMR/T_CSTMRZIMDHJYH_829/1.0.0/VC_ADDALERTSS_984829_TASK.html';
                //Redireccion a  cunsulta de alertas";
        var menu = "Alerta de PLD - FT";
        cobis.container.tabs.openNewTab(menu, url, menu, true);*/
    }

    /*Req. 178652
    if (entities.NaturalPerson.colectivo === null || entities.NaturalPerson.colectivo === '') {
        entities.NaturalPerson.colectivo = collective;
    }*/
    
    if (entities.NaturalPerson.nivelColectivo === null || entities.NaturalPerson.nivelColectivo === '') {
        entities.NaturalPerson.nivelColectivo = collectiveLevel;
    }
    
    //if (entities.EconomicInformation.relationId == null) {
    //    entities.EconomicInformation.relationId = "001" ;
    //}

    //mostrar dependiendo del rol
    if (entities.Context.roleEnabledQueryAccount == 'S') {
        executeCommandCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONRNZGSZY_345213');
    }else{
        executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONRNZGSZY_345213');
    }

    //se aumenta por caso #157556 - inicio
	if(cargaInicial){
        var filtro = {
                customerId:entities.NaturalPerson.personSecuential,
                processInstance:"0",
                sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
        }
	    executeCommandCallbackEventArgs.commons.api.vc.parentVc = {}
	    executeCommandCallbackEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
	    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
		activeChangeIniDocs = true
	}
	//se aumenta por caso #157556 - fin
	
    //seteo de variables
    activeChange = false;

    if (entities.Parameters.allowUpdateNames) {
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_FIRSTNAMEFPYKAF_649213');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_SECONDNAMESJJYD_721213');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_SURNAMESONBWSJR_285213');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_SECONDSURNAMEEE_733213');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_GENDERCODEUTLBL_276213');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_COUNTYOFBIRTHHH_881213');
    }




};