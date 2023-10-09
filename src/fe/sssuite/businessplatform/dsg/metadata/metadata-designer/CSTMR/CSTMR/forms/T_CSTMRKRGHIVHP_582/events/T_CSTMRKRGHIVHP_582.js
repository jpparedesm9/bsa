//"TaskId": "T_CSTMRKRGHIVHP_582"

task.cleanFields = function (entities,args) {
    entities.ReferenceReq.referenceNumber = '';
    entities.ReferenceReq.authorizedAmount = 0 ;
    entities.ReferenceReq.purchaseAmount = 0 ;
    entities.ReferenceInfor.refValidity  = null;
    entities.ReferenceInfor.refStatus  = null;
    entities.ReferenceInfor.operationDate  = null;
    entities.ReferenceInfor.operationTime  = null;
    entities.ReferenceInfor.authorizationNumber  = null;
    
    var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
    LATFO.UTILS.disableFields(args, controls, true);
}