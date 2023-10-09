package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.RequestUtil.getParameter;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createEmptyServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

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
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cloud.service.ClientService;
import com.cobiscorp.ecobis.cloud.service.dto.address.AddressResult;
import com.cobiscorp.ecobis.cloud.service.dto.address.EmailAddress;
import com.cobiscorp.ecobis.cloud.service.dto.address.Phone;
import com.cobiscorp.ecobis.cloud.service.dto.address.PhoneResult;
import com.cobiscorp.ecobis.cloud.service.dto.business.Business;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessAddress;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessData;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessResult;
import com.cobiscorp.ecobis.cloud.service.dto.client.Complementary;
import com.cobiscorp.ecobis.cloud.service.dto.client.ComplementaryDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.ComplementaryDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.client.Customer;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddress;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddressData;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddressDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddressDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerResult;
import com.cobiscorp.ecobis.cloud.service.dto.client.PaymentCapacity;
import com.cobiscorp.ecobis.cloud.service.dto.client.PaymentCapacityData;
import com.cobiscorp.ecobis.cloud.service.dto.client.PaymentCapacityDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.Reference;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceData;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceResult;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.Spouse;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseAddressData;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseAddressDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseAddressDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseData;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseDataRequest;
import com.cobiscorp.ecobis.cloud.service.integration.AddressIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.BusinessService;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.LocationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficeIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.ParameterNotFoundException;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneResponse;

/**
 * @author Cesar Loachamin
 */
@Path("/cobis-cloud/mobile/client")
@Component
@Service({ ClientService.class })
@org.apache.felix.scr.annotations.Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class ClientRestService implements ClientService {

	private final ILogger logger = LogFactory.getLogger(ClientRestService.class);
	private CustomerIntegrationService customerService;
	private AddressIntegrationService addressService;
	private BusinessService businessService;
	private OfficeIntegrationService officeService;

	@org.apache.felix.scr.annotations.Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
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
	public Response readCustomer(@PathParam("id") int customerId) {
		logger.logInfo("/cobis-cloud/mobile/client/readCustomer customerId>>" + customerId);
		try {
			Customer customer = Customer.fromResponse(customerService.searchCustomer(customerId), customerId);
			if (customer == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			AddressResp emailResponse = addressService.findEmail(customerId);

			customer.updateFromInfo(customerService.readCustomerInfo(customerId));
			if (emailResponse != null) {
				customer.setEmailAddress(emailResponse.getAddressDesc());
			}
			return successResponse(new CustomerData(customer), "/cobis-cloud/mobile/client/readCustomer");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/client/readCustomer Error al recuperar información del cliente ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/client/readCustomer Error al recuperar información del cliente ", e);
			return errorResponse("/cobis-cloud/mobile/client/readCustomer Error al recuperar información del cliente ");
		}
	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createCustomer(CustomerDataRequest data) {
		logger.logInfo("/cobis-cloud/mobile/client/createCustomer Request>> " + objectToJson(data));
		CustomerDataResponse response = new CustomerDataResponse();
		try {
			if (data.getCustomer() != null && data.getCustomer().getCustomerId() == 0) {
				customerService.setParameterService(parameterService);
				CustomerResult result = customerService.createProspect(data.getCustomer().toProspect().toProspectRequest());
				data.getCustomer().setCustomerId(result.getCustomerId());
				customerService.updateCustomer(data.getCustomer().toRequest());
				createOrUpdateMail(result.getCustomerId(), data.getCustomer().getEmailAddress());
				response.setCustomer(createServiceResponse(result));
				return successResponse(response, "/cobis-cloud/mobile/client/createCustomer");
			} else {
				logger.logDebug("/cobis-cloud/mobile/client/createCustomer Cliente null o id de cliente igual a cero");
				return successResponse(response, "/cobis-cloud/mobile/client/createCustomer");
			}
		} catch (IntegrationException ie) {
			logger.logError("Error al crear el cliente /cobis-cloud/mobile/client/createCustomer ", ie);
			return errorResponse(ie.getResponse());
		} catch (BusinessException be) {
			logger.logError("Error al crear el cliente /cobis-cloud/mobile/client/createCustomer ", be);
			return errorResponse("Error al crear el cliente");
		} catch (Exception e) {
			logger.logError("Error al crear el cliente /cobis-cloud/mobile/client/createCustomer ", e);
			return errorResponse("Error al crear el cliente");
		}
	}

	private void createOrUpdateMail(Integer customerId, String email) {
		if (email != null && customerId != null) {
			try {
				AddressResp foundEmail = addressService.findEmail(customerId);

				if (foundEmail == null) {
					AddressResult emailResult = addressService.createEmail(customerId, email);
					logger.logInfo("emailResult de email: " + emailResult.getAddressId());
				} else if (!email.equals(foundEmail.getDescription())) {
					int emailId = foundEmail.getAddress();
					addressService.updateEmail(customerId, emailId, email);
				}
			} catch (IntegrationException ie) {
				logger.logError("Error al crear o actualizar correo: ", ie);
			}
		} else {
			logger.logInfo("Cliente o email nulos");
		}

	}

	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateCustomer(CustomerDataRequest data) {
		logger.logInfo("/cobis-cloud/mobile/client/updateCustomer Request>> " + objectToJson(data));
		try {
			customerService.setParameterService(parameterService);
			customerService.updateCustomer(data.getCustomer().toRequest());
			createOrUpdateMail(data.getCustomer().getCustomerId(), data.getCustomer().getEmailAddress());
			return successResponse(new CustomerDataResponse(createEmptyServiceResponse()), "/cobis-cloud/mobile/client/updateCustomer");
		} catch (IntegrationException ie) {
			logger.logError("Error al actualizar el cliente /cobis-cloud/mobile/client/updateCustomer ", ie);
			return errorResponse(ie.getResponse());
		} catch (BusinessException be) {
			logger.logError("Error al crear el cliente /cobis-cloud/mobile/client/createCustomer ", be);
			return errorResponse("Error al crear el cliente");
		} catch (Exception e) {
			logger.logError("Error al actualizar el cliente /cobis-cloud/mobile/client/updateCustomer ", e);
			return errorResponse("Error al actualizar el cliente");
		}
	}

	@Path("/{id}/address/{addressId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readAddress(@PathParam("id") int customerId, @PathParam("addressId") int addressId, @Context HttpServletRequest request) {
		logger.logInfo("/cobis-cloud/mobile/client/readAddress customerId " + customerId + " addressId " + addressId);
		try {
			Integer emailAddressId = getParameter(request, "emailAddressId", Integer.class);
			Integer phoneId = getParameter(request, "phoneId", Integer.class);
			Integer cellphoneId = getParameter(request, "cellphoneId", Integer.class);

			CustomerAddressData data = new CustomerAddressData();
			data.setCustomerId(customerId);
			data.setAddressId(addressId);
			// Query address
			AddressResp addressResponse = addressService.findAddress(customerId, addressId);
			data.setCompleteClientName(addressResponse.getCompleteName());
			CustomerAddress address = CustomerAddress.fromResponse(addressResponse);

			if (address == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}

			data.setAddress(address);
			// Query email
			data.setEmailAddress(EmailAddress.fromResponse(addressService.findAddress(customerId, emailAddressId, "CE")));
			// Query home phone
			data.setPhone(Phone.fromResponse(addressService.findPhone(customerId, address.getAddressId(), phoneId, "D")));
			// Query cellphone
			data.setCellphone(Phone.fromResponse(addressService.findPhone(customerId, address.getAddressId(), cellphoneId, "C")));
			// Query geo-referencing do not exist
			data.setGeoReference(GeoReference.fromResponse(addressResponse));

			return successResponse(data, "/cobis-cloud/mobile/client/readAddress");
		} catch (ParameterNotFoundException ex) {
			logger.logError("Error al recuperar la dirección /cobis-cloud/mobile/client/readAddress ", ex);
			return errorResponse(ex.getMessage());
		} catch (Exception e) {
			logger.logError("Error al recuperar la dirección /cobis-cloud/mobile/client/readAddress ", e);
			return errorResponse("Error al recuperar la dirección");
		}
	}

	@Path("/{id}/address")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createAddress(@PathParam("id") int customerId, CustomerAddressDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createAddress customerId" + customerId + " Request>> " + objectToJson(data));

			CustomerAddressDataResponse response = new CustomerAddressDataResponse();
			int addressId = data.getAddressId();

			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					response.setAddress(geoResult);
					return successResponse(response, false, "/cobis-cloud/mobile/client/createAddress");
				}
			}
			// Create Address
			if (addressId == 0 && data.getAddress() != null && data.getAddress().getAddressId() == 0) {
				try {
					AddressResult addressResult = addressService.createAddress(data.getAddress().toRequest(customerId));
					response.setAddress(createServiceResponse(addressResult));
					addressId = addressResult.getAddressId();
				} catch (IntegrationException ie) {
					response.setAddress(ie.getResponse());
				}
			} else if (addressId != 0 || data.getAddress() != null) {
				int updateAddressId = addressId;
				if (updateAddressId == 0) {
					updateAddressId = data.getAddressId();
				}
				if (updateAddressId != 0 && data.getAddress() != null) {
					updateCustomerAddress(customerId, data, response, addressId);
					response.setAddress(createServiceResponse(new AddressResult(addressId)));
				}
			}

			// Create email
			if (addressId != 0 && data.getEmailAddress() != null && data.getEmailAddress().getAddressId() == 0) {
				try {
					AddressResp foundEmail = addressService.findEmail(customerId);

					if (foundEmail == null) {
						AddressResult emailResult = addressService.createEmail(customerId, data.getEmailAddress().getEmail());
						if (emailResult.getAddressId() != 0) {
							response.setEmail(createServiceResponse(emailResult));
						} else {
							response.setEmail(createEmptyServiceResponse());
						}
						logger.logInfo("emailResult de email: " + emailResult.getAddressId());
						logger.logInfo("GetEmail de email: " + response.getEmail().toString());
					} else if (!data.getEmailAddress().getEmail().equals(foundEmail.getDescription())) {
						int emailId = foundEmail.getAddress();
						addressService.updateEmail(customerId, emailId, data.getEmailAddress().getEmail());
						response.setEmail(createServiceResponse(new AddressResult(emailId)));
					}
				} catch (IntegrationException ie) {
					response.setEmail(ie.getResponse());
				}
			} else {
				logger.logInfo("Se crea respuesta vacia");
				response.setEmail(createServiceResponse(new AddressResult(data.getEmailAddress().getAddressId()))); // se
																													// agrega
																													// para
																													// no
																													// devolver
																													// null
			}

			// Create cellphone
			if (addressId != 0 && data.getCellphone() != null && data.getCellphone().getPhoneId() == 0) {
				try {
					int phoneId = 0;
					TelephoneResponse foundPhone = addressService.findCellPhone(customerId, addressId, data.getCellphone().getNumber());
					if (foundPhone == null) {
						if (data.getCellphone() != null && data.getCellphone().getNumber() != null && !"".equals(data.getCellphone().getNumber().trim())) {
							TelephoneResponse phone = addressService.createPhone(data.getCellphone().toCellPhoneRequest(customerId, addressId));
							phoneId = phone.getTelephoneId();
						}
					} else {
						phoneId = foundPhone.getTelephoneId();
					}
					if (phoneId != 0) {
						response.setCellphone(createServiceResponse(new PhoneResult(phoneId)));
					} else {
						response.setCellphone(createEmptyServiceResponse());
					}
					logger.logInfo("phoneId de Cellphone: " + phoneId);
					logger.logInfo("Response de Cellphone: " + response);
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			}

			// Create telephone
			if (addressId != 0 && data.getPhone() != null && data.getPhone().getPhoneId() == 0) {
				try {
					int phoneId = 0;
					TelephoneResponse foundPhone = addressService.findHomePhone(customerId, addressId, data.getPhone().getNumber());
					if (foundPhone == null) {
						if (data.getPhone() != null && data.getPhone().getNumber() != null && !"".equals(data.getPhone().getNumber().trim())) {
							TelephoneResponse phone = addressService.createPhone(data.getPhone().toHomePhoneRequest(customerId, addressId));
							phoneId = phone.getTelephoneId();
						}
					} else {
						phoneId = foundPhone.getTelephoneId();
					}
					if (phoneId != 0) {
						response.setPhone(createServiceResponse(new PhoneResult(phoneId)));
					} else {
						response.setPhone(null);
					}
					logger.logInfo("phoneId de phone: " + phoneId);
					logger.logInfo("Response de phone: " + response);
				} catch (IntegrationException ie) {
					response.setPhone(ie.getResponse());
				}
			}

			// Create geo reference
			response.setGeoReference(createGeoReference(customerId, data.getGeoReference(), addressId));

			return successResponse(response, "/cobis-cloud/mobile/client/createAddress");
		} catch (ParameterNotFoundException ex) {
			logger.logError("Error al crear dirección /cobis-cloud/mobile/client/createAddress ", ex);
			return errorResponse(ex.getMessage());
		} catch (Exception e) {
			logger.logError("Error al crear dirección /cobis-cloud/mobile/client/createAddress ", e);
			return errorResponse("Error al crear dirección");
		}
	}

	@Path("/{id}/address")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateAddress(@PathParam("id") int customerId, CustomerAddressDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/updateAddress customerId" + customerId + " Request>> " + objectToJson(data));

			CustomerAddressDataResponse response = new CustomerAddressDataResponse();
			int addressId = data.getAddressId();

			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					response.setAddress(geoResult);
					return successResponse(response, false, "/cobis-cloud/mobile/client/createAddress");
				}
			}

			// Create Address
			if (addressId != 0 && data.getAddress() != null) {
				updateCustomerAddress(customerId, data, response, addressId);
			}

			// Create email
			if (addressId != 0 && data.getEmailAddress() != null && data.getEmailAddress().getAddressId() == 0) {
				try {
					AddressResp foundEmail = addressService.findEmail(customerId);

					if (foundEmail == null) {
						AddressResult emailResult = addressService.createEmail(customerId, data.getEmailAddress().getEmail());
						if (emailResult.getAddressId() != 0) {
							response.setEmail(createServiceResponse(emailResult));
						} else {
							response.setEmail(createEmptyServiceResponse());
						}
						logger.logInfo("emailResult de email: " + emailResult.getAddressId());
						logger.logInfo("GetEmail de email: " + response.getEmail().toString());
					} else if (!data.getEmailAddress().getEmail().equals(foundEmail.getDescription())) {
						int emailId = foundEmail.getAddress();
						addressService.updateEmail(customerId, addressId, data.getEmailAddress().getEmail(), data.getEmailAddress().getVerifyEmail());
						response.setEmail(createServiceResponse(new AddressResult(emailId)));
					}
				} catch (IntegrationException ie) {
					response.setEmail(ie.getResponse());
				}
			} else if (addressId != 0 && data.getEmailAddress() != null && data.getEmailAddress().getAddressId() != 0) {
				addressService.updateEmail(customerId, data.getEmailAddress().getAddressId(), data.getEmailAddress().getEmail(), data.getEmailAddress().getVerifyEmail());
				response.setEmail(createServiceResponse(new AddressResult(data.getEmailAddress().getAddressId())));
			} else {
				logger.logInfo("Se crea respuesta vacia");
				response.setEmail(createServiceResponse(new AddressResult(data.getEmailAddress().getAddressId()))); // se																							// null
			}

			// Create cellphone
			if (addressId != 0 && data.getCellphone() != null && data.getCellphone().getPhoneId() != 0) {
				try {
					addressService.updateTelephone(data.getCellphone().toCellPhoneRequest(customerId, addressId, data.getCellphone().getPhoneId()));
					response.setCellphone(createServiceResponse(new PhoneResult(data.getCellphone().getPhoneId())));
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			} else { // Se crea el cellphone
				try {
					if (data.getCellphone() != null && data.getCellphone().getNumber() != null && !"".equals(data.getCellphone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getCellphone().toCellPhoneRequest(customerId, addressId));
						response.setCellphone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			}

			// Create telephone
			if (addressId != 0 && data.getPhone() != null && data.getPhone().getPhoneId() != 0) {
				try {
					addressService.updateTelephone(data.getPhone().toHomePhoneRequest(customerId, addressId, data.getPhone().getPhoneId()));
					response.setPhone(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setPhone(ie.getResponse());
				}
			} else { // Create Workphone
				try {
					if (data.getPhone() != null && data.getPhone().getNumber() != null && !"".equals(data.getPhone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getPhone().toHomePhoneRequest(customerId, addressId));
						response.setPhone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setPhone(ie.getResponse());
				}
			}

			// Create geo reference
			response.setGeoReference(createGeoReference(customerId, data.getGeoReference(), addressId));

			return successResponse(response, "/cobis-cloud/mobile/client/updateAddress");
		}catch(IntegrationException ie) {
			return errorResponse(ie.getResponse());
		}
		catch (Exception e) {
			logger.logError("Error al actualizar dirección /cobis-cloud/mobile/client/updateAddress ", e);
			return errorResponse("Error al crear dirección");
		}
	}

	@Path("/{id}/business/{businessId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readBusiness(@PathParam("id") int customerId, @PathParam("businessId") int businessId) {

		BusinessData data = new BusinessData();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/readBusiness customerId" + customerId + " businessId " + businessId + objectToJson(data));

			Business business = Business.fromResponse(businessService.searchBusiness(customerId, businessId));
			if (business == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			data.setBusiness(business);

			AddressResp resp = addressService.findBusinessAddress(customerId);
			data.setAddress(BusinessAddress.fromResponse(resp));

			data.setGeoReference(GeoReference.fromResponse(resp));

			return successResponse(data, "/cobis-cloud/mobile/client/readBusiness");
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar datos del negocio /cobis-cloud/mobile/client/readBusiness ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar datos del negocio /cobis-cloud/mobile/client/readBusiness ", e);
			return errorResponse("Error al consultar datos del negocio");
		}

	}

	@Path("/{id}/business")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createBusiness(@PathParam("id") int customerId, BusinessDataRequest data) {

		BusinessDataResponse response = new BusinessDataResponse();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createBusiness customerId" + customerId + objectToJson(data));
			int addressId = 0;

			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					response.setBusiness(geoResult);
					return successResponse(response, false, "/cobis-cloud/mobile/client/createAddress");
				}
			}

			if (data.getAddress() != null) {
				if (data.getAddress().getAddressId() == 0) {
					AddressResult result = addressService.createAddress(data.getAddress().toRequest(customerId));
					response.setAddress(createServiceResponse(result));
					addressId = result.getAddressId();
				} else if (data.getAddress().getAddressId() != 0) {
					addressService.updateAddress(data.getAddress().toRequest(customerId));
					response.setAddress(createEmptyServiceResponse());
					addressId = data.getAddress().getAddressId();
				}
			}

			if (data.getBusiness() != null && data.getBusiness().getBusinessId() == 0) {
				BusinessResult result = businessService.createBusiness(data.getBusiness().toRequest(customerId));
				response.setBusiness(createServiceResponse(result));
			}
			if (data.getGeoReference() != null) {
				if (addressId == 0) {
					AddressResp findAddress = addressService.findBusinessAddress(customerId);
					if (findAddress != null) {
						addressId = findAddress.getAddress();
					}
				}
				response.setGeoReference(createGeoReference(customerId, data.getGeoReference(), addressId));

			}

			return successResponse(response, "/cobis-cloud/mobile/client/createBusiness");
		} catch (IntegrationException ie) {
			logger.logError("Error al crear negocio /cobis-cloud/mobile/client/createBusiness ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear negocio /cobis-cloud/mobile/client/createBusiness ", e);
			return errorResponse("Error al crear negocio");
		}
	}

	@Path("/{id}/business")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateBusiness(@PathParam("id") int customerId, BusinessDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/updateBusiness customerId" + customerId + objectToJson(data));
			BusinessDataResponse dataResponse = new BusinessDataResponse();

			AddressResp businessAddress = addressService.findBusinessAddressUpdate(customerId);
			int addressId = 0;

			LocationService locationService = new LocationService();
			locationService.setParameterService(parameterService);
			locationService.setOfficeService(officeService);
			ServiceResponse geoResult = locationService.validateOfficeGeo(data.getGeoReference(), data.getOfficialGeoReference());
			if (geoResult != null) {
				if (!geoResult.isResult()) {
					dataResponse.setBusiness(geoResult);
					return successResponse(dataResponse, false, "/cobis-cloud/mobile/client/createAddress");
				}
			}

			logger.logInfo(" el businessAddress nos devuelve: " + businessAddress);

			if (businessAddress == null) {
				try {
					if (data.getAddress() != null) {
						AddressResult result = addressService.createAddress(data.getAddress().toRequest(customerId));
						dataResponse.setAddress(createServiceResponse(result));
						addressId = result.getAddressId();
					}
				} catch (IntegrationException ie) {
					dataResponse.setAddress(ie.getResponse());
				}
				if (businessAddress == null) {
					dataResponse.setGeoReference(createGeoReference(customerId, data.getGeoReference(), addressId));

				}
			}

			try {
				if (data.getAddress() != null) {
					if (businessAddress != null) {
						data.getAddress().setAddressId(businessAddress.getAddress());
						addressService.updateAddress(data.getAddress().toRequest(customerId));
						dataResponse.setAddress(createEmptyServiceResponse());
					}
				}
			} catch (IntegrationException ie) {
				dataResponse.setAddress(ie.getResponse());
			}

			if (businessAddress != null) {
				dataResponse.setGeoReference(createGeoReference(customerId, data.getGeoReference(), businessAddress.getAddress()));

			}

			try {
				if (data.getBusiness() != null && data.getBusiness().getBusinessId() != 0) {
					BusinessResult result = businessService.updateBusiness(data.getBusiness().toRequest(customerId));
					dataResponse.setBusiness(createServiceResponse(result));
				}
			} catch (IntegrationException ie) {
				dataResponse.setBusiness(ie.getResponse());
			}

			return successResponse(dataResponse, "/cobis-cloud/mobile/client/updateBusiness");
		} catch (IntegrationException ie) {
			logger.logError("Error al actualizar negocio /cobis-cloud/mobile/client/updateBusiness ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al actualizar negocio /cobis-cloud/mobile/client/updateBusiness ", e);
			return errorResponse("Error al actualizar negocio");
		}
	}

	@Path("/{id}/reference")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readReferences(@PathParam("id") int customerId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/readReferences customerId" + customerId);
			CustomerReferenceResponse[] response = customerService.searchReferences(customerId);
			Reference[] references = ArrayUtil.map(response, Reference.class, new ArrayUtil.Function<CustomerReferenceResponse, Reference>() {
				@Override
				public Reference call(CustomerReferenceResponse obj) {
					return Reference.fromResponse(obj);
				}
			});
			return successResponse(references, "/cobis-cloud/mobile/client/readReferences");
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar referencias /cobis-cloud/mobile/client/readReferences ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar referencias /cobis-cloud/mobile/client/readReferences ", e);
			return errorResponse("Error al consultar referencias");
		}
	}

	@Path("/{id}/reference/{referenceId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readReference(@PathParam("id") int customerId, @PathParam("referenceId") int referenceId) {
		try {
			Reference reference = Reference.fromResponse(customerService.searchReference(customerId, referenceId));
			if (reference == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			return successResponse(new ReferenceData(reference), "/cobis-cloud/mobile/client/readReference");
		} catch (IntegrationException ie) {
			return errorResponse(ie.getResponse());
		}
	}

	@Path("/{id}/reference")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createReference(@PathParam("id") int customerId, ReferenceDataRequest data) {

		ReferenceDataResponse response = new ReferenceDataResponse();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createReference customerId " + customerId + objectToJson(data));

			if (data.getReference() != null && data.getReference().getReferenceId() == 0) {
				ReferenceResult result = customerService.createReference(data.getReference().toRequest(customerId));
				response.setReference(createServiceResponse(result));
				return successResponse(response, "/cobis-cloud/mobile/client/createReference");
			}
			return successResponse(response, "/cobis-cloud/mobile/client/createReference");
		} catch (IntegrationException ie) {
			logger.logError("Error al crear referencia /cobis-cloud/mobile/client/createReference ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear referencia /cobis-cloud/mobile/client/createReference ", e);
			return errorResponse("Error al crear referencia");
		}
	}

	@Path("/{id}/reference")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateReference(@PathParam("id") int customerId, ReferenceDataRequest data) {

		ReferenceDataResponse response = new ReferenceDataResponse();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/updateReference customerId " + customerId + objectToJson(data));

			if (data.getReference() != null && data.getReference().getReferenceId() != 0) {
				customerService.updateReference(data.getReference().toRequest(customerId));
				response.setReference(createEmptyServiceResponse());
				return successResponse(response, "/cobis-cloud/mobile/client/updateReference");
			}
			return successResponse(response, "/cobis-cloud/mobile/client/updateReference");
		} catch (IntegrationException ie) {
			logger.logError("Error al actualizar referencia /cobis-cloud/mobile/client/updateReference ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear referencia /cobis-cloud/mobile/client/updateReference ", e);
			return errorResponse("Error al actualizar referencia");
		}
	}

	@Path("/{id}/paymentCapacity")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readPaymentCapacity(@PathParam("id") int customerId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/readPaymentCapacity customerId " + customerId);
			CustomerResponse response = customerService.readCustomerInfo(customerId);
			if (response == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			CustomerResponse response2 = customerService.searchCustomer(customerId);
			if (response2 == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			response.setHasOtherIncome(response2.getHasOtherIncome());
			response.setOtherIncomeSource(response2.getOtherIncomeSource());

			return successResponse(new PaymentCapacityData(PaymentCapacity.fromResponse(response)), "/cobis-cloud/mobile/client/readPaymentCapacity");
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar capacidad de pago /cobis-cloud/mobile/client/readPaymentCapacity ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar capacidad de pago /cobis-cloud/mobile/client/readPaymentCapacity ", e);
			return errorResponse("Error al consultar capacidad de pago");
		}
	}

	@Path("/{id}/paymentCapacity")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createPaymentCapacity(@PathParam("id") int customerId, PaymentCapacityDataRequest paymentCapacity) {
		logger.logInfo("/cobis-cloud/mobile/client/createPaymentCapacity customerId " + customerId + " Request>>" + objectToJson(paymentCapacity));
		return updatePaymentCapacity(customerId, paymentCapacity);
	}

	@Path("/{id}/paymentCapacity")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updatePaymentCapacity(@PathParam("id") int customerId, PaymentCapacityDataRequest paymentCapacity) {

		logger.logInfo("/cobis-cloud/mobile/client/updatePaymentCapacity customerId " + customerId);
		return updateCustomerWithPaymentCapacity(customerId, paymentCapacity);

	}

	@Path("/{id}/spouse")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readSpouse(@PathParam("id") int customerId) {

		SpouseData data = new SpouseData();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/readSpouse customerId " + customerId);
			SpouseProspectRequest request = new SpouseProspectRequest();
			request.setPersonSecuencial(customerId);
			SpouseProspectResponse customerResponse = customerService.searchSpouse(request);
			if (customerResponse == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			data.setSpouse(Spouse.fromResponse(customerResponse));
			return successResponse(data, "/cobis-cloud/mobile/client/readSpouse");
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar cónyugue /cobis-cloud/mobile/client/readSpouse ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar cónyugue /cobis-cloud/mobile/client/readSpouse ", e);
			return errorResponse("Error al consultar cónyugue");
		}
	}

	@Path("/{id}/spouse")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createSpouse(@PathParam("id") int customerId, SpouseDataRequest request) {
		SpouseData data = new SpouseData();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createSpouse customerId " + customerId + " Request>>" + objectToJson(request));
			if (request.getSpouse() != null) {
				SpouseProspectRequest spouseRequest = request.getSpouse().toRequest(customerId);
				ServiceResponse response = customerService.createSponse(spouseRequest);
				if (!response.isResult()) {
					return errorResponse("Error al crear cónyugue");
				}
				if (logger.isDebugEnabled()) {
					logger.logInfo("Conyuge creado");
				}
				SpouseProspectRequest responseSpouse = new SpouseProspectRequest();
				responseSpouse.setPersonSecuencial(customerId);
				SpouseProspectResponse customerSpouse = customerService.searchSpouse(responseSpouse);
				if (customerSpouse == null) {
					return errorResponse("Error al crear cónyugue");
				}
				data.setSpouse(Spouse.fromResponse(customerSpouse));
			}
			return successResponse(data, "/cobis-cloud/mobile/client/readSpouse");

		} catch (IntegrationException ie) {
			logger.logError("Error al crear cónyugue /cobis-cloud/mobile/client/createSpouse ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear cónyugue /cobis-cloud/mobile/client/createSpouse ", e);
			return errorResponse("Error al crear cónyugue");
		}
	}

	@Path("/{id}/spouse")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateSpouse(@PathParam("id") int customerId, SpouseDataRequest request) {

		SpouseData data = new SpouseData();
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createSpouse customerId " + customerId + " Request>>" + objectToJson(request));
			if (request.getSpouse() != null) {
				SpouseProspectRequest spouseRequest = request.getSpouse().toRequest(customerId);
				ServiceResponse response = customerService.createSponse(spouseRequest);
				if (!response.isResult()) {
					return errorResponse("Error al crear cónyugue");
				}
				if (logger.isDebugEnabled()) {
					logger.logInfo("Conyuge actualizado");
				}
				SpouseProspectRequest responseSpouse = new SpouseProspectRequest();
				responseSpouse.setPersonSecuencial(customerId);
				SpouseProspectResponse customerSpouse = customerService.searchSpouse(responseSpouse);
				if (customerSpouse == null) {
					return errorResponse("Error al actualizar cónyugue");
				}
				data.setSpouse(Spouse.fromResponse(customerSpouse));
			}
			return successResponse(data, "/cobis-cloud/mobile/client/readSpouse");

		} catch (IntegrationException ie) {
			logger.logError("Error al actualizar cónyugue /cobis-cloud/mobile/client/createSpouse ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al actualizar cónyugue /cobis-cloud/mobile/client/createSpouse ", e);
			return errorResponse("Error al actualizar cónyugue");
		}
	}

	@Path("/{id}/spouse/address/{addressId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readSpouseAddress(@PathParam("id") int customerId, @PathParam("addressId") int addressId, @Context HttpServletRequest request) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/readSpouseAddress customerId " + customerId + " addressId " + addressId + " Request>>" + objectToJson(request));
			CustomerResponse spouseResponse = customerService.searchSpouse(customerId);
			if (spouseResponse == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			Integer workphoneId = getParameter(request, "workphoneId", Integer.class);
			Integer cellphoneId = getParameter(request, "cellphoneId", Integer.class);

			int spouseId = spouseResponse.getCustomerId();
			SpouseAddressData data = new SpouseAddressData();
			data.setAddressId(addressId);
			// Query address
			BusinessAddress address = BusinessAddress.fromResponse(addressService.findAddress(spouseId, addressId));
			if (address == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			data.setAddress(address);
			// Query email
			// Query home phone
			data.setWorkphone(Phone.fromResponse(addressService.findPhone(spouseId, address.getAddressId(), workphoneId, "D")));
			// Query cellphone
			data.setCellphone(Phone.fromResponse(addressService.findPhone(spouseId, address.getAddressId(), cellphoneId, "C")));

			return successResponse(data, "/cobis-cloud/mobile/client/readSpouseAddress");
		} catch (IntegrationException ex) {
			logger.logError("Error al recuperar dirección del cónyugue /cobis-cloud/mobile/client/readSpouseAddress ", ex);
			return errorResponse(ex.getResponse());
		} catch (Exception e) {
			logger.logError("Error al recuperar dirección del cónyugue /cobis-cloud/mobile/client/readSpouseAddress ", e);
			return errorResponse("Error al recuperar dirección del cónyugue");
		}
	}

	@Path("/{id}/spouse/address")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createSpouseAddress(@PathParam("id") int customerId, SpouseAddressDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/createSpouseAddress customerId " + customerId + " Request>>" + objectToJson(data));
			SpouseAddressDataResponse response = new SpouseAddressDataResponse();
			int addressId = data.getAddressId();
			CustomerResponse spouseResponse = customerService.searchSpouse(customerId);
			if (spouseResponse == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			int spouseId = spouseResponse.getCustomerId();
			// Create Address
			if (addressId == 0 && (data.getAddress() != null) && (data.getAddress().getAddressId() == 0)) {
				try {
					AddressRequest addressRequest = data.getAddress().toRequest(spouseId);
					AddressResult addressResult = addressService.createAddress(addressRequest);
					response.setAddress(createServiceResponse(addressResult));
					addressId = addressResult.getAddressId();
				} catch (IntegrationException ie) {
					response.setAddress(ie.getResponse());
				}
			}

			// Create cellphone
			if ((addressId != 0) && (data.getCellphone() != null) && (data.getCellphone().getPhoneId() == 0)) {
				try {
					if (data.getCellphone() != null && data.getCellphone().getNumber() != null && !"".equals(data.getCellphone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getCellphone().toCellPhoneRequest(spouseId, addressId));
						response.setCellphone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			}

			// Create telephone
			if (addressId != 0 && data.getWorkphone() != null && data.getWorkphone().getPhoneId() == 0) {
				try {
					if (data.getWorkphone() != null && data.getWorkphone().getNumber() != null && !"".equals(data.getWorkphone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getWorkphone().toHomePhoneRequest(spouseId, addressId));
						response.setWorkphone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setWorkphone(ie.getResponse());
				}
			}

			return successResponse(response, "/cobis-cloud/mobile/client/createSpouseAddress");

		} catch (IntegrationException ex) {
			logger.logError("Error al crear dirección del cónyugue /cobis-cloud/mobile/client/createSpouseAddress ", ex);
			return errorResponse(ex.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear dirección del cónyugue /cobis-cloud/mobile/client/createSpouseAddress ", e);
			return errorResponse("Error al crear dirección del cónyugue");
		}
	}

	@Path("/{id}/spouse/address")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateSpouseAddress(@PathParam("id") int customerId, SpouseAddressDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/client/updateSpouseAddress customerId " + customerId + " Request>>" + objectToJson(data));

			SpouseAddressDataResponse response = new SpouseAddressDataResponse();
			int addressId = data.getAddressId();
			CustomerResponse spouseResponse = customerService.searchSpouse(customerId);
			if (spouseResponse == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			int spouseId = spouseResponse.getCustomerId();
			// Create Address
			if (addressId != 0 && data.getAddress() != null) {
				try {
					data.getAddress().setAddressId(addressId);
					AddressRequest addressRequest = data.getAddress().toRequest(spouseId);
					addressService.updateAddress(addressRequest);
					response.setAddress(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setAddress(ie.getResponse());
				}
			}

			// Update cellphone
			if (addressId != 0 && (data.getCellphone() != null) && (data.getCellphone().getPhoneId() != 0)) {
				try {
					addressService.updateTelephone(data.getCellphone().toCellPhoneRequest(spouseId, addressId, data.getCellphone().getPhoneId()));

					response.setCellphone(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			} else { // Se crea el cellphone
				try {
					if (data.getCellphone() != null && data.getCellphone().getNumber() != null && !"".equals(data.getCellphone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getCellphone().toCellPhoneRequest(spouseId, addressId));
						response.setCellphone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setCellphone(ie.getResponse());
				}
			}

			// Update telephone
			if (addressId != 0 && data.getWorkphone() != null && data.getWorkphone().getPhoneId() != 0) {
				try {
					addressService.updateTelephone(data.getWorkphone().toHomePhoneRequest(spouseId, addressId, data.getWorkphone().getPhoneId()));
					response.setWorkphone(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setWorkphone(ie.getResponse());
				}
			} else { // Create Workphone
				try {
					if (data.getWorkphone() != null && data.getWorkphone().getNumber() != null && !"".equals(data.getWorkphone().getNumber().trim())) {
						TelephoneResponse phone = addressService.createPhone(data.getWorkphone().toHomePhoneRequest(spouseId, addressId));
						response.setWorkphone(createServiceResponse(new PhoneResult(phone.getTelephoneId())));
					}
				} catch (IntegrationException ie) {
					response.setWorkphone(ie.getResponse());
				}
			}

			return successResponse(response, "/cobis-cloud/mobile/client/updateSpouseAddress");

		} catch (IntegrationException ex) {
			logger.logError("Error al actualizar dirección del cónyugue /cobis-cloud/mobile/client/updateSpouseAddress ", ex);
			return errorResponse(ex.getResponse());
		} catch (Exception e) {
			logger.logError("Error al actualizar dirección del cónyugue /cobis-cloud/mobile/client/updateSpouseAddress ", e);
			return errorResponse("Error al actualizar dirección del cónyugue");
		}
	}

	@Path("/{id}/complementaryData")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateComplementaryData(ComplementaryDataRequest data) {
		logger.logInfo("/cobis-cloud/mobile/client/updateComplementaryData" + objectToJson(data));
		try {
			customerService.updateComplementary(data.getComplementary().toRequest());
			return successResponse(new ComplementaryDataResponse(createEmptyServiceResponse()), "/cobis-cloud/mobile/client/updateComplementaryData");
		} catch (IntegrationException ex) {
			logger.logError("Error al actualizar dirección del cónyugue /cobis-cloud/mobile/client/updateSpouseAddress ", ex);
			return errorResponse(ex.getResponse());
		} catch (Exception e) {
			logger.logError("Error al actualizar dirección del cónyugue /cobis-cloud/mobile/client/updateSpouseAddress ", e);
			return errorResponse("Error al actualizar dirección del cónyugue");
		}
	}

	@Path("/{id}/complementaryData")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readComplementaryData(@PathParam("id") int customerId) {
		logger.logInfo("/cobis-cloud/mobile/client/readComplementaryData customeId" + customerId);
		try {
			Complementary complementary = Complementary.fromResponse(customerService.readComplementaryData(customerId));
			if (complementary == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			return successResponse(complementary, "/cobis-cloud/mobile/client/readComplementaryData");
		} catch (IntegrationException ex) {
			logger.logError("Error al consultar dirección del cónyugue /cobis-cloud/mobile/client/readComplementaryData ", ex);
			return errorResponse(ex.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar dirección del cónyugue /cobis-cloud/mobile/client/readComplementaryData ", e);
			return errorResponse("Error al consultar dirección del cónyugue");
		}
	}

	private void updateCustomerAddress(int customerId, CustomerAddressDataRequest data, CustomerAddressDataResponse response, int addressId) {
		try {
			data.getAddress().setAddressId(addressId);
			addressService.updateAddress(data.getAddress().toRequest(customerId));
			response.setAddress(createEmptyServiceResponse());
		} catch (IntegrationException ie) {
			response.setAddress(ie.getResponse());
		}
	}

	private Response updateCustomerWithPaymentCapacity(int customerId, PaymentCapacityDataRequest paymentCapacity) {
		try {
			CustomerResponse customerResponse = customerService.searchCustomer(customerId);
			if (customerResponse == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			customerService.updateCustomer(paymentCapacity.getPaymentCapacity().toRequest(customerId, Customer.fromResponse(customerResponse, customerId)));
		} catch (IntegrationException ie) {
			return errorResponse(ie.getResponse());
		} catch (BusinessException be) {
			logger.logError("Error al actualizar capacidad de pago del cliente /cobis-cloud/mobile/client/createCustomer ", be);
			return errorResponse("Error al actualizar Capacidad de Pago del cliente");
		} catch (Exception e) {
			logger.logError("Error al actualizar capacidad de pago del cliente /cobis-cloud/mobile/client/createCustomer ", e);
			return errorResponse("Error al actualizar Capacidad de Pago del cliente");
		}
		return successResponse(createEmptyServiceResponse(), "updateCustomerWithPaymentCapacity");
	}

	private ServiceResponse createGeoReference(int customerId, GeoReference data, int addressId) {
		if (addressId != 0 && data != null) { // Create GeoReference
			try {
				// Important the creation service not return data
				addressService.createGeoReference(data.toRequest(customerId, addressId));
				return createEmptyServiceResponse();
			} catch (IntegrationException ie) {
				return ie.getResponse();
			}
		}
		return null;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
		this.businessService = new BusinessService(serviceIntegration);
		this.officeService = new OfficeIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
		this.businessService = new BusinessService(serviceIntegration);
		this.officeService = new OfficeIntegrationService(serviceIntegration);
	}
}
