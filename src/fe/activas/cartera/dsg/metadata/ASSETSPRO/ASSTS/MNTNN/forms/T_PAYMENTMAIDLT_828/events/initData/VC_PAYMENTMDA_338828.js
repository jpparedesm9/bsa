//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PaymentMaintenanceModal
    task.initData.VC_PAYMENTMDA_338828 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        	     
		
		var mode = initDataEventArgs.commons.api.vc.mode;
        
         
    
        
        
        if (mode === 2){
		 initDataEventArgs.commons.execServer = false;
			var params=initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        var currentRow=params.currentRow;
		ASSETS.Utils.mappingEntity(entities.MethodsRetention,currentRow);
           }
        
        
         var  api = initDataEventArgs.commons.api; 
        if ( entities.MethodsRetention.disbursement ==='N'){
            
             
      // api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = false;
	   api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = false;
      }
        
        if ( entities.MethodsRetention.paymentAut ==='N'){
	 
       api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = false;
	   api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = false;
      }
		
		 entities.MethodsRetention.transacction ='D';
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };