//Entity: DisbursementIncome
    //DisbursementIncome.Account (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SRSNTINOIW6604_ACCU010 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;

  var nav = textInputButtonEventArgs.commons.api.navigation;
        var api = textInputButtonEventArgs.commons.api;
        nav.customDialogParameters = {
   clientID: textInputButtonEventArgs.model.DisbursementIncome.CustomerId
        }
        nav.address = {
           moduleId: 'BUSIN',
           subModuleId: 'FLCRE',
           taskId: 'T_FLCRE_11_AATIN09',
           taskVersion: '1.0.0',
           viewContainerId: 'VC_AATIN09_UTINO_445'
        }
  nav.modalProperties = {
   size: "lg"
  }
        
    };