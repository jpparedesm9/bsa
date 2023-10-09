package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResponseList;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityResponse;

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
import com.cobiscorp.cobis.busin.model.DetailSourceRevenueCustomer;
import com.cobiscorp.cobis.busin.model.HeaderPunishment;
import com.cobiscorp.cobis.busin.model.SourceRevenueCustomer;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class DebtorManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(DebtorManagement.class);
	private int ssn = 0;

	public DebtorManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public int getSsn() {
		return ssn;
	}

	private void setSsn(int ssn) {
		this.ssn = ssn;
	}

	public DebtorResponse[] getDebtorsDTOList(int idRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("--------Aaaaaaaaaaa1");
		DebtorRequest debtorRequest = new DebtorRequest();
		debtorRequest.setApplicationCode(idRequest);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYDEBTOR, serviceRequestTO);// trn 21413

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Clientes recuperados para Tramite:" + idRequest);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DebtorResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNDEBTORRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public DataEntityList getDebtorsEntityList(int idRequest, ICommonEventArgs arg1, BehaviorOption options) {
		DebtorResponse[] debtorsDTO = this.getDebtorsDTOList(idRequest, arg1, options);

		if (debtorsDTO != null) {
			DataEntityList debtorsEntity = new DataEntityList();
			for (DebtorResponse debtor : debtorsDTO) {
				DataEntity eDebtor = new DataEntity();
				eDebtor.set(DebtorGeneral.CUSTOMERCODE, debtor.getDebtorCode());
				eDebtor.set(DebtorGeneral.ROLE, debtor.getRole());
				eDebtor.set(DebtorGeneral.IDENTIFICATION, debtor.getDebtorIdentification());
				eDebtor.set(DebtorGeneral.TYPEDOCUMENTID, debtor.getDebtorIdentificationType());
				eDebtor.set(DebtorGeneral.CUSTOMERNAME, debtor.getDebtorName());
				eDebtor.set(DebtorGeneral.RFC, debtor.getNit());
				// eDebtor.set(DebtorGeneral.QUALIFICATION, Convert.StringToString(debtor.getQualification(), ""));
				// eDebtor.set(DebtorGeneral.DATECIC, (debtor.getDateCIC() != null) ? debtor.getDateCIC().getTime() : null);
				logger.logDebug(":>:>getDebtorsEntityListNuevo -> eDebtor.get(DebtorGeneral.ROLE):>:>" + eDebtor.get(DebtorGeneral.ROLE));
				debtorsEntity.add(eDebtor);
			}
			logger.logDebug(":>:>getDebtorsEntityList -> debtors:>:>" + debtorsEntity.getDataList());

			return debtorsEntity;
		}
		return null;
	}

	public DebtorResponse saveDebtorTmp(DebtorRequest debtorRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.setSsn(0);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		logger.logDebug("codigo en el metodo save:-debtorRequest.getDebtorCode()" + debtorRequest.getDebtorCode());

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEINSERTDEBTORTEMP, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Creado Cliente Codigo:" + debtorRequest.getDebtorCode());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();

			DebtorResponse debtorTempResponse = (DebtorResponse) serviceItemsResponseTO.getValue((ReturnName.RETURNDEBTORRESPONSE));
			this.setSsn(debtorTempResponse.getSsn());
			return debtorTempResponse;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public EconomicActivityResponse[] readEconomicActivity(EconomicActivityRequest economicActivityRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		// serviceRequestTO.getData().put(RequestName.INECONOMICACTIVITYREQUEST, economicActivityRequest);
		serviceRequestTO.addValue(RequestName.INECONOMICACTIVITYREQUEST, economicActivityRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.READACTIVITYBYCUSTOMER, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Actividad Económica Para Cliente Codigo:" + economicActivityRequest.getCustomerId());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (EconomicActivityResponse[]) serviceItemsResponseTO.getValue((ReturnName.RETURNECONOMICACTIVITYRESPONSE));
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public DataEntityList readEconomicActivityAndMapping(DataEntity dataEntity, ICommonEventArgs arg1, BehaviorOption options) {
		EconomicActivityRequest economicActivityRequest = new EconomicActivityRequest();
		economicActivityRequest.setCustomerId(dataEntity.get(DebtorGeneral.CUSTOMERCODE));

		EconomicActivityResponse[] economicActivityListDTO = this.readEconomicActivity(economicActivityRequest, arg1, options);

		if (economicActivityListDTO != null && economicActivityListDTO.length > 0) {
			DataEntityList economicActivityEntity = new DataEntityList();
			for (EconomicActivityResponse economicActivityDTO : economicActivityListDTO) {
				DataEntity eSourceRevenueCustomer = new DataEntity();
				eSourceRevenueCustomer.set(SourceRevenueCustomer.IDCLIENT, dataEntity.get(DebtorGeneral.CUSTOMERCODE));
				eSourceRevenueCustomer.set(SourceRevenueCustomer.ROL, dataEntity.get(DebtorGeneral.ROLE));
				eSourceRevenueCustomer.set(SourceRevenueCustomer.TYPE, economicActivityDTO.getActivityPrin());
				eSourceRevenueCustomer.set(SourceRevenueCustomer.SECTOR, economicActivityDTO.getSector());
				eSourceRevenueCustomer.set(SourceRevenueCustomer.SUBSECTOR, economicActivityDTO.getSubsector());
				eSourceRevenueCustomer.set(SourceRevenueCustomer.ECONOMICACTIVITY, economicActivityDTO.getActivityEco());
				// eSourceRevenueCustomer.set(SourceRevenueCustomer.CLARIFICATION, economicActivityDTO.getClarification());
				// eSourceRevenueCustomer.set(SourceRevenueCustomer.CLARIFICATION, "Detalle...");
				eSourceRevenueCustomer.set(SourceRevenueCustomer.DETAILCLARIFICATION, economicActivityDTO.getClarification());
				eSourceRevenueCustomer.set(SourceRevenueCustomer.DESCRIPTIONACTIVITY, economicActivityDTO.getDescriptionActivity());
				eSourceRevenueCustomer.set(SourceRevenueCustomer.SUBACTIVITYECONOMIC, economicActivityDTO.getSubactivityEconomic());// subsector de la Actividad
				economicActivityEntity.add(eSourceRevenueCustomer);
			}
			return economicActivityEntity;
		}
		return null;
	}

	public void readEconomicActivity(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		EconomicActivityRequest economicActivityRequest = new EconomicActivityRequest();
		DataEntity headerPunishment = entities.getEntity(HeaderPunishment.ENTITY_NAME);
		economicActivityRequest.setCustomerId(headerPunishment.get(HeaderPunishment.CUSTOMERID));

		EconomicActivityResponse[] economicActivityListDTO = this.readEconomicActivity(economicActivityRequest, arg1, options);

		if (economicActivityListDTO != null && economicActivityListDTO.length > 0) {
			String economicActivity;
			for (EconomicActivityResponse economicActivityDTO : economicActivityListDTO) {
				economicActivity = "" + economicActivityDTO.getActivityPrin();
				logger.logDebug("economicActivity: " + economicActivity);
				if (economicActivity.equals(Mnemonic.TYPECUSTOMERACTIVITY)) {
					headerPunishment.set(HeaderPunishment.CUSTOMERORIGINALACTIVITY, economicActivityDTO.getActivityEco());
				}
			}
		}
	}

	public CustomerResponse readCustomerName(CustomerRequest customerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestCustomerTO = new ServiceRequestTO();
		serviceRequestCustomerTO.addValue(RequestName.INCUSTOMEREQUEST, customerRequest);

		ServiceResponse serviceCustomerResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCUSTOMER, serviceRequestCustomerTO);
		if (serviceCustomerResponse.isResult()) {
			ServiceResponseTO serviceCustomerResponseTO = (ServiceResponseTO) serviceCustomerResponse.getData();
			return (CustomerResponse) serviceCustomerResponseTO.getValue(ReturnName.RETURNCUSTOMERDATA);
		} else {
			MessageManagement.show(serviceCustomerResponse, arg1, options);
		}
		return null;
	}

	// Trae algunos datos del cliente + calificacion
	public DebtorResponse queryCustomerHelp(DebtorRequest debtorRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestDebtorTO = new ServiceRequestTO();

		serviceRequestDebtorTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);

		ServiceResponse serviceCustomerResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCUSTOMERHELP, serviceRequestDebtorTO);
		if (serviceCustomerResponse.isResult()) {
			ServiceResponseTO serviceDebtorResponseTO = (ServiceResponseTO) serviceCustomerResponse.getData();
			return (DebtorResponse) serviceDebtorResponseTO.getValue(ReturnName.RETURNDEBTORRESPONSE);
		} else {
			MessageManagement.show(serviceCustomerResponse, arg1, options);
		}
		return null;
	}

	public DataEntityList getCustomerEntityList(DynamicRequest entities, ICommonEventArgs arg1) {
		// Traer los datos del cliente
		DataEntityList debtorsGeneral = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		Integer customerCode = 0;
		logger.logDebug("---->>Inicio Servicio getCustomerEntityList***");
		for (DataEntity debtorGeneral : debtorsGeneral) {
			customerCode = debtorGeneral.get(DebtorGeneral.CUSTOMERCODE);
		}
		logger.logDebug("---->>getCustomerEntityList-customerCode***" + customerCode);
		if (customerCode > 0) {

			DebtorRequest customerRequest = new DebtorRequest();
			customerRequest.setDebtorCode(customerCode);
			DebtorResponse customerDataResponse = this.queryCustomerHelp(customerRequest, arg1, new BehaviorOption(true));

			if (customerDataResponse != null) {
				logger.logDebug("---->>getCustomerEntityList-customerDataResponse***" + customerDataResponse.getDebtorCode());
				for (DataEntity debtorGeneral : debtorsGeneral) {
					logger.logDebug("---->>getCustomerEntityList-debtorGeneral.get(DebtorGeneral.CUSTOMERCODE)***:" + debtorGeneral.get(DebtorGeneral.CUSTOMERCODE));
					logger.logDebug("---->>getCustomerEntityList-customerCode***" + customerCode);
					if (customerCode.equals(debtorGeneral.get(DebtorGeneral.CUSTOMERCODE))) {
						debtorGeneral.set(DebtorGeneral.IDENTIFICATION, customerDataResponse.getDebtorIdentification());
						debtorGeneral.set(DebtorGeneral.TYPEDOCUMENTID, customerDataResponse.getDebtorIdentificationType().trim());
						// debtorGeneral.set(DebtorGeneral.QUALIFICATION, customerDataResponse.getQualification());
						// debtorGeneral.set(DebtorGeneral.DATECIC, null);
					}
				}
				return debtorsGeneral;
			}
		}
		return null;
	}

	// Opción para grupo -- realizar refactor
	public DataEntityList getCustomerEntityList(DynamicRequest entities, ICommonEventArgs arg1, char opcion) {
		// Traer los datos del cliente
		DataEntityList debtorsGeneral = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		Integer customerCode = 0;
		logger.logDebug("------->>>>AAA - Inicio Servicio getCustomerEntityList con opcion***");
		for (DataEntity debtorGeneral : debtorsGeneral) {
			customerCode = debtorGeneral.get(DebtorGeneral.CUSTOMERCODE);
		}
		logger.logDebug("---->>getCustomerEntityList-customerCode***" + customerCode);
		logger.logDebug("---->>getCustomerEntityList-opcion***" + opcion);
		if (customerCode > 0) {

			DebtorRequest customerRequest = new DebtorRequest();
			customerRequest.setDebtorCode(customerCode);
			customerRequest.setOption(opcion);

			DebtorResponse customerDataResponse = this.queryCustomerHelp(customerRequest, arg1, new BehaviorOption(true));

			if (customerDataResponse != null) {
				logger.logDebug("---->>getCustomerEntityList-customerDataResponse***" + customerDataResponse.getDebtorCode());
				for (DataEntity debtorGeneral : debtorsGeneral) {
					logger.logDebug("---->>getCustomerEntityList-debtorGeneral.get(DebtorGeneral.CUSTOMERCODE)***:" + debtorGeneral.get(DebtorGeneral.CUSTOMERCODE));
					logger.logDebug("---->>getCustomerEntityList-customerCode***" + customerCode);
					if (customerCode.equals(debtorGeneral.get(DebtorGeneral.CUSTOMERCODE))) {
						debtorGeneral.set(DebtorGeneral.IDENTIFICATION, customerDataResponse.getDebtorIdentification());
						debtorGeneral.set(DebtorGeneral.TYPEDOCUMENTID, customerDataResponse.getDebtorIdentificationType().trim());
						// debtorGeneral.set(DebtorGeneral.QUALIFICATION, customerDataResponse.getQualification());
						// debtorGeneral.set(DebtorGeneral.DATECIC, null);
					}
				}
				return debtorsGeneral;
			}
		}
		return null;
	}

	public DataEntity getDebtor(DebtorResponse debtorResponse) {
		if (debtorResponse != null) {
			DataEntity eDebtor = new DataEntity();
			eDebtor.set(DebtorGeneral.CUSTOMERCODE, debtorResponse.getDebtorCode());
			eDebtor.set(DebtorGeneral.ROLE, debtorResponse.getRole());
			eDebtor.set(DebtorGeneral.IDENTIFICATION, debtorResponse.getDebtorIdentification());
			eDebtor.set(DebtorGeneral.CUSTOMERNAME, debtorResponse.getDebtorName());
			eDebtor.set(DebtorGeneral.TYPEDOCUMENTID, debtorResponse.getDebtorIdentificationType().trim());
			// eDebtor.set(DebtorGeneral.QUALIFICATION, debtorResponse.getQualification());
			// eDebtor.set(DebtorGeneral.DATECIC, (debtorResponse.getDateCIC() != null) ? debtorResponse.getDateCIC().getTime() : null);
			return eDebtor;
		}
		return null;
	}

	public AddressResponse[] getAddressCode(int idDebtor, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("Inicio Servicio getAddressCode");
		ServiceRequestTO serviceRequestAddressTO = null;
		ServiceResponse serviceAddressResponse = null;
		serviceRequestAddressTO = new ServiceRequestTO();
		AddressRequest addressRequest = new AddressRequest();
		AddressResponseList addressResponseList = new AddressResponseList();
		addressRequest.setCustomerId(idDebtor);
		serviceRequestAddressTO.addValue(RequestName.INADDRESSREQUEST, addressRequest);
		serviceRequestAddressTO.addValue(ReturnName.OUTADDRESSRESPONSELIST, addressResponseList);

		serviceAddressResponse = execute(getServiceIntegration(), logger, ServiceId.READADDRESSCODE, serviceRequestAddressTO);

		if (serviceAddressResponse.isResult()) {
			logger.logDebug("Servicio getAddressCode ok ");
			ServiceResponseTO serviceAddresResponseTO = (ServiceResponseTO) serviceAddressResponse.getData();
			AddressResponse[] addressResponses = (AddressResponse[]) serviceAddresResponseTO.getValue(ReturnName.RETURNADDRESSRESPONSE);
			return addressResponses;
		} else {
			logger.logDebug("Servicio getAddressCode no ok ");
			MessageManagement.show(serviceAddressResponse, arg1, options);
		}
		return null;
	}

	public AddressResponse getAddress(int debtorId, int addressID, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("Inicio Servicio getAddress");
		ServiceRequestTO serviceRequestAddressValidateTO = null;
		ServiceResponse serviceAddressValidateResponse = null;
		serviceRequestAddressValidateTO = new ServiceRequestTO();

		AddressRequest addressValidateRequest = new AddressRequest();
		AddressResponse addressValidateResponseList = new AddressResponse();
		addressValidateRequest.setCustomerId(debtorId);
		addressValidateRequest.setAddress(addressID);

		addressValidateRequest.setFormatDate(SessionContext.getFormatDate());
		serviceRequestAddressValidateTO.addValue(RequestName.INADDRESSREQUEST, addressValidateRequest);
		serviceRequestAddressValidateTO.addValue(ReturnName.OUTADDRESSRESPONSE, addressValidateResponseList);
		serviceAddressValidateResponse = execute(getServiceIntegration(), logger, ServiceId.READADDRESS, serviceRequestAddressValidateTO);

		if (serviceAddressValidateResponse.isResult()) {
			logger.logDebug("Servicio getAddress ok ");
			ServiceResponseTO serviceAddresValidateResponseTO = (ServiceResponseTO) serviceAddressValidateResponse.getData();
			AddressResponse addressRes = (AddressResponse) serviceAddresValidateResponseTO.getValue(ReturnName.RETURNADDRESSRESPONSE);
			return addressRes;
		} else {
			logger.logDebug("Servicio getAddress no ok ");
			MessageManagement.show(serviceAddressValidateResponse, arg1, options);
		}
		return null;
	}

	public boolean saveAllDebtorsTmp(Integer requestId, DynamicRequest entities, ICommonEventArgs args, BehaviorOption options) {
		this.ssn = 0;
		int ssnTmp = 0;
		boolean resp = true;
		DataEntityList debtors = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
	
		// Lista de Deudores
		for (DataEntity dataEntity : debtors) {
			DebtorRequest debtor = new DebtorRequest();
			debtor.setDebtorCode(dataEntity.get(DebtorGeneral.CUSTOMERCODE));
			debtor.setRole(dataEntity.get(DebtorGeneral.ROLE));
			debtor.setDebtorIdentification(dataEntity.get(DebtorGeneral.IDENTIFICATION));
			logger.logDebug("--->saveAllDebtorsTmp:getDebtorCode---> " + debtor.getDebtorCode());

			if (requestId != null) {
				debtor.setApplicationCode(requestId);
			}
			/*
			 * if (dataEntity.get(DebtorGeneral.DATECIC) != null) { debtor.setDateCIC(Convert.CDate.toCalendar(dataEntity.get(DebtorGeneral.DATECIC))); }
			 */
			if (ssnTmp != 0) {
				debtor.setSsn(ssnTmp);
			}
			DebtorResponse debtorResponseDTO = this.saveDebtorTmp(debtor, args, options);
			if (debtorResponseDTO != null) {
				ssnTmp = debtorResponseDTO.getSsn();
			} else {
				resp = false;
			}
		}
		this.ssn = ssnTmp;
		return resp;
	}

	public boolean deleteDebtors(int requestId, int idDebtor, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("Inicio servicio deleteDebtors");
		logger.logDebug("codigo en el metodo save:-idDebtor:" + idDebtor);
		logger.logDebug("codigo en el metodo save:-requestId:" + requestId);

		DebtorRequest debtorRequest = new DebtorRequest();
		debtorRequest.setApplicationCode(requestId);
		debtorRequest.setDebtorCode(idDebtor);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INDEBTORREQUEST, debtorRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICE_DELETE_DEBTOR, serviceRequestTO);

		if (serviceResponse.isResult()) {
			logger.logDebug("servicio deleteDebtors ok");
			return true;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	/* Para traer todas las actividades de los clientes de un tramite */
	public List<EconomicActivityResponse> dataDebtorsActivityItemDTO(DataEntityList debtors, IDataEventArgs arg1) {

		EconomicActivityRequest economicActivityRequest = new EconomicActivityRequest();
		List<EconomicActivityResponse> economicActivityList = new ArrayList<EconomicActivityResponse>();
		List<EconomicActivityResponse> economicActivityListAux = new ArrayList<EconomicActivityResponse>();

		for (DataEntity debtorEntity : debtors) {
			economicActivityRequest.setCustomerId(debtorEntity.get(DebtorGeneral.CUSTOMERCODE));
			EconomicActivityResponse[] economicActivityResponse = this.readEconomicActivity(economicActivityRequest, arg1, new BehaviorOption());

			if (economicActivityResponse != null) {
				for (EconomicActivityResponse economicActivityRequest1 : economicActivityResponse) {
					economicActivityList.add(economicActivityRequest1);
				}
			}
		}
		economicActivityListAux = this.eliminarDuplicados(economicActivityList);
		return economicActivityListAux;
	}

	public List<EconomicActivityResponse> eliminarDuplicados(List<EconomicActivityResponse> list) {
		List<EconomicActivityResponse> economicActivityResponse = new ArrayList<EconomicActivityResponse>();
		for (int i = 0; i < list.size(); i++) {
			String code = list.get(i).getActivityEco().trim();
			boolean add = true;
			for (int j = 0; j < economicActivityResponse.size(); j++) {
				EconomicActivityResponse itemDTO2 = economicActivityResponse.get(j);
				if (code.equals(itemDTO2.getActivityEco().trim())) {
					add = false;
				}
			}
			if (add) {
				economicActivityResponse.add(list.get(i));
			}
		}
		return economicActivityResponse;
	}

}