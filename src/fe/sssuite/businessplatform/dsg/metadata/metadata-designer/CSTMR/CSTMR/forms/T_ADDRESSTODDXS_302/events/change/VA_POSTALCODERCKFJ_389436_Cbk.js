//Start signature to Callback event to VA_POSTALCODERCKFJ_389436
task.changeCallback.VA_POSTALCODERCKFJ_389436 = function (entities, changeCallbackEventArgs) {
    //here your code
    if (changeCallbackEventArgs.success == false) {
        entities.PhysicalAddress.provinceCode = '';
        entities.PhysicalAddress.cityCode = '';
        entities.PhysicalAddress.parishCode = '';
        entities.PhysicalAddress.latitude = 0;
        entities.PhysicalAddress.longitude = 0;
       
    }
    else {
        mustRefreshCity=true;
        mustRefreshParish=true;
        postalCodeChanged=true;
        changeCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXPPK_701436');
        changeCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436');
        
    }
};