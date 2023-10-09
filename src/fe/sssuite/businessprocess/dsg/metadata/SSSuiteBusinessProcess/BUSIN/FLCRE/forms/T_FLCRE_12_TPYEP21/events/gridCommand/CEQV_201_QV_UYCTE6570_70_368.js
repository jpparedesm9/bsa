//gridCommand (Button) QueryView: GridCategoryPlan
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_UYCTE6570_70_368 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        gridExecuteCommandEventArgs.commons.serverParameters.CategoryNew = true;
		
		var nav = gridExecuteCommandEventArgs.commons.api.navigation;
			nav.label = gridExecuteCommandEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_RUBROSNVO_58071');
			nav.modalProperties = {
				size: 'lg',
				callFromGrid: false
			};
			nav.queryParameters = {mode: 2};
			nav.address = {
					moduleId: 'BUSIN',
					subModuleId: 'FLCRE',
					taskId: 'T_FLCRE_24_CTORY86',
					taskVersion: '1.0.0',
					viewContainerId: 'VC_CTORY86_CTEGO_587'
			};
			nav.customDialogParameters = {
					idRequested:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.idRequested,
					currency:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.currency,
					productType:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.productType,
					isNew: true
			};
			nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId, gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader);
    };