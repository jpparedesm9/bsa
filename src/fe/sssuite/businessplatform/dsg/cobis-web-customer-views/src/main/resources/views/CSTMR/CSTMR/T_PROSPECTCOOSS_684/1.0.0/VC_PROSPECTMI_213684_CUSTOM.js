
/* variables locales de T_PROSPECTCOOSS_684*/
/* Importar Script de Mapas */
var script_tag = document.createElement('script');
script_tag.setAttribute("type","text/javascript");
script_tag.setAttribute("src", "https://maps.googleapis.com/maps/api/js?key=AIzaSyBRdzwaUFdmAGF8ExiNkTG3upBjWqIyP0c");
(document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);

/* variables locales de T_GENERALMZYUAQ_723*/

/* variables locales de T_ADDRESSKSQYAJ_769*/

/* variables locales de T_CSTMRAUGMCYDF_966*/

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

    
        var task = designerEvents.api.prospectcomposite;
    

    //"TaskId": "T_PROSPECTCOOSS_684"
var showHeader = true;
var section = null;
var casado = null;
var unionLibre = null;
var edadMin = 0;
var edadMax = 0;
var today ='';

var dirResidencia=null;
var dirNegocio=null;
var cargaInicial = false;
var activeChange = false;
var screenMode = null;
var activeChangeIniDocs = false; //caso153311
var typeRequest = ''; //caso#162288
var mode = ''; //caso#162288
var channel = 4; // tabla cl_canal caso203112

//Limpiar Persona Natural
task.clearNaturalPerson = function (entities) {
    entities.NaturalPerson.personSecuential = '';
    entities.NaturalPerson.firstName = '';
    entities.NaturalPerson.secondName = '';
    entities.NaturalPerson.surname = '';
    entities.NaturalPerson.secondSurname = '';
    entities.NaturalPerson.marriedSurname = '';
    entities.NaturalPerson.email = '';
};
//Limpiar Persona Juridica
task.clearLegalPerson = function (entities) {
    entities.LegalPerson.personSecuential = '';
    entities.LegalPerson.emailAddress = '';
    entities.LegalPerson.businessName = '';
    entities.LegalPerson.tradename = '';
};
//Limpiar Persona Conyuge
task.clearSpousePerson = function (entities) {
    entities.SpousePerson.personSecuential = '';
    entities.SpousePerson.firstName = '';
    entities.SpousePerson.secondName = '';
    entities.SpousePerson.surname = '';
    entities.SpousePerson.secondSurname = '';
};
task.showHideSpouceInformation = function (entities, args) {
    if (entities.NaturalPerson.maritalStatusCode == entities.Context.married) {
        if (entities.NaturalPerson.genderCode == "F") {
            args.commons.api.viewState.show('VA_TEXTINPUTBOXECU_912739');
        }
        else {
            args.commons.api.viewState.hide('VA_TEXTINPUTBOXECU_912739');
        }
        args.commons.api.viewState.show('G_GENERALEAO_954739');
        args.commons.api.viewState.enable('VA_GENDERCODEVBBDG_772739');
    }
    else {
        args.commons.api.viewState.hide('VA_TEXTINPUTBOXECU_912739');
        args.commons.api.viewState.hide('G_GENERALEAO_954739');
    }
};
task.disableFields = function (args, controls, disable) {
    if (disable){
        for (var i = 0; i < controls.length; i++) {
            args.commons.api.viewState.disable(controls[i], disable);
        }
    }else{
        for (var i = 0; i < controls.length; i++) {
            args.commons.api.viewState.enable(controls[i]);
        }
    }
};

task.validateOnlyLettersAndSpaces = function (text, type, stringLength) {
    //Las vocales y letras se encuentran en unicode
    if(type === 0){ //0 es sin punto
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA ]{1,"+stringLength +"}$");
    }else if(type === 1){ //1 es con punto
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA.]{1,"+stringLength +"}$");
    }else if(type === 3){ //3 es con punto y espacio cs: 150907
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA. ]{1,"+stringLength +"}$");
    }
    
    if (expreg.test(text)) {
            return true;
    }
    return false;
};


task.FechaNacimiento = function (fecha, edadMin, edadMax) {
    var birthday = new Date(fecha);    
    var years = today.getFullYear() - birthday.getFullYear();
    birthday.setFullYear(today.getFullYear());
    //if (today < birthday)
    if (today < birthday) {
        years--;
    }
    if (fecha == null) {
        return false;
    }
    if ((years < edadMin) || (years > edadMax)) {
        return false;
    }
    else {
        return true;
    }
};
task.ValidaVencimiento = function (fecha) {
    //var today = new Date();
    if (fecha.getTime() <= today.getTime()) {
        return false;
    }
    return true;
}

    	//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: ProspectComposite
    task.changeGroup.VC_VUWWUPIBAH_277684 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;
        if (changeGroupEventArgs.commons.item.id == 'VC_RIZJHPLTPZ_320966') {
            var customerId = entities.CustomerTmp.code;
            if (customerId != undefined) {
                var filtro ={
                    customerId:customerId,
                    processInstance:"0"
                };
                //bioHasFingerprint>>N: Tiene Huella Dactilar, S: No tiene Huella Dactilar
                var filtro2 = {
                    origen: "P",
                    sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                };
                changeGroupEventArgs.commons.api.vc.parentVc = {}
                changeGroupEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro2;
                
                //Refresh de la grilla para llenar la entidad
                changeGroupEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
            }
        }
    };

	// (Button) 
    task.executeCommand.CM_TPROSPEC_MR6 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;

    if (entities.NaturalPerson.documentNumber == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECOMSL_54956', true);
        executeCommandEventArgs.commons.execServer = false;
    }
    };

	//Start signature to Callback event to CM_TPROSPEC_MR6
task.executeCommandCallback.CM_TPROSPEC_MR6 = function(entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4', true);
    } else {
        executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4', true);
    }
};


	// (Button) 
task.executeCommand.CM_TPROSPEC_MT4 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var confirmMsg = '';
    var ejecuta = 0;
    var aux = 0;
    var collectives = executeCommandEventArgs.commons.api.vc.catalogs.VA_7690NBEFQLFYVXT_868739.data();

    for (let i = 0; i < collectives.length; i++) {
        if (collectives[i].code === entities.NaturalPerson.colectivo) {
            confirmMsg = 'Tipo de Mercado ' + collectives[i].value + ', \u00bfest\u00e1 seguro de su selecci\u00f3n?';
            break;
        }
    }

    //Validacion de personas naturales
    if (entities.NaturalPerson.surname == null || entities.NaturalPerson.genderCode == null || entities.NaturalPerson.firstName == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECOMSL_54956', true);
    } else {
        if (task.FechaNacimiento(entities.NaturalPerson.birthDate, edadMin, edadMax) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
            aux = 1;
        }
        if (entities.NaturalPerson.expirationDate != null && task.ValidaVencimiento(entities.NaturalPerson.expirationDate) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELDOCUMTO_49378', true);
            aux = 1;
        }

    }

    /*if ("INE" == entities.NaturalPerson.bioIdentificationType) {
        if (null == entities.NaturalPerson.bioCIC || "" == entities.NaturalPerson.bioCIC.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_CICESOBIT_15951', true);
            aux = 1;
        }
    } else if ("IFE" == entities.NaturalPerson.bioIdentificationType) {
        if (null == entities.NaturalPerson.bioReaderKey || "" == entities.NaturalPerson.bioReaderKey.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_CLAVEDERR_16854', true);
            aux = 1;
        }
        if (null == entities.NaturalPerson.bioOCR || "" == entities.NaturalPerson.bioOCR.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_OCRESOBIT_95215', true);
            aux = 1;
        }
        if (null == entities.NaturalPerson.bioEmissionNumber || "" == entities.NaturalPerson.bioEmissionNumber.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_NUMERODGS_28759', true);
            aux = 1;
        }

    }*/

    if (null == entities.NaturalPerson.colectivo || "" == entities.NaturalPerson.colectivo.trim()) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.LBL_CSTMR_TIPODEMOT_65400', true);
        aux = 1;
    }
    if (aux == 0) {
        ejecuta = 1;
        entities.NaturalPerson.numCycles;
        entities.NaturalPerson.countyOfBirth;
    }

    if (entities.NaturalPerson.bioIdentificationType == 'INE') {
        entities.NaturalPerson.bioEmissionNumber = null;
        entities.NaturalPerson.bioOCR = null;
        entities.NaturalPerson.bioReaderKey = null;
    } else {
        entities.NaturalPerson.bioCIC = null;
    }
    //Ejecutar el boton
    if (ejecuta == 1) {
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.label = 'Advertencia';
        nav.address = {
            moduleId: 'CSTMR',
            subModuleId: 'CSTMR',
            taskId: 'T_CSTMRRJEZNQUS_394',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CONFIRMMGG_786394'
        };
        nav.queryParameters = {
            mode: 2
        };
        nav.modalProperties = {
            size: "sm"
        };
        nav.customDialogParameters = {
            mMessage: confirmMsg
        }
        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
    }


};

	// (Button) 
    task.executeCommand.CM_TPROSPEC_STR = function(entities, executeCommandEventArgs) {      
        executeCommandEventArgs.commons.execServer = true;
        var physicalAddresses = entities.PhysicalAddress.data();
        var virtualAddresses = entities.VirtualAddress.data();
        var hasMainPhisicalAddress = false;
        entities.Context.channel = channel; // caso203112
		
        for(var i = 0; i < physicalAddresses.length; i++){
             if(physicalAddresses[i].isMainAddress)
             {
               hasMainPhisicalAddress = true;
             }
         }
         executeCommandEventArgs.commons.serverParameters.Context=true;
         if(hasMainPhisicalAddress && virtualAddresses.length > 0){
             executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
         }else {
             executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243',false);
             executeCommandEventArgs.commons.execServer = false;          
         }
    };

	//Start signature to Callback event to CM_TPROSPEC_STR
task.executeCommandCallback.CM_TPROSPEC_STR = function(entities, executeCommandCallbackEventArgs) {
//here your code
    var  controls = [];
    
     if(executeCommandCallbackEventArgs.success ){  
         if(entities.NaturalPerson.riskLevel!='ROJO' && entities.NaturalPerson.santanderCode!=null){
            executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_T8S',true);
            executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_STR',true); 
        } /*else {  //se envia en el java
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError('CSTMR.LBL_CSTMR_ELNIVELUT_98836',true);
        }*/
         
         if ( entities.NaturalPerson.bioRenapoResult == 'S'){
            controls =  [
                'VA_TEXTINPUTBOXBFT_518739','VA_TEXTINPUTBOXWXT_116739','VA_TEXTINPUTBOXVEC_991739','VA_TEXTINPUTBOXBXR_146739',                      
                'VA_TEXTINPUTBOXFGQ_850739','VA_DOCUMENTTYPEFZR_461739','VA_TEXTINPUTBOXNJK_823739','VA_DATEFIELDEXOTID_585739',
                'VA_EMAILVIWJAKIOCI_922739','VA_TEXTINPUTBOXGXM_696739','VA_DATEFIELDKWUZZN_303739','VA_TEXTINPUTBOXJOG_550739',
                'VA_TEXTINPUTBOXECU_912739','VA_TEXTINPUTBOXHWM_415739','VA_TEXTINPUTBOXVJE_867739','VA_TEXTINPUTBOXNVW_269739',
                'VA_TEXTINPUTBOXDTF_989739','VA_TEXTINPUTBOXDFU_862739','VA_TEXTINPUTBOXDYK_693739','VA_TEXTINPUTBOXXGF_770739',
                'VA_DATEFIELDKPKNOQ_427739','VA_BIRTHDATEHFEDFC_460739','VA_TEXTINPUTBOXTMT_413739','VA_TEXTINPUTBOXBNS_113739',
                'VA_TEXTINPUTBOXKUG_213739','VA_TEXTINPUTBOXNLL_783739','VA_TEXTINPUTBOXDXR_200739','CM_TPROSPEC_MT4',
                'VA_TEXTINPUTBOXXTK_742739','VA_EMAILADDRESSOAU_817739','VA_GENDERCODEVBBDG_772739', 'VA_9419JJQLECKWUON_319739',
                'VA_COUNTYOFBIRTHHH_490739','VA_COUNTRYOFBIRHTH_170739'];
             executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4',true); 
             LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        }
         
     }
       
	   //Reporte
    if (entities.Context.generateReport) {
	     var nameReport = entities.Context.nameReport;
	     var tittle = "";	
         if(entities.Context.printReport){
			 var args = [['report.module', 'customer'],['report.name', nameReport],['idCustomer',entities.NaturalPerson.personSecuential]];	
			 if(nameReport === 'BuroCreditoHistorico'){
				 tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTETI_28269');
			}else if(nameReport === 'BuroCreditoInternoExterno'){
				tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTEEI_96019');
			}
			LATFO.UTILS.generarReporte(nameReport, args, tittle); 
		 }else{
			 executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesInfo('CSTMR.MSG_CSTMR_ELREPOREE_57555');
         }       
        if(entities.ScannedDocumentsDetail.data().length != 0){
            for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                if(entities.ScannedDocumentsDetail.data()[i].uploaded === false){
                    executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("No est\u00e1n cargados todos los documentos");
                }
            }
        }
     }
};

	// (Button) 
task.executeCommand.CM_TPROSPEC_T8S = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var clientCode = null;
    var physicalAddresses = entities.PhysicalAddress.data();
    var virtualAddresses = entities.VirtualAddress.data();
    var hasMainPhisicalAddress = false;
    for (var i = 0; i < physicalAddresses.length; i++) {
        if (physicalAddresses[i].isMainAddress) {
            hasMainPhisicalAddress = true;
        }
    }

    if (hasMainPhisicalAddress && virtualAddresses.length > 0) {


        if (entities.Person.typePerson == 'P') {
            clientCode = entities.NaturalPerson.personSecuential;
        } else if (entities.Person.typePerson == 'C') {
            clientCode = entities.LegalPerson.personSecuential;
        }

        if (clientCode != null) {
            //var url = "/CTSProxy/services/cobis/web/views/clientviewer/container-clientviewer.html?ClientId=" + clientCode;
            var url = "/CTSProxy/services/cobis/web/views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html?ClientId=" + clientCode;
            //var menu = "Vista Consolidada";
            var menu = "Mantenimiento de Personas Naturales";
            cobis.container.tabs.openNewTab(menu, url, menu, true);
        }
    } else {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243', true);
    }
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ProspectComposite
task.initData.VC_PROSPECTMI_213684 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.api.viewState.disable('G_GENERALEAO_954739');
    initDataEventArgs.commons.api.viewState.disable('VC_OHGJMSCFAL_971769');
    initDataEventArgs.commons.api.viewState.disable('VC_RIZJHPLTPZ_320966');
    initDataEventArgs.commons.api.viewState.hide('G_ADDRESSLJO_139566');
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXJOG_550739');//estado civil
    //task.showHideSpouceInformation(entities, initDataEventArgs);
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ProspectComposite
task.initDataCallback.VC_PROSPECTMI_213684 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function (processDate) {
        today = processDate;
        today = new Date(today);
    });
    
    if(initDataEventArgs.success){
        //Asignacion de la consulta de parametros
        edadMax = entities.Context.maximumAge;
        edadMin = entities.Context.minimumAge;
        casado = entities.Context.married;
        unionLibre = entities.Context.freeUnion;
        dirResidencia = entities.Context.flag2;
        dirNegocio = entities.Context.flag3;
    
        /* Req. 178652
        entities.NaturalPerson.colectivo = entities.Context.collective;*/
        entities.NaturalPerson.nivelColectivo = entities.Context.collectiveLevel;    
    }
    
};

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ProspectComposite
task.onCloseModalEvent = function(entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_CONFIRMMGG_786394') {
        let option = onCloseModalEventArgs.result === null ? 2 : onCloseModalEventArgs.result.option;
        if (option === 1) {

            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONUBNHVJA_668739', 'save', undefined, true, false, 'VC_PROSPECTMI_213684', false);


        } else {
		    //(accion, padre, hijo-del la misma pantalla compuesta)
		    onCloseModalEventArgs.commons.api.vc.clickTab(onCloseModalEventArgs, 'VC_VUWWUPIBAH_277684', 'VC_ODXEZDWELG_370723', true);
			
		    $("#VC_ODXEZDWELG_370723_tab").prop("class","active"); // a que opcion debe ir
			$("#VC_OHGJMSCFAL_971769_tab").removeClass("active"); // quitar el color de la opcion donde estaba
			$("#VC_RIZJHPLTPZ_320966_tab").removeClass("active"); // quitar el color de la opcion donde estaba

            return;
        }
    }

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if (onCloseModalEventArgs.result.resultArgs !== null) {

            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                } else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }

        }
    }
};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ProspectComposite
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
	    renderEventArgs.commons.api.viewState.disable('G_ADDRESSRXH_631566', true);
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSLJO_139566', true);
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_T8S', true);   
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_STR', true);

    if (entities.Context.renapoByCurp == 'S') {
        renderEventArgs.commons.api.viewState.show('CM_TPROSPEC_MR6', true);
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4', true);
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXNJK_823739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXWXT_116739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXVEC_991739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXBXR_146739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXFGQ_850739');
        renderEventArgs.commons.api.viewState.disable('VA_DATEFIELDKWUZZN_303739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXGXM_696739');
        renderEventArgs.commons.api.viewState.disable('VA_COUNTYOFBIRTHHH_490739');
    } else {
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MR6', true);
        renderEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4', true);
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXNJK_823739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXWXT_116739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXVEC_991739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXBXR_146739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXFGQ_850739');
        renderEventArgs.commons.api.viewState.enable('VA_DATEFIELDKWUZZN_303739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXGXM_696739');
        renderEventArgs.commons.api.viewState.enable('VA_COUNTYOFBIRTHHH_490739');
    }
    };

	//Evento validateTransaction : Permite validar los datos antes de cerrar la ventana modal / Permite validar los datos de una tarea antes de enviarlos a persistir
    //ViewContainer: ProspectComposite
    task.validateTransaction.VC_PROSPECTMI_213684 = function (entities, executeEventArgs){
               renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSRXH_631566', true);
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSLJO_139566', true);
   
        
    };

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

	//Entity: VirtualAddress
    //VirtualAddress.addressDescription (TextInputBox) View: AddressForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXILB_303566 = function(  entities, changedEventArgs ) {
     changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(changedEventArgs.rowData.addressDescription)){
         changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }        
    };

	// (Button) 
task.executeCommand.CM_TADDRESS_C49 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    if (executeCommandEventArgs.commons.api.parentVc.model != null && executeCommandEventArgs.commons.api.parentVc.model != undefined && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
        executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
    
    if (section != null) {
       var response = {
           operation: "U",
           section: section,
           clientId: entities.CustomerTmp.code
       };
       executeCommandEventArgs.commons.api.vc.parentVc.responseEvent(response);
    }
};

	//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONWVQOBVO_763566 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    entities.Context.addressState = 'S';
    entities.Context.mailState = 'S';
};

	//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONYDIJDRL_132566 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmp.code == null) {
        entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    executeCommandEventArgs.commons.serverParameters.VirtualAddress = true;
    executeCommandEventArgs.commons.serverParameters.PhysicalAddress = true;
    executeCommandEventArgs.commons.serverParameters.Context = true;

};

	//Entity: CustomerTmp
    //CustomerTmp. (Button) View: AddressForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONYDIJDRL_132566 = function(  entities, executeCommandCallbackEventArgs ) {
        
        //here your code
        if (executeCommandCallbackEventArgs.success) {
            
            if (ban){
              if (showHeader && taskHeader!=undefined &&  taskHeader!=null ) {

                    if(entities.CustomerTmp.customerType == 'P'){
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.name, 0);
                    }else{
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.businessName, 0);
                    }
                    LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmp.documentNumber, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmp.documentType, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmp.code, 2);
                    //LATFO.INBOX.addTaskHeader(taskHeader,'RAZON SOCIAL',entities.LegalPerson.tradename,0);
                    LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_ADDRESSXDI_956566');
                    executeCommandCallbackEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
                } else {
                    //Para VCC
                    executeCommandCallbackEventArgs.commons.api.viewState.hide('G_ADDRESSXDI_956566');
                }
            }
            if(entities.PhysicalAddress.data().length != 0){
				for(var i = 0; i <= entities.PhysicalAddress.data().length - 1; i++){
					if(entities.PhysicalAddress.data()[i].businessCode == 0){
						entities.PhysicalAddress.data()[i].businessCode = null;
					}
				}
        }
        }
    };


	//PhysicalAddressQuery Entity: 
    task.executeQuery.Q_PHYSICDS_4851 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//VirtualAddressQuery Entity: 
    task.executeQuery.Q_VIRTUALD_9303 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridRowRendering QueryView: QV_4851_97960
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_4851_97960 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_4851_97960', 'create');

    if (gridRowRenderingEventArgs.rowData.directionNumberInternal == -1) {
        gridRowRenderingEventArgs.rowData.directionNumberInternal = 0;
    }

    if (screenMode == 'Q') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        var dsAddress = entities.PhysicalAddress.data();
        for (var i = 0; i < dsAddress.length; i++) {
            var dsRow = dsAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_4851_97960', dsRow, 'edit');
        }

        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');

        var dsVirtualAddress = entities.VirtualAddress.data();
        for (var i = 0; i < dsVirtualAddress.length; i++) {
            var dsRow = dsVirtualAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'edit');
        }
    }

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', gridRowRenderingEventArgs.rowData, 'delete');
    }

};

	//gridRowRendering QueryView: QV_9303_67123
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_9303_67123 = function (entities, gridRowRenderingEventArgs) {

    gridRowRenderingEventArgs.commons.execServer = false;
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_9303_67123', 'create');

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'delete');

        if (posDataModRequest != null) {
            if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || entities.Context.roleEnabledDataModRequest != 'S' || entities.Context.mailState != 'N') {
                gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S' && entities.Context.mailState == 'N') {
                gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            }
        }
    }

};

	//gridRowDeleting QueryView: QV_4851_97960
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_4851_97960 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            gridRowDeletingEventArgs.commons.serverParameters.PhysicalAddress = true;
        };

	//Start signature to Callback event to QV_4851_97960
task.gridRowDeletingCallback.QV_4851_97960 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

	//gridRowDeleting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9303_67123 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.VirtualAddress = true;
        };

	//Start signature to Callback event to QV_9303_67123
task.gridRowDeletingCallback.QV_9303_67123 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

	//gridRowInserting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_9303_67123 = function (entities, gridRowInsertingEventArgs) {
            //CustomerTmp se llena desde la VCC o desde la pantalla de Prospectos
            gridRowInsertingEventArgs.rowData.personSecuential=entities.CustomerTmp.code;
            if(LATFO.UTILS.validarEmail(gridRowInsertingEventArgs.rowData.addressDescription)){
                 gridRowInsertingEventArgs.commons.execServer = true;
            }else{
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.api.grid.removeRow('VirtualAddress',0);
            }
        };

	//Start signature to callBack event to QV_9303_67123
    task.gridRowInsertingCallback.QV_9303_67123 = function(entities, gridRowInsertingEventArgs) {
        if(gridRowInsertingEventArgs.success){
          if (section != null){
                var response = { 
                    operation: "U",
                    section: section,
                    clientId: gridRowInsertingEventArgs.rowData.personSecuential
                }; 
        }

        }else{
            cobis.showMessageWindow.loading(false);
        }
    };

	//gridRowUpdating QueryView: QV_4851_97960
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_4851_97960 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.commons.serverParameters.PhysicalAddress = true;
             
            
        };

	//gridRowUpdating QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9303_67123 = function (entities, gridRowUpdatingEventArgs) {
            if(LATFO.UTILS.validarEmail(gridRowUpdatingEventArgs.rowData.addressDescription)){
                 gridRowUpdatingEventArgs.commons.execServer = true;
        entities.Context.mailState = 'S';
            }else{
                gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowUpdatingEventArgs.commons.execServer = false;
            }
        };

	//Start signature to callBack event to QV_9303_67123
    task.gridRowUpdatingCallback.QV_9303_67123 = function(entities, gridRowUpdatingEventArgs) {
        //here your code
    };

	//gridAfterLeaveInLineRow QueryView: QV_7463_28553
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_7463_28553 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'uploaded');
        };

	//gridBeforeEnterInLineRow QueryView: QV_7463_28553
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_7463_28553 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXTFB_124611');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'file');
	    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'uploaded');
        };

	// (Button) 
    task.executeCommand.VA_VABUTTONILJIEMT_921611 = function(  entities, executeCommandEventArgs ) {
       console.log('Ingresa');

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };

	//Start signature to Callback event to VA_VABUTTONILJIEMT_921611
task.executeCommandCallback.VA_VABUTTONILJIEMT_921611 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    console.log('Ingresa a collback')
        if(entities.DocumentsUpload.uploads){
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Los documentos fueron completados', true);
        } else {
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Faltan documentos por subir', true);
        }
};

	//ScannedDocumentsDetQuery Entity: 
    task.executeQuery.Q_SCANNELD_7463 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//Start signature to Callback event to Q_SCANNELD_7463
task.executeQueryCallback.Q_SCANNELD_7463 = function(entities, executeQueryCallbackEventArgs) {
    if (executeQueryCallbackEventArgs.success) {
        var action = true;
        if(entities.ScannedDocumentsDetail.data().length != 0){
            for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                if(entities.ScannedDocumentsDetail.data()[i].uploaded === false){
                    action = false;
                }
            }
        }
        if (action === true){
            executeQueryCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
            executeQueryCallbackEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
        }
    }
	
	// Inicio Caso153311
    if(activeChangeIniDocs){
		activeChange = true
	    activeChangeIniDocs = false
	}// Fin Caso153311
	
    //Click tab inicial
	if(angular.isDefined(cargaInicial) && cargaInicial && angular.isDefined(activeChange) && activeChange){
		executeQueryCallbackEventArgs.commons.api.vc.clickTab(executeQueryCallbackEventArgs,'VC_DDRWXFYTSU_498680', 'VC_KXWIBTYNCU_272226', true);
		$("#VC_KXWIBTYNCU_272226_tab").prop("class","active");
		$("#VC_HVDQINWTYF_467680_tab").removeClass("active");
		cargaInicial = false;
	}
    
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    for (var i = 0; i < scannedDocumentsDetailList.length; i++) {
        if (scannedDocumentsDetailList[i].documentId == '010') {
            posDataModRequest = i;
            break;
        }
    }

};


	task.gridInitColumnTemplate.QV_7463_28553 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
    
};

	task.gridInitEditColumnTemplate.QV_7463_28553 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

	//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail. (Button) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMNDD_972611 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
        var extension = gridRowCommandEventArgs.rowData.extension.trim();
        var formaMapeo = document.createElement("form");
		formaMapeo.method = "POST"; 
		formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";
                     
        if(gridRowCommandEventArgs.rowData.groupId > 0)	{
            var mapeoInput = document.createElement("input");
            mapeoInput.type = "hidden";
            mapeoInput.name = "groupId";
            mapeoInput.value = gridRowCommandEventArgs.rowData.groupId;
            formaMapeo.appendChild(mapeoInput);				
            document.body.appendChild(formaMapeo);
        }
		
        if(gridRowCommandEventArgs.rowData.processInstance > 0){
            var mapeoInput2 = document.createElement("input");
            mapeoInput2.type = "hidden";
            mapeoInput2.name = "processInstanceId";
            mapeoInput2.value = gridRowCommandEventArgs.rowData.processInstance;
            formaMapeo.appendChild(mapeoInput2);				
            document.body.appendChild(formaMapeo);
        }
		
		var mapeoInput3 = document.createElement("input");
        mapeoInput3.type = "hidden";
        mapeoInput3.name = "customerId";
        mapeoInput3.value = gridRowCommandEventArgs.rowData.customerId;
        formaMapeo.appendChild(mapeoInput3);				
        document.body.appendChild(formaMapeo);
		
		var mapeoInput4 = document.createElement("input");
        mapeoInput4.type = "hidden";
        mapeoInput4.name = "fileName";
        mapeoInput4.value = gridRowCommandEventArgs.rowData.documentId+"."+extension;
        formaMapeo.appendChild(mapeoInput4);				
        document.body.appendChild(formaMapeo);
		
		formaMapeo.submit();
  
    };

	//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail.file (FileUpload) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_TEXTINPUTBOXTFB_124611 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = true;
    };

	//Start signature to Callback event to VA_TEXTINPUTBOXTFB_124611
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(entities, gridRowCommandCallbackEventArgs) {
gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';

        var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            entities.Context.addressState = 'N';
            entities.Context.mailState = 'N';
        }
	   }
};

	//gridRowRendering QueryView: QV_7463_28553
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7463_28553 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.viewState.enable('G_SCANNEDCIM_218611');

	if (typeRequest != CSTMR.CONSTANTS.TypeRequest.NORMAL){ //caso#162288
        gridRowRenderingEventArgs.commons.api.viewState.hide('VA_VABUTTONILJIEMT_921611');	
	}
	
    //Funcionalidad para habilitar o deshabilitar el botÃ³n de descarga
    if (gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null) {
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    } else {
        //cambiar esto has corregir error de uid en gridRowUpdating
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
        gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    }
    //Ocultar y desocultar columnas
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'customerName');
    gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'uploaded');
    if (angular.isDefined(gridRowRenderingEventArgs.commons.api.vc.parentVc)) {
        //aprobacion de prestamo
        //gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'cmdEdition');
    }
    
    if(screenMode == 'Q'){ //caso#162288 --se cambio el mode que estaba del caso 162288 a screenMode por problemas en pantalla   
        var ds = entities.ScannedDocumentsDetail.data();
        for (var i = 0; i < ds.length; i++) {   
            var dsRow = ds[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', dsRow, 'edit');            
        }
    }

    if (screenMode != 'Q' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        if (entities.Person.statusCode == 'A' && entities.Context.roleEnabledDataModRequest != 'S' && gridRowRenderingEventArgs.rowData.documentId == '010') {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611');
        }
    }
};

	//gridRowUpdating QueryView: QV_7463_28553
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_7463_28553 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.rowData.extension = gridRowUpdatingEventArgs.rowData.file.substring((gridRowUpdatingEventArgs.rowData.file).lastIndexOf(".")+1);
			gridRowUpdatingEventArgs.rowData.file = "";
            //Descomentar esto cuando en el gridRowUpdatingEventArgs este llegando el uid
            /*if(gridRowUpdatingEventArgs.rowData.uploaded == 'S'){
				gridRowUpdatingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553',gridRowUpdatingEventArgs.rowData,'VA_GRIDROWCOMMMNDD_972611','disabled',true);
			}*/
            var action = true;
            if(entities.ScannedDocumentsDetail.data().length != 0){
                for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                    if(entities.ScannedDocumentsDetail.data()[i].uploaded === 'N'){
                        action = false;
                    }
                }
            }
            if (action === true){
                gridRowUpdatingEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
                gridRowUpdatingEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
            }
        };



}));