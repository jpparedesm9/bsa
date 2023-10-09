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

import com.cobiscorp.cloud.notificationservice.dto.RechazoLCR;
import com.cobiscorp.cloud.notificationservice.dto.RechazoLCR.Tramite;
import com.cobiscorp.cloud.notificationservice.dto.report.Rechazo;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class RechazoCreditoRevolvente extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(RechazoCreditoRevolvente.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Tramite> notificacionList = new ArrayList<RechazoLCR.Tramite>();
		try {
			/*JaxbUtil jxb = new JaxbUtil();
			RechazoLCR grupos = new RechazoLCR();
			grupos = (RechazoLCR) jxb.unmarshall(grupos, inputData);
			//notificacionList = grupos.getGrupo();*/
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return notificacionList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		RechazoLCR.Tramite tramite = (Tramite) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("FECHA", new Date());
		parameters.put("Tramite", tramite.getNlTramite());
		parameters.put("FechaRegistro", tramite.getNlFechaReg());
		parameters.put("Codigo", tramite.getNlCliente());
		parameters.put("Nombre", tramite.getNlNombre());
		parameters.put("ApellidoPaterno", tramite.getNlApellidoPaterno());
		parameters.put("ApellidoMaterno", tramite.getNlApellidoMaterno());
		parameters.put("Observacion", tramite.getNlObservaciones());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		List<Rechazo> dataCollection = new ArrayList<Rechazo>();
		RechazoLCR.Tramite tramite = (RechazoLCR.Tramite) inputDto;
		Rechazo rechazo;

		if (tramite.getNlTramite() != 0 && tramite.getNlFechaReg() != null && tramite.getNlCliente() != 0 && tramite.getNlNombre() != null && tramite.getNlApellidoPaterno() != null
				&& tramite.getNlApellidoMaterno()!= null && tramite.getNlObservaciones() != null) {
			rechazo = new Rechazo(tramite.getNlTramite(),tramite.getNlFechaReg(),tramite.getNlCliente(),tramite.getNlNombre(),tramite.getNlApellidoPaterno(),
					tramite.getNlApellidoMaterno(),tramite.getNlObservaciones());
			dataCollection.add(rechazo);
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		RechazoLCR.Tramite objDatos = (RechazoLCR.Tramite) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String subject = "Notificación de Rechazo de Línea de Crédito Revolvente";
		String emailCC = "";
		String emailBCC = "";
		parameters.put("ID_GRUPO", new Integer(0));
		parameters.put("NOMBRE_GRUPO", "Sonia Rojas");
		parameters.put("MENSAJE", "");
		parameters.put("EMAIL_TO", objDatos.getNlCorreo());
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject); /* Se modifica en el SP(sp_notifica_grupo) en caso de ser Desembolso */

		return parameters;
	}

	public void executeByCode(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByCode General");
		}
		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, "Q", null, null);

			while (result.next()) {
				Integer tramite = result.getInt(1);
				LOGGER.debug("Trámite de Notificación: " + tramite);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cob_credito..sp_qr_ns_rechaza_lcr(?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setString(1, "S");
					executeSPXml.setInt(2, tramite);

					ResultSet resultQuery = executeSPXml.executeQuery();

					LOGGER.debug("result1.." + resultQuery);
					List<RechazoLCR.Tramite> objectList = new ArrayList<RechazoLCR.Tramite>();
					RechazoLCR.Tramite tramiteLCR = new RechazoLCR.Tramite();
					while (resultQuery.next()) {
						tramiteLCR.setNlTramite(resultQuery.getInt(1));
						tramiteLCR.setNlFechaReg(resultQuery.getString(2));
						tramiteLCR.setNlCliente(resultQuery.getInt(3));
						tramiteLCR.setNlNombre(resultQuery.getString(4));
						tramiteLCR.setNlApellidoPaterno(resultQuery.getString(5));
						tramiteLCR.setNlApellidoMaterno(resultQuery.getString(6));
						tramiteLCR.setNlCorreo(resultQuery.getString(7));
						tramiteLCR.setNlObservaciones(resultQuery.getString(8));
						
						objectList.add(tramiteLCR);
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(tramite), objectList);
					executeNotificationGeneral(cn, executeSP, "U", tramite, "T");// Estado Terminado
				} catch (Exception e) {
					executeNotificationGeneral(cn, executeSP, "U", tramite, "F");// Estado Fallido
				}
			}
		} catch (Exception e) {
			LOGGER.error("ERROR executeByCode General -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByCode General");
			}
		}

	}

	public ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String operation, Integer tramite, String status) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification General");
		}
		String query = "{ call cob_credito..sp_qr_ns_rechaza_lcr(?,?,?) }";

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
			LOGGER.error("ERROR executeNotification General -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification General");
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
