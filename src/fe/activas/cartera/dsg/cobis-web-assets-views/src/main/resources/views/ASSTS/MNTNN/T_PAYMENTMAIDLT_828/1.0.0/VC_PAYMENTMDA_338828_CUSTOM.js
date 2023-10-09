/* variables locales de T_PAYMENTMAIDLT_828*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.paymentmaintenancemodal;
    

    //"TaskId": "T_PAYMENTMAIDLT_828"

    //Entity: MethodsRetention
    //MethodsRetention.disbursement (ComboBox) View: PaymentMaintenanceModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DISBURSEMENTDSI_289701 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
        var  api = changeEventArgs.commons.api; 
        var desembolso  = entities.MethodsRetention.disbursement;
        var pagos     = entities.MethodsRetention.payment;
        var pagoAutomatico  = entities.MethodsRetention.paymentAut;
        var pagoCaja  = entities.MethodsRetention.paymentATX ;             
        validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja);        
    };

//Entity: MethodsRetention
    //MethodsRetention.paymentATX (ComboBox) View: PaymentMaintenanceModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PAYMENTATXPGDKX_602701 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        var  api = changeEventArgs.commons.api; 
        var desembolso  = entities.MethodsRetention.disbursement;
        var pagos     = entities.MethodsRetention.payment;
        var pagoAutomatico  = entities.MethodsRetention.paymentAut;
        var pagoCaja  = entities.MethodsRetention.paymentATX ;             
        validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja);
            
    };

//Entity: MethodsRetention
    //MethodsRetention.paymentAut (ComboBox) View: PaymentMaintenanceModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PAYMENTAUTLPCHV_485701 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
       var  api = changeEventArgs.commons.api; 
        var desembolso  = entities.MethodsRetention.disbursement;
        var pagos     = entities.MethodsRetention.payment;
        var pagoAutomatico  = entities.MethodsRetention.paymentAut;
        var pagoCaja  = entities.MethodsRetention.paymentATX ;             
        validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja);
        
    };

//Entity: MethodsRetention
    //MethodsRetention.payment (ComboBox) View: PaymentMaintenanceModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PAYMENTKWAZXHOL_773701 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        var  api = changeEventArgs.commons.api; 
        var desembolso  = entities.MethodsRetention.disbursement;
        var pagos     = entities.MethodsRetention.payment;
        var pagoAutomatico  = entities.MethodsRetention.paymentAut;
        var pagoCaja  = entities.MethodsRetention.paymentATX ;             
        validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja);
        
    };

// (Button) 
    task.executeCommand.CM_TPAYMENT_08P = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        	var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
    };

// (Button) 
    task.executeCommand.CM_TPAYMENT_TM7 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to callBack event to CM_TPAYMENT_TM7
    task.executeCommandCallback.CM_TPAYMENT_TM7 = function(entities, executeCommandEventArgs) {
        //here your code
         executeCommandEventArgs.commons.execServer = false;
		var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };

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

//Entity: MethodsRetention
    //MethodsRetention.bankServices (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_BANKSERVICESDQR_160701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = false;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Entity: MethodsRetention
    //MethodsRetention.canal (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CANALAHHGQQRYXT_909701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Entity: MethodsRetention
    //MethodsRetention.category (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CATEGORYPGXZQCK_157701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Entity: MethodsRetention
    //MethodsRetention.paymentMethods (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PAYMENTMETHODSD_816701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Entity: MethodsRetention
    //MethodsRetention.pcobis (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PCOBISNSCZVLGJB_151701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PaymentMaintenanceModal
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
    };

   function validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja){
       if (desembolso == 'S' && pagos == 'S' && pagoAutomatico == 'S' && pagoCaja == 'S'){
           api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = true;
           api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
           api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = true;  
        }else{
           if (desembolso == 'S' && pagos == 'S' && pagoAutomatico == 'S' && pagoCaja == 'N'){
               api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = true;
               api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
               api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = true;  
           }else{
              if (desembolso == 'S' && pagos == 'S' && pagoAutomatico == 'N' && pagoCaja == 'N'){
                  api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = true;
                  api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
                  api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = false;  
              }else{
                  if (desembolso == 'S' && pagos == 'N' && pagoAutomatico == 'N' && pagoCaja == 'N'){
                     api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = true;
                     api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
                     api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = false;  
                  }else{
                     if (desembolso == 'N' && pagos == 'N' && pagoAutomatico == 'N' && pagoCaja == 'N'){
                        api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = false;
                        api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = false;
                        api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = false;  
                     }else{
                        if (desembolso == 'N' && pagos == 'N' && pagoAutomatico == 'N' && pagoCaja == 'S'){
                           api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = false;
                           api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = false;
                           api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = false;  
                        }else{
                           if (desembolso == 'N' && pagos == 'N' && pagoAutomatico == 'S' && pagoCaja == 'S'){
                              api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = false;
                              api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
                              api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = true;  
                           }else{
                              if (desembolso == 'N' && pagos == 'S' && pagoAutomatico == 'S' && pagoCaja == 'S'){
                                 api.vc.viewState.VA_BANKSERVICESDQR_160701.visible = false;
                                 api.vc.viewState.VA_PCOBISNSCZVLGJB_151701.visible = true;
                                 api.vc.viewState.VA_TRANSACCTIONKAF_634701.visible = true;  
                              }                              
                           }
                        }                        
                     }
                  }
              }
           }
        }                    
    }



}));