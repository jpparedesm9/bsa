package com.cobiscorp.cobis.paobj.customevents.query;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ReturnName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.paobj.model.ResultadoPagosObjetados;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.regularizepayments.dto.RegularizePaymentsRequest;
import cobiscorp.ecobis.regularizepayments.dto.RegularizePaymentsResponse;

public class ObjetedPaymentsQuery extends BaseEvent implements IExecuteQuery {
	private static final ILogger logger = LogFactory.getLogger(ObjetedPaymentsQuery.class);

	public ObjetedPaymentsQuery(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs arg1) {
		try {

			Map<String, Object> parameters = (Map<String, Object>) arg1.getParameters().getCustomParameters()
					.get("parameters");

			String esGrupo = parameters.get("esGrupo") != null ? parameters.get("esGrupo").toString() : "N";
			String criterioBusqueda = parameters.get("criterioBusqueda") != null
					? parameters.get("criterioBusqueda").toString()
					: "0";

			String criterio = esGrupo.equals("N") ? "I" : "G";

			logger.logDebug("Inicio: ObjetedPaymentsQuery.executeDataEvent");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponse serviceResponse;
			DataEntityList list = new DataEntityList();
			RegularizePaymentsRequest regularizePaymentsRequest = new RegularizePaymentsRequest();
			// paymentMethodRequest.setCreditLine(result.get(ResultadoPagosObjetados.));
			logger.logDebug("Seteo de set");
			regularizePaymentsRequest.setOperation(Parameter.OPERATIONB);
			logger.logDebug("Seteo de set");
			regularizePaymentsRequest.setCriteria(criterio);
			logger.logDebug("Seteo de set");
			regularizePaymentsRequest.setSequential(0);
			logger.logDebug("Despues de Seteo de set");
			regularizePaymentsRequest.setSearchValue(criterioBusqueda); // "80793"
			logger.logDebug("super.getServiceIntegration() != null: " + (super.getServiceIntegration() != null));

			serviceRequestTO.addValue(RequestName.OBJETED_PAYMENTS_REQUEST, regularizePaymentsRequest);
			serviceResponse = this.execute(logger, ServiceId.QUERY_OBJETED_PAYMENTS, serviceRequestTO);

			if (serviceResponse.isResult()) {
				logger.logDebug("serviceResponse.isResult() = " + serviceResponse.isResult());
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				if (serviceResponseTO.isSuccess()) {
					RegularizePaymentsResponse[] response = (RegularizePaymentsResponse[]) serviceResponseTO
							.getValue(ReturnName.OBJETED_PAYMENTS_RESPONSE);

					logger.logDebug("serviceResponseTO.isSuccess() = " + serviceResponseTO.isSuccess());

					for (RegularizePaymentsResponse item : response) {
						DataEntity entity = new DataEntity();
						Calendar cal = item.getDate();
						java.util.Date dateIni = cal.getTime();

						String pattern = "dd/MM/yyyy";
						SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

						String date = simpleDateFormat.format(dateIni);

						logger.logDebug("ResultadoPagosObjetados.IDPAGO = " + String.valueOf(item.getPaymentId()));
						// entity.set(ResultadoPagosObjetados.IDPRESTAMO,
						// String.valueOf(item.getSeq()));
						entity.set(ResultadoPagosObjetados.IDPAGO, String.valueOf(item.getPaymentId()));
						entity.set(ResultadoPagosObjetados.TIPOPRESTAMO, item.getLoanType());
						entity.set(ResultadoPagosObjetados.MONTOPAGADO, BigDecimal.valueOf(item.getAmountPayment()));
						entity.set(ResultadoPagosObjetados.FECHA, date);
						entity.set(ResultadoPagosObjetados.IDPRESTAMO, item.getLoanId());

						list.add(entity);
					}
					entities.setEntityList(ResultadoPagosObjetados.ENTITY_NAME, list);
				}
			} else {
				String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
				arg1.getMessageManager().showErrorMsg(mensaje);
			}
			return list.getDataList();
		} catch (Exception ex) {
			logger.logDebug("Exception--> " + ex);
		}
		return null;
	}

}
