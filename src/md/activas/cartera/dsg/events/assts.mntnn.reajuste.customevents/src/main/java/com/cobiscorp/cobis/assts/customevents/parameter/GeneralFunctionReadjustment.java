package com.cobiscorp.cobis.assts.customevents.parameter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentLoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentLoanResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter.TYPEEXECUTION;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class GeneralFunctionReadjustment extends BaseEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(GeneralFunctionReadjustment.class);

	private static final String REQUESTREADJUSTMENTLOAN = "inReadjustmentLoanRequest";

	public GeneralFunctionReadjustment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Map<String, Object> eventGenerator(DynamicRequest arg0,
			Parameter.TYPEEXECUTION typeExecution) {

		DataEntity readjustment = null;
		DataEntity loan = arg0.getEntity(Loan.ENTITY_NAME);

		this.writeLog("1) EventGenerator [" + typeExecution.toString() + "] ("
				+ loan.get(Loan.LOANBANKID) + ")", Parameter.LEVELDEBUG.INFO);

		if (typeExecution == TYPEEXECUTION.UPDATE
				|| typeExecution == TYPEEXECUTION.DELETE) {
			readjustment = arg0.getEntity(ReadjustmentLoanCab.ENTITY_NAME);
		}

		return this.evalueEvent(typeExecution, readjustment, loan);
	}

	public Map<String, Object> eventGenerator(DataEntity readjustment,
			DataEntity loan, Parameter.TYPEEXECUTION typeExecution) {

		this.writeLog("2) EventGenerator [" + typeExecution.toString() + "] ("
				+ loan.get(Loan.LOANBANKID) + ")", Parameter.LEVELDEBUG.INFO);

		return this.evalueEvent(typeExecution, readjustment, loan);
	}

	private Map<String, Object> evalueEvent(
			Parameter.TYPEEXECUTION typeExecution, DataEntity readjustment,
			DataEntity loan) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<String> listMessages;

		listMessages = GeneralValidation.validationReadjustment(typeExecution,
				readjustment, loan);

		if (listMessages != null && !listMessages.isEmpty()) {
			result.put(Parameter.MESSAGEVALIDATIONLIST, listMessages);
		} else {
			switch (typeExecution) {
			case UPDATE:
				result = this.updateReadjustmentLoan(readjustment, loan);
				break;

			case DELETE:
				result = this.deleteReadjustmentLoan(readjustment, loan);
				break;

			case SEARCH:
				result = this.searchReadjustmentLoan(loan);
				break;

			default:
				break;
			}
		}
		return result;
	}

	private Map<String, Object> searchReadjustmentLoan(DataEntity loan) {
		this.writeLog("Inicio searchReadjustmentLoan",
				Parameter.LEVELDEBUG.INFO);

		Map<String, Object> result = new HashMap<String, Object>();

		ServiceRequestTO request = new ServiceRequestTO();
		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();
		readjustmentLoanRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID).trim());
		readjustmentLoanRequest.setNext(0);

		request.addValue(REQUESTREADJUSTMENTLOAN, readjustmentLoanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSSEARCHREADJUSTMENT, request);

		this.writeLog("Response SearchReadjustmentLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [searchReadjustmentLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private Map<String, Object> updateReadjustmentLoan(
			DataEntity readjustmentCab, DataEntity loan) {
		this.writeLog("Inicio updateReadjustmentLoan",
				Parameter.LEVELDEBUG.INFO);

		Map<String, Object> result = new HashMap<String, Object>();

		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		this.writeLog("UpdateReadjustmentLoan", Parameter.LEVELDEBUG.INFO);

		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentLoanRequest.setEspecial(readjustmentCab.get(
				ReadjustmentLoanCab.MANTCUOTA).trim());
		readjustmentLoanRequest.setDesagio(readjustmentCab
				.get(ReadjustmentLoanCab.DESAGIO));

		readjustmentLoanRequest.setDateReadjustmentL(GeneralFunction
				.convertDateToString(
						readjustmentCab.get(ReadjustmentLoanCab.DATE), true));
		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));

		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID));
		readjustmentLoanRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		readjustmentLoanRequest.setNext(0);

		request.addValue(REQUESTREADJUSTMENTLOAN, readjustmentLoanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSUPDATEREADJUSTMENT, request);

		this.writeLog("Response UpdateReadjustmentLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);
		this.writeLog("Response --: " + response.isResult(),
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [UpdateReadjustmentLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private Map<String, Object> deleteReadjustmentLoan(
			DataEntity readjustmentCab, DataEntity loan) {
		this.writeLog("Inicio deleteReadjustmentLoan",
				Parameter.LEVELDEBUG.DEBUG);

		Map<String, Object> result = new HashMap<String, Object>();

		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID).trim());
		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentLoanRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		readjustmentLoanRequest.setNext(0);

		request.addValue(REQUESTREADJUSTMENTLOAN, readjustmentLoanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSDELETEREADJUSTMENT, request);

		this.writeLog("Response DeleteReadjustmentLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [DeleteReadjustmentLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private DataEntityList listGeneratorReadjustmentLoan(
			ServiceResponse response) {
		this.writeLog("Inicio listGeneratorReadjustmentLoan",
				Parameter.LEVELDEBUG.INFO);

		DataEntityList lista = null;

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			ReadjustmentLoanResponse[] clResponse = (ReadjustmentLoanResponse[]) resultado
					.getValue("returnReadjustmentLoanResponse");

			this.writeLog("Variable (ServiceResponse) response " + response,
					Parameter.LEVELDEBUG.INFO);
			this.writeLog("Variable (ReadjustmentLoanResponse[]) clResponse"
					+ clResponse, Parameter.LEVELDEBUG.INFO);

			lista = new DataEntityList();
			for (ReadjustmentLoanResponse r : clResponse) {
				DataEntity item = new DataEntity();
				item.set(ReadjustmentLoanCab.DATE, GeneralFunction
						.convertStringToDate(r.getDate(),
								Parameter.TYPEDATEFORMAT.DDMMYYYY));
				item.set(ReadjustmentLoanCab.MANTCUOTA, r.getMaintenanceFee());
				item.set(ReadjustmentLoanCab.SECUENCIAL, r.getSecuencial());
				item.set(ReadjustmentLoanCab.DESAGIO, r.getDesagio());

				lista.add(item);
			}
		}

		return lista;
	}

	private Boolean evalueResponse(ServiceResponse response,
			Map<String, Object> result) {
		Boolean resultado = GeneralFunction.evalueResponse(response, result);

		if (resultado) {
			result.put(Parameter.RESULTLIST,
					this.listGeneratorReadjustmentLoan(response));
		}

		return resultado;
	}

	private void writeLog(Object message, Parameter.LEVELDEBUG level) {
		GeneralFunction.writeLog(LOGGER, message, level);
	}
}
