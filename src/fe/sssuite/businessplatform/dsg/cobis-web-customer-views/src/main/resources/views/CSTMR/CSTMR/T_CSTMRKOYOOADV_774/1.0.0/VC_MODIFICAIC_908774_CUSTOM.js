/* variables locales de T_CSTMRKOYOOADV_774*/
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

    
        var task = designerEvents.api.modificationcurprfcform;
    

    //"TaskId": "T_CSTMRKOYOOADV_774"
var taskHeader = {};
var nombreCompleto = '';
var nombre2 = '';
var apellido2 ='';
var nombreGrupo = '';
var idGrupo = '';
var perteneceGroup = 'N';

task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    args.model.NaturalPerson.personSecuential = resp.CodeReceive;
	args.commons.api.vc.executeCommand('VA_VABUTTONBISUTWO_919882', 'FindCustomer', undefined, true, false, 'VC_MODIFICAIC_908774', false);
};

    // (Button) 
task.executeCommand.CM_TCSTMRKO_C00 = function(entities, executeCommandEventArgs) {
	var valueCurp = entities.NaturalPerson.documentNumber;
	var valueRFC = entities.NaturalPerson.identificationRFC;
	var valueCodSantander = entities.NaturalPerson.santanderCode;
	var valueCuentaIndiv = entities.NaturalPerson.accountIndividual;
	var updateCuentaCodIndiv = 'S'
	
	if (entities.NaturalPerson.santanderCode == null)
	    entities.NaturalPerson.santanderCode = ''
		
	if (entities.NaturalPerson.accountIndividual  == null)
	    entities.NaturalPerson.accountIndividual = ''
		
	if (entities.NaturalPerson.santanderCode == '' && entities.NaturalPerson.accountIndividual == '')
		updateCuentaCodIndiv = 'N'
	
	if ((entities.NaturalPerson.santanderCode == '' && entities.NaturalPerson.accountIndividual != '') ||
	    (entities.NaturalPerson.santanderCode != '' && entities.NaturalPerson.accountIndividual == '' ))
        updateCuentaCodIndiv = 'S'
	
	if (updateCuentaCodIndiv == 'N') {
	    if(valueCurp.length == 18){
	    	if(valueRFC.length == 13){
	    		    executeCommandEventArgs.commons.execServer = true;
	    	}else{
	    		executeCommandEventArgs.commons.execServer = false;
	    		executeCommandEventArgs.commons.messageHandler.showMessagesError('El RFC debe tener 13 car\u00E1cteres');
	    	}
	    }else{
	    	executeCommandEventArgs.commons.execServer = false;
	    	executeCommandEventArgs.commons.messageHandler.showMessagesError('El N\u00FAmero de Documento debe tener 18 car\u00E1cteres');
	    }
	} else {
	    if(valueCurp.length == 18){
	    	if(valueRFC.length == 13){
	    		if(valueCodSantander.length == 8){
	    			if(valueCuentaIndiv.length == 12){
	    				executeCommandEventArgs.commons.execServer = true;
	    			}else{
	    				executeCommandEventArgs.commons.execServer = false;
	    				executeCommandEventArgs.commons.messageHandler.showMessagesError('La Cuenta Individual debe tener 12 car\u00E1cteres');
	    			}
	    		}else{
	    		    executeCommandEventArgs.commons.execServer = false;
	    			executeCommandEventArgs.commons.messageHandler.showMessagesError('El C\u00F3digo Santander debe tener 8 car\u00E1cteres');			
	    		}
	    	}else{
	    		executeCommandEventArgs.commons.execServer = false;
	    		executeCommandEventArgs.commons.messageHandler.showMessagesError('El RFC debe tener 13 car\u00E1cteres');
	    	}
	    }else{
	    	executeCommandEventArgs.commons.execServer = false;
	    	executeCommandEventArgs.commons.messageHandler.showMessagesError('El N\u00FAmero de Documento debe tener 18 car\u00E1cteres');
	    }
	}
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
};

// (Button) 
    task.executeCommandCallback.CM_TCSTMRKO_C00 = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
		if (executeCommandCallbackEventArgs.success) {
			LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.NaturalPerson.documentNumber, 1);
			LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_MODIFICRNF_489882');
			executeCommandCallbackEventArgs.commons.api.viewState.show('G_MODIFICRNF_489882');
		}        
    };

// (Button) 
    task.executeCommand.VA_VABUTTONBISUTWO_919882 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.NaturalPerson = true; 
        executeCommandEventArgs.commons.serverParameters.Person = true; 
        executeCommandEventArgs.commons.execServer = true;
    };

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

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ModificationCURPRFCForm
    task.initData.VC_MODIFICAIC_908774 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.serverParameters.NaturalPerson = true;
    
        var nav = initDataEventArgs.commons.api.navigation;
        var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
        var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
        var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;       
        
        if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
	    	initDataEventArgs.commons.execServer = false;
	    	initDataEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
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
                mode: "findCustomer"
            };
            nav.modalProperties = {
                size: 'lg'
            };
            nav.openCustomModalWindow('findCustomer');
		}

    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ModificationCURPRFCForm
    task.initDataCallback.VC_MODIFICAIC_908774 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;        
    };

//Entity: NaturalPerson
    //NaturalPerson.countyOfBirth (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTYOFBIRTHHH_156882 = function( loadCatalogDataEventArgs ) { 
        loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
        loadCatalogDataEventArgs.commons.serverParameters.Person = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_DOCUMENTTYPEMOR_836882 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };

//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_DOCUMENTTYPEMOR_836882 = function(entities, loadCatalogCallbackDataEventArgs ) {
        loadCatalogCallbackDataEventArgs.commons.execServer = false;
    };



}));