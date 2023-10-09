//Entity: CondonationDetail
    //CondonationDetail.percentage (TextInputBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXTBY_391764 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_TEXTINPUTBOXVSD_563764._data;
        var selectedRow = changeEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        //Valida que se ingrese el rubro
        if (selectedRow.concept == '' || selectedRow.concept == null) {
            if (catalogData.length > 0) {
                selectedRow.concept = catalogData[0].code;
                selectedRow.description = catalogData[0].value;
            } else {
                changeEventArgs.commons.execServer = false;
                changeEventArgs.commons.messageHandler.showMessagesError("MSG_ASSTS_ELCAMPOOC_91834",true);
                return;
            }
        }
        
        //Obtener el indice de la fila seleccionada en el grid
        var entityIndex = -1;
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            if (selectedRow.uid ===  entities.CondonationDetail._data[i].uid) {
                entityIndex = i;
                break;
            }
        }

        var model = changeEventArgs.commons.api.vc.model;
        model.ServerParameter.selectedRow = entityIndex;
        //changeEventArgs.commons.serverParameters.CondonationDetail = true;
    };