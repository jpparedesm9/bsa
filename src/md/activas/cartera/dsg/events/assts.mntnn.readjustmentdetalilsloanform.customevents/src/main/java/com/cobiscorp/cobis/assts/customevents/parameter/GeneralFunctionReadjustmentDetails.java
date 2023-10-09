package com.cobiscorp.cobis.assts.customevents.parameter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentDetalilsLoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentDetalilsLoanResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter.TYPEEXECUTION;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentDetalilsLoan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class GeneralFunctionReadjustmentDetails extends BaseEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(GeneralFunctionReadjustmentDetails.class);

	private static final String REQUESTREADJUSTMENTDETAILS = "inReadjustmentDetalilsLoanRequest";

	public GeneralFunctionReadjustmentDetails(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Map<String, Object> eventGenerator(DynamicRequest entities,
			Parameter.TYPEEXECUTION typeExecution) {
		DataEntity readjustment = entities
				.getEntity(ReadjustmentLoanCab.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity readjustmentDetail = null;

		if (typeExecution == TYPEEXECUTION.UPDATE
				|| typeExecution == TYPEEXECUTION.DELETE) {
			readjustmentDetail = entities
					.getEntity(ReadjustmentDetalilsLoan.ENTITY_NAME);
		}

		return evaluationTransaction(readjustmentDetail, readjustment, loan,
				typeExecution);
	}

	public Map<String, Object> eventGenerator(DataEntity readjustmentDetail,
			DataEntity readjustment, DataEntity loan,
			Parameter.TYPEEXECUTION typeExecution) {
		return evaluationTransaction(readjustmentDetail, readjustment, loan,
				typeExecution);
	}

	private Map<String, Object> evaluationTransaction(
			DataEntity readjustmentDetail, DataEntity readjustment,
			DataEntity loan, Parameter.TYPEEXECUTION typeExecution) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<String> listMessages;

		listMessages = GeneralValidation.validationReadjustmentDetails(
				typeExecution, readjustmentDetail, readjustment, loan);

		if (listMessages != null && !listMessages.isEmpty()) {
			result.put(Parameter.MESSAGEVALIDATIONLIST, listMessages);
		} else {
			switch (typeExecution) {
			case UPDATE:
				result = this.updateReadjustmentDetailsLoan(readjustmentDetail,
						readjustment, loan);
				break;

			case DELETE:
				result = this.deleteReadjustmentDetailsLoan(readjustmentDetail,
						readjustment, loan);
				break;

			case SEARCH:
				result = this.searchReadjustmentDetailsLoan(readjustment, loan);
				break;

			default:
				break;
			}
		}

		return result;
	}

	private Map<String, Object> searchReadjustmentDetailsLoan(
			DataEntity readjustmentCab, DataEntity loan) {
		Map<String, Object> result = new HashMap<String, Object>();

		ReadjustmentDetalilsLoanRequest readjustmentDetalilsLoanRequest = new ReadjustmentDetalilsLoanRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		this.writeLog("Ingreso searchReadjustmentDetailsLoan",
				Parameter.LEVELDEBUG.DEBUG);

		readjustmentDetalilsLoanRequest.setBank(loan.get(Loan.LOANBANKID)
				.trim());
		readjustmentDetalilsLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));

		request.addValue(REQUESTREADJUSTMENTDETAILS,
				readjustmentDetalilsLoanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSSEARCHREADJUSTMENTDETAILS, request);

		this.writeLog("Response searchReadjustmentDetailsLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [SearchReadjustmentDetailsLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private Map<String, Object> updateReadjustmentDetailsLoan(
			DataEntity readjustmentDetails, DataEntity readjustmentCab,
			DataEntity loan) {
		this.writeLog("Ingreso updateReadjustmentDetailsLoan",
				Parameter.LEVELDEBUG.DEBUG);

		Map<String, Object> result = new HashMap<String, Object>();

		ReadjustmentDetalilsLoanRequest readjustmentDetalilsLoanRequest = new ReadjustmentDetalilsLoanRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		readjustmentDetalilsLoanRequest.setBank(loan.get(Loan.LOANBANKID)
				.trim());
		readjustmentDetalilsLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentDetalilsLoanRequest.setConcept(readjustmentDetails.get(
				ReadjustmentDetalilsLoan.CONCEPTO).trim());

		readjustmentDetalilsLoanRequest
				.setReferential((readjustmentDetails
						.get(ReadjustmentDetalilsLoan.REFERENCIAL) != null) ? readjustmentDetails
						.get(ReadjustmentDetalilsLoan.REFERENCIAL).trim()
						: readjustmentDetails
								.get(ReadjustmentDetalilsLoan.REFERENCIAL));

		readjustmentDetalilsLoanRequest
				.setSign((readjustmentDetails
						.get(ReadjustmentDetalilsLoan.SIGNO) != null) ? readjustmentDetails
						.get(ReadjustmentDetalilsLoan.SIGNO).trim()
						: readjustmentDetails
								.get(ReadjustmentDetalilsLoan.SIGNO));

		readjustmentDetalilsLoanRequest.setFactor(readjustmentDetails
				.get(ReadjustmentDetalilsLoan.FACTOR));
		readjustmentDetalilsLoanRequest.setPercentage(readjustmentDetails
				.get(ReadjustmentDetalilsLoan.PORCENTAJE));

		request.addValue(REQUESTREADJUSTMENTDETAILS,
				readjustmentDetalilsLoanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSUPDATEREADJUSTMENTDETAILS, request);

		this.writeLog("Response UpdateReadjustmentDetailsLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);
		this.writeLog("Respuesta: " + response.isResult(),
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [UpdateReadjustmentDetailsLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private Map<String, Object> deleteReadjustmentDetailsLoan(
			DataEntity readjustmentDetails, DataEntity readjustmentCab,
			DataEntity loan) {
		this.writeLog("Ingreso deleteReadjustmentDetailsLoan",
				Parameter.LEVELDEBUG.DEBUG);

		Map<String, Object> result = new HashMap<String, Object>();

		ReadjustmentDetalilsLoanRequest readjustmentDetalilsLoanRequest = new ReadjustmentDetalilsLoanRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		readjustmentDetalilsLoanRequest.setBank(loan.get(Loan.LOANBANKID)
				.trim());
		readjustmentDetalilsLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentDetalilsLoanRequest.setConcept(readjustmentDetails.get(
				ReadjustmentDetalilsLoan.CONCEPTO).trim());

		request.addValue(REQUESTREADJUSTMENTDETAILS,
				readjustmentDetalilsLoanRequest);

		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSDELETEREADJUSTMENTDETAILS, request);

		this.writeLog("Response DeleteReadjustmentDetailsLoan: " + response,
				Parameter.LEVELDEBUG.DEBUG);

		if (!evalueResponse(response, result)) {
			this.writeLog(
					"OCURRIO UN ERROR DESCONOCIDO [DeleteReadjustmentDetailsLoan].",
					Parameter.LEVELDEBUG.DEBUG);
		}

		return result;
	}

	private DataEntityList listGeneratorReadjustmentDetailsLoan(
			ServiceResponse response) {
		this.writeLog("Ingreso listGeneratorReadjustmentDetailsLoan",
				Parameter.LEVELDEBUG.INFO);

		DataEntityList lista = null;

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();

			ReadjustmentDetalilsLoanResponse[] clResponse = (ReadjustmentDetalilsLoanResponse[]) resultado
					.getValue("returnReadjustmentDetalilsLoanResponse");

			this.writeLog(
					"Respuesta servicio ListGeneratorReadjustmentDetailsLoan: "
							+ clResponse, Parameter.LEVELDEBUG.DEBUG);

			lista = new DataEntityList();
			for (ReadjustmentDetalilsLoanResponse r : clResponse) {
				DataEntity item = new DataEntity();
				item.set(ReadjustmentDetalilsLoan.CONCEPTO, r.getConcept()
						.trim());

				item.set(ReadjustmentDetalilsLoan.REFERENCIAL, r
						.getReferential() != null ? r.getReferential().trim()
						: r.getReferential());

				item.set(ReadjustmentDetalilsLoan.SIGNO,
						r.getSign() != null ? r.getSign().trim() : r.getSign());

				item.set(ReadjustmentDetalilsLoan.FACTOR, r.getFactor());
				item.set(ReadjustmentDetalilsLoan.PORCENTAJE, r.getPercentage());
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
					this.listGeneratorReadjustmentDetailsLoan(response));
		}

		return resultado;
	}

	private void writeLog(Object message, Parameter.LEVELDEBUG level) {
		GeneralFunction.writeLog(LOGGER, message, level);
	}
}
