//Start signature to Callback event to CM_TGROUPCO_IRO
task.executeCommandCallback.CM_TGROUPCO_IRO = function (entities, executeCommandCallbackEventArgs) {
    //here your code
	var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var dia = "", mes = "", anio = "0";	
    
    if (executeCommandCallbackEventArgs.success) {
		viewState.enable('VC_ZFXQOGVCIH_421740',true);
        if (entities.Group.operation == 'I') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('LOANS.LBL_LOANS_REGISTRAD_40101', '', 2000, false);
            
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848',     true); 
    executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
        else if (entities.Group.operation == 'U') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('LOANS.LBL_LOANS_REGISTRDE_81762', '', 2000, false);
             executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
       
        //CABECERA DE PANTALLA       
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        if (showHeader) {			
			if(entities.Group.constitutionDate != undefined){
				dia = entities.Group.constitutionDate.getDate();
				mes = entities.Group.constitutionDate.getMonth()+1;
				anio = entities.Group.constitutionDate.getFullYear();
			}
			if(dia < 10){
				dia= "0"+ dia;
			}
            		
			if(mes < 10){
				mes= "0"+ mes;
			}
                        
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.nameGroup, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha de Constituci\u00f3n', dia + "-" + mes + "-" + anio, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del grupo', entities.Group.code, 2);
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_HEADERGUOP_223993');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
        }
        else {
            //Para VCC e Inbox
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_HEADERGUOP_223993');
        }
        executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848');
    }
    else {
         if(entities.Group.code!=null)
		{
			executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848',     true); 
		}
		else
		{
        entities.Group.code = undefined;
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TGROUPCO_IRO');
    }
    }
    
    if (entities.Group.updateGroup == 'N') {
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_GROUPCOMOS_387974');
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TGROUPCO_IRO');
    } else {
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VC_GROUPCOMOS_387974');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
    }
    
};