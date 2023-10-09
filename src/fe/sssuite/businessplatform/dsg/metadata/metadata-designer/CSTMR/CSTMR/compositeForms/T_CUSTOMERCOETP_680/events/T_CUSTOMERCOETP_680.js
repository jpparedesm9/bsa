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