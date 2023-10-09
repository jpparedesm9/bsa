package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.KYCAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.KYCAutoOnboardSubDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;
import com.cobiscorp.cloud.scheduler.utils.Util;

public class KYCSimplificado extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(KYCSimplificado.class);

	private static ReportesAutoOnboardDTO inputData;
	private static KYCAutoOnboardDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIOSANTANDER2);
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<KYCAutoOnboardDTO> dataCollection = new ArrayList<KYCAutoOnboardDTO>();
		return dataCollection;
	}

	/* No borrar el metdodo xmlToDTO se requiere para la clase */
	@Override
	public List<?> xmlToDTO(File inputData) {
		LOGGER.debug("Ingresa a xmlToDTO");
		return null;
	}

	/* No borrar el metdodo setParameterToSendMail se requiere para la clase */
	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToSendMail");
		Map<String, Object> parameters = new HashMap<String, Object>();
		return parameters;
	}

	// Trae la data de la base
	public KYCAutoOnboardDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		KYCAutoOnboardDTO kycAutoOnboardDTO = new KYCAutoOnboardDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer tramite = inputObject.getApplication();
			Integer cliente = inputObject.getCustomerId();

			PreparedStatement executeSPXml = null;

			try {

				/* Lista SubReporte Formulario KYC */
				List<KYCAutoOnboardSubDTO> kycAutoOnboardSubDTOList = new ArrayList<KYCAutoOnboardSubDTO>();
				LOGGER.debug("llamada al sp reporte kyc - cobis..sp_reporte_kyc");
				String queryXmlR = "{ call cobis..sp_reporte_kyc(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlR);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setString(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setDate(4, null);
				executeSPXml.setInt(5, 0);
				executeSPXml.setString(6, null);
				executeSPXml.setString(7, null);
				executeSPXml.setString(8, null);
				executeSPXml.setInt(9, 0);
				executeSPXml.setInt(10, 0);
				executeSPXml.setString(11, null);
				executeSPXml.setInt(12, 0);
				executeSPXml.setInt(13, 0);
				executeSPXml.setString(14, null);
				executeSPXml.setString(15, null);
				executeSPXml.setString(16, null);
				executeSPXml.setString(17, null);
				executeSPXml.setString(18, null);
				executeSPXml.setInt(19, 1718);//transaccion
				executeSPXml.setInt(20, 0);
				executeSPXml.setInt(21, tramite);// tramite
				executeSPXml.setString(22, "S");// operacion
				executeSPXml.setString(23, "S");// notificador
				executeSPXml.setInt(24, cliente);// cliente

				ResultSet resultReporte = executeSPXml.executeQuery();

				LOGGER.debug("resultReporte---getRow:" + resultReporte.getRow());
				LOGGER.debug("resultReporte---resultReporte:" + resultReporte);

				KYCAutoOnboardSubDTO kycAutoOnboardSubDTO = new KYCAutoOnboardSubDTO();

				while (resultReporte.next()) {
					LOGGER.debug("Ingreso al while resultReporte:" + resultReporte.getString(2));

					kycAutoOnboardSubDTO.setDiaProceso(Util.getDay(resultReporte.getString(1)));
					kycAutoOnboardSubDTO.setMesProceso(Util.getMonth(resultReporte.getString(1)));
					kycAutoOnboardSubDTO.setAnioProceso(Util.getYear(resultReporte.getString(1)));

					kycAutoOnboardSubDTO.setNombre(resultReporte.getString(2));
					kycAutoOnboardSubDTO.setGenero(resultReporte.getString(3));
					kycAutoOnboardSubDTO.setRfcHomoclave(resultReporte.getString(4));
					kycAutoOnboardSubDTO.setEntidadFederativaNacimiento(resultReporte.getString(5));

					String dd = Util.getDay(resultReporte.getString(6));
					String mm = Util.getMonth(resultReporte.getString(6));
					String yy = Util.getYear(resultReporte.getString(6));
					String getBirthDate = dd + " " + mm + " " + yy;
					kycAutoOnboardSubDTO.setFechaNacimiento(getBirthDate);

					kycAutoOnboardSubDTO.setPaisNacimiento(resultReporte.getString(7));
					kycAutoOnboardSubDTO.setNacionalidad(resultReporte.getString(8));
					kycAutoOnboardSubDTO.setCalleNumero(resultReporte.getString(9));
					kycAutoOnboardSubDTO.setColonia(resultReporte.getString(10));
					kycAutoOnboardSubDTO.setDelegacionMunicipio(resultReporte.getString(11));
					kycAutoOnboardSubDTO.setCiudadEstadoEntFed(resultReporte.getString(12));
					kycAutoOnboardSubDTO.setCodigoPostal(resultReporte.getString(13));
					kycAutoOnboardSubDTO.setPais(resultReporte.getString(14));
					kycAutoOnboardSubDTO.setOcupacionProfesionActividad(resultReporte.getString(15));
					kycAutoOnboardSubDTO.setActEcoGenerica(resultReporte.getString(16));
					kycAutoOnboardSubDTO.setActEcoEspecifica(resultReporte.getString(17));
					kycAutoOnboardSubDTO.setCurp(resultReporte.getString(18));
					kycAutoOnboardSubDTO.setTelefono(resultReporte.getString(19));
					kycAutoOnboardSubDTO.setCorreoElectronico(resultReporte.getString(20));
					kycAutoOnboardSubDTO.setFirmaElectronicaAvanzada(resultReporte.getString(21));
					kycAutoOnboardSubDTO.setOrigenRecursos(resultReporte.getString(22));
					kycAutoOnboardSubDTO.setDestinoRecursos(resultReporte.getString(23));

					if (resultReporte.getString(24).equals("SI")) {
						kycAutoOnboardSubDTO.setRespA1("X");
					} else {
						kycAutoOnboardSubDTO.setRespA2("X");
					}
					if (resultReporte.getString(25).equals("SI")) {
						kycAutoOnboardSubDTO.setRespB1("X");
					} else {
						kycAutoOnboardSubDTO.setRespB2("X");
					}
					if (resultReporte.getString(26).equals("SI")) {
						kycAutoOnboardSubDTO.setRespC1("X");
					} else {
						kycAutoOnboardSubDTO.setRespC2("X");
					}

					kycAutoOnboardSubDTO.setNumEstimadoOperEnv(resultReporte.getString(27));
					kycAutoOnboardSubDTO.setMontoEstimadoOperEnv(resultReporte.getString(28));
					kycAutoOnboardSubDTO.setNumEstimadoOperRec(resultReporte.getString(29));
					kycAutoOnboardSubDTO.setMontoEstimadoOperRec(resultReporte.getString(30));
					kycAutoOnboardSubDTO.setNumEstimadoOperEfe(resultReporte.getString(31));
					kycAutoOnboardSubDTO.setMontoEstimadoOperEfe(resultReporte.getString(32));
					kycAutoOnboardSubDTO.setNumEstimadoOperNoEfe(resultReporte.getString(33));
					kycAutoOnboardSubDTO.setMontoEstimadoOperNoEfe(resultReporte.getString(34));
					kycAutoOnboardSubDTO.setComentarios("");
					kycAutoOnboardSubDTO.setNombreEjecutivo(resultReporte.getString(35));
					kycAutoOnboardSubDTO.setNumContraparte(resultReporte.getString(37));
					kycAutoOnboardSubDTO.setCanalContratacion(resultReporte.getString(38));
					kycAutoOnboardSubDTO.setFechaNacConst(resultReporte.getString(39));

					kycAutoOnboardSubDTOList.add(kycAutoOnboardSubDTO);
				}

				/* Se setea todo a la clase principal */
				kycAutoOnboardDTO.setKycSimplificadoDetalle(kycAutoOnboardSubDTOList);

				LOGGER.debug("Finaliza executeWithDTO");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeWithDTO Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR executeWithDTO -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally executeWithDTO");
			}
		}
		return kycAutoOnboardDTO;
	}

	public void executeByTransaction(JobExecutionContext arg0, Map<String, Object> param, String filePathNameReportGenerate, String jasperFileName) {
		Connection cn = null;
		CallableStatement executeSP = null;
		String namePdf = null;

		try {
			LOGGER.debug("Ingreso executeByTransaction -->>datosEntrada: " + inputData);
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			String documentCode = inputData.getDocumentCode();
			Integer customerCode = inputData.getCustomerId();
			String bank = inputData.getBank();

			LOGGER.debug("-->>executeByTransaction-->>datosReporte::" + inforForReport + "-->>filePathNameReportGenerate:" + filePathNameReportGenerate);

			if (inforForReport.getKycSimplificadoDetalle() != null) {

				Collection<KYCAutoOnboardDTO> dataCol = new ArrayList<KYCAutoOnboardDTO>();
				KYCAutoOnboardDTO kycAutoOnboardDTO = (KYCAutoOnboardDTO) inforForReport;
				dataCol.add(kycAutoOnboardDTO);

				DigitizedDocumentProcessing update = new DigitizedDocumentProcessing();

				if (ReportsGenWithoutRegistration.generateReport(filePathNameReportGenerate, null, param, jasperFileName, dataCol)) {
					update.executeNotification(cn, executeSP, "U", customerCode, "T", documentCode, bank, filePathNameReportGenerate, 2,null); // TERMINADO
				} else {
					update.executeNotification(cn, executeSP, "U", customerCode, "E", documentCode, bank, filePathNameReportGenerate, 2,null);// ERROR
				}

				LOGGER.debug("-->>executeByTransaction1 -- Ruta y nombre:" + namePdf);
				LOGGER.debug("-->>Finaliza executeByTransaction");
			}

		} catch (Exception e) {
			LOGGER.error("-->>ERROR executeByTransaction -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {
					cn.close();
				}
			} catch (SQLException e) {
				LOGGER.error("-->>SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("-->>finally executeByTransaction");
			}
		}

	}

	public void execute(Object inputDto, JobExecutionContext arg0, String filePathNameReportGenerate, String jasperFileName) throws JobExecutionException {
		LOGGER.debug("-->>Ingresa a execute");
		try {
			inputData = (ReportesAutoOnboardDTO) inputDto;
			inforForReport = executeWithDTO(inputData);

			Map<String, Object> param = setParameterToJasper(inputDto);

			executeByTransaction(arg0, param, filePathNameReportGenerate, jasperFileName);

		} catch (Exception ex) {
			LOGGER.error("-->>Exception en execute: ", ex);
		}
	}

}