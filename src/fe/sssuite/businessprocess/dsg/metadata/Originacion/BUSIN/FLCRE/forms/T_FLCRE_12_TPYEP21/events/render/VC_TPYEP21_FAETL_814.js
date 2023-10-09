//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
	//NOTA: Se aniade solo el codigo dado que la pantalla no funciona pero en lo que esta el servidor si
    task.render = function (entities, renderEventArgs){		
        renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState, template; //NOTA
        task.setFechaPagoFija(entities.PaymentPlan, viewState);//NOTA
    };

    task.setFechaPagoFija = function(paymentPlan, viewState) {//NOTA
        if(paymentPlan.fixedpPaymentDate == 'S') {
            viewState.enable('VA_VWPAYMENLA2605_ETDY540');
        } else {
            paymentPlan.paymentDay = 0;
            viewState.disable('VA_VWPAYMENLA2605_ETDY540');
        }
    };	
	