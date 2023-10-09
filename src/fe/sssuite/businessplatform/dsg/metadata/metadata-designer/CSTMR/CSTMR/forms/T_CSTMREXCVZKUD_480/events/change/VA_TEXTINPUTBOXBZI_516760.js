//Entity: WarningRisk
    //WarningRisk.statusAlert (ComboBox) View: ViewAlertsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXBZI_516760 = function( entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
               
        
        if((changedEventArgs.newValue === 'NR') || (changedEventArgs.newValue === 'SR')){
            //changedEventArgs.commons.api.grid.enabledColumn('QV_3983_71432','observations');
            //changedEventArgs.commons.api.grid.addCellStyle('QV_3983_71432', changedEventArgs.rowData,'observations', 'Disable_CTR');
            changedEventArgs.commons.api.grid.enabledColumn('QV_3983_71432','observations');
            changedEventArgs.commons.api.grid.showColumn('QV_3983_71432', 'observations');
            
        } else {
            //changedEventArgs.commons.api.grid.disabledColumn('QV_3983_71432','observations');
           // changedEventArgs.commons.api.grid.removeCellStyle('QV_3983_71432', changedEventArgs.rowData,'observations', 'Disable_CTR');
            changedEventArgs.commons.api.grid.disabledColumn('QV_3983_71432','observations');
            changedEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
            
        }
        changedEventArgs.commons.api.ext.timeout(function() { //Aplicar el estilo en toda el area de todas las celdas marcadas
                $('.Disable_CTR').closest('td').addClass('Disable_CTR');
            },1000);
    };