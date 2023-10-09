//Start signature to Callback event to Q_RESULTTO_3724
task.executeQueryCallback.Q_RESULTTO_3724 = function(entities, executeQueryCallbackEventArgs) {
    for (var i = 0; i < entities.ResultadoPagosObjetados.data().length; i++) {
            entities.ResultadoPagosObjetados.data()[i].seleccionar = false;
    }
};