// (Button) 
    task.executeCommandCallback.CM_TASSTSFI_AS9 = function(entities, executeCommandCallback) {
        executeCommandCallback.commons.execServer = false;		
		var itemReporte = "AccountStatus";
		var flag = 0;
		var tittle ='';

		if(executeCommandCallback.success){
            for (var i = 0; i <= entities.AccountStatus.data().length - 1; i++) {				
                if(entities.AccountStatus.data()[i].toPrint === true){
            		flag = 1;
		     		var date = new Date(entities.AccountStatus.data()[i].date);
		     		var year = date.getFullYear();
		     		var month = date.getMonth()+1
		     		var day = date.getDate();
		     		var dateEn = day +"/" + month + "/" + year
		     		var sequential = 0;
		     		
                    var args = [['report.module', 'cartera'],['report.name', itemReporte],
            		            ['PBankNumber',entities.AccountStatus.data()[i].bankNumber],['PDate',dateEn],['PSequential',entities.AccountStatus.data()[i].sequential]];	
                    tittle = cobis.translate('ASSTS.LBL_ASSTS_ESTADOCAE_42774');								
                    ASSETS.Utils.generarReporte(null, args, tittle);
                }
            }
            if(flag===0){
		     	 var mns = cobis.translate('ASSTS.LBL_ASSTS_DEBESELCL_95286');
            	 executeCommandEventArgs.commons.messageHandler.showMessagesInformation(mns, true);
            }		
		}        
    };