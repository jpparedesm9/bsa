//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PaymentsMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_PAYMENTSAN_916157","VC_ZNXEHASOGQ_840157",entities, renderEventArgs);  
        
        if(screenCall=='refinance'){
            renderEventArgs.commons.api.viewState.label('VA_VABUTTONORYJAMS_468612','Regresar');            
            
            var buttonChange=$('#VA_VABUTTONORYJAMS_468612');
            var spanIcon=buttonChange.find("span");
            spanIcon.removeClass("glyphicon-search");
            spanIcon.addClass("glyphicon-chevron-left");            
        }   
        
        renderEventArgs.commons.api.viewState.hide("CM_TPAYMENT_Y_2");
        if (entities.LoanInstancia.tipo == 'G') {
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_SS1");
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_T7N");
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_NNS");
            renderEventArgs.commons.api.viewState.hide("CM_TPAYMENT_MA5");
            renderEventArgs.commons.api.viewState.hide("VA_CHECKBOXIPQLEBS_550141");
        }
    };