//gridRowSelecting QueryView: QV_2353_40892
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_2353_40892 = function (entities,gridRowSelectingEventArgs) {
               gridRowSelectingEventArgs.commons.execServer = false;        
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
		
		nav.label = "Detalle de Transaccion";
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'QERYS',
            taskId: 'T_ASSTSCJVXOOMB_486',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_TRANSACTDE_986486'
        };

        nav.queryParameters = {
			mode : gridRowSelectingEventArgs.commons.constants.mode.Update
        };
        nav.modalProperties = {
			size: 'lg'
        };
        nav.customDialogParameters = {
			idTrx: gridRowSelectingEventArgs.rowData.transactionId, 
            trxType: gridRowSelectingEventArgs.rowData.transactionType, 
			loanBankID: entities.Loan.loanBankID
        };		
        nav.openModalWindow("QV_2353_40892", gridRowSelectingEventArgs.modelRow);
};