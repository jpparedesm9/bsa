
/* variables locales de T_CUSTOMERCOETP_680*/
/* Importar Script de Mapas */
var script_tag = document.createElement('script');
script_tag.setAttribute("type","text/javascript");
script_tag.setAttribute("src", "https://maps.googleapis.com/maps/api/js?key=AIzaSyBRdzwaUFdmAGF8ExiNkTG3upBjWqIyP0c");
(document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);

/* variables locales de T_LEGALPERSOENE_749*/

/* variables locales de T_CUSTOMERGEIFR_226*/

/* variables locales de T_DEMOGRAPHICCC_186*/

/* variables locales de T_CSTMRNHXBRKXO_604*/

/* variables locales de T_CSTMRAUGMCYDF_966*/

/* variables locales de T_ECONOMICINFFF_735*/

/* variables locales de T_ADDRESSKSQYAJ_769*/

/* variables locales de T_BUSINESSFMWNQ_114*/

/* variables locales de T_RELATIONAJNQY_494*/

/* variables locales de T_CSTMRWNGRIQPQ_400*/

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

    
        var task = designerEvents.api.customercomposite;
    

    //"TaskId": "T_CUSTOMERCOETP_680"
var gridRow = 0;
var showHeader = true;
var cedula = '';
var section = null;
var ban=true;
var banBorrado = true;
var numsecuential=0;

var casado= null;
var unionLibre= null;
var edadMin=0;
var edadMax=0;
var pais=0;
var hijo=0;
var padre=0;
var conyugue=0;
var today ='';

var dirResidencia=null;
var dirNegocio=null;
var balanceFlag = false;
var entitiesTmp = null;
var gnralInfoSelected = 0;
var cargaInicial = true;
var activeChange = false;
var screenMode = null;
var activeChangeIniDocs = false; //caso153311
var typeRequest = ''; //caso#162288
var mode = ''; //caso#162288
var posDataModRequest = null;
var channel = 4; // tabla cl_canal caso203112

task.calculateAvailableResults=function(economicInfo){
    economicInfo.availableResults=economicInfo.assets-economicInfo.liabilities;  
};

task.calculateAvailableBalance=function(economicInfo,changedEventArgs){
    
    
    economicInfo.availableBalance = (economicInfo.sales + economicInfo.otherIncomes + economicInfo.businessIncome)
        - (economicInfo.salesCost+economicInfo.operatingCost); 
    if(balanceFlag && screenMode != 'Q'){
        if(economicInfo.availableBalance <= 0){
            changedEventArgs.commons.api.viewState.disable('CM_TCUSTOME_T01');
            changedEventArgs.commons.messageHandler.showMessagesError("ERROR: La capacidad de pago no puede ser menor a 0", true);
        }else{
            changedEventArgs.commons.api.viewState.enable('CM_TCUSTOME_T01');
        }
    }
};

task.calculateAvailableTotal=function(economicInfo){
    economicInfo.availableTotal=(economicInfo.salesCost + economicInfo.operatingCost);  
};

task.calculateAvailableIncome=function(economicInfo){
    economicInfo.availableIncome = ( economicInfo.sales + economicInfo.otherIncomes + economicInfo.businessIncome);
};

task.ableSaveButton=function(economicInfo,args){
    if (screenMode != 'Q'){
        if(economicInfo.availableBalance <= 0){
            args.commons.api.viewState.disable('CM_TCUSTOME_T01');
        }else{
            args.commons.api.viewState.enable('CM_TCUSTOME_T01');
        }
    }
};


task.hideModeQuery = function (args) {
    //Set del campo HiddenInCompleted para poder continuar la tarea
    if (args.commons.api.parentVc.model.InboxContainerPage != undefined) {
        args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
    var api = args.commons.api;
    //CONTROLES DE INFORMACION GENERAL
    api.viewState.disable('VA_TYPEPERSONLSDIM_548213');
    api.viewState.disable('VA_STATUSCODEMPXFC_766213');
    api.viewState.disable('VA_FIRSTNAMEFPYKAF_649213');
    api.viewState.disable('VA_SECONDNAMESJJYD_721213');
    api.viewState.disable('VA_SURNAMESONBWSJR_285213');
    api.viewState.disable('VA_SECONDSURNAMEEE_733213');
    api.viewState.disable('VA_KNOWNASRBNFXSIW_448213');
    api.viewState.disable('VA_DOCUMENTTYPEAQM_964213');
    api.viewState.disable('VA_DOCUMENTNUMBRRE_960213');
    api.viewState.disable('VA_EXPIRATIONDAEET_157213');
    api.viewState.disable('VA_INDEFINITEHGXSF_717213');
    
    api.viewState.disable('VA_GENDERCODEUTLBL_276213');
    api.viewState.disable('VA_BIRTHDATEEXJMQR_157213');
    api.viewState.disable('VA_NATIONALITYCEDE_860213');
    api.viewState.disable('VA_MARITALSTATUDCC_635213');
    api.viewState.disable('VA_MARRIEDSURNAEEM_647213');
    api.viewState.disable('VA_BRANCHCODEYMGYZ_548213');
    api.viewState.disable('VA_OFFICERCODEBNMM_892213');
    //CONTROLES DE DATOS DEMOGRAFICOS
    api.viewState.disable('VA_4568EAAYMQKOEGY_628794');
    api.viewState.disable('VA_2936ZMJTGKVZWYV_843794');
    api.viewState.disable('VA_5585RSUWJIOZDNO_500794');
    api.viewState.disable('VA_8278MLPNECVHLOC_137794');
    api.viewState.disable('VA_8667DCPWKDXLAAQ_828794');
    api.viewState.disable('VA_9304BAVPAVKRZGV_446794');
    api.viewState.disable('VA_4112FQTPIBIJZKD_665794');
    api.viewState.disable('VA_3231VVMQGIEFXXK_586794');
    //CONTROLES DE DATOS ECONOMICOS
    api.viewState.disable('VA_RELATIONIDYUDBN_824168');
    api.viewState.disable('VA_MONTHLYINCOMEEE_603168');
    api.viewState.disable('VA_EXPENSELEVELXRJ_569168');
    api.viewState.disable('VA_INTERNALQUALIIN_988168');
    api.viewState.disable('VA_CATEGORYALMSHLU_711168');
    api.viewState.disable('VA_TUTORIDJFWNDWTD_976168');
    api.viewState.disable('VA_RETENTIONSUBCTE_894168');
    api.viewState.disable('CM_TCUSTOME_T01');
    //CONTROLES DE ACTIVIDADES ECONOMICAS
    $('#QV_2856_77023_CUSTOM_CREATE').hide();
    $('.k-grid-delete').hide();
};

task.validationMarried = function (entities, args) {
    try{
     var api = args.commons.api;
         if (entities.NaturalPerson.maritalStatusCode != null && entities.NaturalPerson.maritalStatusCode == casado){
             if(entities.NaturalPerson.genderCode != null && entities.NaturalPerson.genderCode == "F"){
                 api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = true;
                 api.vc.viewState.Spacer1140.visible = true;
                 api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = true;
             } else if (entities.NaturalPerson.genderCode != null && entities.NaturalPerson.genderCode == "M"){
                 api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = true;
                 api.vc.viewState.Spacer1140.visible = true;
                 api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = false;
                 entities.NaturalPerson.marriedSurname = null;
             }
         }
         else{
            api.vc.viewState.VA_SPOUSEOBTFDFDMW_696213.visible = false;
             api.vc.viewState.Spacer1140.visible = false;
            api.vc.viewState.VA_MARRIEDSURNAEEM_647213.visible = false;
             entities.NaturalPerson.spouse = null;
             entities.NaturalPerson.marriedSurname = null;
         }
    } catch (err) {}
};

//Busqueda de clientes
task.closeModalEvent.findCustomer = function (args) {
    if (args.result.params.mode == "findCustomer"){
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = args.commons.api.vc.dialogParameters.CodeReceive;
    var CustomerName = args.commons.api.vc.dialogParameters.name;
    var identification = args.commons.api.vc.dialogParameters.documentId;
    //args.model.EconomicInformation.tutorName = CustomerName;
    //args.model.EconomicInformation.tutorId = customerCode;
   args.model.NaturalPerson.typePerson="P";
    args.model.NaturalPerson.personSecuential = customerCode;
    args.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213','FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        
   /* args.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566','FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    args.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);
    args.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576','FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
    args.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','FindCustomer', undefined, true, false, 'VC_RELATIONQE_861494', false);*/
        args.model.ComplementaryRequestData.recruitmentChannel = cobis.translate('CSTMR.MSG_CSTMR_PRESENCIA_80568');
        args.model.ComplementaryRequestData.country = cobis.translate('CSTMR.MSG_CSTMR_MXICOPRIL_50526');
    }
    if (args.result.params.mode == "relation"){
        var api = args.commons.api;        
        var resp = args.commons.api.vc.dialogParameters;
        var selectedRow = api.vc.grids.QV_6114_93961.selectedRow;       
        selectedRow.set('namePersonRight', resp.name);
        selectedRow.set('secuentialPersonLeft', args.model.RelationContext.secuential);
		selectedRow.set('secuentialPersonRight', args.result.selectedData.code);
        //args.model.RelationPerson.data()[0].secuentialPersonLeft = codigoCliente;		
    }
	
	//se comenta por caso #157556
    //Filtro para llenado de executeQuery Inicio Caso153311
    //var filtro = {
    //    customerId:customerCode,
    //    processInstance:"0",
    //    sinHuellaDactilar: (args.model.NaturalPerson.bioHasFingerprint == null?"N":args.model.NaturalPerson.bioHasFingerprint)
    //}
	////Refresh de la grilla para llenar la entidad
    //args.commons.api.vc.parentVc = {}
    //args.commons.api.vc.parentVc.customDialogParameters = filtro;
    //args.commons.api.grid.refresh('QV_7463_28553',filtro);
    //activeChangeIniDocs = true
	//Fin Caso153311
};
task.validarCampos = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    try {
        var client = renderEventArgs.commons.api.parentVc;
        var api = renderEventArgs.commons.api;
        if (api.vc.model.DemographicData.hasDisability !== undefined && api.vc.model.DemographicData.hasDisability == "N") {
            api.viewState.disable('VA_3231VVMQGIEFXXK_586794');
        }
        if (api.vc.model.NaturalPerson.expirationDate !== undefined && api.vc.model.NaturalPerson.expirationDate === null) {
            api.vc.model.NaturalPerson.indefinite = true;
            api.viewState.disable('VA_EXPIRATIONDAEET_157213');
        }
        if (client.customDialogParameters.Task.urlParams.MODE !== undefined && client.customDialogParameters.Task.urlParams.MODE == "Q") {
            task.hideModeQuery(renderEventArgs);
            entities.Entity1.screenMode = "Q";
        }
    }
    catch (err) {
        //CSTMR.Utils.managerException(err);
    }
};
task.validarFechaNac = function (entities, changedEventArgs) {
    if (entities.NaturalPerson.indefinite == true && entities.NaturalPerson.birthDate != null) {
            var age = 0;
            var birthDate = entities.NaturalPerson.birthDate;
            //var today = new Date();
            var newDate=new Date(today);
            age = today.getFullYear() - birthDate.getFullYear();            
            newDate.setFullYear(newDate.getFullYear()+100);
            entities.NaturalPerson.expirationDate=newDate;
        
            if (age < entities.Parameters.minimumAge) {
                entities.NaturalPerson.expirationDate = null;
                entities.NaturalPerson.indefinite = false;
                changedEventArgs.commons.messageHandler.showMessagesError("CSTMR.MSG_CSTMR_LAEDADDAO_98111", true);
            }
            else {
                entities.NaturalPerson.expirationDate = entities.Parameters.idExpiration;
                changedEventArgs.commons.api.viewState.disable("VA_EXPIRATIONDAEET_157213");
            }
    }else if(entities.NaturalPerson.indefinite == false){
        changedEventArgs.commons.api.viewState.enable("VA_EXPIRATIONDAEET_157213");
    }
 
};
task.FechaNacimiento = function (fecha, edadMin, edadMax){
    var birthday =new Date(fecha);
    //var today = new Date();
    var years = today.getFullYear() - birthday.getFullYear();
    birthday.setFullYear(today.getFullYear());
    //if (today < birthday)
    var todayDate=today.toISOString().slice(0,10)
    var birthdayDate=birthday.toISOString().slice(0,10)
    if (todayDate < birthdayDate)
        {
            years--;
        }
    if(fecha == null){
        return false;
    }
    if (years < edadMin || years >edadMax)
    {
        return false;
    }else{
        return true;    
    }    

};
task.ValidaVencimiento =  function(fecha){    
    //var today =new Date(today);
    
    if (fecha.getTime() <= today.getTime() ) {
        return false;        
    }
    return true;
};
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(  entities, gridRowCommandCallbackEventArgs ) {
       gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
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
    }else if(type === 4){ //4 permite letras, numeros y espacios
        var expreg = new RegExp("^[a-zA-Z0-9\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA ]{1,"+stringLength +"}$");
    }
    
    if (expreg.test(text)) {
            return true;
    }
    return false;
};

    	//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
//ViewContainer: CustomerComposite
task.changeGroup.VC_DDRWXFYTSU_498680 = function (entities, changeGroupEventArgs) {
    changeGroupEventArgs.commons.execServer = false;    
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;

    var GET = location.search.substr(1).split("?");
    var get = {};
    for (var i = 0, l = GET.length; i < l; i++) {
        var tmp = GET[i].split('=');
        get[tmp[0]] = unescape(decodeURI(tmp[1]));
    }
    screenMode = get.modo;
   
    //INFORMACION GENERAL
    if (changeGroupEventArgs.commons.item.id == 'VC_KXWIBTYNCU_272226') {
        gnralInfoSelected++;
        changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMERIF_745226', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }

    }
    //DATOS DEMOGRAFICOS
    if (changeGroupEventArgs.commons.item.id == 'VC_FTDSYJBGDX_891186') {
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //DIRECCIONES
    if (changeGroupEventArgs.commons.item.id == 'VC_BZHSCWLUJU_302769') {        
        changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
    //NEGOCIO DEL CLIENTE
    if (changeGroupEventArgs.commons.item.id == 'VC_RRLBYDXROB_523114') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    
    //Caso 155939
    //REFERENCIA DEL CLIENTE
    /*if (changeGroupEventArgs.commons.item.id == 'VC_OBFWMZSSQP_160647') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576','FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
    }*/
    
    //RELACION ENTRE CLIENTES
    if (changeGroupEventArgs.commons.item.id == 'VC_QQHYLHYLXD_897494') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','FindCustomer', undefined, true, false, 'VC_RELATIONQE_861494', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //CONYUGE
    if (changeGroupEventArgs.commons.item.id == 'VC_GQKQIIYSWN_251604') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONSTVQSJN_350425','FindCustomer', undefined, true, false, 'VC_CUSTOMERUU_138604', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //CAPACIDAD DE PAGO
    if (changeGroupEventArgs.commons.item.id == 'VC_CFFKBKPJOS_961735') {
        balanceFlag = true;
        task.ableSaveButton(entities.EconomicInformation,changeGroupEventArgs);
        task.calculateAvailableBalance(entities.EconomicInformation,changeGroupEventArgs);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //VC_KXWIBTYNCU_272226 infor gene
    //VC_FTDSYJBGDX_891186 datos demo
    //VC_CFFKBKPJOS_961735 datos econo
    //VC_AWHUUJNANM_301855 activ econ
    //VC_BZHSCWLUJU_302769 direcciones
    //VC_RRLBYDXROB_523114 nego del client
    //VC_OBFWMZSSQP_160647 referen del client
    //VC_QQHYLHYLXD_897494 relacion entre clien
    
    //DOCUMENTOS DIGITALIZADOS
    //Llamada a executeQuery para llenar la grilla de documentos Digitalizados
    if (changeGroupEventArgs.commons.item.id == 'VC_HVDQINWTYF_467680') {
       var customerId = entities.Person.personSecuential;
        if (customerId != undefined) {
            var filtro ={
                customerId:customerId,
                processInstance:"0",
                sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                        }
            //Refresh de la grilla para llenar la entidad
            changeGroupEventArgs.commons.api.vc.parentVc = {}
            changeGroupEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
                
            //Refresh de la grilla para llenar la entidad
            changeGroupEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
        }
    }
    //DATOS SOLICITUD COMPLEMENTARIA
    if (changeGroupEventArgs.commons.item.id == 'VC_XISAWPDNOD_912400') {
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
};

	// (Button) 
    task.executeCommand.CM_TCUSTOME_2_9 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
    task.executeCommandCallback.CM_TCUSTOME_2_9 = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        
    };

	// (Button) 
task.executeCommand.CM_TCUSTOME_ROE = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
};

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

	//Command4 (Button) 
task.executeCommand.CM_TCUSTOME_T01 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    let confirmMsg = '';
    let collectives = executeCommandEventArgs.commons.api.vc.catalogs.VA_COLECTIVOXQJYTJ_296213.data();

    for (let i = 0; i < collectives.length; i++) {
        if (collectives[i].code === entities.NaturalPerson.colectivo) {
            confirmMsg = 'Tipo de Mercado ' + collectives[i].value + ', \u00bfest\u00e1 seguro de su selecci\u00f3n?';
            break;
        }
    }

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

};

	// (Button) 
    task.executeCommand.CM_TCUSTOME_T26 = function(entities, executeCommandEventArgs) {
        var docsValidated = true;
        if(entities.VirtualAddress._data.length == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORREEI_58179', true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
         if(entities.PhysicalAddress._data.length < 2){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LASDIREON_70625', true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        
        if (task.FechaNacimiento(entities.NaturalPerson.birthDate, edadMin, edadMax) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
            executeCommandEventArgs.commons.execServer = false;
        }
        else {
            executeCommandEventArgs.commons.execServer = true;
            entities.EconomicInformation.monthlyIncome="10";
            entities.EconomicInformation.expenseLevel="1";

            if(entities.NaturalPerson.hasProblems==null){
                entities.NaturalPerson.hasProblems=false;
            }
            if(entities.NaturalPerson.personPEP==null){
                entities.NaturalPerson.personPEP=false;
            }
            if(entities.NaturalPerson.isLinked==null){
                entities.NaturalPerson.isLinked=false;
            }
            if(entities.EconomicInformation.sales==null) {
               entities.EconomicInformation.sales=0; 
            }
            entities.NaturalPerson.santanderCode = entities.Person.santanderCode;
            //Caso 155939
            //entities.CustomerTmpReferences.code=entities.NaturalPerson.personSecuential;
        }
        if(entities.NaturalPerson.bioIdentificationType == 'INE'){
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        } else {
            entities.NaturalPerson.bioCIC = null;
        }
        
      };

	//Start signature to callBack event to CM_TCUSTOME_T26
task.executeCommandCallback.CM_TCUSTOME_T26 = function (entities, executeCommandCallbackEventArgs) {
    //here your code
    //var references = entities.References.data();
	 
	if(entities.EconomicInformation.businessYears == null){
        entities.EconomicInformation.businessYears = 0;
    }
	 
    if (executeCommandCallbackEventArgs.success) {
        //Set del campo HiddenInCompleted para poder continuar la tarea
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        if (executeCommandCallbackEventArgs.commons.api.parentVc != null && executeCommandCallbackEventArgs.commons.api.parentVc != undefined) {
            if (executeCommandCallbackEventArgs.commons.api.parentVc.model != null && executeCommandCallbackEventArgs.commons.api.parentVc.model != undefined && executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
                executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
            }
        }
        if (section != null) {
            var response = {
                operation: "U"
                , section: section
                , clientId: entities.NaturalPerson.personSecuential
            };
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.responseEvent(response);
        }
        
        if((entities.NaturalPerson.maritalStatusCode === casado)||(entities.NaturalPerson.maritalStatusCode === unionLibre)){
           // executeCommandCallbackEventArgs.commons.api.viewState.show('VC_GQKQIIYSWN_251604');
        } else {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
        }
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_2_9');
		executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_T6S');
    }
    else {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
};

	// (Button) 
    task.executeCommand.CM_TCUSTOME_T6S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //api.viewState.disable('VA_EMAILPFXEWBQUQH_770213');
        //executeCommandEventArgs.commons.api.viewState.show('VA_EMAILPFXEWBQUQH_770213');
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
        var physicalAddresses = entities.PhysicalAddress.data();
        var virtualAddresses = entities.VirtualAddress.data();
        var scannedDocumentsDetail = entities.ScannedDocumentsDetail.data();
        var hasMainPhisicalAddress = false;
        var hasMainDocuments = true; //Caso153311
        entities.Context.channel = channel; // caso203112
		
        for(var i = 0; i < physicalAddresses.length; i++){
             if(physicalAddresses[i].isMainAddress)
             {
               hasMainPhisicalAddress = true;
             }
         }

		//Inicio Caso153311
		if(scannedDocumentsDetail.length != 0){
            for(var i = 0; i < scannedDocumentsDetail.length; i++){
			     if((scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '007') && 
				    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '006') &&
                    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '010') &&
                    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '011')){ //--caso#194473
					 hasMainDocuments = false;
                     break;
				 }else{
					 hasMainDocuments = true;
				 }
			}
        }
		//Fin Caso153311		
        if(hasMainPhisicalAddress && virtualAddresses.length > 0){
			if (hasMainDocuments === false){
				executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECUMNE_39597',false);
				executeCommandEventArgs.commons.execServer = false; 		
			}else{
				executeCommandEventArgs.commons.execServer = true;
			}
        }else{
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243',false);
            executeCommandEventArgs.commons.execServer = false;          
        }
    };

	//Start signature to Callback event to CM_TCUSTOME_T6S
task.executeCommandCallback.CM_TCUSTOME_T6S = function(entities, executeCommandCallbackEventArgs) {
	executeCommandCallbackEventArgs.commons.execServer = false;    
	var nameReport = entities.Context.nameReport;
	var tittle = "";	
	if (entities.Context.generateReport) {
	    if (entities.Context.printReport) {
	        var args = [['report.module', 'customer'], ['report.name', nameReport], ['idCustomer', entities.Person.personSecuential]];
	        if (nameReport === 'BuroCreditoHistorico') {
	            tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTETI_28269');
	        } else if (nameReport === 'BuroCreditoInternoExterno') {
	            tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTEEI_96019');
	        }
	        LATFO.UTILS.generarReporte(nameReport, args, tittle);
	    } else {
	        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesInfo('CSTMR.MSG_CSTMR_ELREPOREE_57555');
	    }
	}
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: CustomerComposite
task.initData.VC_CUSTOMEROI_208680 = function(entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.hide('VA_HASPROBLEMSUGXJ_814213');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLEBALCNN_776168');
    initDataEventArgs.commons.api.viewState.disable('VA_DOCUMENTNUMBRRE_960213');
    initDataEventArgs.commons.api.viewState.disable('VA_IDENTIFICATICCC_741213');
    initDataEventArgs.commons.api.viewState.disable('VA_2792JAYJXHGFXEG_699213');
    initDataEventArgs.commons.api.viewState.disable('VA_BRANCHCODEYMGYZ_548213'); //Sucursal
    initDataEventArgs.commons.api.viewState.disable('VA_OFFICERCODEBNMM_892213'); //Oficial
    initDataEventArgs.commons.api.viewState.hide('VA_BUSINESSYEARSSS_759168');
    // initDataEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
    initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_2_9');
    initDataEventArgs.commons.api.viewState.disable('VA_PERSONPEPVOMMIN_199213'); //persona PEP
    initDataEventArgs.commons.api.viewState.disable('VA_CHARGEPUBGMPRKN_954213');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLETOTAAL_435168');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLEINCEEE_385168');
    initDataEventArgs.commons.api.viewState.hide('VA_EMAILPFXEWBQUQH_770213');
    /*Desactivar campos de RFC*/
    initDataEventArgs.commons.api.viewState.disable('VA_FIRSTNAMEFPYKAF_649213');
    initDataEventArgs.commons.api.viewState.disable('VA_SECONDNAMESJJYD_721213');
    initDataEventArgs.commons.api.viewState.disable('VA_SURNAMESONBWSJR_285213');
    initDataEventArgs.commons.api.viewState.disable('VA_SECONDSURNAMEEE_733213');
    initDataEventArgs.commons.api.viewState.disable('VA_BIRTHDATEEXJMQR_157213');
    initDataEventArgs.commons.api.viewState.disable('VA_COUNTYOFBIRTHHH_881213');
    initDataEventArgs.commons.api.viewState.disable('VA_GENDERCODEUTLBL_276213');
    initDataEventArgs.commons.api.viewState.hide('VA_LANDLINEONESMPZ_626642');
    //Se oculta por cambio bloqueado PLD
    initDataEventArgs.commons.api.viewState.hide('VA_BLOCKEDZUOBRBYZ_833213');
    initDataEventArgs.commons.api.viewState.hide('VA_STATUSCODEMPXFC_766213');
    //ComplementariaTelefonofijo
    //if (cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONRNZGSZY_345213');
    //}

    initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T26');
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
    var GET = location.search.substr(1).split("?");
    var get = {};
    gnralInfoSelected = 0;
    if (parentVc == undefined) {
        initDataEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
    }

    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function(processDate) {
        today = processDate;
        today = new Date(today);
    });

    //Se oculta la columna Direccion
    initDataEventArgs.commons.api.grid.hideColumn('QV_4851_97960', 'addressDescription');

    for (var i = 0, l = GET.length; i < l; i++) {
        var tmp = GET[i].split('=');
        get[tmp[0]] = unescape(decodeURI(tmp[1]));
    }
    
    screenMode = get.modo;
 
    if ((screenMode != undefined && screenMode != null && screenMode == 'Q') || get[tmp[0]] == 'undefined' || (customDialogParameters != null && customDialogParameters.clientId != undefined)) {
        if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
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
        } else if (customDialogParameters != null && customDialogParameters != undefined && parentParameters.Task == undefined) {
            showHeader = false;
            entities.NaturalPerson.personSecuential = customDialogParameters.clientId;
            entities.NaturalPerson.typePerson = "P";
            section = customDialogParameters.section;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
            if (parentVc.id == 'VC_GROUPCOMOS_387974') { //grupos aprobar prestamos
                initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T01'); //oculta guardar
                initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T6S'); //oculta buro
                initDataEventArgs.commons.api.viewState.disable('VC_CUSTOMEROI_208680'); //disable all
                initDataEventArgs.commons.api.viewState.disable('VC_GQKQIIYSWN_251604'); //disable spouse
            }

        } else if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
            showHeader = false;
            var task = parentParameters.Task;
            if (task != null) {
                entities.NaturalPerson.personSecuential = task.clientId;
                entities.NaturalPerson.typePerson = "P";
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
            }
        }
    } else {
        entities.NaturalPerson.personSecuential = get[tmp[0]];
        entities.NaturalPerson.typePerson = "P";
        //section = customDialogParameters.section;
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        /*initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566','FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576','FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','FindCustomer', undefined, true, false, 'VC_RELATIONQE_861494', false);*/
    }
};

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: CustomerComposite
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    onCloseModalEventArgs.commons.execServer = false;

    gridRow = -1;
    var isAccept;

    
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_CONFIRMMGG_786394') {        
        let option = onCloseModalEventArgs.result == null ? 2 : onCloseModalEventArgs.result.option;
        if (option === 1){
            onCloseModalEventArgs.commons.api.vc.executeCommand('CM_TCUSTOME_T26', 'save', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        }else{
		    //(accion, padre, hijo-del la misma pantalla compuesta)
		    onCloseModalEventArgs.commons.api.vc.clickTab(onCloseModalEventArgs, 'VC_DDRWXFYTSU_498680', 'VC_KXWIBTYNCU_272226', true);

		    $("#VC_KXWIBTYNCU_272226_tab").prop("class","active"); // a que opcion debe ir
			$("#VC_FTDSYJBGDX_891186_tab").removeClass("active"); // Datos Demograficos - quitar el color de la opcion donde estaba
			$("#VC_GQKQIIYSWN_251604_tab").removeClass("active"); // Conyuge - quitar el color de la opcion donde estaba			
			$("#VC_HVDQINWTYF_467680_tab").removeClass("active"); // Documento digitalizados - quitar el color de la opcion donde estaba
			$("#VC_CFFKBKPJOS_961735_tab").removeClass("active"); // Capacidad de Pago - quitar el color de la opcion donde estaba
			$("#VC_BZHSCWLUJU_302769_tab").removeClass("active"); // Direcciones y correos electronicos - quitar el color de la opcion donde estaba
			$("#VC_RRLBYDXROB_523114_tab").removeClass("active"); // Negocios del Cliente - quitar el color de la opcion donde estaba
			$("#VC_QQHYLHYLXD_897494_tab").removeClass("active"); // Relacion entre Clientes - quitar el color de la opcion donde estaba
			$("#VC_XISAWPDNOD_912400_tab").removeClass("active"); // Datos Solicitud Complementaria - quitar el color de la opcion donde estaba			
            return;
        }
    }
    
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ECONOMICOU_167751') {
        if (typeof onCloseModalEventArgs.result === "boolean") {
            isAccept = onCloseModalEventArgs.result;
        }
        if (isAccept) {
            //Refrescar el grid 
            if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
                entities.Entity1.refreshGrid = true;
            } else {
                entities.Entity1.refreshGrid = false;
            }
        }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
        onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
if (onCloseModalEventArgs.closedViewContainerId == 'VC_BUSINESSPP_740722') {
    if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Business', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Business', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
      }
      onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);//Para que recuper la info de la base a pesar de que dio error
    }
    //Caso 155939
    /*if (onCloseModalEventArgs.closedViewContainerId == 'VC_REFERENCPP_688957') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {

                    onCloseModalEventArgs.commons.api.grid.addRow('References', onCloseModalEventArgs.result.resultArgs.data);

                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('References', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
    }*/
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REPLACEAII_570116') {
        if(onCloseModalEventArgs.result.resultArgs != null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    entities.NaturalPerson.accountIndividual = onCloseModalEventArgs.result.resultArgs.accountIndividual; 
                }
            }
        } else if(onCloseModalEventArgs.result.resultArgs === undefined){
            entities.NaturalPerson.accountIndividual = entities.Context.accountIndividual;
        }
    }
};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: CustomerComposite
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    //var client = renderEventArgs.commons.api.parentVc;
    //var api = renderEventArgs.commons.api;

    //    try {
    //        var client = renderEventArgs.commons.api.parentVc;
    //        var api = renderEventArgs.commons.api;
    //        if (api.vc.model.DemographicData.hasDisability !== undefined && api.vc.model.DemographicData.hasDisability == "N") {
    //            api.viewState.disable('VA_3231VVMQGIEFXXK_586794');
    //        }
    //        if (api.vc.model.NaturalPerson.expirationDate !== undefined && api.vc.model.NaturalPerson.expirationDate === null) {
    //            api.vc.model.NaturalPerson.indefinite = true;
    //            api.viewState.disable('VA_EXPIRATIONDAEET_157213');
    //        }
    //        if (client.customDialogParameters.Task.urlParams.MODE !== undefined && client.customDialogParameters.Task.urlParams.MODE == "Q") {
    //            task.hideModeQuery(renderEventArgs);
    //            entities.Entity1.screenMode = "Q";
    //        }
    //    }
    //    catch (err) {
    //        //CSTMR.Utils.managerException(err);
    //    }


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

task.customValidate.VA_BIOCICLKEOYOTBY_860213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 9, 9, "N", "CSTMR.MSG_CSTMR_CAMPODETR_21780");
    }

};

	//Entity: NaturalPerson
//NaturalPerson.bioEmissionNumber (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOEMISSIONNRER_925213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 2, 2, "A", "CSTMR.MSG_CSTMR_CAMPODEBT_21506");
    }

};

	//Entity: NaturalPerson
//NaturalPerson.bioOCR (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOOCRWLTNZPKPV_627213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;
    
    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 13, 13, "N", "CSTMR.MSG_CSTMR_CAMPODE1E_73658");
    }

};

	//Entity: NaturalPerson
//NaturalPerson.bioReaderKey (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOREADERKEYGIL_809213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 18, 18, "A", "CSTMR.MSG_CSTMR_CAMPODENR_14381");
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

	//Entity: DemographicData
    //DemographicData.profession (ComboBox) View: DemographicForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_5585RSUWJIOZDNO_500794 = function(  entities, changedEventArgs ) {
        if(changedEventArgs.newValue == '007'){
            changedEventArgs.commons.api.viewState.enable('VA_WHICHPROFESSINI_582794');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_WHICHPROFESSINI_582794');
            entities.DemographicData.whichProfession = null;
        }
        changedEventArgs.commons.execServer = false;
        
    };

	//Entity: DemographicData
    //DemographicData.dependents (TextInputBox) View: DemographicForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8667DCPWKDXLAAQ_828794 = function(  entities, changedEventArgs ) {
        /*if(entities.DemographicData.dependents < 0 || entities.DemographicData.dependents > 10 ){
            entities.DemographicData.dependents = 0;
            alert("Las dependencias económicos deben estar entre el rango 0 - 10");
        }*/
        
        changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: DemographicData
//DemographicData.whichProfession (TextInputBox) View: DemographicForm

task.customValidation.VA_WHICHPROFESSINI_582794 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 4, 30); 
};

	//Entity: DemographicData
    //DemographicData.residenceCountry (ComboBox) View: DemographicForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_4568EAAYMQKOEGY_628794 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.DemographicData = true;
    };

	//Entity: SpousePerson
    //SpousePerson.birthDate (DateField) View: CustomerSpouseForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DATEFIELDMSIZCP_990425 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
		//Por caso #154979
        //if (task.FechaNacimiento(entities.SpousePerson.birthDate, edadMin, edadMax) == false) {
        //    changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
        //}
        
    };

	//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXJTN_514425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.surname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.SpousePerson.surname = null;
    }
    
        
};

	//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXPLP_556425 = function(  entities, changedEventArgs ) {
    
    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.secondSurname;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 2) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SOLOSEPNE_77852', true);
        entities.SpousePerson.secondSurname = null;
    }
    
        
};

	//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXTLP_404425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.firstName;
    var indexs = text.indexOf(".");
    if(indexs != -1){
        var sub = text.substring(0, indexs.length);
        if(sub != 'MA.'){
                changedEventArgs.commons.messageHandler.showTranslateMessagesError('El punto solo se permite en MA.',true);
                entities.SpousePerson.firstName = null;
        }
        indexs = 0;
    }    
    
        
};

	//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXXTU_738425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.secondName;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 3) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
        entities.SpousePerson.secondName = null;
    }
    
};

	//Entity: SpousePerson
    //SpousePerson.phone (TextInputBox) View: CustomerSpouseForm
    
    task.customValidate.VA_TEXTINPUTBOXMPZ_379425 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        LATFO.UTILS.validarTelefono(customValidateEventArgs);
    
        
    };

	//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: CustomerSpouseFor//SpousePerson.surname (TextInputBox) View: CustomerSpouseFor     
task.customValidation.VA_TEXTINPUTBOXJTN_514425 = function( customValidationEventArgs ) {    
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16);
 } ;

	//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXPLP_556425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16);
    
};

	//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXTLP_404425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 1, 20);    
};

	//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXXTU_738425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 30);     
        
};

	//Entity: SpousePerson
    //SpousePerson. (Button) View: CustomerSpouseForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONOARJENM_541425 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
        
        if(entities.SpousePerson.personSecuential === null){
            entities.SpousePerson.personSecuential = 0;
        }
    
        
       
        //executeCommandEventArgs.commons.serverParameters.SpousePerson = true;
    };

	//Entity: SpousePerson
//SpousePerson. (Button) View: CustomerSpouseForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONSTVQSJN_350425 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
    if (screenMode == 'Q') {

        var controls = ['VA_TEXTINPUTBOXTLP_404425','VA_TEXTINPUTBOXXTU_738425','VA_TEXTINPUTBOXJTN_514425',
                        'VA_TEXTINPUTBOXPLP_556425','VA_TEXTINPUTBOXMPZ_379425','VA_DATEFIELDMSIZCP_990425',
                        'VA_VABUTTONOARJENM_541425','VA_VABUTTONOARJENM_541425'];
        LATFO.UTILS.disableFields(executeCommandEventArgs, controls, true);
            
    }
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

	//Entity: EconomicInformation
    //EconomicInformation.assets (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ASSETSGNFTVVLMX_315168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableResults(entities.EconomicInformation);
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.availableBalance (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVAILABLEBALCNN_776168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        //task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
        task.ableSaveButton(entities.EconomicInformation,changedEventArgs);
    };

	//Entity: EconomicInformation
    //EconomicInformation.availableIncome (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVAILABLEINCEEE_385168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        //task.calculateAvailableIncome(entities.EconomicInformation);
    };

	//Entity: EconomicInformation
    //EconomicInformation.availableTotal (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVAILABLETOTAAL_435168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        //task.calculateAvailableTotal(entities.EconomicInformation);
        //task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
    };

	//Entity: EconomicInformation
//EconomicInformation.hasOtherIncome (CheckBox) View: EconomicInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_HASOTHERINCOMME_557168 = function (entities, changedEventArgs) {


    if (entities.EconomicInformation.hasOtherIncome) {
        if (!angular.isDefined(changedEventArgs.commons.api.vc.parentVc)) {
            changedEventArgs.commons.api.viewState.enable('VA_OTHERINCOMESEEE_418168');
            changedEventArgs.commons.api.viewState.enable('VA_SALESPRFYEHZSYT_162168');
        }
    } else {
        changedEventArgs.commons.api.viewState.disable('VA_OTHERINCOMESEEE_418168');
        changedEventArgs.commons.api.viewState.disable('VA_SALESPRFYEHZSYT_162168');
        entities.EconomicInformation.otherIncomeSource = null;
        entities.EconomicInformation.sales = null;
    }
    
    if (screenMode == 'Q'){
         changedEventArgs.commons.api.viewState.disable('VA_OTHERINCOMESEEE_418168');
         changedEventArgs.commons.api.viewState.disable('VA_SALESPRFYEHZSYT_162168');
    }

    changedEventArgs.commons.execServer = false;

};

	//Entity: EconomicInformation
    //EconomicInformation.isLinked (CheckBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ISLINKEDSVEOBYH_771168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.liabilities (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_LIABILITIESUKBV_739168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableResults(entities.EconomicInformation);
   
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.operatingCost (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OPERATINGCOSTTT_884168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableBalance(entities.EconomicInformation, changedEventArgs);
        task.calculateAvailableTotal(entities.EconomicInformation);
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.otherIncomes (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OTHERINCOMESTNU_586168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableIncome(entities.EconomicInformation);
        task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.salesCost (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SALESCOSTPAHABC_774168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
       task.calculateAvailableBalance(entities.EconomicInformation, changedEventArgs);
       task.calculateAvailableTotal(entities.EconomicInformation); 
        
    };

	//Entity: EconomicInformation
    //EconomicInformation.sales (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SALESPRFYEHZSYT_162168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        task.calculateAvailableIncome(entities.EconomicInformation);
        task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
   
    };

	//Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_TUTORIDJFWNDWTD_976168 = function(  entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
    };

/*task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode= args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName= args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.EconomicInformation.tutorName = CustomerName;
        args.model.EconomicInformation.tutorId = customerCode;
    };
*/
//Entity: EconomicInformation
    //EconomicInformation.tutorId (TextInputButton) View: EconomicInfForm
    
task.textInputButtonEvent.VA_TUTORIDJFWNDWTD_976168 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label =cobis.translate('CSTMR.LBL_CSTMR_BSQUEDADE_82600');
        nav.customAddress = {id: "findCustomer", url:"customer/templates/find-customers-tpl.html"};
        nav.modalProperties = {size: 'lg'};
        nav.scripts = [{module: cobis.modules.CUSTOMER, files: ["/customer/services/find-customers-srv.js","/customer/controllers/find-customers-ctrl.js"]}];
        nav.customDialogParameters = {};
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
              if (showHeader && typeof taskHeader !== 'undefined' && taskHeader!=undefined &&  taskHeader!=null ) {

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

	//Entity: VirtualAddress
//VirtualAddress. (Button) View: AddressForm

task.gridRowCommand.VA_GRIDROWCOMMMDNA_449566 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    var args = gridRowCommandEventArgs;
    
    if(args.rowData.isChecked == 'S'){
        //grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
        args.commons.messageHandler.showMessagesInformation('CSTMR.MSG_CSTMR_ELCORRECO_13668');
    } else {

        var nav = args.commons.api.navigation;
        nav.label = args.commons.api.viewState.translate('CSTMR.LBL_CSTMR_VERIFICDN_92071');
        nav.address = {
            moduleId: 'CSTMR',
            subModuleId: 'CSTMR',
            taskId: 'T_CSTMRGAPGAKXO_726',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CODEVERICU_522726'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'sm',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            cstmrCode: args.rowData.personSecuential,
            phoneNumber: args.rowData.addressDescription,
            valType: 'MAIL',
            addressId: args.rowData.addressId
        };
        nav.openModalWindow(args.commons.controlId, args.rowData);
    }

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
    
    var grid = gridRowRenderingEventArgs.commons.api.grid;
    if(entities.CustomerTmp.paramVamail == 'S'){
        grid.addCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);
        grid.removeCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);

    } else {
        grid.addCellStyle('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMDNA_449566', 'disabled', false);
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

	//Entity: CustomerTmp
    //CustomerTmp. (Button) View: BusinessForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONJPSJYQV_906304 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmpBusiness.code == null){
    entities.CustomerTmpBusiness.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    executeCommandEventArgs.commons.serverParameters.Business= true;
};

	//Start signature to Callback event to VA_VABUTTONJPSJYQV_906304
task.executeCommandCallback.VA_VABUTTONJPSJYQV_906304 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if (executeCommandCallbackEventArgs.success) {
        if (ban){
        if (showHeader) {
            if(entities.CustomerTmpBusiness.customerType == 'P'){
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.name, 0);
            }else{
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.businessName, 0);
            }
            LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentNumber, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentType, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmpBusiness.code, 2);
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_BUSINESSSS_428304');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_BUSINESSSS_428304');
        } else {
            //Para VCC
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_BUSINESSSS_428304');
        }
      }
        
    }
    
    
};

	//undefined Entity: 
    task.executeQuery.Q_BUSINESS_6359 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridRowRendering QueryView: QV_6359_40398
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6359_40398 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if(screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6359_40398', 'create');        
        var dsBusiness = entities.Business.data();
        for (var i = 0; i < dsBusiness.length; i++) {   
            var dsRow = dsBusiness[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6359_40398', dsRow, 'delete');   
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_6359_40398', dsRow, 'edit');
        }
        
    }
            
};

	//gridRowDeleting QueryView: QV_6359_40398
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_6359_40398 = function (entities, gridRowDeletingEventArgs) {
    gridRowDeletingEventArgs.commons.execServer = true;
    
    gridRowDeletingEventArgs.commons.serverParameters.Business = true;
};

	//Start signature to Callback event to QV_6359_40398
task.gridRowDeletingCallback.QV_6359_40398 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

	//Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;        
         if (entities.RelationContext.secuential==null){         
        entities.RelationContext.secuential = entities.NaturalPerson.personSecuential;        
       }
        //alert ("uno");
        //executeCommandEventArgs.commons.serverParameters.Entity2 = true;
        
        
    };

	//Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
    
        //Mensaje en caso de que el cliente tenga estado civil casado pero no tenga creada la relación
	var result = null;
	if(entities.NaturalPerson.maritalStatusCode == casado){
		if(entities.SpousePerson.personSecuential == null){
            result = 1;
			
		}
	}
	if(result == 1){ //ERROR: CREAR RELACION CON CONYUGE
		executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('Crear relaci\u00f3n con Conyuge',true);
	}
	
    executeCommandEventArgs.commons.execServer = false;
    if(numsecuential!=0){
        task.hideButtonGridMember(executeCommandEventArgs, 'RelationPerson', 'QV_6114_93961');
    } 
    
        
    };

	//RelationPersonQuery Entity: 
    task.executeQuery.Q_RELATION_6114 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridRowRendering QueryView: QV_6114_93961
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6114_93961 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if (screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6114_93961', 'create'); 
        var dsRelation = entities.RelationPerson.data();
        for (var i = 0; i < dsRelation.length; i++) {   
            var dsRow = dsRelation[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6114_93961', dsRow, 'delete');            
        }
    
    }
            
};

	//Entity: RelationPerson
    //RelationPerson.relationId (ComboBox) View: RelationForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCLW_566954 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        
    };

	//Entity: RelationPerson
    //RelationPerson.namePersonRight (TextInputButton) View: RelationForm
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXJMD_724954 = function( textInputButtonEventGridEventArgs ) {
        textInputButtonEventGridEventArgs.commons.execServer = false;
        var nav = textInputButtonEventGridEventArgs.commons.api.navigation;        
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
            mode: "relation"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        //nav.openCustomModalWindow('findCustomer');
        
    };

	//gridRowDeleting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_6114_93961 = function (entities, gridRowDeletingEventArgs) {
        if (banBorrado==true ){
            if (gridRowDeletingEventArgs.rowData.secuentialPersonLeft ==0 ||        gridRowDeletingEventArgs.rowData.secuentialPersonRight == 0 ){
				gridRowDeletingEventArgs.commons.execServer = false;
				gridRowDeletingEventArgs.commons.messageHandler.showMessagesError('Error, datos inconsistentes',true);
			}
			else{
				gridRowDeletingEventArgs.commons.execServer = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationPerson = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationContext = true;
			}
            //banBorrado=false;            
        }
        else{
            gridRowDeletingEventArgs.commons.execServer = false;
        }
        };

	//Start signature to callBack event to QV_6114_93961
task.gridRowDeletingCallback.QV_6114_93961 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
    if (banBorrado == true){        
        if(gridRowDeletingCallbackEventArgs.success){	        gridRowDeletingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTROM_33731',true);
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            //banBorrado=false;
        }
    }
};

	//gridRowInserting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_6114_93961 = function (entities, gridRowInsertingEventArgs) {            
            var grid = gridRowInsertingEventArgs.commons.api.grid;
            if (gridRowInsertingEventArgs.rowData.secuentialPersonLeft ==0 || gridRowInsertingEventArgs.rowData.secuentialPersonRight == 0){                
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('Error en la creación del registro',true); 
                banBorrado = false;
                grid.removeRow('RelationPerson', 0); 
                //grid.refresh('QV_6114_93961');
                
            }
            else{
                gridRowInsertingEventArgs.commons.execServer = true;
                gridRowInsertingEventArgs.commons.serverParameters.RelationPerson = true;
                banBorrado= true;
            }
            
        };

	//Start signature to Callback event to QV_6114_93961
task.gridRowInsertingCallback.QV_6114_93961 = function(entities, gridRowInsertingCallbackEventArgs) {
//here your code
};

	//Entity: ComplementaryRequestData
    //ComplementaryRequestData.electronicSignature (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ELECTRONICSIGGU_426642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: ComplementaryRequestData
    //ComplementaryRequestData.ifeNumber (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IFENUMBERTXDDFK_481642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: ComplementaryRequestData
    //ComplementaryRequestData.passportNumber (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PASSPORTNUMBEER_566642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: ComplementaryRequestData
    //ComplementaryRequestData.phoneErrands (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PHONEERRANDSTRD_116642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

	//Entity: ComplementaryRequestData
//ComplementaryRequestData.personNameMessages (TextInputBox) View: ComplementaryRequestDataForm
    
task.customValidation.VA_PERSONNAMEMEAES_714642 = function( customValidationEventArgs ) {
	return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 20);            
};



}));