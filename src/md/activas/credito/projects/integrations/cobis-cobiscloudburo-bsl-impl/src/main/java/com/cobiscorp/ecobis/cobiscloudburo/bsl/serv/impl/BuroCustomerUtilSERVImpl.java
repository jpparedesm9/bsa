/**
 * Archivo: BuroCustomerUtil.java
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

package com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;
import com.fasterxml.jackson.databind.ObjectMapper;

public class BuroCustomerUtilSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil {
	private static final ILogger LOGGER = LogFactory.getLogger(BuroCustomerUtilSERVImpl.class);

	// include body with key: BuroCustomerUtil.body

	public Integer createBuroAccount(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta aData, Integer aEnte) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.createBuroAccount

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroAccount]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpCuentaBuroUtil.executeCuentaBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro account data in DB");
			}
		}

		return 0;

	}

	public Integer createBuroResume(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte aData, Integer aEnte) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.createBuroResume

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroResume]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpReporteBuroUtil.executeReporteBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro report data in DB");
			}
		}
		return 0;

	}

	public Integer createBuroScore(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC aData, Integer aEnte) {

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroScore]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpScoreBuroUtil.executeScoreBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro score data in DB");
			}
		}

		return 0;

	}

	public Integer createBuroJob(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo aData, Integer aEnte) {

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroJob]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpEmpleoBuroUtil.executeEmpleoBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro job data in DB");
			}
		}

		return 0;
	}

	public Integer createMadeQuerys(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada aData, Integer aEnte) {

		String wInfo = "[BuroCustomerServiceSERVImpl][createMadeQuerys]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpConsultaEfectuadaUtil.executeConsultaBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro querys data in DB");
			}
		}

		return 0;
	}

	public Integer createBuroAddress(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio aData, Integer aEnte) {

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroAddress]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		spDireccionBuroUtil.executeDireccionBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro address data in DB");
			}
		}

		return 0;
	}

	public Integer createBuroHeader(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Encabezado aData, Integer aEnte) {

		String wInfo = "[BuroCustomerServiceSERVImpl][createBuroHeader]";
		ObjectMapper oMapper = new ObjectMapper();
		Map<String, Object> map = oMapper.convertValue(aData, Map.class);
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aEnte);
		map.put("operacion", "I");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to save: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpBuroEncabezadoUtil.executeBuroEncabezado(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error saving buro header data in DB");
			}
		}

		return 0;
	}

	public Integer deleteBuroAccounts(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.deleteBuroAccounts

		String wInfo = "[BuroCustomerServiceSERVImpl][deleteBuroAccounts]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpCuentaBuroUtil.executeCuentaBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro account data in DB");
			}
		}
		return 0;

	}

	public Integer deleteBuroRemuseReports(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.deleteBuroRemuseReports

		String wInfo = "[BuroCustomerServiceSERVImpl][deleteBuroRemuseReports]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpReporteBuroUtil.executeReporteBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro report data in DB");
			}
		}
		return 0;

	}

	public Integer deleteBuroScore(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.deleteBuroRemuseReports

		String wInfo = "[BuroCustomerServiceSERVImpl][deleteBuroScore]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpScoreBuroUtil.executeScoreBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro score data in DB");
			}
		}
		return 0;

	}

	public Integer deleteBuroJob(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.deleteBuroRemuseReports

		String wInfo = "[BuroCustomerServiceSERVImpl][deleteBuroJob]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpEmpleoBuroUtil.executeEmpleoBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro job data in DB");
			}
		}
		return 0;

	}

	public Integer deleteBuroAddress(Integer aClientId) {
		String wInfo = "[BuroCustomerServiceSERVImpl][deleteBuroAddress]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		spDireccionBuroUtil.executeDireccionBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro address data in DB");
			}
		}
		return 0;

	}

	public Integer deleteMadeQuerys(Integer aClientId) {
		String wInfo = "[BuroCustomerServiceSERVImpl][deleteMadeQuerys]";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		map.put("ente", aClientId);
		map.put("operacion", "D");
		Request spRequest = new Request();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "Map to delete: " + map);
		}
		requestMap.put("aParameter", map);
		spRequest.setInfo(requestMap);
		SpConsultaEfectuadaUtil.executeConsultaBuro(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "Error deleting buro querys data in DB");
			}
		}
		return 0;

	}

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header generateHeader(

	) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.generateHeader

		com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header wHeader = new com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header();
		wHeader.setCountryKey(getCobisParameter().getParameter(null, "CRE", "BCCP", String.class));
		wHeader.setUnitCurrencyKey(getCobisParameter().getParameter(null, "CRE", "BCUM", String.class));
		wHeader.setUserKey(getCobisParameter().getParameter(null, "CRE", "BCCU", String.class));
		wHeader.setLanguage(getCobisParameter().getParameter(null, "CRE", "BCID", String.class));
		wHeader.setContractAmount(getCobisParameter().getParameter(null, "CRE", "BCIC", String.class));
		wHeader.setOperatorReferenceNumber(getCobisParameter().getParameter(null, "CRE", "BCNO", String.class));
		wHeader.setQueryType(getCobisParameter().getParameter(null, "CRE", "BCTQ", String.class));
		wHeader.setPassword(getCobisParameter().getParameter(null, "CRE", "BCPW", String.class));
		wHeader.setRequiredProduct(getCobisParameter().getParameter(null, "CRE", "BCPR", String.class));
		wHeader.setContractType(getCobisParameter().getParameter(null, "CRE", "BCTC", String.class));
		wHeader.setOutputType(getCobisParameter().getParameter(null, "CRE", "BCTS", String.class));
		wHeader.setVersion(getCobisParameter().getParameter(null, "CRE", "BCVR", String.class));
		return wHeader;

	}

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header generateHeader(String requiredProduct) {
		com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header wHeader = new com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header();
		wHeader = generateHeader();
		wHeader.setRequiredProduct(requiredProduct);
		return wHeader;

	}

	public String getBlackList(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.getBlackList

		String wInfo = "[BuroCustomerUtil][getBlackList]";
		String wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("result", "");
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpBlackListUtil.executeBlackList(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error retrieving the black list from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamBlackList");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_resultado");
			wResult = result;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "result --> " + wResult);
			}

		}
		return wResult;

	}

	// sp_blacklistcustomer

	@Override
	public Integer getBlackListCustomer(Integer aClientId) {
		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.getBlackList

		String wInfo = "[BuroCustomerUtil][getBlackListCustomer]";
		Integer wResult = 0;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("result", "");
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpBlackListCustomerUtil.executeBlackListCustomer(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error retrieving the black list from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamBlackListCustomer");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "listParams Black list customer --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "mapParams  --> " + mapParams.toString());
			}
			LOGGER.logDebug("------------------mapParams.get(@o_resultado)1 --> " + mapParams.get("@o_resultado"));
			String result = (String) mapParams.get("@o_resultado");
			wResult = Integer.valueOf(result);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "result Black list customer --> " + wResult);
			}

		}
		return wResult;
	}

	public String getDelayPercentage(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.getDelayPercentage

		String wInfo = "[BuroCustomerUtil][getDelayPercentage]";
		String wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("result", "");
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpDelayPercentageUtil.executeDelayPercentage(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error retrieving delay percentaje from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamDelayPercentage");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_resultado");
			wResult = result;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "result --> " + wResult);
			}

		}
		return wResult;

	}

	public String isPartner(Integer aClientId) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.isPartner

		String wInfo = "[BuroCustomerUtil][isPartner]";
		String wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("result", "");
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpPartnerUtil.executePartner(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamPartner");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_resultado");
			wResult = result;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "result --> " + wResult);
			}

		}
		return wResult;

	}

	public com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse simulateBuroExecution(com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest aRequest) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.simulateBuroExecution
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse wResponse = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse();
		String xml = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><Respuesta><Personas><Persona><Encabezado><NumeroReferenciaOperador></NumeroReferenciaOperador><ClavePais>MX</ClavePais><IdentificadorBuro>0010</IdentificadorBuro><ClaveOtorgante>ZM11001029</ClaveOtorgante><ClaveRetornoConsumidorPrincipal>0</ClaveRetornoConsumidorPrincipal><ClaveRetornoConsumidorSecundario>0</ClaveRetornoConsumidorSecundario><NumeroControlConsulta>1000660802</NumeroControlConsulta></Encabezado><Nombre><ApellidoPaterno>CASANOVA</ApellidoPaterno><ApellidoMaterno>NOBEL</ApellidoMaterno><PrimerNombre>PAULINA</PrimerNombre><RFC>CANP700102UF1</RFC></Nombre><Domicilios><Domicilio><Direccion1>COLONIAN BENJAMIN MENDEZ CALLEN DE LA ES</Direccion1><ColoniaPoblacion>BENJAMIN MENDEZ</ColoniaPoblacion><DelegacionMunicipio>DGO</DelegacionMunicipio><Estado>DGO</Estado><CP>34020</CP><codPais>MX</codPais><FechaReporteDireccion>22082017</FechaReporteDireccion></Domicilio></Domicilios><Empleos/><Cuentas><Cuenta><FechaActualizacion>08092015</FechaActualizacion><NombreOtorgante>BBVABANCOMER</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><RegistroImpugnado>T</RegistroImpugnado><ClaveOtorgante>T</ClaveOtorgante><NumeroTelefonoOtorgante>T</NumeroTelefonoOtorgante><IdentificadorSociedadCrediticia>T</IdentificadorSociedadCrediticia><NumeroCuentaActual>T</NumeroCuentaActual><ValorActivoValuacion>T</ValorActivoValuacion><FechaCierreCuenta>T</FechaCierreCuenta><UltimaFechaSaldoCero>T</UltimaFechaSaldoCero><Garantia>T</Garantia><FechaMasRecienteHistoricoPagos>T</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>T</FechaMasAntiguaHistoricoPagos><TotalPagosCalificadosMOP2>T</TotalPagosCalificadosMOP2><TotalPagosCalificadosMOP3>T</TotalPagosCalificadosMOP3><TotalPagosCalificadosMOP4>T</TotalPagosCalificadosMOP4><TotalPagosCalificadosMOP5>T</TotalPagosCalificadosMOP5><MontoUltimoPago>T</MontoUltimoPago><FechaInicioReestructura>T</FechaInicioReestructura><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>2118</MontoPagar><FechaAperturaCuenta>06112014</FechaAperturaCuenta><FechaUltimoPago>10082015</FechaUltimoPago><FechaUltimaCompra>19042015</FechaUltimaCompra><FechaReporte>31082015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>35236</CreditoMaximo><SaldoActual>32583+</SaldoActual><LimiteCredito>34200</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111110</HistoricoPagos><FechaMasRecienteHistoricoPagos>31072015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30112014</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>09092015</FechaActualizacion><NombreOtorgante>TIENDA COMERCIAL</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>5480</MontoPagar><FechaAperturaCuenta>28062008</FechaAperturaCuenta><FechaUltimoPago>05072010</FechaUltimoPago><FechaUltimaCompra>05042010</FechaUltimaCompra><FechaReporte>31082015</FechaReporte><CreditoMaximo>5480</CreditoMaximo><SaldoActual>5480+</SaldoActual><LimiteCredito>100</LimiteCredito><SaldoVencido>5480</SaldoVencido><NumeroPagosVencidos>9</NumeroPagosVencidos><FormaPagoActual>97</FormaPagoActual><HistoricoPagos>999999999999999999999999</HistoricoPagos><FechaMasRecienteHistoricoPagos>31072015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31082013</FechaMasAntiguaHistoricoPagos><ClaveObservacion>UP</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>01092015</FechaActualizacion><NombreOtorgante>TIENDA COMERCIAL</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>30062014</FechaAperturaCuenta><FechaReporte>28082015</FechaReporte><ModoReportar>A</ModoReportar><SaldoActual>0+</SaldoActual><LimiteCredito>4000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>UR</FormaPagoActual><HistoricoPagos>UUUUUUUUUUUUU</HistoricoPagos><FechaMasRecienteHistoricoPagos>28072015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>28072014</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>23082015</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PN</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>2</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>350</MontoPagar><FechaAperturaCuenta>07082015</FechaAperturaCuenta><FechaUltimoPago>21082015</FechaUltimoPago><FechaUltimaCompra>08082015</FechaUltimaCompra><FechaReporte>23082015</FechaReporte><CreditoMaximo>700</CreditoMaximo><SaldoActual>350+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><FechaMasRecienteHistoricoPagos>23082015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>01011901</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>18082015</FechaActualizacion><NombreOtorgante>COMUNICACIONES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>299</MontoPagar><FechaAperturaCuenta>29082014</FechaAperturaCuenta><FechaUltimoPago>17082015</FechaUltimoPago><FechaUltimaCompra>30072015</FechaUltimaCompra><FechaReporte>17082015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>318</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>1804</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>17072015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>17082014</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>28082015</FechaActualizacion><NombreOtorgante>GUBERNAMENTALES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>18</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>854</MontoPagar><FechaAperturaCuenta>05092011</FechaAperturaCuenta><FechaUltimoPago>31122012</FechaUltimoPago><FechaUltimaCompra>05092011</FechaUltimaCompra><FechaReporte>31072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>15374</CreditoMaximo><SaldoActual>2989+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1XXX11111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>30062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>14092011</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>07082015</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>4055</MontoPagar><FechaAperturaCuenta>01082011</FechaAperturaCuenta><FechaUltimaCompra>05082011</FechaUltimaCompra><FechaReporte>31072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>34563</CreditoMaximo><SaldoActual>31062+</SaldoActual><LimiteCredito>1</LimiteCredito><SaldoVencido>19409</SaldoVencido><NumeroPagosVencidos>6</NumeroPagosVencidos><FormaPagoActual>07</FormaPagoActual><HistoricoPagos>XXXXXXXXXX1XX99999999999</HistoricoPagos><FechaMasRecienteHistoricoPagos>30062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31082011</FechaMasAntiguaHistoricoPagos><ClaveObservacion>UP</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>19409</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>15052014</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>97</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>05082015</FechaActualizacion><NombreOtorgante>COMUNICACIONES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>08092008</FechaAperturaCuenta><FechaUltimoPago>27072015</FechaUltimoPago><FechaUltimaCompra>12072015</FechaUltimaCompra><FechaReporte>31072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>1010</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>10000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>30062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092009</FechaMasAntiguaHistoricoPagos><ImporteSaldoMorosidadHistMasGrave>607</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>31012010</FechaHistoricaMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>03092015</FechaActualizacion><NombreOtorgante>SERVICIOS</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>616</MontoPagar><FechaAperturaCuenta>27082013</FechaAperturaCuenta><FechaUltimoPago>11072015</FechaUltimoPago><FechaUltimaCompra>01072015</FechaUltimaCompra><FechaReporte>31072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>0</CreditoMaximo><SaldoActual>616+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>11131114X5414131X1</HistoricoPagos><FechaMasRecienteHistoricoPagos>30062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30012014</FechaMasAntiguaHistoricoPagos><ImporteSaldoMorosidadHistMasGrave>1040</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>30092014</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>05</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>30072015</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>1651</MontoPagar><FechaAperturaCuenta>01052005</FechaAperturaCuenta><FechaUltimoPago>22072015</FechaUltimoPago><FechaUltimaCompra>21062015</FechaUltimaCompra><FechaReporte>22072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>42934</CreditoMaximo><SaldoActual>34410+</SaldoActual><LimiteCredito>42500</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1111111111111X1111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>30062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>10052012</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>14072015</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>AU</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>8</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>3591</MontoPagar><FechaAperturaCuenta>27062012</FechaAperturaCuenta><FechaUltimoPago>09072015</FechaUltimoPago><FechaUltimaCompra>27062012</FechaUltimaCompra><FechaReporte>09072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>126174</CreditoMaximo><SaldoActual>47382+</SaldoActual><SaldoVencido>0</SaldoVencido><NumeroPagosVencidos>1</NumeroPagosVencidos><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>09062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>09062012</FechaMasAntiguaHistoricoPagos><ImporteSaldoMorosidadHistMasGrave>3764</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>02062015</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>02</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>13072015</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>LR</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>683</MontoPagar><FechaAperturaCuenta>28052013</FechaAperturaCuenta><FechaUltimoPago>01072015</FechaUltimoPago><FechaUltimaCompra>04042015</FechaUltimaCompra><FechaReporte>08072015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>4385</CreditoMaximo><SaldoActual>6922+</SaldoActual><LimiteCredito>10000</LimiteCredito><SaldoVencido>0</SaldoVencido><NumeroPagosVencidos>21</NumeroPagosVencidos><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>08062015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>08042013</FechaMasAntiguaHistoricoPagos><ClaveObservacion>IA</ClaveObservacion><TotalPagosReportados>024</TotalPagosReportados><TotalPagosCalificadosMOP2>03</TotalPagosCalificadosMOP2></Cuenta><Cuenta><FechaActualizacion>17072015</FechaActualizacion><NombreOtorgante>COMUNICACIONES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>3688</MontoPagar><FechaAperturaCuenta>24112006</FechaAperturaCuenta><FechaUltimoPago>03052014</FechaUltimoPago><FechaUltimaCompra>04032014</FechaUltimaCompra><FechaReporte>30062015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>3688</CreditoMaximo><SaldoActual>3688+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>3688</SaldoVencido><NumeroPagosVencidos>13</NumeroPagosVencidos><FormaPagoActual>96</FormaPagoActual><HistoricoPagos>977777776</HistoricoPagos><FechaMasRecienteHistoricoPagos>31052015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092014</FechaMasAntiguaHistoricoPagos><ImporteSaldoMorosidadHistMasGrave>3688</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>30062015</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>96</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>19072015</FechaActualizacion><NombreOtorgante>GUBERNAMENTALES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>6</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>14</MontoPagar><FechaAperturaCuenta>01052015</FechaAperturaCuenta><FechaUltimoPago>01052015</FechaUltimoPago><FechaUltimaCompra>01052015</FechaUltimaCompra><FechaReporte>30062015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>85</CreditoMaximo><SaldoActual>82+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1</HistoricoPagos><FechaMasRecienteHistoricoPagos>30052015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30052015</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>07072015</FechaActualizacion><NombreOtorgante>COMUNICACIONES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>1470</MontoPagar><FechaAperturaCuenta>11092003</FechaAperturaCuenta><FechaUltimoPago>09062015</FechaUltimoPago><FechaUltimaCompra>22062015</FechaUltimaCompra><FechaReporte>30062015</FechaReporte><ModoReportar>A</ModoReportar><UltimaFechaSaldoCero>30062007</UltimaFechaSaldoCero><CreditoMaximo>9878</CreditoMaximo><SaldoActual>1470+</SaldoActual><LimiteCredito>10000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>12052015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092009</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>20072015</FechaActualizacion><NombreOtorgante>TIENDA COMERCIAL</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><FechaAperturaCuenta>01082005</FechaAperturaCuenta><FechaUltimoPago>09022015</FechaUltimoPago><FechaUltimaCompra>02052014</FechaUltimaCompra><FechaReporte>30062015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>3632</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>5800</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>UR</FormaPagoActual><HistoricoPagos>UUUUUUUUUUUUU111111UUUUU</HistoricoPagos><FechaMasRecienteHistoricoPagos>31052015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092009</FechaMasAntiguaHistoricoPagos><TotalPagosReportados>005</TotalPagosReportados><TotalPagosCalificadosMOP2>05</TotalPagosCalificadosMOP2></Cuenta><Cuenta><FechaActualizacion>11092015</FechaActualizacion><NombreOtorgante>CIRCULO CREDITO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>AF</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>12</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>1847</MontoPagar><FechaAperturaCuenta>22062014</FechaAperturaCuenta><FechaUltimoPago>22062014</FechaUltimoPago><FechaUltimaCompra>22062014</FechaUltimaCompra><FechaReporte>31032015</FechaReporte><CreditoMaximo>3695</CreditoMaximo><SaldoActual>3695+</SaldoActual><LimiteCredito>11964</LimiteCredito><SaldoVencido>2771</SaldoVencido><FormaPagoActual>07</FormaPagoActual><HistoricoPagos>7776</HistoricoPagos><FechaMasRecienteHistoricoPagos>28022015</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30112014</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>16012015</FechaActualizacion><NombreOtorgante>BANAMEX TC L-006</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>18072014</FechaAperturaCuenta><FechaUltimoPago>02012015</FechaUltimoPago><FechaUltimaCompra>16122014</FechaUltimaCompra><FechaCierreCuenta>02012015</FechaCierreCuenta><FechaReporte>02012015</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>2666</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>49999</LimiteCredito><SaldoVencido>0</SaldoVencido><NumeroPagosVencidos>1</NumeroPagosVencidos><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>321111</HistoricoPagos><FechaMasRecienteHistoricoPagos>31122014</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>18072014</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>894</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>31122014</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>03</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>24112014</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>30</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>28102009</FechaAperturaCuenta><FechaUltimoPago>02082010</FechaUltimoPago><FechaUltimaCompra>28102009</FechaUltimaCompra><FechaCierreCuenta>07102014</FechaCierreCuenta><FechaReporte>30092014</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>36000</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>33206</SaldoVencido><NumeroPagosVencidos>50</NumeroPagosVencidos><FormaPagoActual>96</FormaPagoActual><HistoricoPagos>999999999999999999999999</HistoricoPagos><FechaMasRecienteHistoricoPagos>31082014</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>03102009</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CV</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>33206</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>30062011</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>97</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>04092014</FechaActualizacion><NombreOtorgante>HSBC MEXICO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>27092013</FechaAperturaCuenta><FechaUltimoPago>02092014</FechaUltimoPago><FechaUltimaCompra>27092013</FechaUltimaCompra><FechaCierreCuenta>02092014</FechaCierreCuenta><FechaReporte>02092014</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>18332</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>04082014</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092013</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>18022014</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>16</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>4234</MontoPagar><FechaAperturaCuenta>01072013</FechaAperturaCuenta><FechaUltimoPago>04092013</FechaUltimoPago><FechaUltimaCompra>02072013</FechaUltimaCompra><FechaCierreCuenta>16012014</FechaCierreCuenta><FechaReporte>31012014</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>54891</CreditoMaximo><SaldoActual>40718+</SaldoActual><SaldoVencido>40718</SaldoVencido><FormaPagoActual>97</FormaPagoActual><HistoricoPagos>654322</HistoricoPagos><FechaMasRecienteHistoricoPagos>31122013</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31072013</FechaMasAntiguaHistoricoPagos><ClaveObservacion>UP</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>36037</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>31102013</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>04</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>22012014</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>PN</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>06122013</FechaAperturaCuenta><FechaUltimoPago>20122013</FechaUltimoPago><FechaUltimaCompra>07122013</FechaUltimaCompra><FechaCierreCuenta>20122013</FechaCierreCuenta><FechaReporte>31122013</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>600</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>19122013</FechaActualizacion><NombreOtorgante>SERVICIOS</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>MI</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>04082009</FechaAperturaCuenta><FechaUltimoPago>16112013</FechaUltimoPago><FechaUltimaCompra>16112013</FechaUltimaCompra><FechaCierreCuenta>30112013</FechaCierreCuenta><FechaReporte>30112013</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>422</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>740</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>31102013</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31052010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>26112013</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PN</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>36</NumeroPagos><FrecuenciaPagos>S</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>01012007</FechaAperturaCuenta><FechaUltimoPago>17082012</FechaUltimoPago><FechaUltimaCompra>17082012</FechaUltimaCompra><FechaCierreCuenta>05112013</FechaCierreCuenta><FechaReporte>05112013</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>22461</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>143000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>05102013</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31102009</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion><TotalPagosReportados>017</TotalPagosReportados><TotalPagosCalificadosMOP2>01</TotalPagosCalificadosMOP2></Cuenta><Cuenta><FechaActualizacion>06092013</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>01112010</FechaAperturaCuenta><FechaCierreCuenta>25082013</FechaCierreCuenta><FechaReporte>25082013</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>0</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>6000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>11111111111XUUUUUUUUUUUU</HistoricoPagos><FechaMasRecienteHistoricoPagos>24072013</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>24112010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>15032013</FechaActualizacion><NombreOtorgante>MICROFINANCIERA</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>12</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>14022013</FechaAperturaCuenta><FechaUltimoPago>14032013</FechaUltimoPago><FechaUltimaCompra>14032013</FechaUltimaCompra><FechaCierreCuenta>14032013</FechaCierreCuenta><FechaReporte>14032013</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>1000</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1</HistoricoPagos><FechaMasRecienteHistoricoPagos>28022013</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>28022013</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>05042012</FechaActualizacion><NombreOtorgante>COMUNICACIONES</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>07082008</FechaAperturaCuenta><FechaUltimoPago>13122011</FechaUltimoPago><FechaUltimaCompra>28032012</FechaUltimaCompra><FechaCierreCuenta>31032012</FechaCierreCuenta><FechaReporte>31032012</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>2167</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111243232121111111112112</HistoricoPagos><FechaMasRecienteHistoricoPagos>29022012</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092009</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>3207</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>31102011</FechaHistoricaMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>14032012</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>28022011</FechaAperturaCuenta><FechaUltimoPago>06032012</FechaUltimoPago><FechaUltimaCompra>28022011</FechaUltimaCompra><FechaCierreCuenta>06032012</FechaCierreCuenta><FechaReporte>06032012</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>65000</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>29022012</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>28022011</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>09022012</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>20062005</FechaAperturaCuenta><FechaUltimoPago>18012012</FechaUltimoPago><FechaUltimaCompra>27072011</FechaUltimaCompra><FechaCierreCuenta>19012012</FechaCierreCuenta><FechaReporte>31012012</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>8045</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>8600</LimiteCredito><SaldoVencido>4616</SaldoVencido><NumeroPagosVencidos>4</NumeroPagosVencidos><FormaPagoActual>97</FormaPagoActual><HistoricoPagos>543211121112111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>31122011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31102009</FechaMasAntiguaHistoricoPagos><ClaveObservacion>LC</ClaveObservacion><TotalPagosReportados>029</TotalPagosReportados><FechaHistoricaMorosidadMasGrave>31012012</FechaHistoricaMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>09022012</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>26072010</FechaAperturaCuenta><FechaUltimoPago>12012012</FechaUltimoPago><FechaUltimaCompra>12012012</FechaUltimaCompra><FechaCierreCuenta>12012012</FechaCierreCuenta><FechaReporte>31012012</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>7838</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>6544</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>UR</FormaPagoActual><HistoricoPagos>111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>30122011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>29102010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>LS</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>08022012</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>M</TipoCuenta><TipoContrato>RE</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>241</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>06042006</FechaAperturaCuenta><FechaUltimoPago>30012012</FechaUltimoPago><FechaUltimaCompra>06042006</FechaUltimaCompra><FechaCierreCuenta>30012012</FechaCierreCuenta><FechaReporte>31012012</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>424440</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>111111111111111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>31122011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092009</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>30122011</FechaActualizacion><NombreOtorgante>HSBC MEXICO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>29112011</FechaAperturaCuenta><FechaUltimoPago>21122011</FechaUltimoPago><FechaUltimaCompra>29112011</FechaUltimaCompra><FechaCierreCuenta>21122011</FechaCierreCuenta><FechaReporte>21122011</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>18500</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1</HistoricoPagos><FechaMasRecienteHistoricoPagos>30112011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30112011</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>04102011</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>16</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>08062011</FechaAperturaCuenta><FechaUltimoPago>29092011</FechaUltimoPago><FechaUltimaCompra>08062011</FechaUltimaCompra><FechaCierreCuenta>30092011</FechaCierreCuenta><FechaReporte>03102011</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>6013</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1111</HistoricoPagos><FechaMasRecienteHistoricoPagos>26092011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>05062011</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>19072011</FechaActualizacion><NombreOtorgante>SERVICIOS</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>O</TipoCuenta><TipoContrato>MI</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>17052009</FechaAperturaCuenta><FechaUltimoPago>15062011</FechaUltimoPago><FechaUltimaCompra>10062011</FechaUltimaCompra><FechaCierreCuenta>30062011</FechaCierreCuenta><FechaReporte>30062011</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>204</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>512</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1111111111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>31052011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>31052010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>10052011</FechaActualizacion><NombreOtorgante>FINANCIERA</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>02032011</FechaAperturaCuenta><FechaUltimoPago>04042011</FechaUltimoPago><FechaUltimaCompra>02032011</FechaUltimaCompra><FechaCierreCuenta>04042011</FechaCierreCuenta><FechaReporte>30042011</FechaReporte><CreditoMaximo>5667</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>0</SaldoVencido><NumeroPagosVencidos>2</NumeroPagosVencidos><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>2</HistoricoPagos><FechaMasRecienteHistoricoPagos>30032011</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30032011</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>21012011</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>16</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>28092010</FechaAperturaCuenta><FechaUltimoPago>19012011</FechaUltimoPago><FechaUltimaCompra>28092010</FechaUltimaCompra><FechaCierreCuenta>20012011</FechaCierreCuenta><FechaReporte>20012011</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>6010</CreditoMaximo><SaldoActual>0+</SaldoActual><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><HistoricoPagos>1110</HistoricoPagos><FechaMasRecienteHistoricoPagos>31122010</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>30092010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>CC</ClaveObservacion><ImporteSaldoMorosidadHistMasGrave>0</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>30092010</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>00</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>13012011</FechaActualizacion><NombreOtorgante>BANCO</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>PL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><NumeroPagos>4</NumeroPagos><FrecuenciaPagos>M</FrecuenciaPagos><MontoPagar>251</MontoPagar><FechaAperturaCuenta>24022010</FechaAperturaCuenta><FechaUltimoPago>16082010</FechaUltimoPago><FechaCierreCuenta>31122010</FechaCierreCuenta><FechaReporte>31122010</FechaReporte><ModoReportar>M</ModoReportar><CreditoMaximo>19200</CreditoMaximo><SaldoActual>19670+</SaldoActual><LimiteCredito>19200</LimiteCredito><SaldoVencido>19670</SaldoVencido><NumeroPagosVencidos>4</NumeroPagosVencidos><FormaPagoActual>97</FormaPagoActual><HistoricoPagos>9432111111</HistoricoPagos><FechaMasRecienteHistoricoPagos>30112010</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>28022010</FechaMasAntiguaHistoricoPagos><ClaveObservacion>UP</ClaveObservacion><TotalPagosReportados>010</TotalPagosReportados><TotalPagosCalificadosMOP2>01</TotalPagosCalificadosMOP2><TotalPagosCalificadosMOP3>01</TotalPagosCalificadosMOP3><TotalPagosCalificadosMOP4>01</TotalPagosCalificadosMOP4><TotalPagosCalificadosMOP5>01</TotalPagosCalificadosMOP5><ImporteSaldoMorosidadHistMasGrave>19670</ImporteSaldoMorosidadHistMasGrave><FechaHistoricaMorosidadMasGrave>31122010</FechaHistoricaMorosidadMasGrave><MopHistoricoMorosidadMasGrave>97</MopHistoricoMorosidadMasGrave></Cuenta><Cuenta><FechaActualizacion>08022011</FechaActualizacion><NombreOtorgante>FINANCIERA</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>R</TipoCuenta><TipoContrato>CL</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><FrecuenciaPagos>Z</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>04062005</FechaAperturaCuenta><FechaUltimoPago>05042006</FechaUltimoPago><FechaUltimaCompra>12072005</FechaUltimaCompra><FechaCierreCuenta>31122010</FechaCierreCuenta><FechaReporte>31122010</FechaReporte><ModoReportar>A</ModoReportar><CreditoMaximo>19377</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>15000</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><ClaveObservacion>CL</ClaveObservacion></Cuenta><Cuenta><FechaActualizacion>23092004</FechaActualizacion><NombreOtorgante>TIENDA COMERCIAL</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>AF</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>26</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>21092002</FechaAperturaCuenta><FechaUltimoPago>25032003</FechaUltimoPago><FechaUltimaCompra>21092002</FechaUltimaCompra><FechaCierreCuenta>25032003</FechaCierreCuenta><FechaReporte>23092004</FechaReporte><CreditoMaximo>2324</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><FechaMasRecienteHistoricoPagos>23092004</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>01011901</FechaMasAntiguaHistoricoPagos></Cuenta><Cuenta><FechaActualizacion>23092004</FechaActualizacion><NombreOtorgante>TIENDA COMERCIAL</NombreOtorgante><NumeroTelefonoOtorgante>1</NumeroTelefonoOtorgante><IdentificadorSociedadInformacionCrediticia>1</IdentificadorSociedadInformacionCrediticia><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><TipoCuenta>I</TipoCuenta><TipoContrato>AF</TipoContrato><ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria><NumeroPagos>26</NumeroPagos><FrecuenciaPagos>W</FrecuenciaPagos><MontoPagar>0</MontoPagar><FechaAperturaCuenta>16012003</FechaAperturaCuenta><FechaUltimoPago>01082003</FechaUltimoPago><FechaUltimaCompra>16012003</FechaUltimaCompra><FechaCierreCuenta>01082003</FechaCierreCuenta><FechaReporte>23092004</FechaReporte><CreditoMaximo>1762</CreditoMaximo><SaldoActual>0+</SaldoActual><LimiteCredito>0</LimiteCredito><SaldoVencido>0</SaldoVencido><FormaPagoActual>01</FormaPagoActual><FechaMasRecienteHistoricoPagos>23092004</FechaMasRecienteHistoricoPagos><FechaMasAntiguaHistoricoPagos>01011901</FechaMasAntiguaHistoricoPagos></Cuenta></Cuentas><ConsultasEfectuadas><ConsultaEfectuada><FechaConsulta>22082017</FechaConsulta><ClaveOtorgante>ZM11001029</ClaveOtorgante><NombreOtorgante>BANCO SANTANDER</NombreOtorgante><TipoContrato>SE</TipoContrato><ImporteContrato>0</ImporteContrato><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><ConsumidorNuevo>Y</ConsumidorNuevo><ResultadoFinal>0</ResultadoFinal><IdentificadorOrigenConsulta>0</IdentificadorOrigenConsulta></ConsultaEfectuada><ConsultaEfectuada><FechaConsulta>10082011</FechaConsulta><NombreOtorgante>BANAMEX</NombreOtorgante><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><ImporteContrato>100</ImporteContrato><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><ResultadoFinal>1</ResultadoFinal><IdentificadorOrigenConsulta>1</IdentificadorOrigenConsulta></ConsultaEfectuada><ConsultaEfectuada><FechaConsulta>17062011</FechaConsulta><NombreOtorgante>BANAMEX</NombreOtorgante><TipoContrato>CC</TipoContrato><ClaveUnidadMonetaria>N$</ClaveUnidadMonetaria><ImporteContrato>100</ImporteContrato><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><ResultadoFinal>1</ResultadoFinal><IdentificadorOrigenConsulta>1</IdentificadorOrigenConsulta></ConsultaEfectuada><ConsultaEfectuada><FechaConsulta>23012011</FechaConsulta><NombreOtorgante>BANAMEX</NombreOtorgante><TipoContrato>CC</TipoContrato><ImporteContrato>0</ImporteContrato><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><ResultadoFinal>1</ResultadoFinal><IdentificadorOrigenConsulta>1</IdentificadorOrigenConsulta></ConsultaEfectuada><ConsultaEfectuada><FechaConsulta>17082010</FechaConsulta><NombreOtorgante>FINCOMUN</NombreOtorgante><TelefonoOtorgante>5552001600</TelefonoOtorgante><TipoContrato>SE</TipoContrato><ImporteContrato>0</ImporteContrato><IndicadorTipoResponsabilidad>I</IndicadorTipoResponsabilidad><ResultadoFinal>1</ResultadoFinal><IdentificadorOrigenConsulta>1</IdentificadorOrigenConsulta></ConsultaEfectuada></ConsultasEfectuadas><ResumenReporte><ResumenReporte><FechaIngresoBD>22082017</FechaIngresoBD><NumeroMOP7>02</NumeroMOP7><NumeroMOP6>00</NumeroMOP6><NumeroMOP5>00</NumeroMOP5><NumeroMOP4>00</NumeroMOP4><NumeroMOP3>00</NumeroMOP3><NumeroMOP2>00</NumeroMOP2><NumeroMOP1>29</NumeroMOP1><NumeroMOP0>00</NumeroMOP0><NumeroMOPUR>03</NumeroMOPUR><NumeroCuentas>0040</NumeroCuentas><CuentasPagosFijosHipotecas>0020</CuentasPagosFijosHipotecas><CuentasRevolventesAbiertas>0020</CuentasRevolventesAbiertas><CuentasCerradas>0023</CuentasCerradas><CuentasNegativasActuales>0008</CuentasNegativasActuales><CuentasClavesHistoriaNegativa>0004</CuentasClavesHistoriaNegativa><CuentasDisputa>00</CuentasDisputa><NumeroSolicitudesUltimos6Meses>00</NumeroSolicitudesUltimos6Meses><NuevaDireccionReportadaUltimos60Dias>Y</NuevaDireccionReportadaUltimos60Dias><MensajesAlerta>NNNNN</MensajesAlerta><ExistenciaDeclaracionesConsumidor>N</ExistenciaDeclaracionesConsumidor><TipoMoneda>MX</TipoMoneda><TotalCreditosMaximosRevolventes>000136739</TotalCreditosMaximosRevolventes><TotalLimitesCreditoRevolventes>000108565</TotalLimitesCreditoRevolventes><TotalSaldosActualesRevolventes>000109309+</TotalSaldosActualesRevolventes><TotalSaldosVencidosRevolventes>000033193</TotalSaldosVencidosRevolventes><TotalPagosRevolventes>000019377</TotalPagosRevolventes><PctLimiteCreditoUtilizadoRevolventes>101</PctLimiteCreditoUtilizadoRevolventes><TotalCreditosMaximosPagosFijos>000150413</TotalCreditosMaximosPagosFijos><TotalSaldosActualesPagosFijos>000061420+</TotalSaldosActualesPagosFijos><TotalSaldosVencidosPagosFijos>000096365</TotalSaldosVencidosPagosFijos><TotalPagosPagosFijos>000007339</TotalPagosPagosFijos><NumeroMOP96>02</NumeroMOP96><NumeroMOP97>04</NumeroMOP97><NumeroMOP99>00</NumeroMOP99><FechaAperturaCuentaMasAntigua>21092002</FechaAperturaCuentaMasAntigua><FechaAperturaCuentaMasReciente>07082015</FechaAperturaCuentaMasReciente><TotalSolicitudesReporte>04</TotalSolicitudesReporte><FechaSolicitudReporteMasReciente>23012011</FechaSolicitudReporteMasReciente><NumeroTotalCuentasDespachoCobranza>00</NumeroTotalCuentasDespachoCobranza><FechaAperturaCuentaMasRecienteDespachoCobranza>00000000\n"
				+ "                    </FechaAperturaCuentaMasRecienteDespachoCobranza><NumeroTotalSolicitudesDespachosCobranza>00</NumeroTotalSolicitudesDespachosCobranza><FechaSolicitudMasRecienteDespachoCobranza>00000000</FechaSolicitudMasRecienteDespachoCobranza></ResumenReporte></ResumenReporte><HawkAlertaConsulta><HawkAlertConsulta><FechaReporte>22082017</FechaReporte><CodigoClave>000</CodigoClave><Mensaje>SISTEMA HAWK NO DISPONIBLE</Mensaje></HawkAlertConsulta></HawkAlertaConsulta><HakwAlertaBaseDatos/><declaracionesCliente/><ScoreBuroCredito><ScoreBC><ValorScore>70</ValorScore></ScoreBC></ScoreBuroCredito></Persona></Personas></Respuesta>\n";
		wResponse.setResponseXml(xml);
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Respuesta respuesta = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Respuesta();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Personas personas = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Personas();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Persona persona = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Persona();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuentas cuentas = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuentas();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta> listCuenta = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta cuenta = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Encabezado encabezado = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Encabezado();
		cuenta.setFechaActualizacion("20170707");
		cuenta.setRegistroImpugnado("1");// NULL
		cuenta.setClaveOtorgante("XX99999999");
		cuenta.setNombreOtorgante("BC 1TN");
		cuenta.setNumeroTelefonoOtorgante("1");
		cuenta.setIdentificadorSociedadCrediticia("1");// NULL
		cuenta.setNumeroCuentaActual("989898121212");
		cuenta.setIndicadorTipoResponsabilidad("I");
		cuenta.setTipoCuenta("I");
		cuenta.setTipoContrato("AU");
		cuenta.setClaveUnidadMonetaria("MX");
		cuenta.setValorActivoValuacion("775");
		cuenta.setNumeroPagos("48");
		cuenta.setFrecuenciaPagos("M");
		cuenta.setMontoPagar("2000");
		cuenta.setFechaAperturaCuenta("01012016");
		cuenta.setFechaUltimoPago("01012016");
		cuenta.setFechaUltimaCompra("01012016");
		cuenta.setFechaCierreCuenta("17102014");
		cuenta.setFechaReporte("09052016");
		cuenta.setModoReportar("M");
		cuenta.setUltimaFechaSaldoCero("22102007");
		cuenta.setGarantia("1");// NULL
		cuenta.setCreditoMaximo("5000");
		cuenta.setSaldoActual("3000");
		cuenta.setLimiteCredito("50000");
		cuenta.setSaldoVencido("0");
		cuenta.setNumeroPagosVencidos("4");
		cuenta.setFormaPagoActual("00");
		cuenta.setHistoricoPagos("111111111111111111111111");
		cuenta.setFechaMasRecienteHistoricoPagos("30062015");
		cuenta.setFechaMasAntiguaHistoricoPagos("31082011");
		cuenta.setClaveObservacion("IA");
		cuenta.setTotalPagosReportados("024");
		cuenta.setTotalPagosCalificadosMOP2("03");
		cuenta.setTotalPagosCalificadosMOP3("02");
		cuenta.setTotalPagosCalificadosMOP4("01");
		cuenta.setTotalPagosCalificadosMOP5("99");
		cuenta.setImporteSaldoMorosidadHistMasGrave("438");
		cuenta.setFechaHistoricaMorosidadMasGrave("30112010");
		cuenta.setMopHistoricoMorosidadMasGrave("02");
		cuenta.setMontoUltimoPago("2000");
		cuenta.setFechaInicioReestructura("30112010");// NULL
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReportes resumenReportes = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReportes();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte> resumenReporteList = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte resumenReporte = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte();
		resumenReporte.setFechaIngresoBD("T");
		resumenReporte.setNumeroMOP7("T");
		resumenReporte.setNumeroMOP6("T");
		resumenReporte.setNumeroMOP5("T");
		resumenReporte.setNumeroMOP4("T");
		resumenReporte.setNumeroMOP3("T");
		resumenReporte.setNumeroMOP2("T");
		resumenReporte.setNumeroMOP1("T");
		resumenReporte.setNumeroMOP0("T");
		resumenReporte.setNumeroMOPUR("T");
		resumenReporte.setNumeroCuentas("T");
		resumenReporte.setCuentasPagosFijosHipotecas("T");
		resumenReporte.setCuentasRevolventesAbiertas("T");
		resumenReporte.setCuentasCerradas("T");
		resumenReporte.setCuentasNegativasActuales("T");
		resumenReporte.setCuentasClavesHistoriaNegativa("T");
		resumenReporte.setCuentasDisputa("T");
		resumenReporte.setNumeroSolicitudesUltimos6Meses("T");
		resumenReporte.setNuevaDireccionReportadaUltimos60Dias("T");
		resumenReporte.setMensajesAlerta("T");
		resumenReporte.setExistenciaDeclaracionesConsumidor("T");
		resumenReporte.setTipoMoneda("T");
		resumenReporte.setTotalCreditosMaximosRevolventes("T");
		resumenReporte.setTotalLimitesCreditoRevolventes("T");
		resumenReporte.setTotalSaldosActualesRevolventes("T");
		resumenReporte.setTotalSaldosVencidosRevolventes("T");
		resumenReporte.setTotalPagosRevolventes("T");
		resumenReporte.setPctLimiteCreditoUtilizadoRevolventes("T");
		resumenReporte.setTotalCreditosMaximosPagosFijos("T");
		resumenReporte.setTotalSaldosActualesPagosFijos("T");
		resumenReporte.setTotalSaldosVencidosPagosFijos("T");
		resumenReporte.setTotalPagosPagosFijos("T");
		resumenReporte.setNumeroMOP96("T");
		resumenReporte.setNumeroMOP97("T");
		resumenReporte.setNumeroMOP99("T");
		resumenReporte.setFechaAperturaCuentaMasAntigua("T");
		resumenReporte.setFechaAperturaCuentaMasReciente("T");
		resumenReporte.setTotalSolicitudesReporte("T");
		resumenReporte.setFechaSolicitudReporteMasReciente("T");
		resumenReporte.setNumeroTotalCuentasDespachoCobranza("T");
		resumenReporte.setFechaAperturaCuentaMasRecienteDespachoCobranza("T");
		resumenReporte.setNumeroTotalSolicitudesDespachosCobranza("T");
		resumenReporte.setFechaSolicitudMasRecienteDespachoCobranza("T");
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBuroCredito scoreBuroCredito = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBuroCredito();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC scoreBC = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC> scoreBCList = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo empleoBC = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo> empleoBCList = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleos empleos = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleos();

		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada consultaBC = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada> consultaBCList = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultasEfectuadas consultasBuros = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultasEfectuadas();

		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio domicilioBC = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio();
		List<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio> domicilioBCList = new ArrayList<com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio>();
		com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilios domiciliosBuro = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilios();

		scoreBC.setValorScore("705");
		scoreBC.setNombreScore("BC SCORE");
		scoreBC.setCodigoScore("017");

		scoreBC.setCodigoError("00");
		scoreBC.setCodigoRazon("000");

		empleoBC.setCiudad("IXTAPALUCA");
		empleoBC.setCodigoPais("MX");
		empleoBC.setNombreEmpresa("TRABAJADOR INDEPENDIENTE");
		empleoBC.setDireccionUno("CDA NVO MEXICO 6 SN");
		empleoBC.setColoniaPoblacion("LA ERA");
		empleoBC.setDelegacionMunicipio("IXTAPALUCA");
		empleoBC.setCodigoPostal("56530");

		consultaBC.setFechaConsulta("07032018");
		consultaBC.setClaveOtorgante("BB89251002");
		consultaBC.setNombreOtorgante("INCLUSION FIN");
		consultaBC.setTipoContrato("SE");
		consultaBC.setImporteContrato("000000000");
		consultaBC.setIndicadorTipoResponsabilidad("I");
		consultaBC.setResultadoFinal("0");
		consultaBC.setIdentificadorOrigenConsulta("0");

		Random random = new Random();

		String folio = "";
		while (folio.length() < 10) {
			int randomInt = random.nextInt(9);
			folio = folio + randomInt;
		}
		encabezado.setNumeroControlConsulta(folio);

		domicilioBC.setDireccionUno("CDA LA LADERA MZ 7 LT 1");
		domicilioBC.setDireccionDos("AV CENTRAL Y LA PAZ");
		domicilioBC.setColoniaPoblacion("SANTO DOMINGO");
		domicilioBC.setDelegacionMunicipio("CHIMALHUACAN");
		domicilioBC.setCiudad("ACTOPAN");
		domicilioBC.setEstado("EM");
		domicilioBC.setCodigoPostal("56337");
		domicilioBC.setNumeroTelefono("5535936848");
		domicilioBC.setTipoDomicilio("H");
		domicilioBC.setIndicadorEspecialDomicilio("K");
		domicilioBC.setCodPais("MX");
		domicilioBC.setFechaReporteDireccion("13012014");

		wResponse.setRespuesta(respuesta);
		respuesta.setPersonas(personas);
		personas.setPersona(persona);
		persona.setCuentas(cuentas);
		listCuenta.add(cuenta);
		cuentas.setCuentasList(listCuenta);
		persona.setResumenReportes(resumenReportes);
		resumenReporteList.add(resumenReporte);
		resumenReportes.setResumenReportesList(resumenReporteList);
		persona.setScoreBuroCredito(scoreBuroCredito);
		scoreBCList.add(scoreBC);
		scoreBuroCredito.setScoreBCList(scoreBCList);
		persona.setEmpleos(empleos);
		empleoBCList.add(empleoBC);
		empleos.setEmpleosList(empleoBCList);
		persona.setConsultasEfectuadas(consultasBuros);
		persona.setEncabezado(encabezado);
		consultaBCList.add(consultaBC);
		consultasBuros.setConsultasEfectuadasList(consultaBCList);
		domicilioBCList.add(domicilioBC);
		domiciliosBuro.setDomiciliosList(domicilioBCList);
		persona.setDomicilios(domiciliosBuro);
		return wResponse;

	}

	public String riesgoIndExt(Integer aClientId, Integer validDaysBuro, String typeRatingCustomerEval, String evaluateRule) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerUtilImpl.riesgoIndExt

		String wInfo = "[BuroCustomerUtil][riesgoIndExt]";
		String wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("validityBureauDays", validDaysBuro);
		parameterMap.put("typeRatingCustomerEvaluation", typeRatingCustomerEval);
		parameterMap.put("evaluateRule", evaluateRule);
		parameterMap.put("result", "");
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpRiesgoIndExtUtil.executeRiesgoIndExt(spRequest, getSpOrchestrator());
		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug("StatusCode String -- riesgoIndExt: " + statusCode);
		if (statusCode != null) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
			}
		}
		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamRiesgoIndExt");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());
		}
		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			}
			String result = (String) mapParams.get("@o_nivel");
			wResult = result;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "result --> " + wResult);
			}

		}
		return wResult;

	}

	// caso #168293 Flujo de originación Auto onboarding
	public Double digCustomerCreditAmount(Integer aClientId) {
		String wInfo = "[BuroCustomerUtil][digCustomerCreditAmount]";
		Double wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("reglaId", "MONINDCLID");
		parameterMap.put("result", "");

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpCreditAmountRuleUtil.executeCreditAmountRule(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug(wInfo + "StatusCode String: " + statusCode);

		if (statusCode != null) {
			LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamCreditAmountRule");
		LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			String result = (String) mapParams.get("@o_monto");
			wResult = Double.valueOf(result);
			LOGGER.logDebug(wInfo + "result --> " + wResult);

		}
		return wResult;

	}

	// caso #168293 Flujo de originación Auto onboarding
	public String digCustomerQualification(Integer aClientId) {
		String wInfo = "[BuroCustomerUtil][digCustomerQualification]";
		String wResult = null;
		String result = null;
		String resultFlagContinue = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("reglaId", "BUROCALDIG");
		parameterMap.put("result", "");

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpQualifBureauRuleUtil.executeQualificationBureauRule(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug(wInfo + "StatusCode String: " + statusCode);

		if (statusCode != null) {
			LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamQualificationBureauRule");
		LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			result = (String) mapParams.get("@o_calif_riesgo");
			resultFlagContinue = (String) mapParams.get("@o_continua");
			wResult = result + ";" + resultFlagContinue;
			LOGGER.logDebug(wInfo + "result --> " + wResult);

		}
		return wResult;

	}

	// caso #168293 Flujo de originación Auto onboarding
	public String riesgoIndividual(Integer aClientId) {
		String wInfo = "[BuroCustomerUtil][riesgoIndividual]";
		String wResult = null;
		String result = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("reglaId", "RIESGO_IND");
		parameterMap.put("result", "");

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpIndividualRiskRuleUtil.executeIndividualRiskRule(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug(wInfo + "StatusCode String: " + statusCode);

		if (statusCode != null) {
			LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamIndividualRiskRule");
		LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			result = (String) mapParams.get("@o_continua");
			wResult = result;
			LOGGER.logDebug(wInfo + "result --> " + wResult);

		}
		return wResult;

	}

	// caso #168293 Flujo de originación Auto onboarding
	public String generateMatrix(Integer aClientId) {
		String wInfo = "[BuroCustomerUtil][generateMatrix]";
		String wResult = null;
		String result = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("opcionId", "GM");
		parameterMap.put("result", "");

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpGenerateMatrixUtil.executeGenerateMatriz(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug(wInfo + "StatusCode String: " + statusCode);

		if (statusCode != null) {
			LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamGenerateMatriz");
		LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			result = (String) mapParams.get("@o_continua");
			wResult = result;
			LOGGER.logDebug(wInfo + "result --> " + wResult);

		}
		return wResult;

	}

	// caso203112 Nueva validacion de reglas para un cliente
	public Map<?, ?> newCustomeRulesEvaluation(Map<String, Object> parameterMap) {
		String wInfo = "[BuroCustomerUtilSERVImpl][newCustomeRulesEvaluation]";
		Map<?, ?> mapParams = null;

		Map<String, Object> requestMap = new HashMap<String, Object>();

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpRuleCalifCli.executeRuleCalifCli(spRequest, getSpOrchestrator());

		Integer statusCodeRuleCalifCli = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCodeRuleCalifCli != 0) {
			if (LOGGER.isErrorEnabled()) {
				LOGGER.logError(wInfo + "Error checking if there is the executeRuleCalifCli in our DB");
			}
		}

		List<?> listResults = (List<?>) spRequest.getInfo().get("aParamRuleCalifCli");

		LOGGER.logDebug(wInfo + " listResults: " + listResults);

		if (listResults.get(0) != null)
			mapParams = (Map<?, ?>) listResults.get(0);

		return mapParams;
	}

	// Llama a lo mismo del metodo riesgoIndExt, pero devuelve un mapa
	public Map<?, ?> riesgoIndExtMap(Map<String, Object> parameterMap) {
		String wInfo = "[BuroCustomerUtil][riesgoIndExtMap]";
		Map<?, ?> mapParams = null;

		Map<String, Object> requestMap = new HashMap<String, Object>();

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpRiesgoIndExtUtil.executeRiesgoIndExt(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug("StatusCode String -- riesgoIndExtMap: " + statusCode);
		if (statusCode != null) {
			if (LOGGER.isErrorEnabled())
				LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamRiesgoIndExt");
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null)
			mapParams = (Map<?, ?>) listParams.get(0);

		return mapParams;

	}

	// caso #193221 B2B Grupal Digital
	public Double customerAmountApproved(Integer aClientId) {
		String wInfo = "[BuroCustomerUtil][customerAmountApproved]";
		Double wResult = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		parameterMap.put("clientId", aClientId);
		parameterMap.put("operacion", "C");
		parameterMap.put("result", "");

		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);

		SpAmountApprovedUtil.executeAmountApproved(spRequest, getSpOrchestrator());

		String statusCode = spRequest.getInfo().get("statusCode").toString();
		LOGGER.logDebug(wInfo + "StatusCode String: " + statusCode);

		if (statusCode != null && !"0".equals(statusCode)) {
			LOGGER.logError(wInfo + "Error retrieving if is partner from the DB");
		}

		List<?> listParams = (List<?>) spRequest.getInfo().get("aParamAmountApproved");
		LOGGER.logDebug(wInfo + "listParams --> " + listParams.toString());

		if (listParams.get(0) != null) {
			Map<?, ?> mapParams = (Map<?, ?>) listParams.get(0);
			LOGGER.logDebug(wInfo + "mapParams --> " + mapParams.toString());
			String result = (String) mapParams.get("@o_monto");
			wResult = Double.valueOf(result);
			LOGGER.logDebug(wInfo + "result --> " + wResult);

		}
		return wResult;
	}

}
