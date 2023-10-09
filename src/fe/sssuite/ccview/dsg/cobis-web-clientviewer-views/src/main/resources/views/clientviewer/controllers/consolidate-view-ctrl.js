(function (window) {
    'use strict';

	var app = cobis.createModule(cobis.modules.CLIENTVIEWER, ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', "ngResource"]);

    
	
  	
	
    app
        .controller(
            "clientviewer.consolidatePositionController", [
       '$scope',
       '$rootScope',
       '$filter',
       'clientviewer.consolidatePositionService',
       'clientviewer.queryClientViewerService',
       '$location',
       function ($scope, $rootScope, $filter,
                    consolidatePositionService,
                    queryClientViewerService, $location) {
					
       }]);
	   
}(window));