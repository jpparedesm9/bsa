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

import com.cobiscorp.cloud.notificationservice.dto.Traspasos;
import com.cobiscorp.cloud.notificationservice.dto.Traspasos.Solicitud;
import com.cobiscorp.cloud.notificationservice.dto.report.TraspasoReport;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class Traspaso extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(Traspaso.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Solicitud> notificacionList = new ArrayList<Traspasos.Solicitud>();
		/*try {
			JaxbUtil jxb = new JaxbUtil();
			Traspasos traspaso = new Traspasos();
			traspaso = (Traspasos) jxb.unmarshall(traspaso, inputData);
			notificacionList = traspaso.getSolicitud();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}*/
		return notificacionList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		Traspasos.Solicitud solicitud = (Solicitud) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		
		parameters.put("FECHA", solicitud.getFecha());
		parameters.put("solicitud", solicitud.getSolicitud());
		parameters.put("nombre", solicitud.getNombre());
		parameters.put("entes", solicitud.getEntes());
		parameters.put("esgrupo", solicitud.getEsGrupo());
		parameters.put("razonrechazo", solicitud.getRazonRechazo());
		parameters.put("oficialniega", solicitud.getOficialNiega());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		List<TraspasoReport> dataCollection = new ArrayList<TraspasoReport>();
		Traspasos.Solicitud notificacionGeneral = (Traspasos.Solicitud) inputDto;
		TraspasoReport grupo;

		if (notificacionGeneral.getEntes() != null && notificacionGeneral.getNombre() != null && notificacionGeneral.getRazonRechazo() != null && notificacionGeneral.getOficialNiega() != null) {
			grupo = new TraspasoReport( notificacionGeneral.getNombre(), notificacionGeneral.getEntes(), notificacionGeneral.getEsGrupo(), notificacionGeneral.getRazonRechazo(), notificacionGeneral.getOficialNiega(), notificacionGeneral.getFecha());
			dataCollection.add(grupo);
		}
		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		Traspasos.Solicitud objDatos = (Traspasos.Solicitud) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		
		String subject = "Rechazo de Solicitud de Traspaso"; /* Se agrega en el SP(sp_notifica_grupo) */
		
		String emailCC = "";
		String emailBCC = "";
		parameters.put("ID_GRUPO", new Integer(0));
		parameters.put("NOMBRE_GRUPO", "");
		parameters.put("MENSAJE", objDatos.getNombre());
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
				Integer idSolicitud = result.getInt(2);
				LOGGER.debug("Código de Notificación: " + codigo);
				LOGGER.debug("Código de Solicitud: " + idSolicitud);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cobis..sp_qr_ns_traspaso(?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setString(1, "S");
					executeSPXml.setInt(2, codigo);
					executeSPXml.setString(3, null);
					executeSPXml.setInt(4, idSolicitud);
					executeSPXml.execute();

					ResultSet resultQuery = executeSPXml.getResultSet();
					
					List<Traspasos.Solicitud> objectList = new ArrayList<Traspasos.Solicitud>();
					Traspasos.Solicitud traspaso = new Traspasos.Solicitud();
					while (resultQuery.next()) {
						
						LOGGER.debug("result1.." + resultQuery);
						
						traspaso.setCodigo(resultQuery.getInt(1));
						traspaso.setSolicitud(resultQuery.getString(2));
						traspaso.setNombre(resultQuery.getString(3));
						traspaso.setEntes(resultQuery.getString(4));
						traspaso.setEsGrupo(resultQuery.getString(5));
						traspaso.setRazonRechazo(resultQuery.getString(6));
						traspaso.setOficialNiega(resultQuery.getString(7));
						traspaso.setCorreo(resultQuery.getString(8));
						traspaso.setFecha(resultQuery.getString(9));
						
						LOGGER.debug("traspaso.." + traspaso.getNombre());
						
						objectList.add(traspaso);
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(idSolicitud), objectList);
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
		String query = "{ call cobis..sp_qr_ns_traspaso(?,?,?) }";

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
