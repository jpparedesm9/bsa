//Evento initData : Inicializaci�n de datos del formulario, despu�s de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GenericApplication
task.initData.VC_OIIRL51_CNLTO_343 = function (entities, initDataEventArgs) {
    passInitData = true;
    FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, true, false);
    initDataEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLZA_843R86');

    //SMO se agrega de Grupales
    //Bloqueo de campos
    var viewState = initDataEventArgs.commons.api.viewState;
    // Tipo de solicitud
    var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD; // -- ACHP
    modeRequest = customDialogParameters.Task.urlParams.MODE; //PXSG
    if(customDialogParameters.Task.urlParams.Tipo!=undefined){
		modeType = customDialogParameters.Task.urlParams.Tipo;
	}
    var ctrs = ['VA_ORIAHEADER8602_TERM237',
              'VA_ORIAHEADER8602_NQUE773', //Se deshabilita plazo y frequencia
			  'VA_REFERENCIASNASR_958W91'] //Se deshabilita campo Referencia
    BUSIN.API.disable(viewState, ctrs);
    BUSIN.API.hide(viewState, ['VA_ORIAHEADER8605_ERTO640', 'CM_TFLCRE_8_TCR']); //Se oculta lÃ­nea de creditoinitda
    //SMO fin grupales

    // Estilos
    var viewState = initDataEventArgs.commons.api.viewState;
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'TypeDocumentId', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');

    //SMO se agrega de grupales
    //Se habilita validaciÃ³n para combo de ejecutivo
    viewState.disableValidation('VA_EJECUTIVOZUEHTQ_752W91', VisualValidationTypeEnum.Required);
    viewState.enableValidation('VA_EJECUTIVOZUEHTQ_752W91', VisualValidationTypeEnum.Required);



    // Entidades Temporal
    entities.generalData = {};
    entities.generalData.productTypeName = "";
    entities.generalData.paymentFrecuencyName = "";
    entities.generalData.vinculado = "";
    entities.generalData.labelOtroDestino = "";
    entities.generalData.segment = "";
    entities.generalData.type = "";

    entities.OriginalHeader2 = {};
    entities.OriginalHeader2.idOriginalHeader2 = null;

    // Recupero parametros de la ventana padre
    var parentParameters = initDataEventArgs.commons.api.parentVc.model;

    // Set de campos
    entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
    entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
    entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
    entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
    entities.OriginalHeader.OpNumberBank = parentParameters.Task.bussinessInformationStringOne;
    entities.generalData.type = parentParameters.Task.urlParams.TRAMITE;
    entities.Context.CustomerId = parentParameters.Task.clientId;
    entities.Context.channel = channel; // caso203112
    // entities.OriginalHeader.OpNumberBank = "";
    //entities.OriginalHeader.AmountCalculated = 0;SMO no existe en grupales

    // Campos del Cliente
    entities.NewAliquot.referencia = "Operacion creada desde Workflow"; //SMO se agrega de grupales

    // Campos del Cliente
    var client = initDataEventArgs.commons.api.parentVc.model.Task;

    /*entities.generalData.clientId = ((client != null && client != undefined) ? client.clientId : 0);
    if (typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== ''){
    	var cust = new DebtorGeneral(client.clientId,client.clientName, 'D', '', '',client.clientType);
    	listCustomer.push(cust);
    	initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
    }*/
    //Diferente en grupales
    entities.generalData.clientId = ((client != null && client != undefined) ? client.clientId : 0);

    if (typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== '') { // -- ACHP
        var cust = '';
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
            cust = new DebtorGeneral(client.clientId, client.clientName, 'G', '', '');
        } else {
            cust = new DebtorGeneral(client.clientId, client.clientName, 'D', '', '');
        }
        listCustomer.push(cust);
        initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        entities.NewAliquot.grupal = 'S';
    }

    // Cambio de etiqueta
    if (typeRequest != FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        initDataEventArgs.commons.api.viewState.label("VA_COMBOBOXGTFCJFR_317R86", "BUSIN.LBL_BUSIN_ACEPTARVN_91496");
    }
    
  
    initDataEventArgs.commons.execServer = true;
};