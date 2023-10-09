//Start signature to callBack event to VA_TEXTINPUTBOXUFN_810872
    task.changeCallback.VA_TEXTINPUTBOXUFN_810872 = function(entities, changeEventArgs) {
        var api = changeEventArgs.commons.api;
        var balanceOp = entities.OtherCharges.balanceOp;
        var balanceDesemp = entities.OtherCharges.balanceDesemp;        
        var categoryType = entities.OtherCharges.categoryType;        
        if(categoryType != null){
            if(categoryType.trim() ==='Q'){
                if (balanceOp.trim() === 'N' && balanceDesemp.trim() === 'N'){
                    api.viewState.enable("VA_BASECALCULATONI_509872");
                }else{
                    api.viewState.disable("VA_BASECALCULATONI_509872");
                }
            }    
            else{
            api.viewState.disable("VA_BASECALCULATONI_509872");
            }
        }
         else{
            api.viewState.disable("VA_BASECALCULATONI_509872");
        }
        //here your code
    };