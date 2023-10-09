package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.impl.AsistenciaFunerariaSimplificado;
import com.cobiscorp.cloud.notificationservice.impl.CaratulaContrato;
import com.cobiscorp.cloud.notificationservice.impl.CaratulaSimpleIndAutoOnboard;
import com.cobiscorp.cloud.notificationservice.impl.CertConsentimientoZurichAutoOnboard;
import com.cobiscorp.cloud.notificationservice.impl.CertificadoConsentimientoZurich;
import com.cobiscorp.cloud.notificationservice.impl.ContratoCreditoInclusion;
import com.cobiscorp.cloud.notificationservice.impl.ContratoSimpleIndAutoOnboard;
import com.cobiscorp.cloud.notificationservice.impl.FichaPago;
import com.cobiscorp.cloud.notificationservice.impl.KYCAutoOnboard;
import com.cobiscorp.cloud.notificationservice.impl.KYCSimplificado;
import com.cobiscorp.cloud.notificationservice.impl.SecureConsent;
import com.cobiscorp.cloud.notificationservice.impl.TAmortSimpleIndAutoOnboard;
import com.cobiscorp.cloud.notificationservice.impl.TablaAmortizacionSimplificado;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

public class DigitizedDocumentProcessing {

	private static final String FLDR_CSTMR = "Customer";
	private static final String FLDR_IBX = "Inbox";

	private static final String TOPER_LCR = "REVOLVENTE";
	private static final String TOPER_GRP = "GRUPAL";
	private static final String TOPER_IND = "INDIVIDUAL";
	private static final String EXTENSION = ".pdf";

	String diaInter = null;
	String mesInter = null;
	String anioInter = null;
	String errorStatus = "E";
	String finishStatus = "T";
	String pendingStatus = "P";
	Integer mode1 = 1; // padre
	Integer mode2 = 2; // hijas
	Integer mode3 = 3; // Padre envio
	String fileNameZipIR = "";
	String fileNamePathIR = "";

	private static final Logger LOGGER = Logger.getLogger(DigitizedDocumentProcessing.class);

	public void generateReport(JobExecutionContext arg0, String partCommunFileName, File pathSourceFolderFin, String jasperFileName, ReportesAutoOnboardDTO reportesAutoOnboardDTO)
			throws JobExecutionException {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug(" " + arg0);
			LOGGER.debug("partCommunFileName: " + partCommunFileName);
			LOGGER.debug("pathSourceFolderFin: " + pathSourceFolderFin);
			LOGGER.debug("jasperFileName: " + jasperFileName);
			LOGGER.debug("ReportesAutoOnboardDTO: " + reportesAutoOnboardDTO);
		}

		String filePathNameReportGenerate = pathSourceFolderFin + File.separator + partCommunFileName + "_" + reportesAutoOnboardDTO.getDocumenteName();

		LOGGER.debug("-->>generateReport -- filePath ruta y nombre a generar:" + filePathNameReportGenerate);
		String docCode = reportesAutoOnboardDTO.getDocumentCode();

		if (docCode.equals(ReportesAutoOnboardDTO.getCodContrato())) {// contratoSimpleAutoOnboard
			LOGGER.debug("Debe ejecutar el contrato");
			ContratoSimpleIndAutoOnboard contratoSimpleIndAutoOnboard = new ContratoSimpleIndAutoOnboard();
			contratoSimpleIndAutoOnboard.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodTablaAmortizacion())) {// tablaAmortizacionSimpleAutoOnboard
			LOGGER.debug("Debe ejecutar la tabla");
			TAmortSimpleIndAutoOnboard tAmortSimpleIndAutoOnboard = new TAmortSimpleIndAutoOnboard();
			tAmortSimpleIndAutoOnboard.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodCaratula())) {// caratulaSimpleAutoOnboard
			LOGGER.debug("Debe ejecutar el caratula");
			CaratulaSimpleIndAutoOnboard caratulaSimpleIndAutoOnboard = new CaratulaSimpleIndAutoOnboard();
			caratulaSimpleIndAutoOnboard.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodConsentimiento())) {// consentimientoZurichSimpleAutoOnboar
			LOGGER.debug("Debe ejecutar el consentimiento");
			CertConsentimientoZurichAutoOnboard certConsentimientoZurichAutoOnboard = new CertConsentimientoZurichAutoOnboard();
			certConsentimientoZurichAutoOnboard.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodKyc())) {// kycSimpleAutoOnboard
			LOGGER.debug("Debe ejecutar kyc");
			KYCAutoOnboard kycAutoOnboard = new KYCAutoOnboard();
			kycAutoOnboard.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodFichaPagoIndividual()) || docCode.equals(ReportesAutoOnboardDTO.getCodFichaPagoGrupal())) {// Ficha
																																							// De
																																							// Pago
			LOGGER.debug("Debe ejecutar ficha de Pago con codigo de documento: " + docCode);
			FichaPago fichaPago = new FichaPago();
			fichaPago.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodAutorizacion())) { // autorizacionBuroSimpleAutoOnboard
			LOGGER.debug("Debe ejecutar autorizacion");

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodFormularioKYC())) {// FormularioKYC
			LOGGER.debug("Debe ejecutar Formulario KYC con codigo de documento: " + docCode);
			KYCSimplificado kYCSimplificado = new KYCSimplificado();
			kYCSimplificado.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodTablaAmortizacionGrupal())) {// FormularioTablaAmortizacion
			LOGGER.debug("Debe ejecutar Formulario Tabla de Amortizacion con codigo de documento: " + docCode);
			TablaAmortizacionSimplificado tablaAmortizacionSimplificado = new TablaAmortizacionSimplificado();
			tablaAmortizacionSimplificado.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodCertConsentimiento())) {// CertificadoConsentimiento
			LOGGER.debug("Debe ejecutar Certificado Consentimiento con codigo de documento: " + docCode);
			CertificadoConsentimientoZurich certificadoConsentimientoZurich = new CertificadoConsentimientoZurich();
			certificadoConsentimientoZurich.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodCertAsistenciaFuneraria())) {// CertificadoAsistenciaFuneraria
			LOGGER.debug("Debe ejecutar Certificado Asistencia Funeraria con codigo de documento: " + docCode);
			AsistenciaFunerariaSimplificado asistenciaFunerariaSimplificado = new AsistenciaFunerariaSimplificado();
			asistenciaFunerariaSimplificado.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodContratoGrupal())) {// ContratoGrupal
			LOGGER.debug("Debe ejecutar Contrato Grupal con codigo de documento: " + docCode);
			ContratoCreditoInclusion contratoCreditoInclusion = new ContratoCreditoInclusion();
			contratoCreditoInclusion.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodCaratulaCreditoGrupal())) {// CaratulaContrato
			LOGGER.debug("Debe ejecutar Caratula de Contrato con codigo de documento: " + docCode);
			CaratulaContrato caratulaContrato = new CaratulaContrato();
			caratulaContrato.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else if (docCode.equals(ReportesAutoOnboardDTO.getCodCertAsistenciaMedica())) {// CertificadoAsistenciaMedica
			LOGGER.debug("Debe ejecutar Certificado Asistencia Medica con codigo de documento: " + docCode);
			SecureConsent secureConsent = new SecureConsent();
			secureConsent.execute(reportesAutoOnboardDTO, arg0, filePathNameReportGenerate, jasperFileName);

		} else {
			LOGGER.debug("Debe ejecutar -- no hay reporte o implementar");

		}

	}

	public void processNotificationReportsByClient(Connection cn, CallableStatement executeSP, JobExecutionContext arg0, CopyFileJob copyFileJob, String partCommunFileName, File pathSourceFolderFin,
			ResultSet resultMainDetailIND, String fileNameZip, String fileNamePath) throws SQLException {
		Integer customerId = resultMainDetailIND.getInt(1);
		String buc = resultMainDetailIND.getString(2);
		String bank = resultMainDetailIND.getString(3);
		Integer application = resultMainDetailIND.getInt(4);
		String documentCode = resultMainDetailIND.getString(5);
		String reportName = resultMainDetailIND.getString(6);
		Date proccessDate = resultMainDetailIND.getDate(7);
		String jasperFileName = resultMainDetailIND.getString(8);

		String endingAcronymName = resultMainDetailIND.getString(11);
		String isAlfresco = resultMainDetailIND.getString(12);
		Integer groupId = resultMainDetailIND.getInt(13);
		Integer proccessInst = resultMainDetailIND.getInt(14);
		String docName = resultMainDetailIND.getString(15);
		String folder = resultMainDetailIND.getString(16);
		String operType = resultMainDetailIND.getString(17);
		groupId = TOPER_IND.equals(operType) ? null : groupId;

		String isLoadAlfresco = resultMainDetailIND.getString(18);
		String codeDocTypeCstmr = resultMainDetailIND.getString(19);
		String groupUnif = resultMainDetailIND.getString(20);
		Integer idCodInstAct = resultMainDetailIND.getInt(21);
		Integer codCodigoTipoDoc = resultMainDetailIND.getInt(22);

		fileNameZip = partCommunFileName + endingAcronymName + ".zip";
		fileNamePath = pathSourceFolderFin + File.separator + fileNameZip;
		fileNameZipIR = fileNameZip;
		fileNamePathIR = fileNamePath;

		LOGGER.debug("-->>processNotificationReportsByClient-->>Resultado Query Detalle -- >>Id cliente: " + customerId + "-->>buc: " + buc + "-->>banco: " + bank + "-->>tramite: " + application
				+ "-->>codDocumento: " + documentCode + "-->>nombreArchivo:" + docName + "-->>fechaProceso: " + proccessDate + "-->>nombreArchivoJasper:" + jasperFileName);

		try {
			ReportesAutoOnboardDTO reportesAutoOnboardDTO = new ReportesAutoOnboardDTO();
			reportesAutoOnboardDTO.setCustomerId(customerId);
			reportesAutoOnboardDTO.setBank(bank);
			reportesAutoOnboardDTO.setApplication(application);
			reportesAutoOnboardDTO.setDocumentCode(documentCode);
			reportesAutoOnboardDTO.setDocumenteName(reportName);
			reportesAutoOnboardDTO.setBuc(buc);
			reportesAutoOnboardDTO.setProccessDate(proccessDate);
			/* reportesAutoOnboardDTO.setProcessInst(proccessInst); */
			reportesAutoOnboardDTO.setGroupId(groupId);
			reportesAutoOnboardDTO.setFolder(folder);
			reportesAutoOnboardDTO.setDocName(docName);

			if ("S".equals(isAlfresco)) {

				String localFileName = getLocalFileName(reportesAutoOnboardDTO, operType);

				LOGGER.debug("-->>processNotificationReportsByClient-->>Resultado Query Detalle -- >>getSourceFolder: " + copyFileJob.getSourceFolder() + "-->>groupId: " + groupId
						+ "-->>proccessInst: " + proccessInst + "-->>customerId: " + customerId + "-->>docName: " + docName + "-->>folder:" + folder + "-->>fechaProceso: " + proccessDate
						+ "-->>operType: " + operType + "-->>localFileName: " + localFileName);

				String pathLocalFile = DownloadAlfrescoFile.getAlfrescoFile(copyFileJob.getSourceFolder(), groupId == null || groupId == 0 ? "" : groupId.toString(), proccessInst.toString(),
						customerId.toString(), docName, folder, proccessDate, localFileName);

				if (pathLocalFile != null && !"".equals(pathLocalFile)) { // Si getAlfrescoFile SUCCESS -> Actualizacion de estados -> ya se descarg�
																			// satisfactoriamente
					executeNotification(cn, executeSP, "U", reportesAutoOnboardDTO.getCustomerId(), "T", reportesAutoOnboardDTO.getDocumentCode(), reportesAutoOnboardDTO.getBank(), pathLocalFile, 4,
							null); // TERMINADO
				} else {
					executeNotification(cn, executeSP, "U", reportesAutoOnboardDTO.getCustomerId(), "E", reportesAutoOnboardDTO.getDocumentCode(), reportesAutoOnboardDTO.getBank(), pathLocalFile, 4,
							null);// ERROR
				}
			} else {
				generateReport(arg0, partCommunFileName, pathSourceFolderFin, jasperFileName, reportesAutoOnboardDTO);// customerId,reportName

				if ("S".equals(isLoadAlfresco)) {
					String filePathName = pathSourceFolderFin + File.separator + partCommunFileName + "_" + reportesAutoOnboardDTO.getDocumenteName() + EXTENSION;
					File file = getFile(filePathName);

					// Validacion si se genero el archivo dentro de la carpeta

					if (file == null) {
						LOGGER.error("El archivo no existe --> " + filePathName);
						executeNotification(cn, executeSP, "U", reportesAutoOnboardDTO.getCustomerId(), "E", reportesAutoOnboardDTO.getDocumentCode() + EXTENSION, reportesAutoOnboardDTO.getBank(),
								filePathName, 2, null);// ERROR return;
					}

					LOGGER.debug("-->>processNotificationReportsByClient-->>Resultado Query Detalle -- >>filePathName: " + filePathName + "-->>groupId: " + groupId);

					boolean isUploaded = UploadAlfrescoFile.uploadAlfrescoFile(file, groupId.toString(), proccessInst.toString(), customerId.toString(), reportesAutoOnboardDTO.getDocName(), folder);

					LOGGER.debug("-->>processNotificationReportsByClient-->>Resultado Query Detalle -- >>isUploaded: " + isUploaded);

					if (isUploaded) {

						executeUpdateDocuments(cn, executeSP, proccessInst, idCodInstAct, codCodigoTipoDoc, docName, customerId, groupId, folder, codeDocTypeCstmr);

						executeNotification(cn, executeSP, "U", reportesAutoOnboardDTO.getCustomerId(), "T", reportesAutoOnboardDTO.getDocumentCode(), reportesAutoOnboardDTO.getBank(), filePathName,
								5, null);

					} else {
						executeNotification(cn, executeSP, "U", reportesAutoOnboardDTO.getCustomerId(), "E", reportesAutoOnboardDTO.getDocumentCode(), reportesAutoOnboardDTO.getBank(), filePathName,
								5, null);// ERROR }

					}
				}

			}

		} catch (Exception e) {
			LOGGER.error("-->> executeByTransaction -- >> Error en Hija -->> Exception Hija: ", e);

		} finally {
			// System.gc();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction Hija");
			}
		}
	}

	public File getFile(String filePathName) {
		File file = new File(filePathName);
		if (existFile(file.getAbsolutePath())) {
			return file;
		}
		return null;
	}

	public ResultSet executeNotification(Connection cn, CallableStatement executeSP, String operation, Integer customerId, String status, String documentCode, String bank, String filenameWithPath,
			Integer mode, String tOper) throws SQLException, Exception {

		LOGGER.debug("-->>Ingreso executeNotification");

		String query = "{ call cob_credito..sp_estado_gen_report_auto_boarding(?,?,?,?,?,?,?,?) }";
		LOGGER.debug(String.format("exec cob_credito..sp_estado_gen_report_auto_boarding %s , %s , %s , %s , %s , %s ,%s , %s ", operation, customerId, status, documentCode, bank, filenameWithPath,
				mode, tOper));

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);

			executeSP.setString(1, operation);

			if (customerId == null)
				executeSP.setNull(2, java.sql.Types.INTEGER);
			else
				executeSP.setInt(2, customerId);

			if (status == null)
				executeSP.setNull(3, java.sql.Types.VARCHAR);
			else
				executeSP.setString(3, status);

			if (documentCode == null)
				executeSP.setNull(4, java.sql.Types.VARCHAR);
			else
				executeSP.setString(4, documentCode);

			if (bank == null)
				executeSP.setNull(5, java.sql.Types.VARCHAR);
			else
				executeSP.setString(5, bank);

			if (filenameWithPath == null)
				executeSP.setNull(6, java.sql.Types.VARCHAR);
			else
				executeSP.setString(6, filenameWithPath);

			if (mode == null)
				executeSP.setNull(7, java.sql.Types.INTEGER);
			else
				executeSP.setInt(7, mode);

			if (tOper == null)
				executeSP.setNull(8, java.sql.Types.VARCHAR);
			else
				executeSP.setString(8, tOper);

			executeSP.execute();

			return executeSP.getResultSet();

		} catch (SQLException ex) {
			LOGGER.error("-->>ERROR executeNotification -->", ex);
			throw ex;
		} catch (Exception ex) {
			LOGGER.error("-->>ERROR executeNotification -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("-->>Finaliza executeNotification");
			}
		}

	}

	private String getLocalFileName(ReportesAutoOnboardDTO reportesAutoOnboardDTO, String operType) {
		String extension = "";
		int index = reportesAutoOnboardDTO.getDocName().lastIndexOf('.');
		if (index > 0) {
			extension = reportesAutoOnboardDTO.getDocName().substring(index);
			LOGGER.debug("getLocalFileName - getDocName= " + reportesAutoOnboardDTO.getDocName());
			LOGGER.debug("getLocalFileName - extension= " + extension + "-->>operType: " + operType);
		}
		if (TOPER_IND.equals(operType) || TOPER_LCR.equals(operType)) {

			return reportesAutoOnboardDTO.getBuc() + "_" + reportesAutoOnboardDTO.getDocumenteName() + extension;
		} else if (TOPER_GRP.equals(operType)) {
			if (FLDR_IBX.equals(reportesAutoOnboardDTO.getFolder())) {
				return reportesAutoOnboardDTO.getGroupId() + "_" + reportesAutoOnboardDTO.getDocumenteName() + extension;
			} else if (FLDR_CSTMR.equals(reportesAutoOnboardDTO.getFolder())) {
				return reportesAutoOnboardDTO.getBuc() + "_" + reportesAutoOnboardDTO.getDocumenteName() + extension;
			}
		}
		return null;
	}

	public void executeNotificacionCode(Integer customerCode, String bank, String buc, String mail, String typeNotification) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("-->>Ingresa executeNotificacionCode");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		String query = "{ call cob_conta_super..sp_notif_onboarding_clave(?,?,?,?,?,?) }";

		LOGGER.debug("executeNotificacionCode Onboarding query" + query + "-->>Cliente: " + customerCode + "-->>Banco: " + bank + "-->>Buc: " + buc + "-->Mail: " + mail);

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "P");
			executeSP.setInt(2, customerCode);
			executeSP.setString(3, bank);
			executeSP.setString(4, buc);
			executeSP.setString(5, mail);
			executeSP.setString(6, typeNotification);
			executeSP.execute();
			LOGGER.debug("INGRESO AL METODO : " + query);
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotificacionCode Onboarding  -->", ex);
			throw ex;
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {
					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("-->> executeNotificacionCode -- >> Error en Padre -->> Error SQLException: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction Padre");
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotificacionCode Onboarding");
			}
		}
	}

	public Boolean sendNotification(ReportesAutoOnboardDTO infoSend, String filePath, String typeNotification) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa sendNotification envío de correo con los datos");
			LOGGER.debug("infoSend" + infoSend);
			LOGGER.debug("filePath" + filePath);
			LOGGER.debug("typeNotification" + typeNotification);
		}

		Boolean success = false;
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			// Envio de notificacion
			String query = "{ call cob_cartera..sp_notifica_grupo(?,?,?,?,?,?,?,?,?) }";

			ConfigManager ds = ConfigManager.getInstance();
			Class.forName(ds.getJdbDriver()).newInstance();

			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);

			String emailTO = infoSend.getEmail();
			String emailCC = "";
			String emailBCC = "";
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug(String.format("exec cob_cartera..sp_notifica_grupo %s , %s , %s , %s , %s , %s ,%s , %s ,%s", emailTO, emailCC, emailBCC, null, infoSend.getCustomerId(),
						infoSend.getCustomerName(), filePath, typeNotification, infoSend.getBank()));
			}

			executeSP.setString(1, emailTO);// @i_to
			executeSP.setString(2, emailCC);// @i_cc
			executeSP.setString(3, emailBCC);// @i_bcc
			executeSP.setString(4, null);// @i_subject
			executeSP.setInt(5, infoSend.getCustomerId()); // @i_funcionario
			executeSP.setString(6, infoSend.getCustomerName()); // @i_nombre
			executeSP.setString(7, filePath); // @i_attachment
			executeSP.setString(8, typeNotification);// @i_tipo_notific
			executeSP.setString(9, infoSend.getBank());// @i_tipo_notific

			executeSP.execute();
			success = true;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finailiza sendNotification");
			}

		} catch (Exception e) {
			LOGGER.error("-->>ERROR Exception sendNotification : ", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza sendNotification");
			}
		}
		return success;
	}

	public void processZipAndSendNotification(Connection cn, CallableStatement executeSP, File pathDestinationFolder, Integer customerCodeF, String bucF, String bankF, String emailF,
			String customerNameF, String fileNameZip, String fileNamePath) throws SQLException, Exception {

		// Trae la lista de archivos generados del cliente
		ResultSet resultMainDetailList = executeNotification(cn, executeSP, "Q", customerCodeF, finishStatus, null, bankF, null, mode2, null);

		ArrayList<String> pathList = new ArrayList<String>();
		while (resultMainDetailList.next()) {
			if (resultMainDetailList.getString(10).equals("S")) {
				String pathFile = resultMainDetailList.getString(9);
				pathList.add(pathFile);
			}
		}

		ArrayList<File> listFile = new ArrayList<File>();
		for (String a : pathList) {
			LOGGER.debug("-->> executeByTransaction -- >>Archivo que va al correo: " + a);
			listFile.add(new File(a));
		}

		// Enviar la contrase�a
		if (listFile != null) {
			executeNotificacionCode(customerCodeF, bankF, bucF, emailF, "GRAOB");

			// Crea el archivo zip con los archivos generados
			if (createZip(listFile, bucF, fileNamePath, true)) {
				executeNotification(cn, executeSP, "U", customerCodeF, "T", null, bankF, fileNamePath, mode1, null);

				// Deja en los atachment
				File pathDestinationFolderName = new File(pathDestinationFolder + File.separator + fileNameZip);
				FileExchangeResponse fileExchangeResponse = moveFileToDestination(fileNamePath, pathDestinationFolderName.getAbsolutePath());

				if (!fileExchangeResponse.isSuccess()) {
					LOGGER.error("-->> executeByTransaction con error: " + fileExchangeResponse.getErrorMessage());
				} else {
					ReportesAutoOnboardDTO reportesAutoOnboardMainDTO = new ReportesAutoOnboardDTO();
					reportesAutoOnboardMainDTO.setCustomerId(customerCodeF);
					reportesAutoOnboardMainDTO.setEmail(emailF);
					reportesAutoOnboardMainDTO.setCustomerName(customerNameF);
					reportesAutoOnboardMainDTO.setBank(bankF);
					LOGGER.error("-->> implementar envio de correo");
					if (sendNotification(reportesAutoOnboardMainDTO, fileNameZip, "GRAOB"))
						executeNotification(cn, executeSP, "U", customerCodeF, "T", null, bankF, null, mode3, null);
					else
						executeNotification(cn, executeSP, "U", customerCodeF, "E", null, bankF, null, mode3, null);
				}

			} else {
				executeNotification(cn, executeSP, "U", customerCodeF, "E", null, bankF, fileNamePath, mode1, null);
			}
		}
	}

	public void SendUnifiedDocumentNotification(Connection cn, CallableStatement executeSP, Integer customerCodeF, String bucF, String bankF, String emailF, String customerNameF, String fileNamePath)
			throws SQLException, Exception {

		executeNotification(cn, executeSP, "U", customerCodeF, "T", null, bankF, fileNamePath, mode1, null);
		ReportesAutoOnboardDTO reportesAutoOnboardMainDTO = new ReportesAutoOnboardDTO();
		reportesAutoOnboardMainDTO.setCustomerId(customerCodeF);
		reportesAutoOnboardMainDTO.setEmail(emailF);
		reportesAutoOnboardMainDTO.setCustomerName(customerNameF);
		reportesAutoOnboardMainDTO.setBank(bankF);

		LOGGER.error("-->> implementar envio de correo");
		File fileName = new File(fileNamePath);
		if (sendNotification(reportesAutoOnboardMainDTO, fileName.getName(), "GRAOB"))
			executeNotification(cn, executeSP, "U", customerCodeF, "T", null, bankF, null, mode3, null);
		else
			executeNotification(cn, executeSP, "U", customerCodeF, "E", null, bankF, null, mode3, null);

	}

	public static Boolean createZip(ArrayList<File> rutaFileObt, String password, String ruteNameSave, boolean encriptado) {
		Boolean output = false;
		try {
			ZipFile zipFile = new ZipFile(ruteNameSave);
			LOGGER.debug("-->>createZip-->>password: " + password + "-->>ruteNameSave: " + ruteNameSave);

			ZipParameters parameters = new ZipParameters();
			parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE); // metodo de compresion
			parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
			parameters.setEncryptFiles(true);
			parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
			parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
			parameters.setPassword(password);
			zipFile.addFiles(rutaFileObt, parameters);
			output = true;
		} catch (ZipException e) {

			LOGGER.error("-->>createZip-->>No se pudo comprimir el archivo", e);
		}
		return output;
	}

	public FileExchangeResponse moveFileToDestination(String fileNameRoute, String destinationRoute) {
		LOGGER.debug("Inicia moveFileToHistory");

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ruta del archivo origen: " + fileNameRoute);
			LOGGER.debug("Ruta del archivo destino: " + destinationRoute);
		}

		// si existe en la carpeta destino, lo elimina
		File file = new File(destinationRoute);
		if (existFile(file.getAbsolutePath())) {
			removeFile(file.getAbsolutePath());
		}

		FileExchangeResponse moveFile = FileUtil.moveFile(fileNameRoute, destinationRoute);

		// si existe en la carpeta origen lo borra
		if (FileUtil.existFile(fileNameRoute)) {
			removeFile(fileNameRoute);
		}

		return moveFile;
	}

	public static boolean existFile(String filePath) {
		File f = new File(filePath);
		return (f.exists() && !f.isDirectory());
	}

	public static FileExchangeResponse removeFile(String filePathName) {
		File file = new File(filePathName);
		file.delete();
		return new FileExchangeResponse(true, null);
	}

	public void executeUpdateDocuments(Connection cn, CallableStatement executeSP, Integer idInstProcess, Integer idInstActiv, Integer idTipoCod, String nombreDoc, Integer codEnte, Integer codGrupo,
			String tipo, String codeDocTypeCstmr) throws Exception {

		LOGGER.debug("-->>Ingreso executeUpdateDocuments");
		String[] splitDocument = nombreDoc.split("[.]");
		String extDocument = splitDocument[1];

		String query = "{ call cob_credito..sp_actualiza_documentos(?,?,?,?,?,?,?,?,?) }";

		LOGGER.debug(String.format("exec cob_credito..sp_actualiza_documentos %s , %s , %s , %s , %s , %s ,%s , %s, %s ", idInstProcess, idInstActiv, idTipoCod, nombreDoc, codEnte, codGrupo,
				extDocument, tipo, codeDocTypeCstmr));

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);

			if (idInstProcess == null)
				executeSP.setNull(1, java.sql.Types.INTEGER);
			else
				executeSP.setInt(1, idInstProcess);

			if (idInstActiv == null)
				executeSP.setNull(2, java.sql.Types.INTEGER);
			else
				executeSP.setInt(2, idInstActiv);

			if (idTipoCod == null)
				executeSP.setNull(3, java.sql.Types.INTEGER);
			else
				executeSP.setInt(3, idTipoCod);

			if (nombreDoc == null)
				executeSP.setNull(4, java.sql.Types.VARCHAR);
			else
				executeSP.setString(4, nombreDoc);

			if (codEnte == null)
				executeSP.setNull(5, java.sql.Types.INTEGER);
			else
				executeSP.setInt(5, codEnte);

			if (codGrupo == null)
				executeSP.setNull(6, java.sql.Types.INTEGER);
			else
				executeSP.setInt(6, codGrupo);

			if (extDocument == null)
				executeSP.setNull(7, java.sql.Types.VARCHAR);
			else
				executeSP.setString(7, extDocument);

			if (tipo == null)
				executeSP.setNull(8, java.sql.Types.VARCHAR);
			else
				executeSP.setString(8, tipo);

			if (tipo == null)
				executeSP.setNull(9, java.sql.Types.VARCHAR);
			else
				executeSP.setString(9, codeDocTypeCstmr);

			executeSP.execute();

		} catch (Exception ex) {
			LOGGER.error("-->>ERROR executeUpdateDocuments -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("-->>Finaliza executeUpdateDocuments");
			}
		}

	}

	public void processNotificationReportsByTOper(Connection cn, CallableStatement executeSP, JobExecutionContext arg0, File pathSourceFolder, File pathDestinationFolder, CopyFileJob copyFileJob,
			String tOperation) {

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			// clase Padre
			ResultSet resultMain = executeNotification(cn, executeSP, "Q", null, pendingStatus, null, null, null, mode1, tOperation);

			LOGGER.debug("-->>processNotificationReportsByTOper-->>Resultado Query Principal -- >>" + resultMain + "-->>Ruta para generar: " + pathSourceFolder + "-->>Nombre Job: "
					+ arg0.getJobDetail().getName());

			while (resultMain.next()) {

				Integer customerCodeF = resultMain.getInt(1);
				String bucF = resultMain.getString(2);
				String bankF = resultMain.getString(3);
				String emailF = resultMain.getString(4);
				Date proccessDateF = resultMain.getDate(6);
				String customerNameF = resultMain.getString(7);

				LOGGER.debug("-->>processNotificationReportsByTOper-->>Resultado Query Secundario -- >>Id cliente: " + customerCodeF + "-->>buc: " + bucF + "-->>banco: " + bankF + "-->>Email: "
						+ emailF + proccessDateF);

				Calendar calendarGenF = Calendar.getInstance();
				calendarGenF.setTime(proccessDateF);
				diaInter = String.valueOf(calendarGenF.get(Calendar.DAY_OF_MONTH));
				mesInter = String.valueOf(calendarGenF.get(Calendar.MONTH) + 1);
				anioInter = String.valueOf(calendarGenF.get(Calendar.YEAR));

				if (mesInter.length() == 1)
					mesInter = '0' + mesInter;

				if (diaInter.length() == 1)
					diaInter = '0' + diaInter;

				String partCommunFileName = String.valueOf(bucF) + "-" + bankF + "-" + anioInter + mesInter + diaInter;

				File pathSourceFolderFin = new File(pathSourceFolder + File.separator + anioInter + File.separator + mesInter + File.separator + diaInter);

				LOGGER.debug("-->>processNotificationReportsByTOper ruta para agregar lo generado:" + pathSourceFolderFin);

				if (!pathSourceFolderFin.exists()) {
					if (pathSourceFolderFin.mkdirs()) {
						LOGGER.debug("-->>processNotificationReportsByTOper-->>Directorio Creado");
					} else {
						LOGGER.debug("-->>processNotificationReportsByTOper-->>Directorio no Creado, errror");
						return;
					}
				}

				ResultSet resultMainDetail = executeNotification(cn, executeSP, "Q", customerCodeF, pendingStatus, null, bankF, null, mode2, null);

				String fileNameZip = "";
				String fileNamePath = "";

				if (TOPER_IND.equals(tOperation) || TOPER_LCR.equals(tOperation)) {
					while (resultMainDetail.next()) { // ini while hija
						processNotificationReportsByClient(cn, executeSP, arg0, copyFileJob, partCommunFileName, pathSourceFolderFin, resultMainDetail, fileNameZip, fileNamePath);
						LOGGER.debug("-->> processNotificationReportsByTOper -- >>Inicia Zip, codigo y correos 1");
						processZipAndSendNotification(cn, executeSP, pathDestinationFolder, customerCodeF, bucF, bankF, emailF, customerNameF, fileNameZipIR, fileNamePathIR);
					} // fin while hija
				} else {
					// Generación de documentos
					while (resultMainDetail.next()) { // ini while hija
						processNotificationReportsByClient(cn, executeSP, arg0, copyFileJob, partCommunFileName, pathSourceFolderFin, resultMainDetail, fileNameZip, fileNamePath);
					}

					LOGGER.debug("-->> processNotificationReportsByTOper -- >>Unificar correos");
					resultMainDetail = executeNotification(cn, executeSP, "Q", customerCodeF, "T", null, bankF, null, mode2, null);
					List<File> docList1 = new ArrayList<File>();
					List<File> docList2 = new ArrayList<File>();
					while (resultMainDetail.next()) {
						String ruta_archivo_gen = resultMainDetail.getString(9);
						Integer ra_grp_unif = resultMainDetail.getInt(20);

						if (ra_grp_unif == 1) {
							docList1.add(new File(ruta_archivo_gen));
						} else if (ra_grp_unif == 2) {
							docList2.add(new File(ruta_archivo_gen));
						}
					}
					// resultMainDetail.first();

					String pathDocumentUnified1 = MergeDocumentPdf.generateMergeDocument(docList1, pathDestinationFolder.getPath(), partCommunFileName + "_1");

					String pathDocumentUnified2 = MergeDocumentPdf.generateMergeDocument(docList2, pathDestinationFolder.getPath(), partCommunFileName + "_2");

					if (pathDocumentUnified1 != null) {
						SendUnifiedDocumentNotification(cn, executeSP, customerCodeF, bucF, bankF, emailF, customerNameF, pathDocumentUnified1);

					}
					if (pathDocumentUnified2 != null) {
						SendUnifiedDocumentNotification(cn, executeSP, customerCodeF, bucF, bankF, emailF, customerNameF, pathDocumentUnified2);

					}

				}

			} // fin while Padre
		} catch (Exception e) {
			LOGGER.error("-->> processNotificationReportsByTOper -- >> Error en Padre -->> Exception: ", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza processNotificationReportsByTOper");
			}
		}

	}

	public void processNotificationGroupReports(Connection cn, CallableStatement executeSP, JobExecutionContext arg0, File pathSourceFolder, File pathDestinationFolder, CopyFileJob copyFileJob,
			String tOperation) {
		LOGGER.debug("Inicia processNotificationGroupReports");

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			// 1) Consultar los documentos pendientes por el grupo
			ResultSet resultMain = executeNotification(cn, executeSP, "Q", null, pendingStatus, null, null, null, mode1, tOperation);

			while (resultMain.next()) {
				Integer customerCodeF = resultMain.getInt(1);
				String bucF = resultMain.getString(2);
				String bankF = resultMain.getString(3);
				String emailF = resultMain.getString(4);
				Date proccessDateF = resultMain.getDate(6);
				String customerNameF = resultMain.getString(7);

				Calendar calendarGenF = Calendar.getInstance();
				calendarGenF.setTime(proccessDateF);
				diaInter = String.valueOf(calendarGenF.get(Calendar.DAY_OF_MONTH));
				mesInter = String.valueOf(calendarGenF.get(Calendar.MONTH) + 1);
				anioInter = String.valueOf(calendarGenF.get(Calendar.YEAR));

				if (mesInter.length() == 1)
					mesInter = '0' + mesInter;

				if (diaInter.length() == 1)
					diaInter = '0' + diaInter;

				String partCommunFileName = String.valueOf(bucF) + "-" + bankF + "-" + anioInter + mesInter + diaInter;

				File pathSourceFolderFin = new File(pathSourceFolder + File.separator + anioInter + File.separator + mesInter + File.separator + diaInter);

				LOGGER.debug("-->>executeByTransaction ruta para agregar lo generado:" + pathSourceFolderFin);

				if (!pathSourceFolderFin.exists()) {
					if (pathSourceFolderFin.mkdirs()) {
						LOGGER.debug("-->>executeByTransaction-->>Directorio Creado");
					} else {
						LOGGER.debug("-->>executeByTransaction-->>Directorio no Creado, errror");
						return;
					}
				}

				ResultSet resultMainDetail = executeNotification(cn, executeSP, "Q", customerCodeF, pendingStatus, null, bankF, null, mode2, null);

				String fileNameZip = "";
				String fileNamePath = "";
				while (resultMainDetail.next()) { // ini while hija

					processNotificationReportsByClient(cn, executeSP, arg0, copyFileJob, partCommunFileName, pathSourceFolderFin, resultMainDetail, fileNameZip, fileNamePath);
					LOGGER.debug("-->> executeByTransaction -- >>Inicia Zip, codigo y correos");
					processZipAndSendNotification(cn, executeSP, pathDestinationFolder, customerCodeF, bucF, bankF, emailF, customerNameF, fileNameZip, fileNamePath);
				} // fin while hija

				// resultMainDetail.

			}

			// 2) Genera los documentos que se deban generar

			// 3) Unificar los documentos de acuerdo al ra_grp_unif

			// 4)

		} catch (SQLException e) {
			LOGGER.error("-->> processNotificationGroupReports -- >> Error en Padre -->> Error SQLException: ", e);
		} catch (Exception e) {
			LOGGER.error("-->> processNotificationGroupReports -- >> Error en Padre -->> Error Exception: ", e);
		}

		LOGGER.debug("Finaliza processNotificationGroupReports");
	}

}

