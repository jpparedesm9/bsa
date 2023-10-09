package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.comext.dto.BankGuaranteeRequest;
import cobiscorp.ecobis.comext.dto.BankGuaranteeResponse;
import cobiscorp.ecobis.comext.dto.CommissionCalculationRequest;
import cobiscorp.ecobis.comext.dto.CostBankGuaranteeResponse;
import cobiscorp.ecobis.comext.dto.RuleBankGuaranteeRequest;
import cobiscorp.ecobis.comext.dto.TypeBankGuaranteeRequest;
import cobiscorp.ecobis.comext.dto.TypeBankGuaranteeResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.FeeRate;
import com.cobiscorp.cobis.busin.model.HeaderGuaranteesTicket;
import com.cobiscorp.cobis.busin.model.IndexSizeActivity;
import com.cobiscorp.cobis.busin.model.Official;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;

public class TicketManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(TicketManagement.class);
	int customerId;

	public TicketManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public BankGuaranteeResponse createBankGuarantee(BankGuaranteeRequest bankGuaranteeRequest, ICommonEventArgs arg1, BehaviorOption options) {
		BankGuaranteeResponse bankGuaranteeResponseDTO = null;
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INBANKGUARANTEEREQUEST, bankGuaranteeRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATEBANKGUARANTEE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- BOLETA GUARDADA OK PARA PROCESO: " + bankGuaranteeRequest.getInstProcess());
			ServiceResponseTO serviceResponseDTO = (ServiceResponseTO) serviceResponse.getData();
			@SuppressWarnings("unchecked")
			Map<String, Object> bankGuaranteeResponseM = (Map<String, Object>) serviceResponseDTO.getValue("com.cobiscorp.cobis.cts.service.response.output");

			bankGuaranteeResponseDTO = new BankGuaranteeResponse();
			if (bankGuaranteeResponseM != null) {
				if (bankGuaranteeResponseM.get("@o_cod_tramite") != null) {
					bankGuaranteeResponseDTO.setIdRequested(Integer.valueOf(bankGuaranteeResponseM.get("@o_cod_tramite").toString()));
					logger.logDebug(" -- BG -- Codigo tramite: " + bankGuaranteeResponseM.get("@o_cod_tramite"));
				}

				if (bankGuaranteeResponseM.get("@o_op_banco") != null) {
					bankGuaranteeResponseDTO.setBank(bankGuaranteeResponseM.get("@o_op_banco").toString());
					logger.logDebug(" -- BG -- Codigo op banco: " + bankGuaranteeResponseM.get("@o_op_banco"));
				}

				if (bankGuaranteeResponseM.get("@o_cod_oper") != null) {
					bankGuaranteeResponseDTO.setOperationCode(Integer.valueOf(bankGuaranteeResponseM.get("@o_cod_oper").toString()));
					logger.logDebug(" -- BG -- Codigo operacion: " + bankGuaranteeResponseM.get("@o_cod_oper"));
				}
			}
		} else {
			logger.logDebug(" -- BG -- BOLETA ERROR PARA PROCESO: " + bankGuaranteeRequest.getInstProcess());
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return bankGuaranteeResponseDTO;
	}

	public BankGuaranteeResponse QueryBankGuarantee(Integer idProcess, String numberBankOperation, String isRenovation, ICommonEventArgs arg1, BehaviorOption options) {

		BankGuaranteeRequest bankGuaranteeRequest = new BankGuaranteeRequest();
		bankGuaranteeRequest.setInstProcess(idProcess);
		bankGuaranteeRequest.setNumberBankOperation(numberBankOperation);
		bankGuaranteeRequest.setFormateDate(SessionContext.getFormatDate());
		bankGuaranteeRequest.setRenewal(isRenovation);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INBANKGUARANTEEREQUEST, bankGuaranteeRequest);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYBANKGUARANTEE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- RESULTADO DE QueryBankGuarantee para proceso : " + idProcess);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (BankGuaranteeResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNBANKGUARANTEERESPONSE);
		} else {
			logger.logDebug(" -- BG -- ERROR DE QueryBankGuarantee para proceso : " + idProcess);
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean updateBankGuarantee(BankGuaranteeRequest bankGuaranteeRequest, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INBANKGUARANTEEREQUEST, bankGuaranteeRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEBANKGUARANTEE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- RESULTADO DE updateBankGuarantee para proceso : " + bankGuaranteeRequest.getInstProcess());
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	// Recupera los tipos de garantías para la clase de Garantía - Combo
	public TypeBankGuaranteeResponse[] searchTypeBankGuarantee(String classCode, String typeCode, String state, ICommonEventArgs arg1, BehaviorOption options) {

		TypeBankGuaranteeRequest typeBankGuaranteeRequest = new TypeBankGuaranteeRequest();
		typeBankGuaranteeRequest.setClassCode(classCode);
		typeBankGuaranteeRequest.setClassType(typeCode);
		typeBankGuaranteeRequest.setState(state);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INTYPEBANKGUARANTEEREQUEST, typeBankGuaranteeRequest);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHTYPEBANKGUARANTEE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug(" -- BG -- Tipo de Garantías recuperados para clase: " + typeBankGuaranteeRequest.getClassCode());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (TypeBankGuaranteeResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNTYPEBANKGUARANTEERESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public AddressRequest[] getAddress(AddressRequest request, ICommonEventArgs argss, BehaviorOption options) {

		ServiceResponse serviceResponse = null;
		ServiceRequestTO requestTO = new ServiceRequestTO();
		ServiceResponseTO serviceResponseTo = new ServiceResponseTO();

		requestTO.addValue("inAddressRequest", request);
		serviceResponse = execute(logger, "CustomerDataManagementService.CustomerManagement.SearchAddress", requestTO);
		logger.logDebug("<< serviceResponse " + serviceResponse);
		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("ENTRAMOS A LA EJECUCION DEL SERVICIO");
			serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			return (AddressRequest[]) serviceResponseTo.getValue("returnAddressRequest");

		}

		return null;
	}

	public void mappingWarrantiesTicket(DynamicRequest arg0, ICommonEventArgs arg1) {
		/*
		 * ServiceResponse serviceResponse = null; ServiceRequestTO requestTO = new ServiceRequestTO(); ServiceResponseTO serviceResponseTo = new
		 * ServiceResponseTO();
		 */
		if (logger.isDebugEnabled())
			logger.logDebug("<< COMIENZA INITDATA_TGUARANTEESTICKET");

		DataEntity originalHeader = arg0.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity headerGuaranteeSticket = arg0.getEntity(HeaderGuaranteesTicket.ENTITY_NAME);
		DataEntity indexSizeActivity = arg0.getEntity(IndexSizeActivity.ENTITY_NAME);
		DataEntity oficial = arg0.getEntity(Official.ENTITY_NAME);
		String customerType = headerGuaranteeSticket.get(HeaderGuaranteesTicket.CUSTOMERTYPE);
		boolean success = true;
		BankGuaranteeResponse bankGuaranteeResponse = null;
		AddressRequest addressRequest = new AddressRequest();
		int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		try {
			// 1.- RECUPERA NUMERO DE TRAMITE
			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}
			int codigoTramite = processedNumber.getTramite();

			OfficerManagement officeMngt = new OfficerManagement(super.getServiceIntegration());
			OfficerResponse officeResponseDTO;
			officeResponseDTO = officeMngt.getOfficerByLogin(headerGuaranteeSticket.get(HeaderGuaranteesTicket.USER), arg1, new BehaviorOption(true));
			if (officeResponseDTO != null && officeResponseDTO.getOfficerId() != null) {
				originalHeader.set(OriginalHeader.OFFICERNAME, officeResponseDTO.getOfficerName());
				originalHeader.set(OriginalHeader.OFFICERID, String.valueOf(officeResponseDTO.getOfficerId()));
			}

			// 2.RECUPERO EL ID DEL CLIENTE
			customerId = headerGuaranteeSticket.get(HeaderGuaranteesTicket.CUSTOMERID);
			logger.logDebug("<< Recupero customerId " + customerId);
			// headerGuaranteeSticket.set(HeaderGuaranteesTicket.EXPIRATIONDATE,
			// date);
			headerGuaranteeSticket.set(HeaderGuaranteesTicket.REQUESTEDTERMINDAYS, 0);

			// 3. RECUPERO LOS DATOS DE LA DIRECCION DEL CLIENTE
			addressRequest.setCustomerId(customerId);
			TicketManagement ticketManagement = new TicketManagement(super.getServiceIntegration());
			AddressRequest[] data;
			data = ticketManagement.getAddress(addressRequest, arg1, new BehaviorOption(true));
			if (customerType != null && customerType.equals("C")) {
				if (data != null) {
					logger.logDebug("RETORNA DATA " + data.length);
					for (AddressRequest adReq : data) {
						if (adReq.getPrincipal().equals("S")) {
							if (!adReq.getIsChecked().equals("S")) {
								MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_VERCILCIE_57786", MessageLevel.ERROR, true));
								success = false;
							}
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.CUSTOMERADDRESS, adReq.getAddressDesc());
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTADDRESS, adReq.getAddressDesc());
							break;
						} else {
							logger.logDebug("NO TIENE DIRECCION PRINCIPAL");
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.CUSTOMERADDRESS, adReq.getAddressDesc());
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTADDRESS, adReq.getAddressDesc());
						}
					}
				}
			} else {
				if (data != null) {
					logger.logDebug("RETORNA DATOS EL SERVICIO DE DIRECION DEL CLIENTE");
					for (AddressRequest adReq : data) {
						if (adReq.getPrincipal().equals("S")) {
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.CUSTOMERADDRESS, adReq.getAddressDesc());
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTADDRESS, adReq.getAddressDesc());
							break;
						} else {
							logger.logDebug("NO TIENE DIRECCION PRINCIPAL");
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.CUSTOMERADDRESS, adReq.getAddressDesc());
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTADDRESS, adReq.getAddressDesc());
						}
					}
				}
			}

			// 3.- SI TIENE TRAMITE TRAE LOS DATOS
			if (codigoTramite != 0) {
				// 5-A.- RECUPERA DEUDEORES/CO-DEUDEORES
				logger.logDebug("RECUPERA DEUDEORES/CO-DEUDEORES tramite != 0");
				originalHeader.set(OriginalHeader.IDREQUESTED, String.valueOf(codigoTramite));
				DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
				DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite, arg1, new BehaviorOption(true));
				if (debtors != null) {
					arg0.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
				} else {
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}
				
				getCreditLineData(arg0, arg1, headerGuaranteeSticket, transactionManagement, codigoTramite, debManagement, debtors, indexSizeActivity);			
					
				if (originalHeader.get(OriginalHeader.APPLICATIONNUMBER) != null) {
					logger.logDebug("RECUPERA DATOS DE COMEXT PARA APERTURA");
					bankGuaranteeResponse = QueryBankGuarantee(originalHeader.get(OriginalHeader.APPLICATIONNUMBER), null, "N", arg1, new BehaviorOption(true));
					originalHeader.set(OriginalHeader.OPNUMBERBANK, bankGuaranteeResponse.getBank());	
				} else {
					logger.logDebug("APPLICATIONNUMBER es null");
				}
			} else {
				// 5-B.- RECUPERA NOMBRE E IDENTIFICACION DEL CLIENTE
				logger.logDebug("RECUPERA DEUDEORES/CO-DEUDEORES tramite == 0");
				// 4-A.- RECUPERA NOMBRE E IDENTIFICACION DEL CLIENTE
				DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
				DataEntityList dataEntityCustomer = debManagement.getCustomerEntityList(arg0, arg1);
				if (dataEntityCustomer != null) {
					arg0.setEntityList(DebtorGeneral.ENTITY_NAME, dataEntityCustomer);
				} else {
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}

				// fecha del servidor
				SystemConfigurationManagement sysCnfMangmt = new SystemConfigurationManagement(super.getServiceIntegration());
				Date iniDate = sysCnfMangmt.getDate(SessionContext.getFormatDate(), arg1, new BehaviorOption(false, false));
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.DATEPROCESS, iniDate);

				/*
				 * if (headerGuaranteeSticket.get(HeaderGuaranteesTicket.RENEWOPERATION) != null &&
				 * !headerGuaranteeSticket.get(HeaderGuaranteesTicket.RENEWOPERATION).isEmpty()) {
				 * headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE, "RENOVACION");
				 * logger.logDebug("OBTIENE DATOS PARA LA RENOVACIÓN"); bankGuaranteeResponse = QueryBankGuarantee(null,
				 * headerGuaranteeSticket.get(HeaderGuaranteesTicket.RENEWOPERATION), "S", arg1, new BehaviorOption(true));
				 * originalHeader.set(OriginalHeader.IDREQUESTED, ""); } else { headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE,
				 * "ORIGINAL"); }
				 */

			}

			// 6. RECUPERA LOS DATOS DE COMEXT
			if (bankGuaranteeResponse != null) {
				logger.logDebug("bankGuaranteeResponse.getRenewal()-->" + bankGuaranteeResponse.getRenewal());
				logger.logDebug("bankGuaranteeResponse.getBank()-->" + bankGuaranteeResponse.getBank());
				logger.logDebug("bankGuaranteeResponse.getReference()-->" + bankGuaranteeResponse.getReference());
				logger.logDebug("bankGuaranteeResponse.getAmount()-->" + bankGuaranteeResponse.getIdRequested());
				if (bankGuaranteeResponse != null && bankGuaranteeResponse.getRenewal().equals("S")) {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE, "RENOVACION");
				} else {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE, "ORIGINAL");
				}
				if (bankGuaranteeResponse.getAmount() != null) {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.AMOUNTREQUESTED, new BigDecimal(bankGuaranteeResponse.getAmount()));
				}
				/*
				 * if (bankGuaranteeResponse.getReference() != null) { headerGuaranteeSticket.set(HeaderGuaranteesTicket.RENEWOPERATION,
				 * bankGuaranteeResponse.getReference()); }
				 */
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.WARRANTYCLASS, bankGuaranteeResponse.getWarrantyClass());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.WARRANTYTYPE, bankGuaranteeResponse.getWarrantyType());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.CURRENCYREQUESTED, String.valueOf(bankGuaranteeResponse.getCurrency()));

				ApplicationResponse applicationResponse = transactionManagement.getApplication(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)), arg1, new BehaviorOption(true));
				
				if(applicationResponse!=null){
					if(applicationResponse.getSector()!=null){
						headerGuaranteeSticket.set(HeaderGuaranteesTicket.CREDITSECTOR, applicationResponse.getSector().trim());
					}else{
						CatalogManagement catalogMngnt = new CatalogManagement(super.getServiceIntegration());
						ParameterResponse parameterSECEMP = catalogMngnt.getParameter(4, "SECEMP", "CRE", arg1, new BehaviorOption(false, false));
						if(parameterSECEMP != null){
							headerGuaranteeSticket.set(HeaderGuaranteesTicket.CREDITSECTOR, parameterSECEMP.getParameterValue());
						}
					}						
				}
				
				if (bankGuaranteeResponse.getDateEmis() != null) {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.FROMDATE, Convert.CString.toDate(bankGuaranteeResponse.getDateEmis()));
				}
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.REQUESTEDTERMINDAYS, bankGuaranteeResponse.getTerm());

				if (bankGuaranteeResponse.getDateExpir() != null) {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.EXPIRATIONDATE, Convert.CString.toDate(bankGuaranteeResponse.getDateExpir()));
				}
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTNAME, bankGuaranteeResponse.getOnAccountOf());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.BYACCOUNTADDRESS, bankGuaranteeResponse.getAddressPCD());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.BENEFICIARYNAME, bankGuaranteeResponse.getBeneficiary());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.BENEFICIARYADDRESS, bankGuaranteeResponse.getAddressBen());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.OBJECTGUARANTEE, bankGuaranteeResponse.getReason());
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.ADDITIONALINSTRUCTION, (bankGuaranteeResponse.getInstructionOne() != null ? bankGuaranteeResponse.getInstructionOne() : "")
						+ (bankGuaranteeResponse.getInstructionTwo() != null ? bankGuaranteeResponse.getInstructionTwo() : "")
						+ (bankGuaranteeResponse.getInstructionThree() != null ? bankGuaranteeResponse.getInstructionThree() : ""));
			} else {
				logger.logDebug("No existe información para el bankGuaranteeResponse");
				if (headerGuaranteeSticket.get(HeaderGuaranteesTicket.RENEWOPERATION) != null && !headerGuaranteeSticket.get(HeaderGuaranteesTicket.RENEWOPERATION).isEmpty()) {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE, "RENOVACION");
				} else {
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.APPLICATIONTYPE, "ORIGINAL");
				}
			}

			logger.logDebug("OriginalHeader.IDREQUESTED" + originalHeader.get(OriginalHeader.IDREQUESTED));
			// 7.Recupero oficial asignado al tramite
			if (originalHeader.get(OriginalHeader.IDREQUESTED) != null && !originalHeader.get(OriginalHeader.IDREQUESTED).isEmpty()) {
				int idRequested = (Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
				logger.logDebug("idRequested " + idRequested);
				ApplicationResponse creditNewApplication = transactionManagement.getApplication(idRequested, arg1, new BehaviorOption(true));
				// Obteniendo el nombre del Usuario del tramite
				if (creditNewApplication != null) {
					logger.logDebug("Codigo del oficial " + creditNewApplication.getOfficer());
					logger.logDebug("Entidad oficial " + oficial);
					if (oficial != null) {
						oficial.set(Official.OFFICIAL, String.valueOf(creditNewApplication.getOfficer()));
					}
					String officerName = officeMngt.getOfficerName(creditNewApplication.getOfficer(), arg1, new BehaviorOption(true));
					originalHeader.set(OriginalHeader.USERL, officerName);
					originalHeader.set(OriginalHeader.OFFICERNAME, officerName);
					originalHeader.set(OriginalHeader.OFFICERID, String.valueOf(creditNewApplication.getOfficer()));
					if(creditNewApplication.getOffice() != null){
						originalHeader.set(OriginalHeader.OFFICE, creditNewApplication.getOffice());
					}	
					headerGuaranteeSticket.set(HeaderGuaranteesTicket.DATEPROCESS, creditNewApplication.getCreationDate().getTime());
				}
			}
			
			// 1.- RECUPERA DATOS DE OFICINA
			LocationManagement locManagement = new LocationManagement(super.getServiceIntegration());
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(false));
			if (officeResponse != null) {
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
				originalHeader.set(OriginalHeader.PROVINCE, officeResponse.getProvinceId());
			} else {
				originalHeader.set(OriginalHeader.CITYCODE, -1);
				originalHeader.set(OriginalHeader.PROVINCE, -1);
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NODNCOFCI_45206", MessageLevel.ERROR, true));
				return;
			}
			if (logger.isDebugEnabled())
				logger.logDebug("<< TGUARANTEESTICKET >> CIUDAD: " + officeResponse.getCityId() + " - PROVINCIA - " + officeResponse.getProvinceId());

			if (success == false) {
				arg1.setSuccess(success);
			} else {
				arg1.setSuccess(success);
			}

			if (logger.isDebugEnabled())
				logger.logDebug("<< TERMINA INITDATA_TGUARANTEESTICKET");

		} catch (Exception e) {
			logger.logDebug("Error method mappingWarrantiesTicket " + this.getClass().toString(), e);
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, "Error:" + e.getMessage());
			arg1.setSuccess(false);
		}

	}

	private void getCreditLineData(DynamicRequest arg0, ICommonEventArgs arg1, DataEntity headerGuaranteeSticket, TransactionManagement transactionManagement, int codigoTramite,
			DebtorManagement debManagement, DataEntityList debtors, DataEntity indexSizeActivity) {
		logger.logDebug("Ingresa al método getDebtorsAndCreditLine ");

		ApplicationResponse applicationResponse = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
		
		if (applicationResponse != null) {
			logger.logDebug("SECTOR-->" + applicationResponse.getSector());
			if (applicationResponse.getSector() != null) {
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.SECTOR, applicationResponse.getSector());
			} else {
				List<EconomicActivityResponse> dataDebtorsActivityItemDTO = debManagement.dataDebtorsActivityItemDTO(debtors, (IDataEventArgs) arg1);
				if (dataDebtorsActivityItemDTO != null) {
					if (dataDebtorsActivityItemDTO.size() == 0) {
						headerGuaranteeSticket.set(HeaderGuaranteesTicket.SECTOR, indexSizeActivity.get(IndexSizeActivity.PARAMETERFIXEDINCOME));
					} else {
						headerGuaranteeSticket.set(HeaderGuaranteesTicket.SECTOR, dataDebtorsActivityItemDTO.get(0).getSector());
					}
				}
			}

			logger.logDebug("CREDITLINEDISTRIB-->" + applicationResponse.getLineComext());
			headerGuaranteeSticket.set(HeaderGuaranteesTicket.CREDITLINEDISTRIB, applicationResponse.getLineComext());
			logger.logDebug("AMOUNTREQUESTED-->" + applicationResponse.getAmountRequested());
			if (applicationResponse.getAmountRequested() != null) {
				headerGuaranteeSticket.set(HeaderGuaranteesTicket.AMOUNTREQUESTED,applicationResponse.getAmountRequested());
			}

			// Recuera la linea
			CreditLineManagement creditLineManagement = new CreditLineManagement(super.getServiceIntegration());
			LineCreditData[] listCredit = creditLineManagement.getByCustomer(customerId, arg1, new BehaviorOption(true));

			if (listCredit != null) {
				for (LineCreditData line : listCredit) {
					if (line.getCreditLine().equals(headerGuaranteeSticket.get(HeaderGuaranteesTicket.CREDITLINEDISTRIB))) {
						headerGuaranteeSticket.set(HeaderGuaranteesTicket.AMOUNTAVAILABLE, line.getAmountAvailable());
					}
				}
			}
			/*
			 * else{ headerGuaranteeSticket.set(HeaderGuaranteesTicket. CREDITLINEDISTRIB, ""); headerGuaranteeSticket.set(HeaderGuaranteesTicket
			 * .AMOUNTAVAILABLE, new BigDecimal(0.0)); }
			 */
		}
		logger.logDebug("Finaliza métdoo getDebtorsAndCreditLine");
	}

	public ServiceResponseTO dataRuleGuarantee(Integer idProcess, String operationBank, String category) {
		logger.logDebug("Entra a VALORES DE dataRuleGuarantee -----------> " + idProcess + "-" + category);
		RuleBankGuaranteeRequest ruleBankGuaranteeRequest = new RuleBankGuaranteeRequest();
		ruleBankGuaranteeRequest.setIdProcess(idProcess);
		ruleBankGuaranteeRequest.setOperationBank(operationBank);
		ruleBankGuaranteeRequest.setCategory(category);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INRULEBANKGUARANTEEREQUEST, ruleBankGuaranteeRequest);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHCOSTRULE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- RESULTADO DE SERVICESEARCHCOSTRULE para proceso : " + idProcess);
			ServiceResponseTO serviceResponseDTO = (ServiceResponseTO) serviceResponse.getData();

			return serviceResponseDTO;
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<RuleProcess> executeRuleGuarantee(String acronim, Integer idProcess, String operationBank, String category, ICommonEventArgs arg1, BehaviorOption options) {
		RuleVersion ruleVersion = null;
		logger.logDebug("Entra ejecucion servicio executeRuleGuarantee-------> " + acronim + " idprocess " + idProcess + " gar " + operationBank + " categoria " + category);
		ServiceResponse serviceResponse = null;
		serviceResponse = this.execute(getServiceIntegration(), logger, "Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym", new Object[] { acronim });
		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("Entra a serviceResponse -----------> ");
			List<RuleVersion> ruleList = (List<RuleVersion>) serviceResponse.getData();
			if (!ruleList.isEmpty()) {
				ruleVersion = ruleList.get(0);
			}
		}

		if (ruleVersion != null) {
			logger.logDebug("Entra a ruleVersion -----------> ");
			VariableProcess variableProcessGuaranteeClass = new VariableProcess();
			VariableProcess variableProcessTypeGuarantee = new VariableProcess();
			VariableProcess variableProcessTypeBakcup = new VariableProcess();
			VariableProcess variableProcessQualificationCustomer = new VariableProcess();

			Variable guaranteeClass = new Variable();
			Variable typeGuarantee = new Variable();
			Variable typeBakcup = new Variable();
			Variable qualificationCustomer = new Variable();

			logger.logDebug("Entra a ANTES -----------> ");
			ServiceResponseTO serviceResponseDTO = this.dataRuleGuarantee(idProcess, operationBank, category);
			Map<String, Object> ruleBankGuaranteeResponse = (Map<String, Object>) serviceResponseDTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			logger.logDebug("Entra a DESPUES -----------> ");
			if (ruleBankGuaranteeResponse != null) {
				logger.logDebug("Entra a MAS DESPUES -----------> ");
				if (ruleBankGuaranteeResponse.get("@o_clase") != null) {
					logger.logDebug("Entra a MAS MAS DESPUES -----------> ");
					guaranteeClass.setNombreVariable("CLASE DE GARANTIA BANCARIA");
					variableProcessGuaranteeClass.setValue(ruleBankGuaranteeResponse.get("@o_clase").toString());
					variableProcessGuaranteeClass.setVariable(guaranteeClass);
					logger.logDebug(">>>> CLASE DE GARANTIA BANCARIA: " + ruleBankGuaranteeResponse.get("@o_clase"));
				}

				if (ruleBankGuaranteeResponse.get("@o_tipo") != null) {
					typeGuarantee.setNombreVariable("TIPO DE GARANTIA BANCARIA");
					variableProcessTypeGuarantee.setValue(ruleBankGuaranteeResponse.get("@o_tipo").toString());
					variableProcessTypeGuarantee.setVariable(typeGuarantee);
					logger.logDebug(">>>> TIPO DE GARANTIA BANCARIA: " + ruleBankGuaranteeResponse.get("@o_tipo"));
				}

				if (ruleBankGuaranteeResponse.get("@o_trespaldo") != null) {
					typeBakcup.setNombreVariable("TIPO DE RESPALDO");
					variableProcessTypeBakcup.setValue(ruleBankGuaranteeResponse.get("@o_trespaldo").toString());
					variableProcessTypeBakcup.setVariable(typeBakcup);
					logger.logDebug(">>>> TIPO DE RESPALDO: " + ruleBankGuaranteeResponse.get("@o_trespaldo"));
				}

				if (ruleBankGuaranteeResponse.get("@o_calif_cli") != null) {
					qualificationCustomer.setNombreVariable("CALIFICACION CLIENTE");
					variableProcessQualificationCustomer.setValue(ruleBankGuaranteeResponse.get("@o_calif_cli").toString());
					variableProcessQualificationCustomer.setVariable(qualificationCustomer);
					logger.logDebug(">>>> CALIFICACION CLIENTE: " + ruleBankGuaranteeResponse.get("@o_calif_cli"));
				}
			}
			List<VariableProcess> listVariableProcess = new ArrayList<VariableProcess>();
			listVariableProcess.add(variableProcessGuaranteeClass);
			listVariableProcess.add(variableProcessTypeGuarantee);
			listVariableProcess.add(variableProcessTypeBakcup);
			if (acronim.equals(Mnemonic.SPECIAL))
				listVariableProcess.add(variableProcessQualificationCustomer);

			// Creación de mapa con la regla y la lista de variables proceso
			HashMap<RuleVersion, List<VariableProcess>> values = new HashMap<RuleVersion, List<VariableProcess>>();
			values.put(ruleVersion, listVariableProcess);

			// Ejecucion del servicio
			// ServiceResponse serviceResponse = null;
			serviceResponse = this.execute(getServiceIntegration(), logger, "Bpl.Rules.Engine.RuleManager.Generate", new Object[] { values, 0, "", Integer.valueOf(SessionUtil.getRol()) });

			/*
			 * Donde: values: es le mapa creado 0: es el id del cliente cuando existen excepciones "": es el numero de la tarjeta de crédito cuando
			 * existen excepciones 3 : es el id del role que se logueo el usuario.
			 */

			if (serviceResponse != null && serviceResponse.isResult()) {
				return (List<RuleProcess>) serviceResponse.getData();
			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}
		}
		return new ArrayList<RuleProcess>();
	}

	public boolean CreateUpdateCostBankGuarantee(DynamicRequest entities, ICommonEventArgs arg1, String option) {
		DataEntity feeRate = entities.getEntity(FeeRate.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity headerGuaranteeSticket = entities.getEntity(HeaderGuaranteesTicket.ENTITY_NAME);

		RuleBankGuaranteeRequest ruleBankGuaranteeRequest = new RuleBankGuaranteeRequest();
		ruleBankGuaranteeRequest.setIdProcess(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
		ruleBankGuaranteeRequest.setComment("APROBACION - ORIGINADOR");
		ruleBankGuaranteeRequest.setCurrency(Integer.valueOf(headerGuaranteeSticket.get(HeaderGuaranteesTicket.CURRENCYREQUESTED)));
		ruleBankGuaranteeRequest.setFactor(feeRate.get(FeeRate.PERCENTAGENEW));
		ruleBankGuaranteeRequest.setCategory(feeRate.get(FeeRate.COSTCATEGORY));

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INRULEBANKGUARANTEEREQUEST, ruleBankGuaranteeRequest);
		ServiceResponse serviceResponse;
		if (option.equals(Mnemonic.INSERT))
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATECOSTBANKGUARANTE, serviceRequestTO);
		else
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATECOSTBANKGUARANTE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- RESULTADO DE SERVICECREATECOSTBANKGUARANTE");
			arg1.setSuccess(true);
			arg1.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625");
			return serviceResponse.isResult();
		}
		arg1.setSuccess(false);
		return false;
	}

	public boolean SearchCostBankGuarantee(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options, String origen) {
		DataEntity feeRate = entities.getEntity(FeeRate.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		RuleBankGuaranteeRequest ruleBankGuaranteeRequest = new RuleBankGuaranteeRequest();
		ruleBankGuaranteeRequest.setIdProcess(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INRULEBANKGUARANTEEREQUEST, ruleBankGuaranteeRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHCOSTBANKGUARANTE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug(" Costos Recuperados para Garantías: " + originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			CostBankGuaranteeResponse costBankGuaranteeResponse = (CostBankGuaranteeResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNCOSTBANKGUARANTEERESPONSE);
			if (costBankGuaranteeResponse != null) {
				if (costBankGuaranteeResponse.getRate() >= 0 && costBankGuaranteeResponse.getItemCode() != null) {
					logger.logDebug("ORIGEN " + origen);
					if (origen.equals("Init")) {
						if (logger.isDebugEnabled())
							logger.logDebug("NUEVA TASA: " + costBankGuaranteeResponse.getRate());
						feeRate.set(FeeRate.PERCENTAGENEW, costBankGuaranteeResponse.getRate());
						return true;
					} else {
						return true;
					}
				}
				return false;
			}
			return false;

		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	public void calculatedCommissionGuarantee(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		DataEntity feeRate = entities.getEntity(FeeRate.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		CommissionCalculationRequest commissionCalculationRequest = new CommissionCalculationRequest();
		commissionCalculationRequest.setIdProcess(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
		commissionCalculationRequest.setValueMax(feeRate.get(FeeRate.MAXVALUE));
		commissionCalculationRequest.setValueMin(feeRate.get(FeeRate.MINVALUE));
		commissionCalculationRequest.setFactor((feeRate.get(FeeRate.PERCENTAGENEW)));

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INCOMMISSIONCALCULATIONREQUEST, commissionCalculationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECOMMISSIONCALCULATE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug(" Comission Recuperada: ");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceItemsResponseTO != null) {
				@SuppressWarnings("unchecked")
				Map<String, Object> commissionCalculationResponse = (Map<String, Object>) serviceItemsResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug("Entra a serviceItemsResponseTO -----------> ");
				if (commissionCalculationResponse != null) {
					logger.logDebug("Entra a commissionCalculationResponse -----------> ");
					if (commissionCalculationResponse.get("@o_valor") != null) {
						if (logger.isDebugEnabled())
							logger.logDebug("Entra @o_valor -----------> " + commissionCalculationResponse.get("@o_valor"));
						feeRate.set(FeeRate.COMMISSION, Double.valueOf(commissionCalculationResponse.get("@o_valor").toString()));
					}
					if (commissionCalculationResponse.get("@o_moneda") != null) {
						if (logger.isDebugEnabled())
							logger.logDebug("Entra @o_moneda -----------> " + commissionCalculationResponse.get("@o_moneda"));
						feeRate.set(FeeRate.CURRENCY, Integer.valueOf(commissionCalculationResponse.get("@o_moneda").toString()));
					}
					if (commissionCalculationResponse.get("@o_minimo") != null) {
						if (logger.isDebugEnabled())
							logger.logDebug("Entra @o_minimo -----------> " + commissionCalculationResponse.get("@o_minimo"));
						feeRate.set(FeeRate.MINIMUM, commissionCalculationResponse.get("@o_minimo").toString());
					}
				}
			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}
		}
	}

	public double getAmountInLocalCurrency(int currencyProposed, double amountProposed, ICommonEventArgs arg1, BehaviorOption options) throws Exception {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		ServiceResponse serviceResponse = null;
		QuoteRequest quoteRequest = new QuoteRequest();
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		serviceResponse = null;
		serviceRequestTO = new ServiceRequestTO();
		String localMoney = null;
		Double cotizacion;

		ParameterRequest parameterRequest = new ParameterRequest();
		ParameterResponse parameterResponse = new ParameterResponse();
		parameterRequest.setMode(4);
		parameterRequest.setParameterNemonic("MLO");
		parameterRequest.setProductNemonic("ADM");

		serviceRequestTO.addValue(RequestName.INPARAMETERREQUEST, parameterRequest);
		serviceResponse = execute(getServiceIntegration(), logger, ServiceId.PARAMETERMANAGEMENT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			parameterResponse = (ParameterResponse) serviceResponseTO.getValue(ReturnName.RETURNPARAMETERRESPONSE);
			localMoney = parameterResponse.getParameterValue();

			quoteRequest.setCurrencyOrigin(Integer.parseInt(localMoney));
			quoteRequest.setCurrencyDestination(currencyProposed);
			quoteRequest.setOffice(Integer.valueOf(SessionUtil.getOffice()));
			quoteRequest.setModule("CRE");

			if (currencyProposed == Integer.parseInt(localMoney)) {
				cotizacion = transactionManagement.getQuote(quoteRequest, arg1, options);
			} else {
				cotizacion = transactionManagement.getQuoteUSD(quoteRequest, arg1, options);
			}

			return (cotizacion * amountProposed);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			throw new Exception();
		}

	}
}
