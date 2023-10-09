package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewDataResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.VariableDataRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.VariableDataResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.CurrentValuesOperationResponse;
import cobiscorp.ecobis.loan.dto.LoanResponse;
import cobiscorp.ecobis.loan.dto.NegotiatedPaymentResponse;
import cobiscorp.ecobis.loan.dto.NegotiatedPaymentResponseList;
import cobiscorp.ecobis.loan.dto.ReadArrearsDataResponse;
import cobiscorp.ecobis.loan.dto.ReadOperationCustomerRequest;
import cobiscorp.ecobis.loan.dto.ReadOperationCustomerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.Amount;
import com.cobiscorp.cobis.busin.model.ArrearsInfo;
import com.cobiscorp.cobis.busin.model.HeaderPunishment;
import com.cobiscorp.cobis.busin.model.InfoPayment;
import com.cobiscorp.cobis.busin.model.NegotiablePayments;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.busin.model.VariableData;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class OperationManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(OperationManagement.class);
	private RenewLoanResponse[] readCustomerOperation;

	public OperationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public RenewLoanResponse[] getReadCustomerOperation() {
		return readCustomerOperation;
	}

	public char searchOperationUse(String opCode, ICommonEventArgs arg1, BehaviorOption options) {
		char exist = ' ';
		cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest renewLoanRequest = new cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest();
		renewLoanRequest.setOperationCode(opCode);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANREQUEST, renewLoanRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHOPERATIONUSE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanResponse loanRes = (cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanResponse) serviceResponseTO
					.getValue(ReturnName.RETURNLOANRESPONSE);
			if (loanRes != null) {
				exist = loanRes.getExiste();
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return exist;
	}

	public DataTypeOperationResponse[] searchTypeOperation(DataTypeOperationRequest dataTypeOperation, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INDATATYPEOPERATION, dataTypeOperation);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHTYPEOPERATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("DataTypeOperationResponse para ID: " + dataTypeOperation.getOperationType() + ", ServiceId:" + ServiceId.SERVICESEARCHTYPEOPERATION);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DataTypeOperationResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNTYPEOPERATIONDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public VariableDataResponse[] searchVariableData(VariableDataRequest variableDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INVARIABLEDATAREQUEST, variableDataRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHVARIABLEDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("VariableDataResponse para ID: " + variableDataRequest.getOperationType() + ", ServiceId:" + ServiceId.SERVICESEARCHVARIABLEDATA);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (VariableDataResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNVARIABLEDATARESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ReadOperationCustomerResponse[] searchOperation(ReadOperationCustomerRequest readOperationCustomerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INREADOPERATION, readOperationCustomerRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADOPERATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("DataTypeOperationResponse para ID: " + readOperationCustomerRequest.getI_operation() + ", ServiceId:" + ServiceId.SERVICEREADOPERATION);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadOperationCustomerResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNOPERATIONCUTOMERRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public RenewLoanResponse[] searchCustomerOperations(RenewLoanRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.readCustomerOperation = null;
		logger.logDebug("ENTRO A searchCustomerOperations");
		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWOPERDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICEREADOPERATION);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			this.readCustomerOperation = (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
			return this.readCustomerOperation;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchCustomerOperations");
		}
		return null;
	}

	public RenewLoanResponse[] searchOperationsByCustomer(RenewLoanRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("ENTRO A searchOperationsByCustomer");
		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWLOANDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICEREADOPERATION);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchOperationsByCustomer");
		}
		return null;
	}

	public RenewLoanResponse[] searchOperationsByOperation(RenewLoanRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("ENTRO A searchOperationsByOperation");
		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		renewDataRequest.setCustomerId(-1); // MANDO ESTE VALOR PORQUE EL SP VALIDA QUE NO SE null
		serviceRequestTO.getData().put(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWOPERDATABYOPERATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICESEARCHRENEWOPERDATABYOPERATION);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchOperationsByOperation");
		}
		return null;
	}

	public RenewLoanResponse[] searchOperationsByCustomerTypeObject(RenewLoanRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("ENTRO A searchOperationsByCustomerTypeObject");
		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWOPERDATABYCUSTOMER, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICESEARCHRENEWOPERDATABYCUSTOMER);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchOperationsByCustomer");
		}
		return null;
	}

	// **************************************************************RLA

	public LoanResponse[] searchOperationsUse(LoanRequest renewLoanRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("ENTRO A searchOperationsUse");

		// LoanResponse loanReponse = new LoanResponse();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANREQUEST, renewLoanRequest);
		// serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHOPERATIONUSE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewLoanRequest.getOperationCode() + ", ServiceId:" + ServiceId.SERVICESEARCHOPERATIONUSE);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (LoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchOperationsUse");
		}
		return null;
	}

	// ***********************************************************************

	public DataEntityList searchTypeOperationAndValueMapping(String operationType, String productMnemonic, int codigoTramite, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		DataTypeOperationRequest dataTypeOperation = new DataTypeOperationRequest();
		dataTypeOperation.setOperationType(operationType);
		dataTypeOperation.setCobisProductMnemonic(productMnemonic);
		DataTypeOperationResponse[] typeOperationListDTO = this.searchTypeOperation(dataTypeOperation, arg1, options);
		if (typeOperationListDTO != null) {
			DataEntityList variableDataEntity = new DataEntityList();

			// MAPEA DATOS DE TIPO DE OPERACION
			for (DataTypeOperationResponse typeOperationData : typeOperationListDTO) {
				DataEntity eVariableData = new DataEntity();
				eVariableData.set(VariableData.IDFIELDVARIABLEDATA, typeOperationData.getDataCode());
				eVariableData.set(VariableData.FIELD, typeOperationData.getDataDescription());
				eVariableData.set(VariableData.VALUE, "");
				if (typeOperationData.getDataType() != null)
					eVariableData.set(VariableData.TYPE, typeOperationData.getDataType().toString());
				if (typeOperationData.getMandatory() != null)
					eVariableData.set(VariableData.MANDATORY, typeOperationData.getMandatory().toString());
				variableDataEntity.add(eVariableData);
			}

			// BUSCA LOS VALORES PARA CADA TIPO DE OPERACION
			if (variableDataEntity.size() > 0) {
				VariableDataRequest variableDataRequest = new VariableDataRequest();
				variableDataRequest.setOperationType(operationType);
				variableDataRequest.setCobisProductMnemonic(productMnemonic);
				variableDataRequest.setCreditCode(codigoTramite);

				VariableDataResponse[] variableDataListDTO = this.searchVariableData(variableDataRequest, arg1, options);
				if (variableDataListDTO != null && variableDataListDTO.length > 0) {
					for (DataEntity dataEntity : variableDataEntity) {
						for (VariableDataResponse variableDataDTO : variableDataListDTO) {
							if (dataEntity.get(VariableData.IDFIELDVARIABLEDATA).equals(variableDataDTO.getData())) {
								dataEntity.set(VariableData.VALUE, variableDataDTO.getValue());
							}
						}
					}
				}
			}
			return variableDataEntity;
		}
		return null;
	}

	public DataEntityList searchOperationAndMapping(int codigoCliente, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {

		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchOperationAndMapping");
		// RefinancingOperations
		DataEntityList refinancingOperations = new DataEntityList();
		ReadOperationCustomerRequest readOperationCustomerRequest = new ReadOperationCustomerRequest();

		readOperationCustomerRequest.setI_operation('S');
		readOperationCustomerRequest.setI_customer(codigoCliente);
		readOperationCustomerRequest.setI_cobranza('N');
		readOperationCustomerRequest.setI_only_cca('S');
		readOperationCustomerRequest.setI_option_b(3);
		ReadOperationCustomerResponse[] readOperation = this.searchOperation(readOperationCustomerRequest, arg1, options);

		for (ReadOperationCustomerResponse operationData : readOperation) {
			DataEntity eRefinancingOperations = new DataEntity();
			eRefinancingOperations.set(RefinancingOperations.OPERATIONBANK, operationData.getBank());
			eRefinancingOperations.set(RefinancingOperations.CURRENCYOPERATION, operationData.getCurrency());
			eRefinancingOperations.set(RefinancingOperations.BALANCE, operationData.getBalance());
			eRefinancingOperations.set(RefinancingOperations.LOCALCURRENCYBALANCE, operationData.getLocalCurrencyBalance());
			eRefinancingOperations.set(RefinancingOperations.ORIGINALAMOUNT, operationData.getAmount());
			eRefinancingOperations.set(RefinancingOperations.LOCALCURRENCYAMOUNT, operationData.getLocalCurrencyAmount());
			eRefinancingOperations.set(RefinancingOperations.CREDITTYPE, operationData.getTproduct());
			eRefinancingOperations.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, operationData.getRatingCustomer());
			eRefinancingOperations.set(RefinancingOperations.DATEGRANTING, operationData.getStartDate());
			eRefinancingOperations.set(RefinancingOperations.IDOPERATION, operationData.getBank());
			eRefinancingOperations.set(RefinancingOperations.ISBASE, false);
			eRefinancingOperations.set(RefinancingOperations.OFICIALOPERATION, operationData.getOficial());
			eRefinancingOperations.set(RefinancingOperations.OPERATIONQUALIFICATION, "");
			eRefinancingOperations.set(RefinancingOperations.PAYOUTPERCENTAGE, 0);
			eRefinancingOperations.set(RefinancingOperations.RATE, operationData.getRate());
			refinancingOperations.add(eRefinancingOperations);
		}
		// entities.setEntityList(RefinancingOperations.ENTITY_NAME, refinancingOperations);
		return refinancingOperations;
		// return null;
	}

	public DataEntityList searchOperationAndMappingbyRequest(String tramite, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchOperationAndMapping");

		String tipoTramite = entities.getEntity(OriginalHeader.ENTITY_NAME).get(OriginalHeader.TYPE);
		DataEntityList refinancingOperations = new DataEntityList();

		// RECUPERAR PARAMETRO DE LA MONEDA
		CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
		ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
		if (parameterDTO == null) {
			return refinancingOperations;
		}
		String localMoney = parameterDTO.getParameterValue();

		// RECUPERAR OPERACIONES
		RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		renewDataRequest.setNumRequest(Integer.parseInt(tramite));
		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		renewDataRequest.setCustomerId(-1); // MANDO ESTE VALOR PORQUE EL SP VALIDA QUE NO SE null
		RenewLoanResponse[] readCustomerOperation = this.searchCustomerOperations(renewDataRequest, arg1, options);

		if (readCustomerOperation != null) {
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
				if (logger.isDebugEnabled())
					logger.logDebug("Ingreso searchOperationCustomerAndMapping");
				DataEntity operationEntity = new DataEntity();
				operationEntity.set(RefinancingOperations.IDOPERATION, "");
				operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
				operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
				// String[] currencyCode = renewDataResponse.getDescrip_currency_origi().split("(");;
				// operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(currencyCode[0]));
				operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
				operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));

				operationEntity.set(RefinancingOperations.ISBASE, (renewDataResponse.getIsRenew() != null && renewDataResponse.getIsRenew().equals(Mnemonic.STRING_S)));
				if ((tipoTramite != null) && tipoTramite.equals(Mnemonic.RESCHEDULEREQUEST)) {
					operationEntity.set(RefinancingOperations.OFICIALOPERATION, renewDataResponse.getCustomerId());
				} else {
					operationEntity.set(RefinancingOperations.OFICIALOPERATION, renewDataResponse.getOfficer());
				}

				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(Integer.parseInt(renewDataResponse.getOperationMoney()));
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));
				quoteRequest.setOffice(1);
				quoteRequest.setModule(Mnemonic.MODULE);
				Double cotization = null;

				// if (currencyCode[0].equals(localMoney))
				if (renewDataResponse.getOperationMoney().equals(localMoney)) {
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				} else {
					cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()).multiply(new BigDecimal(cotization)));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()).multiply(new BigDecimal(cotization)));
				}
				operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation());
				operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
				operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
				operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
				operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
				operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
				operationEntity.set(RefinancingOperations.RATE, new Double(0));
				operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());
				refinancingOperations.add(operationEntity);
			}

		}

		return refinancingOperations;
		// return null;
	}

	public DataEntityList searchOperationByCustomerAndMappingbyRequest(RenewLoanRequest renewDataRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchOperationByCustomerAndMappingbyRequest");
		DataEntityList refinancingOperations = new DataEntityList();

		// RECUPERAR PARAMETRO DE LA MONEDA
		CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
		ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
		if (parameterDTO == null) {
			return refinancingOperations;
		}
		String localMoney = parameterDTO.getParameterValue();

		// RECUPERAR OPERACIONES
		// RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		// renewDataRequest.setNumRequest(Integer.parseInt(tramite));
		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		// renewDataRequest.setCustomerId(-1); // MANDO ESTE VALOR PORQUE EL SP VALIDA QUE NO SE null
		RenewLoanResponse[] readCustomerOperation = this.searchOperationsByCustomerTypeObject(renewDataRequest, arg1, options);

		if (readCustomerOperation != null) {
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
				if (logger.isDebugEnabled())
					logger.logDebug("Trajo Datos searchOperationsByCustomerTypeObject");
				DataEntity operationEntity = new DataEntity();
				operationEntity.set(RefinancingOperations.IDOPERATION, renewDataResponse.getNumOperation() + "");
				operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
				operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
				// String[] currencyCode = renewDataResponse.getDescrip_currency_origi().split("(");;
				// operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(currencyCode[0]));
				operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
				operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));

				operationEntity.set(RefinancingOperations.ISBASE, (renewDataResponse.getIsRenew() != null && renewDataResponse.getIsRenew().equals(Mnemonic.STRING_S)));
				operationEntity.set(RefinancingOperations.OFICIALOPERATION, 0);
				operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());

				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(Integer.parseInt(renewDataResponse.getOperationMoney()));
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));
				quoteRequest.setOffice(1);
				quoteRequest.setModule(Mnemonic.MODULE);
				Double cotization = null;

				// if (currencyCode[0].equals(localMoney))
				if (renewDataResponse.getOperationMoney().equals(localMoney)) {
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				} else {
					cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()).multiply(new BigDecimal(cotization)));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()).multiply(new BigDecimal(cotization)));
				}
				operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation());
				operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
				operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
				operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
				operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
				operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
				operationEntity.set(RefinancingOperations.RATE, new Double(0));
				refinancingOperations.add(operationEntity);
			}

		}

		return refinancingOperations;
		// return null;
	}

	public DataEntityList searchOperationCustomerMappingRequest(RenewLoanRequest renewDataRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchOperationByCustomerAndMappingbyRequest");
		DataEntityList refinancingOperations = new DataEntityList();

		// RECUPERAR PARAMETRO DE LA MONEDA
		CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
		ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
		if (parameterDTO == null) {
			return refinancingOperations;
		}
		String localMoney = parameterDTO.getParameterValue();

		// RECUPERAR OPERACIONES
		// RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		// renewDataRequest.setNumRequest(Integer.parseInt(tramite));
		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		// renewDataRequest.setCustomerId(-1); // MANDO ESTE VALOR PORQUE EL SP VALIDA QUE NO SE null
		RenewLoanResponse[] readCustomerOperation = this.searchOperationsByCustomer(renewDataRequest, arg1, options);

		if (readCustomerOperation != null) {
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
				if (logger.isDebugEnabled())
					logger.logDebug("Trajo Datos searchOperationsByCustomerTypeObject");
				DataEntity operationEntity = new DataEntity();
				operationEntity.set(RefinancingOperations.IDOPERATION, renewDataResponse.getNumOperation() + "");
				operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
				operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
				// String[] currencyCode = renewDataResponse.getDescrip_currency_origi().split("(");;
				// operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(currencyCode[0]));
				operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
				operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));

				operationEntity.set(RefinancingOperations.ISBASE, (renewDataResponse.getIsRenew() != null && renewDataResponse.getIsRenew().equals(Mnemonic.STRING_S)));
				operationEntity.set(RefinancingOperations.OFICIALOPERATION, 0);
				operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());

				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(Integer.parseInt(renewDataResponse.getOperationMoney()));
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));
				quoteRequest.setOffice(1);
				quoteRequest.setModule(Mnemonic.MODULE);
				Double cotization = null;

				// if (currencyCode[0].equals(localMoney))
				if (renewDataResponse.getOperationMoney().equals(localMoney)) {
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				} else {
					cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()).multiply(new BigDecimal(cotization)));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()).multiply(new BigDecimal(cotization)));
				}
				operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation());
				operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
				operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
				operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
				operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
				operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
				operationEntity.set(RefinancingOperations.RATE, new Double(0));
				refinancingOperations.add(operationEntity);
			}

		}

		return refinancingOperations;
		// return null;
	}

	public DataEntityList searchOperationByOperationAndMappingbyRequest(RenewLoanRequest renewDataRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		this.readCustomerOperation = null;
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchOperationByOperationAndMappingbyRequest");
		DataEntityList refinancingOperations = new DataEntityList();

		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		this.readCustomerOperation = this.searchOperationsByOperation(renewDataRequest, arg1, options);

		mappingOperationResponse(arg1, refinancingOperations, this.readCustomerOperation);
		return refinancingOperations;
	}

	// public double searchOperationByOperationAndMappingbyRequest02(RenewLoanRequest renewDataRequest, DynamicRequest entities, ICommonEventArgs
	// arg1, BehaviorOption options) {
	// double ret = 0.00;
	//
	// renewDataRequest.setDateFormat(Format.DATE);
	// RenewLoanResponse[] readCustomerOperation = this.searchOperationsByOperation(renewDataRequest, arg1, options);
	// if (readCustomerOperation!=null){
	// for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
	// renewDataResponse.getQuota();
	// logger.logDebug("Ingreso renewDataResponse.getQuota() "+renewDataResponse.getQuota());
	// }
	// ret = 123.12;
	// }
	// return ret;
	// }
	//

	private void mappingOperationResponse(ICommonEventArgs arg1, DataEntityList refinancingOperations, RenewLoanResponse[] readCustomerOperation) {
		// RECUPERAR PARAMETRO DE LA MONEDA
		CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
		ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
		if (parameterDTO == null) {
			return;
		}
		String localMoney = parameterDTO.getParameterValue();
		if (readCustomerOperation != null) {
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
				if (logger.isDebugEnabled())
					logger.logDebug("Trajo Datos searchOperationsByCustomerTypeObject");
				DataEntity operationEntity = new DataEntity();
				operationEntity.set(RefinancingOperations.IDOPERATION, renewDataResponse.getNumOperation() + "");
				operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
				operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
				operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
				operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));

				operationEntity.set(RefinancingOperations.ISBASE, true);
				operationEntity.set(RefinancingOperations.OFICIALOPERATION, 0);

				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(Integer.parseInt(renewDataResponse.getOperationMoney()));
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));
				quoteRequest.setOffice(1);
				quoteRequest.setModule(Mnemonic.MODULE);
				Double cotization = null;

				// if (currencyCode[0].equals(localMoney))
				if (renewDataResponse.getOperationMoney().equals(localMoney)) {
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				} else {
					cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()).multiply(new BigDecimal(cotization)));
					operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()).multiply(new BigDecimal(cotization)));
				}
				operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation());
				operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
				operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
				operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
				operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
				operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
				operationEntity.set(RefinancingOperations.RATE, new Double(0));
				operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());

				refinancingOperations.add(operationEntity);
			}

		}
	}

	public DataEntityList searchRescheduleOperationByOperationAndCliente(RenewLoanRequest renewDataRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		this.readCustomerOperation = null;
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso searchRescheduleOperationByOperationAndCliente");
		DataEntityList refinancingOperations = new DataEntityList();

		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		this.readCustomerOperation = this.searchRescheduleOperation(renewDataRequest, arg1, options);
		mappingOperationResponse(arg1, refinancingOperations, this.readCustomerOperation);
		return refinancingOperations;
	}

	public RenewLoanResponse[] searchRescheduleOperation(RenewLoanRequest renewDataRequest, ICommonEventArgs args, BehaviorOption options) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Executing searchRescheduleOperation .... ");
		}

		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.getData().put(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHRESCHEDULEOPERBYCUSTOMERANDOPER, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICESEARCHRENEWOPERDATABYOPERATION);
			}

			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, args, options);
			if (logger.isDebugEnabled()) {
				logger.logDebug("No data searchRescheduleOperation");
			}

		}
		return null;
	}

	public void validateBalanceOper(int application, ICommonEventArgs args, BehaviorOption options) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Executing validateBalanceoper .... ");
		}

		ApplicationRequest appRequest = new ApplicationRequest();
		appRequest.setIdrequested(application);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INAPPLICATIONREQUEST, appRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.VALIDATEAPPLICATIONOPERATIONS, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			// las operaciones tiene saldo en capital
			MessageManagement.show(serviceResponse, args, options);
			MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_OCENEUADA_38257", MessageLevel.ERROR, false));
		}
	}

	public void ReadCurrentValuesByOperation(LoanRequest loanRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		NegotiatedPaymentResponseList negotiatedPaymentResponseList = new NegotiatedPaymentResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANREQUEST, loanRequest);
		serviceRequestTO.getData().put(ReturnName.OUTNEGOTIATEDPAYMENTRESPONSELIST, negotiatedPaymentResponseList);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCURRENTVALUESBYOPERATION, serviceRequestTO);//trn 74002

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("VariableDataResponse para ID: " + loanRequest.getBank() + ", ServiceId:" + ServiceId.SERVICESEARCHVARIABLEDATA);
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTO.isSuccess()) {
				NegotiatedPaymentResponse[] negotiatedPaymentResponses = (NegotiatedPaymentResponse[]) serviceResponseTO.getValue(ReturnName.RETURNNEGOTIATEDPAYMENTRESPONSE);
				CurrentValuesOperationResponse currentValuesOperationResponses = (CurrentValuesOperationResponse) serviceResponseTO.getValue(ReturnName.RETURNCURRENTVALUESOPERATIONRESPONSE);
				ReadArrearsDataResponse readArrearsDataResponse = (ReadArrearsDataResponse) serviceResponseTO.getValue(ReturnName.RETURNARREARSDATARESPONSE);

				DataEntityList infoPaymentList = new DataEntityList();
				DataEntityList amountList = new DataEntityList();
				DataEntity dataEntityCaptial = new DataEntity();
				DataEntity dataEntityInterest = new DataEntity();
				DataEntity dataEntityMora = new DataEntity();
				DataEntity dataEntityOtros = new DataEntity();

				DataEntity dataEntityTotal = new DataEntity();
				if (arg1.getParameters().getTaskId().equals("T_FLCRE_84_PUSEN31")) {// Se valida la tarea actual (T_FLCRE_84_PUSEN31 Ingreso
																					// castigo/Moratoria)

					BigDecimal capitalAgreed;
					BigDecimal capitailPaid;
					BigDecimal capitalBalanceCourt;
					BigDecimal capitalBalance;
					dataEntityCaptial.set(Amount.CONCEPT, Mnemonic.PG_CAPITAL);// CAPITAL
					
					if (currentValuesOperationResponses.getCapitalAgreed() != null) {
						dataEntityCaptial.set(Amount.AGREEDAMOUNT, new BigDecimal(currentValuesOperationResponses.getCapitalAgreed()));
						capitalAgreed = new BigDecimal(currentValuesOperationResponses.getCapitalAgreed());
					} else {
						dataEntityCaptial.set(Amount.AGREEDAMOUNT, new BigDecimal(0));
						capitalAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getCapitalPaid() != null) {
						dataEntityCaptial.set(Amount.AMOUNTPAID, new BigDecimal(currentValuesOperationResponses.getCapitalPaid()));
						capitailPaid = new BigDecimal(currentValuesOperationResponses.getCapitalPaid());
					} else {
						dataEntityCaptial.set(Amount.AMOUNTPAID, new BigDecimal(0));
						capitailPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getCapitalBalanceCourt() != null) {
						dataEntityCaptial.set(Amount.BALANCECUTOFFDATE, new BigDecimal(currentValuesOperationResponses.getCapitalBalanceCourt()));
						capitalBalanceCourt = new BigDecimal(currentValuesOperationResponses.getCapitalBalanceCourt());
					} else {
						dataEntityCaptial.set(Amount.BALANCECUTOFFDATE, new BigDecimal(0));
						capitalBalanceCourt = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getCapitalBalance() != null) {
						dataEntityCaptial.set(Amount.BALANCEDATE, new BigDecimal(currentValuesOperationResponses.getCapitalBalance()));
						capitalBalance = new BigDecimal(currentValuesOperationResponses.getCapitalBalance());
					} else {
						dataEntityCaptial.set(Amount.BALANCEDATE, new BigDecimal(0));
						capitalBalance = new BigDecimal(0);
					}
					amountList.add(dataEntityCaptial);

					BigDecimal interestAgreed;
					BigDecimal interestPaid;
					BigDecimal interestBalanceCourt;
					BigDecimal interestBalance;
					dataEntityInterest.set(Amount.CONCEPT, Mnemonic.PG_INTERES);// INTERES
					if (currentValuesOperationResponses.getInterestAgreed() != null) {
						dataEntityInterest.set(Amount.AGREEDAMOUNT, new BigDecimal(currentValuesOperationResponses.getInterestAgreed()));
						interestAgreed = new BigDecimal(currentValuesOperationResponses.getInterestAgreed());
					} else {
						dataEntityInterest.set(Amount.AGREEDAMOUNT, new BigDecimal(0));
						interestAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getInterestPaid() != null) {
						dataEntityInterest.set(Amount.AMOUNTPAID, new BigDecimal(currentValuesOperationResponses.getInterestPaid()));
						interestPaid = new BigDecimal(currentValuesOperationResponses.getInterestPaid());
					} else {
						dataEntityInterest.set(Amount.AMOUNTPAID, new BigDecimal(0));
						interestPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getInterestBalanceCourt() != null) {
						dataEntityInterest.set(Amount.BALANCECUTOFFDATE, new BigDecimal(currentValuesOperationResponses.getInterestBalanceCourt()));
						interestBalanceCourt = new BigDecimal(currentValuesOperationResponses.getInterestBalanceCourt());
					} else {
						dataEntityInterest.set(Amount.BALANCECUTOFFDATE, new BigDecimal(0));
						interestBalanceCourt = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getInterestBalance() != null) {
						dataEntityInterest.set(Amount.BALANCEDATE, new BigDecimal(currentValuesOperationResponses.getInterestBalance()));
						interestBalance = new BigDecimal(currentValuesOperationResponses.getInterestBalance());
					} else {
						dataEntityInterest.set(Amount.BALANCEDATE, new BigDecimal(0));
						interestBalance = new BigDecimal(0);
					}

					amountList.add(dataEntityInterest);

					BigDecimal moraAgreed;
					BigDecimal moraPaid;
					BigDecimal moraBalanceCourt;
					BigDecimal moraBalance;
					dataEntityMora.set(Amount.CONCEPT, Mnemonic.PG_INTERES_MORA);// MORA=INTERES PENAL
					if (currentValuesOperationResponses.getMoraAgreed() != null) {
						dataEntityMora.set(Amount.AGREEDAMOUNT, new BigDecimal(currentValuesOperationResponses.getMoraAgreed()));
						moraAgreed = new BigDecimal(currentValuesOperationResponses.getMoraAgreed());
					} else {
						dataEntityMora.set(Amount.AGREEDAMOUNT, new BigDecimal(0));
						moraAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getMoraPaid() != null) {
						dataEntityMora.set(Amount.AMOUNTPAID, new BigDecimal(currentValuesOperationResponses.getMoraPaid()));
						moraPaid = new BigDecimal(currentValuesOperationResponses.getMoraPaid());
					} else {
						dataEntityMora.set(Amount.AMOUNTPAID, new BigDecimal(0));
						moraPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getMoraBalanceCourt() != null) {
						dataEntityMora.set(Amount.BALANCECUTOFFDATE, new BigDecimal(currentValuesOperationResponses.getMoraBalanceCourt()));
						moraBalanceCourt = new BigDecimal(currentValuesOperationResponses.getMoraBalanceCourt());
					} else {
						dataEntityMora.set(Amount.BALANCECUTOFFDATE, new BigDecimal(0));
						moraBalanceCourt = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getMoraBalance() != null) {
						dataEntityMora.set(Amount.BALANCEDATE, new BigDecimal(currentValuesOperationResponses.getMoraBalance()));
						moraBalance = new BigDecimal(currentValuesOperationResponses.getMoraBalance());
					} else {
						dataEntityMora.set(Amount.BALANCEDATE, new BigDecimal(0));
						moraBalance = new BigDecimal(0);
					}

					amountList.add(dataEntityMora);

					dataEntityTotal.set(Amount.CONCEPT, Mnemonic.PG_TOTAL);// TOTAL
					dataEntityTotal.set(Amount.AGREEDAMOUNT, capitalAgreed.add(interestAgreed).add(moraAgreed));
					dataEntityTotal.set(Amount.AMOUNTPAID, capitailPaid.add(interestPaid).add(moraPaid));
					dataEntityTotal.set(Amount.BALANCECUTOFFDATE, capitalBalanceCourt.add(interestBalanceCourt).add(moraBalanceCourt));
					dataEntityTotal.set(Amount.BALANCEDATE, capitalBalance.add(interestBalance).add(moraBalance));

					amountList.add(dataEntityTotal);
					entities.setEntityList(Amount.ENTITY_NAME, amountList);
					DataEntity headerPunishment = entities.getEntity(HeaderPunishment.ENTITY_NAME);
					headerPunishment.set(HeaderPunishment.NUMBERCREDITSEARNED, readArrearsDataResponse.getOperationsNumbers());
				} else {
					BigDecimal capitalAgreed;
					BigDecimal capitailPaid;
					BigDecimal capitalBalance;
					BigDecimal moraAgreed;
					BigDecimal moraPaid;
					BigDecimal moraBalance;
					BigDecimal othersAgreed;
					BigDecimal othersPaid;
					BigDecimal othersBalance;
					BigDecimal interestAgreed;
					BigDecimal interestPaid;
					BigDecimal interestBalance;

					dataEntityCaptial.set(InfoPayment.TITLECOLUMN, Mnemonic.PG_CAPITAL);// CAPITAL
					if (currentValuesOperationResponses.getCapitalAgreed() != null) {
						dataEntityCaptial.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(currentValuesOperationResponses.getCapitalAgreed()));
						capitalAgreed = new BigDecimal(currentValuesOperationResponses.getCapitalAgreed());
					} else {
						dataEntityCaptial.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(0));
						capitalAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getCapitalPaid() != null) {
						dataEntityCaptial.set(InfoPayment.PAYMENTPAID, new BigDecimal(currentValuesOperationResponses.getCapitalPaid()));
						capitailPaid = new BigDecimal(currentValuesOperationResponses.getCapitalPaid());
					} else {
						dataEntityCaptial.set(InfoPayment.PAYMENTPAID, new BigDecimal(0));
						capitailPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getCapitalBalance() != null) {
						dataEntityCaptial.set(InfoPayment.BALANCE, new BigDecimal(currentValuesOperationResponses.getCapitalBalance()));
						capitalBalance = new BigDecimal(currentValuesOperationResponses.getCapitalBalance());
					} else {
						dataEntityCaptial.set(InfoPayment.BALANCE, new BigDecimal(0));
						capitalBalance = new BigDecimal(0);
					}

					infoPaymentList.add(dataEntityCaptial);

					dataEntityInterest.set(InfoPayment.TITLECOLUMN, Mnemonic.PG_INTERES);// INTERES

					if (currentValuesOperationResponses.getInterestAgreed() != null) {
						dataEntityInterest.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(currentValuesOperationResponses.getInterestAgreed()));
						interestAgreed = new BigDecimal(currentValuesOperationResponses.getInterestAgreed());
					} else {
						dataEntityInterest.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(0));
						interestAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getInterestPaid() != null) {
						dataEntityInterest.set(InfoPayment.PAYMENTPAID, new BigDecimal(currentValuesOperationResponses.getInterestPaid()));
						interestPaid = new BigDecimal(currentValuesOperationResponses.getInterestPaid());
					} else {
						dataEntityInterest.set(InfoPayment.PAYMENTPAID, new BigDecimal(0));
						interestPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getInterestBalance() != null) {
						dataEntityInterest.set(InfoPayment.BALANCE, new BigDecimal(currentValuesOperationResponses.getInterestBalance()));
						interestBalance = new BigDecimal(currentValuesOperationResponses.getInterestBalance());
					} else {
						dataEntityInterest.set(InfoPayment.BALANCE, new BigDecimal(0));
						interestBalance = new BigDecimal(0);
					}

					infoPaymentList.add(dataEntityInterest);

					dataEntityMora.set(InfoPayment.TITLECOLUMN, Mnemonic.PG_INTERES_MORA);// MORA=INTERES PENAL
					if (currentValuesOperationResponses.getMoraAgreed() != null) {
						dataEntityMora.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(currentValuesOperationResponses.getMoraAgreed()));
						moraAgreed = new BigDecimal(currentValuesOperationResponses.getMoraAgreed());
					} else {
						dataEntityMora.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(0));
						moraAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getMoraPaid() != null) {
						dataEntityMora.set(InfoPayment.PAYMENTPAID, new BigDecimal(currentValuesOperationResponses.getMoraPaid()));
						moraPaid = new BigDecimal(currentValuesOperationResponses.getMoraPaid());
					} else {
						dataEntityMora.set(InfoPayment.PAYMENTPAID, new BigDecimal(0));
						moraPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getMoraBalance() != null) {
						dataEntityMora.set(InfoPayment.BALANCE, new BigDecimal(currentValuesOperationResponses.getMoraBalance()));
						moraBalance = new BigDecimal(currentValuesOperationResponses.getMoraBalance());
					} else {
						dataEntityMora.set(InfoPayment.BALANCE, new BigDecimal(0));
						moraBalance = new BigDecimal(0);
					}

					infoPaymentList.add(dataEntityMora);

					dataEntityOtros.set(InfoPayment.TITLECOLUMN, Mnemonic.PG_OTROS);// OTROS
					if (currentValuesOperationResponses.getOthersAgreed() != null) {
						dataEntityOtros.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(currentValuesOperationResponses.getOthersAgreed()));
						othersAgreed = new BigDecimal(currentValuesOperationResponses.getOthersAgreed());
					} else {
						dataEntityOtros.set(InfoPayment.AGREEDPAYMENT, new BigDecimal(0));
						othersAgreed = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getOthersPaid() != null) {
						dataEntityOtros.set(InfoPayment.PAYMENTPAID, new BigDecimal(currentValuesOperationResponses.getOthersPaid()));
						othersPaid = new BigDecimal(currentValuesOperationResponses.getOthersPaid());
					} else {
						dataEntityOtros.set(InfoPayment.PAYMENTPAID, new BigDecimal(0));
						othersPaid = new BigDecimal(0);
					}
					if (currentValuesOperationResponses.getOthersBalance() != null) {
						dataEntityOtros.set(InfoPayment.BALANCE, new BigDecimal(currentValuesOperationResponses.getOthersBalance()));
						othersBalance = new BigDecimal(currentValuesOperationResponses.getOthersBalance());
					} else {
						dataEntityOtros.set(InfoPayment.BALANCE, new BigDecimal(0));
						othersBalance = new BigDecimal(0);
					}

					infoPaymentList.add(dataEntityOtros);

					dataEntityTotal.set(InfoPayment.TITLECOLUMN, Mnemonic.PG_TOTAL);// TOTAL
					dataEntityTotal.set(InfoPayment.AGREEDPAYMENT, capitalAgreed.add(interestAgreed).add(moraAgreed).add(othersAgreed));
					dataEntityTotal.set(InfoPayment.PAYMENTPAID, capitailPaid.add(interestPaid).add(moraPaid).add(othersPaid));
					dataEntityTotal.set(InfoPayment.BALANCE, capitalBalance.add(interestBalance).add(moraBalance).add(othersBalance));

					infoPaymentList.add(dataEntityTotal);

					entities.setEntityList(InfoPayment.ENTITY_NAME, infoPaymentList);

					DataEntityList negotiablePaymentList = new DataEntityList();
					BigDecimal totalNegotiablePayment = new BigDecimal(0);
					String flag = "N";
					for (NegotiatedPaymentResponse negotiatedPaymentResponse : negotiatedPaymentResponses) {
						DataEntity dataEntity = new DataEntity();
						dataEntity.set(NegotiablePayments.APPLICATIONDATE, negotiatedPaymentResponse.getApplicationDate());
						dataEntity.set(NegotiablePayments.AMOUNT, new BigDecimal(negotiatedPaymentResponse.getAmount()));
						totalNegotiablePayment = totalNegotiablePayment.add(new BigDecimal(negotiatedPaymentResponse.getAmount()));
						negotiablePaymentList.add(dataEntity);

						if (flag.equals("N")) {
							flag = "S";
						}
					}

					if (flag.equals("S")) {
						DataEntity dataEntity = new DataEntity();
						dataEntity.set(NegotiablePayments.APPLICATIONDATE, "");
						dataEntity.set(NegotiablePayments.AMOUNT, totalNegotiablePayment);
						negotiablePaymentList.add(dataEntity);
					}
					entities.setEntityList(NegotiablePayments.ENTITY_NAME, negotiablePaymentList);

					// DATOS ADICIONALES DE LA OPERACION
					DataEntity arrearsInfo = entities.getEntity(ArrearsInfo.ENTITY_NAME);
					if (arrearsInfo != null) {
						arrearsInfo.set(ArrearsInfo.NUMBEROFCREDITSEARNED, readArrearsDataResponse.getOperationsNumbers());
						arrearsInfo.set(ArrearsInfo.OVERDUEDAYS, readArrearsDataResponse.getDaysOverdue());
						arrearsInfo.set(ArrearsInfo.CAPITALOVERDUEQUOTES, BigDecimal.valueOf(readArrearsDataResponse.getCapitalOverdue()));
					}
				}
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}

	public BigDecimal calculateAmountInAnyCurrency(int currencyDestination, DataEntityList operations, ICommonEventArgs arg1) {
		// 1.- VARIABLES
		int localMoney = 0;
		BigDecimal amountRequested = new BigDecimal(0);

		if (operations != null && operations.size() > 0) {
			// 2.- BUSCA MONEDA LOCAL
			CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
			if (parameterDTO == null) {
				return null;
			}
			localMoney = Integer.parseInt(parameterDTO.getParameterValue());
			// 3.- CALCULA MONTO-SOLICITADO EN MONEDA DESTINO
			for (DataEntity refOperation : operations) {
				if (localMoney == currencyDestination) {
					// SI MONEDA LOCAL Y DE DESTINO ES LA MISMA, SOLO SUMO LOS SALDOS EN MODEDA LOCAL
					amountRequested = refOperation.get(RefinancingOperations.LOCALCURRENCYBALANCE).add(amountRequested);
				} else {
					if (currencyDestination == refOperation.get(RefinancingOperations.CURRENCYOPERATION)) {
						// SI MONEDA DESTINO Y DE OPERACION ES LA MISMA TOMO EL SALDO
						amountRequested = refOperation.get(RefinancingOperations.BALANCE).add(amountRequested);
					} else {
						// SI MONEDA DESTINO Y DE OPERACION ES DISTINTA BUSCO COTIZACION
						TransactionManagement tranManager = new TransactionManagement(getServiceIntegration());
						Double amountInCurrencyDestination = tranManager.getQuote(refOperation.get(RefinancingOperations.CURRENCYOPERATION), currencyDestination,
								refOperation.get(RefinancingOperations.BALANCE).doubleValue(), arg1, new BehaviorOption(true));
						amountRequested = amountRequested.add(new BigDecimal(amountInCurrencyDestination));
					}
				}
			}
		} else {
			MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_ANRSRAPRA_09435", MessageLevel.ERROR, true));
			return null;
		}
		return amountRequested;
	}

	public BigDecimal calculateAmountInAnyCurrency(int currencyDestination, int requetId, ICommonEventArgs arg1) {
		TransactionManagement tranManager = new TransactionManagement(getServiceIntegration());
		RenewLoanRequest dtoBalanceRequest = new RenewLoanRequest();
		dtoBalanceRequest.setRequestId(String.valueOf(requetId));
		dtoBalanceRequest.setCustomerId(-1);
		RenewLoanResponse[] balanceResponseList = tranManager.getBalancebyOperation(dtoBalanceRequest, arg1, new BehaviorOption(true));

		// 1.- VARIABLES
		int localMoney = 0;
		BigDecimal amountRequested = new BigDecimal(0);

		if (balanceResponseList != null && balanceResponseList.length > 0) {
			// 2.- BUSCA MONEDA LOCAL
			CatalogManagement catalogMngmnt = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
			if (parameterDTO == null) {
				return null;
			}
			localMoney = Integer.parseInt(parameterDTO.getParameterValue());
			// 3.- CALCULA MONTO-SOLICITADO EN MONEDA DESTINO
			for (RenewLoanResponse item : balanceResponseList) {
				if (localMoney == currencyDestination) {
					// SI MONEDA LOCAL Y DE DESTINO ES LA MISMA, SOLO SUMO LOS SALDOS EN MODEDA LOCAL
					Double cotization = null;
					QuoteRequest quoteRequest = new QuoteRequest();
					quoteRequest.setCurrencyOrigin(Integer.parseInt(item.getOperationMoney()));
					quoteRequest.setCurrencyDestination(localMoney);
					quoteRequest.setOffice(1);
					quoteRequest.setModule(Mnemonic.MODULE);

					if (Integer.parseInt(item.getOperationMoney()) == localMoney)
						cotization = tranManager.getQuote(quoteRequest, arg1, new BehaviorOption(true));
					else
						cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));

					amountRequested = new BigDecimal(item.getBalance()).multiply(new BigDecimal(cotization)).add(amountRequested);
				} else {
					if (currencyDestination == Integer.parseInt(item.getOperationMoney())) {
						// SI MONEDA DESTINO Y DE OPERACION ES LA MISMA TOMO EL SALDO
						amountRequested = new BigDecimal(item.getBalance()).add(amountRequested);
					} else {
						// SI MONEDA DESTINO Y DE OPERACION ES DISTINTA BUSCO COTIZACION
						Double amountInCurrencyDestination = tranManager.getQuote(Integer.parseInt(item.getOperationMoney()), currencyDestination, new BigDecimal(item.getBalance()).doubleValue(),
								arg1, new BehaviorOption(true));
						amountRequested = amountRequested.add(new BigDecimal(amountInCurrencyDestination));
					}
				}
			}
		} else {
			MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_ANRSRAPRA_09435", MessageLevel.ERROR, true));
			return null;
		}
		return amountRequested;
	}
}
