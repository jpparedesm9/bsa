package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusAmortizationTableDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusHeaderDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusInformationDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusMovementDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusMovementTotalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoObjetadoDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.FileZipPassword;
import com.cobiscorp.cloud.scheduler.utils.GenerateReportInterfactura;
import com.cobiscorp.cloud.scheduler.utils.Util;

public class EstadoCuenta extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(EstadoCuenta.class);

	private static Integer codigo;
	private static String banco;
	private static String correo;
	private static String buc_cliente;
	private static String fechaCreacionCliente;
	Date fechaInterfactura = new Date();
	SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
	Calendar calendarInterfactura = Calendar.getInstance();
	String diaInter = null;
	String mesInter = null;
	String anioInter = null;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		
		AccountStatusDTO objDatos = (AccountStatusDTO) inputDto;
		AccountStatusHeaderDTO aStatusHeader = objDatos.getAccountStatusHeader();
		AccountStatusInformationDTO aStatusInformation = objDatos.getAccountStatusInformation();
		AccountStatusMovementTotalDTO aStatusMovementTotalDTO = objDatos.getAccountStatusMovementTotalDTO();
		List<AccountStatusAmortizationTableDTO> amortizationTable = objDatos.getAmortizationTable();
		List<AccountStatusMovementDTO> movement = objDatos.getMovement();
		List<PagoObjetadoDTO> pagoObjetadoTable = objDatos.getPagoObjetadoTable();

		Map<String, Object> parameters = new HashMap<String, Object>();

		// Mapeo de Datos al jaspers
		parameters.put("sucursal", aStatusHeader.getDescSucursal());
		parameters.put("nombreCliente", aStatusHeader.getNombreCliente());
		parameters.put("rfc", aStatusHeader.getRfc());
		parameters.put("domicilio", aStatusHeader.getCalle() + " " + aStatusHeader.getNumero() + " " + aStatusHeader.getParroquia() + " " + aStatusHeader.getDelegacion() + " "
				+ aStatusHeader.getCodigoPostal() + " " + aStatusHeader.getEstado());
		parameters.put("producto", aStatusHeader.getTipoOperacion());
		parameters.put("nombreGrupo", aStatusHeader.getNombreGrupo());
		parameters.put("numCredito", aStatusHeader.getOperacion());
		parameters.put("periodo", aStatusHeader.getFechaInicio() + " - " + aStatusHeader.getFechaReporte());
		parameters.put("fecheCorte", aStatusHeader.getDiaHabil());

		parameters.put("icLimCredito", aStatusInformation.getLimiteCredito());
		parameters.put("icSaldoIni", aStatusInformation.getSaldoInicial());
		parameters.put("icIntOrdinario", aStatusInformation.getInteresOrdinario());
		parameters.put("icTotalPagar", aStatusInformation.getTotalCredito());
		parameters.put("icmCapital", aStatusInformation.getCapital());

		parameters.put("icmIntOrdinarios", aStatusInformation.getInteresParcial());
		parameters.put("icmIvaIntOrd", aStatusInformation.getIvaInteres());
		parameters.put("icmTotal", aStatusInformation.getTotalParcial());
		parameters.put("icBaseCalculoInt", aStatusInformation.getBaseCalculo());
		parameters.put("icSaldoFinalCap", aStatusInformation.getSaldoFinalCap());
		/**/
		parameters.put("icEstCredito", aStatusInformation.getEstado());
		parameters.put("icPlazoIni", aStatusInformation.getFechaInicio());
		parameters.put("icPlazoFin", aStatusInformation.getFechaFin());
		parameters.put("icFrecPago", aStatusInformation.getFrecuenciaPago());
		parameters.put("icPlazoSemanas", aStatusInformation.getPlazo());
		parameters.put("icDiaPago", aStatusInformation.getDiaPago());
		parameters.put("icTasOrdAnual", aStatusInformation.getTasaOrdinaria());
		parameters.put("icTasOrdMensual", aStatusInformation.getTasaMensual());
		parameters.put("icDeposGar", aStatusInformation.getDepGarantias());
		parameters.put("icFechaDepositoGar", aStatusInformation.getFecDepGarantias());
		parameters.put("icInfoCat", aStatusInformation.getCat());
		parameters.put("icInfoComisiones", aStatusInformation.getComisiones());

		parameters.put("rtTotalPagos", aStatusMovementTotalDTO.getPagos());
		parameters.put("rtCapital", aStatusMovementTotalDTO.getCapital());
		parameters.put("rtInteresOrdinarios", aStatusMovementTotalDTO.getInteres());
		parameters.put("rtIvaInteresOrd", aStatusMovementTotalDTO.getIva());
		parameters.put("rtImportTotalComisioes", aStatusMovementTotalDTO.getImporteTotal());
		parameters.put("rtTipoComision", aStatusMovementTotalDTO.getTipoComision());
		parameters.put("rtFechaComision", aStatusMovementTotalDTO.getFechaComision());

		// En el reporte indica que deben ir vacios
		parameters.put("coFecha", "");
		parameters.put("coMovimiento", "");
		parameters.put("coImporte", "");
		parameters.put("coNumFolio", "");

		parameters.put("folioFiscal", aStatusHeader.getFolioFiscal());
		parameters.put("certificado", aStatusHeader.getCertificado());
		parameters.put("selloDigital", aStatusHeader.getSelloDigital());
		parameters.put("selloSat", aStatusHeader.getSelloSAT());
		parameters.put("serieCertificadoSAT", aStatusHeader.getSerieCertificado());
		parameters.put("fechaHoraCertificacion", aStatusHeader.getFechaCertificacion());
		parameters.put("cadOriComSAT", aStatusHeader.getCadOriComSAT());
		parameters.put("rfcEmisor", aStatusHeader.getRfcEmisor());
		parameters.put("montoFactura", aStatusHeader.getMontoFactura());

		Calendar actual = Calendar.getInstance();
		parameters.put("eDiaEmitido", Util.numberCero(actual.get(Calendar.DAY_OF_MONTH)));
		parameters.put("eMesEmitido", Util.monthDescription(actual));
		parameters.put("eAnioEmitido", String.valueOf(actual.get(Calendar.YEAR)));
		parameters.put("eHoraEmitido", String.valueOf(actual.get(Calendar.HOUR_OF_DAY) + ":" + String.valueOf(actual.get(Calendar.MINUTE))));
		parameters.put("fechaImpresion", Util.numberCero(actual.get(Calendar.DAY_OF_MONTH)) + "/" + Util.numberCero(actual.get(Calendar.MONTH) + 1) + "/" + String.valueOf(actual.get(Calendar.YEAR)));
		parameters.put("importes", aStatusHeader.getImportes());
		parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO_II);
		parameters.put("urlPathCodigo", ConstantValue.URL_IMAGEN_COD);
		parameters.put("REPORT_LOCALE", new Locale("en", "US"));
		
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		List<AccountStatusDTO> dataCollection = new ArrayList<AccountStatusDTO>();
		return dataCollection;
	}

	/* No borrar el metdodo xmlToDTO se requiere para la clase */
	@Override
	public List<?> xmlToDTO(File inputData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		return null;
	}

	@Override
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
		LOGGER.debug("Correo cliente antes de setear: " + correo);
		if (header.getNombreCliente() != null) {
			parameters.put("NOMBRE_GRUPO", header.getNombreCliente());
		} else {
			parameters.put("NOMBRE_GRUPO", "XX");
		}

		parameters.put("EMAIL_TO", correo);
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject);

		return parameters;

	}

	public void executeByTransaction(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction");
		}
		String fechadoc = "";
		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.ZFIEC);
			CopyFileJob copyFileJobEnvio = new CopyFileJob(FileJob.Job.MPDFI);
			ConfigManager ds = ConfigManager.getInstance();
			// cn = ConnectionManager.openNewConnection();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			// Se ejecuta el sp de notificaciones de codigos
			// executeNotificacionCode(cn, executeSP);

			ResultSet result = executeNotification(cn, executeSP, "Q", null, "P", null);

			LOGGER.debug("result" + result);
			while (result.next()) {
				codigo = result.getInt(1);
				banco = result.getString(2);
				String fecha = result.getString(3).toString();
				correo = result.getString(4).toString();
				Integer formato = 103;
				buc_cliente = result.getString(5).toString();
				fechaCreacionCliente = result.getString(6).toString();

				LOGGER.debug("Banco: " + banco);
				LOGGER.debug("Correo cliente: " + correo);
				PreparedStatement executeSPXml = null;
				try {
					AccountStatusDTO accountStatus = new AccountStatusDTO();

					/* Generar información en tablas temporales */
					LOGGER.debug("primera llamada al sp sp_cons_estado_cuenta-C1");
					String queryXml0 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml0);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "A");
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					executeSPXml.execute();

					/* No es lista CABECERA */
					LOGGER.debug("primera llamada al sp sp_cons_estado_cuenta-C1");
					String queryXml1 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml1);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "C1");
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					LOGGER.debug("resultCabecera----:" + fecha);
					ResultSet resultCabecera = executeSPXml.executeQuery();

					LOGGER.debug("resultCabecera---getRow:" + resultCabecera.getRow());
					LOGGER.debug("resultCabecera---resultCabecera:" + resultCabecera);
					AccountStatusHeaderDTO accountHeader = new AccountStatusHeaderDTO();

					while (resultCabecera.next()) {
						accountHeader.setCodigoSucursal(resultCabecera.getInt(1));
						accountHeader.setDescSucursal(resultCabecera.getString(2));
						accountHeader.setTipoOperacion(resultCabecera.getString(3));
						accountHeader.setNombreCliente(resultCabecera.getString(4));
						accountHeader.setCodigoGrupo(resultCabecera.getInt(5));
						accountHeader.setNombreGrupo(resultCabecera.getString(6));
						accountHeader.setRfc(resultCabecera.getString(7));
						accountHeader.setOperacion(resultCabecera.getString(8));
						accountHeader.setCalle(resultCabecera.getString(9));
						accountHeader.setNumero(resultCabecera.getInt(10));
						accountHeader.setParroquia(resultCabecera.getString(11));
						accountHeader.setDelegacion(resultCabecera.getString(12));
						accountHeader.setCodigoPostal(resultCabecera.getString(13));
						accountHeader.setEstado(resultCabecera.getString(14));
						accountHeader.setFechaInicio(resultCabecera.getString(15));
						accountHeader.setFechaReporte(resultCabecera.getString(16));
						accountHeader.setDiaHabil(resultCabecera.getString(17));
						accountHeader.setImportes(resultCabecera.getString(18));
						accountHeader.setFolioFiscal(resultCabecera.getString(19));
						accountHeader.setCertificado(resultCabecera.getString(20));
						accountHeader.setSelloDigital(resultCabecera.getString(21));
						accountHeader.setSelloSAT(resultCabecera.getString(22));
						accountHeader.setSerieCertificado(resultCabecera.getString(23));
						accountHeader.setFechaCertificacion(resultCabecera.getString(24));
						LOGGER.debug("resultCabecera.getString(25)" + resultCabecera.getString(25));
						LOGGER.debug("resultCabecera.getString(26)" + resultCabecera.getString(26));
						LOGGER.debug("resultCabecera.getString(27)" + resultCabecera.getString(27));
						accountHeader.setCadOriComSAT(resultCabecera.getString(25));
						accountHeader.setRfcEmisor(resultCabecera.getString(26));
						accountHeader.setMontoFactura(resultCabecera.getString(27));
					}
					/* No es lista Informacion */
					LOGGER.debug("segunda llamada al sp sp_cons_estado_cuenta-I1");
					String queryXml2 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml2);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "I1"); // Informacion
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultInformacion = executeSPXml.executeQuery();
					LOGGER.debug("resultInformacion.." + resultInformacion);

					AccountStatusInformationDTO accountInformation = new AccountStatusInformationDTO();
					while (resultInformacion.next()) {
						accountInformation.setLimiteCredito(resultInformacion.getDouble(1));
						accountInformation.setSaldoInicial(resultInformacion.getDouble(2));
						accountInformation.setInteresOrdinario(resultInformacion.getDouble(3));
						accountInformation.setTotalCredito(resultInformacion.getDouble(4));
						accountInformation.setCapital(resultInformacion.getDouble(5));
						accountInformation.setInteresParcial(resultInformacion.getDouble(6));
						accountInformation.setIvaInteres(resultInformacion.getDouble(7));
						accountInformation.setTotalParcial(resultInformacion.getDouble(8));
						accountInformation.setBaseCalculo(resultInformacion.getDouble(9));
						accountInformation.setSaldoFinalCap(resultInformacion.getDouble(10));
						accountInformation.setEstado(resultInformacion.getString(11));
						accountInformation.setFechaInicio(resultInformacion.getString(12));
						accountInformation.setFechaFin(resultInformacion.getString(13));
						accountInformation.setFrecuenciaPago(resultInformacion.getString(14));
						accountInformation.setPlazo(resultInformacion.getInt(15));
						accountInformation.setDiaPago(resultInformacion.getString(16));
						accountInformation.setTasaOrdinaria(resultInformacion.getDouble(17));
						accountInformation.setTasaMensual(resultInformacion.getDouble(18));
						accountInformation.setDepGarantias(resultInformacion.getDouble(19));
						accountInformation.setFecDepGarantias(resultInformacion.getString(20));
						accountInformation.setCat(resultInformacion.getDouble(21));
						accountInformation.setComisiones(resultInformacion.getDouble(22));
					}
					/* Lista de Movimientos */
					LOGGER.debug("tercera llamada al sp sp_cons_estado_cuenta-M1");
					String queryXml3 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml3);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "M1"); // Movimientos
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultMovement = executeSPXml.executeQuery();
					LOGGER.debug("resultMovement.." + resultMovement);
					LOGGER.debug("codigo.." + codigo);

					List<AccountStatusMovementDTO> movementList = new ArrayList<AccountStatusMovementDTO>();

					while (resultMovement.next()) {
						AccountStatusMovementDTO accountMovement = new AccountStatusMovementDTO();
						accountMovement.setNumero(resultMovement.getInt(1));
						accountMovement.setFechaOperacion(resultMovement.getString(2));
						accountMovement.setFechaPactada(resultMovement.getString(3));
						accountMovement.setNumPago(resultMovement.getInt(4));
						accountMovement.setDiasAtraso(resultMovement.getInt(5));
						accountMovement.setDetalleMovimiento(resultMovement.getString(6));
						accountMovement.setTotal(resultMovement.getDouble(7));
						accountMovement.setCapital(resultMovement.getDouble(8));
						accountMovement.setInteresOrdinario(resultMovement.getDouble(9));
						accountMovement.setComisionGastoCobranza(resultMovement.getDouble(10));
						accountMovement.setIvaInt(resultMovement.getDouble(11));
						accountMovement.setIvaMora(resultMovement.getDouble(12));
						accountMovement.setOtros(resultMovement.getDouble(13));
						accountMovement.setSaldoInsoluto(resultMovement.getDouble(14));
						LOGGER.debug("resultMovement.getInt(1).." + resultMovement.getInt(1));
						LOGGER.debug("(resultMovement.getString(2).." + resultMovement.getString(2));
						LOGGER.debug("resultMovement.getString(3).." + resultMovement.getString(3));
						LOGGER.debug("(resultMovement.getInt(4).." + resultMovement.getInt(4));
						movementList.add(accountMovement);
					}
					LOGGER.debug("(totallll..." + movementList.size());

					/* Lista de Tabla de Amortizacion */
					LOGGER.debug("cuarta llamada al sp sp_cons_estado_cuenta-T1");
					String queryXml4 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml4);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "T1"); // Tabla de Amortización
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultAmortization = executeSPXml.executeQuery();
					LOGGER.debug("resultAmortization.." + resultAmortization);

					List<AccountStatusAmortizationTableDTO> amortizationList = new ArrayList<AccountStatusAmortizationTableDTO>();

					while (resultAmortization.next()) {
						AccountStatusAmortizationTableDTO accountAmortization = new AccountStatusAmortizationTableDTO();
						accountAmortization.setTaNumPago(resultAmortization.getInt(1));
						accountAmortization.setTaFechaLimitePago(resultAmortization.getString(2));
						accountAmortization.setTaAbonoPrincipal(resultAmortization.getDouble(3));
						accountAmortization.setTaInteresOrdinarios(resultAmortization.getDouble(4));
						accountAmortization.setTaIvaInteresOrdinarios(resultAmortization.getDouble(5));
						accountAmortization.setTaComisionGastCobranza(resultAmortization.getDouble(6));
						accountAmortization.setTaIvaGastosCobranza(resultAmortization.getDouble(7));
						accountAmortization.setTaMontoPago(resultAmortization.getDouble(8));
						accountAmortization.setTaSaldoInsolutoCap(resultAmortization.getDouble(9));
						amortizationList.add(accountAmortization);
					}

					/* No es lista TOTAL MOVIMIENTOS */
					LOGGER.debug("quinta llamada al sp sp_cons_estado_cuenta-M2");
					String queryXml5 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml5);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "M2");
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultMovementTotal = executeSPXml.executeQuery();

					LOGGER.debug("resultMovementTotal.." + resultMovementTotal);

					AccountStatusMovementTotalDTO accountMovementTotal = new AccountStatusMovementTotalDTO();
					while (resultMovementTotal.next()) {
						accountMovementTotal.setCapital(resultMovementTotal.getDouble(1));
						accountMovementTotal.setInteres(resultMovementTotal.getDouble(2));
						accountMovementTotal.setIva(resultMovementTotal.getDouble(3));
						accountMovementTotal.setPagos(resultMovementTotal.getDouble(4));
						accountMovementTotal.setImporteTotal(resultMovementTotal.getDouble(5));
						accountMovementTotal.setTipoComision(resultMovementTotal.getString(6));
						accountMovementTotal.setFechaComision(resultMovementTotal.getString(7));
					}

					/***************************************************/

					LOGGER.debug("sexta llamada al sp sp_cons_estado_cuenta-O");
					String queryObjetados = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryObjetados);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "O");
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultMovementPagosObjetados = executeSPXml.executeQuery();

					LOGGER.debug("resultMovementPagosObjetados.." + resultMovementPagosObjetados);
					List<PagoObjetadoDTO> pagoObjetadoList = new ArrayList<PagoObjetadoDTO>();

					while (resultMovementPagosObjetados.next()) {
						PagoObjetadoDTO pagoObjetado = new PagoObjetadoDTO();
						pagoObjetado.setFecha(resultMovementPagosObjetados.getString(1));
						pagoObjetado.setDetalleMovimiento(resultMovementPagosObjetados.getString(2));
						pagoObjetado.setImporte(resultMovementPagosObjetados.getDouble(3));
						pagoObjetado.setFolio(resultMovementPagosObjetados.getInt(4));

						LOGGER.debug("pagoObjetado.getFecha().." + pagoObjetado.getFecha());
						LOGGER.debug("pagoObjetado.getDetalleMovimiento().." + pagoObjetado.getDetalleMovimiento());
						LOGGER.debug("pagoObjetado.getImporte().." + pagoObjetado.getImporte());
						LOGGER.debug("pagoObjetado.getFolio().." + pagoObjetado.getFolio());

						pagoObjetadoList.add(pagoObjetado);
					}

					/***************************************************/
					/* Se setea todo a la clase principal */
					accountStatus.setAccountStatusHeader(accountHeader);
					accountStatus.setAccountStatusInformation(accountInformation);
					accountStatus.setMovement(movementList);
					accountStatus.setAmortizationTable(amortizationList);
					accountStatus.setAccountStatusMovementTotalDTO(accountMovementTotal);
					accountStatus.setPagoObjetadoTable(pagoObjetadoList);

					LOGGER.debug("Antes de Generar el reporte");
					LOGGER.debug("Parametro de ingreso para generar el reporte arg0.getJobDetail().getName() >> " + arg0.getJobDetail().getName());
					LOGGER.debug("EL buc del cliente es >> " + buc_cliente);
					LOGGER.debug("La fecha es >> " + fecha);

					// se obtiene la fecha de generacion
					LOGGER.debug("Fecha para pdf >> " + fechaCreacionCliente);

					fechaInterfactura = dateformat.parse(fechaCreacionCliente);
					calendarInterfactura.setTime(fechaInterfactura);
					diaInter = String.valueOf(calendarInterfactura.get(Calendar.DAY_OF_MONTH));
					mesInter = String.valueOf(calendarInterfactura.get(Calendar.MONTH) + 1);
					anioInter = String.valueOf(calendarInterfactura.get(Calendar.YEAR));
					if (mesInter.length() == 1) {
						mesInter = '0' + mesInter;
					}

					fechadoc = anioInter + mesInter + diaInter;

					LOGGER.debug("Fecha dia >> " + diaInter);
					LOGGER.debug("Fecha mes >> " + mesInter);
					LOGGER.debug("Fecha anio >> " + anioInter);

					LOGGER.debug("Fecha extencion para pdf >> " + fechadoc);

					String namePdf = "";

					namePdf = GenerateReportInterfactura.generateReportReturnName(arg0.getJobDetail().getName(), String.valueOf(buc_cliente) + "-" + banco + "-" + fechadoc, null, accountStatus,
							buc_cliente, fechadoc);

					File temp = new File(namePdf);
					LOGGER.debug("namePdf" + namePdf);
					LOGGER.debug("tempnamePdf" + temp.getName());
					FileZipPassword.createZip(copyFileJob, temp.getName(), buc_cliente, true);

					LOGGER.debug("Antes del executeNotification");
					/* Una vez generado el pdf cambio el estado a D para que no vuelva a tomar el mismo registro */
					executeNotification(cn, executeSP, "U", codigo, "D", namePdf);// Estado D para que pueda generar el pdf o correo
					LOGGER.debug("Despues del executeNotification");

				} catch (ParseException e) {
					LOGGER.error("ParseException:", e);
				} catch (Exception e) {
					LOGGER.error("Exception:", e);
					executeNotification(cn, executeSP, "U", codigo, "F", "");// Estado Fallido el nombre del pdf queda en blanco
				} finally {

					if (executeSPXml != null) {
						executeSPXml.close();
					}
					System.gc();
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

	public ResultSet executeNotification(Connection cn, CallableStatement executeSP, String operation, Integer codigo, String status, String nombrePdf) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification EstadoCuenta");
		}
		String query = "{ call cob_conta_super..sp_qr_ns_estado_cuenta(?,?,?,?,?) }";
		LOGGER.debug("query -->" + query);

		try {
			LOGGER.debug("-->>**GRUPAL-->>Operacion: " + operation + "-->Codigo: " + codigo + "-->>status: " + status + "-->>nombrePdf: " + nombrePdf);
			
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
			executeSP.setString(5, "GRUPAL");
			
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

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			executeByTransaction(arg0);
		} catch (Exception ex) {
			LOGGER.error("Exception: ", ex);
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