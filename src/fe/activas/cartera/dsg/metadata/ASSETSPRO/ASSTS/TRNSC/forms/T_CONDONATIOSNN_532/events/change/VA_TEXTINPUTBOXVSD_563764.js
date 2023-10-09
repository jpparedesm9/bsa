//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXVSD_563764 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
        //Valida que se ingrese el rubro
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_TEXTINPUTBOXVSD_563764._data;
        var selectedRow = changeEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;

        if (selectedRow.concept == '' || selectedRow.concept == null) {
            if (catalogData.length > 0) {
                selectedRow.concept = catalogData[0].code;
                selectedRow.description = catalogData[0].value;
            } else {
                changeEventArgs.commons.execServer = false;
            }
        }
        if (selectedRow.percentage == 0) 
            changeEventArgs.commons.execServer = false;
        
        entities.ServerParameter.selectedRow = 0;
        //changeEventArgs.commons.serverParameters.CondonationDetail = true;
    };