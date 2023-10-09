/**
 * Archivo: BuroCustomerService.java
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

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.cobiscorp.cobis.commons.converters.DateConverter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroResponse;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil;
//include imports with key: BuroCustomerService.imports
import com.cobiscorp.ecobis.cobiscloudburo.util.BuroServiceExecutor;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.ServerAddress;

public class BuroCustomerServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService {
	private static ILogger logger = LogFactory.getLogger(BuroCustomerServiceSERVImpl.class);
	private static final ILogger LOGGER = LogFactory.getLogger(BuroCustomerServiceSERVImpl.class);

	// include body with key: BuroCustomerService.body
	private IBuroCustomerUtil buroCustomerUtil;

	public void setBuroCustomerUtil(IBuroCustomerUtil buroCustomerUtil) {
		this.buroCustomerUtil = buroCustomerUtil;
	}

	public IBuroCustomerUtil getBuroCustomerUtil() {
		return this.buroCustomerUtil;
	}

	public Boolean validateRequest(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest aBuroRequest) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerServiceImpl.validateRequest
		LOGGER.logDebug("Inicio en validateRequest ");
		if (aBuroRequest.getName() == null) {
			LOGGER.logDebug("aBuroRequest.getName()--> " + aBuroRequest.getName());
			return false;
		}
		if (aBuroRequest.getName().getFirstName() == null) {
			LOGGER.logDebug("aBuroRequest.getName().getFirstName()--> " + aBuroRequest.getName().getFirstName());
			return false;
		}
		if (aBuroRequest.getName().getFatherLastName() == null) {
			LOGGER.logDebug("aBuroRequest.getName().getFatherLastName()--> " + aBuroRequest.getName().getFatherLastName());
			return false;
		}

		if (aBuroRequest.getName().getMotherLastName() == null || aBuroRequest.getName().getMotherLastName().trim().equals("")) {
			LOGGER.logDebug("aBuroRequest.getName().getMotherLastName()-->" + aBuroRequest.getName().getMotherLastName() + "<--");
			aBuroRequest.getName().setMotherLastName("");
		}
		if (aBuroRequest.getName().getRfc() == null) {
			LOGGER.logDebug("aBuroRequest.getName().getRfc()--> " + aBuroRequest.getName().getRfc());
			return false;
		}
		if (aBuroRequest.getResidence() == null) {
			LOGGER.logDebug("aBuroRequest.getName().getResidence()--> " + aBuroRequest.getResidence());
			return false;
		}
		if (aBuroRequest.getResidence().getAddress1() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getAddress1()--> " + aBuroRequest.getResidence().getAddress1());
			return false;
		}
		if (aBuroRequest.getResidence().getCodCountry() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getCodCountry()--> " + aBuroRequest.getResidence().getCodCountry());
			return false;
		}
		if (aBuroRequest.getResidence().getColony() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getColony()--> " + aBuroRequest.getResidence().getColony());
			return false;
		}
		if (aBuroRequest.getResidence().getCp() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getCp()--> " + aBuroRequest.getResidence().getCp());
			return false;
		}
		if (aBuroRequest.getResidence().getState() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getState()--> " + aBuroRequest.getResidence().getState());
			return false;
		}
		if (aBuroRequest.getResidence().getCity() == null && aBuroRequest.getResidence().getMunicipality() == null) {
			LOGGER.logDebug("aBuroRequest.getResidence().getCity()--> " + aBuroRequest.getResidence().getCity());
			return false;
		}
		return true;

	}

	public com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroResponse verify(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest aBuroRequest) {

		// to include in code order use key:
		// cobiscloudburo.BuroCustomerServiceImpl.verify

		String wInfo = "[BuroCustomerServiceSERVImpl][verify]";
		String customerBuroScore = "";
		String operationType = "";
		Boolean searchBuro = false;
		Boolean update = false;
		BuroResponse buroResponse = new BuroResponse();
		buroResponse.setSearchBuro(false);
		
		try {
			buroResponse.setProblemConsultingBuro(false);
			if (aBuroRequest.getResidence() == null) {
				throw new BusinessException(107352, "Residencia es requerida para verificar Buro");
			}
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			Map<String, Object> requestMap = new HashMap<String, Object>();

			parameterMap.put("idCobis", aBuroRequest.getIdCobis());
			parameterMap.put("operationType", "Q");
			parameterMap.put("instProc", aBuroRequest.getInstProc());
			parameterMap.put("expirationDays", aBuroRequest.getExpirationDays());

			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "aBuroRequest: " + aBuroRequest.toString());
				logger.logDebug(wInfo + "instProc: " + aBuroRequest.getInstProc());
			}

			Request spRequest = new Request();
			requestMap.put("aParameter", parameterMap);
			spRequest.setInfo(requestMap);
			SpInterfaceBuroUtil.executeInterfaceBuro(spRequest, getSpOrchestrator());
			Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
			if (statusCode != 0) {
				if (logger.isErrorEnabled()) {
					logger.logError(wInfo + "Error checking if there is the buro of the customer in our DB");
				}
			}
			List<?> listResults = (List<?>) spRequest.getInfo().get("aResultInterfaceBuro");
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "listResults --> " + listResults.toString());
			}

			logger.logDebug(wInfo + " Informacion aBuroRequest: " + aBuroRequest.toString());

			if (listResults != null && !listResults.isEmpty()) {
				List<?> interfaceBuroResult = (List<?>) listResults.get(0);
				if (!interfaceBuroResult.isEmpty()) {

					Map<?, ?> mapParams = (Map<?, ?>) interfaceBuroResult.get(0);
					String continueConsulting = (String) mapParams.get("proc_consulta");

					logger.logDebug(wInfo + "Resultado sp: " + continueConsulting);
					if (continueConsulting != null) {
						if (continueConsulting.contentEquals("S") || continueConsulting == "S") {
							Date dateCreated = (Date) mapParams.get("ib_fecha");
							long diffDays = SpUtil.diffInDayOfDates(dateCreated, new Date());
							long validDays = aBuroRequest.getExpirationDays();

							if (logger.isDebugEnabled()) {
								logger.logDebug(wInfo + "validDays:--> " + validDays);
								logger.logDebug(wInfo + "diffDays:--> " + diffDays);
							}
							if (diffDays > validDays) {
								searchBuro = true;
								update = true;
							} else {
								customerBuroScore = (Integer) mapParams.get("ib_riesgo") + "";
							}
						}
					}
				} else {
					searchBuro = true;
					update = false;
				}
			} // fin listResults != null && !listResults.isEmpty()
			logger.logDebug(wInfo + "Banderas para consulta-searchBuro: " + searchBuro);
			logger.logDebug(wInfo + "Banderas para consulta-update: " + update);

			if (searchBuro) {

				com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest buroRequest = new com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest();
				if (logger.isDebugEnabled()) {
					logger.logDebug(wInfo + "aBuroRequest --> " + aBuroRequest);
				}
				buroRequest.setName(aBuroRequest.getName());
				buroRequest.setHeader(getBuroCustomerUtil().generateHeader(aBuroRequest.getProductRequired()));
				buroRequest.setResidence(aBuroRequest.getResidence());
				if (!validateRequest(aBuroRequest)) {
					throw new BusinessException(208924, "Error de Conexión con Buró");
				}
				ServerAddress serverAddress = new ServerAddress();
				serverAddress.setIp(getCobisParameter().getParameter(null, "CRE", "BCIP", String.class));
				serverAddress.setPort(getCobisParameter().getParameter(null, "CRE", "BCPO", String.class));
				buroRequest.setServerAddress(serverAddress);
				int executeBuroFromRealService = getCobisParameter().getParameter(null, "CRE", "OBCDS", Long.class).intValue();
				com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse buroResponse1;
				if (executeBuroFromRealService == 1) {
					buroResponse1 = BuroServiceExecutor.getBuroClient(buroRequest);
				} else {
					buroResponse1 = getBuroCustomerUtil().simulateBuroExecution(buroRequest);
				}
				spRequest = new Request();
				if (update) {
					operationType = "U";
				} else {
					operationType = "I";
				}
				parameterMap.put("idCobis", aBuroRequest.getIdCobis());
				parameterMap.put("operationType", operationType);
				parameterMap.put("date", DateConverter.format(new Date(), "yyyy-MM-dd HH:mm:ss.S"));
				parameterMap.put("procedureNumber", aBuroRequest.getProcedureNumber());

				logger.logDebug("----->>>AAFolio:" + buroResponse1.getRespuesta().getPersonas().getPersona().getEncabezado().getNumeroControlConsulta());
				parameterMap.put("folio", buroResponse1.getRespuesta().getPersonas().getPersona().getEncabezado().getNumeroControlConsulta());
				//
				// try {
				// String xmlHex =
				// ZipUtil.compressToHex(buroResponse1.getResponseXml());
				// parameterMap.put("xml", xmlHex);
				// } catch (java.io.IOException e) {
				// if (logger.isErrorEnabled()) {
				// logger.logError(wInfo + "Error compressing the XML data", e);
				// }
				// }
				buroResponse.setSearchBuro(true);
				requestMap.put("aParameter", parameterMap);
				if (logger.isDebugEnabled()) {
					logger.logDebug(wInfo + "requestMap --> " + requestMap.toString());
				}
				spRequest.setInfo(requestMap);
				SpInterfaceBuroUtil.executeInterfaceBuro(spRequest, getSpOrchestrator());

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getCuentas().getCuentasList() != null) {
					// this.getBuroCustomerUtil().deleteBuroAccounts(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta account : buroResponse1.getRespuesta().getPersonas().getPersona().getCuentas().getCuentasList()) {
						this.getBuroCustomerUtil().createBuroAccount(account, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getResumenReportes().getResumenReportesList() != null) {
					// this.getBuroCustomerUtil().deleteBuroRemuseReports(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte report : buroResponse1.getRespuesta().getPersonas().getPersona().getResumenReportes().getResumenReportesList()) {
						this.getBuroCustomerUtil().createBuroResume(report, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getScoreBuroCredito().getScoreBCList() != null) {
					// this.getBuroCustomerUtil().deleteBuroScore(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC report : buroResponse1.getRespuesta().getPersonas().getPersona().getScoreBuroCredito().getScoreBCList()) {
						this.getBuroCustomerUtil().createBuroScore(report, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getEmpleos().getEmpleosList() != null) {
					// this.getBuroCustomerUtil().deleteBuroJob(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo report : buroResponse1.getRespuesta().getPersonas().getPersona().getEmpleos().getEmpleosList()) {
						this.getBuroCustomerUtil().createBuroJob(report, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getConsultasEfectuadas().getConsultasEfectuadasList() != null) {
					// this.getBuroCustomerUtil().deleteMadeQuerys(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada report : buroResponse1.getRespuesta().getPersonas().getPersona().getConsultasEfectuadas().getConsultasEfectuadasList()) {
						this.getBuroCustomerUtil().createMadeQuerys(report, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getDomicilios().getDomiciliosList() != null) {

					logger.logDebug(wInfo + "CodigoCliente --> " + aBuroRequest.getIdCobis());

					// this.getBuroCustomerUtil().deleteBuroAddress(aBuroRequest.getIdCobis());
					for (com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio report : buroResponse1.getRespuesta().getPersonas().getPersona().getDomicilios().getDomiciliosList()) {
						this.getBuroCustomerUtil().createBuroAddress(report, aBuroRequest.getIdCobis());
					}
				}

				if (buroResponse1.getRespuesta().getPersonas().getPersona().getEncabezado() != null) {

					logger.logDebug(wInfo + "CodigoCliente --> " + aBuroRequest.getIdCobis());
					this.getBuroCustomerUtil().createBuroHeader(buroResponse1.getRespuesta().getPersonas().getPersona().getEncabezado(), aBuroRequest.getIdCobis());

				}

			}

			buroResponse.setOperationType(operationType);
			LOGGER.logError("eeeeeeeeeee-buroResponse.toString(): " + buroResponse.toString());
		} catch (BusinessException e) {
			buroResponse.setProblemConsultingBuro(true);
			LOGGER.logError("eeeeeeeeeee-buroResponse.getProblemConsultingBuro():" + buroResponse.getProblemConsultingBuro());
			LOGGER.logError("Error al consultar buró", e);
			throw e;
		} catch (Exception e) {
			buroResponse.setProblemConsultingBuro(true);
			LOGGER.logError("FFFFFFFFF-buroResponse.getProblemConsultingBuro():" + buroResponse.getProblemConsultingBuro());
			LOGGER.logError("Error al consultar buró", e);
			throw new BusinessException(208924, "Error al consutar buró");
		}
		return buroResponse;
	}

}
