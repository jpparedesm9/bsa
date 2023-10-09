//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: parameterPrintTask
    task.initData.VC_ANTTS25_AREPV_622 = function (entities, initDataEventArgs){
        //MGU. Visualizar parametros formato automotriz de impresion 
        initDataEventArgs.commons.execServer = false;
		var viewState = initDataEventArgs.commons.api.viewState;
		entities.DocumentProductTmp = initDataEventArgs.commons.api.parentVc.customDialogParameters.DocumentProduct;
        for (var i = 0; i <= entities.DocumentProductTmp.length - 1; i++) {
            if (entities.DocumentProductTmp[i].YesNot === true) {
				if(entities.DocumentProductTmp[i].isAutoTemplate == "S"){
					var ctrsToHide = ['GR_PAMERPRTIE35_04'];
					BUSIN.API.hide(viewState,ctrsToHide);
				}
				if(entities.DocumentProductTmp[i].isAutoTemplate == "N"){
					var ctrsToHide = ['G_PARAMETIIP_387E35'];
					BUSIN.API.hide(viewState,ctrsToHide);
				}
			}
		}
    };