//Entity: ReadjustmentDetalilsLoan
    //ReadjustmentDetalilsLoan.signo (ComboBox) View: ReadjustmentDetalilsLoanForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXIEY_291141 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        try {
			var api = changeEventArgs.commons.api;
			var selectedRow = api.vc.grids.QV_2618_23821.selectedRow;

			if (changeEventArgs.value !== null) {
				selectedRow.set('porcentaje', null);
			}
		} catch (err) {
			ASSETS.Utils.managerException(err);
		}
    };