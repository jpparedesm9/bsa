//Start signature to Callback event to VC_SCANNEDDEU_695486
task.initDataCallback.VC_SCANNEDDEU_695486 = function(entities, initDataCallbackEventArgs) {
//here your code
    console.log("entra a callback");
    //Llamada a la funcion que muestra datos de la cabecera
    task.loadTaskHeader(entities, initDataCallbackEventArgs);
	//Se crea filtro para llenar la grilla
	var filtro = {
				groupId: entities.Group.code
			}
	//initDataCallbackEventArgs.commons.api.grid.refresh('QV_1763_79525',filtro);    
};