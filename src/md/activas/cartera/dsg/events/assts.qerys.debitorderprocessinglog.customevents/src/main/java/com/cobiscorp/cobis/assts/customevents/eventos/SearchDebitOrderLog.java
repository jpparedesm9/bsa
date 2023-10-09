package com.cobiscorp.cobis.assts.customevents.eventos;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import cobiscorp.ecobis.assets.cloud.dto.DebitOrderProcessingLogRequest;
import com.cobiscorp.cobis.assts.model.DebitOrderProcessingLog;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchDebitOrderLog extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(SearchDebitOrderLog.class);

	public SearchDebitOrderLog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		// TODO Auto-generated method stub

		// Id de Servicio
		String serviceId = "Loan.DebitOrderProcessingLog.SearchDebitOrderProcessingLog";
		Integer clientId = null;
		DataEntity debitOrderProcessingLogResponseEntity;
		DataEntityList debitOrderProcessingLogResponseEntityList = new DataEntityList();

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		// Llamada y seteo DTO entrada
		DebitOrderProcessingLogRequest requestInDebitOrderProcessingLogRequest = new DebitOrderProcessingLogRequest();

		requestInDebitOrderProcessingLogRequest.setTypeError(arg0.getData().get("typeError") == null ? null : String.valueOf(arg0.getData().get("typeError")).trim());

		Calendar calendarUntilDate = Calendar.getInstance();
		Calendar calendarFromDate = Calendar.getInstance();

		if (arg0.getData().get("untilDate") != null) {
			calendarUntilDate.setTime(GeneralFunction.convertStringToDate(GeneralFunction.convertDateToString((Date) arg0.getData().get("untilDate"), false),
					Parameter.TYPEDATEFORMAT.DDMMYYYY));

			requestInDebitOrderProcessingLogRequest.setUntilDate(calendarUntilDate);
		}

		if (arg0.getData().get("fromDate") != null) {
			calendarFromDate.setTime(GeneralFunction.convertStringToDate(GeneralFunction.convertDateToString((Date) arg0.getData().get("fromDate"), false),
					Parameter.TYPEDATEFORMAT.DDMMYYYY));

			requestInDebitOrderProcessingLogRequest.setFromDate(calendarFromDate);
		}

		if (arg0.getData().get("clientId") != null && arg0.getData().get("clientId") != "") {
			clientId = Integer.valueOf(arg0.getData().get("clientId").toString());
		}
		requestInDebitOrderProcessingLogRequest.setClient(clientId);
		requestInDebitOrderProcessingLogRequest.setLoanNumber(arg0.getData().get("loanNumber") == null ? null : String.valueOf(arg0.getData().get("loanNumber")).trim());

		requestInDebitOrderProcessingLogRequest.setAccountNumber(arg0.getData().get("accountNumber") == null ? null : String.valueOf(arg0.getData().get("accountNumber")).trim());
		requestInDebitOrderProcessingLogRequest.setReference(arg0.getData().get("reference") == null ? null : String.valueOf(arg0.getData().get("reference")).trim());
		requestInDebitOrderProcessingLogRequest.setFilename(arg0.getData().get("filename") == null ? null : String.valueOf(arg0.getData().get("filename")).trim());
		// Invocación de servicio
		serviceRequest.addValue("inDebitOrderProcessingLogRequest", requestInDebitOrderProcessingLogRequest);

		// Ejecución de servicio
		ServiceResponse response = this.execute(logger, serviceId, serviceRequest);

		// Mapeo de respuesta
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {

				cobiscorp.ecobis.assets.cloud.dto.DebitOrderProcessingLogResponse[] debitOrderProcessingLogResponseList = (cobiscorp.ecobis.assets.cloud.dto.DebitOrderProcessingLogResponse[]) resultado
						.getValue("returnDebitOrderProcessingLogResponse");

				for (cobiscorp.ecobis.assets.cloud.dto.DebitOrderProcessingLogResponse debitOrderProcessingLogResponseDTO : debitOrderProcessingLogResponseList) {
					debitOrderProcessingLogResponseEntity = new DataEntity();
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.ERRORDESCRIPTION,
							debitOrderProcessingLogResponseDTO.getDescriptionError());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.STATE, debitOrderProcessingLogResponseDTO.getState());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.ERRORTYPE, debitOrderProcessingLogResponseDTO.getTypeError()==null?null:debitOrderProcessingLogResponseDTO.getTypeError().trim());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.ORDERGENERATIONDATE, debitOrderProcessingLogResponseDTO
							.getOrderGenerationDate().getTime());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.LOANNUMBER,
							debitOrderProcessingLogResponseDTO.getLoanNumber());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.PAYMENTAMOUNT,
							debitOrderProcessingLogResponseDTO.getPaymentAmount());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.ACCOUNTNUMBERSANTANDER,
							debitOrderProcessingLogResponseDTO.getAccountNumber());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.NAMECLIENT,
							debitOrderProcessingLogResponseDTO.getNameClient());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.REFERENCE, debitOrderProcessingLogResponseDTO.getReference());
					debitOrderProcessingLogResponseEntity.set(DebitOrderProcessingLog.FILENAME, debitOrderProcessingLogResponseDTO.getFilename());
					debitOrderProcessingLogResponseEntityList.add(debitOrderProcessingLogResponseEntity);
				}

			} else {
				arg1.setSuccess(false);
				GeneralFunction.handleResponse(arg1, response, null);
			}
		}
		arg1.setSuccess(true);
		return debitOrderProcessingLogResponseEntityList.getDataList();

	}
}
