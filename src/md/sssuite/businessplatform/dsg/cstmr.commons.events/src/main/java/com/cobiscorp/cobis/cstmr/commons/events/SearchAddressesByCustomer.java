package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.CustomerTmp;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.cobis.cstmr.model.VirtualAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;

public class SearchAddressesByCustomer extends BaseEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(SearchAddressesByCustomer.class);

	public SearchAddressesByCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void searchAddressesByCustomer(DynamicRequest entities,
			ICommonEventArgs args) {

		LOGGER.logDebug("Start searchAddressesByCustomer in SearchAddressesByCustomer");
		ParameterManager parameterManagement = new ParameterManager(
				getServiceIntegration());
		ParameterResponse parameterDto;
		try {
			parameterDto = parameterManagement.getParameter(4, "FDVD", "CLI",
					args);
			DataEntity customerTmp = entities.getEntity(CustomerTmp.ENTITY_NAME);
			DataEntity debGenral = entities.getEntity(DebtorGeneral.ENTITY_NAME);
			int customerId  = 0;
			if(customerTmp!= null) {
				customerId =  customerTmp.get(CustomerTmp.CODE);
			}else if(debGenral!=null){
				customerId = debGenral.get(DebtorGeneral.CUSTOMERCODE) ;
			}
			if(customerId == 0) {
				throw new IllegalStateException("El customerId No puede ser 0");
			}
			
			LOGGER.logDebug("customerId ---" + customerId);
			AddressRequest request = new AddressRequest();
			request.setCustomerId(customerId);
			AddressManager addresssManager = new AddressManager(
					getServiceIntegration());
			AddressResp[] addresses = addresssManager.searchAddresses(request,
					args);
			//DataEntityList physicalAddressList = entities.getEntityList(PhysicalAddress.ENTITY_NAME);
			//DataEntityList virtualAddressList = entities.getEntityList(VirtualAddress.ENTITY_NAME);
			DataEntityList physicalAddressList= new DataEntityList();
			DataEntityList virtualAddressList= new DataEntityList();
			
			int contadorDirecciones = 0;
			boolean isEmptyReference = false;

			LOGGER.logDebug("addresses ---" + addresses);
			for (AddressResp resp : addresses) {
				DataEntity addressEntity = new DataEntity();
				addressEntity.set(PhysicalAddress.ADDRESSID, resp.getAddress());
				addressEntity.set(PhysicalAddress.ADDRESSDESCRIPTION,
						resp.getAddressDesc());
				addressEntity.set(PhysicalAddress.ADDRESSTYPE,
						resp.getAddressType());
				addressEntity.set(PhysicalAddress.PERSONSECUENTIAL, customerId);
				// validación para las direcciones
				LOGGER.logError("--->>resp.getMonthsInForce()"
						+ resp.getMonthsInForce());
				int valorCompara = 0;
				if (parameterDto != null) {
					valorCompara = Integer.parseInt(parameterDto
							.getParameterValue());
					LOGGER.logDebug("----->>>Valor getParameterValue: "
							+ parameterDto.getParameterValue());
					if (resp.getMonthsInForce() > valorCompara) {
						contadorDirecciones++;

					}
				} else {
					// LBL_LOANS_PARMETRRN_32839: Voluntary Savings Parameter
					// Does Not Exist
					LOGGER.logError("----->>>No hay informacion para el parametro-FDVD");
					addressEntity.set(PhysicalAddress.MONTHSINFORCE, 0);
				}
				
				if(resp.getReference() == null) {
					isEmptyReference = true;
				}
				
				if (resp.getAddressType() != null
						&& !resp.getAddressType().equals("CE")) {

					addressEntity.set(PhysicalAddress.ADDRESSTYPEDESCRIPTION,
							resp.getTypeDescription());
					addressEntity.set(PhysicalAddress.CITYCODE,
							resp.getCityCode());
					addressEntity.set(PhysicalAddress.CITYDESCRIPTION,
							resp.getCityDescription());
					addressEntity.set(PhysicalAddress.COUNTRYCODE,
							resp.getCountyCode());
					addressEntity.set(PhysicalAddress.COUNTRYDESCRIPTION,
							resp.getCountryDescription());
					LOGGER.logDebug("paiss---->" + resp.getCountryDescription());
					// TODO: modify SP y SG
					addressEntity.set(PhysicalAddress.DEPARTMENT,
							resp.getDepartment());
					addressEntity.set(PhysicalAddress.ISMAINADDRESS,
							("S".equals(resp.getPrincipal()) ? true : false));
					addressEntity.set(PhysicalAddress.ISSHIPPINGADDRESS,
							("S".equals(resp.getIsShippingAddress()) ? true
									: false));
					// TODO: modify SP y SG
					if (resp.getLatitude() != null) {
						addressEntity.set(PhysicalAddress.LATITUDE, resp
								.getLatitude().doubleValue());
					}
					if (resp.getLongitude() != null) {
						addressEntity.set(PhysicalAddress.LONGITUDE, resp
								.getLongitude().doubleValue());
					}
					addressEntity.set(PhysicalAddress.NEIGHBORHOOD,
							resp.getNeighborhood());
					// TODO: modify SP y SG
					addressEntity.set(PhysicalAddress.NEIGHBORHOODCODE,
							resp.getNeigborhoodCode());
					LOGGER.logDebug("--->>>:resp.getNeigborhoodCode--"
							+ resp.getNeigborhoodCode() + "--");

					addressEntity.set(PhysicalAddress.DIRECTIONNUMBER,
							resp.getDirectionNumber());
					LOGGER.logDebug("Direccion--->>>:resp.getDirectionNumber()--"
							+ resp.getDirectionNumber() + "--");

					addressEntity.set(PhysicalAddress.POSTALCODE,
							resp.getPostalCode());
					LOGGER.logDebug("Direccion--->>>:resp.getPostalCode()--"
							+ resp.getPostalCode() + "--");

					addressEntity.set(PhysicalAddress.NUMBEROFRESIDENTS,
							resp.getNumberOfResidents());

					LOGGER.logDebug("Direccion--->>>:resp.getNumberOfResidents()--"
							+ resp.getNumberOfResidents() + "--");
					addressEntity.set(PhysicalAddress.DIRECTIONNUMBERINTERNAL,
							resp.getDirectionNumberInternal());
					LOGGER.logDebug("Direccion--->>>:resp.getDirectionNumberInternal()--"
							+ resp.getDirectionNumberInternal() + "--");

					addressEntity.set(PhysicalAddress.DIRECTIONNUMBERINTERNAL,
							resp.getDirectionNumberInternal());
					LOGGER.logDebug("Direccion--->>>:resp.getDirectionNumberInternal()--"
							+ resp.getDirectionNumberInternal() + "--");

					// TODO: modify SP y SG
					addressEntity.set(PhysicalAddress.OWNERSHIPTYPE,
							resp.getOwnershipType());
					addressEntity.set(PhysicalAddress.PARISHCODE,
							resp.getParishCode());
					addressEntity.set(PhysicalAddress.PARISHDESCRIPTION,
							resp.getParishDescription());
					addressEntity.set(PhysicalAddress.PROVINCECODE,
							resp.getProvinceCode());
					addressEntity.set(PhysicalAddress.PROVINCEDESCRIPTION,
							resp.getProvinceDescription());
					// TODO: modify SP y SG
					addressEntity.set(PhysicalAddress.STREET, resp.getStreet());
					addressEntity.set(PhysicalAddress.URBANTYPE,
							resp.getUrbanType());
					addressEntity.set(PhysicalAddress.RESIDENCETIME,
							resp.getResidenceTime());
					//Negocio
					addressEntity.set(PhysicalAddress.BUSINESSCODE,
							resp.getBusinessCode());
					LOGGER.logDebug("Direccion--->>>: resp.getBusinessCode()--"
							+ resp.getBusinessCode() + "--");
					//CIUDAD POBLACION
					addressEntity.set(PhysicalAddress.CITYPOBLATION,
							resp.getCityPoblation().trim());
					LOGGER.logDebug("CITYPOBLATION--->>>:"
							+ resp.getCityPoblation().trim() + "--");
					//REFERENCE
					addressEntity.set(PhysicalAddress.REFERENCE, resp.getReference());
					LOGGER.logDebug("REFERENCE --->>>: "+resp.getReference());					
					
					physicalAddressList.add(addressEntity);
					
				} else {
					//VERIFICACION
					if(resp.getVerification() != null)
					    addressEntity.set(VirtualAddress.ISCHECKED, resp.getVerification());
					else 
						addressEntity.set(VirtualAddress.ISCHECKED, "N");
					LOGGER.logDebug("VERIFICACION --->>>: " + resp.getReference());
					
					virtualAddressList.add(addressEntity);
				}
			}

			if (contadorDirecciones > 0) {
				LOGGER.logDebug("contadorDirecciones>>" + contadorDirecciones);
				args.getMessageManager()
						.showInfoMsg(
								"Información No Vigente, por favor actualizar direcciones del cliente");
			}
			if(isEmptyReference) {
				args.getMessageManager()
				.showInfoMsg(
						"Es necesario actualizar el campo REFERENCIA en la sección de direcciones");
			}

			LOGGER.logDebug("virtualAddressList>>" + virtualAddressList.size());
			LOGGER.logDebug("physicalAddressList>>"
					+ physicalAddressList.size());

			entities.setEntityList(PhysicalAddress.ENTITY_NAME,
					physicalAddressList);
			entities.setEntityList(VirtualAddress.ENTITY_NAME,
					virtualAddressList);
		} catch (Exception e) {
			LOGGER.logError("Error al buscar las direcciones del cliente",e);
		}

	}

}
