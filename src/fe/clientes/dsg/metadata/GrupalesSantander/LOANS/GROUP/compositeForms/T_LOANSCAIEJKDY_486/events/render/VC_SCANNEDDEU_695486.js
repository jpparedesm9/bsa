//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ScannedDocuments
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        var filtro = {
				groupId: entities.Group.code,
				applicationNumber: entities.Credit.creditCode
			}
	   renderEventArgs.commons.api.grid.refresh('QV_1763_79525',filtro);
    };