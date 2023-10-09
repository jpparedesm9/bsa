//gridRowSelecting QueryView: QV_5030_22532
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5030_22532 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;        
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
		
		nav.label = gridRowSelectingEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_DETALLEAG_48048');
        nav.address = {
			moduleId: 'ASSTS',
			subModuleId: 'QERYS',
			taskId: 'T_PAYMENTDETMFP_722',
			taskVersion: '1.0.0',
			viewContainerId: 'VC_PAYMENTDEE_475722'
        };
        nav.queryParameters = {
			mode : gridRowSelectingEventArgs.commons.constants.mode.Update
        };
        nav.modalProperties = {
			size: 'lg'
        };
        nav.customDialogParameters = {
			sequentialIns: gridRowSelectingEventArgs.rowData.sequential, 
			loanBankID: entities.Loan.loanBankID
        };		
        nav.openModalWindow("QV_5030_22532", gridRowSelectingEventArgs.modelRow);
    };