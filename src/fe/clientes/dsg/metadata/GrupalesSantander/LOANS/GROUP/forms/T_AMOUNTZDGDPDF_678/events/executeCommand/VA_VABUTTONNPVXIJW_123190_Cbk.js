//Start signature to Callback event to VA_VABUTTONNPVXIJW_123190
task.executeCommandCallback.VA_VABUTTONNPVXIJW_123190 = function(entities, executeCommandCallbackEventArgs) {
	if (executeCommandCallbackEventArgs.success == true ){ //**ACHP
        
        var percentage = LATFO.COMMONS.getPercentage(executeCommandCallbackEventArgs.commons.api.vc.model.Amount.data()
                                                 .map(function(item){return item.authorizedAmount}), porcentaje);         
        entities.Credit.warrantyAmount = percentage;
        
	    executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested  == 'null' ? 0 : entities.Credit.amountRequested ), 2), 1);
    	LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount  == 'null' ? 0 : entities.Credit.approvedAmount ), 2), 1);	
	}else{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //para que no vaya con cualquier monto, si se vuelve a ejecutar con datos incorrectos
	}
	//Monto maximo propuesto
	$("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
     //MontoSolicitado
	if(stage=='APROBAR'){
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
	}
};