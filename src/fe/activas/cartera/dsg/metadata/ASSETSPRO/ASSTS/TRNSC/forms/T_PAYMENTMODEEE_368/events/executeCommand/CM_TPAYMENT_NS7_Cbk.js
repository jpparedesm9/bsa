//Start signature to callBack event to CM_TPAYMENT_NS7
    task.executeCommandCallback.CM_TPAYMENT_NS7 = function(entities, executeCommandEventArgs) {
        //here your code
        var api = executeCommandEventArgs.commons.api;
      entities.PaymentForm.currencyName = api.vc.catalogs.VA_4212YIFTVBCOPPD_140216.get(entities.PaymentForm.currencyId);
      var dataGrid = {
         index: api.navigation.getCustomDialogParameters().rowIndex,
         mode: api.vc.mode,
         data:  entities.PaymentForm
      }
      api.navigation.closeModal(dataGrid);
    };