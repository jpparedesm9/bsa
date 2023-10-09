//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: GenericApplication
task.render = function (entities, renderEventArgs) {
    var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    var viewState = renderEventArgs.commons.api.viewState;
	typeRequest = parentParameters.Task.urlParams.SOLICITUD;
    var ctrs = ['VA_ORIAHEADER8608_TAOR020',
              'VA_ORIAHEADER8608_TCTC534',
              'VA_ORIAHEADER8608_TTCD057',
              'VA_ORIAHEADER8608_CCAA829', // seccion de alicuota
              'VC_OIIRL51_RUPNR_606', // seccion, operaciones,spacerCreditLine
              'VA_ORIAHEADER8605_TIRC927', // tipoProduto
              'VA_ORIAHEADER8605_ERTO640']; // Linea de Credito

    BUSIN.API.hide(viewState, ctrs);

    // Template para combo Linea de credito
    var viewState = renderEventArgs.commons.api.viewState,
        template;
    var template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - ' + '<span><b>Disponible:</b> #: attributes[1] #</span> - ' + '<span><b>Moneda:</b> #: attributes[2] #</span>';
    viewState.template('VA_ORIAHEADER8605_ERTO640', template);

    // Realizo el change para que cambie el segmento
    entities.EntidadInfo.sector = entities.generalData.segment;

    var template2 = '<span><h4>#: code#</h4></span>' + '<span>#: attributes[0]#</span><br>' + '<span>#: attributes[1]#</span><br>' + '<span>#: attributes[2]#</span><br>';
    viewState.template('VA_ORIAHEADER8608_TTCD057', template2);
    viewState.template('VA_ORIAHEADER8608_TAOR020', template2);


    // Alicuota
    var ctrs1Alicuota = [];
    entities.Alicuota.Alicuota = (entities.Alicuota.Alicuota !== null) ? entities.Alicuota.Alicuota : "N-A";
    var alicuotaValue = entities.Alicuota.Alicuota;
    if (alicuotaValue === 'S') {
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TCTC534', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
    } else if (alicuotaValue === 'N') {
        viewState.label("VA_ORIAHEADER8608_CCAA829", 'BUSIN.DLB_BUSIN_ALICUOTAI_84613'); // cambio de etiqueta
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
        if (entities.Alicuota.CtaCertificada !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
        }
        if (entities.Alicuota.CtaAhorros !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
        }
    }

    // Modo Consulta
    task.showButtons(renderEventArgs);
    if (parentParameters.Task.urlParams.MODE == "Q") { // en el caso de que la
        // tarea se utilice con
        // todos los campos
        // deshabilitados
        var ctrsToDisable = ['VC_OIIRL51_TBRMT_122',
                        'VC_OIIRL51_PTONI_284',
                        'VC_OIIRL51_GTDOS_515',
                        'VC_OIIRL51_RUPNR_606',
                        'CM_OIIRL51SVE80',
                        'CM_OIIRL51INT80']; // btn guardar, btn imprimir
        BUSIN.API.disable(viewState, ctrsToDisable);
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992'); //boton nuevo operaciones
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978'); //boton eliminar operaciones
    }


    // Etapas Tramite
    // Refinanciamiento, Reestructuracion, Renovacion
    if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Refinancing ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration) {

        // Grilla de operaciones y tipo de producto en los flujos
        // especificos
        var ctrsToShow = ['VC_OIIRL51_RUPNR_606', 'VA_ORIAHEADER8605_TIRC927'];
        BUSIN.API.show(viewState, ctrsToShow);

        // spacerTypeProduct
        var ctrsToHide = ['VA_ORIAHEADER8605_0000029'];
        BUSIN.API.hide(viewState, ctrsToHide);

        // Oculta columnas
        var columnsRefinancingOperations = ['RefinancingOption', 'InternalCustomerClassification', 'Rate', 'CreditType'];
        BUSIN.API.GRID.hideColumns('QV_ITRIC1523_63', columnsRefinancingOperations, renderEventArgs.commons.api);

        //Ajusta el tamaÃ±o de las cabeceras al campo de la grilla
        var columns = ['OperationBank', 'CurrencyOperation', 'Balance', 'LocalCurrencyBalance', 'OriginalAmount', 'LocalCurrencyAmount', 'CreditType', 'InternalCustomerClassification',
                     'DateGranting', 'IdOperation', 'RefinancingOption', 'IsBase', 'Rate', 'ExpirationDate', 'State', 'TypeOperation'];
        BUSIN.API.GRID.addColumnsStyle('QV_ITRIC1523_63', 'Grid-Column-Header', renderEventArgs.commons.api, columns);

        //Disable de columnas de la grilla
        var grid = renderEventArgs.commons.api.grid;
        grid.disabledColumn('QV_ITRIC1523_63', 'OperationBank');
        grid.disabledColumn('QV_ITRIC1523_63', 'TypeOperation');
        grid.disabledColumn('QV_ITRIC1523_63', 'ExpirationDate');
        grid.disabledColumn('QV_ITRIC1523_63', 'State');
        grid.disabledColumn('QV_ITRIC1523_63', 'DateGranting');

    }


    //Bloquea el tipo de producto en base al parametro que llega del an_component DISABLE_PRODUCT_TYPE
    if (parentParameters.Task.urlParams.DISABLE_PRODUCT_TYPE == "S") {
        var ctrsToDisable = ['VA_ORIAHEADER8605_TIRC927'];
        BUSIN.API.disable(viewState, ctrsToDisable);
    }

	//Tramite grupal	
	if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
        var ctrsToDisable = ['VA_GRUPALKFSXRLTTA_514W91']; // NewAliquot.grupal
        BUSIN.API.hide(viewState, ctrsToDisable);
	   renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
	   renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores
	}    
    renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create'); // boton de la grilla de operaciones
};