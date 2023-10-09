package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createEmptyServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.ProspectService;
import com.cobiscorp.ecobis.cloud.service.dto.address.AddressResult;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerResult;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.Prospect;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectAddress;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectClient;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectCreateResponse;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectData;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectDataResponse;
import com.cobiscorp.ecobis.cloud.service.integration.AddressIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.LocationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficeIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

@Path("/cobis-cloud/mobile/prospect")
@Component
@Service({ ProspectService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class ProspectRestService implements ProspectService {

	private final ILogger logger = LogFactory.getLogger(ProspectRestService.class);
	private CustomerIntegrationService customerService;
	private AddressIntegrationService addressService;
	private OfficeIntegrationService officeService;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)", cardinality = ReferenceCardinality.MANDATORY_UNARY, policy = ReferencePolicy.DYNAMIC)
	private ICobisParameter parameterService;

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}

	@Path("/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readProspect(@PathParam("id") int customerId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/prospect/readProspect customerId>>" + customerId);

			// query customer
			Prospect prospect = Prospect.fromResponse(customerService.searchCustomer(customerId), customerId);
			if (prospect == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}

			// Query address
			AddressResp addressResponse = addressService.findPrincipalAddress(customerId);
			ProspectAddress address = ProspectAddress.fromResponse(addressResponse, customerId);

			return successResponse(new ProspectData(prospect, address, GeoReference.fromResponse(addressResponse)), "/cobis-cloud/mobile/prospect/readProspect");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/prospect/readProspect  Error al consultar prospecto", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/prospect/readProspect  Error al consultar prospecto", e);
			return errorResponse("/cobis-cloud/mobile/prospect/readProspect Error al consultar prospecto");
		}
	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createProspect(ProspectDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/prospect/createProspect Request>>" + objectToJson(data));
			// Create the response object
			ProspectDataResponse serviceResponse = new ProspectDataResponse();
			CustomerResult customer = null;

			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					serviceResponse.setProspect(geoResult);
					return successResponse(serviceResponse, false, "/cobis-cloud/mobile/prospect/createProspect");
				}
			}
			int customerId = 0;
			customerService.setParameterService(parameterService);
			// Create prospect
			if (data.getProspect().getCustomerId() == 0) {

				try {
					data.getProspect().setCheckRenapo(data.getProspect().getCheckRenapo() == null ? "N" : data.getProspect().getCheckRenapo());
					customer = customerService.createProspect(data.getProspect().toProspectRequest());
					serviceResponse.setProspectResult(customer);
					if (data.getAddress() != null) { // update the customer id
														// for the address
						data.getAddress().setCustomerId(customer.getCustomerId());
						customerId = customer.getCustomerId();
					}
				} catch (IntegrationException ie) {
					logger.logError("/cobis-cloud/mobile/prospect/createProspect Error al crear el prospecto", ie);
					serviceResponse.setProspect(ie.getResponse());
					return successResponse(serviceResponse, false, "/cobis-cloud/mobile/prospect/createProspect");
				}

				int addressId = 0;
				// Create Address
				if (data.getAddress().getCustomerId() != 0 && data.getAddress().getAddressId() == 0) {
					try {
						AddressResult result = addressService.createAddress(data.getAddress().toRequest());
						serviceResponse.setAddressResult(result);
						addressId = result.getAddressId();
					} catch (IntegrationException ie) {
						logger.logError("/cobis-cloud/mobile/prospect/createProspect Error al crear la dirección", ie);
						serviceResponse.setAddress(ie.getResponse());
						return successResponse(serviceResponse, false, "/cobis-cloud/mobile/prospect/createProspect");
					}
				}

				if (data.getGeoReference() != null) {
					try {
						if (addressId == 0) {
							addressId = data.getGeoReference().getAddressId();
						}
						addressService.createGeoReference(data.getGeoReference().toRequest(customerId, addressId));
						serviceResponse.setGeoReference(createEmptyServiceResponse());
					} catch (IntegrationException ie) {
						logger.logError("/cobis-cloud/mobile/prospect/createProspect Error al crear los puntos geográficos", ie);
						serviceResponse.setGeoReference(ie.getResponse());
						return successResponse(serviceResponse, false, "/cobis-cloud/mobile/prospect/createProspect");
					}
				}

			}
			return successResponse(serviceResponse, "/cobis-cloud/mobile/prospect/createProspect");
		} catch (IntegrationException ie) {
			logger.logError("Error al crear prospecto", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/prospect/createProspect  Error al crear prospecto", e);
			return errorResponse("Error al crear prospecto");
		}
	}

	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateProspect(ProspectDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/prospect/updateProspect Request>>" + objectToJson(data));
			// Create the response object
			ProspectDataResponse serviceResponse = new ProspectDataResponse();
			CustomerResult customer = null;
			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					serviceResponse.setProspect(geoResult);
					return successResponse(serviceResponse, false, "/cobis-cloud/mobile/prospect/updateProspect");
				}
			}
			// Update prospect
			customerService.setParameterService(parameterService);
			if (data.getProspect().getCustomerId() != 0) {
				// update data prospect
				try {
					CustomerTotalRequest request = data.getProspect().toRequest();
					// Avoid to lose the nationality

					CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
					customerTotalRequest.setCodePerson(data.getProspect().getCustomerId());
					customerTotalRequest.setName(data.getProspect().getFirstName());
					customerTotalRequest.setSecondName(data.getProspect().getSecondName());
					customerTotalRequest.setFirstSurname(data.getProspect().getSurname());
					customerTotalRequest.setSecondSurname(data.getProspect().getSecondSurname());
					customerTotalRequest.setGender(data.getProspect().getGender() == null ? null : data.getProspect().getGender().charAt(0));
					customerTotalRequest.setBioIdentificationType(data.getProspect().getBioIdentificationType());
					customerTotalRequest.setBioCIC(data.getProspect().getBioCIC());
					customerTotalRequest.setBioEmissionNumber(data.getProspect().getBioEmissionNumber());
					customerTotalRequest.setBioHasFingerprinter(data.getProspect().getBioHasFingerprint());
					customerTotalRequest.setBioOCR(data.getProspect().getBioOCR());
					customerTotalRequest.setBioReaderKey(data.getProspect().getBioReaderKey());
					customerTotalRequest.setCollective(data.getProspect().getCollective());
					customerTotalRequest.setCollectiveLevel(data.getProspect().getCollectiveClientLevel());
					if (data.getProspect().getBirthDate() != null) {
						try {
							Calendar calendar = Calendar.getInstance();
							Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data.getProspect().getBirthDate());
							calendar.setTime(date);
							customerTotalRequest.setBirthDate(calendar);
						} catch (Exception e) {
							logger.logError("ParseException:::", e);
							return errorResponse("Error al transfromar Fecha de Nacimiento");
						}
					}
					customerTotalRequest.setCountyOfBirth(data.getProspect().getCityBirth());
					customerTotalRequest.setMode(0);
					customer = customerService.updateCustomerRenapo(customerTotalRequest);
					if (customer != null) {
						serviceResponse.setProspectResult(customer);
					} else {
						return errorResponse("Error al actualizar el prospecto");
					}

				} catch (IntegrationException ie) {
					serviceResponse.setProspect(ie.getResponse());
				}
			}
			// Update Address
			if (data.getAddress().getCustomerId() != 0 && data.getAddress().getAddressId() != 0) {
				try {
					addressService.updateAddress(data.getAddress().toRequest());
					serviceResponse.setAddress(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					serviceResponse.setProspect(ie.getResponse());
				}

				try {
					if (data.getGeoReference() != null) {
						addressService.createGeoReference(data.getGeoReference().toRequest(data.getAddress().getCustomerId(), data.getAddress().getAddressId()));
					}
					serviceResponse.setGeoReference(createEmptyServiceResponse());

				} catch (IntegrationException ie) {
					serviceResponse.setGeoReference(ie.getResponse());
				}
			}

			return successResponse(serviceResponse, "/cobis-cloud/mobile/prospect/updateProspect");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/prospect/updateProspect Error al actualizar el prospecto", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/prospect/updateProspect Error al actualizar el prospecto", e);
			return errorResponse("Error al actualizar el prospecto");
		}
	}

	// caso #193221 B2B Grupal Digital
	@Path("/prospectCreation")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response prospectCreation(ProspectClient prospectCreateRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug(".......---------ProspectRestService.prospectCreation");
		logger.logInfo("/cobis-cloud/mobile/prospect/prospectCreation Request>>" + objectToJson(prospectCreateRequest));
		try {
			logger.logDebug("----Inicio try-catch-prospectCreation");
			logger.logDebug("----prospectCreation:canal: " + httpRequest.getHeader(Constants.CHANNEL));
			
			int channel = Integer.parseInt(httpRequest.getHeader(Constants.CHANNEL));
			logger.logDebug("----prospectCreation:canal: " + channel);

			ProspectCreateResponse response = customerService.prospectCreation(prospectCreateRequest, channel);
			if (response == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			return successResponse(response, "/cobis-cloud/mobile/prospect/prospectCreation");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/prospect/prospectCreation Error al crear prospecto", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/prospect/prospectCreation Error al crear prospecto", e);
			return errorResponse("/cobis-cloud/mobile/prospect/prospectCreation Error al crear prospecto");
		} finally {
			logger.logDebug(".......---------Final ProspectRestService.prospectCreation");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
		this.officeService = new OfficeIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
		this.officeService = new OfficeIntegrationService(serviceIntegration);
	}
}
