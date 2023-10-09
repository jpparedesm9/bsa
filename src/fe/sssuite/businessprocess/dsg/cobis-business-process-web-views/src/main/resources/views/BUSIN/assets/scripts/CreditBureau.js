var CREDITBUREAU = {
		QUERYCENTRAL: {
			validateLevelIndebtedness : function(entities, args, fielId){
				args.commons.api.viewState.hide(fielId);
				if( !BUSIN.VALIDATE.IsNull(entities.Context) ){
					if( !BUSIN.VALIDATE.IsNullOrEmpty(entities.Context.TaskCountLap) && (entities.Context.TaskCountLap>1) ){
						args.commons.api.viewState.show(fielId);
					}
				}
			},
		},
};

document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');