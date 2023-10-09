
/**
 * Archivo: CustomerService.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerData;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerProduct;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Residence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//include imports with key: CustomerService.imports

public class CustomerServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService {
	private static ILogger logger = LogFactory.getLogger(CustomerServiceSERVImpl.class);
	private static final ILogger LOGGER = LogFactory.getLogger(CustomerServiceSERVImpl.class);

	// include body with key: CustomerService.body

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerData findCustomerById(Integer aId, String validateLetterN) {

		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.findCustomerById
		Request aRequest = new Request();
		Map aCustomerBuroRequest = new HashMap();
		aRequest.setInfo(new HashMap());
		aRequest.getInfo().put("aParameter", aCustomerBuroRequest);
		aCustomerBuroRequest.put("operation", "Q");
		aCustomerBuroRequest.put("subType", "4");
		aCustomerBuroRequest.put("idCustomer", aId);
		aCustomerBuroRequest.put("validateLetterN", validateLetterN);//a
		
		SpSPCustomerBuroUtil.executeSPCustomerBuro(aRequest, getSpOrchestrator());
		List<List<Map<String, Object>>> customerInfoResultSets = (List<List<Map<String, Object>>>) aRequest.getInfo().get("aResultSPCustomerBuro");
		CustomerData customerData = new CustomerData();
		if (customerInfoResultSets.size() >= 1 && !customerInfoResultSets.get(0).isEmpty()) {
			Name name = new Name();
			name.setFatherLastName((String) customerInfoResultSets.get(0).get(0).get("ApellidoPaterno"));
			name.setMotherLastName((String) customerInfoResultSets.get(0).get(0).get("ApellidoMaterno"));
			name.setFirstName((String) customerInfoResultSets.get(0).get(0).get("PrimerNombre"));
			name.setSecondName((String) customerInfoResultSets.get(0).get(0).get("SegundoNombre"));
			name.setRfc((String) customerInfoResultSets.get(0).get(0).get("RFC"));
			name.setDateOfBirth((String) customerInfoResultSets.get(0).get(0).get("FechaNacimientoFormat"));
			customerData.setName(name);
			customerData.setDateOfBirth((Date) customerInfoResultSets.get(0).get(0).get("FechaNacimientoDate"));
		}
		if (customerInfoResultSets.size() >= 2 && !customerInfoResultSets.get(1).isEmpty()) {
			Residence residence = new Residence();
			residence.setAddress1((String) customerInfoResultSets.get(1).get(0).get("Direccion"));
			residence.setColony((String) customerInfoResultSets.get(1).get(0).get("Colonia-Parroquia"));
			residence.setMunicipality((String) customerInfoResultSets.get(1).get(0).get("Municipio-Ciudad"));
			residence.setState((String) customerInfoResultSets.get(1).get(0).get("Estado-Provincia"));
			// TODO city no se encuentra a donde mapear
			residence.setCp((String) customerInfoResultSets.get(1).get(0).get("CP"));
			residence.setCodCountry((String) customerInfoResultSets.get(1).get(0).get("CodPais"));
			customerData.setResidence(residence);
		}

		// TODO solicitar la fecha directamente en el sp y no transformada
		// customerData.setDateOfBirth();
		return customerData;

	}

	public java.util.Map getCustomerDetailsById(Integer aId) {

		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.getCustomerDetailsById
		Request aRequest = new Request();
		Map aSpPersonaCons = new HashMap();
		aRequest.setInfo(new HashMap());
		aRequest.getInfo().put("aParameter", aSpPersonaCons);
		aSpPersonaCons.put("trn", 132);
		aSpPersonaCons.put("operation", "Q");
		aSpPersonaCons.put("subType", "4");
		aSpPersonaCons.put("customerId", aId);
		aSpPersonaCons.put("mode", 0);

		SpSPPersonaConsUtil.executeSPPersonaCons(aRequest, getSpOrchestrator());
		List<List<Map<String, Object>>> customerDetailResultSets = (List<List<Map<String, Object>>>) aRequest.getInfo().get("aResultSPPersonaCons");
		// solo devuelve el primer row del primer resultset
		if (customerDetailResultSets.isEmpty() && customerDetailResultSets.get(0).isEmpty()) {
			return null;
		}
		Map customerDetailsRow = customerDetailResultSets.get(0).get(0);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("customerDetailsRow:" + customerDetailsRow);
		}
		return customerDetailsRow;

	}

	public Integer getDelayGroupDays(Integer aIdGroup) {

		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.getDelayGroupDays
		String wInfo = "[CustomerServiceSERVImpl][getDelayGroupDays]";
		Integer wDelayGroupDays = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		parameterMap.put("idGroup", aIdGroup);
		Long cyclesNumnber = getCobisParameter().getParameter(null, "CRE", "DAGCA", Long.class);
		parameterMap.put("cyclesNumber", cyclesNumnber.intValue() + "");
		parameterMap.put("cycleStatus", "S");
		parameterMap.put("result", 0);

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSPQueryDelayGroupDaysUtil.executeSPQueryDelayGroupDays(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error retrieving the cycle numbers from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamSPQueryDelayGroupDays");
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_resultado");
			wDelayGroupDays = Integer.parseInt(result);
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "result --> " + result.toString());
			}

		}

		return wDelayGroupDays;

	}

	public Integer updateCustomerInfo(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.UpdateCustomerInfoRequest aCustomerInfo) {

		logger.logDebug(aCustomerInfo.getCustomerId() + "  xx " + aCustomerInfo.getIndRiskScore() + " yy " + aCustomerInfo.getRiskScore());
		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.updateCustomerInfo
		String wInfo = "[CustomerServiceSERVImpl][updateCustomerInfo]";
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		if (aCustomerInfo.getBank() != null) {
			parameterMap.put("bank", aCustomerInfo.getBank());
		}

		if (aCustomerInfo.getRiskScore() != null) {
			parameterMap.put("riskScore", aCustomerInfo.getRiskScore());
		}
		if (aCustomerInfo.getBankAccount() != null) {
			parameterMap.put("bankAccount", aCustomerInfo.getBankAccount());
		}
		parameterMap.put("execute", "S");
		if (aCustomerInfo.getStatus() != null) {
			parameterMap.put("status", aCustomerInfo.getStatus());
		}
		parameterMap.put("operationType", "B");
		if (aCustomerInfo.getCustomerId() != null) {
			parameterMap.put("customerId", aCustomerInfo.getCustomerId());
		}
		if (aCustomerInfo.getIndRiskScore() != null) {
			parameterMap.put("indRiskScore", aCustomerInfo.getIndRiskScore());
		}
		parameterMap.put("transaction", "104");
		if (logger.isDebugEnabled()) {
			logger.logError(wInfo + "MAP to Update:" + parameterMap);
		}
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSPUpdateCustomerInfoUtil.executeSPUpdateCustomerInfo(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error retrieving the cycle numbers from the DB");
			}
		}
		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.updateCustomerInfo

		return statusCode;

	}

	public String getBuroScore(Integer groupId, Integer cutomerId, String type) {
		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.getRiskScore
		String wInfo = "[CustomerServiceSERVImpl][getRiskScore]";
		String riskScore = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		// PAso de parametros
		parameterMap.put("groupId", groupId);
		parameterMap.put("clientId", cutomerId);

		parameterMap.put("result", 0);

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		if (type.equals("G")) {
			SpSPQueryRiskUtil.executeInterfaceRiskGroup(spRequest, getSpOrchestrator());
		}

		if (type.equals("I")) {
			SpSPQueryRiskUtil.executeInterfaceRiskInd(spRequest, getSpOrchestrator());
		}

		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error retrieving the cycle numbers from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamInterfaceRisk");

		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "getBuroScore-listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "getBuroScore-mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_resultado");
			riskScore = result;
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "getBuroScore-result --> " + result.toString());
			}

		}
		return riskScore;
	}

	@Override
	public Integer saveCustomerProducts(List<CustomerProduct> customerProductList) {

		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.saveCustomerProducts
		String wInfo = "[CustomerServiceSERVImpl][saveCustomerProducts]";
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		int result = 0;
		logger.logDebug(wInfo + " CustomerProductList size >>> " + (customerProductList != null ? customerProductList.size() : 0));

		if (customerProductList != null) {

			for (CustomerProduct cp : customerProductList) {// init for

				if (cp.getCustomerId() != null) {
					parameterMap.put("customerId", cp.getCustomerId());
				}

				if (cp.getBuc() != null) {
					parameterMap.put("buc", cp.getBuc());
				}
				if (cp.getContractNumber() != null) {
					parameterMap.put("contractNumber", cp.getContractNumber());
				}

				if (cp.getProductId() != null) {
					parameterMap.put("productId", cp.getProductId());
				}

				if (cp.getSubproductId() != null) {
					parameterMap.put("subproductId", cp.getSubproductId());
				}
				if (cp.getStatus() != null) {
					parameterMap.put("status", cp.getStatus());
				}

				if (cp.getCurrencyCode() != null) {
					parameterMap.put("currencyCode", cp.getCurrencyCode());
				}

				parameterMap.put("creationDate", new Date());
				parameterMap.put("operation", "I");

				if (logger.isDebugEnabled()) {
					logger.logError(wInfo + " MAP to Insert:" + parameterMap);
				}

				Request spRequest = new Request();
				requestMap.put("aParameter", parameterMap);
				spRequest.setInfo(requestMap);
				SpProductoSantanderUtil.executeSPProductoSantanderInfo(spRequest, getSpOrchestrator());
				Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
				if (statusCode != 0) {
					result = statusCode;
					if (logger.isErrorEnabled()) {
						logger.logError(wInfo + "Error executing SP");
					}
					break;// leave for
				}
			} // end for

		}

		return result;

	}

	@Override
	public Integer deleteCustomerProducts(Integer customerId) {
		// to include in code order use key:
		// cobiscloudparty.CustomerServiceImpl.deleteCustomerProducts
		String wInfo = "[CustomerServiceSERVImpl][deleteCustomerProducts]";
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		logger.logDebug(wInfo + " customerId: " + customerId);
		if (customerId != null) {
			parameterMap.put("customerId", customerId);
		}

		parameterMap.put("operation", "D");
		if (logger.isDebugEnabled()) {
			logger.logError(wInfo + " MAP to Delete:" + parameterMap);
		}
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpProductoSantanderUtil.executeSPProductoSantanderInfo(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");

		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error executing SP");
			}
		}
		return statusCode;

	}

}
