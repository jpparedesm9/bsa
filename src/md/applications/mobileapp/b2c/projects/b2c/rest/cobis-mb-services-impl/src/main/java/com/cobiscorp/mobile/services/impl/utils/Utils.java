package com.cobiscorp.mobile.services.impl.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.LoginRequest;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Address;
import com.cobiscorp.mobile.model.Customer;
import com.cobiscorp.mobile.model.OnboardingRequest;

import cobiscorp.ecobis.businesstoconsumer.dto.AddressRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.CustomerRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.OnboardingCustomerRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilebanking.dto.Ente;
import cobiscorp.ecobis.mobilebanking.dto.SearchOption;

public class Utils {

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> UtilsImplements] ";

	private static final ILogger logger = LogFactory.getLogger(Utils.class);

	private static Utils instance;

	public static Utils getInstance() {
		if (instance == null)
			instance = new Utils();
		return instance;
	}

	public static void setInstance(Utils instance) {
		Utils.instance = instance;
	}

	public Utils() {
		// Singleton Class for Util instance

	}

	public String applyingMaskToAccountNumber(String accountNumber) {
		int startPosition = 3;
		int endPosition = accountNumber.length() - 3;
		String digitsMask = "X";
		String accountNumberToMasked = accountNumber.substring(startPosition, endPosition);
		for (int x = 0; x < accountNumberToMasked.length() - 1; x++)
			digitsMask = digitsMask + "X";
		accountNumber.replace(accountNumberToMasked, digitsMask);
		if (logger.isInfoEnabled()) {
			logger.logInfo(
					CLASS_NAME + "Utils.applyingMaskToAccountNumber(..) -> accountNumber=" + accountNumber + " :: ");
		}
		return accountNumber;
	}

	/*
	 * Method Name: Get Original Login This method allows users to search the
	 * original login from the login Eg. login:Pedro originalLogin:1724356XXX
	 */
	@SuppressWarnings("unchecked")
	public String getOriginalLogin(String login, String sessionId, ICTSServiceIntegration serviceIntegration) {

		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Iniciando el metodo getOriginalLogin (String)");
			logger.logDebug("login: " + login);
		}

		String originalLogin = "";

		ServiceRequest header = new ServiceRequest();
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		requestTO.setSessionId(sessionId);
		requestTO.setServiceId("MobileBanking.Service.Password.GetLogin");

		cobiscorp.ecobis.mobilebanking.dto.Ente inEnte = new Ente();
		inEnte.setLogin(login);

		requestTO.addValue("inEnte", inEnte);
		cobiscorp.ecobis.mobilebanking.dto.SearchOption inSearchOption = new SearchOption();
		inSearchOption.setServiceId(Integer.parseInt(Constants.SERVICE_MOBILE_BANKING));

		requestTO.addValue("inSearchOption", inSearchOption);

		ServiceResponseTO responseTO = serviceIntegration.getResponseFromCTS(requestTO);
		if (logger.isDebugEnabled()) {
			logger.logDebug("success: " + responseTO.isSuccess());
		}

		if (responseTO.isSuccess()) {
			Map<String, String> outputs = (Map<String, String>) responseTO.getValue(Constants.SERVICE_OUTPUT_VALUES);
			if (outputs != null) {
				originalLogin = outputs.get("@o_login");
				if (logger.isInfoEnabled()) {
					logger.logInfo(CLASS_NAME + "originalLogin:" + originalLogin);
				}
			}
		}
		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Terminando el metodo getOriginalLogin");
		}

		return originalLogin;
	}

	@SuppressWarnings("unchecked")
	public Integer getBiometricId(String login, String uuid, String sessionId,
			ICTSServiceIntegration serviceIntegration) {

		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Iniciando el metodo getBiometricId (String)");
			logger.logDebug("login: " + login);
			logger.logDebug("uuid: " + uuid);
		}

		Integer biometricId = 0;

		ServiceRequest header = new ServiceRequest();
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		requestTO.setSessionId(sessionId);
		requestTO.setServiceId("MobileBanking.Service.Biometric.GetBiometricId");

		cobiscorp.ecobis.mobilebanking.dto.Ente inEnte = new Ente();
		inEnte.setLogin(login);
		inEnte.setBiometricId(-1);
		requestTO.addValue("inEnte", inEnte);

		cobiscorp.ecobis.mobilebanking.dto.SearchOption inSearchOption = new SearchOption();
		inSearchOption.setServiceId(Integer.parseInt(Constants.SERVICE_MOBILE_BANKING));
		requestTO.addValue("inSearchOption", inSearchOption);

		cobiscorp.ecobis.mobilebanking.dto.Device inDevice = new cobiscorp.ecobis.mobilebanking.dto.Device();
		inDevice.setUdId(uuid);
		requestTO.addValue("inDevice", inDevice);

		ServiceResponseTO responseTO = serviceIntegration.getResponseFromCTS(requestTO);
		if (logger.isDebugEnabled()) {
			logger.logDebug("success: " + responseTO.isSuccess());
		}
		if (responseTO.isSuccess()) {
			Map<String, String> outputs = (Map<String, String>) responseTO.getValue(Constants.SERVICE_OUTPUT_VALUES);
			if (outputs != null) {
				if (logger.isInfoEnabled()) {
					logger.logInfo(CLASS_NAME + "@o_biometric_id:" + outputs.get("@o_biometric_id"));
				}
				// biometricId = outputs.get("@o_biometric_id");

				if (biometricId != null)
					biometricId = Integer.parseInt(outputs.get("@o_biometric_id"));
				if (logger.isInfoEnabled()) {
					logger.logInfo(CLASS_NAME + "@o_biometric_id:" + biometricId);
				}
			}
		}
		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Terminando el metodo getBiometricId");
		}

		return biometricId;
	}

	@SuppressWarnings("unchecked")
	public LoginRequest getCredentials(String uuid, int biometricId, String sessionId,
			ICTSServiceIntegration serviceIntegration) {

		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Iniciando el metodo getBiometricId (String)");
			logger.logDebug("biometricId: " + biometricId);
			logger.logDebug("uuid: " + uuid);
		}

		LoginRequest request = new LoginRequest();
		ServiceRequest header = new ServiceRequest();
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		requestTO.setSessionId(sessionId);
		requestTO.setServiceId("MobileBanking.Service.Biometric.GetBiometricId");

		Ente inEnte = new Ente();
		inEnte.setBiometricId(biometricId);
		requestTO.addValue("inEnte", inEnte);

		cobiscorp.ecobis.mobilebanking.dto.SearchOption inSearchOption = new SearchOption();
		inSearchOption.setServiceId(Integer.parseInt(Constants.SERVICE_MOBILE_BANKING));
		requestTO.addValue("inSearchOption", inSearchOption);

		cobiscorp.ecobis.mobilebanking.dto.Device inDevice = new cobiscorp.ecobis.mobilebanking.dto.Device();
		inDevice.setUdId(uuid);
		requestTO.addValue("inDevice", inDevice);

		ServiceResponseTO responseTO = serviceIntegration.getResponseFromCTS(requestTO);
		if (logger.isDebugEnabled()) {
			logger.logDebug("success: " + responseTO.isSuccess());
		}

		if (responseTO.isSuccess()) {
			Map<String, String> outputs = (Map<String, String>) responseTO.getValue(Constants.SERVICE_OUTPUT_VALUES);
			if (outputs != null) {
				request.setPassword(outputs.get("@o_biometric_password"));
				request.setLogin(outputs.get("@o_login"));
				String biometricOriginalLogin = outputs.get("@o_cedula");
				if (logger.isInfoEnabled()) {
					logger.logInfo(CLASS_NAME + "@o_biometric_password:" + request.getPassword());
					logger.logInfo(CLASS_NAME + "@o_login:" + request.getLogin());
					logger.logInfo(CLASS_NAME + "@o_cedula:" + biometricOriginalLogin);
				}

			}
		}
		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + "Terminando el metodo getBiometricId");
		}

		return request;
	}

	public static CustomerRequest getCustomerRequest(Customer customer) {
		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setId(customer.getId());
		customerRequest.setMode(customer.getMode());

		if (customer.getMode() == 0) {
			customerRequest.setFirstName(customer.getFirstName());
			customerRequest.setSecondName(customer.getSecondName());
			customerRequest.setLastname(customer.getLastname());
			customerRequest.setSecondLastname(customer.getSecondLastname());
			customerRequest.setCurp(customer.getCurp());
			customerRequest.setGender(customer.getGender());
			customerRequest.setPhoneNumber(customer.getPhoneNumber());
			customerRequest.setBirthplace(customer.getBirthplace());
			if (customer.getBirthdate() == null) {
				customerRequest.setBirthdate(null);
			} else {
				Calendar birthdate = Calendar.getInstance();
				Date date = null;
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(customer.getBirthdate());
					birthdate.setTime(date);
					customerRequest.setBirthdate(birthdate);
				} catch (ParseException e) {
					logger.logError("Error al convertir la fecha de nacimiento");
					customerRequest.setBirthdate(null);
				}
			}

			if ((customer.getBioIdentificationType() == null || "".equals(customer.getBioIdentificationType())
					|| Constants.INE.equals(customer.getBioIdentificationType())) && customer.getBioCIC() != null) {
				customerRequest.setBioIdentificationType(Constants.INE);
				customerRequest.setBioCIC(customer.getBioCIC());
			} else {
				customerRequest.setBioIdentificationType(Constants.IFE);
				customerRequest.setBioOCR(customer.getBioOCR());
				customerRequest.setBioEmissionNumber(customer.getBioEmissionNumber());
				customerRequest.setBioReaderKey(customer.getBioReaderKey());
				customerRequest.setBioFingerprint(customer.getBioFingerprint());
			}
		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("cuenta : " + customer.getAccount());
				logger.logDebug("buc: " + customer.getBuc());
				logger.logDebug("id Expedinete: " + customer.getIdExpedient());
			}
			customerRequest.setAccount(customer.getAccount());
			customerRequest.setBuc(customer.getBuc());
			customerRequest.setIdExpedient(customer.getIdExpedient());
		}
		return customerRequest;

	}

	public static OnboardingCustomerRequest getOnboardingCustomerRequest(OnboardingRequest onboardingRequest) {
		OnboardingCustomerRequest onboardingCustomerRequest = new OnboardingCustomerRequest();
		onboardingCustomerRequest.setCellphoneNumber(onboardingRequest.getCellphoneNumber());
		return onboardingCustomerRequest;
	}

	public static AddressRequest getAddressRequest(Address address) {
		AddressRequest addressRequest = new AddressRequest();
		if (com.cobiscorp.mobile.model.Constants.EMAIL_ADDRESS_TYPE.equals(address.getType())) {
			addressRequest.setCustomerId(address.getCustomerId());
			addressRequest.setDescription(address.getDescription());
			addressRequest.setType(address.getType());

		} else {
			addressRequest.setCustomerId(address.getCustomerId());
			addressRequest.setColony(address.getColony());
			addressRequest.setMunicipality(address.getMunicipality());
			addressRequest.setPostalCode(address.getPostalCode());
			addressRequest.setCountry(address.getCountry());
			addressRequest.setStreet(address.getStreet());
			addressRequest.setState(address.getState());
			addressRequest.setMain(address.getMain());
			addressRequest.setType(address.getType());
			addressRequest.setInternalNumber(address.getInternalNumber());
			addressRequest.setExternalNumber(address.getExternalNumber());
			addressRequest.setLatitudeCoordinates(address.getLatitudeCoordinates());
			addressRequest.setLatitudeDegrees(address.getLatitudeDegrees());
			addressRequest.setLatitudeMinutes(address.getLatitudeMinutes());
			addressRequest.setLatitudeSeconds(address.getLatitudeSeconds());
			addressRequest.setLongitudeCoordinates(address.getLongitudeCoordinates());
			addressRequest.setLongitudeDegrees(address.getLongitudeDegrees());
			addressRequest.setLongitudeMinutes(address.getLongitudeMinutes());
			addressRequest.setLongitudeSeconds(address.getLongitudeSeconds());
			addressRequest.setPathCroquis(address.getPathCroquis());

		}

		return addressRequest;
	}

	public static Object getOutputs(Map<String, Object> outputs, String output) throws MobileServiceException {
		Object object = outputs.get(output) == null ? null : outputs.get(output).toString();
		if (object == null) {
			throw new MobileServiceException("Error al obtener datos del cliente");
		}
		return object;
	}

}
