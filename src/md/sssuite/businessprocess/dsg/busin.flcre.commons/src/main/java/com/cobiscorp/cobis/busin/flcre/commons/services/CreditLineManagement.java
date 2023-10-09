package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.TransactionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.LineHeader;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.ValidationQuotaVsAvailableBalance;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CreditLineManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(CreditLineManagement.class);

	public CreditLineManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public LineCreditData getByBank(String operationNumberBank, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setOperationNumberBank(operationNumberBank);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERYCREDITLINEBYBANK, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("LineCreditData recuperados para Banco - " + operationNumberBank);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (LineCreditData) serviceResponseApplicationTO.getValue(ReturnName.RETURNCREDITLINEDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ReadDisbursementFormResponse[] searchDisbursement(ReadDisbursementFormRequest readDisbursementFormRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INDISBURSEMENTFORM, readDisbursementFormRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYDISFORMSINFORMATION_BUSIN, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ReadDisbursementFormSearch recuperados para Banco: " + readDisbursementFormRequest.getBankReal());
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadDisbursementFormResponse[]) serviceResponseApplicationTO.getValue(ReturnName.RETURNDISBURSEMENT);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public LineCreditData[] getByCustomer(Integer customer, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setClient(customer);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHGETCREDITLINEDATABYCUSTOMER, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("LineCreditData recuperados para el cliente - " + customer);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (LineCreditData[]) serviceResponseApplicationTO.getValue(ReturnName.RETURNCREDITLINEDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean calculeMaximunQuotaLine(DynamicRequest entities, ICommonEventArgs arg1) {
		DataEntity validationQuotaVsAvailableBalance = entities.getEntity(ValidationQuotaVsAvailableBalance.ENTITY_NAME);
		DataEntity lineHeader = entities.getEntity(LineHeader.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		String tipoTramite= originalHeader.get(OriginalHeader.TYPEREQUEST);
		if (validationQuotaVsAvailableBalance != null) {
			boolean hasValues = true;
			Double rate = validationQuotaVsAvailableBalance.get(ValidationQuotaVsAvailableBalance.RATE);
			Integer term = validationQuotaVsAvailableBalance.get(ValidationQuotaVsAvailableBalance.TERM);

			if ((rate == null) || (term == null)) {
				hasValues = false;
			} else {
				Double amountProposed = null;
				rate = rate / 100.00;

				//Se valida cuando es Modificatorios para hacer el calculo de la Cuota Maxima Linea con el Monto Solicitado
				if ((originalHeader != null) && (originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null) && (tipoTramite!=null) && (tipoTramite.equals("P"))) {
					amountProposed = originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue();
				} else if((lineHeader != null) && (lineHeader.get(LineHeader.AMOUNTPROPOSED) != null)){
					amountProposed = lineHeader.get(LineHeader.AMOUNTPROPOSED);
				}else if((originalHeader != null) && (originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null)) {
					amountProposed = originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue();
				} else {
					hasValues = false;
				}

				if (hasValues) {
					Double numerator = rate * (Math.pow(rate + 1, term));
					Double denominator = Math.pow(rate + 1, term) - 1;
					Double maximumQuotaLine = amountProposed * (numerator / denominator);
					validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.MAXIMUMQUOTALINE, maximumQuotaLine);
					return true;
				}

			}
		} else {
			logger.logDebug("NO SE PUDO CALCULAR 'ValidationQuotaVsAvailableBalance.MAXIMUMQUOTALIN' ENTIDAD NO ENCONTRADA");
		}
		return false;
	}

	public void setDataForQuotaVsAvailableBalance(int requestId, DynamicRequest entities, LineCreditData lineResponse, ICommonEventArgs arg1) {
		DataEntity validationQuotaVsAvailableBalance = entities.getEntity(ValidationQuotaVsAvailableBalance.ENTITY_NAME);
		if (validationQuotaVsAvailableBalance == null) {
			return;
		}
		logger.logInfo("Entro al metodo 22222");
		// SETEO DE CAMPOS DE PESTAÑA DE VALIDACION CUOTA VS. SALDO DISPONIBLE
		if (lineResponse.getMaximunQuote() != null) {
			validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.MAXIMUMQUOTA, new BigDecimal(lineResponse.getMaximunQuote()));
		}
		if (lineResponse.getMaximunQuoteLine() != null) {
			validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.MAXIMUMQUOTALINE, lineResponse.getMaximunQuoteLine());
		}
		if (lineResponse.getTerm() != null) {
			validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.TERM, lineResponse.getTerm());
		}
		if (lineResponse.getRate() != null) {
			validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.RATE, lineResponse.getRate());
		} else {
			// BUSCA VALOR DE LA 'TASA' INVOCANDO A LA REGLA
			RuleExecutionManagement ruleExecutionMngmnt = new RuleExecutionManagement(this.getServiceIntegration());
			TransactionContext transactionContextDTO = ruleExecutionMngmnt.readRuleForRateCreditLine(requestId, arg1, new BehaviorOption(true));
			if (transactionContextDTO.isSuccess()) {
				validationQuotaVsAvailableBalance.set(ValidationQuotaVsAvailableBalance.RATE, (Double) transactionContextDTO.getValue("ValueForRateCreditLine"));
			} else {
				arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_OSTAOEATS_74282");
				arg1.setSuccess(false);
			}
		}

		// SI 'TASA' Y 'PLAZO' TIENEN VALOR SE PUEDE CALCULAR EL VALOR DE LA 'CUOTA MAXIMA LINEA'
		if ((validationQuotaVsAvailableBalance.get(ValidationQuotaVsAvailableBalance.RATE) != null) && (validationQuotaVsAvailableBalance.get(ValidationQuotaVsAvailableBalance.TERM) != null)) {
			// SOLO 'SI' EL VALOR DE LA 'CUOTA MAXIMA LINEA' ES NULL LA MANDO A RECALCULAR
			if (validationQuotaVsAvailableBalance.get(ValidationQuotaVsAvailableBalance.MAXIMUMQUOTALINE) == null) {
				this.calculeMaximunQuotaLine(entities, arg1);
			}
		}
	}
}
