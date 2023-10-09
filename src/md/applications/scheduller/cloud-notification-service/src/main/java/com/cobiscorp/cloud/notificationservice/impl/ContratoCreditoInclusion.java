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
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoCreditoInclusionDetalleDosDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoCreditoInclusionDetalleDosDatosOpDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoCreditoInclusionDetallePrincipalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoCreditoInclusionDetalleUnoDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoCreditoInclusionPrincipalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoSimpleIndAutoOnboardClausulaDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.FirmasDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportResponseDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.TransactionContextReport;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;
import com.cobiscorp.cloud.scheduler.utils.Util;

public class ContratoCreditoInclusion extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(ContratoCreditoInclusion.class);

	private static ReportesAutoOnboardDTO inputData;
	private static ContratoCreditoInclusionPrincipalDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {
			List<ContratoCreditoInclusionDetallePrincipalDTO> parametros = inforForReport.getContratoCreditoInclusionDetallePrincipal();
			LOGGER.debug("setParameterToJasper-->>parametros:" + parametros);

			if (parametros != null) {
				// Mapeo de Datos al jaspers
				parameters.put("condusef", parametros.get(0).getCciDetalleUno().get(0).getNumeroRegistro());
				parameters.put("porCovit", parametros.get(0).getPorCovit());
				parameters.put("pieAnio", parametros.get(0).getPieAnio());

				parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO_II);
				parameters.put("firmaNF1CCI", ConstantValue.URLIMAG_firmaNF1CCI);
				parameters.put("firmaNF2CCI", ConstantValue.URLIMAG_firmaNF2CCI);
				parameters.put("firmaNB1CCI", ConstantValue.URLIMAG_firmaNB1CCI);
				parameters.put("firmaNB2CCI", ConstantValue.URLIMAG_firmaNB2CCI);
			}
		}
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<ContratoCreditoInclusionPrincipalDTO> dataCollection = new ArrayList<ContratoCreditoInclusionPrincipalDTO>();
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
	public ContratoCreditoInclusionPrincipalDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		ContratoCreditoInclusionPrincipalDTO contratoCreditoInclusionPrincipalDTO = new ContratoCreditoInclusionPrincipalDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer application = inputObject.getApplication();
			String bank = inputObject.getBank();

			PreparedStatement executeSPXml = null;

			try {
				List<ContratoCreditoInclusionDetallePrincipalDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetallePrincipalDTO>();
				/* Datos Contrato */
				LOGGER.debug("llamada al sp datos contrato - cob_credito..sp_datos_credito");
				String queryXmlD = "{ call cob_credito..sp_datos_credito(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlD);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setInt(2, 0);
				executeSPXml.setInt(3, 0);
				executeSPXml.setInt(4, 0);
				executeSPXml.setString(5, null);
				executeSPXml.setDate(6, null);
				executeSPXml.setString(7, null);
				executeSPXml.setString(8, "N");
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setString(11, null);
				executeSPXml.setString(12, null);
				executeSPXml.setInt(13, 0);
				executeSPXml.setString(14, "T");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha
				executeSPXml.setString(17, "D");

				ResultSet resultDatosContrato = executeSPXml.executeQuery();

				LOGGER.debug("resultDatosContrato---getRow:" + resultDatosContrato.getRow());
				LOGGER.debug("resultDatosContrato---resultDatosContrato:" + resultDatosContrato);

				ContratoCreditoInclusionDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoInclusionDetallePrincipalDTO();
				String fecha = "";
				int gracia = 0;

				while (resultDatosContrato.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultDatosContrato.getString(1));
					fecha = resultDatosContrato.getString(25);
					cciDetallePrincipalDTO.setDia(Util.getDay(fecha));
					cciDetallePrincipalDTO.setMes(Util.getMonth(fecha));
					cciDetallePrincipalDTO.setAnio(Util.getYear(fecha));

					LOGGER.debug("Gracia:" + resultDatosContrato.getString(26));
					gracia = Integer.valueOf(resultDatosContrato.getString(26));
				}

				/* Parametros Contrato */
				LOGGER.debug("llamada al sp datos contrato - cob_credito..sp_datos_credito");
				String queryXmlP = "{ call cob_credito..sp_datos_credito(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlP);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setInt(2, 0);
				executeSPXml.setInt(3, 0);
				executeSPXml.setInt(4, 0);
				executeSPXml.setString(5, null);
				executeSPXml.setDate(6, null);
				executeSPXml.setString(7, null);
				executeSPXml.setString(8, "N");
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setString(11, null);
				executeSPXml.setString(12, null);
				executeSPXml.setInt(13, 0);
				executeSPXml.setString(14, "P");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha
				executeSPXml.setString(17, "D");

				ResultSet resultParamsContrato = executeSPXml.executeQuery();

				LOGGER.debug("resultParamsContrato---getRow:" + resultParamsContrato.getRow());
				LOGGER.debug("resultParamsContrato---resultParamsContrato:" + resultParamsContrato);

				String inclFinUnoS = "--";
				String inclFinDosS = "--";
				String bancoUnoS = "--";
				String bancoDosS = "--";
				String numRegistroS = "--";
				String lugarPagoS = "--";
				String porCovit = "--";
				String pieAnio = "--";

				while (resultParamsContrato.next()) {
					LOGGER.debug("Ingreso al while resultParametrosContrato:" + resultParamsContrato.getString(1));
					if (resultParamsContrato.getString(1) != null) {
						inclFinUnoS = resultParamsContrato.getString(1);
					}
					if (resultParamsContrato.getString(2) != null) {
						inclFinDosS = resultParamsContrato.getString(2);
					}
					if (resultParamsContrato.getString(3) != null) {
						bancoUnoS = resultParamsContrato.getString(3);
					}
					if (resultParamsContrato.getString(4) != null) {
						bancoDosS = resultParamsContrato.getString(4);
					}
					if (resultParamsContrato.getString(5) != null) {
						lugarPagoS = resultParamsContrato.getString(5);
					}
					if (resultParamsContrato.getString(6) != null) {
						lugarPagoS = lugarPagoS + " " + resultParamsContrato.getString(6);
					}
					if (resultParamsContrato.getString(7) != null) {
						lugarPagoS = lugarPagoS + " " + resultParamsContrato.getString(7);
					}
					if (resultParamsContrato.getString(8) != null) {
						lugarPagoS = lugarPagoS + " " + resultParamsContrato.getString(8);
					}
					if (resultParamsContrato.getString(9) != null) {
						lugarPagoS = lugarPagoS + " " + resultParamsContrato.getString(9);
					}
					if (resultParamsContrato.getString(10) != null) {
						lugarPagoS = lugarPagoS + " " + resultParamsContrato.getString(10);
					}
					if (gracia > 0) {
						if (resultParamsContrato.getString(11) != null) {
							numRegistroS = resultParamsContrato.getString(11);
						}
					} else {
						if (resultParamsContrato.getString(12) != null) {
							numRegistroS = resultParamsContrato.getString(12);
						}
					}
					if (resultParamsContrato.getString(13) != null) {
						porCovit = resultParamsContrato.getString(13);
					}
					if (resultParamsContrato.getString(14) != null) {
						pieAnio = resultParamsContrato.getString(14);
					}
				}
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - inclFinUnoS: " + inclFinUnoS);
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - inclFinDosS: " + inclFinDosS);
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - bancoUnoS: " + bancoUnoS);
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - bancoDosS: " + bancoDosS);
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - numRegistroS: " + numRegistroS);
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - lugarPagoS: " + lugarPagoS);

				cciDetallePrincipalDTO.setNombreInclusionRepUno(inclFinUnoS);
				cciDetallePrincipalDTO.setNombreInclusionRepDos(inclFinDosS);

				cciDetallePrincipalDTO.setNombreBancoRepUno(bancoUnoS);
				cciDetallePrincipalDTO.setNombreBancoRepDos(bancoDosS);

				cciDetallePrincipalDTO.setPorCovit(porCovit);
				cciDetallePrincipalDTO.setPieAnio(pieAnio);

				/* Contrato Llenado */
				LOGGER.debug("llamada al sp cob_cartera..sp_orden_desembolso_gru");
				String queryXmlL = "{ call cob_cartera..sp_orden_desembolso_gru(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlL);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setDate(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setString(4, null);
				executeSPXml.setString(5, null);
				executeSPXml.setInt(6, 0);
				executeSPXml.setInt(7, 0);
				executeSPXml.setString(8, null);
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setInt(11, 0);
				executeSPXml.setString(12, "L"); // operacion
				executeSPXml.setString(13, bank);// banco
				executeSPXml.setInt(14, 103);// formato fecha
				executeSPXml.setInt(15, 2);// opcion
				executeSPXml.setInt(16, 2);// modo

				int resultLlenado = executeSPXml.executeUpdate();
				LOGGER.debug("resultLlenado---resultLlenado:" + resultLlenado);

				/* Contrato Consultado */
				LOGGER.debug("llamada al sp cob_cartera..sp_orden_desembolso_gru");
				String queryXmlC = "{ call cob_cartera..sp_orden_desembolso_gru(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setDate(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setString(4, null);
				executeSPXml.setString(5, null);
				executeSPXml.setInt(6, 0);
				executeSPXml.setInt(7, 0);
				executeSPXml.setString(8, null);
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setInt(11, 0);
				executeSPXml.setString(12, "Q"); // operacion
				executeSPXml.setString(13, bank);// banco
				executeSPXml.setInt(14, 103);// formato fecha
				executeSPXml.setInt(15, 2);// opcion
				executeSPXml.setInt(16, 2);// modo

				ResultSet resultContrato = executeSPXml.executeQuery();

				LOGGER.debug("resultContrato---getRow:" + resultContrato.getRow());
				LOGGER.debug("resultContrato---resultContrato:" + resultContrato);

				List<ReportResponseDTO> reportResponseDTOList = new ArrayList<ReportResponseDTO>();
				String nombres = "";
				String documento = "";

				while (resultContrato.next()) {
					LOGGER.debug("Ingreso al while contrato1:" + resultContrato.getString(10));
					nombres = nombres + resultContrato.getString(10) + ",";
					LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - reportResponse[i].getAddressCustomer(): " + resultContrato.getString(13));
					if (resultContrato.getString(13) != null) {
						documento = documento + resultContrato.getString(13) + ",";
					}
					ReportResponseDTO reportResponseDTO = new ReportResponseDTO();
					reportResponseDTO.setDisbursementOffice(resultContrato.getString(2));
					reportResponseDTO.setDisbursementForm(resultContrato.getString(3));
					reportResponseDTO.setReference(resultContrato.getString(4));
					reportResponseDTO.setCurrencyDescrip(resultContrato.getString(6));
					reportResponseDTO.setQuotation(resultContrato.getDouble(7));
					reportResponseDTO.setAmount(resultContrato.getDouble(8));
					reportResponseDTO.setBank(resultContrato.getString(9));
					reportResponseDTO.setClient(resultContrato.getString(10));
					reportResponseDTO.setCustomerId(resultContrato.getInt(11));
					reportResponseDTO.setDate(resultContrato.getString(12));
					reportResponseDTO.setAddressCustomer(resultContrato.getString(13));
					reportResponseDTO.setSettlementDate(resultContrato.getString(14));
					reportResponseDTO.setRole(resultContrato.getString(15));
					reportResponseDTO.setRoleDescription(resultContrato.getString(16));
					reportResponseDTO.setDisplacement(resultContrato.getString(17));
					reportResponseDTO.setAmountPreviousDebt(resultContrato.getDouble(18));
					reportResponseDTO.setAmountWorkingCapital(resultContrato.getDouble(19));
					reportResponseDTO.setAmountTotalReceive(resultContrato.getDouble(20));

					reportResponseDTOList.add(reportResponseDTO);

				}
				LOGGER.debug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - documento: " + documento);

				cciDetallePrincipalDTO.setNombreCliente(nombres);

				// Sin datos
				List<ContratoCreditoInclusionDetalleUnoDTO> ccinclusionDetalleDTOUno = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
				ccinclusionDetalleDTOUno = getDetalleUno(numRegistroS);

				// Va la lista
				List<ContratoCreditoInclusionDetalleDosDTO> ccinclusionDetalleDTODos = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
				ccinclusionDetalleDTODos = getDetalleDos(reportResponseDTOList, lugarPagoS, documento);

				// Firmas
				List<FirmasDTO> firmasDTOUno = new ArrayList<FirmasDTO>();
				List<FirmasDTO> firmasDTODos = new ArrayList<FirmasDTO>();

				firmasDTOUno = getDetalleFirma(reportResponseDTOList);
				firmasDTODos = getDetalleFirma(reportResponseDTOList);

				cciDetallePrincipalDTO.setCciDetalleUno(ccinclusionDetalleDTOUno);
				cciDetallePrincipalDTO.setCciDetalleDos(ccinclusionDetalleDTODos);

				// Envio de listas
				TransactionContextReport transContextReportFirm = new TransactionContextReport();
				transContextReportFirm = dataListFirm(firmasDTOUno);
				firmasDTOUno = (List<FirmasDTO>) transContextReportFirm.getValue(ConstantValue.valueConstant.list1);
				firmasDTODos = (List<FirmasDTO>) transContextReportFirm.getValue(ConstantValue.valueConstant.list2);

				cciDetallePrincipalDTO.setCciDetalleFirmaUno(firmasDTOUno);
				cciDetallePrincipalDTO.setCciDetalleFirmaDos(firmasDTODos);

				dataBeanList.add(cciDetallePrincipalDTO);

				/* Lista Informacion Previa */
				List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionInfoPreviaDTOList = new ArrayList<ContratoSimpleIndAutoOnboardClausulaDTO>();
				LOGGER.debug("llamada Informacion Previa");
				ContratoSimpleIndAutoOnboardClausulaDTO infoprevia = new ContratoSimpleIndAutoOnboardClausulaDTO();
				infoprevia.setCampo(".");
				contratoCreditoInclusionInfoPreviaDTOList.add(infoprevia);

				/* Lista AnexoLegal */
				List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionAnexoLegalDTOList = new ArrayList<ContratoSimpleIndAutoOnboardClausulaDTO>();
				LOGGER.debug("llamada AnexoLegal");
				ContratoSimpleIndAutoOnboardClausulaDTO anexoLegal = new ContratoSimpleIndAutoOnboardClausulaDTO();
				anexoLegal.setCampo(".");
				contratoCreditoInclusionAnexoLegalDTOList.add(anexoLegal);

				/* Se setea todo a la clase principal */
				contratoCreditoInclusionPrincipalDTO.setContratoCreditoInclusionInfoPrevia(contratoCreditoInclusionInfoPreviaDTOList);
				contratoCreditoInclusionPrincipalDTO.setContratoCreditoInclusionDetallePrincipal(dataBeanList);
				contratoCreditoInclusionPrincipalDTO.setContratoCreditoInclusionAnexoLegal(contratoCreditoInclusionAnexoLegalDTOList);

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
		return contratoCreditoInclusionPrincipalDTO;
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

			if (inforForReport.getContratoCreditoInclusionDetallePrincipal() != null) {

				Collection<ContratoCreditoInclusionPrincipalDTO> dataCol = new ArrayList<ContratoCreditoInclusionPrincipalDTO>();
				ContratoCreditoInclusionPrincipalDTO contratoCreditoInclusionPrincipalDTO = (ContratoCreditoInclusionPrincipalDTO) inforForReport;
				dataCol.add(contratoCreditoInclusionPrincipalDTO);

				DigitizedDocumentProcessing update = new DigitizedDocumentProcessing();

				if (ReportsGenWithoutRegistration.generateReport(filePathNameReportGenerate, null, param, jasperFileName, dataCol)) {
					update.executeNotification(cn, executeSP, "U", customerCode, "T", documentCode, bank, filePathNameReportGenerate, 2, null); // TERMINADO
				} else {
					update.executeNotification(cn, executeSP, "U", customerCode, "E", documentCode, bank, filePathNameReportGenerate, 2, null);// ERROR
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

	// Lleva una lista
	public List<ContratoCreditoInclusionDetalleUnoDTO> getDetalleUno(String numRegistro) {
		List<ContratoCreditoInclusionDetalleUnoDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
		ContratoCreditoInclusionDetalleUnoDTO dataBean = new ContratoCreditoInclusionDetalleUnoDTO();
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleUno - Sin Datos");
		dataBean.setNumeroRegistro(numRegistro);
		dataBeanList.add(dataBean);
		return dataBeanList;
	}

	// Lleva una lista
	public List<ContratoCreditoInclusionDetalleDosDTO> getDetalleDos(List<ReportResponseDTO> reportResponse, String lugarPago, String documento) {
		List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleDos - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				LOGGER.debug("*****>> Inicia getDetalleDos - reportResponse.length" + reportResponse.size());
				if (reportResponse.size() > 0) {
					ContratoCreditoInclusionDetalleDosDTO cciDetalleDTO = new ContratoCreditoInclusionDetalleDosDTO();
					List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
					List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacionMontos = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
					datosOperacion = getDetalleDosDatosOp(reportResponse);
					datosOperacionMontos = getDetalleDosDatosOp(reportResponse);
					cciDetalleDTO.setDatosOperacion(datosOperacion);
					cciDetalleDTO.setDatosOperacionMontos(datosOperacionMontos);
					cciDetalleDTO.setLugarPago(lugarPago);
					cciDetalleDTO.setDocumento(documento);
					dataBeanList.add(cciDetalleDTO);
				} else {
					this.initDetalleDos(dataBeanList);
				}

			} else {
				this.initDetalleDos(dataBeanList);
			}
		} catch (Exception e) {
			LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Error getDetalle", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	public List<ContratoCreditoInclusionDetalleDosDatosOpDTO> getDetalleDosDatosOp(List<ReportResponseDTO> reportResponse) {
		List<ContratoCreditoInclusionDetalleDosDatosOpDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleDosDatosOp - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				LOGGER.debug("*****>> Inicia getDetalleDosDatosOp - reportResponse.length" + reportResponse.size());
				if (reportResponse.size() > 0) {
					for (ReportResponseDTO report : reportResponse) {
						ContratoCreditoInclusionDetalleDosDatosOpDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDatosOpDTO();
						cciDetalleDosDatosOpDTO.setNombre(report.getClient());
						cciDetalleDosDatosOpDTO.setMonto(Util.getStringCurrencyFormated(report.getAmount()));
						cciDetalleDosDatosOpDTO.setMontoDestAdeudo(Util.getStringCurrencyFormated(report.getAmountPreviousDebt()));
						cciDetalleDosDatosOpDTO.setMontoDestCap(Util.getStringCurrencyFormated(report.getAmountWorkingCapital()));
						cciDetalleDosDatosOpDTO.setMontoRecibir(Util.getStringCurrencyFormated(report.getAmountTotalReceive()));
						dataBeanList.add(cciDetalleDosDatosOpDTO);
					}
				} else {
					this.initDetalleDosDatosOp(dataBeanList);
				}
			} else {
				this.initDetalleDosDatosOp(dataBeanList);
			}
		} catch (Exception e) {
			LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	private void initDetalleDos(List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList) {
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - initDetalleDosDatosOpDTO");
		ContratoCreditoInclusionDetalleDosDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDTO();
		List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
		cciDetalleDosDatosOpDTO.setDatosOperacion(datosOperacion);
		cciDetalleDosDatosOpDTO.setLugarPago("");
		dataBeanList.add(cciDetalleDosDatosOpDTO);
	}

	private void initDetalleDosDatosOp(List<ContratoCreditoInclusionDetalleDosDatosOpDTO> dataBeanList) {
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - initDetalleDosDatosOpDTO");
		ContratoCreditoInclusionDetalleDosDatosOpDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDatosOpDTO();
		cciDetalleDosDatosOpDTO.setNombre("");
		cciDetalleDosDatosOpDTO.setMonto("");
		dataBeanList.add(cciDetalleDosDatosOpDTO);
	}

	public List<FirmasDTO> getDetalleFirma(List<ReportResponseDTO> reportResponse) {
		List<FirmasDTO> dataBeanList = new ArrayList<FirmasDTO>();
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleFirma - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				LOGGER.debug("*****>> Inicia getDetalleFirma - reportResponse.length" + reportResponse.size());
				if (reportResponse.size() > 0) {
					for (ReportResponseDTO report : reportResponse) {
						FirmasDTO firmasDTO = new FirmasDTO();
						firmasDTO.setCargo("");
						firmasDTO.setNombre(report.getClient());
						dataBeanList.add(firmasDTO);
					}
				} else {
					this.initDetalleFirma(dataBeanList);
				}
			} else {
				this.initDetalleFirma(dataBeanList);
			}
		} catch (Exception e) {
			LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	private void initDetalleFirma(List<FirmasDTO> dataBeanList) {
		LOGGER.debug("*****>>ContratoCreditoInclusionListIMPL - initDetalleFirma");
		FirmasDTO firmasDTO = new FirmasDTO();
		firmasDTO.setCargo("");
		firmasDTO.setNombre("");
		dataBeanList.add(firmasDTO);
	}

	public TransactionContextReport dataListFirm(List<FirmasDTO> dataListFirma) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug(" *****-- INICIO SERVICIO dataListFirma -- dataListFirma:" + dataListFirma);
		}

		List<FirmasDTO> dataListFirma1 = new ArrayList<FirmasDTO>();
		List<FirmasDTO> dataListFirma2 = new ArrayList<FirmasDTO>();

		if (dataListFirma != null && !dataListFirma.isEmpty()) {
			for (int i = 0; i < dataListFirma.size(); i++) {
				if ((i % 2) == 0) {
					FirmasDTO dataListFirma11 = new FirmasDTO();
					dataListFirma11.setCargo(dataListFirma.get(i).getCargo());
					dataListFirma11.setNombre(dataListFirma.get(i).getNombre());
					dataListFirma1.add(dataListFirma11);
				} else {
					FirmasDTO dataListFirma22 = new FirmasDTO();
					dataListFirma22.setCargo(dataListFirma.get(i).getCargo());
					dataListFirma22.setNombre(dataListFirma.get(i).getNombre());
					dataListFirma2.add(dataListFirma22);
				}
			}
		}
		TransactionContextReport listFirm = new TransactionContextReport();
		listFirm.addValue(ConstantValue.valueConstant.list1, dataListFirma1);
		listFirm.addValue(ConstantValue.valueConstant.list2, dataListFirma2);

		return listFirm;
	}

}