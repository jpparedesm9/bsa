//Entity: Amount
    //Amount.authorizedAmount (TextInputBox) View: AmountForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXLEH_921190 = function(  entities, changedEventArgs ) {
            changedEventArgs.commons.execServer = false;
            
            if (changedEventArgs.newValue > 0) {
                changedEventArgs.rowData.cycleParticipation = 'S'
            }
            else {
                changedEventArgs.rowData.cycleParticipation = 'N'
            }
            
            var percentage = LATFO.COMMONS.getPercentage(changedEventArgs.commons.api.vc.model.Amount.data().map(function(item){return item.authorizedAmount}));                
            entities.Credit.warrantyAmount = percentage;
       changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
        
            // Seccion para el bloqueo de columnas
            
            // Incremento
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
            
            //  Monto Maximo Propuesto 
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
        
           if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
               changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXYVS_120190');
            
           }
        
      
        
    };