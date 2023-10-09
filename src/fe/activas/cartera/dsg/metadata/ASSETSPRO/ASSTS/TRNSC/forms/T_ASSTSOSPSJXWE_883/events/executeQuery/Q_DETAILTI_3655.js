//DetailRejectedDispersionsQuery Entity: 
    task.executeQuery.Q_DETAILTI_3655 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true; 
        var custom = "";
		var group = "";
		if (executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action == null || executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action != '1'){
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_294');
			executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_212');
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_480');
			$('#CEQV_201QV_3655_99787_294').attr("disabled",true);
            $('#CEQV_201QV_3655_99787_480').attr("disabled",true);
            $('#CEQV_201QV_3655_99787_212').attr("disabled",true);
			executeQueryEventArgs.commons.api.grid.hideColumn('QV_3655_99787','selection');
        }else{
			executeQueryEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_294');
            executeQueryEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_480');
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_212');
            $('#CEQV_201QV_3655_99787_294').attr("disabled",false);
            $('#CEQV_201QV_3655_99787_480').attr("disabled",false);
            $('#CEQV_201QV_3655_99787_212').attr("disabled",false);
			executeQueryEventArgs.commons.api.grid.showColumn('QV_3655_99787','selection');
        }
		
		if (isGroup == 'N'){
			custom = executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.customerCode;
		}else{
			group = executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.customerCode;
        }
		
			
        var filtro = {
			customerCode : custom,
			groupCode : group,
            action: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action,
            account: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.account,
            startDate: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.startDate,
            endDate: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.endDate,
            type: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.type 
        };
        executeQueryEventArgs.commons.api.vc.parentVc = {}
        executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    };