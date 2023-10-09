/* variables locales de T_GENERALMZYUAQ_723*/
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

    
        var task = designerEvents.api.generalform;
    

    //"TaskId": "T_GENERALMZYUAQ_723"

    //Entity: NaturalPerson
    //NaturalPerson.bioIdentificationType (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOIDENTIFICITO_287739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        if(changedEventArgs.newValue == 'INE'){
            changedEventArgs.commons.api.viewState.show('VA_BIOCICSOGTHMGMK_830739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOEMISSIONNUUU_579739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOOCRPFNDHELMR_160739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOREADERKEYXPM_644739');
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        }else if(changedEventArgs.newValue == 'IFE'){
            changedEventArgs.commons.api.viewState.hide('VA_BIOCICSOGTHMGMK_830739');
            changedEventArgs.commons.api.viewState.show('VA_BIOEMISSIONNUUU_579739');
            changedEventArgs.commons.api.viewState.show('VA_BIOOCRPFNDHELMR_160739');
            changedEventArgs.commons.api.viewState.show('VA_BIOREADERKEYXPM_644739');
            entities.NaturalPerson.bioCIC = null;
        }
        
    };

//Entity: SpousePerson
//SpousePerson.birthDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_BIRTHDATEHFEDFC_460739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.FechaNacimiento(entities.SpousePerson.birthDate,edadMin, edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }
};

//Entity: NaturalPerson
//NaturalPerson.expirationDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DATEFIELDEXOTID_585739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
     if (task.ValidaVencimiento(entities.NaturalPerson.expirationDate) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELDOCUMTO_49378', true);
    }
};

//Entity: SpousePerson
//SpousePerson.expirationDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DATEFIELDKPKNOQ_427739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.ValidaVencimiento(entities.SpousePerson.expirationDate) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELDOCUMTO_49378', true);
    }
};

//Entity: NaturalPerson
//NaturalPerson.birthDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DATEFIELDKWUZZN_303739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.FechaNacimiento(entities.NaturalPerson.birthDate,edadMin, edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }
};

//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DOCUMENTTYPEFZR_461739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        entities.NaturalPerson.documentNumber =" ";
        //changedEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: LegalPerson
    //LegalPerson.emailAddress (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_EMAILADDRESSOAU_817739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(entities.LegalPerson.emailAddress)){
            changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }
    };

//Entity: NaturalPerson
    //NaturalPerson.email (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_EMAILVIWJAKIOCI_922739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(entities.NaturalPerson.email)){
            changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }
    };

//Entity: Person
    //Person.typePerson (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    //Tipo de documento
    task.change.VA_TEXTINPUTBOXBFT_518739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        //changedEventArgs.commons.serverParameters.Person = true;
        if (entities.Person.typePerson == "P"){            
            changedEventArgs.commons.api.viewState.hide('G_GENERALAIR_501739');
            changedEventArgs.commons.api.viewState.hide('G_GENERALEAO_954739'); 
            changedEventArgs.commons.api.viewState.show('G_GENERALKTA_486739');
            task.clearNaturalPerson(entities);
            task.clearLegalPerson(entities);
            task.clearSpousePerson(entities);
        }
       if (entities.Person.typePerson == "C"){
           changedEventArgs.commons.api.viewState.hide('G_GENERALKTA_486739');
           changedEventArgs.commons.api.viewState.hide('G_GENERALEAO_954739');
           changedEventArgs.commons.api.viewState.show('G_GENERALAIR_501739');
           task.clearNaturalPerson(entities);
           task.clearLegalPerson(entities);
           task.clearSpousePerson(entities);
        }
        

    };

//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXBXR_146739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.surname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.NaturalPerson.surname = null;
    }  
};

//Entity: LegalPerson
    //LegalPerson.documentNumber (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXDXR_200739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.LegalPerson = true;
    };

//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXFGQ_850739 = function(  entities, changedEventArgs ) {

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
    //NaturalPerson.genderCode (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXGXM_696739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        //task.showHideSpouceInformation(entities, changedEventArgs);
    };

//Entity: NaturalPerson
    //NaturalPerson.maritalStatusCode (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXJOG_550739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        //task.showHideSpouceInformation(entities, changedEventArgs);
    };

//Entity: NaturalPerson
    //NaturalPerson.documentNumber (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXNJK_823739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
    if (entities.Context.renapoByCurp == 'S') {
        entities.NaturalPerson.firstName = null;
        entities.NaturalPerson.secondName = null;
        entities.NaturalPerson.surname = null;
        entities.NaturalPerson.secondSurname = null;
        entities.NaturalPerson.birthDate = null;
        entities.NaturalPerson.genderCode = null;
        entities.NaturalPerson.countyOfBirth = null;
    }
        
    };

//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXVEC_991739 = function(entities, changedEventArgs) {

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

//Entity: SpousePerson
    //SpousePerson.documentNumber (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXXGF_770739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: NaturalPerson
    //NaturalPerson.bioCIC (TextInputBox) View: GeneralForm
    
    task.customValidate.VA_BIOCICSOGTHMGMK_830739 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 9,9, "N", "CSTMR.MSG_CSTMR_CAMPODETR_21780");
    }
        
    };

//Entity: NaturalPerson
    //NaturalPerson.bioEmissionNumber (TextInputBox) View: GeneralForm
    
    task.customValidate.VA_BIOEMISSIONNUUU_579739 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 2,2, "A", "CSTMR.MSG_CSTMR_CAMPODEBT_21506");
    }
    
    };

//Entity: NaturalPerson
    //NaturalPerson.bioOCR (TextInputBox) View: GeneralForm
    
    task.customValidate.VA_BIOOCRPFNDHELMR_160739 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 13,13, "N", "CSTMR.MSG_CSTMR_CAMPODE1E_73658");
    }
        
    };

//Entity: NaturalPerson
    //NaturalPerson.bioReaderKey (TextInputBox) View: GeneralForm
    
    task.customValidate.VA_BIOREADERKEYXPM_644739 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 18,18, "A", "CSTMR.MSG_CSTMR_CAMPODENR_14381");
    }
        
    };

//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXBXR_146739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto    
        
};

//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXDFU_862739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto  
};

//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXDTF_989739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto    
 };

//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXFGQ_850739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto
    
};

//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXNVW_269739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 30); //el 0 es sin punto
};

//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXVEC_991739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 30); //el 3 es con punto y espacio   
};

//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXVJE_867739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 1, 20); //el 1 es con punto
};

//Entity: NaturalPerson
//NaturalPerson.firstName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXWXT_116739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 20); //el 3 es con punto y espacio
        
};

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

//Start signature to callBack event to VA_VABUTTONUBNHVJA_668739
task.executeCommandCallback.VA_VABUTTONUBNHVJA_668739 = function(entities, executeCommandCallbackEventArgs) {
    var controls = [];
    if(executeCommandCallbackEventArgs.success){
        if(entities.Person.operation == 'I'){
           executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSRXH_631566', true);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSLJO_139566', true);           
        }else if(entities.Person.operation == 'U'){
           executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        }
        
        if (entities.NaturalPerson.bioRenapo == 'S'){
            executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_SSC');
        }
        
       /*Se comenta por Biométricos, se activan los campos*/
        /*controls =  [
                'VA_TEXTINPUTBOXBFT_518739','VA_TEXTINPUTBOXWXT_116739','VA_TEXTINPUTBOXVEC_991739','VA_TEXTINPUTBOXBXR_146739',                      
                'VA_TEXTINPUTBOXFGQ_850739','VA_DOCUMENTTYPEFZR_461739','VA_TEXTINPUTBOXNJK_823739','VA_DATEFIELDEXOTID_585739',
                'VA_EMAILVIWJAKIOCI_922739','VA_TEXTINPUTBOXGXM_696739','VA_DATEFIELDKWUZZN_303739','VA_TEXTINPUTBOXJOG_550739',
                'VA_TEXTINPUTBOXECU_912739','VA_TEXTINPUTBOXHWM_415739','VA_TEXTINPUTBOXVJE_867739','VA_TEXTINPUTBOXNVW_269739',
                'VA_TEXTINPUTBOXDTF_989739','VA_TEXTINPUTBOXDFU_862739','VA_TEXTINPUTBOXDYK_693739','VA_TEXTINPUTBOXXGF_770739',
                'VA_DATEFIELDKPKNOQ_427739','VA_BIRTHDATEHFEDFC_460739','VA_TEXTINPUTBOXTMT_413739','VA_TEXTINPUTBOXBNS_113739',
                'VA_TEXTINPUTBOXKUG_213739','VA_TEXTINPUTBOXNLL_783739','VA_TEXTINPUTBOXDXR_200739',
                'VA_TEXTINPUTBOXXTK_742739','VA_EMAILADDRESSOAU_817739','VA_GENDERCODEVBBDG_772739', 'VA_9419JJQLECKWUON_319739',
                'VA_COUNTYOFBIRTHHH_490739','VA_COUNTRYOFBIRHTH_170739'];*/
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4',true);        
        //task.disableFields (executeCommandCallbackEventArgs, controls, true);

        if(entities.LegalPerson.personSecuential!=null){
            entities.CustomerTmp.code=entities.LegalPerson.personSecuential;
        }else if(entities.NaturalPerson.personSecuential!=null){
            entities.CustomerTmp.code=entities.NaturalPerson.personSecuential;
        }
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VC_OHGJMSCFAL_971769');

        if (entities.Context.renapoByCurp == 'S') {
        executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MR6', true);
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXNJK_823739');
        }
    } else {
        if (entities.Context.renapoByCurp == 'S') {
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MR6', true);
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXNJK_823739');
    }
    }
};


//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: GeneralForm
    task.initData.VC_GENERALYFB_798723 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.Person.typePerson ="P"
    };

//Entity: SpousePerson
    //SpousePerson.countryOfBirth (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTRYOFBIRHTH_170739 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.SpousePerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.countyOfBirth (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTYOFBIRTHHH_490739 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_DOCUMENTTYPEFZR_461739 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: Person
    //Person.typePerson (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXBFT_518739 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
         var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = "P";
        valores[0].value = "Natural";
        valores[1] = new resultado();
        valores[1].code = "C";
        valores[1].value = "Juridica";
        return valores;
    };

//Entity: SpousePerson
    //SpousePerson.documentType (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXDYK_693739 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.SpousePerson = true;
    };

//Entity: LegalPerson
    //LegalPerson.documentType (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXNLL_783739 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.LegalPerson = true;
    };



}));