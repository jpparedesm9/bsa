//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanDisbursementMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_LOANDISBMN_824275","VC_VBHENKGGPP_117275",entities, renderEventArgs); 
        entities.LoanAdditionalInformation.lblAmountToCancel = 
            cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152')+': '+            
            kendo.toString(entities.LoanAdditionalInformation.amountOperation, 'c') +
            " "+entities.Loan.currencyName + " " +
            cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+
            entities.LoanAdditionalInformation.quotation;
    };