package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.address.AddressResult;
import com.cobiscorp.ecobis.cloud.service.dto.address.Phone;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.Predicate;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessAddress;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;

/**
 * @author Cesar Loachamin
 */
public class AddressIntegrationService extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(AddressIntegrationService.class);

	public AddressIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public AddressResult createAddress(AddressRequest request) {
		request.setChannel("B2B");
		return executeCreateAddress(request);
	}

	public AddressResult createEmail(int customerId, String email) {
		AddressRequest request = new AddressRequest();
		request.setCustomerId(customerId);
		request.setAddressDesc(email);
		request.setAddressType("CE");
		request.setChannel("B2B");
		return executeCreateAddress(request);
	}

	public void updateAddress(AddressRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inAddressRequest", request);
		request.setChannel("B2B");
		execute("CustomerDataManagementService.CustomerManagement.UpdateAddressSan", requestTo);
	}

	public AddressResp findPrincipalAddress(int customerId) {
		return filterAddress(customerId, new Predicate<AddressResp>() {
			@Override
			public boolean test(AddressResp address) {
				return "S".equals(address.getPrincipal());
			}
		});
	}

	public AddressResp findAddress(int customerId, final int addressId) {
		if (addressId == 0) {
			AddressResp[] address = searchAddress(customerId);
			if (address == null) {
				return null;
			} else {
				for (AddressResp element : address) {
					if (element.getAddressType().equals("AE")) {
						logger.logDebug("La direccion de negocio es: " + element.getAddressDesc());
						return element;
					}
				}
				return null;
			}
		} else {
			return filterAddress(customerId, new Predicate<AddressResp>() {
				@Override
				public boolean test(AddressResp address) {
					return addressId == address.getAddress();
				}
			});
		}
	}

	public AddressResp findHomeAddress(int customerId) {
		// if (addressId == 0) {
		AddressResp[] address = searchAddress(customerId);
		if (address == null) {
			return null;
		} else {
			for (AddressResp element : address) {
				if (element.getAddressType().equals("RE")) {
					logger.logDebug("La direccion de Domicilio es: " + element.getAddressDesc());
					return element;
				}
			}
			return null;
		}
		/*
		 * } else { return filterAddress(customerId, new Predicate<AddressResp>() {
		 * 
		 * @Override public boolean test(AddressResp address) { return addressId == address.getAddress(); } }); }
		 */
	}

	public AddressResp findAddress(int customerId, final int addressId, final String type) {

		if (addressId != 0) {
			return filterAddress(customerId, new Predicate<AddressResp>() {
				@Override
				public boolean test(AddressResp address) {
					return addressId == address.getAddress();
				}
			});
		} else {
			AddressResp[] address = searchAddress(customerId);
			for (AddressResp element : address) {
				if (element.getAddressType().equals(type)) {
					logger.logDebug("else El correo es: " + element.getAddressDesc());
					return element;
				}
			}
			return null;
		}
	}

	public AddressResp findBusinessAddress(int customerId) {
		return filterAddress(customerId, new Predicate<AddressResp>() {
			@Override
			public boolean test(AddressResp address) {
				return BusinessAddress.ADDRESS_TYPE.equals(address.getAddressType());
			}
		});
	}

	public AddressResp findBusinessAddressUpdate(int customerId) {
		return filterBusinessAddress(customerId, new Predicate<AddressResp>() {
			@Override
			public boolean test(AddressResp address) {
				return BusinessAddress.ADDRESS_TYPE.equals(address.getAddressType());
			}
		});
	}

	private AddressResp filterBusinessAddress(int customerId, Predicate<AddressResp> predicate) {
		AddressResp[] address = searchAddressBusiness(customerId);
		if (address == null) {
			return null;
		}
		return ArrayUtil.find(address, predicate);
	}

	private AddressResp[] searchAddressBusiness(int customerId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		AddressRequest request = new AddressRequest();
		request.setCustomerId(customerId);
		requestTo.addValue("inAddressRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchAddresBusiness", requestTo);
		return extractValue(response, "returnAddressResp", AddressResp[].class);
	}

	public AddressResp findEmail(int customerId) {
		AddressResp emailAddress = findEmailAddress(customerId);
		if (emailAddress == null)
			return null;
		return emailAddress;
	}

	public void updateEmail(int customerId, String emailAddress) {
		AddressResp currentEmail = findEmailAddress(customerId);
		checkAndUpdateAddress(customerId, emailAddress, currentEmail, null);
	}

	public void updateEmail(int customerId, int emailAddressId, String emailAddress) {
		AddressResp currentEmail = findEmail(customerId);
		checkAndUpdateAddress(customerId, emailAddress, currentEmail, null);
	}

	public void updateEmail(int customerId, int emailAddressId, String emailAddress, String verifyEmail) {
		AddressResp currentEmail = findEmail(customerId);
		checkAndUpdateAddress(customerId, emailAddress, currentEmail, verifyEmail);
	}

	public void createGeoReference(GeoreferencingRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setChannel("B2B");
		requestTo.addValue("inGeoreferencingRequest", request);
		execute("CustomerDataManagementService.CustomerManagement.CreateGeoreferencing", requestTo);
	}

	public TelephoneResponse createPhone(TelephoneRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setChannel("B2B");
		requestTo.addValue("inTelephoneRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.CreateTelephone", requestTo);
		return extractValue(response, "returnTelephoneResponse", TelephoneResponse.class);
	}

	public void updateTelephone(TelephoneRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setChannel("B2B");
		requestTo.addValue("inTelephoneRequest", request);
		execute("CustomerDataManagementService.CustomerManagement.UpdateTelephone", requestTo);
	}

	public TelephoneResponse findCellPhone(int customerId, Integer addressId, final String number) {
		return findPhoneByTypeAndNumber(customerId, addressId, number, Phone.CELL_PHONE_TYPE);
	}

	public TelephoneResponse findHomePhone(int customerId, Integer addressId, final String number) {
		return findPhoneByTypeAndNumber(customerId, addressId, number, Phone.HOME_PHONE_TYPE);
	}

	private TelephoneResponse findPhoneByTypeAndNumber(int customerId, Integer addressId, final String number, final String type) {
		TelephoneResponse[] phones = findTelephones(customerId, addressId);
		return ArrayUtil.find(phones, new Predicate<TelephoneResponse>() {
			@Override
			public boolean test(TelephoneResponse obj) {
				return type.equals(obj.getType()) && number.equals(obj.getNumber());
			}
		});
	}

	public TelephoneResponse findPhone(int customerId, int addressId, final Integer phoneId, final String type) {
		TelephoneResponse[] phones = findTelephones(customerId, addressId);
		logger.logDebug("fuera del if");
		if (phoneId != 0) {
			return ArrayUtil.find(phones, new Predicate<TelephoneResponse>() {
				@Override
				public boolean test(TelephoneResponse obj) {
					return obj.getTelephoneId() == phoneId;
				}
			});
		} else {
			logger.logDebug("Ingresa al else");
			for (TelephoneResponse element : phones) {
				if (element.getType().equals(type)) {
					logger.logDebug("else El Telefono" + element.getNumber());
					return element;
				}
			}
			return null;
		}

	}

	private AddressResp findEmailAddress(int customerId) {
		AddressResp[] addresses = searchAddress(customerId);
		if (addresses == null) {
			return null;
		}
		return ArrayUtil.find(addresses, new Predicate<AddressResp>() {
			@Override
			public boolean test(AddressResp address) {
				return "CE".equals(address.getAddressType());
			}
		});
	}

	private AddressResp[] searchAddress(int customerId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		AddressRequest request = new AddressRequest();
		request.setCustomerId(customerId);
		requestTo.addValue("inAddressRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan", requestTo);
		if (response.isResult() && response.getData() != null) {
			cobiscorp.ecobis.commons.dto.ServiceResponseTO dataResponse = (cobiscorp.ecobis.commons.dto.ServiceResponseTO) response.getData();
			return (AddressResp[]) (dataResponse.getData().get("returnAddressResp"));
		}
		return null;
	}

	public TelephoneResponse findHomePhone(int customerId, Integer addressId) {
		TelephoneResponse[] phones = findTelephones(customerId, addressId);
		return ArrayUtil.find(phones, new Predicate<TelephoneResponse>() {
			@Override
			public boolean test(TelephoneResponse obj) {
				return Phone.HOME_PHONE_TYPE.equals(obj.getType());
			}
		});
	}

	private void updateAddress(Object address) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inAddressRequest", address);
		execute("CustomerDataManagementService.CustomerManagement.UpdateAddressSan", requestTo);
	}

	private void checkAndUpdateAddress(int customerId, String emailAddress, AddressResp currentEmail, String verifyEmail) {
		// if (currentEmail == null || hasEmailChanged(emailAddress, currentEmail)) {
		logger.logInfo("The email address for the customer " + customerId + " has changed to " + emailAddress + " the value is going to be updated");
		currentEmail.setAddressDesc(emailAddress);
		currentEmail.setCustomerId(customerId);

		AddressRequest ObjRequest = new AddressRequest();
		ObjRequest.setAddress(currentEmail.getAddress());
		logger.logInfo("Direccion Numero: " + currentEmail.getAddress());
		logger.logInfo("Direccion Numero: " + currentEmail.getAddressType());

		ObjRequest.setCustomerId(customerId);
		ObjRequest.setAddressDesc(emailAddress);
		ObjRequest.setAddressType(currentEmail.getAddressType());
		ObjRequest.setNeighborhood(currentEmail.getNeighborhood());
		ObjRequest.setCityCode(currentEmail.getCityCode());
		ObjRequest.setPrincipal(currentEmail.getPrincipal());
		ObjRequest.setProvinceCode(currentEmail.getProvinceCode());
		ObjRequest.setPostalCode(currentEmail.getPostalCode());
		ObjRequest.setStreet(currentEmail.getStreet());
		ObjRequest.setVerifyAddress(verifyEmail);
		ObjRequest.setChannel("B2B");

		updateAddress(ObjRequest);
		// }
	}

	private boolean hasEmailChanged(String newEmail, AddressResp email) {
		return email != null && !newEmail.equals(email.getAddressDesc());
	}

	private AddressResult executeCreateAddress(AddressRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inAddressRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.CreateAddressSan", requestTo);
		return new AddressResult(extractOutputValue(response, "@o_dire", Integer.class));
	}

	private AddressResp filterAddress(int customerId, Predicate<AddressResp> predicate) {
		AddressResp[] address = searchAddress(customerId);
		if (address == null) {
			return null;
		}
		return ArrayUtil.find(address, predicate);
	}

	private TelephoneResponse[] findTelephones(int customerId, Integer addressId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		TelephoneRequest request = new TelephoneRequest();
		request.setCustomerId(customerId);
		request.setAddress(addressId);
		requestTo.addValue("inTelephoneRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchTelephone", requestTo);
		return extractValue(response, "returnTelephoneResponse", TelephoneResponse[].class);
	}

}
