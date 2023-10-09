// (Button) 
    task.executeCommand.CM_TASSTSFI_S64 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = false;
		var ds = executeCommandEventArgs.commons.api.vc.model['AccountStatus'];
        var dsData = ds.data();
		var flag = 1;
		var send = 'N';
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
			if(dsRow.toPrint === true){
				send = 'S';
				if(dsRow.email === '' || dsRow.email === undefined || dsRow.email === null){
					flag = 2;
					executeCommandEventArgs.commons.messageHandler.showMessagesInformation("ASSTS.MSG_ASSTS_CLIENTEUN_99499");
				}
			}
        }
		
		if(send === 'N'){
			var mns = cobis.translate('ASSTS.LBL_ASSTS_DEBESELCL_95286');
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation(mns, true);
		}else{
			if(flag == 1){
			executeCommandEventArgs.commons.execServer = true;
			}	
		}
    };