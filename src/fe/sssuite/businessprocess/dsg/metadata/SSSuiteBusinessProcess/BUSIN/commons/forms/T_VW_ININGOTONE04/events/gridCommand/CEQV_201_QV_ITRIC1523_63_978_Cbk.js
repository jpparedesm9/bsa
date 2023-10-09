//Start signature to callBack event to CEQV_201_QV_ITRIC1523_63_978
    task.gridCommandCallback.CEQV_201_QV_ITRIC1523_63_978 = function(entities, args) {
		args.newValue=entities.OriginalHeader.AmountRequested;
		task.change.VA_ORIAHEADER8602_OQUE134(entities, args);
		args.commons.execServer = false;
	};