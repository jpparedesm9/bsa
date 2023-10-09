package com.cobiscorp.mobile.services.impl;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.EnrollDevicelClient;
import com.cobiscorp.mobile.service.interfaces.IRegistrationService;
import com.cobiscorp.mobile.services.impl.utils.Activator;
import com.cobiscorp.mobile.services.impl.utils.KeepSecurity;

import cobiscorp.ecobis.businesstoconsumer.dto.CellphoneRegistrationRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.ValidationRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.ValidationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilebanking.dto.Ente;

@Component
@Service({ IRegistrationService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class RegistrationServiceImpl extends ServiceBase implements IRegistrationService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private ILogger logger = LogFactory.getLogger(RegistrationServiceImpl.class);

	@Override
	public Client validateOnboardCode(String code) throws MobileServiceException {
		Client client = null;

		ValidationRequest validationRequest = new ValidationRequest();
		validationRequest.setRegistrationId(code);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inValidationRequest", validationRequest);

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("*******************> validateOnboardCode : code to validate : " + code);
			}
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, logger,
					"BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation", EMPTY_COBIS_SESSION_ID,
					serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				ValidationResponse[] validationResponseList = (ValidationResponse[]) serviceResponseTO
						.getValue("returnValidationResponse");
				ValidationResponse validationResponse = validationResponseList[0];
				if (validationResponse != null && validationResponse.getCustomerId() != null) {
					client = new Client();
					client.setIdCliente(validationResponse.getCustomerId().toString());
					client.setNombres(validationResponse.getNames());
					client.setApellidos(validationResponse.getLastNames());
					client.setTelefono(validationResponse.getCellphoneNumber());
					client.setNumeroCredito(validationResponse.getLoanId());
				}
			} else {
				manageResponseError(serviceResponseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		return client;
	}

	@Override
	public void updateClientPhoneNumber(Integer clientId, String phoneNumber) throws MobileServiceException {
		CellphoneRegistrationRequest cellphoneRegistrationRequest = new CellphoneRegistrationRequest();
		cellphoneRegistrationRequest.setCustomerId(clientId);
		cellphoneRegistrationRequest.setCellphoneNumber(phoneNumber);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inCellphoneRegistrationRequest", cellphoneRegistrationRequest);

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("*******************> updateClientPhoneNumber");
				logger.logDebug("clientId : " + clientId);
				logger.logDebug("phoneNumber : " + phoneNumber);
			}
			ServiceResponseTO serviceResponse = execute(serviceIntegration, logger,
					"BusinessToConsumer.RegistrationManagement.CellphoneRegistration", EMPTY_COBIS_SESSION_ID,
					serviceRequest);
			if (serviceResponse.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("*******************> updateClientPhoneNumber : servicio ejecutado exitosamente");
				}
			} else {
				manageResponseError(serviceResponse, logger);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logError(e);
			}
			throw new MobileServiceException(e.getMessage());
		}
	}

	@Override
	public void enrollClient(EnrollDevicelClient enrolDevicelClient, boolean isEncrypted)
			throws MobileServiceException {
		logger.logDebug("*******************> enrollClient : inicio de ejecucion datos");
		Activator.loadConfig();
		Ente ente = new Ente();
		if (enrolDevicelClient.getPassword() == null) {
			throw new MobileServiceException("password parameter is required for mobile");
		}
		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
		String decryptedPass = isEncrypted ? keepSecurity.decrypt(enrolDevicelClient.getPassword())
				: enrolDevicelClient.getPassword();

		String pwd = this.cobisCrypt.enCrypt(decryptedPass, decryptedPass);
		ente.setChannel(enrolDevicelClient.getChannel());
		ente.setLogin(enrolDevicelClient.getPhoneNumber());
		ente.setEnteMis(enrolDevicelClient.getClientId());
		ente.setPassword(pwd);
		ente.setOldPhone(enrolDevicelClient.getOldPhoneNumber());
		ente.setBrandDevice(enrolDevicelClient.getBrandDevice());
		ente.setModelDevice(enrolDevicelClient.getModelDevice());
		ente.setVersionOs(enrolDevicelClient.getVersionOS());
		ente.setCarrier(enrolDevicelClient.getCarrier());
		ente.setIdCard(enrolDevicelClient.getConnectAddress());
		if (logger.isDebugEnabled()) {
			logger.logDebug("*******************> channel :" + enrolDevicelClient.getChannel());
			logger.logDebug("*******************> phoneNumber :" + enrolDevicelClient.getPhoneNumber());
			logger.logDebug("*******************> clientId :" + enrolDevicelClient.getClientId());
			logger.logDebug("*******************> pwd :" + pwd);
			logger.logDebug("*******************> oldPhoneNumber :" + enrolDevicelClient.getOldPhoneNumber());
			logger.logDebug("*******************> brandDevice :" + enrolDevicelClient.getBrandDevice());
			logger.logDebug("*******************> modelDevice :" + enrolDevicelClient.getModelDevice());
			logger.logDebug("*******************> versionOS :" + enrolDevicelClient.getVersionOS());
			logger.logDebug("*******************> carrier :" + enrolDevicelClient.getCarrier());
		}
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inEnte", ente);
		try {
			ServiceResponseTO serviceResponse = execute(serviceIntegration, logger,
					"BusinessToConsumer.RegistrationManagement.EnrollClient", EMPTY_COBIS_SESSION_ID, serviceRequest);
			if (serviceResponse.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("*******************> enrollClient : servicio ejecutado exitosamente");
				}
			} else {
				manageResponseError(serviceResponse, logger);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logError(e);
			}
			throw new MobileServiceException(e);
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = null;
	}
}
