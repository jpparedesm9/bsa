//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReadjustmentDetalilsLoanForm
    task.initData.VC_REAJUSTEMF_502264 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        try {
			var model = initDataEventArgs.commons.api.vc.model;
			model.Loan = initDataEventArgs.commons.api.parentVc.model.Loan;
			model.ReadjustmentLoanCab = initDataEventArgs.commons.api.navigation
					.getCustomDialogParameters().readjustmentLoanCab;
		} catch (err) {
			ASSETS.Utils.managerException(err);
		}
    };