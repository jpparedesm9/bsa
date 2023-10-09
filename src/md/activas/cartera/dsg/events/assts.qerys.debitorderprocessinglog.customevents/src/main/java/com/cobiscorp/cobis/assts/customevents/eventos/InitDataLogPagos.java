package com.cobiscorp.cobis.assts.customevents.eventos;

import java.util.Date;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DebitOrderProcessingLogFilter;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;

public class InitDataLogPagos implements IInitDataEvent {

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		// TODO Auto-generated method stub
		String processDate = ServerParamUtil.getProcessDate();
		DataEntity debitOrderLogFilter = entities.getEntity(DebitOrderProcessingLogFilter.ENTITY_NAME);
		// debitOrderLogFilter.set(DebitOrderProcessingLogFilter.FROMDATE, new
		// Date());
		// debitOrderLogFilter.set(DebitOrderProcessingLogFilter.UNTILDATE, new
		// Date());
		debitOrderLogFilter.set(DebitOrderProcessingLogFilter.TYPEERROR, "T");
		debitOrderLogFilter.set(DebitOrderProcessingLogFilter.PROCESSDATE,
				GeneralFunction.convertStringToDate(processDate, Parameter.TYPEDATEFORMAT.MMDDYYYY));
	}

}
