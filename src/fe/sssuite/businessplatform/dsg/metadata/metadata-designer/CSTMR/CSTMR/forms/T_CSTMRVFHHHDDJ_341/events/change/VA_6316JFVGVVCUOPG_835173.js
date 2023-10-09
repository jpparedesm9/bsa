//Entity: WarningRisk
    //WarningRisk.statusAlert (ComboBox) View: ViewAlertsEditForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6316JFVGVVCUOPG_835173 = function(  entities, changedEventArgs ) {

     changedEventArgs.commons.execServer = false;
               
        
        if((changedEventArgs.newValue === 'NR') || (changedEventArgs.newValue === 'SR')){
            changedEventArgs.commons.api.viewState.show('VA_3831FTIGRDFHULJ_171173');
            
        } else {
            changedEventArgs.commons.api.viewState.hide('VA_3831FTIGRDFHULJ_171173');
            
        }
        changedEventArgs.commons.api.ext.timeout(function() { //Aplicar el estilo en toda el area de todas las celdas marcadas
                $('.Disable_CTR').closest('td').addClass('Disable_CTR');
            },1000);
    
        
    };