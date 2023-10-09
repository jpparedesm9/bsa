// (Button)
task.executeCommand.CM_TLOANSYB_04A = function (entities, executeCommandEventArgs) {
	executeCommandEventArgs.commons.execServer = false;

  let nameRemplaceSpace = entities.FilterSimulation.nameClient.replace(/ /g,"")

	var args = [
		["report.module", "cartera"],
		["report.name", "tablaSimulacion"],
		["nameRequested", nameRemplaceSpace],
		["termRequested", entities.FilterSimulation.term],
		["amountRequested", entities.FilterSimulation.amountRequest],
	];
	LATFO.UTILS.generarReporte(null, args);
};