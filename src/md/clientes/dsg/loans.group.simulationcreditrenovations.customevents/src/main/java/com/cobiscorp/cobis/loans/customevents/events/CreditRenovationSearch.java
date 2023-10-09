package com.cobiscorp.cobis.loans.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.InformationSimulation;
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
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioResponse;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovationRequest;

public class CreditRenovationSearch extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(CreditRenovationSearch.class);

	public CreditRenovationSearch(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso CreditRenovationSearch - executeDataEvent");
		}

		ServiceRequestTO request = new ServiceRequestTO();

		Map<String, Object> creditSimulationRenovation = (Map<String, Object>) entities.getData();

		logger.logDebug("creditSimulationRenovation" + creditSimulationRenovation);

		DataEntityList lista = new DataEntityList();

		SimulationCreditRenovationRequest simulationCreditRenovationRequest = new SimulationCreditRenovationRequest();

		try {
			logger.logDebug("creditSimulationRenovation.get(\"amountRequest\")" + creditSimulationRenovation.get("amountRequest"));
			logger.logDebug("creditSimulationRenovation.get(\"term\")" + creditSimulationRenovation.get("term"));

			if (creditSimulationRenovation.get("amountRequest") != null && creditSimulationRenovation.get("amountRequest") != "") {
				logger.logDebug("Ingreso amountRequest>>>");
				simulationCreditRenovationRequest.setMonto(Double.parseDouble(creditSimulationRenovation.get("amountRequest").toString()));

			}

			if (creditSimulationRenovation.get("term") != null && creditSimulationRenovation.get("term") != "") {
				simulationCreditRenovationRequest.setPlazo(Integer.parseInt( creditSimulationRenovation.get("term").toString()));
			}

			logger.logDebug("simulationCreditRenovationRequest>>> " + simulationCreditRenovationRequest);

			request.addValue("inSimulationCreditRenovationRequest", simulationCreditRenovationRequest);
			ServiceResponse response = this.execute(getServiceIntegration(), logger, "LoanGroup.CreditRenovation.SimulationCreditRenovation", request);

			logger.logDebug("Respuesta >>>>" + response);
			if (response != null) {
				if (response.isResult()) {

					logger.logDebug("Respuesta si es verdadera >>>>" + response);

					ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
					SimulationCreditRenovatioResponse[] simulationListResponse = (SimulationCreditRenovatioResponse[]) resultado.getValue("returnSimulationCreditRenovatioResponse");

					logger.logDebug("Tamaño de respuesta " + simulationListResponse);

					SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
					Date fechaDate = null;

					for (SimulationCreditRenovatioResponse result : simulationListResponse) {
						logger.logDebug("Resultado en la lista>>>>   " + result);
						DataEntity item = new DataEntity();
						item.set(InformationSimulation.NUMQUOTA, result.getDividendo());
						fechaDate = formato.parse(result.getFecha());
						item.set(InformationSimulation.PAYMENTDATE, fechaDate);
						item.set(InformationSimulation.CAPITALBALANCE, result.getCapital());
						item.set(InformationSimulation.INTEREST, result.getInteres());
						item.set(InformationSimulation.TOTALQUOTA, result.getTotal());
						lista.add(item);
					}
					args.setSuccess(true);
				} else {
					args.setSuccess(false);

				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("INCORRECTO");
				}
			}
		} catch (Exception e) {
			logger.logError("Error al realizar la simulación", e);
		}

		logger.logDebug("size:" + lista.size());
		args.setSuccess(true);
		return lista.getDataList();
	}

}
