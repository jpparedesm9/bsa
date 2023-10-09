// (Button) 
    task.executeCommand.CM_TDOCUMEN_1RO = function(entities, executeCommandEventArgs) {
         var itemReporte;
        var reportTitle = "FICHA DE PRE CANCELACI\u00d3N";
        var sendMail =  executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ;//SOLO PDF
        var args ;
        var crearReporte = true;
        var loan = entities.Loan;
        
        executeCommandEventArgs.commons.execServer = false;
     
          //Operacion Padre
        if(operationType=='GRUPAL' && groupSummary=="S"){
             itemReporte = "PreCancellation";
            args = [['bank', entities.Loan.loanBankID],['amountPRE', 0],['sendMail', sendMail]]
            
        }else if(operationType=='GRUPAL' && groupSummary=="N"){
          itemReporte = "PreCancellation";
               args = [['clientID', entities.Loan.clientID],['amountPRE', 0],['sendMail', sendMail]]
              if(!task.isValidDate(processDateLocal,disbursementDate)){
                crearReporte=false;
              }
               
        }else if(operationType=='REVOLVENTE'){
           /* executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  */
            console.log("revolvente");
          
        }else {
            cobis.showMessageWindow.alertError("Formato no desarrollado","ERROR");
            crearReporte=false;
        }
     
        if(crearReporte){
            if (loan.statusID==3){
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                cobis.showMessageWindow.alert(message, 'FICHA DE PRE CANCELACI\u00d3N', buttons)
            }else{
                executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                if(args !== undefined){
                    args[2]=['sendMail','1']
                }
                var buttons = ['NO', 'SI'];
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                cobis.showMessageWindow.confirm('\u00bfDesea enviar la Ficha de Pre Cancelacion al Correo\u003f', 'AVISO', buttons).then(function (resp) {
                    switch (resp.buttonIndex) {
                        case 1: //accept
                            executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                            if(args !== undefined){
                                args[2]=['sendMail','2']
                            }
                            break;
                    }
                  
                    if(operationType=='REVOLVENTE'){
            executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                    }
                    else{ 
                        ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
                    }
                });
                
             
        
            }  
        }
    };