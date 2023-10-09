/*global designerEvents, console */
(function() {
	"use strict";

	// *********** COMENTARIOS DE AYUDA **************
	// Para imprimir mensajes en consola
	// console.log("executeCommand");

	// Para enviar mensaje use
	// eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando
	// comando personalizado');

	// Para evitar que se continue con la validación a nivel de servidor
	// eventArgs.commons.execServer = false;

	// **********************************************************
	// Eventos de VISUAL ATTRIBUTES
	// **********************************************************

	var task = designerEvents.api.readjustmentdetalilsloanform;

	/* "TaskId": "T_REAJUSTEDEFTF_264", */
	// Your code here
	// Evento initData : Inicialización de datos del formulario, después de este
	// evento se realiza el seguimiento de cambios en los datos
	// ViewContainer: ReadjustmentDetalilsLoanForm
	task.initData.VC_REAJUSTEMF_502264 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = true;
		try {
			var model = initDataEventArgs.commons.api.vc.model;
			model.Loan = initDataEventArgs.commons.api.parentVc.model.Loan;
			// model.ReadjustmentLoanCab=initDataEventArgs.commons.api.parentVc.model.ReadjustmentLoanCab._data[0];
			// initDataEventArgs.commons.serverParameters.entityName = true;}
			model.ReadjustmentLoanCab = initDataEventArgs.commons.api.navigation
					.getCustomDialogParameters().readjustmentLoanCab;
		} catch (err) {
			alert(err.message);
		}
	};

	// Entity: ReadjustmentDetalilsLoan
	// ReadjustmentDetalilsLoan.referencial (ComboBox) View:
	// ReadjustmentDetalilsLoanForm
	// Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un
	// catálogo.
	task.loadCatalog.VA_TEXTINPUTBOXFYD_123141 = function(loadCatalogEventArgs) {
		loadCatalogEventArgs.commons.execServer = true;
		// loadCatalogEventArgs.commons.serverParameters.ReadjustmentDetalilsLoan
		// = true;
	};

	// gridRowDeleting QueryView: QV_2618_23821
	// Se ejecuta antes de que los datos eliminados en una grilla sean
	// comprometidos.
	task.gridRowDeleting.QV_2618_23821 = function(entities,
			gridRowDeletingEventArgs) {
		gridRowDeletingEventArgs.commons.execServer = true;
		// gridRowDeletingEventArgs.commons.serverParameters.ReadjustmentDetalilsLoan
		// = true;
	};

	// gridRowUpdating QueryView: QV_2618_23821
	// Se ejecuta antes de que los datos modificados en una grilla sean
	// comprometidos.
	task.gridRowUpdating.QV_2618_23821 = function(entities,
			gridRowUpdatingEventArgs) {
		gridRowUpdatingEventArgs.commons.execServer = true;
		// gridRowUpdatingEventArgs.commons.serverParameters.ReadjustmentDetalilsLoan
		// = true;

	};

	// Entity: Entity6
	// Entity6. (Button) View: ReadjustmentDetalilsLoanForm
	// Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un
	// command o de un ActionControl.
	task.executeCommand.VA_VABUTTONRGCIAEL_707141 = function(entities,
			executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = true;
		// executeCommandEventArgs.commons.serverParameters.Entity6 = true;
	};

	// Entity: ReadjustmentDetalilsLoan
	// ReadjustmentDetalilsLoan.porcentaje (TextInputBox) View:
	// ReadjustmentDetalilsLoanForm
	// Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.change.VA_TEXTINPUTBOXAAA_377141 = function(entities, changeEventArgs) {
		changeEventArgs.commons.execServer = false;
		try {
			var api = changeEventArgs.commons.api;
			var selectedRow = api.vc.grids.QV_2618_23821.selectedRow;

			if (changeEventArgs.value !== null) {
				selectedRow.set('referencial', null);
				selectedRow.set('signo', null);
				selectedRow.set('factor', null);
			}
		} catch (err) {
			alert(err.message);
		}
	};

	// Entity: ReadjustmentDetalilsLoan
	// ReadjustmentDetalilsLoan.referencial (ComboBox) View:
	// ReadjustmentDetalilsLoanForm
	// Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.change.VA_TEXTINPUTBOXFYD_123141 = function(entities, changeEventArgs) {
		changeEventArgs.commons.execServer = false;
		try {
			var api = changeEventArgs.commons.api;
			var selectedRow = api.vc.grids.QV_2618_23821.selectedRow;

			if (changeEventArgs.value !== null) {
				selectedRow.set('porcentaje', null);
			}
		} catch (err) {
			alert(err.message);
		}
	};

	// Entity: ReadjustmentDetalilsLoan
	// ReadjustmentDetalilsLoan.signo (ComboBox) View:
	// ReadjustmentDetalilsLoanForm
	// Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.change.VA_TEXTINPUTBOXIEY_291141 = function(entities, changeEventArgs) {
		changeEventArgs.commons.execServer = false;
		try {
			var api = changeEventArgs.commons.api;
			var selectedRow = api.vc.grids.QV_2618_23821.selectedRow;

			if (changeEventArgs.value !== null) {
				selectedRow.set('porcentaje', null);
			}
		} catch (err) {
			alert(err.message);
		}
	};

	// Entity: ReadjustmentDetalilsLoan
	// ReadjustmentDetalilsLoan.factor (TextInputBox) View:
	// ReadjustmentDetalilsLoanForm
	// Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.change.VA_TEXTINPUTBOXYTY_525141 = function(entities, changeEventArgs) {
		changeEventArgs.commons.execServer = false;
		try {
			var api = changeEventArgs.commons.api;
			var selectedRow = api.vc.grids.QV_2618_23821.selectedRow;

			if (changeEventArgs.value !== null) {
				selectedRow.set('porcentaje', null);
			}
		} catch (err) {
			alert(err.message);
		}
	};
}());