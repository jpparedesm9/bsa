//Entity: ReferenceReq
    //ReferenceReq.referenceNumber (TextInputBox) View: ValidateReferenceForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_5608FDSMYIVCMKB_809945 = function(  entities, changedEventArgs ) {
        //changedEventArgs.commons.serverParameters.ReferenceReq = true;
        EXPIRED = cobis.translate('CSTMR.LBL_CSTMR_CADUCADAA_62798');
        ACTIVE = cobis.translate('CSTMR.LBL_CSTMR_VIGENTEWR_13152');
        APPLIED = cobis.translate('CSTMR.LBL_CSTMR_APLICADOO_96730');
        entities.ReferenceInfor.authorizationNumber='';
        entities.ReferenceInfor.operationDate=null;
        entities.ReferenceInfor.operationTime=null;
        if(entities.ReferenceReq.referenceNumber != null && entities.ReferenceReq.referenceNumber != '' &&  
                entities.ReferenceReq.referenceNumber.length == entities.ReferenceReq.refLenght){
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;
        }
    };