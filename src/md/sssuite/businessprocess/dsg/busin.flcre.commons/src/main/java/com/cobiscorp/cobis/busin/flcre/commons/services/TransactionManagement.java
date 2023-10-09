package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationNewRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineAditionalData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineOpCurrencyData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.OperationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.OperationTypeData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RejectRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.FinanEvalRequest;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.FinanEvalResponse;
import cobiscorp.ecobis.loan.dto.LoanOptionRequest;
import cobiscorp.ecobis.loan.dto.LoanRequest;
import cobiscorp.ecobis.loan.dto.LoanResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanGeneralDataAdditionalResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanGeneralDataRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsDetailResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;
import cobiscorp.ecobis.moneymarket.dto.ExchangeRateRequest;
import cobiscorp.ecobis.workflow.dto.InstanceProcess;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ProductType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.DistributionLine;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.QueryCentral;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class TransactionManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(TransactionManagement.class);
	private int applicationCode = 0;
	private int operationCode = 0;

	public int getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(int operationCode) {
		this.operationCode = operationCode;
	}

	public int getApplicationCode() {
		return this.applicationCode;
	}

	public void setApplicationCode(int applicationCode) {
		this.applicationCode = applicationCode;
	}

	public TransactionManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean RejectApplication (RejectRequest rejectRequest, ICommonEventArgs args, BehaviorOption options){
		this.setApplicationCode(0);
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INREJECTTRANSACTREQUEST, rejectRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREJECTTRANSACT, serviceRequestTO);
		
		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("RejectApplication isSuccess");
				}
				return true;
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("RejectApplication NOTSuccess");	
				}				
				throw new BusinessException(703037, raiseException(serviceResponse));
			}

		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("RejectApplication ServiceResponse NULL");
			}
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}
	
	
	public ProcessedNumber getProcessedNumber(int applicationNumber, ICommonEventArgs arg1, BehaviorOption options) {
		ProcessedNumber processedNumber = new ProcessedNumber();
		processedNumber.setIdInstProc(applicationNumber);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INPROCESSEDNUMBER, processedNumber);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETPROCESSEDNUMBER, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ProcessedNumber recuperados para - " + applicationNumber);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceItemsResponseTO.isSuccess()) {
				return (ProcessedNumber) serviceItemsResponseTO.getValue(ReturnName.RETURNPROCESSEDNUMBER);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public ApplicationResponse getApplication(int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(idRequested);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADAPPLICATION, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ApplicationResponse recuperados para - " + idRequested);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				return (ApplicationResponse) serviceResponseApplicationTO.getValue(ReturnName.RETURNAPPLICATIONRESPONSE);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public ReadLoanItemsResponse[] getItems(ReadLoanItemsRequest bankNumber, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.addValue(RequestName.INITEMSREQUEST, bankNumber);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHITEMS, serviceRequestItemsTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ItemsResponse recuperados para - " + bankNumber.getOperationNumber());
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseItemsTO.isSuccess()) {
				return (ReadLoanItemsResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNITEMSREPONSE);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public ReadLoanItemsDetailResponse getItemsDetail(ReadLoanItemsRequest dtoItemDetailRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		logger.logDebug("getItemsDetail aqui 1");
		serviceRequestItemsTO.addValue(RequestName.INITEMSREQUEST, dtoItemDetailRequest);
		logger.logDebug("getItemsDetail aqui 2" + serviceRequestItemsTO.getData().toString());
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETITEMS, serviceRequestItemsTO);
		logger.logDebug("getItemsDetail aqui 3");
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("getItemsDetail recuperados para - " + dtoItemDetailRequest.getOperationNumber());
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug("getItemsDetail recuperados para - antes return ");

			if (serviceResponseItemsTO.isSuccess()) {
				return (ReadLoanItemsDetailResponse) serviceResponseItemsTO.getValue(ReturnName.RETURNITEMSDETAILRESPONSE);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public LoanResponse getLoanTmp(String loanCode, ICommonEventArgs arg1, BehaviorOption options) {
		LoanRequest dto = new LoanRequest();
		dto.setDateFormat(SessionContext.getFormatDate());// @i_formato_fecha
		dto.setCode(loanCode);// @i_codigo

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INLOANREQUEST, dto);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADLOANGENERALDATA, serviceRequestApplicationTO);
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("LoanResponse recuperados para - " + loanCode);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug("ReturnName.RETURNLOANRESPONSE: " + serviceResponseApplicationTO.getValue(ReturnName.RETURNLOANRESPONSE));

			if (serviceResponseApplicationTO.isSuccess()) {
				return (LoanResponse) serviceResponseApplicationTO.getValue(ReturnName.RETURNLOANRESPONSE);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean CreateLoanTmp(cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest loanRequestDTO, IExecuteCommandEventArgs args) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.CRERATELOAN, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Tramite creado para IDREQUESTED: " + loanRequestDTO.getCode());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error crear tramite para IDREQUESTED: " + loanRequestDTO.getCode());
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean UpdateLoanTmp(cobiscorp.ecobis.loan.dto.LoanRequest loanRequestDTO, IExecuteCommandEventArgs args) throws BusinessException {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
	
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATELOAN, serviceRequestTO);
		//ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATENEWLOAN, serviceRequestTO);
	
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Tramite modificado para -IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error modificado tramite para IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			throw new BusinessException(703037, raiseExceptionWithoutPrints(serviceResponse));

		}
	}

	public Map<String, Object> UpdateLoanTmpAndGetRates(cobiscorp.ecobis.loan.dto.LoanRequest loanRequestDTO, IExecuteCommandEventArgs args)
			throws BusinessException {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATELOAN, serviceRequestTO);
		
		//ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATENEWLOAN, serviceRequestTO);
		Map<String, Object> applicationResponse = null;

		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Tramite modificado para -IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				applicationResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			} else {
				throw new BusinessException(703037, raiseExceptionWithoutPrints(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error modificado tramite para IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			throw new BusinessException(703037, raiseExceptionWithoutPrints(serviceResponse));

		}
		return applicationResponse;
	}

	public String saveApplication(ApplicationRequest applicationRequest, DebtorRequest debtorRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);
		serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		String codeAplication = "0";
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVELOANAPPLICATION, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				codeAplication = applicationResponse.get("@o_tramite").toString();
				return codeAplication;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));

		}
	}
	public String createApplicationTramite(ApplicationRequest applicationRequest, DebtorRequest debtorRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);
		serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		String codeAplication = "0";
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICETRAIMTECREATELOANAPPLICATION, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				codeAplication = applicationResponse.get("@o_tramite").toString();
				return codeAplication;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));

		}
	}
	public void saveApplicationTramite(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICETRAIMTESAVELOANAPPLICATION, serviceRequestApplicationTO);

		if (serviceResponse == null && !serviceResponse.isResult()) {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}
	public boolean saveApplication(DebtorRequest debtorRequest,ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.setApplicationCode(0);
		logger.logDebug("Entra a metodo saveApplication1");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);
		serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVELOANAPPLICATION, serviceRequestApplicationTO);
		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("Entra a metodo saveApplication2");
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				logger.logDebug("Entra a metodo saveApplication3");
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug("applicationResponse: "+ applicationResponse.values());
				this.setApplicationCode(Integer.parseInt(applicationResponse.get("@o_tramite").toString()));
				//this.setApplicationCode(1309379);//Seteo de prueba del codigo de tramite
				return true;
			} else {
				logger.logDebug("Entra a metodo saveApplication4");
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			logger.logDebug("Entra a metodo saveApplication5");
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}
	
	
	public boolean saveApplication(ApplicationNewRequest applicationNewRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.setApplicationCode(0);
		this.setOperationCode(0);
		logger.logDebug("Entra a metodo saveApplication1");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		logger.logDebug("saveApplicationType: "+applicationNewRequest.getType());
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONNEWREQUEST, applicationNewRequest);
		//serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		ServiceResponse serviceResponse = null;
		if(applicationNewRequest.getOpertationType().equals(ProductType.PRESTAMO_INDIVIDUAL)){
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVELOANAPPLICATIONIND, serviceRequestApplicationTO); 
		} else {
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVELOANAPPLICATION, serviceRequestApplicationTO);
		}
		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("Entra a metodo saveApplication2");
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				logger.logDebug("Entra a metodo saveApplication3");
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug("applicationResponse: "+ applicationResponse.values());
				this.setApplicationCode(Integer.parseInt(applicationResponse.get("@o_tramite").toString()));
				this.setOperationCode(Integer.parseInt(applicationResponse.get("@o_operacion").toString()));
				logger.logDebug("numero operacion query:"+applicationResponse.get("@o_operacion").toString());
				//this.setApplicationCode(1309379);//Seteo de prueba del codigo de tramite
				return true;
			} else {
				logger.logDebug("Entra a metodo saveApplication4");
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			logger.logDebug("Entra a metodo saveApplication5");
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean updateApplication(ApplicationNewRequest applicationNewRequest, ICommonEventArgs arg1, BehaviorOption options)
			throws BusinessException {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONNEWREQUEST, applicationNewRequest);
		//serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATELOANAPPLICATION,
				serviceRequestApplicationTO);

		logger.logDebug("updateApplication serviceResponse" + serviceResponse);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("updateApplication result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("updateApplication serviceResponseTo success");
				return true;
			} else {
				logger.logDebug("updateApplication serviceResponseTo doesn't success");
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			if(serviceResponse != null){
				logger.logDebug("updateApplication result" + serviceResponse.isResult());
			}
			throw new BusinessException(703037, raiseException(serviceResponse));

		}
	}
	public boolean updateApplicationWithoutPrints(ApplicationNewRequest applicationNewRequest, ICommonEventArgs arg1, BehaviorOption options)
			throws BusinessException {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONNEWREQUEST, applicationNewRequest);
		//serviceRequestApplicationTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		ServiceResponse serviceResponse = null;
		if(applicationNewRequest.getOpertationType().equals(ProductType.PRESTAMO_INDIVIDUAL)){
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATELOANAPPLICATIONIND, serviceRequestApplicationTO); 
		} else {
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATELOANAPPLICATION, serviceRequestApplicationTO); 
		}

		logger.logDebug("updateApplication serviceResponse" + serviceResponse);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("updateApplication result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("updateApplication serviceResponseTo success");
				return true;
			} else {
				logger.logDebug("updateApplication serviceResponseTo doesn't success");
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			if(serviceResponse != null){
				logger.logDebug("updateApplication result" + serviceResponse.isResult());
			}
			throw new BusinessException(703037, raiseExceptionWithoutPrints(serviceResponse));

		}
	}

	public boolean updateAditionalInformation(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATEADITIONALINFORMATION, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean updateApplicationCentral(Integer idrequested, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		DataEntity queryCentral = entities.getEntity(QueryCentral.ENTITY_NAME);
		if (queryCentral != null) {
			if (queryCentral.get(QueryCentral.LEVELINDEBTEDNESS) == null) {
				queryCentral.set(QueryCentral.LEVELINDEBTEDNESS, Mnemonic.CHAR_N);
			}
			if (!Validate.Strings.isNotNullOrEmptyOrWhiteSpace(queryCentral.get(QueryCentral.LEVELINDEBTEDNESS).toString())) {
				queryCentral.set(QueryCentral.LEVELINDEBTEDNESS, Mnemonic.CHAR_N);
			}

			ApplicationRequest applicationRequest = new ApplicationRequest();
			applicationRequest.setIdrequested(idrequested);
			// ACTUALIZA FECHA CIC
			applicationRequest.setAssignDateCIC(Mnemonic.CHAR_S);

			// ACTUALIZA NIVEL DE ENDEUDAMIENTO
			applicationRequest.setLevelIndebtedness(queryCentral.get(QueryCentral.LEVELINDEBTEDNESS));
			return this.updateApplicationCentral(applicationRequest, arg1, options);
		}
		return true;
	}

	public boolean updateApplicationCentral(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATECREDITDATACENTRAL,
				serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public boolean updateInstanceProcess(InstanceProcess instanceProcess, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = null;

		serviceRequestTO.addValue(RequestName.INPROCESSINSTDTO, instanceProcess);
		serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEINSTANCEPROCESS, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public CustomerResponse readDataCustomer(CustomerRequest customerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestCustomerTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = null;
		ServiceResponseTO serviceCustomerResponseTO = new ServiceResponseTO();

		serviceRequestCustomerTO.addValue(RequestName.INCUSTOMEREQUEST, customerRequest);
		serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADATACUSTOMER, serviceRequestCustomerTO);

		if (serviceResponse != null && serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return (CustomerResponse) serviceResponseTo.getValue(ReturnName.RETURNCUSTOMERDATA);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public CustomerResponse readCustomer(CustomerRequest customerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestCustomerTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = null;
		ServiceResponseTO serviceCustomerResponseTO = new ServiceResponseTO();

		serviceRequestCustomerTO.addValue(RequestName.INCUSTOMEREQUEST, customerRequest);
		serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCUSTOMER, serviceRequestCustomerTO);

		if (serviceResponse != null && serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return (CustomerResponse) serviceResponseTo.getValue(ReturnName.RETURNCUSTOMERDATA);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public boolean copyFinalTablesToTmpTables(String bank, ICommonEventArgs args, BehaviorOption options) {
		LoanOptionRequest loanRequestDTO = new LoanOptionRequest();
		loanRequestDTO.setBank(bank);
		loanRequestDTO.setOperation(Mnemonic.CHAR_S);
		loanRequestDTO.setDividend(Mnemonic.CHAR_S);
		loanRequestDTO.setAmortization(Mnemonic.CHAR_S);
		loanRequestDTO.setAdditionalFee(Mnemonic.CHAR_S);
		loanRequestDTO.setCategory(Mnemonic.CHAR_S);
		loanRequestDTO.setRelationship(Mnemonic.CHAR_S);
		loanRequestDTO.setAutomaticPayment(Mnemonic.CHAR_S);
		loanRequestDTO.setIncreasingCapital(Mnemonic.CHAR_S);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANOPTIONREQUEST, loanRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATETMPTABLES, serviceRequestTO);
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Operacion copiada HACIA tablas temporales, para BANCO: " + bank);
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public boolean copyTmpTablesToFinalTables(String bank, IExecuteCommandEventArgs args, BehaviorOption options) {
		LoanRequest loanRequestDTO = new LoanRequest();
		loanRequestDTO.setBank(bank);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.COMMITLOANCHANGES, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Operacion copiada de tablas temporales a definitivas, para BANCO: " + bank);
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean deleteTmpTables(String bank, ICommonEventArgs args, BehaviorOption options) {
		LoanRequest loanRequestDTO = new LoanRequest();
		loanRequestDTO.setRoyalBank(bank);
		return deleteTmpTables(loanRequestDTO, args, options);
	}

	public boolean deleteTmpTablesByCode(int operationCode, ICommonEventArgs args, BehaviorOption options) {
		LoanRequest loanRequestDTO = new LoanRequest();
		loanRequestDTO.setOperationCode(operationCode);
		return deleteTmpTables(loanRequestDTO, args, options);
	}

	public boolean deleteTmpTables(LoanRequest loanRequestDTO, ICommonEventArgs args, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.DELETETMPTABLES, serviceRequestTO);

		if (serviceResponse != null & serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public LineCreditData getCreditLine(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYCREDITLINE, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTo.isSuccess()) {
				return (LineCreditData) serviceResponseTo.getValue(ReturnName.RETURNCREDITLINEDATA);
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));

			}

		} else {
			throw new BusinessException(703037, raiseException(serviceResponse));
		}

	}

	public LineCreditData getCreditLine(int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(idRequested);
		return this.getCreditLine(applicationRequest, arg1, options);
	}

	public LineOpCurrencyData[] getDistributionLine(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYDISTRIBUTIONLINE,
				serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ApplicationResponse recuperados para - " + applicationRequest.toString());
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (LineOpCurrencyData[]) serviceResponseApplicationTO.getValue(ReturnName.RETURNDISTRIBUTIONLINEDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public DataEntityList getDistributionLineEntityList(int idRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(idRequest);

		LineOpCurrencyData[] distributionLineDTO = this.getDistributionLine(applicationRequest, arg1, options);
		return this.mappingDistributionLine(distributionLineDTO);
	}

	public DataEntityList getDistributionLineEntityList(int idRequest, int codeLine, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(idRequest);
		applicationRequest.setCreditLine(codeLine);

		LineOpCurrencyData[] distributionLineDTO = this.getDistributionLine(applicationRequest, arg1, options);
		return this.mappingDistributionLine(distributionLineDTO);
	}

	public DataEntityList getDistributionLineEntityList(ApplicationRequest applicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		LineOpCurrencyData[] distributionLineDTO = this.getDistributionLine(applicationRequest, arg1, options);
		return this.mappingDistributionLine(distributionLineDTO);
	}

	private DataEntityList mappingDistributionLine(LineOpCurrencyData[] distributionLineDTO) {
		if (distributionLineDTO != null) {
			DataEntityList distributionLineEntity = new DataEntityList();
			for (LineOpCurrencyData dist : distributionLineDTO) {
				DataEntity eDistLine = new DataEntity();
				eDistLine.set(DistributionLine.CREDITTYPE, dist.getOperationType());
				eDistLine.set(DistributionLine.CURRENCY, dist.getCurrency());
				if (dist.getApprovedAmount() != null)
					eDistLine.set(DistributionLine.AMOUNTPROPOSED, dist.getApprovedAmount().doubleValue());
				eDistLine.set(DistributionLine.QUOTE, dist.getQuote());
				eDistLine.set(DistributionLine.MODULE, dist.getCobisProductMnemonic());
				if (dist.getLocalAmount() != null)
					eDistLine.set(DistributionLine.AMOUNTLOCALCURRENCY, dist.getLocalAmount().doubleValue());
				// falta el monto por moneda local
				distributionLineEntity.add(eDistLine);
			}
			return distributionLineEntity;
		}
		return null;
	}

	public boolean saveDistributionLine(LineOpCurrencyData lineData, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INDISTRIBUTIONLINE, lineData);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVEDISTRIBUTIONLINE, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			return true;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	public boolean saveAditionalLine(LineAditionalData lineData, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INADITIONALLINE, lineData);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESAVEADITIONALLINE, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {

			return true;
		} else {
			return false;
		}
	}

	public boolean updateAditionalLine(LineAditionalData lineData, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INADITIONALLINE, lineData);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEADITIONALLINE, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {

			return true;
		} else {
			return false;
		}
	}

	public LineAditionalData getAditionalLine(int idRequested, int process, ICommonEventArgs arg1, BehaviorOption options) {
		LineAditionalData aditionalData = new LineAditionalData();
		aditionalData.setProcess(process);
		aditionalData.setCreditCode(idRequested);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INADITIONALLINE, aditionalData);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYADITIONALLINE, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ApplicationResponse recuperados para - " + idRequested);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (LineAditionalData) serviceResponseApplicationTO.getValue(ReturnName.RETURNADITIONALLINEDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
	}

	public OperationTypeData[] getOperationType(ICommonEventArgs arg1, BehaviorOption options) {
		OperationResponse operationResponseList = new OperationResponse();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(ReturnName.OUTOPERATIONRESPONSELIST, operationResponseList);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETOPERATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (OperationTypeData[]) serviceResponseApplicationTO.getValue(ReturnName.RETURNGETOPERATION);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public Double getMoneyExchange(ExchangeRateRequest exchangeRateRequest, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INEXCHANGERATEREQUEST, exchangeRateRequest);
		Double result;
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEMONEYEXCHANGE, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceTOResponse = new ServiceResponseTO();
			serviceTOResponse = (ServiceResponseTO) serviceResponse.getData();

			if (serviceTOResponse.isSuccess()) {
				@SuppressWarnings("rawtypes")
				Map<String, Object> processesResponse = (Map) serviceTOResponse.getValue("com.cobiscorp.cobis.cts.service.response.output");
				result = Double.parseDouble(processesResponse.get("@o_cotizacion").toString());
				return result;
			} else
				return null;
		} else
			return null;
	}

	public String getProduct(DataTypeOperationRequest dataType, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INDATATYPEOPERATION, dataType);
		String product;
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETPRODUCT, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceTOResponse = new ServiceResponseTO();
			serviceTOResponse = (ServiceResponseTO) serviceResponse.getData();
			OperationTypeData operationResponse = (OperationTypeData) serviceTOResponse.getValue(ReturnName.RETURNGETOPERATION);

			product = operationResponse.getProductCode();
			return product;
		} else
			return null;
	}

	public boolean updateDistributionLine(LineOpCurrencyData lineData, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INDISTRIBUTIONLINE, lineData);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEDISTRIBUTION, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {

			return true;
		} else {
			return false;
		}
	}

	public boolean deleteDistributionLine(LineOpCurrencyData lineData, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INDISTRIBUTIONLINE, lineData);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEDELETEDISTRIBUTION, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			return true;
		} else {
			return false;
		}
	}

	public ReadLoanGeneralDataAdditionalResponse searchLoanGeneralData(String bank, ICommonEventArgs arg1, BehaviorOption options) {
		ReadLoanGeneralDataRequest gralDataRequest = new ReadLoanGeneralDataRequest();
		gralDataRequest.setBank(bank);
		gralDataRequest.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INLOANGENERALDATA, gralDataRequest);

		// ServiceResponse serviceResponse = execute(getServiceIntegration(),
		// logger, ServiceId.SEARCHLOANGENERALDATABUSIN,
		// serviceRequestApplicationTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHLOANGENERALDATA, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("SearchLoanGeneralData recuperados Banco: " + bank);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadLoanGeneralDataAdditionalResponse) serviceResponseApplicationTO.getValue(ReturnName.RETURNLOANGENERALDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public FinanEvalResponse[] searchFinanEval(FinanEvalRequest request, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INFINANEVALREQUEST, request);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHFINANEVAL, serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("********FINANEVALREQUEST**************" + request.getAnalisisType());
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			return (FinanEvalResponse[]) serviceResponseApplicationTO.getValue(ReturnName.RETURNFINANEVAL);
		}
		return null;
	}

	public Double getQuote(QuoteRequest quoteRequest, ICommonEventArgs arg1, BehaviorOption options, String ouputName) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INQUOTEREQUEST, quoteRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETQUOTEBUSIN, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceTOResponse = new ServiceResponseTO();
			serviceTOResponse = (ServiceResponseTO) serviceResponse.getData();
			if (serviceTOResponse.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> processesResponse = (Map<String, Object>) serviceTOResponse
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				return Double.parseDouble(processesResponse.get(ouputName).toString());
			} else {
				MessageManagement.show(serviceTOResponse, arg1, options);
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public Double getQuote(QuoteRequest quoteRequest, ICommonEventArgs arg1, BehaviorOption options) {
		return this.getQuote(quoteRequest, arg1, options, "@o_cotizacion");
	}

	public Double getQuoteUSD(QuoteRequest quoteRequest, ICommonEventArgs arg1, BehaviorOption options) {
		return this.getQuote(quoteRequest, arg1, options, "@o_cot_usd");
	}

	public Double getQuote(int currencyOrigin, int currencyDestination, Double value, ICommonEventArgs arg1, BehaviorOption options) {
		QuoteRequest quoteRequest = new QuoteRequest();
		quoteRequest.setCurrencyOrigin(currencyOrigin);
		quoteRequest.setCurrencyDestination(currencyDestination);
		quoteRequest.setOffice(1);
		quoteRequest.setModule(Mnemonic.MODULE);
		quoteRequest.setValue(value);
		return this.getQuote(quoteRequest, arg1, options, "@o_valor_convertido");
	}

	public ApplicationResponse readAditionalInformation(int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(idRequested);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.READADITIONALINFORMATION, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("SID:'" + ServiceId.READADITIONALINFORMATION + "' - RequestedID:" + idRequested);
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			// return (ApplicationResponse)
			// serviceResponseApplicationTO.getValue(ReturnName.RETURNAPPLICATIONRESPONSE);

			@SuppressWarnings("unchecked")
			Map<String, Object> processesResponse = (Map<String, Object>) serviceResponseApplicationTO
					.getValue("com.cobiscorp.cobis.cts.service.response.output");
			ApplicationResponse applicationResponseDTO = new ApplicationResponse();
			if (processesResponse.get("@o_tipo_cartera") != null) {
				applicationResponseDTO.setPortfolioType(processesResponse.get("@o_tipo_cartera").toString());
			}
			if (processesResponse.get("@o_destino_descripcion") != null) {
				applicationResponseDTO.setDestinationDescription(processesResponse.get("@o_destino_descripcion").toString());
			}
			// monthCic--@o_mes_cic
			// yearCic--@o_anio_cic
			// reportingDateCic--@o_fecha_reporte_cic
			// monthInfocred--@o_mes_infocred
			// yearInfocred--@o_anio_infocred
			// reportingDateInfocred--@o_fecha_reporte_infocred
			// patrimony--@o_patrimonio
			// sales--@o_ventas
			// staffBusyNumber--@o_num_personal_ocupado
			if (processesResponse.get("@o_tipo_credito") != null) {
				applicationResponseDTO.setCreditType(processesResponse.get("@o_tipo_credito").toString());
			}
			// activityIndexSize--@o_indice_tamano_actividad
			if (processesResponse.get("@o_objeto") != null) {
				applicationResponseDTO.setObjectCredit(processesResponse.get("@o_objeto").toString());
			}
			// activity--@o_actividad
			// officerDescription--@o_descripcion_oficial
			// annualSales--@o_ventas_anuales
			// productiveAssets--@o_activos_productivos
			// levelIndebtedness--@o_level_indebtedness
			return applicationResponseDTO;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public RenewLoanResponse[] getBalancebyOperation(RenewLoanRequest dtoBalanceRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestBalanceTO = new ServiceRequestTO();
		logger.logDebug("getBalance aqui 1");
		serviceRequestBalanceTO.addValue(RequestName.INRENEWLOANREQUEST, dtoBalanceRequest);
		logger.logDebug("getItemsDetail aqui 2" + serviceRequestBalanceTO.getData().toString());
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWBALANCEBYOPERATION,
				serviceRequestBalanceTO);
		logger.logDebug("getItemsDetail aqui 3");
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("getBalancebyOP recuperados para - " + dtoBalanceRequest.getNumBanc());
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug("getItemsDetail recuperados para - antes return ");
			return (RenewLoanResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}

		return null;
	}

	// Funcion que permite validar la informacion del cliente
	public Integer getValidacionCliente(Integer cliente, ICommonEventArgs arg1, BehaviorOption options) {
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setClient(cliente);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEVALIDATIONINFCUSTOMER,
				serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ApplicationResponse recuperados para - " + cliente);
			// MessageManagement.show(serviceResponse,arg1,options);
			return 0;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean ManualLoanSave(cobiscorp.ecobis.loan.dto.LoanRequest loanRequestDTO, IExecuteCommandEventArgs args) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INLOANREQUEST, loanRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEMANUALAMORTIZACION, serviceRequestTO);
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Tabla de amortización Manual -IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error Tabla de amortización Manual para IDREQUESTED-BANCO: " + loanRequestDTO.getBank());
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean validateOriginalApplication(DynamicRequest entities, IExecuteCommandEventArgs args) throws Exception {

		try {

			logger.logDebug("---->Entra al ChangePaymentFrequency");

			logger.logError("---->Declaracion de TransactionManagement");
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			logger.logDebug("---->Instancia de la entidad hacia los objetos");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList refinancingOperations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);

			@SuppressWarnings("unchecked")
			Map<String, Object> task = (Map<String, Object>) args.getParameters().getCustomParameters().get("Task");
			@SuppressWarnings("unchecked")
			Map<String, Object> url = (Map<String, Object>) task.get("urlParams");

			logger.logDebug("---->Variables APF");
			String namePaymentFrequencyAfp = "";
			String paymentFrequencyAfp = "";
			Integer plazoApf = 0;
			Integer factorApf = 0;

			logger.logDebug("---->Variables de Presentacion");
			String paymentFrequency = originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) == null ? "" : originalHeader.get(OriginalHeader.PAYMENTFREQUENCY);
			Integer plazo = originalHeader.get(OriginalHeader.TERM) == null ? 0 : Integer.valueOf(originalHeader.get(OriginalHeader.TERM));
			Integer factor = 0;

			logger.logDebug("---->Valida variables de entrada");
			if (paymentFrequency.equals("") || plazo == 0) {
				args.getMessageManager().showErrorMsg("El plazo debe ser diferente de cero y la frecuencia es obligatoria");
				return false;
			}

			logger.logDebug("---->Recuerapcion de parametro de plazo en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					originalHeader.get(OriginalHeader.PRODUCTTYPE), Mnemonic.PLAZO)) {
				plazoApf = Integer.parseInt(generalParametersValuesHistory.getValue());

			}

			logger.logDebug("---->Recuerapcion de parametro de tipo cuota en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					originalHeader.get(OriginalHeader.PRODUCTTYPE), Mnemonic.TIPO_CUOTA)) {
				paymentFrequencyAfp = generalParametersValuesHistory.getValue();
			}

			logger.logDebug("---->Recupera del factor de acuerdo a la factor de pago del apf");
			List<CatalogDto> catalogDtoList = queryStoredProcedureManagement.getPaymentFrequency(args, new BehaviorOption(true));
			for (CatalogDto catalogDto : catalogDtoList) {
				if (catalogDto.getCode().trim().equals(paymentFrequencyAfp.trim())) {
					namePaymentFrequencyAfp = catalogDto.getName();
					factorApf = Integer.valueOf(catalogDto.getDescription1().trim());
					break;
				}
			}

			logger.logDebug("---->Recupera del factor de acuerdo a la factor de pago");
			for (CatalogDto catalogDto : catalogDtoList) {
				if (paymentFrequency.equals(catalogDto.getCode().trim())) {
					factor = Integer.valueOf(catalogDto.getDescription1().trim());
					break;
				}
			}

			Integer daysApf = plazoApf * factorApf;
			Integer days = plazo * factor;

			logger.logDebug("factor1: " + factor);
			logger.logDebug("days1: " + days);
			logger.logDebug("daysApf1: " + daysApf);
			logger.logDebug("plazoApf1: " + plazoApf);
			logger.logDebug("factorApf1: " + factorApf);

			// if (days > 0 && days <= daysApf) {
			//	originalHeader.set(OriginalHeader.TERM, plazo);
			//} else {
			//	args.getMessageManager().showErrorMsg(
			//			"El plazo debe estar en el rango configurado el en producto ( Frecuencia: " + namePaymentFrequencyAfp + " Plazo: " + plazoApf
			//					+ " )");
			////	return false;
			//	//TODO: validar en la integracion el plazo
			//}

			if (url.get("TRAMITE") != null && url.get("TRAMITE").equals("RENOVATION")) {

				BigDecimal sumSaldo = BigDecimal.ZERO;
				BigDecimal amountAprobed = originalHeader.get(OriginalHeader.AMOUNTAPROBED) == null ? BigDecimal.ZERO : originalHeader.get(OriginalHeader.AMOUNTAPROBED);
				BigDecimal amountRequested = originalHeader.get(OriginalHeader.AMOUNTREQUESTED) == null ? BigDecimal.ZERO : originalHeader.get(OriginalHeader.AMOUNTREQUESTED);

				for (DataEntity operation : refinancingOperations) {
					sumSaldo = sumSaldo.add(operation.get(RefinancingOperations.BALANCE) == null ? BigDecimal.ZERO : operation.get(RefinancingOperations.BALANCE));
				}

				if (sumSaldo.compareTo(amountAprobed) == 1 || sumSaldo.compareTo(amountRequested) == 1) {
					args.getMessageManager().showErrorMsg("El valor de renovacion debe ser mayor o igual a " + sumSaldo);
					return false;
				}
			}
			return true;

		} catch (Exception e) {
			logger.logError("Error al cargar ChangeTerm", e);
			throw e;
		}

	}

	public String raiseException(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				errors.append("Error ");
				errors.append(message.getCode());
				errors.append(": ");
				errors.append(message.getMessage());
				errors.append("\n");
			}
			return errors.toString();
		}
		return "";
	}
	
	public String raiseExceptionWithoutPrints(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				if(!"0".equals(message.getCode().trim())){
					errors.append("Error ");
					errors.append(message.getCode());
					errors.append(": ");
					errors.append(message.getMessage());
					errors.append("\n");
				}
			}
			return errors.toString();
		}
		return "";
	}

}
