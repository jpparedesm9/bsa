//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ValidateReferenceForm
task.initData.VC_VALIDATERE_626582 = function (entities, initDataEventArgs){
    EXPIRED = cobis.translate('CSTMR.LBL_CSTMR_CADUCADAA_62798');
    ACTIVE = cobis.translate('CSTMR.LBL_CSTMR_VIGENTEWR_13152');
    APPLIED = cobis.translate('CSTMR.LBL_CSTMR_APLICADOO_96730');
    initDataEventArgs.commons.execServer = true;
    var controls = ['VA_4946SJPACVZFMWM_373945','VA_3427XJKLLNQAQYE_228945','VA_1SYTJLSFVGPZTLZ_730945',
                    'VA_2162OOPJZILSJIG_309945','VA_8931EJGJPFLRCLA_810945','VA_2008YZXDHFWCPDA_768945',
                    'VA_5204RGQEHWUBOFP_899945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
    LATFO.UTILS.disableFields(initDataEventArgs, controls, true);
    task.cleanFields(entities,initDataEventArgs);
};