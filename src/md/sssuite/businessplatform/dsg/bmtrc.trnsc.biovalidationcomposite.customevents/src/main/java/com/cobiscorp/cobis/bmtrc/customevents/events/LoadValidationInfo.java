package com.cobiscorp.cobis.bmtrc.customevents.events;

import java.math.BigDecimal;
import java.util.List;

import com.cobiscorp.cobis.bmtrc.customevents.constants.Constants;
import com.cobiscorp.cobis.bmtrc.customevents.manager.AmountManager;
import com.cobiscorp.cobis.bmtrc.customevents.manager.BioCheckManager;
import com.cobiscorp.cobis.bmtrc.customevents.manager.CustomerManager;
import com.cobiscorp.cobis.bmtrc.customevents.manager.GroupManager;
import com.cobiscorp.cobis.bmtrc.customevents.manager.MemberManager;
import com.cobiscorp.cobis.bmtrc.model.AdditionalInformation;
import com.cobiscorp.cobis.bmtrc.model.Credit;
import com.cobiscorp.cobis.bmtrc.model.Customer;
import com.cobiscorp.cobis.bmtrc.model.ValidationData;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerAmountRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerAmountResponse;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class LoadValidationInfo extends BaseEvent implements IInitDataEvent {
	private static final String GROUP_TYPE = "G";
	private static final String REVOLVENT_TYPE = "R";
	private static final String GRUPAL_CREDIT = "GRUPAL";
	private static final String REVOLVENTE_CREDIT = "REVOLVENTE";
	private static final String INDIVIDUAL_CREDIT = "INDIVIDUAL";
	private static final String SHARE_TYPE = "Tipo de cuota";
	private static final ILogger LOGGER = LogFactory.getLogger(LoadValidationInfo.class);

	public LoadValidationInfo(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);
		GroupManager groupManager = new GroupManager(getServiceIntegration());
		TransactionManagement transactionManagement = new TransactionManagement(this.getServiceIntegration());

		DataEntity validationData = entities.getEntity(ValidationData.ENTITY_NAME);

		try {

			if (GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				GroupRequest groupRequest = new GroupRequest();
				groupRequest.setCode(validationData.get(ValidationData.CUSTOMERID));
				GroupResponse groupResponse = groupManager.searchGroup(groupRequest, args);
				if (groupResponse != null) {
					mapGroupData(validationData, groupResponse);
					getCreditData(entities, args);
					MemberRequest memberRequest = new MemberRequest();
					memberRequest.setGroupId(validationData.get(ValidationData.CUSTOMERID));

					// Caso #145927
					// DataEntityList members = setAmounts(entities, args, this.getServiceIntegration());
					// DataEntityList members = getMembers(entities, args);
					// this.getServiceIntegration());
					// setAmounts(entities, members, args);

					// Caso #175319
					//entities.setEntityList(Customer.ENTITY_NAME, members);
					setBioCheckData(entities, args);
					getDataToBiocheck(entities, args);
					// obtencion de parametro del ambiente (requerido para uso del token opaco)
				}
			} else if (REVOLVENTE_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				CustomerRequest customerRequest = new CustomerRequest();
				customerRequest.setCustomerId(validationData.get(ValidationData.CUSTOMERID));
				customerRequest.setModo(0);

				CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, args, new BehaviorOption(true));
				mapCustomerData(validationData, customerResponse);
				getCreditData(entities, args);

				DataEntityList members = setAmountAndBiocheckDataCustomer(entities, args, this.getServiceIntegration());
				entities.setEntityList(Customer.ENTITY_NAME, members);
				setBioCheckData(entities, args);
				getDataToBiocheck(entities, args);

			}else if (INDIVIDUAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				CustomerRequest customerRequest = new CustomerRequest();
				customerRequest.setCustomerId(validationData.get(ValidationData.CUSTOMERID));
				customerRequest.setModo(0);

				CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, args, new BehaviorOption(true));
				mapCustomerData(validationData, customerResponse);
				getCreditData(entities, args);

				DataEntityList members = setAmountAndBiocheckDataCustomer(entities, args, this.getServiceIntegration());
				entities.setEntityList(Customer.ENTITY_NAME, members);
				setBioCheckData(entities, args);
				getDataToBiocheck(entities, args);

			}
			readEnvironment(entities, "ENVBIO", args);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_GROUP, e, args, LOGGER);
		}
	}
	
	// Caso #145927
	private DataEntityList setAmounts(DynamicRequest entities, ICommonEventArgs args, ICTSServiceIntegration serviceIntegration) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicio LoadValidationInfo - setAmounts");
		}
		DataEntityList membersEntity = new DataEntityList();

		GroupLoanAmountRequest amountRequest = new GroupLoanAmountRequest();
		DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);
		DataEntity validationData = entities.getEntity(ValidationData.ENTITY_NAME);
		amountRequest.setSolicitude(creditEntity.get(Credit.CREDITCODE));
		amountRequest.setGroupId(validationData.get(ValidationData.CUSTOMERID));

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("setAmounts - codigo del credito Amount:" + creditEntity.get(Credit.CREDITCODE));
		}

		MemberRequest memberRequest = new MemberRequest();
		memberRequest.setGroupId(validationData.get(ValidationData.CUSTOMERID));
		AmountManager amountManager = new AmountManager(getServiceIntegration());
		GroupLoanAmountResponse responseAmountList[] = amountManager.searchAmount(amountRequest, args);

		// informacion de integrantes
		MemberManager memberManager = new MemberManager(serviceIntegration);
		MemberResponse[] memberResponses = memberManager.searchMember(memberRequest, args);

		int indice = 0;
		if (responseAmountList != null) {
			for (GroupLoanAmountResponse amount : responseAmountList) {
				for (MemberResponse member : memberResponses) {
					if (amount.getCustomerId().equals(member.getCustomerId())) {
						if (amount.getAmount() != null) {
							if (amount.getAmount() > 0) {
								DataEntity eMember = new DataEntity();
								if (amount.getAmount() != null) {
									eMember.set(Customer.AMOUNT, BigDecimal.valueOf(amount.getAmount()));
								} else {
									eMember.set(Customer.AMOUNT, BigDecimal.valueOf(0));
								}
								eMember.set(Customer.IDCUSTOMER, member.getCustomerId());
								eMember.set(Customer.ROLE, member.getRole());
								eMember.set(Customer.CUSTOMER, member.getCustomer());
								indice += 1;
								eMember.set(Customer.SEQUENTIAL, indice);
								membersEntity.add(eMember);
							}
						}
					}
				}
			}
		}
		return membersEntity;
	}

	private DataEntityList setAmountAndBiocheckDataCustomer(DynamicRequest entities, ICommonEventArgs args, ICTSServiceIntegration serviceIntegration) throws Exception {

		DataEntityList membersEntity = new DataEntityList();
		DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);
		DataEntity validationData = entities.getEntity(ValidationData.ENTITY_NAME);

		CustomerAmountRequest customerAmountRequest = new CustomerAmountRequest();
		customerAmountRequest.setApplicationNumber(creditEntity.get(Credit.CREDITCODE));
		customerAmountRequest.setCustomerId(validationData.get(ValidationData.CUSTOMERID));

		CustomerManager customerManager = new CustomerManager(serviceIntegration);
		CustomerAmountResponse customerAmountResponse = customerManager.getLCRCustomerAmount(customerAmountRequest, args);

		if (customerAmountResponse != null) {
			DataEntity eMember = new DataEntity();
			LOGGER.logDebug("customerAmountResponse.getSequential():" + customerAmountResponse.getSequential());
			LOGGER.logDebug("customerAmountResponse.getAmount():" + customerAmountResponse.getAmount());
			LOGGER.logDebug("customerAmountResponse.getClientId():" + customerAmountResponse.getClientId());
			LOGGER.logDebug("customerAmountResponse.getClientName():" + customerAmountResponse.getClientName());

			eMember.set(Customer.SEQUENTIAL, customerAmountResponse.getSequential());
			eMember.set(Customer.AMOUNT, customerAmountResponse.getAmount() == null ? BigDecimal.valueOf(0) : BigDecimal.valueOf(customerAmountResponse.getAmount()));
			eMember.set(Customer.IDCUSTOMER, customerAmountResponse.getClientId());
			eMember.set(Customer.CUSTOMER, customerAmountResponse.getClientName());
			eMember.set(Customer.ROLE, "");
			eMember.set(Customer.WITHOUTFINGERPRINT,
					customerAmountResponse.getWithoutFingerprint() == null ? false : "N".equals(customerAmountResponse.getWithoutFingerprint()) ? false : true);
			eMember.set(Customer.WITHOUTFINGERPRINTVALUE, customerAmountResponse.getWithoutFingerprint());
			eMember.set(Customer.OCR, customerAmountResponse.getOcr());
			eMember.set(Customer.CIC, customerAmountResponse.getCic());
			eMember.set(Customer.CUSTOMERNAME, customerAmountResponse.getName());
			eMember.set(Customer.SURNAME, customerAmountResponse.getSurname());
			eMember.set(Customer.MOTHERSURNAME, customerAmountResponse.getSecondSurname());
			eMember.set(Customer.YEAR, customerAmountResponse.getYear());
			eMember.set(Customer.YEAREMISSION, customerAmountResponse.getEmissionYear());
			eMember.set(Customer.CREDENTIALNUMBER, customerAmountResponse.getCredentialNumber());
			eMember.set(Customer.VOTERKEY, customerAmountResponse.getElectorKey());
			eMember.set(Customer.CURP, customerAmountResponse.getCurp());
			eMember.set(Customer.BIRTHCITY, customerAmountResponse.getCity());
			eMember.set(Customer.BIRTHDAY, customerAmountResponse.getBirthday());
			eMember.set(Customer.BUC, customerAmountResponse.getBuc());
			eMember.set(Customer.VALIDATIONSTATUS, customerAmountResponse.getStatus());
			membersEntity.add(eMember);
		}
		return membersEntity;

	}

	private void setBioCheckData(DynamicRequest entities, IDataEventArgs args) {
		DataEntityList customerList = entities.getEntityList(Customer.ENTITY_NAME);
		for (DataEntity customer : customerList) {
			customer.set(Customer.WITHOUTFINGERPRINTVALUE, null);
			customer.set(Customer.YEAR, null);
			customer.set(Customer.VOTERKEY, null);
			customer.set(Customer.SURNAME, null);
			customer.set(Customer.MOTHERSURNAME, null);
			customer.set(Customer.CUSTOMERNAME, null);
			customer.set(Customer.YEAREMISSION, null);
			customer.set(Customer.CREDENTIALNUMBER, null);
			customer.set(Customer.RIGHTFINGER, null);
			customer.set(Customer.LEFTFINGER, null);
			customer.set(Customer.HASH, null);
			customer.set(Customer.REGISTRYSITUATION, null);
			customer.set(Customer.TYPETHEFTREPORT, null);
			customer.set(Customer.VALIDATIONSTATUS, "PENDIENTE");
		}

	}

	private void getDataToBiocheck(DynamicRequest entities, IDataEventArgs args) {
		try {
			BioCheckManager biocheckManager = new BioCheckManager(this.getServiceIntegration());
			DataEntity data = entities.getEntity(ValidationData.ENTITY_NAME);
			DataEntityList customerList = entities.getEntityList(Customer.ENTITY_NAME);
			DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);

			CustomerBiocheckResponse[] customerBioCheck = null;
			if (GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				customerBioCheck = biocheckManager.getWithoutFingerPrint(data.get(ValidationData.CUSTOMERID), data.get(ValidationData.PROCESSINSTANCE), GROUP_TYPE, args);
				//Caso #175319
				groupDataMapping(customerBioCheck, creditEntity, customerList);
			} else if (REVOLVENTE_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				customerBioCheck = biocheckManager.getWithoutFingerPrint(data.get(ValidationData.CUSTOMERID), data.get(ValidationData.PROCESSINSTANCE), REVOLVENT_TYPE, args);
			} else if (INDIVIDUAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				customerBioCheck = biocheckManager.getWithoutFingerPrint(data.get(ValidationData.CUSTOMERID), data.get(ValidationData.PROCESSINSTANCE), REVOLVENT_TYPE, args);
			}
			
			//Caso #175319, se quita el grupal ya que cambia para que se cree una nueva entidad
			if (!GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				if (customerBioCheck != null) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("Inicia mapeo de Sin Huella creditEntity.get(Credit.PRODUCTTYPE): " + creditEntity.get(Credit.PRODUCTTYPE));
					}
					
					for (CustomerBiocheckResponse customerBiocheckResponse : customerBioCheck) {
						for (DataEntity customer : customerList) {
							if (customerBiocheckResponse.getEnte().equals(customer.get(Customer.IDCUSTOMER))) {
								customer.set(Customer.WITHOUTFINGERPRINTVALUE, customerBiocheckResponse.getHasFingerPrint());
								customer.set(Customer.OCR, customerBiocheckResponse.getOcr());
								customer.set(Customer.CIC, customerBiocheckResponse.getCic());
								customer.set(Customer.CUSTOMERNAME, customerBiocheckResponse.getName());
								customer.set(Customer.SURNAME, customerBiocheckResponse.getSurname());
								customer.set(Customer.MOTHERSURNAME, customerBiocheckResponse.getMotherSurname());
								customer.set(Customer.YEAR, customerBiocheckResponse.getYearRegistry());
								customer.set(Customer.YEAREMISSION, customerBiocheckResponse.getYearEmission());
								customer.set(Customer.CREDENTIALNUMBER, customerBiocheckResponse.getNoEmissionCredential());
								customer.set(Customer.VOTERKEY, customerBiocheckResponse.getVoterKey());
								customer.set(Customer.CURP, customerBiocheckResponse.getCurp());
								if (customerBiocheckResponse.getResultRule() != null) {
									customer.set(Customer.VALIDATIONSTATUS, customerBiocheckResponse.getResultRule());
								}
								if (customerBiocheckResponse.getHasFingerPrint() != null && customerBiocheckResponse.getHasFingerPrint().equals("S")
										&& GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
									customer.set(Customer.WITHOUTFINGERPRINT, true);
									customer.set(Customer.VALIDATIONSTATUS, "APROBADO");
								} else {
									if(customerBiocheckResponse.getHasFingerPrint() != null && customerBiocheckResponse.getHasFingerPrint().equals("S")) {
										customer.set(Customer.WITHOUTFINGERPRINT, true);
									}else {
										customer.set(Customer.WITHOUTFINGERPRINT, false);
									}
								}

								customer.set(Customer.BIRTHCITY, customerBiocheckResponse.getBirthCity());
								customer.set(Customer.BIRTHDAY, customerBiocheckResponse.getBirthDay());
								customer.set(Customer.BUC, customerBiocheckResponse.getBuc());
								customer.set(Customer.CHANNEL, customerBiocheckResponse.getChannel());
							}
						}
					}
					
				}
			}

			// Resultado de Validacion Regla Identidad Grupal
			if (GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				String validationResult = biocheckManager.validateData(data.get(ValidationData.CUSTOMERID), data.get(ValidationData.PROCESSINSTANCE), "G", args);
				String[] validationResultArray = validationResult.split(";");
				String validationResultLimits = validationResultArray[0];
				String validationResultStatus = "";

				LOGGER.logDebug("validationResult>>" + validationResult);
				LOGGER.logDebug("validationResultLimits>>" + validationResultLimits);
				if (validationResultArray.length > 0) {
					validationResultStatus = validationResultArray[1];
				}
				LOGGER.logDebug("validationResultStatus>>" + validationResultStatus);

				if (Constants.PENDING_RESPONSE.equals(validationResultStatus)) {
					data.set(ValidationData.RESULTVALIDATION, Constants.PENDING);
				} else {
					if (Constants.REJECTED_RESPONSE.equals(validationResultStatus)) {
						data.set(ValidationData.RESULTVALIDATION, Constants.REJECTED);
					} else {
						if (Constants.NEGATIVE_RESPONSE.equals(validationResultLimits)) {
							data.set(ValidationData.RESULTVALIDATION, Constants.REJECTED);
						} else {
							data.set(ValidationData.RESULTVALIDATION, Constants.APPROVED);
						}
					}

				}
			}

		} catch (Exception e) {
			LOGGER.logError("Error: ", e);
			args.getMessageManager().showErrorMsg("Ocurrió un error al cargar la información");
		}
	}

	private void groupDataMapping(CustomerBiocheckResponse[] customerBioCheck, DataEntity creditEntity, DataEntityList customerList) {
		int indice = 0;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia mapeo de Sin Huella - GRUPAL");
		}
		for (CustomerBiocheckResponse customerBiocheckResponse : customerBioCheck) {
			// Por caso #175319
			DataEntity customer = new DataEntity();
					
			//for (DataEntity customer : customerList) {
				//if (customerBiocheckResponse.getEnte().equals(customer.get(Customer.IDCUSTOMER))) {
			customer.set(Customer.IDCUSTOMER, customerBiocheckResponse.getEnte());
			indice += 1;
			customer.set(Customer.SEQUENTIAL, indice);
			customer.set(Customer.CUSTOMER, customerBiocheckResponse.getFullName());
			if (customerBiocheckResponse.getAmount() != null) {
				customer.set(Customer.AMOUNT, BigDecimal.valueOf(customerBiocheckResponse.getAmount()));
			} else {
				customer.set(Customer.AMOUNT, BigDecimal.valueOf(0));
			}
			customer.set(Customer.ROLE, customerBiocheckResponse.getRole());							
			customer.set(Customer.WITHOUTFINGERPRINTVALUE, customerBiocheckResponse.getHasFingerPrint());
			customer.set(Customer.OCR, customerBiocheckResponse.getOcr());
			customer.set(Customer.CIC, customerBiocheckResponse.getCic());
			customer.set(Customer.CUSTOMERNAME, customerBiocheckResponse.getName());
			customer.set(Customer.SURNAME, customerBiocheckResponse.getSurname());
			customer.set(Customer.MOTHERSURNAME, customerBiocheckResponse.getMotherSurname());
			customer.set(Customer.YEAR, customerBiocheckResponse.getYearRegistry());
			customer.set(Customer.YEAREMISSION, customerBiocheckResponse.getYearEmission());
			customer.set(Customer.CREDENTIALNUMBER, customerBiocheckResponse.getNoEmissionCredential());
			customer.set(Customer.VOTERKEY, customerBiocheckResponse.getVoterKey());
			customer.set(Customer.CURP, customerBiocheckResponse.getCurp());
			if (customerBiocheckResponse.getResultRule() != null) {
				customer.set(Customer.VALIDATIONSTATUS, customerBiocheckResponse.getResultRule());
			}
			if (customerBiocheckResponse.getHasFingerPrint() != null && customerBiocheckResponse.getHasFingerPrint().equals("S")
					&& GRUPAL_CREDIT.equals(creditEntity.get(Credit.PRODUCTTYPE))) {
				customer.set(Customer.WITHOUTFINGERPRINT, true);
				customer.set(Customer.VALIDATIONSTATUS, "APROBADO");
			} else {
				if(customerBiocheckResponse.getHasFingerPrint() != null && customerBiocheckResponse.getHasFingerPrint().equals("S")) {
					customer.set(Customer.WITHOUTFINGERPRINT, true);
				}else {
					customer.set(Customer.WITHOUTFINGERPRINT, false);
				}
			}
			customer.set(Customer.BIRTHCITY, customerBiocheckResponse.getBirthCity());
			customer.set(Customer.BIRTHDAY, customerBiocheckResponse.getBirthDay());
			customer.set(Customer.BUC, customerBiocheckResponse.getBuc());
			customer.set(Customer.CHANNEL, customerBiocheckResponse.getChannel());
			customerList.add(customer);
				//}
			//}
		}
	}
	
	private void getCreditData(DynamicRequest entities, IDataEventArgs args) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("---->Recupera el numero del tramite");
		}
		TransactionManagement transactionManagement = new TransactionManagement(this.getServiceIntegration());
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
		DataEntity credit = entities.getEntity(Credit.ENTITY_NAME);

		int applicationNumber = credit.get(Credit.APPLICATIONNUMBER) == null ? 0 : credit.get(Credit.APPLICATIONNUMBER);
		ProcessedNumber processedNumberResp = transactionManagement.getProcessedNumber(applicationNumber, args, new BehaviorOption(true));
		Integer processedNumber = processedNumberResp.getTramite();
		credit.set(Credit.CREDITCODE, processedNumber);
		ApplicationResponse creditApplication = transactionManagement.getApplication(processedNumber, args, new BehaviorOption(true));

		credit.set(Credit.OFFICENAME, creditApplication.getOffice() == null ? null : String.valueOf(creditApplication.getOffice()));
		credit.set(Credit.APPROVEDAMOUNT, creditApplication.getSumAmountGroup() == null ? null : creditApplication.getSumAmountGroup());
		credit.set(Credit.AMOUNTREQUESTED, creditApplication.getSumRequestedAmountGroup() == null ? null : creditApplication.getSumRequestedAmountGroup());
		credit.set(Credit.TERM, creditApplication.getTerm());

		List<GeneralParametersValuesHistory> frecuencyCatalog = bankingProductManager.getCatalogGeneralParameter(args, credit.get(Credit.PRODUCTTYPE), SHARE_TYPE);
		for (GeneralParametersValuesHistory generalParametersValuesHistory : frecuencyCatalog) {
			credit.set(Credit.PAYMENTFRECUENCY, generalParametersValuesHistory.getDescription());
		}
		LOGGER.logDebug("ProductType: " + credit.get(Credit.PRODUCTTYPE));

		List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, credit.get(Credit.PRODUCTTYPE), "Sector");
		// Asocio el valor del sector
		for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
			credit.set(Credit.SECTOR, sectorNeg.getDescription());
		}

	}

	private void mapGroupData(DataEntity validationData, GroupResponse groupResponse) {
		validationData.set(ValidationData.CUSTOMERNAME, groupResponse.getNameGroup());
		validationData.set(ValidationData.CYCLENUMBER, Integer.parseInt(groupResponse.getCycleNumber()));
	}

	private void mapCustomerData(DataEntity validationData, CustomerResponse customerResponse) {
		StringBuilder customerName = new StringBuilder();

		customerName.append(customerResponse.getCustomerName());
		customerName.append(" ");
		if (customerResponse.getCustomerSecondName() != null) {
			customerName.append(customerResponse.getCustomerSecondName());
			customerName.append(" ");
		}
		if (customerResponse.getCustomerLastName() != null) {
			customerName.append(customerResponse.getCustomerLastName());
			customerName.append(" ");
		}
		if (customerResponse.getCustomerSecondLastName() != null) {
			customerName.append(customerResponse.getCustomerSecondLastName());
		}
		validationData.set(ValidationData.CUSTOMERNAME, customerName.toString());

	}

	public void readEnvironment(DynamicRequest entities, String parameterName, IDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("<<< Inicia readEnvironment >>>");
		}
		try {
			DataEntity additionaInformation = entities.getEntity(AdditionalInformation.ENTITY_NAME);
			ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
			ParameterResponse environment = parameterManagement.getParameter(4, parameterName, "CLI", args);

			if (null != environment) {
				additionaInformation.set(AdditionalInformation.ENVIRONMENT, environment.getParameterValue());
			}

		} catch (Exception e) {
			LOGGER.logError("Error en la obtencion del parametro " + parameterName + " : ", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("<<< Finaliza readEnvironment >>>");
			}
		}

	}

}
