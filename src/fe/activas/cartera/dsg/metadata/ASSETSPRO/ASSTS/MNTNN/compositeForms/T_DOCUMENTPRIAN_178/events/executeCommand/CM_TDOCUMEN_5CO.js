// (Button) 
    task.executeCommand.CM_TDOCUMEN_5CO = function(entities, executeCommandEventArgs, option) {
       executeCommandEventArgs.commons.execServer = false;
        var itemReporte = "paymentCard";
        var reportTitle = "FICHA DE PAGO CR\u00c9DITO INDIVIDUAL";
        var sendMail =  executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ;//SOLO PDF
        var args = [['numOperation', entities.Loan.loanBankID.trim()],['sendMail', sendMail]];
    
        ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
        
    };