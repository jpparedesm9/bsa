//Entity: Punishment
    //Punishment. (ImageButton) View: TPunishment
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAD_775N43 = function(  entities, gridRowCommandEventArgs ) {
        var args=gridRowCommandEventArgs;
		gridRowCommandEventArgs.commons.execServer = false;		
		var nav = FLCRE.API.getApiNavigation(args,'T_FLCRE_84_PUSEN31','VC_PUSEN31_TIMNT_481');        
        nav.modalProperties = { size: 'lg' };
        nav.queryParameters = { mode: args.commons.constants.mode.Insert };        	
        nav.customDialogParameters = { 
            Task:{alternateCode:"instanciaProces",
					bussinessInformationIntegerOne:gridRowCommandEventArgs.rowData.IdClient,
					bussinessInformationIntegerTwo:0,//never used
					bussinessInformationStringOne:gridRowCommandEventArgs.rowData.Bank,
					processInstanceIdentifier:gridRowCommandEventArgs.rowData.Bank,
					processSubject:"SOLICITUD DE CASTIGO",//never used
					taskSubject:"INGRESO SOLICITUD DE CASTIGO",//never used
					clientName:gridRowCommandEventArgs.rowData.DescriptionClient,
					urlParams:{ETAPA:"MASSIVE"}
					}			
				};
        nav.openModalWindow(args.commons.controlId);
		/*var url = "/CTSProxy/services/cobis/web/views/BUSIN/FLCRE/T_FLCRE_84_PUSEN31/1.0.0/VC_PUSEN31_TIMNT_481_TASK.html";
		url="/CTSProxy/services/cobis/web/views/genericModule/genericModule-container-page.html";
		
		var menu = cobis.translate('COMMONS.MENU.MNU_REQUEST_PUNISHMENT');
		BUSIN.INBOX.STATUS.openNewTabGen(menu,url);*/
		//BUSIN.INBOX.STATUS.openNewTab('370725482',menu);
    };