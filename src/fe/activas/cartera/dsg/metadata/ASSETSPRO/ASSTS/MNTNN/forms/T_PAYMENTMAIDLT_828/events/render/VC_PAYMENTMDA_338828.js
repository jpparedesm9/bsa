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