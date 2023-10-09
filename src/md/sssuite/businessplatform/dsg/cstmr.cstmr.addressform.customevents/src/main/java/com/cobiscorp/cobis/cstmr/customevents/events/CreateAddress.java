package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.CatalogManagement;
import com.cobiscorp.cobis.cstmr.commons.services.LocationService;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.OfficeManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;
import com.cobiscorp.ecobis.customer.commons.prospect.services.GeoLocationManager;

public class CreateAddress extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(CreateAddress.class);
	private static String countryGeo = null;
	private static int showError = 0;

	public CreateAddress(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			DataEntity requestEntity = entities.getEntity(PhysicalAddress.ENTITY_NAME);
			int customerId = requestEntity.get(PhysicalAddress.PERSONSECUENTIAL);
			AddressRequest addressRequest = new AddressRequest();
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			/* Se valida pais seleccionado */
			// Obtención de parámetros
			ParameterResponse paramDto = catalogManagement.getParameter(4, "CP", "ADM", args, new BehaviorOption(false, false));
			int countryId = Integer.parseInt(paramDto.getParameterValue());
			ParameterResponse paramFilialDto = catalogManagement.getParameter(4, "FILSAN", "CRE", args, new BehaviorOption(false, false));
			int filialId = Integer.parseInt(paramFilialDto.getParameterValue());
			ParameterResponse paramGeoDto = catalogManagement.getParameter(4, "PAISGE", "CLI", args, new BehaviorOption(false, false));
			countryGeo = paramGeoDto.getParameterValue().toString();
			ParameterResponse paramDisDto = catalogManagement.getParameter(4, "DISGEO", "CLI", args, new BehaviorOption(false, false));
			double minDistance = Integer.parseInt(paramDisDto.getParameterValue());
			minDistance = minDistance / 1000; // convertir de metros a kilometros
			ParameterResponse paramMaxDto = catalogManagement.getParameter(4, "RADGEO", "CLI", args, new BehaviorOption(false, false));
			int maxDistance = Integer.parseInt(paramMaxDto.getParameterValue());
			/* URL Parametros */
			ParameterResponse paramUrlDto = catalogManagement.getParameter(4, "URLGEO", "CLI", args, new BehaviorOption(false, false));
			String urlParam = paramUrlDto.getParameterValue().toString();
			ParameterResponse paramPuertoDto = catalogManagement.getParameter(4, "PRTGEO", "CLI", args, new BehaviorOption(false, false));
			int puertoParam = Integer.parseInt(paramPuertoDto.getParameterValue());
			ParameterResponse paramServicioDto = catalogManagement.getParameter(4, "SERGEO", "CLI", args, new BehaviorOption(false, false));
			String servicioParam = paramServicioDto.getParameterValue().toString();
			//Url del servicio
			String urlComplete = urlParam + puertoParam + servicioParam; 
			if (countryId != requestEntity.get(PhysicalAddress.COUNTRYCODE)) {
				showError = 1;
				throw new BusinessException(1, ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_PAISDIR);
			}
			double lat = requestEntity.get(PhysicalAddress.LATITUDE);
			double lon = requestEntity.get(PhysicalAddress.LONGITUDE);
			if (!LocationService.isInsideCountry(urlComplete, lat, lon, countryGeo)) {
				showError = 2;
				throw new BusinessException(1, ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_PAISGEO);
			}
			/* obtener geo de oficina */
			OfficeManagement officeManager = new OfficeManagement(getServiceIntegration());
			OfficeGeoRequest officeGeoRequest = new OfficeGeoRequest();
			officeGeoRequest.setFilialId(filialId);
			officeGeoRequest.setOfficerLogin(SessionUtil.getUser());
			OfficeGeoResponse officeGeo = officeManager.searchOfficeGeo(officeGeoRequest, args);
			if (officeGeo == null) {
				showError = 3;
				throw new BusinessException(1, ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_OFFICE);
			}
			double officeLat = officeGeo.getLatitude().doubleValue();
			double officeLon = officeGeo.getLongitude().doubleValue();

			/* Validación de radio*/
			double distanceClient = LocationService.getDistance(officeLat, officeLon, lat, lon);
			if (distanceClient < minDistance) {
				showError = 4;
				throw new BusinessException(1, ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_GEODIS);
			}
			if (distanceClient > maxDistance){
				showError = 5;
				throw new BusinessException(1, ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_GEORAD);
			}
			
			addressRequest.setAddressDesc(requestEntity.get(PhysicalAddress.ADDRESSDESCRIPTION));
			LOGGER.logDebug("AddressDescription>>" + addressRequest.getAddressDesc());
			addressRequest.setAddressType(requestEntity.get(PhysicalAddress.ADDRESSTYPE));
			addressRequest.setCityCode(requestEntity.get(PhysicalAddress.CITYCODE));
			addressRequest.setCountyCode(requestEntity.get(PhysicalAddress.COUNTRYCODE));
			addressRequest.setNeighborhood(requestEntity.get(PhysicalAddress.NEIGHBORHOOD));
			if (requestEntity.get(PhysicalAddress.PARISHCODE) != null) {
				addressRequest.setParishCode(requestEntity.get(PhysicalAddress.PARISHCODE));
			}
			addressRequest.setProvinceCode(requestEntity.get(PhysicalAddress.PROVINCECODE));
			addressRequest.setStreet(requestEntity.get(PhysicalAddress.STREET));
			addressRequest.setCustomerId(requestEntity.get(PhysicalAddress.PERSONSECUENTIAL));

			addressRequest.setPrincipal(requestEntity.get(PhysicalAddress.ISMAINADDRESS) == true ? "S" : "N");
			addressRequest.setIsShippingAddress(requestEntity.get(PhysicalAddress.ISSHIPPINGADDRESS) == true ? "S" : "N");

			addressRequest.setUrbanType(requestEntity.get(PhysicalAddress.URBANTYPE));
			addressRequest.setNeigborhoodCode(requestEntity.get(PhysicalAddress.NEIGHBORHOODCODE));
			addressRequest.setDepartment(requestEntity.get(PhysicalAddress.DEPARTMENT));
			addressRequest.setOwnershipType(requestEntity.get(PhysicalAddress.OWNERSHIPTYPE));
			addressRequest.setReference(requestEntity.get(PhysicalAddress.REFERENCE));
			LOGGER.logDebug("URBAN TYPE>>" + addressRequest.getUrbanType());
			LOGGER.logDebug("NEIGHBOR CODE>>" + addressRequest.getNeigborhoodCode());
			LOGGER.logDebug("DEPARTMENT >>" + addressRequest.getDepartment());
			LOGGER.logDebug("OWNERSHIP >>" + addressRequest.getOwnershipType());

			LOGGER.logDebug("Llega DIRECTIONNUMBER>>" + requestEntity.get(PhysicalAddress.DIRECTIONNUMBER));
			if (requestEntity.get(PhysicalAddress.DIRECTIONNUMBER) != null) {
				addressRequest.setDirectionNumber(requestEntity.get(PhysicalAddress.DIRECTIONNUMBER));
				LOGGER.logDebug("Se guarda getDirectionNumber>>" + addressRequest.getDirectionNumber());
			}

			LOGGER.logDebug("Llega DIRECTIONNUMBERINTERNAL>>" + requestEntity.get(PhysicalAddress.DIRECTIONNUMBERINTERNAL));
			if (requestEntity.get(PhysicalAddress.DIRECTIONNUMBERINTERNAL) != null) {
				addressRequest.setDirectionNumberInternal(requestEntity.get(PhysicalAddress.DIRECTIONNUMBERINTERNAL));
				LOGGER.logDebug("Se guarda getDirectionNumberInternal>>" + addressRequest.getDirectionNumberInternal());
			}

			LOGGER.logDebug("Llega POSTALCODE>>" + requestEntity.get(PhysicalAddress.POSTALCODE));
			addressRequest.setPostalCode(requestEntity.get(PhysicalAddress.POSTALCODE));
			LOGGER.logDebug("Se guarda getPostalCode>>" + addressRequest.getPostalCode());

			LOGGER.logDebug("Llega NUMBEROFRESIDENTS>>" + requestEntity.get(PhysicalAddress.NUMBEROFRESIDENTS));
			if (requestEntity.get(PhysicalAddress.NUMBEROFRESIDENTS) != null) {
				addressRequest.setNumberOfResidents(requestEntity.get(PhysicalAddress.NUMBEROFRESIDENTS));
				LOGGER.logDebug("Se guarda getDirectionNumber>>" + addressRequest.getNumberOfResidents());
			}
			LOGGER.logDebug("ciudad Poblacion>>");
			LOGGER.logDebug("ciudad Poblacion" + requestEntity.get(PhysicalAddress.CITYPOBLATION));
			if (requestEntity.get(PhysicalAddress.CITYPOBLATION) != null) {
				addressRequest.setCityPoblation(requestEntity.get(PhysicalAddress.CITYPOBLATION));
				LOGGER.logDebug("Se guarda ciudad Poblacion>>" + addressRequest.getCityPoblation());
			}

			LOGGER.logDebug("Antes de BUSINESSCODE>>");
			LOGGER.logDebug("Llega BUSINESSCODE>>" + (Integer) requestEntity.get(PhysicalAddress.BUSINESSCODE));
			if (requestEntity.get(PhysicalAddress.BUSINESSCODE) != null) {
				addressRequest.setBusinessCode((Integer) requestEntity.get(PhysicalAddress.BUSINESSCODE));
				LOGGER.logDebug("Se guarda getBusinessCode>>" + addressRequest.getBusinessCode());
			}

			/*** Santander ***/
			if (requestEntity.get(PhysicalAddress.RESIDENCETIME) != null) {
				addressRequest.setResidenceTyme(requestEntity.get(PhysicalAddress.RESIDENCETIME));
			}
			AddressManager addressManager = new AddressManager(getServiceIntegration());
			GeoLocationManager geoManager = new GeoLocationManager(getServiceIntegration());

			Integer actualAddressId = requestEntity.get(PhysicalAddress.ADDRESSID);
			GeoreferencingRequest geoRequest = new GeoreferencingRequest();
			if (actualAddressId == 0) {

				// Se crea duplicado para direccion de negocio
				if (((requestEntity.get(PhysicalAddress.ADDRESSTYPE)).equals("RE")) && (requestEntity.get(PhysicalAddress.BUSINESSCODE) != null)) {

					addressRequest.setAddressType("AE");

					int addressCode = addressManager.createAddress(addressRequest, args);
					requestEntity.set(PhysicalAddress.ADDRESSID, addressCode);
					if (addressCode != -1) {
						geoRequest.setAddressId(addressCode);
						geoRequest.setCustomerId(customerId);
						geoRequest.setLatitudeSeg(requestEntity.get(PhysicalAddress.LATITUDE));
						geoRequest.setLongitudSeg(requestEntity.get(PhysicalAddress.LONGITUDE));
						geoManager.createUpdateGeoLocation(geoRequest, args);
					}
					addressRequest.setAddressType("RE");
					addressRequest.setBusinessCode(0);
				}

				int addressCode = addressManager.createAddress(addressRequest, args);
				requestEntity.set(PhysicalAddress.ADDRESSID, addressCode);
				if (addressCode != -1) {
					geoRequest.setAddressId(addressCode);
					geoRequest.setCustomerId(customerId);
					geoRequest.setLatitudeSeg(requestEntity.get(PhysicalAddress.LATITUDE));
					geoRequest.setLongitudSeg(requestEntity.get(PhysicalAddress.LONGITUDE));
					geoManager.createUpdateGeoLocation(geoRequest, args);
				}
			} else {
				addressRequest.setAddress(actualAddressId);
				addressManager.updateAddress(addressRequest, args);
				if (args.isSuccess()) {
					geoRequest.setAddressId(requestEntity.get(PhysicalAddress.ADDRESSID));
					geoRequest.setCustomerId(customerId);
					geoRequest.setLatitudeSeg(requestEntity.get(PhysicalAddress.LATITUDE));
					geoRequest.setLongitudSeg(requestEntity.get(PhysicalAddress.LONGITUDE));
					geoManager.createUpdateGeoLocation(geoRequest, args);
				}
			}
		} catch (BusinessException e) {
			if (showError == 1)
				ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_PAISDIR, e, args, LOGGER);
			if (showError == 2)
				ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_PAISGEO, e, args, LOGGER);
			if (showError == 3)
				ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_OFFICE, e, args, LOGGER);
			if (showError == 4)
				ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_GEODIS, e, args, LOGGER);
			if (showError == 5)
				ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS_GEORAD, e, args, LOGGER);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ADDRESS, e, args, LOGGER);
		}
	}

}
