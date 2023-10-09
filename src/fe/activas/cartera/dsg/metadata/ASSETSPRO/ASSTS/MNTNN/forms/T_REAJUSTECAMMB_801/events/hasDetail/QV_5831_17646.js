//gridInitDetailTemplate QueryView: QV_5831_17646
//
task.gridInitDetailTemplate.QV_5831_17646 = function (entities, gridInitDetailTemplateEventArgs) {
    gridInitDetailTemplateArgs.commons.execServer = false;
         
        try
        {
        	var nav = gridInitDetailTemplateArgs.commons.api.navigation;

          nav.address = {
              moduleId : 'ASSTS',
              subModuleId : 'MNTNN',
              taskId : 'T_REAJUSTEDEFTF_264',
              taskVersion : '1.0.0',
              viewContainerId : 'VC_REAJUSTEMF_502264'
          };
          
          nav.customDialogParameters = {
              readjustmentLoanCab:gridInitDetailTemplateArgs.modelRow              
          };
          nav.openDetailTemplate('QV_5831_17646', gridInitDetailTemplateArgs.modelRow);
        }
        catch(err)
        {
			ASSETS.Utils.managerException(err);
        }
};