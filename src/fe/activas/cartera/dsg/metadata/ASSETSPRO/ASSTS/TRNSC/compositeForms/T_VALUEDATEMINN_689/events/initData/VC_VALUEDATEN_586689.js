//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ValueDateMain
    task.initData.VC_VALUEDATEN_586689 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
        var parameters=api.navigation.getCustomDialogParameters();        
        entities.LoanInstancia = parameters.parameters.loanInstancia;
		queryDict = {
			menu: parameters.parameters.menu
		}
		
        commons.execServer = true;	
		entities.ValueDateFilter.option = queryDict.menu;
		if (queryDict.menu == ASSETS.Constants.MENU_VALUE_DATE){
			commons.api.viewState.hide('VA_OBSERVATIONDKBP_175866');
		}else if (queryDict.menu == ASSETS.Constants.MENU_REVERSE){
			$(".breadcrumb .ng-binding").last().text(commons.api.viewState.translate('ASSTS.LBL_ASSTS_REVERSAGQ_88268'));
			commons.api.viewState.hide('VA_LASTPROCESSDEET_724866');
			commons.api.viewState.hide('VA_3610ZOUUEMDZQED_313866');
		}
		if (entities.Loan.status == "NO VIGENTE"){
            api.viewState.disable("CM_VALUEDAT_NNN");
        }
        
    };