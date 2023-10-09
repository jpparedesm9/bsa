//Start signature to callBack event to VC_ERFAN09_OEDAO_387
	 task.initDataCallback.VC_ERFAN09_OEDAO_387 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var api=initDataEventArgs.commons.api;
		var ds = initDataEventArgs.commons.api.vc.model['CustomerReference'];
		var dsData = ds.data();
		var flag=0;

		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			if(dsRow.Result ==='0'){
				flag=1;
				break;
			}
		}

		if(parentApi != undefined && flag===0){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = 'YES';
		}		
		if(entities.SourceRevenueCustomer.data().length==0){			
			var ctrsToHide = ['VC_ERFAN09_IVITY_872']
			BUSIN.API.hide(api.viewState,ctrsToHide);
		}	
		task.loadTaskHeader(entities,initDataEventArgs);		
    };