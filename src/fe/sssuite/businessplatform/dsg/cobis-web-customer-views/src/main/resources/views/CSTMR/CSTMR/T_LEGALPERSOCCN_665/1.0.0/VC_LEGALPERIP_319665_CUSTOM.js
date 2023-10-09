
/* variables locales de T_LEGALPERSOCCN_665*/

/* variables locales de T_LEGALPERSOENE_749*/

/* variables locales de T_GENERALLEGNAP_980*/

/* variables locales de T_LEGALREPREIEV_573*/

/* variables locales de T_ECONOMICINANG_249*/

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

    
        var task = designerEvents.api.legalpersoncomposite;
    

    //"TaskId": "T_LEGALPERSOCCN_665"
var showHeader = true;
var section = null;
task.closeModalEvent.findCustomer = function (args) {
    if (args.result.params.mode == "findCompany") {
        args.model.LegalPerson.personSecuential = args.result.selectedData.code;
        args.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
    }
    else if (args.result.params.mode == "findRepresentative") {
        args.model.LegalRepresentative.legalRepresentativeCode = args.result.selectedData.code;
        args.model.LegalRepresentative.legalRepresentativeDescription = args.result.selectedData.name;
    }
};

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

	//Start signature to callBack event to CM_TLEGALPE_CLM
task.executeCommandCallback.CM_TLEGALPE_CLM = function (entities, executeCommandEventArgs) {
    if (executeCommandEventArgs.success) {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        if (executeCommandEventArgs.commons.api.parentVc.model != null && executeCommandEventArgs.commons.api.parentVc.model != undefined && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
            executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
        if (section != null) {
            var response = {
                operation: "U",
                section: section,
                clientId: entities.LegalPerson.personSecuential
            };
            executeCommandEventArgs.commons.api.vc.parentVc.responseEvent(response);
        }
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: LegalPersonComposite
task.initData.VC_LEGALPERIP_319665 = function (entities, initDataEventArgs) {
   initDataEventArgs.commons.execServer = false;
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
	var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;
	
    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined){
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
			url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
			files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
        }];
        nav.customDialogParameters = {
            mode: "findCompany"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
    }else if(customDialogParameters !=null && customDialogParameters!=undefined && parentParameters.Task == undefined){
        showHeader = false;
        entities.LegalPerson.personSecuential = customDialogParameters.clientId;
        section = customDialogParameters.section;
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
	}else if( (customDialogParameters !=null || customDialogParameters != undefined) && parentParameters.Task != undefined){
        showHeader = false;
        var task = parentParameters.Task;
		if (task != null){
            entities.LegalPerson.personSecuential = task.clientId;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
        }
    }
};

	//Entity: LegalPerson
    //LegalPerson. (Button) View: GeneralLegalPerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    //Busca la persona en función del código
    task.executeCommand.VA_VABUTTONECKBAAP_763218 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.serverParameters.LegalPerson = true;
        executeCommandEventArgs.commons.serverParameters.LegalRepresentative = true;
        executeCommandEventArgs.commons.serverParameters.EconomicInformationLegalPerson = true;
       
    };

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

	//Entity: LegalRepresentative
    //LegalRepresentative.undefinedEffectiveDate (CheckBox) View: LegalRepresentative
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_UNDEFINEDEFFTED_315183 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(changedEventArgs.newValue==true){
            changedEventArgs.commons.api.viewState.disable('VA_EFFECTIVEDATEEE_633183');
          
             entities.LegalRepresentative.effectiveDate=undefined;
        }else{
            changedEventArgs.commons.api.viewState.enable('VA_EFFECTIVEDATEEE_633183');
        }
        
    };

	//Entity: LegalRepresentative
    //LegalRepresentative. (ImageButton) View: LegalRepresentative
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VAIMAGEBUTTONNN_454183 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
        //nav.label = cobis.translate('LATFO.DLB_LATFO_LIENTLAIM_54829');
        nav.label='B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
            url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                }];
        nav.customDialogParameters = {
            mode:"findRepresentative"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
        
    };



}));