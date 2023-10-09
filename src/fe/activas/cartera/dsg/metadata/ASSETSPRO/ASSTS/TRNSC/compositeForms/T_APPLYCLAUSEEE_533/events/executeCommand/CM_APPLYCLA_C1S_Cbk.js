//Start signature to callBack event to CM_APPLYCLA_C1S
    task.executeCommandCallback.CM_APPLYCLA_C1S = function(entities, executeCommandEventArgs) {
        //here your code
        ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
        ASSETS.Amortization.resizeGrid("QV_8237_80795");
    };