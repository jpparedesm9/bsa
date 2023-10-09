//Start signature to Callback event to VC_CREDITBLOC_747144
task.initDataCallback.VC_CREDITBLOC_747144 = function(entities, initDataCallbackEventArgs) {

    task.loadFields(entities, initDataCallbackEventArgs);
    if(entities.Block.enabledAut=='S'){
        initDataCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSRB_NMS");
    }else{
        initDataCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSRB_NMS");
    }
};