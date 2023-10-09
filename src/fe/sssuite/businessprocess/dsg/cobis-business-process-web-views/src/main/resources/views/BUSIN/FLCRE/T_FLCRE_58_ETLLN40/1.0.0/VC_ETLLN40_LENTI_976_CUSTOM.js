<!-- Designer Generator v 5.0.0.1514 - release SPR 2015-14 24/07/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tdetailpenalization;

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************

    task.initData.VC_ETLLN40_LENTI_976 = function(entities, initDataEventArgs) { //ViewContainer: TDetailPenalization
		var api = initDataEventArgs.commons.api;
		var rowData = api.vc.rowData;
		entities.HeaderPunishment.ApplicationNumber = rowData.Operation;
    };

    task.render = function(entities, renderEventArgs) { //ViewContainer: TDetailPenalization
    };

}());