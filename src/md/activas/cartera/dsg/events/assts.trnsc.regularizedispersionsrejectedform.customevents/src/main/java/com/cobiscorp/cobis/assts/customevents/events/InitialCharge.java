package com.cobiscorp.cobis.assts.customevents.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.SearchRejectedDispersions;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class InitialCharge extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitialCharge.class);
	protected ICobisParameter cobisParameter;

	public InitialCharge(ICTSServiceIntegration serviceIntegration, ICobisParameter cobisParameter) {
		super(serviceIntegration);
		this.cobisParameter = cobisParameter;
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {

		DataEntity wDatos = arg0.getEntity(SearchRejectedDispersions.ENTITY_NAME);
		String fechaProceso = null;
		String fechaParam = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");

		LOGGER.logInfo(">>>>>Antes del if: " + ServerParamUtil.getProcessDate());
		if (ServerParamUtil.getProcessDate() != null) {
			try {
				Integer wParam = getParameterByName("CCA", "DPDES");
				LOGGER.logInfo(">>>>>Parametro DPDES " + wParam);
				fechaProceso = ServerParamUtil.getProcessDate();
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(formatDate.parse(fechaProceso));
				calendar.add(Calendar.DAY_OF_YEAR, -wParam);
				fechaParam = formatDate.format(calendar.getTime());

				wDatos.set(SearchRejectedDispersions.ENDDATE, new SimpleDateFormat("MM/dd/yyyy").parse(fechaProceso));
				wDatos.set(SearchRejectedDispersions.STARTDATE, new SimpleDateFormat("MM/dd/yyyy").parse(fechaParam));

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public Integer getParameterByName(String aProduct, String aNemonic) {

		Integer param = null;

		try {
			ServiceRequestTO serviceRequestTo = new ServiceRequestTO();
			RejectedDispersionsRequest rejectedDispersionsRequest = new RejectedDispersionsRequest();

			rejectedDispersionsRequest.setOperation('A');

			serviceRequestTo.addValue(Parameter.DISPERSIONS_REQUEST, rejectedDispersionsRequest);
			ServiceResponse response = execute(LOGGER, Parameter.ACTIONDISPERSIONS, serviceRequestTo);

			LOGGER.logDebug(">>>>>Response getParameterByName " + response.getData());

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				Parameter[] pResponse = (Parameter[]) resultado.getValue("returnOutputParam");

				Map data = resultado.getData();
				Map output = (Map) data.get("com.cobiscorp.cobis.cts.service.response.output");

				LOGGER.logDebug("***************Response resultado " + output.get("@o_parametro"));

				param = Integer.valueOf(output.get("@o_parametro").toString());

			}
			return param;
		} catch (Exception e) {
			e.printStackTrace();
			return param;
		}
	}
}
