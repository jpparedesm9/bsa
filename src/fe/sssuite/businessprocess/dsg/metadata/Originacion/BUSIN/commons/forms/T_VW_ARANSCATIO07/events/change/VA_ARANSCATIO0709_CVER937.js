//Entity: WarrantyGeneral
    //WarrantyGeneral.coverage (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0709_CVER937 = function( entities, changeEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var newCoverage = changedEventArgs.newValue;
        // CAMBIA EL PORCENTAJE SEGUN LA COBERTURA SELECCIONADA
        var arreglo = changedEventArgs.commons.api.vc.catalogs.VA_ARANSCATIO0709_CVER937.data();
        for (var i = 0; i < arreglo.length; i++) {
            if (arreglo[i].code == newCoverage) {
                entities.WarrantyGeneral.percentageCoverage = arreglo[i].attributes[0];
            }
        }
        
    };