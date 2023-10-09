package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusHeaderDTO;
import com.cobiscorp.cloud.notificationservice.model.ResponseRule;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.ExecuteRule;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.GenerateReportInterfactura;

public class EstadoCuentaPdfCorreo extends Thread implements Job {

	private static final Logger LOGGER = Logger.getLogger(EstadoCuentaPdfCorreo.class);

	private String tipoOp;
	private String tipoOpEstado;
	private String tipoOperacion;
	private JobExecutionContext arg0;

	public EstadoCuentaPdfCorreo(String tipoOp, String tipoOpEstado, String tipoOperacion, JobExecutionContext arg0) {
		super();
		this.tipoOp = tipoOp;
		this.tipoOpEstado = tipoOpEstado;
		this.tipoOperacion = tipoOperacion;
		this.arg0 = arg0;
	}

	public EstadoCuentaPdfCorreo() {
		super();
	}

	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		AccountStatusDTO objDatos = (AccountStatusDTO) inputDto;
		AccountStatusHeaderDTO header = objDatos.getAccountStatusHeader();

		Map<String, Object> parameters = new HashMap<String, Object>();

		String emailCC = "";
		String emailBCC = "";
		String subject = "Estado de Cuenta";

		if (header.getCodigoGrupo() != null) {
			parameters.put("ID_GRUPO", header.getCodigoGrupo());
		} else {
			parameters.put("ID_GRUPO", 0);
		}
		LOGGER.debug("Correo cliente antes de setear: " + header.getMail());
		if (header.getNombreCliente() != null) {
			parameters.put("NOMBRE_GRUPO", header.getNombreCliente());
		} else {
			parameters.put("NOMBRE_GRUPO", "XX");
		}

		parameters.put("EMAIL_TO", header.getMail());
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject);

		return parameters;

	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			String fechadoc = "";
			Connection cn = null;
			CallableStatement executeSP = null;

			try {
				ConfigManager ds = ConfigManager.getInstance();
				// cn = ConnectionManager.openNewConnection();
				cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

				ResponseRule responseRuleGrupal = new ResponseRule();
				ResponseRule responseRuleRevolvente = new ResponseRule();
				ResponseRule responseRuleIndividual = new ResponseRule();

				ExecuteRule executeRuleGrupal = new ExecuteRule();
				responseRuleGrupal = executeRuleGrupal.executeRule(cn, executeSP, "GRUPAL");

				ExecuteRule executeRuleRevolvente = new ExecuteRule();
				responseRuleRevolvente = executeRuleRevolvente.executeRule(cn, executeSP, "REVOLVENTE");

				ExecuteRule executeRuleIndividual = new ExecuteRule();
				responseRuleIndividual = executeRuleIndividual.executeRule(cn, executeSP, "INDIVIDUAL");

				/* Para Generar PDFy Correo para Grupal */
				// EstadoCuentaPdfCorreo pdfEstadoCuenta = new EstadoCuentaPdfCorreo("PDF", generarPdf, arg0);
				EstadoCuentaPdfCorreo pdfEstadoCuenta = new EstadoCuentaPdfCorreo("PDF", responseRuleGrupal.getGenerarPdf(), "GRUPAL", arg0);
				pdfEstadoCuenta.start();

				EstadoCuentaPdfCorreo correoEstadoCuenta = new EstadoCuentaPdfCorreo("CORREO", responseRuleGrupal.getEnviarEmail(), "GRUPAL", arg0);
				correoEstadoCuenta.start();

				/* Para Generar PDFy Correo para Revolvemte */
				EstadoCuentaPdfCorreo pdfEstadoCuentaRev = new EstadoCuentaPdfCorreo("PDFREV", responseRuleRevolvente.getGenerarPdf(), "REVOLVENTE", arg0);
				pdfEstadoCuentaRev.start();

				EstadoCuentaPdfCorreo correoEstadoCuentaRev = new EstadoCuentaPdfCorreo("CORREOREV", responseRuleRevolvente.getEnviarEmail(), "REVOLVENTE", arg0);
				correoEstadoCuentaRev.start();

				/* Para Generar PDFy Correo para Individual */
				EstadoCuentaPdfCorreo pdfEstadoCuentaInd = new EstadoCuentaPdfCorreo("PDF", responseRuleIndividual.getGenerarPdf(), "INDIVIDUAL", arg0);
				pdfEstadoCuentaInd.start();

				EstadoCuentaPdfCorreo correoEstadoCuentaInd = new EstadoCuentaPdfCorreo("CORREO", responseRuleIndividual.getEnviarEmail(), "INDIVIDUAL", arg0);
				correoEstadoCuentaInd.start();

			} catch (Exception e) {
				LOGGER.error("ERROR executeByTransaction -->", e);
			} finally {
				try {
					if (executeSP != null) {
						executeSP.close();
					}
					if (cn != null) {

						cn.close();

					}
				} catch (SQLException e) {
					LOGGER.error("SQLException -->", e);
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Finaliza executeByTransaction");
				}
			}

		} catch (Exception ex) {
			LOGGER.error("Exception: ", ex);
		}

	}

	@Override
	public void run() {

		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.ZFIEC);
		CopyFileJob copyFileJobEnvio = new CopyFileJob(FileJob.Job.MPDFI);
		CallableStatement executeSP = null;
		Connection cn = null;
		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			LOGGER.debug("Inicio metodo run-->>tipoOpEstado: " + tipoOpEstado + " -->>tipoOperacion: " + tipoOperacion + " -->>tipoOp: " + tipoOp);

			// GRUPAL/INDIVIDUAL GENERAR PDF
			if (tipoOp.equalsIgnoreCase("PDF") && tipoOpEstado.equalsIgnoreCase("SI")) {

				ResultSet resultpdf = executeNotification(cn, executeSP, "Y", null, "P", null, tipoOperacion);

				LOGGER.debug("AA-Metodo run PDF-->> tipo: " + tipoOperacion + ">>resultpdf: " + resultpdf);

				while (resultpdf.next()) {

					int codigoPdf = resultpdf.getInt(1);
					String bancoPdf = resultpdf.getString(2);
					String fechaCarpeta = resultpdf.getString(3);
					String rutaPdf = resultpdf.getString(6);

					LOGGER.debug("codigoPdf" + codigoPdf + "-->>bancoPdf: " + bancoPdf + "-->>fechaCarpeta: " + fechaCarpeta + "-->>rutaPdf: " + rutaPdf);

					// Se crea un file con la ruta donde se creo el pdf
					File fileEnvio = new File(rutaPdf);
					copyFileJobEnvio.moveFileToDestinationInterfactura(fileEnvio, fechaCarpeta);

					executeNotification(cn, executeSP, "A", codigoPdf, "T", null, tipoOperacion);
				}
			}

			// GRUPAL/INDIVIDUAL ENVIAR PDF
			if (tipoOp.equalsIgnoreCase("CORREO") && tipoOpEstado.equalsIgnoreCase("SI")) {
				ResultSet resultCorreo = executeNotification(cn, executeSP, "W", null, "P", null, tipoOperacion);

				LOGGER.debug("AA-Metodo run CORREO-->> tipo: " + tipoOperacion + ">>resultCorreo: " + resultCorreo);
				while (resultCorreo.next()) {
					int secId = resultCorreo.getInt(1);
					String bancoGrp = resultCorreo.getString(2);
					String correoGrp = resultCorreo.getString(4);
					String passwordBuc = resultCorreo.getString(5);
					String nameFilezip = resultCorreo.getString(6);
					int codGrupo = resultCorreo.getInt(8);
					String nameClient = resultCorreo.getString(9);

					LOGGER.debug("secId: " + secId + "-->>bancoGrp: " + bancoGrp + "-->>passwordBuc: " + passwordBuc + "-->>nameFilezip: " + nameFilezip);
					LOGGER.debug("secId: " + secId + "-->>codGrupo: " + codGrupo + "-->>nameFilezip: " + nameClient);

					/* Envio el primer correo con el password password */
					executeNotificacionCode(cn, executeSP, secId, passwordBuc, correoGrp);

					/* Envio el segundo correo con el zip */
					File temp = new File(nameFilezip);
					LOGGER.debug("namePdf" + nameFilezip);
					String[] nameEnvFile = temp.getName().split("\\.");
					LOGGER.debug("Nombre del archivo zip >> " + nameEnvFile[0] + ".zip");
					AccountStatusDTO accountStatus = new AccountStatusDTO();
					AccountStatusHeaderDTO headerData = new AccountStatusHeaderDTO();
					headerData.setCodigoGrupo(codGrupo);
					headerData.setNombreCliente(nameClient);
					headerData.setMail(correoGrp);
					accountStatus.setAccountStatusHeader(headerData);
					GenerateReportInterfactura.sendNotification(setParameterToSendMail(accountStatus), nameEnvFile[0] + ".zip", arg0.getJobDetail().getName());
					// actualiza el estado correo
					executeNotification(cn, executeSP, "C", secId, "T", null, tipoOperacion);
				}
			}

			// REVOLVENTE GENERAR PDF
			if (tipoOp.equalsIgnoreCase("PDFREV") && tipoOpEstado.equalsIgnoreCase("SI")) {

				ResultSet resultpdfRevolvente = executeNotification(cn, executeSP, "T", null, "P", null, tipoOperacion);

				LOGGER.debug("BB-Metodo run PDF-->> tipo: " + tipoOperacion + ">>resultpdfRevolvente: " + resultpdfRevolvente);

				while (resultpdfRevolvente.next()) {

					int codigoPdfRev = resultpdfRevolvente.getInt(1);
					String bancoPdfRev = resultpdfRevolvente.getString(2);
					String fechaCarpetaRev = resultpdfRevolvente.getString(3);
					String rutaPdfRev = resultpdfRevolvente.getString(6);

					LOGGER.debug("codigoPdfRev: " + codigoPdfRev + "-->>bancoPdfRev: " + bancoPdfRev + "-->>fechaCarpetaRev: " + fechaCarpetaRev + "-->>rutaPdfRev: " + rutaPdfRev);
					
					File fileEnvioRev = new File(rutaPdfRev); // Se crea un file con la ruta donde se creo el pdf.
					copyFileJobEnvio.moveFileToDestinationInterfactura(fileEnvioRev, fechaCarpetaRev);

					executeNotification(cn, executeSP, "A", codigoPdfRev, "T", null, tipoOperacion);
				}
			}

			// REVOLVENTE ENVIAR PDF
			if (tipoOp.equalsIgnoreCase("CORREOREV") && tipoOpEstado.equalsIgnoreCase("SI")) {
				ResultSet resultCorreoRev = executeNotification(cn, executeSP, "X", null, "P", null, tipoOperacion);

				LOGGER.debug("BB-Metodo run CORREO-->> tipo: " + tipoOperacion + ">>resultCorreoRev: " + resultCorreoRev);
				while (resultCorreoRev.next()) {
					int secIdRev = resultCorreoRev.getInt(1);
					String bancoRev = resultCorreoRev.getString(2);
					String correoRev = resultCorreoRev.getString(4);
					String passwordBucRev = resultCorreoRev.getString(5);
					String nameFilezipRev = resultCorreoRev.getString(6);
					int codGrupoRev = resultCorreoRev.getInt(8);
					String nameClientRev = resultCorreoRev.getString(9);

					LOGGER.debug("secIdRev: " + secIdRev + "-->>bancoRev: " + bancoRev + "-->>passwordBucRev: " + passwordBucRev + "-->>nameFilezipRev: " + nameFilezipRev);
					LOGGER.debug("secIdRev: " + secIdRev + "-->>codGrupoRev: " + codGrupoRev + "-->>nameFilezip: " + nameClientRev);
					
					/* Envio el primer correo con el password password */

					executeNotificacionCode(cn, executeSP, secIdRev, passwordBucRev, correoRev);

					/* Envio el segundo correo con el zip */

					File tempRev = new File(nameFilezipRev);
					LOGGER.debug("namePdf: " + nameFilezipRev);
					String[] nameEnvFileRev = tempRev.getName().split("\\.");
					LOGGER.debug("Nombre del archivo zip: " + nameEnvFileRev[0] + ".zip");
					AccountStatusDTO accountStatus = new AccountStatusDTO();
					AccountStatusHeaderDTO headerData = new AccountStatusHeaderDTO();
					headerData.setCodigoGrupo(codGrupoRev);
					headerData.setNombreCliente(nameClientRev);
					headerData.setMail(correoRev);
					accountStatus.setAccountStatusHeader(headerData);
					GenerateReportInterfactura.sendNotification(setParameterToSendMail(accountStatus), nameEnvFileRev[0] + ".zip", arg0.getJobDetail().getName());
					executeNotification(cn, executeSP, "C", secIdRev, "T", null, tipoOperacion);
				}
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeByTransaction -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction");
			}
		}

	}

	public ResultSet executeNotification(Connection cn, CallableStatement executeSP, String operation, Integer codigo, String status, String nombrePdf, String toperation) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification");
		}
		String query = "{ call cob_conta_super..sp_qr_ns_estado_cuenta(?,?,?,?,?) }";
		LOGGER.debug("query -->" + query);

		try {
			
			LOGGER.debug("-->>Tipo: " + toperation + "-->>Operacion: " + operation + "-->Codigo: " + codigo + "-->>status: " + status + "-->>nombrePdf: " + nombrePdf);

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			if (codigo == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, codigo);
			}
			executeSP.setString(3, status);
			executeSP.setString(4, nombrePdf);
			executeSP.setString(5, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification -->", ex);
			throw ex;
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification");
			}
		}

	}

	public void executeNotificacionCode(Connection cn, CallableStatement executeSP, int cod, String buc, String mail) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotificacionCode");
		}
		String query = "{ call cob_conta_super..sp_notif_interfactura_clave(?,?,?,?) }";

		LOGGER.debug("executeNotificacionCode query: " + query);
		LOGGER.debug("executeNotificacionCode cod: " + cod);
		LOGGER.debug("executeNotificacionCode query: " + buc);
		LOGGER.debug("executeNotificacionCode cod: " + mail);

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "P");
			executeSP.setInt(2, cod);
			executeSP.setString(3, buc);
			executeSP.setString(4, mail);
			executeSP.execute();

			LOGGER.debug("INGRESO AL METODO : " + query);
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotificacionCode -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotificacionCode");
			}
		}
	}

	public static XMLGregorianCalendar toXMLGregorianCalendar(Date date) {
		GregorianCalendar gCalendar = new GregorianCalendar();
		gCalendar.setTime(date);
		XMLGregorianCalendar xmlCalendar = null;
		try {
			xmlCalendar = DatatypeFactory.newInstance().newXMLGregorianCalendar(gCalendar);
		} catch (DatatypeConfigurationException ex) {
			LOGGER.error("Exception: ", ex);
		}
		return xmlCalendar;
	}

}