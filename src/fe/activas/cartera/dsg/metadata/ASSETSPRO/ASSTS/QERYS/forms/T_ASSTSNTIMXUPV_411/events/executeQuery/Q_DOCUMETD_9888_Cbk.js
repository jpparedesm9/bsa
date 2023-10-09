//Start signature to Callback event to Q_DOCUMETD_9888
task.executeQueryCallback.Q_DOCUMETD_9888 = function(entities, executeQueryCallbackEventArgs) {
    //Limpiamos campos de busqueda luego de traer los resultados
    entities.HeaderQueryDocuments.groupName = null;
	entities.HeaderQueryDocuments.groupId = null;
	entities.HeaderQueryDocuments.clientName = null;
	entities.HeaderQueryDocuments.clientId = null;
	entities.HeaderQueryDocuments.loan = null;
	entities.HeaderQueryDocuments.procedure = null;
};