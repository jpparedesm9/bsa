<!-- Designer Generator v 5.0.0.1519 - release SPR 2015-19 02/10/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tfuentefinanciamiento;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.Guardar (Button) View: ViewSourceFunding
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_IWSORCENIN8703_0000566 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: GSourceFunding
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitDetailTemplate.QV_COURC4312_01 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
		var nav = gridInitDetailTemplateArgs.commons.api.navigation;
			nav.label = 'SourceFunding';

			nav.address = {

					 moduleId: 'BUSIN',
                     subModuleId: 'FLCRE',
                     taskId: 'T_FLCRE_68_MNNIN29',
                     taskVersion: '1.0.0',
                     viewContainerId: 'VC_MNNIN29_RZNTE_283'

			};
			
			nav.customDialogParameters = {currency: gridInitDetailTemplateArgs.modelRow.Currency,
										  funcdingsource: gridInitDetailTemplateArgs.modelRow.FundingSource,
										  maximunAmount: gridInitDetailTemplateArgs.modelRow.MaximunAmount,
										  maximunRate: gridInitDetailTemplateArgs.modelRow.MaximunRate,
										  manimunAmount:gridInitDetailTemplateArgs.modelRow.MinimunAmout,
										  minimunRate:gridInitDetailTemplateArgs.modelRow.MinimunRate,
										  objectCredit:gridInitDetailTemplateArgs.modelRow.ObjectCredit,
										  paymentFrecuency:gridInitDetailTemplateArgs.modelRow.PaymentFrecuency,
										  sectorActivity:gridInitDetailTemplateArgs.modelRow.SectorActivity
										  };

			nav.openDetailTemplate('QV_COURC4312_01', gridInitDetailTemplateArgs.modelRow);
		
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //SelecccionaFuenteFin QueryView: GSourceFunding
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_COURC4312_01 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		
		var rowData = gridRowSelectingEventArgs.rowData.CodeSource;
		entities.SourceFunding.CodeSource = rowData;

        
    };

    //Eliminar (Button) QueryView: GSourceFunding
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_COURC4312_01_876 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //Nuevo (Button) QueryView: GSourceFunding
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_COURC4312_01_285 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		var nav = gridExecuteCommandEventArgs.commons.api.navigation;
			nav.label = gridExecuteCommandEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_ETDEFAAMI_27181');
			nav.modalProperties = {
				//Hay 3 tamaños permitidos:  sm - pequeño, lg - grande, o si no se declara usa el mediano
				size: 'lg',
				//opcionalmente se puede definir una altura
				//height: 350,
				//si es llamado desde un evento de grilla el valor es true
				callFromGrid: false
			};
			nav.queryParameters = {mode: 2};
			nav.address = {
					moduleId: 'BUSIN',
					subModuleId: 'FLCRE',
					taskId: 'T_FLCRE_68_MNNIN29',
					taskVersion: '1.0.0',
					viewContainerId: 'VC_MNNIN29_RZNTE_283'
			};
			nav.customDialogParameters = {
				amountItemValueSelected: gridExecuteCommandEventArgs.rowData
			};
			nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId, gridExecuteCommandEventArgs.rowData);  
    };
	
	
	//close modal associateRules
		task.closeModalEvent.VC_MNNIN29_RZNTE_283 = function(args){		
			var response = args.result;
			if(response!=null&&response!=undefined){
				args.model.SourceFunding.add(response);
			};		
		};	
		
		
	//ELiminarFuente QueryView: GSourceFunding
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_COURC4312_01 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
    };

		
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: TFuenteFinanciamiento 
    task.initData.VC_FUNME92_TTFAE_107 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = true;
		
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: TFuenteFinanciamiento 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState;
		
    };

}());