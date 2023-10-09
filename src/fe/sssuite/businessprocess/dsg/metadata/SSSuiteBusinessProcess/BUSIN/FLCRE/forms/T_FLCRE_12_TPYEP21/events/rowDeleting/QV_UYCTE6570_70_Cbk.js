//Start signature to callBack event to QV_UYCTE6570_70
    task.gridRowDeletingCallback.QV_UYCTE6570_70 = function(entities, gridRowDeletingEventArgsCallback) {
		if(gridRowDeletingEventArgsCallback.success){
			gridRowDeletingEventArgsCallback.commons.messageHandler.showMessagesSuccess('BUSIN.DLB_BUSIN_EIMACIEOA_99670');
			gridRowDeletingEventArgsCallback.commons.api.vc.executeCommand('CM_TPYEP21MTE89',
				'Compute', '', true, false, 'VC_TPYEP21_FAETL_814', false);
		}
    };