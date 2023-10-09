package com.cobiscorp.mobile.services.impl;

import java.security.Key;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.request.BeneficiaryLifeInsuranceRequest;
import com.cobiscorp.mobile.request.LifeInsuranceResquest;
import com.cobiscorp.mobile.service.interfaces.ILifeInsurance;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.CreateLifeInsuranceRequest;

@Component
@Service({ ILifeInsurance.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class LifeInsuranceImpl extends ServiceBase implements ILifeInsurance {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private static final String ID_APPLICATION = "bancaMovil";

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> LifeInsuranceImpl] ";

	/** Logger. */
	private ILogger LOGGER = LogFactory.getLogger(LifeInsuranceImpl.class);

	private Map<String, Key> privateKeysMap;

	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	@Override
	public ServiceResponseTO saveLifeInsuranceImp(LifeInsuranceResquest lifeInsuranceResquest, String cobisSessionId)
			throws MobileServiceException {
		try {
			LOGGER.logDebug(">>>>>>>>>>>metodo lifeInsuranceImp ");
			LOGGER.logDebug(">>>>>>>>>>>metodo lifeInsuranceImp -- llamar al servicio");
			BaseResponse baseResponse = new BaseResponse();
			ServiceRequestTO requestTo = new ServiceRequestTO();
			ServiceResponseTO response = new ServiceResponseTO();

			CreateLifeInsuranceRequest createLifeInsuranceRequest = new CreateLifeInsuranceRequest();
			createLifeInsuranceRequest.setTramiteId(lifeInsuranceResquest.getTramiteId());
			createLifeInsuranceRequest.setClientId(lifeInsuranceResquest.getClientId());
			createLifeInsuranceRequest.setAccept(lifeInsuranceResquest.getAccept());
			createLifeInsuranceRequest.setOtorgo(lifeInsuranceResquest.getOtorgo());
			createLifeInsuranceRequest.setOperation("I");
			lifeInsuranceResquest.setBiometricCode(lifeInsuranceResquest.getBiometricCode());

			for (BeneficiaryLifeInsuranceRequest list : lifeInsuranceResquest.getListBeneficiary()) {
				createLifeInsuranceRequest.setBeneficiaryName(list.getBeneficiaryName());
				createLifeInsuranceRequest.setPercentage(list.getPercentage());
				createLifeInsuranceRequest.setRelationshipId(list.getRelationshipId());
				requestTo.addValue("inCreateLifeInsuranceRequest", createLifeInsuranceRequest);
				response = execute(serviceIntegration, LOGGER, "IndividualLoan.OnBoarding.CreateLifeInsurance",
						cobisSessionId, requestTo);
				LOGGER.logDebug(">>>>>>>>>>>Consumo del servicio" + response);
			}

			if (response.isSuccess()) {
				createLifeInsuranceRequest.setOperation("U");
				requestTo.addValue("inCreateLifeInsuranceRequest", createLifeInsuranceRequest);
				response = execute(this.serviceIntegration, this.LOGGER,
						"IndividualLoan.OnBoarding.CreateLifeInsurance", cobisSessionId, requestTo);
				if (response.isSuccess()) {
					LOGGER.logInfo("Response saveLifeInsuranceImp Operation U");
					return response;
				} else {
					LOGGER.logInfo("Response Error saveLifeInsuranceImp Operation U");
					manageResponseError(response, LOGGER);
					return null;
				}
			} else {
				LOGGER.logInfo("Response Error saveLifeInsuranceImp Operation I");
				manageResponseError(response, LOGGER);
				return null;
			}

		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public Map<String, Key> getPrivateKeysMap() {
		return this.privateKeysMap;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
