//Start signature to Callback event to VA_VABUTTONAICSAKZ_975190
task.executeCommandCallback.VA_VABUTTONAICSAKZ_975190 = function(entities, executeCommandCallbackEventArgs) {
 if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
            
           }      
};