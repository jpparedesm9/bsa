/* variables locales de T_CUSTOMERGEIFR_226*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.customergeneralinfform;
    

    //"TaskId": "T_CUSTOMERGEIFR_226"

task.validationMarried = function(entities, args) {
    try
    {
     var api = args.commons.api;
/*
     if (entities.NaturalPerson.maritalStatusCode != null && entities.NaturalPerson.maritalStatusCode == casado){
         if(entities.NaturalPerson.genderCode != null && entities.NaturalPerson.genderCode == "F"){
             api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = true;
             api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = true;
         } else if (entities.NaturalPerson.genderCode != null && entities.NaturalPerson.genderCode == "M"){
             api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = true;
             api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = false;
             entities.NaturalPerson.marriedSurname = null;
         }
     }
     else{
        api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = false;
        api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = false;
         entities.NaturalPerson.spouse = null;
         entities.NaturalPerson.marriedSurname = null;
     }*/
    } catch (err) {

    }
};

    //Entity: NaturalPerson
    //NaturalPerson.bioHasFingerprint (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOHASFINGERRRR_235213 = function(  entities, changedEventArgs ) {
        activeChange = true;
        changedEventArgs.commons.execServer = false;
        var customerId = entities.Person.personSecuential;
        if (customerId != undefined) {
            var filtro ={
                customerId:customerId,
                processInstance:"0",
                sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                        }
            //Refresh de la grilla para llenar la entidad
            changedEventArgs.commons.api.vc.parentVc = {}
            changedEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
                
            //Refresh de la grilla para llenar la entidad
            changedEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
        }
        
    };

//Entity: NaturalPerson
    //NaturalPerson.bioIdentificationType (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOIDENTIFICPON_671213 = function(  entities, changedEventArgs ) {
    
    changedEventArgs.commons.execServer = false;
    
        if(changedEventArgs.newValue == 'INE'){
            changedEventArgs.commons.api.viewState.show('VA_BIOCICLKEOYOTBY_860213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOEMISSIONNRER_925213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOOCRWLTNZPKPV_627213');
            changedEventArgs.commons.api.viewState.hide('VA_BIOREADERKEYGIL_809213');
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        }else if(changedEventArgs.newValue == 'IFE'){
            changedEventArgs.commons.api.viewState.hide('VA_BIOCICLKEOYOTBY_860213',true);
            changedEventArgs.commons.api.viewState.show('VA_BIOEMISSIONNRER_925213');
            changedEventArgs.commons.api.viewState.show('VA_BIOOCRWLTNZPKPV_627213');
            changedEventArgs.commons.api.viewState.show('VA_BIOREADERKEYGIL_809213');
            entities.NaturalPerson.bioCIC = null;
        }
        
    };

//Entity: NaturalPerson
    //NaturalPerson.birthDate (DateField) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIRTHDATEEXJMQR_157213 = function(  entities, changedEventArgs ) {
        
        var date1 = new Date(entities.NaturalPerson.birthDate);
        
        var birthday = date1;
        var today = new Date();
        var years = today.getFullYear() - birthday.getFullYear();

        // Reset birthday to the current year.
        birthday.setFullYear(today.getFullYear());

        // If the user's birthday has not occurred yet this year, subtract 1.
        if (today < birthday)
        {
            years--;
        }
        
        entities.NaturalPerson.age = years;
        
         if (task.FechaNacimiento(entities.NaturalPerson.birthDate,edadMin,edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }

        changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: NaturalPerson
//NaturalPerson.firstName (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_FIRSTNAMEFPYKAF_649213 = function(entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;
    var text = entities.NaturalPerson.firstName;
    var indexs = text.indexOf(".");
    //if (indexs != -1) {
    //    var sub = text.substring(0, indexs.length);
    //    if (sub != 'MA.') {
    //        changedEventArgs.commons.messageHandler.showTranslateMessagesError('El punto solo se permite en MA.', true);
    //        entities.NaturalPerson.firstName = null;
    //    }
    //    indexs = 0;
    //}
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 3) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
        entities.NaturalPerson.firstName = null;
    }
};

//Entity: NaturalPerson
    //NaturalPerson.genderCode (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_GENDERCODEUTLBL_276213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.validationMarried( entities, changedEventArgs);
    };

//Entity: NaturalPerson
    //NaturalPerson.indefinite (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_INDEFINITEHGXSF_717213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.validarFechaNac(entities, changedEventArgs);
    };

//Entity: NaturalPerson
    //NaturalPerson.maritalStatusCode (ComboBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_MARITALSTATUDCC_635213 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        
        if((entities.NaturalPerson.maritalStatusCode != casado)&&(entities.NaturalPerson.maritalStatusCode != unionLibre)){
            changedEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');  
        }else {
            changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONSTVQSJN_350425','FindCustomer', undefined, true, false, 'VC_CUSTOMERUU_138604', false);
            changedEventArgs.commons.api.viewState.show('VC_GQKQIIYSWN_251604');

        }
        
         task.validationMarried( entities, changedEventArgs);
    };

//Entity: NaturalPerson
    //NaturalPerson.personPEP (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PERSONPEPVOMMIN_199213 = function(  entities, changedEventArgs ) {
        
       /* if(entities.NaturalPerson.personPEP){
            changedEventArgs.commons.api.viewState.enable('VA_CHARGEPUBGMPRKN_954213');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_CHARGEPUBGMPRKN_954213');
            entities.NaturalPerson.chargePub = null;
        }*/
        
        changedEventArgs.commons.execServer = false;
        
    };

//Entity: NaturalPerson
    //NaturalPerson.publicPerson (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PUBLICPERSONWEB_369213 = function(  entities, changedEventArgs ) {
        
        if(entities.NaturalPerson.publicPerson){
            changedEventArgs.commons.api.viewState.enable('VA_RELCHARGEPUBFLT_742213');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_RELCHARGEPUBFLT_742213');
            entities.NaturalPerson.relChargePub = null;
        }
        
        
    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_SECONDNAMESJJYD_721213 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.secondName;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 3) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
        entities.NaturalPerson.secondName = null;
    } 
    
        
};

//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_SECONDSURNAMEEE_733213 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.secondSurname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.NaturalPerson.secondSurname = null;
    } 
    
        
};

//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_SURNAMESONBWSJR_285213 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.surname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.NaturalPerson.surname = null;
    } 
    
        
};

//Entity: NaturalPerson
//NaturalPerson.bioCIC (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidate.VA_BIOCICLKEOYOTBY_860213 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
    LATFO.UTILS.validarMinMax(customValidateEventArgs, 9,9, "N", "CSTMR.MSG_CSTMR_CAMPODETR_21780");
    }
        
};

//Entity: NaturalPerson
//NaturalPerson.bioEmissionNumber (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidate.VA_BIOEMISSIONNRER_925213 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
    LATFO.UTILS.validarMinMax(customValidateEventArgs, 2,2, "A", "CSTMR.MSG_CSTMR_CAMPODEBT_21506");   
    }
        
};

//Entity: NaturalPerson
//NaturalPerson.bioOCR (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidate.VA_BIOOCRWLTNZPKPV_627213 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
    
    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
    LATFO.UTILS.validarMinMax(customValidateEventArgs, 13,13, "N", "CSTMR.MSG_CSTMR_CAMPODE1E_73658");
    }
        
};

//Entity: NaturalPerson
//NaturalPerson.bioReaderKey (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidate.VA_BIOREADERKEYGIL_809213 = function(  entities, customValidateEventArgs ) {
    
    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
    LATFO.UTILS.validarMinMax(customValidateEventArgs, 18,18, "A", "CSTMR.MSG_CSTMR_CAMPODENR_14381");
    }
    
};

//Entity: NaturalPerson
//NaturalPerson.firstName (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_FIRSTNAMEFPYKAF_649213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 20); //3 es con punto y espacio cs: 150907
};

//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SECONDNAMESJJYD_721213 = function( customValidationEventArgs ) {
     return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 30); //el 3 es con punto y espacio
};

//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SECONDSURNAMEEE_733213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto 
};

//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SURNAMESONBWSJR_285213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto     
        
};

//Entity: NaturalPerson
//NaturalPerson. (Button) View: CustomerGeneralInfForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONQGYEKJY_245213 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
    entitiesTmp = entities;
    if(gnralInfoSelected>0){
        executeCommandEventArgs.commons.execServer = false;
    }
    if (entities.CustomerTmp.code == null) {
        entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;

    }
};

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
            executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TCUSTOME_T26');
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


        if (entities.Context.renapo == 'S' && entities.NaturalPerson.bioRenapoResult != 'S' && entities.NaturalPerson.statusCode == 'P') {
            var controls = ['VA_FIRSTNAMEFPYKAF_649213', 'VA_SECONDNAMESJJYD_721213', 'VA_SURNAMESONBWSJR_285213', 'VA_SECONDSURNAMEEE_733213', 'VA_BIRTHDATEEXJMQR_157213', 'VA_COUNTYOFBIRTHHH_881213',
                'VA_GENDERCODEUTLBL_276213'
            ];
            LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
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
                           'G_RELATIONNN_320954','G_COMPLEMETQ_738642','CM_TCUSTOME_T26','CM_TCUSTOME_2_9','CM_TCUSTOME_T6S'];
            LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
            
        }


    } else {
        entities.NaturalPerson.personSecuential = undefined;
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TCUSTOME_T26');
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

    if (entities.NaturalPerson.colectivo === null || entities.NaturalPerson.colectivo === '') {
        entities.NaturalPerson.colectivo = collective;
    }
    
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

//Entity: NaturalPerson
    //NaturalPerson. (Button) View: CustomerGeneralInfForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRNZGSZY_345213 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
        entities.Context.accountIndividual = entities.NaturalPerson.accountIndividual;
    };

//Start signature to Callback event to VA_VABUTTONRNZGSZY_345213
    task.executeCommandCallback.VA_VABUTTONRNZGSZY_345213 = function(entities, executeCommandCallbackEventArgs) {
        if(executeCommandCallbackEventArgs.success){
			//Open Modal
			var nav = executeCommandCallbackEventArgs.commons.api.navigation;

			nav.address = {
				moduleId: 'CSTMR',
				subModuleId: 'CSTMR',
				taskId: 'T_CSTMRNJOIOJFD_116',
				taskVersion: '1.0.0',
				viewContainerId: 'VC_REPLACEAII_570116'
			};
			nav.queryParameters = {
				mode: 2
			};
			nav.modalProperties = {
				size: 'md',
				callFromGrid: false
			};
			nav.customDialogParameters = {
                personSecuential: entities.NaturalPerson.personSecuential,
				oldAccount: entities.Context.accountIndividual,
				newAccount: entities.NaturalPerson.accountIndividual
			};
			nav.openModalWindow(executeCommandCallbackEventArgs.commons.controlId, null);
		} else {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_OCURRIONR_93100');
        }
    };

//Entity: NaturalPerson
    //NaturalPerson.countyOfBirth (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTYOFBIRTHHH_881213 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_DOCUMENTTYPEAQM_964213 = function( loadCatalogDataEventArgs ) {
        
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.nationalityCode (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NATIONALITYCEDE_860213 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.officerCode (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICERCODEBNMM_892213 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };



}));