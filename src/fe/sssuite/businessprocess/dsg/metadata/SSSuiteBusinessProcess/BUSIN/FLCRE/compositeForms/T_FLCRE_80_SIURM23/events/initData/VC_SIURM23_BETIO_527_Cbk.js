//Start signature to callBack event to VC_SIURM23_BETIO_527
    task.initDataCallback.VC_SIURM23_BETIO_527 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_TSRSE1342_26', 'CEQV_201_QV_TSRSE1342_26_253');
		initDataEventArgs.commons.api.viewState.hide('CM_SIURM23TOR49');
		var ds = initDataEventArgs.commons.api.vc.model['DisbursementDetail'];
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
			initDataEventArgs.commons.api.grid.hideGridRowCommand('QV_TSRSE1342_26', dsData[i], 'delete');
		}
		if(initDataEventArgs.success){
			BUSIN.INBOX.STATUS.nextStep(true,initDataEventArgs.commons.api);
			//initDataEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitDisbursementLoan.commitDisbursementLoan';
		}
		task.loadTaskHeader(entities,initDataEventArgs);
	};