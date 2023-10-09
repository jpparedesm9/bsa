package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.AlertasRiesgo;
import com.cobiscorp.cloud.notificationservice.dto.AlertasRiesgo.Alerta;
import com.cobiscorp.cloud.notificationservice.dto.report.AlertaReport;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class AlertaRiesgo extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(AlertaRiesgo.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Alerta> notificacionList = new ArrayList<AlertasRiesgo.Alerta>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			AlertasRiesgo alertas = new AlertasRiesgo();
			alertas = (AlertasRiesgo) jxb.unmarshall(alertas, inputData);
			notificacionList = alertas.getAlerta();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return notificacionList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		AlertasRiesgo.Alerta grupo = (Alerta) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("FECHA", grupo.getFechaProceso());
		parameters.put("cliente", grupo.getCliente());
		parameters.put("nombre", grupo.getNombre());
		parameters.put("tipolista", grupo.getTipoLista());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		List<AlertaReport> dataCollection = new ArrayList<AlertaReport>();
		AlertasRiesgo.Alerta notificacionGeneral = (AlertasRiesgo.Alerta) inputDto;
		AlertaReport grupo;

		if (notificacionGeneral.getCliente() != null && notificacionGeneral.getNombre() != null && notificacionGeneral.getTipoLista() != null) {
			grupo = new AlertaReport(notificacionGeneral.getCliente(), notificacionGeneral.getNombre(), notificacionGeneral.getTipoLista());
			dataCollection.add(grupo);
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		AlertasRiesgo.Alerta objDatos = (AlertasRiesgo.Alerta) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String subject = "Alertas de Riesgo"; /* Se agrega en el SP(sp_notifica_grupo) */
		
		String emailCC = "";
		String emailBCC = "";
		parameters.put("ID_GRUPO", new Integer(0));
		parameters.put("NOMBRE_GRUPO", "");
		parameters.put("MENSAJE", objDatos.getCliente());
		parameters.put("EMAIL_TO", objDatos.getCorreo());
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
				Integer codigo = result.getInt(1);
				String cliente = result.getString(2);
				LOGGER.debug("Código de Notificación: " + codigo);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cobis..sp_qr_ns_alerta_cliente(?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setString(1, "S");
					executeSPXml.setInt(2, codigo);

					ResultSet resultQuery = executeSPXml.executeQuery();

					LOGGER.debug("result1.." + resultQuery);
					List<AlertasRiesgo.Alerta> objectList = new ArrayList<AlertasRiesgo.Alerta>();
					AlertasRiesgo.Alerta alerta = new AlertasRiesgo.Alerta();
					while (resultQuery.next()) {
						alerta.setCodigo(resultQuery.getInt(1));
						alerta.setCliente(resultQuery.getString(2));
						alerta.setNombre(resultQuery.getString(3));
						alerta.setTipoLista(resultQuery.getString(4));
						alerta.setFechaProceso(resultQuery.getString(5));
						alerta.setCorreo(resultQuery.getString(6));
						
						LOGGER.debug("alerta.." + alerta.getNombre());
						
						objectList.add(alerta);
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(cliente +'_'+ codigo), objectList);
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
		String query = "{ call cobis..sp_qr_ns_alerta_cliente(?,?,?) }";

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
