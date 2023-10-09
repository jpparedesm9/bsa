package com.cobiscorp.ecobis.cloud.service.integration;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationNewRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.InformationOfficerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ValidateGroupRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanOptionRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.systemconfiguration.dto.DateRequest;
import cobiscorp.ecobis.systemconfiguration.dto.DateResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.ApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditAmountResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIndRequest;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.MemberRequest;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.util.Constants;

/**
 * Created by ntrujillo on 17/07/2017.
 */
public class ApplicationService extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(ApplicationService.class);

	private final String className = "[ApplicationService] ";

	public ApplicationService(ICTSServiceIntegration integration) {
		super(integration);

	}

	public ServiceResponse createIndApplication(CreditApplicationIndRequest creditApplicationRequest) {
		logger.logInfo(className + " start createApplication Individual ");

		CreditApplicationData creditApplicationData = new CreditApplicationData();
		ServiceResponse creditApplicationResponse = new ServiceResponse();

		ApplicationData applicationData = creditApplicationRequest.getApplicationData();
		CustomerData customerData = creditApplicationRequest.getCustomerData();

		ApplicationNewRequest creditApplicationNewRequest = new ApplicationNewRequest();
		creditApplicationNewRequest.setIdRequested(0);
		creditApplicationNewRequest.setOffice(creditApplicationRequest.getCustomerData().getOffice());
		creditApplicationNewRequest.setOfficer(creditApplicationRequest.getCustomerData().getOfficer());
		creditApplicationNewRequest.setMoney(0);// review no esta
		creditApplicationNewRequest.setDestination(creditApplicationRequest.getApplicationData().getCreditDestination());// review
																															// no
																															// esta
		creditApplicationNewRequest.setName(customerData.getName());
		creditApplicationNewRequest.setStartDate(CalendarUtil.from(this.getProcessDate(101)));
		creditApplicationNewRequest.setOpertationType(applicationData.getApplicationType());
		creditApplicationNewRequest.setBanking("1");// review no esta
		creditApplicationNewRequest.setClient(customerData.getCode());
		// Campos Nuevos **
		creditApplicationNewRequest.setPromotion(applicationData.isPromotion() ? 'S' : 'N');
		creditApplicationNewRequest.setGroupAgreesToRenew(customerData.isAgreeRenew() ? 'S' : 'N');
		if (customerData.isAgreeRenew()) {
			creditApplicationNewRequest.setReasonForNotRenewing(""); // review
		}
		creditApplicationNewRequest.setEntrepreneurship('N'); // review no esta
		creditApplicationNewRequest.setPercentageGuarantee(0.00);// review esta
																	// en la
																	// pantalla
		creditApplicationNewRequest.setComentary("Operation Created From Mobil App");
		creditApplicationNewRequest.setNature("APP_MOVIL");
		// creditApplicationNewRequest.setGroup("S");
		creditApplicationNewRequest.setCity(1);
		creditApplicationNewRequest.setType("O");
		creditApplicationNewRequest.setPeriodCap(1);
		creditApplicationNewRequest.setPeriodInt(1);
		creditApplicationNewRequest.setTDividend(applicationData.getFrecuency());
		logger.logDebug("getTDividend " + creditApplicationNewRequest.getTDividend());
		creditApplicationNewRequest.setTerm(Integer.parseInt(applicationData.getTerm()));
		logger.logDebug("getTerm " + creditApplicationNewRequest.getTerm());
		creditApplicationNewRequest.setTermType(applicationData.getFrecuency());
		logger.logDebug("getTermType " + creditApplicationNewRequest.getTermType());
		creditApplicationNewRequest.setAlliance(customerData.getAvalCode());

		// Recupero campos del Producto y seteo DTO
		/*
		 * List<GeneralParametersValuesHistory> generalParameterCatalog =
		 * bankingProductManager.getCatalogGeneralParameter(args,
		 * originalHeader.get(OriginalHeader.PRODUCTTYPE), "Pago de intereses"); for
		 * (GeneralParametersValuesHistory generalParametersValuesHistory :
		 * generalParameterCatalog) { creditApplicationRequest.setPaymentType(
		 * generalParametersValuesHistory.getValue().charAt(0)); }
		 * 
		 * generalParameterCatalog =
		 * bankingProductManager.getCatalogGeneralParameter(args,
		 * originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría"); for
		 * (GeneralParametersValuesHistory generalParametersValuesHistory :
		 * generalParameterCatalog) {
		 * creditApplicationNewRequest.setSector(generalParametersValuesHistory.
		 * getValue()); creditApplicationNewRequest.setPortafolioClass(
		 * generalParametersValuesHistory.getValue()); }
		 */

		creditApplicationNewRequest.setApprovedAmount(applicationData.getAuthorizedAmount());// review
		creditApplicationNewRequest.setAmount(applicationData.getAmountOriginalRequest());// review

		ServiceResponse createApplicationResponse = createApplication(creditApplicationNewRequest);

		if (createApplicationResponse.isResult()) {

			int applicationCode = ((CreditApplicationData) createApplicationResponse.getData()).getApplicationCode();

			ServiceResponse createDebtorResponse = createDebtor(applicationCode, customerData.getCode(), "D", String.valueOf(customerData.getCode()));

			return createApplicationResponse;

		} else {
			return createApplicationResponse;
		}

	}

	public ServiceResponse createGrpApplication(CreditApplicationRequest creditApplicationRequest, int processInstance) {
		logger.logInfo(className + " start createApplication Grupal ");
		CreditApplicationData creditApplicationData = new CreditApplicationData();

		ServiceResponse creditApplicationResponse = new ServiceResponse();

		ApplicationNewRequest creditApplicationNewRequest = new ApplicationNewRequest();
		creditApplicationNewRequest.setIdRequested(0);
		creditApplicationNewRequest.setOffice(creditApplicationRequest.getOffice());
		creditApplicationNewRequest.setOfficer(creditApplicationRequest.getOfficer());
		creditApplicationNewRequest.setMoney(0);// review no esta
		creditApplicationNewRequest.setDestination("01");// review no esta
		creditApplicationNewRequest.setName(creditApplicationRequest.getGroupName());
		creditApplicationNewRequest.setStartDate(CalendarUtil.from(this.getProcessDate(101)));
		creditApplicationNewRequest.setOpertationType(creditApplicationRequest.getApplicationType());
		creditApplicationNewRequest.setBanking("1");// review no esta
		creditApplicationNewRequest.setClient(creditApplicationRequest.getGroupNumber());
		// SRO. #140073
		creditApplicationNewRequest.setTerm(creditApplicationRequest.getTerm() == null ? null : Integer.valueOf(creditApplicationRequest.getTerm()));
		creditApplicationNewRequest.setDisplacement(creditApplicationRequest.getDisplacement() == null ? null : Integer.valueOf(creditApplicationRequest.getDisplacement()));
		// Campos Nuevos **

		creditApplicationNewRequest.setPromotion(creditApplicationRequest.isPromotion() ? 'S' : 'N');
		creditApplicationNewRequest.setGroupAgreesToRenew(creditApplicationRequest.isGroupAgreeRenew() ? 'S' : 'N');
		if (creditApplicationRequest.isGroupAgreeRenew()) {
			creditApplicationNewRequest.setReasonForNotRenewing(creditApplicationRequest.getReasonNotAccepting());
		}
		creditApplicationNewRequest.setEntrepreneurship('N'); // review no esta
		creditApplicationNewRequest.setPercentageGuarantee(0.00);// review esta
																	// en la
																	// pantalla
		creditApplicationNewRequest.setComentary("Operation Created From Mobil App");
		creditApplicationNewRequest.setNature("APP_MOVIL");
		creditApplicationNewRequest.setGroup("S");
		creditApplicationNewRequest.setCity(1);
		creditApplicationNewRequest.setType(Constants.TYPE_REQUEST_RENOVATION.equals(creditApplicationRequest.getRequestType()) ? "R" : "O");

		// Recupero campos del Producto y seteo DTO
		/*
		 * List<GeneralParametersValuesHistory> generalParameterCatalog =
		 * bankingProductManager.getCatalogGeneralParameter(args,
		 * originalHeader.get(OriginalHeader.PRODUCTTYPE), "Pago de intereses"); for
		 * (GeneralParametersValuesHistory generalParametersValuesHistory :
		 * generalParameterCatalog) { creditApplicationRequest.setPaymentType(
		 * generalParametersValuesHistory.getValue().charAt(0)); }
		 * 
		 * generalParameterCatalog =
		 * bankingProductManager.getCatalogGeneralParameter(args,
		 * originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría"); for
		 * (GeneralParametersValuesHistory generalParametersValuesHistory :
		 * generalParameterCatalog) {
		 * creditApplicationNewRequest.setSector(generalParametersValuesHistory.
		 * getValue()); creditApplicationNewRequest.setPortafolioClass(
		 * generalParametersValuesHistory.getValue()); }
		 */

		logger.logDebug("Settings paramaters on create grupal application");
		creditApplicationNewRequest.setPeriodCap(1);
		creditApplicationNewRequest.setPeriodInt(1);
		logger.logDebug("getPeriodCap " + creditApplicationNewRequest.getPeriodCap());
		logger.logDebug("getPeriodInt " + creditApplicationNewRequest.getPeriodInt());
		creditApplicationNewRequest.setApprovedAmount(0);// review
		creditApplicationNewRequest.setAmount(creditApplicationRequest.getGroupAmount());// review
		creditApplicationNewRequest.setProcessInstance(processInstance);
		ServiceResponse createApplicationResponse = createApplication(creditApplicationNewRequest);

		if (createApplicationResponse.isResult()) {

			int applicationCode = ((CreditApplicationData) createApplicationResponse.getData()).getApplicationCode();

			ServiceResponse createDebtorResponse = createDebtor(applicationCode, creditApplicationRequest.getGroupNumber(), "G",
					String.valueOf(creditApplicationRequest.getGroupNumber()));

			return createApplicationResponse;

		} else {
			return createApplicationResponse;
		}

	}

	public ServiceResponse createApplication(ApplicationNewRequest applicationNewRequest) {
		logger.logDebug("start createApplication");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inApplicationNewRequest", applicationNewRequest);
		CreditApplicationData creditApplicationData = new CreditApplicationData();
		ServiceResponse serviceResponse;

		// achp
		if (applicationNewRequest.getOpertationType().equals(Constants.PRESTAMO_GRUPAL)) {
			serviceResponse = execute("Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication", serviceRequestApplicationTO);

		} else {
			serviceResponse = execute("Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual", serviceRequestApplicationTO);
		}

		ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
		int applicationCode = 0, operationCode = 0, groupCycle = 0;

		String date;
		Date applicationDate = null;
		if (serviceResponseApplicationTO.isSuccess()) {
			Map<String, Object> applicationResponse = (Map) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			applicationCode = Integer.parseInt(applicationResponse.get("@o_tramite").toString());
			logger.logDebug("o_tramite: " + applicationCode);
			operationCode = Integer.parseInt(applicationResponse.get("@o_operacion").toString());
			logger.logDebug("o_operacion: " + operationCode);
			logger.logDebug("o_ciclo: " + applicationResponse.get("@o_ciclo"));
			if (applicationResponse.get("@o_ciclo") != null) {
				logger.logDebug("o_ciclo: " + applicationResponse.get("@o_ciclo").toString());
				groupCycle = Integer.parseInt(applicationResponse.get("@o_ciclo").toString());

			}

			if (applicationResponse.get("@o_fecha_creacion") != null) {
				logger.logDebug("Imprimir @o_fecha_creacion: " + applicationResponse.get("@o_fecha_creacion").toString());
				date = applicationResponse.get("@o_fecha_creacion").toString();
				try {
					SimpleDateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");

					applicationDate = inputFormat.parse(date);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}

			Float interestRate = (applicationResponse.get("@o_tasa_grp") == null ? 0f : Float.valueOf(applicationResponse.get("@o_tasa_grp").toString()));
			creditApplicationData.setInterestRate(interestRate);
			logger.logDebug("Tasa grupal>>" + interestRate);

			if (operationCode > 0) {
				creditApplicationData.setApplicationCode(applicationCode);
				if (groupCycle > 0) {
					creditApplicationData.setGroupCycle(groupCycle);
				}
				if (applicationDate != null) {
					creditApplicationData.setApplicationDate(applicationDate.getTime());
				}
				serviceResponse.setData(creditApplicationData);
				serviceResponse.setMessages(new ArrayList<Message>());
			} else {
				serviceResponse.setResult(false);
				serviceResponse.setData(null);
			}
		}
		return serviceResponse;

	}

	public String createRevolvingApplication(ApplicationRequest applicationRequest, DebtorRequest debtorRequest) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inApplicationRequest", applicationRequest);
		serviceRequestApplicationTO.addValue("inDebtorRequest", debtorRequest);
		String codeAplication = "0";
		ServiceResponse serviceResponse = execute("Businessprocess.Creditmanagement.ApplicationManagment.CreateRevolvingApplication", serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				codeAplication = applicationResponse.get("@o_tramite").toString();
				return codeAplication;
			} else {
				throw new IntegrationException(serviceResponse);
			}
		} else {
			throw new IntegrationException(serviceResponse);
		}
	}

	public ServiceResponse updateRevolvingApplication(ApplicationRequest applicationRequest) {

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inApplicationRequest", applicationRequest);
		return execute("Businessprocess.Creditmanagement.ApplicationManagment.UpdateRevolvingApplication", serviceRequestApplicationTO);

	}

	public ServiceResponse saveDebtorTmp(DebtorRequest debtorRequest) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inDebtorRequest", debtorRequest);
		logger.logDebug("codigo en el metodo save:-debtorRequest.getDebtorCode()" + debtorRequest.getDebtorCode());

		return execute("Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor", serviceRequestTO);
		/*
		 * if (serviceResponse.isResult()) { if (logger.isDebugEnabled())
		 * logger.logDebug("Creado Cliente Codigo:" + debtorRequest.getDebtorCode());
		 * ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO)
		 * serviceResponse.getData();
		 * 
		 * DebtorResponse debtorTempResponse = (DebtorResponse)
		 * serviceItemsResponseTO.getValue("returnDebtorResponse"); return
		 * debtorTempResponse; } else { return null; }
		 */
	}

	public ServiceResponse updateApplication(ApplicationNewRequest applicationNewRequest) {
		logger.logDebug("start updateApplication ");

		deleteTmpTables(applicationNewRequest.getBank());
		copyFinalTablesToTmpTables(applicationNewRequest.getBank());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inApplicationNewRequest", applicationNewRequest);
		return this.execute("Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual", serviceRequestApplicationTO);

	}

	public ApplicationResponse getApplication(int applicationNumber) {
		logger.logDebug("start getApplication " + applicationNumber);
		ApplicationRequest applicationRequest = new ApplicationRequest();
		applicationRequest.setIdrequested(Integer.valueOf(applicationNumber));
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inApplicationRequest", applicationRequest);
		ServiceResponse serviceResponse = this.execute("Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication", serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("ApplicationResponse recuperados para - " + applicationNumber);
			}
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseApplicationTO.isSuccess()) {
				return (ApplicationResponse) serviceResponseApplicationTO.getValue("returnApplicationResponse");
			}
		}

		return new ApplicationResponse();
	}

	/* Traer montos */
	public GroupLoanAmountResponse[] searchAmount(int applicationNumber) {
		logger.logDebug("start searchAmount - getAmount " + applicationNumber);
		GroupLoanAmountResponse[] groupLoanAmountResponse = null;
		GroupLoanAmountRequest groupLoanAmountRequest = new GroupLoanAmountRequest();
		groupLoanAmountRequest.setSolicitude(applicationNumber);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inGroupLoanAmountRequest", groupLoanAmountRequest);
		ServiceResponse serviceResponse = this.execute("LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount", serviceRequestApplicationTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Montos recuperados para el tramite - " + applicationNumber);
			}
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseApplicationTO.isSuccess()) {
				return groupLoanAmountResponse = (GroupLoanAmountResponse[]) serviceResponseApplicationTO.getValue("returnGroupLoanAmountResponse");
			}
		}
		return groupLoanAmountResponse;
	}

	private ServiceResponse createDebtor(int numeroTramite, int code, String role, String identification) {
		logger.logDebug("start createDebtor tramite:" + numeroTramite + " code:" + code + " role:" + role + " identification:" + identification);

		DebtorRequest debtor = new DebtorRequest();
		debtor.setDebtorCode(code);
		debtor.setRole(role);
		debtor.setDebtorIdentification(identification);
		debtor.setApplicationCode(numeroTramite);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inDebtorRequest", debtor);
		return this.execute("Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor", serviceRequestTO);

	}

	public CreditAmountResponse updateAmount(int applicationNumber, int groupNumber, List<MemberRequest> members, double minimumSavings) {
		logger.logInfo("start UpdateAmount applicationNumber:" + applicationNumber + " groupNumber:" + groupNumber);
		GroupLoanAmountRequest amountRequest;
		ServiceResponse serviceResponse = new ServiceResponse();
		CreditAmountResponse creditAmountResponse = new CreditAmountResponse();
		String tasagrp = "0";
		boolean updateAmountsFlag = true;
		for (MemberRequest m : members) {
			logger.logDebug("----->>>ExecuteCommand - Antes de Guardar - Id Integrante: " + m.getCode());
			amountRequest = new GroupLoanAmountRequest();
			amountRequest.setSolicitude(applicationNumber);
			amountRequest.setCustomerId(m.getCode());
			amountRequest.setGroupId(groupNumber);
			amountRequest.setCycleParticipation(m.isParticipant() ? 'S' : 'N');
			// amount.get(Amount.AMOUNT) - solicitado -- se va con el
			// tg_monto_aprobado
			// amount.get(Amount.AUTHORIZEDAMOUNT) - autorizado -- se va con el
			// tg_monto

			amountRequest.setAmount(m.getAmountRequestedOriginal());// Se
																	// duplican
																	// los
																	// montos
			amountRequest.setAuthorizedAmount(m.getAmountRequestedOriginal());
			amountRequest.setProposedMaximumSaving(m.getProposedMaximumAmount());
			if (m.getVoluntarySavings() < minimumSavings) {
				m.setVoluntarySavings(minimumSavings);
			}

			serviceResponse = updateAmount(amountRequest, 2);
			if (!serviceResponse.isResult()) {
				updateAmountsFlag = false;
				break;
			}
		}
		logger.logDebug("----->>updateAmountsFlag " + updateAmountsFlag);

		if (updateAmountsFlag) {

			amountRequest = new GroupLoanAmountRequest();
			amountRequest.setSolicitude(applicationNumber);
			amountRequest.setGroupId(groupNumber);
			amountRequest.setCustomerId(0);

			serviceResponse = updateAmount(amountRequest, 3);

			if (serviceResponse.isResult()) {

				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (outputs != null) {
					String mensaje = outputs.get("@o_msg1");
					tasagrp = outputs.get("@o_tasa_grp");
					if (tasagrp != null) {
						tasagrp = tasagrp.trim();
					}
					logger.logDebug("---->> tasa.." + tasagrp + "-----<<");

					logger.logDebug("----->>mensaje.." + mensaje);

					if (!"--".equals(mensaje)) {
						String[] parts = mensaje.split("-");
						String msgTotal = "";
						for (int i = 0; i < parts.length; i++) {
							if (parts[i].length() > 0) {
								msgTotal += parts[i] + ".";
							}
						}
						logger.logDebug("----->>mensajeTotal" + msgTotal);
						serviceResponse.setData(msgTotal);
					} else {
						serviceResponse.setData(null);
					}
				}

			}
		}
		creditAmountResponse.setServiceResponse(serviceResponse);

		creditAmountResponse.setTasa(tasagrp);

		return creditAmountResponse;
	}

	public ServiceResponse updateAmount(GroupLoanAmountRequest amountRequest, int mode) {
		logger.logDebug("Inicio Servicio updateAmount - modo:" + mode);

		amountRequest.setMode(mode);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inGroupLoanAmountRequest", amountRequest);
		return execute("LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount", serviceRequestApplicationTO);

	}

	private ServiceResponse deleteTmpTables(String bank) {
		if (logger.isDebugEnabled())
			logger.logDebug("Borra de temporales, numeroBbanco --->" + bank);
		cobiscorp.ecobis.loan.dto.LoanRequest loanRequestDTO = new cobiscorp.ecobis.loan.dto.LoanRequest();
		loanRequestDTO.setRoyalBank(bank);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inLoanRequest", loanRequestDTO);
		return this.execute("Loan.LoanMaintenance.DeleteTmpTables", serviceRequestTO);

	}

	private ServiceResponse copyFinalTablesToTmpTables(String bank) {
		if (logger.isDebugEnabled())
			logger.logDebug("Copia de definivas a temporales, numeroBbanco --->" + bank);
		LoanOptionRequest loanRequestDTO = new LoanOptionRequest();
		loanRequestDTO.setBank(bank);
		loanRequestDTO.setOperation('S');
		loanRequestDTO.setDividend('S');
		loanRequestDTO.setAmortization('S');
		loanRequestDTO.setAdditionalFee('S');
		loanRequestDTO.setCategory('S');
		loanRequestDTO.setRelationship('S');
		loanRequestDTO.setAutomaticPayment('S');
		loanRequestDTO.setIncreasingCapital('S');
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inLoanOptionRequest", loanRequestDTO);
		return this.execute("Loan.LoanMaintenance.CreateTmpTables", serviceRequestTO);

	}

	public String getProcessDate(int dateFormat) {
		if (logger.isDebugEnabled())
			logger.logDebug("getProcessDate --->" + dateFormat);
		DateRequest dateRequestDTO = new DateRequest();
		dateRequestDTO.setDateFormat(dateFormat);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inDateRequest", dateRequestDTO);
		ServiceResponse serviceResponse = this.execute("SystemConfiguration.ParameterManagement.ProcessDate", serviceRequestTO);

		if (logger.isDebugEnabled())
			logger.logDebug("getProcessDate --->" + dateFormat);
		ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
		return ((DateResponse) serviceItemsResponseTO.getValue("returnDateResponse")).getProcessDate();

	}

	public ServiceResponse validateGroup(int groupId, String requestType) {
		ValidateGroupRequest validateGroupRequest = new ValidateGroupRequest();
		validateGroupRequest.setGroupId(groupId);
		validateGroupRequest.setRequestType(requestType);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inValidateGroupRequest", validateGroupRequest);
		return this.executeNormal("Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup", serviceRequestTO);
	}

	public int getOfficeOfficer(String loginOfficer) {
		logger.logDebug(className + "Inicio Servicio getOfficeOfficer - Login:" + loginOfficer);
		ServiceResponse serviceResponse;
		InformationOfficerRequest informationOfficer = new InformationOfficerRequest();
		informationOfficer.setUser(loginOfficer);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inInformationOfficerRequest", informationOfficer);
		serviceResponse = execute("Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer", serviceRequestApplicationTO);
		ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
		int codeOffice = 0;
		if (serviceResponseApplicationTO.isSuccess()) {
			Map<String, Object> applicationResponse = (Map) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			logger.logDebug(className + "Servicio getOfficeOffice - CodOffice:" + applicationResponse.get("@o_oficina").toString());
			codeOffice = Integer.parseInt(applicationResponse.get("@o_oficina").toString());
		}
		return codeOffice;

	}

}
