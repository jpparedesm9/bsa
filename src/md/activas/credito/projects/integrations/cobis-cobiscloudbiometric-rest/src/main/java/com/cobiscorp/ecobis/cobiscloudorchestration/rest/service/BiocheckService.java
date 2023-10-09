package com.cobiscorp.ecobis.cobiscloudorchestration.rest.service;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.NotFoundException;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto.Biocheck;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto.BiocheckRuleResponse;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckResponse;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerErrorRequest;
import cobiscorp.ecobis.systemconfiguration.dto.EquivalenceRequest;

public class BiocheckService extends RestService {

	private final ILogger logger = LogFactory.getLogger(BiocheckService.class);

	public BiocheckService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public BiocheckRuleResponse createBiocheckRegistry(int customerId, Biocheck biocheck) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("[createBiocheckRegistry] Creando al cliente" + customerId);
		}
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerBiocheckRequest request = biocheck.toRequest(customerId);
		request.setOperation("I");
		requestTo.addValue("inCustomerBiocheckRequest", request);
		ServiceResponse response = execute("CustomerBiocheck.CustomerBiocheck.SaveRegistry", requestTo);
		if (response.isResult() && response.getData() != null) {
			ServiceResponseTO dataResponse = (ServiceResponseTO) response.getData();
			@SuppressWarnings("unchecked")
			Map<String, String> result = (Map<String, String>) dataResponse.getValue("com.cobiscorp.cobis.cts.service.response.output");
			result.get("@o_respuesta");
			return new BiocheckRuleResponse(result.get("@o_respuesta"));
		} else {
			throw new NotFoundException("Error al guardar y obtener respuesta de regla Biocheck");
		}
	}

	public Biocheck queryBiocheckRegistry(int customerId) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("[queryBiocheckRegistry] Consultando al cliente" + customerId);
		}
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerBiocheckRequest request = new CustomerBiocheckRequest();
		request.setEnte(customerId);
		request.setOperation("Q");
		requestTo.addValue("inCustomerBiocheckRequest", request);
		ServiceResponse response = execute("CustomerBiocheck.CustomerBiocheck.QueryRegistry", requestTo);
		if (response.isResult() && response.getData() != null) {
			ServiceResponseTO dataResponse = (ServiceResponseTO) response.getData();
			CustomerBiocheckResponse[] customerBiocheckResponses = (CustomerBiocheckResponse[]) (dataResponse.getData().get("returnCustomerBiocheckResponse"));
			return new Biocheck().fromResponse(customerId, customerBiocheckResponses[0]);
		} else {
			throw new NotFoundException("Registro de Biocheck no encontrado");
		}
	}

	public Map<String, Object> queryAdditionalInfoOpaqueToken() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
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
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
					resultMap = (HashMap) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");

				}
				for (Message message : response.getMessages()) {
					logger.logError("Error en la ejecucion del servicio CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken ---> " + message.getMessage());
				}
			}

		} catch (Exception e) {
			logger.logError("Error en la consulta de informacion adicional para el Token Opaco ---> ", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-------> Finaliza queryAdditionalInfoOpaqueToken <---------");
			}
		}
		return resultMap;

	}

	public String queryCityBirth(String cityBirth) {
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
	}

	public Integer getOfficeNumber(String sesionSN) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String officeId = "0";
		if (logger.isDebugEnabled()) {
			logger.logDebug("-------> Inicia getOfficeNumber <---------");
		}
		try {
			ServiceRequestTO requestTo = new ServiceRequestTO();
			CustomerBiocheckRequest request = new CustomerBiocheckRequest();
			request.setOperation("S");
			request.setName(sesionSN);
			requestTo.addValue("inCustomerBiocheckRequest", request);

			ServiceResponse response = execute("CustomerBiocheck.CustomerBiocheck.QueryOfficeId", requestTo);
			if (response != null) {
				if (response.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
					resultMap = (HashMap) serviceResponseTO.getValue(Parameter.OUTPUT);
					if (resultMap != null) {
						officeId = resultMap.get("@o_oficina") == null ? "" : (String) resultMap.get("@o_oficina");
						logger.logDebug("Oficina ID >>" + officeId);
					}
				}

				/*
				 * for (Message message : response.getMessages()) {
				 * logger.logError("Error en la ejecucion del servicio CustomerBiocheck.CustomerBiocheck.QueryOfficeId ---> " + message.getMessage());
				 * logger.logError("Error en la ejecucion del servicio resultMap.size ---> " + resultMap.size()); }
				 */
				logger.logError("Error en la ejecucion del servicio resultMap ---> " + resultMap);
			}

		} catch (Exception e) {
			logger.logError("Error en la consulta de informacion adicional para el Token Opaco ---> ", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-------> Finaliza getOfficeNumber <---------");
			}
		}
		return new Integer(officeId);
	}

	public String validateErrorBiocheck(int customerId, String errorCode, int tramite) throws Exception {

		String mensaje = "";
		CustomerErrorRequest errorRequest = new CustomerErrorRequest();
		errorRequest.setCustomerId(customerId);
		errorRequest.setErrorCode(errorCode);
		errorRequest.setTramitId(tramite);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inCustomerErrorRequest", errorRequest);
		ServiceResponse response = execute("CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck", serviceRequestTO);

		if (response == null) {
			logger.logError("Eror al consultar equivalencias");
			throw new BusinessException(601321);
		} else {
			if (response.isResult()) {
				ServiceResponseTO dataResponse = (ServiceResponseTO) response.getData();

				Map<String, Object> output = (Map<String, Object>) dataResponse.getData().get(Parameter.OUTPUT);
				if (output != null) {
					mensaje = output.get(Parameter.OUT_RESULTADO) == null ? "" : (String) output.get(Parameter.OUT_RESULTADO);
					logger.logDebug("Resultado del Error >>" + mensaje);
				}
			} else {
				logger.logError("No se encontraron resultados");
				throw new BusinessException(601321);
			}
		}
		return mensaje;

	}

}
