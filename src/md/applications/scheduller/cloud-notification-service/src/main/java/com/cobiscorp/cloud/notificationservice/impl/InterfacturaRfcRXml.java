package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class InterfacturaRfcRXml extends NotificationGeneric implements Job {
	private static final Logger logger = Logger.getLogger(InterfacturaRfcRXml.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		logger.error("Inicia ejecucion de InterfacturaRfcRXml ");

		try {
			if (ejecutionJobXml()) {
				try {

					logger.debug("JobName: " + arg0.getJobDetail().getName());
					executeByInterFacturasRfcRxml(arg0);

				} catch (Exception ex) {
					logger.error("Exception: ", ex);
				}
			} else {
				logger.debug("La hora del Job de xml de Facturacion Global se encuentra fuera de los limites de Inicio y Fin");
			}
		} catch (Exception e) {
			logger.debug("Exeption Interfactura Global", e);
		}

	}

	public void executeByInterFacturasRfcRxml(JobExecutionContext arg0) {
		Connection cn = null;
		PreparedStatement executeSPXml = null;
		try {
			cn = ConnectionManager.newConnection();
			logger.error("Inicia ejecucion cob_credito..sp_xml_rfc_err_estd_cuenta(?):");
			String query = "{ call cob_credito..sp_xml_rfc_err_estd_cuenta(?) }";
			executeSPXml = cn.prepareStatement(query);
			executeSPXml.setEscapeProcessing(true);
			executeSPXml.setString(1, "I");
			executeSPXml.execute();
		} catch (SQLException e) {
			logger.error("Error en la base de datos..:", e);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("Exception..:", e);
		} finally {
			if (executeSPXml != null) {
				try {
					executeSPXml.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					logger.error("SQLException -->", e);
				}
			}
			System.gc();
		}

	}

	private boolean ejecutionJobXml() throws Exception {

		boolean realizarAccion = false;
		Connection cn = null;
		PreparedStatement executeSPXml = null;
		String nemonico = null;
		String producto = null;
		String description = null;
		String valor_pachar = null;

		String query = "{ call cobis..sp_return_parametro(?,?,?) }";
		try {
			cn = ConnectionManager.newConnection();
			executeSPXml = cn.prepareCall(query);
			executeSPXml.setEscapeProcessing(true);
			executeSPXml.setString(1, "Q");
			executeSPXml.setString(2, "JXMRNV");
			executeSPXml.setString(3, "CRE");
			ResultSet resultParametro = executeSPXml.executeQuery();
			while (resultParametro.next()) {
				nemonico = resultParametro.getString(1);
				producto = resultParametro.getString(2);
				description = resultParametro.getString(3);
				valor_pachar = resultParametro.getString(4);
				logger.debug("nemonicoXml------->" + nemonico);
				logger.debug("productoXml------->" + producto);
				logger.debug("descriptionXml---->" + description);
				logger.debug("valor_pacharXml--->" + valor_pachar);
			}

			Calendar horaActual = Calendar.getInstance();
			Calendar jobHoraInicio = Calendar.getInstance();
			Calendar jobHoraFin = Calendar.getInstance();
			String parametro = valor_pachar;
			String[] patterns = parametro.split("\\|");
			for (int i = 0; i < patterns.length; i++) {
				logger.debug("patterns [i] Xml" + patterns[i]);
			}
			String horainicio = patterns[0].replace(" ", "");
			logger.debug("HoraInicio Xml--->" + horainicio);
			String horafin = patterns[1].replace(" ", "");
			logger.debug("HoraFin Xml------>" + horafin);

			String[] patternsHoraInicio = horainicio.split("\\:");
			for (int i = 0; i < patternsHoraInicio.length; i++) {
				logger.debug("patternsHoraInicio [i] Xml" + patternsHoraInicio[i]);
			}

			jobHoraInicio.set(Calendar.HOUR_OF_DAY, Integer.valueOf(patternsHoraInicio[0]));
			jobHoraInicio.set(Calendar.MINUTE, Integer.valueOf(patternsHoraInicio[1]));
			jobHoraInicio.set(Calendar.SECOND, 0);

			String[] patternsHoraFin = horafin.split("\\:");
			for (int i = 0; i < patternsHoraFin.length; i++) {
				logger.debug("patternsHoraFin [i] xml" + patternsHoraFin[i]);
			}

			jobHoraFin.set(Calendar.HOUR_OF_DAY, Integer.valueOf(patternsHoraFin[0]));
			jobHoraFin.set(Calendar.MINUTE, Integer.valueOf(patternsHoraFin[1]));
			jobHoraFin.set(Calendar.SECOND, 59);

			logger.debug("horaActual Xml------>" + horaActual.getTime());
			logger.debug("jobHoraInicio Xml--->" + jobHoraInicio.getTime());
			logger.debug("jobHoraFin Xml------>" + jobHoraFin.getTime());
			if (horaActual.after(jobHoraInicio) && horaActual.before(jobHoraFin)) {
				logger.debug("Ejecuta el Job de Xml ");
				realizarAccion = true;
			} else {
				logger.debug("La hora del Job de xml de Facturacion Global no se encuentra fuera de los limites de Inicio y Fin");
				realizarAccion = false;
			}

		} catch (SQLException e) {
			logger.error("ERROR SQLException en  ejecutionJob de Xml -->", e);
		} catch (Exception e) {
			logger.error("ERROR Exception en ejecutionJob de Xml -->", e);
		} finally {
			ConnectionManager.saveConnection(cn);
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza ejecutionJob de Xml Facturacion Global");
			}
		}

		return realizarAccion;
	}

}
