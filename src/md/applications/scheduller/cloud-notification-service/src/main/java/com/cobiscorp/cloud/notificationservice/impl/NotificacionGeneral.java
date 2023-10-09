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

import com.cobiscorp.cloud.notificationservice.dto.NotificacionesGenerales;
import com.cobiscorp.cloud.notificationservice.dto.NotificacionesGenerales.Grupo;
import com.cobiscorp.cloud.notificationservice.dto.report.Notificacion;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class NotificacionGeneral extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(NotificacionGeneral.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Grupo> notificacionList = new ArrayList<NotificacionesGenerales.Grupo>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			NotificacionesGenerales grupos = new NotificacionesGenerales();
			grupos = (NotificacionesGenerales) jxb.unmarshall(grupos, inputData);
			notificacionList = grupos.getGrupo();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return notificacionList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		NotificacionesGenerales.Grupo grupo = (Grupo) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("FECHA", new Date());
		parameters.put("MENSAJE", grupo.getNgMensaje());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		List<Notificacion> dataCollection = new ArrayList<Notificacion>();
		NotificacionesGenerales.Grupo notificacionGeneral = (NotificacionesGenerales.Grupo) inputDto;
		Notificacion grupo;

		if (notificacionGeneral.getNgMensaje() != null && notificacionGeneral.getNgCorreo() != null) {
			grupo = new Notificacion(notificacionGeneral.getNgMensaje());
			dataCollection.add(grupo);
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		NotificacionesGenerales.Grupo objDatos = (NotificacionesGenerales.Grupo) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		String emailCC = "";
		String emailBCC = "";
		parameters.put("ID_GRUPO", new Integer(0));
		parameters.put("NOMBRE_GRUPO", "Sonia Rojas");
		parameters.put("MENSAJE", objDatos.getNgMensaje());
		parameters.put("EMAIL_TO", objDatos.getNgCorreo());
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", objDatos.getNgAsunto()); /* Se modifica en el SP(sp_notifica_grupo) en caso de ser Desembolso */

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
				Integer codigo = result.getInt(1);
				LOGGER.debug("Código de Notificación: " + codigo);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cobis..sp_genera_xml_notf_general(?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setInt(1, codigo);
					executeSPXml.setString(2, "G");

					ResultSet resultQuery = executeSPXml.executeQuery();

					LOGGER.debug("result1.." + resultQuery);
					List<NotificacionesGenerales.Grupo> objectList = new ArrayList<NotificacionesGenerales.Grupo>();
					NotificacionesGenerales.Grupo grupo = new NotificacionesGenerales.Grupo();
					while (resultQuery.next()) {
						grupo.setNgMensaje(resultQuery.getString(1));
						grupo.setNgCorreo(resultQuery.getString(2));
						grupo.setNgAsunto(resultQuery.getString(3));
						objectList.add(grupo);
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(codigo), objectList);
					executeNotificationGeneral(cn, executeSP, "U", codigo, "T");// Estado Terminado
				} catch (Exception e) {
					executeNotificationGeneral(cn, executeSP, "U", codigo, "F");// Estado Fallido
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

	public ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String operation, Integer codigo, String status) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification General");
		}
		String query = "{ call cobis..sp_qr_ns_general(?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);

			if (codigo == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, codigo);
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
