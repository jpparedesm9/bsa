//"TaskId": "T_ASSTSRBSDDMKT_144"
task.loadFields = function(entities, args){

    var block = entities.Block;
    
    block.disbursementDate = kendo.toString((block.disbursementDate), cobis.containerScope.preferences.dateFormat);
    block.expirationDate = kendo.toString((block.expirationDate), cobis.containerScope.preferences.dateFormat);
    block.dateLastUpdate = kendo.toString((block.dateLastUpdate), cobis.containerScope.preferences.dateFormat);
    block.customerId = kendo.toString((block.customerId), "############");
    
    if (block.blocked == 'S'){
     args.commons.api.viewState.label("CM_TASSTSRB_N1N", 'ASSTS.LBL_ASSTS_DESBLOQUE_43117'); 
    }else{
     args.commons.api.viewState.label("CM_TASSTSRB_N1N", 'ASSTS.LBL_ASSTS_BLOQUEARR_90407');
    }
    
    if (block.active == 'N'){
        args.commons.api.viewState.disable("CM_TASSTSRB_N1N");
    }
};
    