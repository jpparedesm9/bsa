//Start signature to Callback event to VC_BIOVALIDSA_412339
task.initDataCallback.VC_BIOVALIDSA_412339 = function(entities, initDataCallbackEventArgs) {
    var estado = '';
    if (initDataCallbackEventArgs.success && entities.Credit.applicationNumber != 0 && entities.Credit.applicationNumber != null) {
        //CABECERA DE PANTALLA       
        initDataCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.ValidationData.customerId + " - " + entities.ValidationData.customerName, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode == null || entities.Credit.creditCode == '0' ? '--' : entities.Credit.creditCode, 1);
        
        if(entities.Credit.productType == 'GRUPAL'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BMTRC.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested == 'null' ? 0 : entities.Credit.amountRequested), 2), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BMTRC.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount == 'null' ? 0 : entities.Credit.approvedAmount), 2), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.Credit.paymentFrecuency == null ? '--' : entities.Credit.paymentFrecuency), 1);
        }
        

        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        
        if(entities.Credit.productType == 'GRUPAL'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.ValidationData.cycleNumber, 2);
        }
        
        if (entities.Credit.productType == 'REVOLVENTE'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.Credit.sector, 2);
            initDataCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted ="YES";                    
        }
        
        LATFO.INBOX.updateTaskHeader(taskHeader, initDataCallbackEventArgs, 'G_HEADERSYFS_536967');

        //task.validateResult(entities);
        //IP local
        BMTRC.SERVICES.BIOCHECK.getLocalIpAddress(function(ip) {
            localIp = ip;
        });

    }
};