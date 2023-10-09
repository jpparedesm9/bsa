// Save (Button)
   task.executeCommand.CM_OIIRL51SVE80 = function(entities, executeCommandEventArgs) {
       if(entities.OriginalHeader.ProductType === "INDIVIDUAL"){
           if((entities.Aval.idCustomer === undefined) || (entities.Aval.idCustomer === null)){
               executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ELAVALEOB_47675');
               executeCommandEventArgs.commons.execServer = false;
               return;
           }
   	   }
       if(entities.OriginalHeader.CurrencyRequested === undefined){ // ACHP
	       executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('Ingrese la Moneda Solicitada', '', 3000, true);//No olvidar cambiar a etiqueta
		   executeCommandEventArgs.commons.execServer = false;
	   } else if(entities.ApplicationInfoAux.percentageGuarantee > 100 || entities.ApplicationInfoAux.percentageGuarantee < 0 ){ // ACHP
	       executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_VRPOSEY10_55418'); //Valor del Porcentaje debe ser entre 0 y 100
		   executeCommandEventArgs.commons.execServer = false;
	   }else {
	       if(task.validateRenderSection(entities, executeCommandEventArgs)){
		    /*if(task.validateEntities(entities) && task.validateAliquotEntities(entities)) {
		    	executeCommandEventArgs.commons.execServer = true;
		    } else {
		    	executeCommandEventArgs.commons.execServer = false;		
		    	executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795','',3000,true);
		    }*/
                if (task.validateEntities(entities)) {
                    if (entities.Alicuota.Alicuota === "N" && entities.Alicuota.CtaAhorros !== undefined && entities.Alicuota.CtaCertificada !== undefined) {
                    executeCommandEventArgs.commons.execServer = true;
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_AUOBLNOON_98811', '', 3000, true);
                    } else {
                    executeCommandEventArgs.commons.execServer = true;
                    }
                } else {
                    executeCommandEventArgs.commons.execServer = false;
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795', '', 3000, true);
                }
	       }else{
	           executeCommandEventArgs.commons.execServer = false;
		       executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('FINPM.DLB_FINPM_AILALIDIM_74169');
	       }
	   }
       if(modeType!= null){
           entities.Context.Type=modeType;
       }
   };