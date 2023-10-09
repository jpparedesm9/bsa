package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.CreacionLCR;
import com.cobiscorp.cloud.notificationservice.dto.CreacionLCR.Tramite;
import com.cobiscorp.cloud.notificationservice.dto.NotificacionesGenerales;
import com.cobiscorp.cloud.notificationservice.dto.report.CreacionLCRDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.Notificacion;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CreacionCreditoRevolvente extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CreacionCreditoRevolvente.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Tramite> notificacionList = new ArrayList<CreacionLCR.Tramite>();
		try {
			/*JaxbUtil jxb = new JaxbUtil();
			NotificacionesGenerales grupos = new NotificacionesGenerales();
			grupos = (NotificacionesGenerales) jxb.unmarshall(grupos, inputData);
			notificacionList = grupos.getGrupo();*/
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return notificacionList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		CreacionLCR.Tramite tramite = (Tramite) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("FECHA", new Date());
		parameters.put("Tramite", tramite.getNcTramite());
		parameters.put("FechaRegistro", tramite.getNcFechaReg());
		parameters.put("Codigo", tramite.getNcCliente());
		parameters.put("Nombre", tramite.getNcNombre());
		parameters.put("ApellidoPaterno", tramite.getNcApellidoPaterno());
		parameters.put("ApellidoMaterno", tramite.getNcApellidoMaterno());
		parameters.put("DigitoVerificador", tramite.getNcDigito());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		List<CreacionLCRDTO> dataCollection = new ArrayList<CreacionLCRDTO>();
		CreacionLCR.Tramite tramite = (CreacionLCR.Tramite) inputDto;
		CreacionLCRDTO creacion;

		if (tramite.getNcTramite() != 0 && tramite.getNcFechaReg() != null && tramite.getNcCliente() != 0 && tramite.getNcNombre() != null && tramite.getNcApellidoPaterno() != null
				&& tramite.getNcApellidoMaterno()!= null) {
			creacion = new CreacionLCRDTO(tramite.getNcTramite(), tramite.getNcFechaReg(), tramite.getNcCliente(), tramite.getNcNombre(), tramite.getNcApellidoPaterno(), tramite.getNcApellidoMaterno(), tramite.getNcDigito());
			dataCollection.add(creacion);
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		CreacionLCR.Tramite objDatos = (CreacionLCR.Tramite) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		String subject = "Notificación de Creación de Línea de Crédito Revolvente";
		String emailCC = "";
		String emailBCC = "";
		parameters.put("ID_GRUPO", new Integer(0));
		parameters.put("NOMBRE_GRUPO", "Sonia Rojas");
		parameters.put("MENSAJE", "");
		parameters.put("EMAIL_TO", objDatos.getNcCorreo());
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject); /* Se modifica en el SP(sp_notifica_grupo) en caso de ser Desembolso */

		return parameters;
	}

	public void executeByCode(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByCode Creacion LCR");
		}
		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, "Q", null, null);

			while (result.next()) {
				Integer tramite = result.getInt(1);
				LOGGER.debug("Código de Notificación: " + tramite);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cob_credito..sp_qr_ns_creacion_lcr(?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setString(1, "S");
					executeSPXml.setInt(2, tramite);
					
					ResultSet resultQuery = executeSPXml.executeQuery();
					
					LOGGER.debug("result1.." + resultQuery);
					List<CreacionLCR.Tramite> objectList = new ArrayList<CreacionLCR.Tramite>();
					CreacionLCR.Tramite tramiteLCR = new CreacionLCR.Tramite();
					while (resultQuery.next()) {
						tramiteLCR.setNcTramite(resultQuery.getInt(1));
						tramiteLCR.setNcFechaReg(resultQuery.getString(2));
						tramiteLCR.setNcCliente(resultQuery.getInt(3));
						tramiteLCR.setNcNombre(resultQuery.getString(4));
						tramiteLCR.setNcApellidoPaterno(resultQuery.getString(5));
						tramiteLCR.setNcApellidoMaterno(resultQuery.getString(6));
						tramiteLCR.setNcCorreo(resultQuery.getString(7));
						tramiteLCR.setNcDigito(resultQuery.getString(8));
						objectList.add(tramiteLCR);
					}
					
					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(tramite), objectList);
					executeNotificationGeneral(cn, executeSP, "U", tramite, "T");// Estado Terminado
				} catch (Exception e) {
					executeNotificationGeneral(cn, executeSP, "U", tramite, "F");// Estado Fallido
				}
			}
		} catch (Exception e) {
			LOGGER.error("ERROR executeByCode Creacion LCR -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByCode Creacion LCR");
			}
		}

	}

	public ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String operation, Integer tramite, String status) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification Creación CRL");
		}
		String query = "{ call cob_credito..sp_qr_ns_creacion_lcr(?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);

			if (tramite == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, tramite);
			}
			executeSP.setString(3, status);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification Creación CRL -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification Creación CRL");
			}
		}
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			executeByCode(arg0);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}

	}

}
