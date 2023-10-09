//Start signature to Callback event to VA_VABUTTONPDPCKGB_382725
task.executeCommandCallback.VA_VABUTTONPDPCKGB_382725 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success && entities.Credit.applicationNumber != 0 && entities.Credit.applicationNumber != null) {
        //CABECERA DE PANTALLA       
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.code + " - " + entities.Group.nameGroup, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode, 1);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', entities.Credit.category, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested == 'null' ? 0 : entities.Credit.amountRequested), 2), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount == 'null' ? 0 : entities.Credit.approvedAmount), 2), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.Credit.paymentFrecuency, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', entities.Credit.subtype, 2);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado',  entities.Credit.linked, 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.Group.cycleNumber, 2);
        LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_HEADERGUOP_223993');
        executeCommandCallbackEventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
        porcentaje = entities.Credit.percentageWarranty;
        var percentage = LATFO.COMMONS.getPercentage(executeCommandCallbackEventArgs.commons.api.vc.model.Amount.data().map(function (item) {
            return item.authorizedAmount
        }), porcentaje);
        entities.Credit.warrantyAmount = percentage;
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");        
    }
    /* Se recarga el catalogo de oficiales */
    executeCommandCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXNBX_864725');
    executeCommandCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXYVS_120190');
    
    var parentVc = executeCommandCallbackEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
     if (customDialogParameters == null) {
	    if (entities.Group.updateGroup == 'N') {
           executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_GROUPCOMOS_387974');
           //executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		if(entities.Group.otherPlace==true)
		 {
		 executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725');
         executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		 }
          executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('LOANS.MSG_LOANS_NOSEPUEOA_20236');//No se Puede Modificar el Grupo si la Solicitud no se Encuentra en la Etapa de Ingreso
        } 
        else
		{
			executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848', true);
		}
	}
    // se utiliza para bloquear el campo Incremento de la pantalla de montos
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
    
    if(stage == 'APROBAR'){
      $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
    }
    
    if(requestType != 'R'){
		var i=0;
		for (i = 0; i<entities.Amount.data().length;i++){
			executeCommandCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_6248_19660',entities.Amount.data()[i],'VA_GRIDROWCOMMMDAD_387190');
		}	
	}else{
		$("#QV_6248_19660 col:last-child").width("110px")
		$("#QV_6248_19660 .btn-toolbar a").removeClass("invisible");
	}
    
   /* if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) {
        //Si es renovación ocultar la pantalla de incremento
        if(entities.Group.cycleNumber>1){
             executeCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_6248_19660','proposedMaximumSaving');
        }else{
            executeCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_6248_19660','increment');
    }
}*/ //se comenta para mostrar ambas columnas
    
    //if(type == typeConsulta){
    // task.hideButtonGridMember(executeCommandCallbackEventArgs,'Member','QV_7978_25243');
    //}
};