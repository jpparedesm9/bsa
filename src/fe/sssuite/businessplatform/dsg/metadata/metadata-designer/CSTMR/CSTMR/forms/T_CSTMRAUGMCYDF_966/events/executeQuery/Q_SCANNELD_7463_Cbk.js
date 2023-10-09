//Start signature to Callback event to Q_SCANNELD_7463
task.executeQueryCallback.Q_SCANNELD_7463 = function(entities, executeQueryCallbackEventArgs) {
    if (executeQueryCallbackEventArgs.success) {
        var action = true;
        if(entities.ScannedDocumentsDetail.data().length != 0){
            for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                if(entities.ScannedDocumentsDetail.data()[i].uploaded === false){
                    action = false;
                }
            }
        }
        if (action === true){
            executeQueryCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
            executeQueryCallbackEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
        }
    }
	
	// Inicio Caso153311
    if(activeChangeIniDocs){
		activeChange = true
	    activeChangeIniDocs = false
	}// Fin Caso153311
	
    //Click tab inicial
	if(angular.isDefined(cargaInicial) && cargaInicial && angular.isDefined(activeChange) && activeChange){
		executeQueryCallbackEventArgs.commons.api.vc.clickTab(executeQueryCallbackEventArgs,'VC_DDRWXFYTSU_498680', 'VC_KXWIBTYNCU_272226', true);
		$("#VC_KXWIBTYNCU_272226_tab").prop("class","active");
		$("#VC_HVDQINWTYF_467680_tab").removeClass("active");
		cargaInicial = false;
	}
    
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    for (var i = 0; i < scannedDocumentsDetailList.length; i++) {
        if (scannedDocumentsDetailList[i].documentId == '010') {
            posDataModRequest = i;
            break;
        }
    }

};
