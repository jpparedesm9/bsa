//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GenericApplication
task.initData.VC_OIIRL51_CNLTO_343 = function (entities, initDataEventArgs) {
    FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, true, false);

    // Estilos
    var viewState = initDataEventArgs.commons.api.viewState;
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'TypeDocumentId', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');

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
    // entities.OriginalHeader.OpNumberBank = "";


    // Campos del Cliente
    var client = initDataEventArgs.commons.api.parentVc.model.Task;

    entities.generalData.clientId = ((client != null && client != undefined) ? client.clientId : 0);
    if (typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== '') {
		var cust = '';
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			cust = new DebtorGeneral(client.clientId, client.clientName, 'G', '', '');
		}else{
			cust = new DebtorGeneral(client.clientId, client.clientName, 'D', '', '');
		}
        listCustomer.push(cust);
        initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
    }

    //Grupales
    if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
		entities.NewAliquot.grupal = 'S';
	}
    initDataEventArgs.commons.execServer = true;

};