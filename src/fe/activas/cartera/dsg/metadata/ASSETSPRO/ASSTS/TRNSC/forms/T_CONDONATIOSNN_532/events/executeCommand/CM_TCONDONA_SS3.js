// (Button) 
    task.executeCommand.CM_TCONDONA_SS3 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var hasError = false;
        var msgResourceID = "";
        var selectedRow = executeCommandEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            if (entities.CondonationDetail._data[i].percentage > entities.ServerParameter.condonationPercentage) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18736"
                break;
            }
            if (entities.CondonationDetail._data[i].valueToCondone <= 0) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18737"
                break
            }
        }
        //valida que no ingrese mas de una vez el mismo rubro
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            var concept = entities.CondonationDetail._data[i].concept
            for (var j = i + 1; j < entities.CondonationDetail._data.length; j++) {
                if (entities.CondonationDetail._data[j].concept == concept) {
                    hasError = true;
                    msgResourceID = "ASSTS.MSG_ASSTS_NOPUEDEOR_19224";
                    break;
                }
            }
            if (hasError)
                break;
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        } else {
            var dataGrid = {
                data: entities.CondonationDetail
            }
            executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);
        }
    };