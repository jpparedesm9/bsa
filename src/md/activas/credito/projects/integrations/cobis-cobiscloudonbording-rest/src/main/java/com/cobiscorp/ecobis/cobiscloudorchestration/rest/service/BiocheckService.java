package com.cobiscorp.ecobis.cobiscloudorchestration.rest.service;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.NotFoundException;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudonboard.util.constants.Parameter;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckResponse;
import cobiscorp.ecobis.systemconfiguration.dto.EquivalenceRequest;

public class BiocheckService extends RestService {

	private final ILogger logger = LogFactory.getLogger(BiocheckService.class);
	
	public BiocheckService(ICTSServiceIntegration integration) {
		super(integration);
	}

	
	
	public Map<String, Object> queryAdditionalInfoOpaqueToken() {
		Map <String,Object> resultMap = new HashMap<String, Object>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("-------> Inicia queryAdditionalInfoOpaqueToken <---------");
		}
		try {
			ServiceRequestTO requestTo = new ServiceRequestTO();
			CustomerBiocheckRequest request = new CustomerBiocheckRequest();
			request.setOperation("X");
			requestTo.addValue("inCustomerBiocheckRequest", request);
			
			ServiceResponse response = execute("CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken", requestTo);
			if (response != null) {
		        if (response.isResult()) {
		          ServiceResponseTO serviceResponseTO = (ServiceResponseTO)response.getData();
		          resultMap = (HashMap)serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");

		        }
		        for (Message message : response.getMessages()) {
		        	logger.logError("Error en la ejecucion del servicio CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken ---> " + message.getMessage());
		        }
		      }
			
		}catch(Exception e) {
			logger.logError("Error en la consulta de informacion adicional para el Token Opaco ---> ", e);
		}finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-------> Finaliza queryAdditionalInfoOpaqueToken <---------");
			}
		}
		return resultMap;
		
	}
	
	/*public String queryCityBirth(String cityBirth) {
		String equivalence = "";
		EquivalenceRequest equivalenceRequest = new EquivalenceRequest();
		equivalenceRequest.setCatalog(Parameter.CATALOG_FED);
		equivalenceRequest.setCatalog1(Parameter.CATALOG_CURP);
		equivalenceRequest.setEquivalence(cityBirth);
		equivalenceRequest.setMode(1);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inEquivalenceRequest", equivalenceRequest);

		ServiceResponse serviceResponseEquiv = this.execute(getIntegration(), logger, Parameter.QUERY_EQUIVALENCES, serviceRequestTO);
		if (serviceResponseEquiv == null) {
			logger.logError("Eror al consultar equivalencias");
			throw new BusinessException(601321);
		} else {
			if (serviceResponseEquiv.isResult()) {
				ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponseEquiv.getData();

				Map<String, Object> output = (Map<String, Object>) dataResponse.getData().get(Parameter.OUTPUT);
				if (output != null) {
					equivalence = output.get(Parameter.OUT_VALOR_EQUIV) == null ? "" : (String) output.get(Parameter.OUT_VALOR_EQUIV);
					logger.logDebug("Equivalencia >>" + equivalence);
				}
			} else {
				logger.logError("No se encontraron equivalencias");
				throw new BusinessException(601321);
			}
		}
		return equivalence;
	}*/

}
