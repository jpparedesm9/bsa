//Start signature to Callback event to VA_5608FDSMYIVCMKB_809945
task.changeCallback.VA_5608FDSMYIVCMKB_809945 = function(entities, changeCallbackEventArgs) {
    if(changeCallbackEventArgs.success){
        if(entities.ReferenceInfor.refStatus == EXPIRED){ // C=CADUCADA

            var botonLabel = cobis.translate('CSTMR.LBL_CSTMR_ACEPTARZF_98506'),
            mensaje = cobis.translate('CSTMR.MSG_CSTMR_REFERENNI_70685'),
            titulo = cobis.translate('CSTMR.LBL_CSTMR_REFERENAD_67241');

            var buttons = [botonLabel],
            promise = cobis.showMessageWindow.confirm(mensaje, titulo, buttons);
            promise.then(function (response) {
                changeCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONTLJBFIX_730945','Compute', undefined, true, false, 'VC_VALIDATERE_626582', false);
            });
        }else{
            var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
            LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, false);
            controls = ['VA_5608FDSMYIVCMKB_809945'];
            LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, true);
        }
    }else{
        entities.ReferenceReq.referenceNumber = '';
        var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(changeCallbackEventArgs, controls, true);
    }
};