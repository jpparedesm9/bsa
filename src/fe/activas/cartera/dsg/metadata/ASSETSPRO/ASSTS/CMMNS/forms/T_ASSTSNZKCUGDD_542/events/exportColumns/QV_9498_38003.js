//exportColumns QueryView: QV_9498_38003
        //Evento que permite personalizar que columnas se quiere exportar a excel
        task.exportColumns.QV_9498_38003 = function (exportColumnsEventArgs) {
            exportColumnsEventArgs.commons.execServer = false;
            
            exportColumnsEventArgs.exportColumnsToExcel.isSelected = false;
        };