package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.w3c.dom.Document;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CopiaEstadoCuentaInterfacturaRechazados implements Job {

	private static final Logger logger = Logger.getLogger(CopiaEstadoCuentaInterfacturaRechazados.class);
	private static final String messageOk = "Copia de Archivos de Estado de Cuenta Interfactura Rechazados Exitosa!";
	private static final String codeErrorRFC = "CFDI33132";
	
	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		logger.debug("Inicia copia de archivos de Interfactura Rechazados");
		try {

			CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYIFR);
			try {
				if (logger.isDebugEnabled()) {
					logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
				}
				extractInsuranceReports(copyFileJob);
			} catch (Exception ex) {
				logger.error("Error al copiar archivos de interfactura Procesados: ", ex);
			}
		} catch (Exception e) {
			logger.debug("Exception in execute ", e);
		}

	}

	private void extractInsuranceReports(CopyFileJob copyFileJob) throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia ejecución método extractInsuranceReports");
		}

		File[] listFiles = copyFileJob.getListFilesPattern();

		Connection cn = null;
		PreparedStatement executeSPXml = null;

		if (listFiles.length > 0) {
			try {
				cn = ConnectionManager.newConnection();

				for (int i = 0; i < listFiles.length; i++) {
					logger.debug("Ruta a procesar: " + listFiles[i].getAbsolutePath());
					logger.debug("Archivo a procesar: " + listFiles[i].getName());

					// Extracción del nombre del archivo
					String nameFileError = splitNameFileError(listFiles[i].getName(), "Error_", ".xml");
					logger.debug("Nombre archivo error: " + nameFileError);

					// Lectura del archivo xml de error, recuperación de código de error y descripción
					DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
					DocumentBuilder documentBuilder = factory.newDocumentBuilder();
					Document document = documentBuilder.parse(listFiles[i]);
					document.getDocumentElement().normalize();

					String code = document.getElementsByTagName("Code").item(0).getTextContent();
					String description = document.getElementsByTagName("Description").item(0).getTextContent();

					logger.debug("Codigo Respuesta: " + code);
					logger.debug("Descripción Respuesta: " + description);

					if (code.equalsIgnoreCase(codeErrorRFC)) {

						logger.debug("Inicia cob_credito..sp_rfc_int_error");

						String query = "{ call cob_credito..sp_rfc_int_error(?,?) }";
						executeSPXml = cn.prepareStatement(query);
						executeSPXml.setEscapeProcessing(true);
						executeSPXml.setString(1, "I");
						executeSPXml.setString(2, nameFileError);
						executeSPXml.execute();
						
						logger.debug("Termina cob_credito..sp_rfc_int_error");
					} else {
						logger.debug("La causa de error del archivo " + listFiles[i].getName() + " no corresponde por RFC");
					}

					
					  FileExchangeResponse fileExchangeResponse1 = copyFileJob.moveFileToHIstory(listFiles[i]); if
					  (fileExchangeResponse1.isSuccess()) { logger.debug("messageOk: " + messageOk); } else {
					  logger.debug("Error al copiar el archivo"); }
					 
				}

			} catch (Exception e) {
				logger.error("ERROR executeNotification -->", e);
			} finally {
				ConnectionManager.saveConnection(cn);
				if (logger.isDebugEnabled()) {
					logger.debug("Finaliza extractInsuranceReports");
				}
			}
		}

	}

	private String splitNameFileError(String nameFile, String startWord, String extention) {

		String deleteError = nameFile.replace(startWord, "");
		String deleteExtention = deleteError.replace(extention, "");
		String responseName = deleteExtention.trim();
		return responseName;
	}

	/*
	 * private boolean ejecutionJob() throws Exception {
	 * 
	 * boolean realizarAccion=false; Connection cn =null; PreparedStatement executeSPXml = null; String nemonico =null; String producto =null; String
	 * description =null; String valor_pachar =null;
	 * 
	 * String query = "{ call cobis..sp_return_parametro(?,?,?) }"; try { cn = ConnectionManager.newConnection(); executeSPXml =
	 * cn.prepareCall(query); executeSPXml.setEscapeProcessing(true); executeSPXml.setString(1, "Q"); executeSPXml.setString(2, "JRFCNV");
	 * executeSPXml.setString(3, "CRE"); ResultSet resultParametro = executeSPXml.executeQuery(); while (resultParametro.next()) {
	 * nemonico=resultParametro.getString(1); producto=resultParametro.getString(2); description=resultParametro.getString(3);
	 * valor_pachar=resultParametro.getString(4); logger.debug("nemonico------->"+nemonico); logger.debug("producto------->"+producto);
	 * logger.debug("description---->"+description); logger.debug("valor_pachar--->"+valor_pachar); }
	 * 
	 * Calendar horaActual = Calendar.getInstance(); Calendar jobHoraInicio = Calendar.getInstance(); Calendar jobHoraFin = Calendar.getInstance();
	 * String parametro=valor_pachar; String[] patterns = parametro.split("\\|"); for(int i=0;i<patterns.length;i++) { logger.debug("patterns [i]"+
	 * patterns[i]); } String horainicio=patterns[0].replace(" ", ""); logger.debug("HoraInicio--->"+horainicio); String horafin=
	 * patterns[1].replace(" ", ""); logger.debug("HoraFin------>"+horafin);
	 * 
	 * String[] patternsHoraInicio = horainicio.split("\\:"); for(int i=0;i<patternsHoraInicio.length;i++) { logger.debug("patternsHoraInicio [i]"+
	 * patternsHoraInicio[i]); }
	 * 
	 * jobHoraInicio.set(Calendar.HOUR_OF_DAY,Integer.valueOf(patternsHoraInicio[0])); jobHoraInicio.set(Calendar.MINUTE,
	 * Integer.valueOf(patternsHoraInicio[1])); jobHoraInicio.set(Calendar.SECOND,0);
	 * 
	 * String[] patternsHoraFin = horafin.split("\\:"); for(int i=0;i<patternsHoraFin.length;i++) { logger.debug("patternsHoraFin [i]"+
	 * patternsHoraFin[i]); }
	 * 
	 * jobHoraFin.set(Calendar.HOUR_OF_DAY,Integer.valueOf(patternsHoraFin[0])); jobHoraFin.set(Calendar.MINUTE, Integer.valueOf(patternsHoraFin[1]));
	 * jobHoraFin.set(Calendar.SECOND,59);
	 * 
	 * logger.debug("horaActual------>"+horaActual.getTime()); logger.debug("jobHoraInicio--->"+jobHoraInicio.getTime());
	 * logger.debug("jobHoraFin------>"+jobHoraFin.getTime()); if(horaActual.after(jobHoraInicio)&& horaActual.before(jobHoraFin)) {
	 * logger.debug("Ejecuta el Job de RFC no validos"); realizarAccion=true; } else {
	 * logger.debug("La hora del Job de Rfc no validos se encuentra fuera de los limites de Inicio y Fin"); realizarAccion=false; }
	 * 
	 * 
	 * } catch (SQLException e) { logger.error("ERROR SQLException en  ejecutionJob -->", e); }catch (Exception e) {
	 * logger.error("ERROR Exception en ejecutionJob -->", e); }finally { ConnectionManager.saveConnection(cn); if (logger.isDebugEnabled()) {
	 * logger.debug("Finaliza ejecutionJob"); } }
	 * 
	 * 
	 * return realizarAccion; }
	 */

}
