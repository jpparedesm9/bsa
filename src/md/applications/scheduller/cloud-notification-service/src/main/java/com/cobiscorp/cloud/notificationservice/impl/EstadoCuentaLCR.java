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
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusHeaderDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusInformationDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusMovementDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusMovementTotalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusObjectedChargesTableDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.FileZipPassword;
import com.cobiscorp.cloud.scheduler.utils.GenerateReportInterfactura;
import com.cobiscorp.cloud.scheduler.utils.Util;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class EstadoCuentaLCR extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(EstadoCuentaLCR.class);
	
	
	private static Integer codigo;
	private static String banco;
	private static String correo;
	private static String buc_cliente;
	private static String fechaCreacionCliente; 
	Date fechaInterfactura = new Date();
	Date fechaInterfacturaInicio = new Date();
	Date fechaInterfacturaFin = new Date();
	Date fechaInicioMes = new Date();
    SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
    SimpleDateFormat dateformatdia = new SimpleDateFormat("dd/MM/yyyy");
    Calendar calendarInterfactura = Calendar.getInstance();
    Calendar calendarInterfacturaInicio = Calendar.getInstance();
    Calendar calendarInterfacturaFin = Calendar.getInstance();
    String diaInter = null;
    String mesInter=null;
    String anioInter=null;
    String diaInterIni = null;
    String mesInterIni=null;
    String anioInterIni=null;
    String diaInterFin = null;
    String mesInterFin=null;
    String anioInterFin=null;
    int mesInterFinInt=0;
	
    
	
	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		
		AccountStatusDTO objDatos = (AccountStatusDTO) inputDto;
		AccountStatusHeaderDTO aStatusHeader = objDatos.getAccountStatusHeader();
		AccountStatusInformationDTO aStatusInformation = objDatos.getAccountStatusInformation();
		AccountStatusMovementTotalDTO aStatusMovementTotalDTO = objDatos.getAccountStatusMovementTotalDTO();
		List<AccountStatusObjectedChargesTableDTO> objetecChargesTable = objDatos.getObjectedChargesTable();
		List<AccountStatusMovementDTO> movement = objDatos.getMovement();

		Map<String, Object> parameters = new HashMap<String, Object>();

		// Mapeo de Datos al jaspers parte Cabecera
		parameters.put("sucursal", aStatusHeader.getDescSucursal());
		parameters.put("nombreCliente", aStatusHeader.getNombreCliente());
		parameters.put("rfc", aStatusHeader.getRfc());
		parameters.put("domicilio",
				aStatusHeader.getCalle() + " " + aStatusHeader.getNumero() + " " + aStatusHeader.getParroquia() + " " + aStatusHeader.getDelegacion() + " " + aStatusHeader.getCodigoPostal() + " "
						+ aStatusHeader.getEstado());
		parameters.put("producto", aStatusHeader.getTipoOperacion());
		parameters.put("numCredito", aStatusHeader.getOperacion());
		
		LOGGER.debug("aStatusHeader.getFechaInicio()>> "+ aStatusHeader.getFechaInicio());
		LOGGER.debug(" aStatusHeader.getFechaReporte()>> "+  aStatusHeader.getFechaReporte());
		
		try {
			fechaInterfacturaInicio = dateformatdia.parse(aStatusHeader.getFechaInicio());
			fechaInterfacturaFin    = dateformatdia.parse(aStatusHeader.getFechaReporte());
			
			LOGGER.debug(" fechaInterfacturaInicio>> "+ fechaInterfacturaInicio);
			LOGGER.debug(" fechaInterfacturaFin>> "+ fechaInterfacturaFin);
			
			
			calendarInterfacturaInicio.setTime(fechaInterfacturaInicio);
			calendarInterfacturaFin.setTime(fechaInterfacturaFin);

			
			diaInterFin    = String.valueOf(calendarInterfacturaFin.get(Calendar.DAY_OF_MONTH));
			mesInterFin    = Util.monthDescription(calendarInterfacturaFin);
			anioInterFin   = String.valueOf(calendarInterfacturaFin.get(Calendar.YEAR));
			mesInterFinInt = calendarInterfacturaFin.get(Calendar.MONTH);
			LOGGER.debug(" diaInterFin>> "+ diaInterFin);
			LOGGER.debug(" mesInterFin>> "+ mesInterFin);
			LOGGER.debug(" anioInterFin>> "+ anioInterFin);
			LOGGER.debug(" mesInterFinInt>> "+ mesInterFinInt);
			
			fechaInicioMes=new Date(Integer.valueOf(anioInterFin)-1900,mesInterFinInt,Integer.valueOf(diaInterFin));
			LOGGER.debug(" fechaInicioMes>> "+ fechaInicioMes);
			if(fechaInterfacturaInicio.compareTo(fechaInicioMes)>0)
			{	
				LOGGER.debug(" fecha de Inicio de la op mayor que inicio de mes ");
				diaInterIni  =String.valueOf(calendarInterfacturaInicio.get(Calendar.DAY_OF_MONTH));
				LOGGER.debug(" diaInterIni>> "+ diaInterIni);
			}
			else 
			{
				LOGGER.debug(" fecha de Inicio de la op menor que inicio de mes ");
				diaInterIni=String.valueOf(1);
				LOGGER.debug(" diaInterIni>> "+ diaInterIni);
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	

		
		parameters.put("periodo"," Del " + diaInterIni + " al " + diaInterFin +" de "+mesInterFin+" "+anioInterFin );
		parameters.put("fecheCorte", aStatusHeader.getDiaHabil());
		//esta demas en cabecera
		parameters.put("nombreGrupo", aStatusHeader.getNombreGrupo());
		
		//Inicio Infromacion de credito
		parameters.put("icPlazoIni", aStatusInformation.getFechaInicio());
		parameters.put("icPlazoFin", aStatusInformation.getFechaFin());
		parameters.put("icLimCredito", aStatusInformation.getLimiteCredito());
		//falta-
		parameters.put("icLiDisponible", aStatusInformation.getLineaDisponible());
		
		parameters.put("icmCapital", aStatusInformation.getCapital());
		parameters.put("icmIntOrdinarios", aStatusInformation.getInteresParcial());
		parameters.put("icmIvaIntOrd", aStatusInformation.getIvaInteres());
		
		//falta-
		parameters.put("icComCobranza", aStatusInformation.getComisionGastosCobranza());
		//falta-
		parameters.put("icIvaComCobranza", aStatusInformation.getIvaGastosCobranza());
		
		parameters.put("icmTotal", aStatusInformation.getTotalParcial());
		parameters.put("icFrecPago", aStatusInformation.getFrecuenciaPago());
		parameters.put("icPlazoSemanas", aStatusInformation.getPlazo());
		parameters.put("icDiaPago", aStatusInformation.getDiaPago());
		parameters.put("icTasOrdAnual", aStatusInformation.getTasaOrdinaria());
		parameters.put("icTasOrdMensual", aStatusInformation.getTasaMensual());
		parameters.put("icBaseCalculoInt", aStatusInformation.getBaseCalculo());
		parameters.put("icInfoCat", aStatusInformation.getCat());
		parameters.put("icInfoComisiones", aStatusInformation.getComisiones());
		
		//los que estan demas en Informacion de Credito
		parameters.put("icSaldoIni", aStatusInformation.getSaldoInicial());
		parameters.put("icIntOrdinario", aStatusInformation.getInteresOrdinario());
		parameters.put("icTotalPagar", aStatusInformation.getTotalCredito());
		parameters.put("icSaldoFinalCap", aStatusInformation.getSaldoFinalCap());
		parameters.put("icEstCredito", aStatusInformation.getEstado());
		parameters.put("icDeposGar", aStatusInformation.getDepGarantias());
		parameters.put("icFechaDepositoGar", aStatusInformation.getFecDepGarantias());
        
		//Resumen totales	
		//PAgos
		parameters.put("rtTotalPagos", aStatusMovementTotalDTO.getPagos());
		parameters.put("rtCapital", aStatusMovementTotalDTO.getCapital());
		parameters.put("rtInteresOrdinarios", aStatusMovementTotalDTO.getInteres());
		parameters.put("rtIvaInteresOrd", aStatusMovementTotalDTO.getIva());
		//falta-
		parameters.put("rtGastosCobranza", aStatusMovementTotalDTO.getGastosCobranza());
		//falta-
		parameters.put("rtIvaGastosCobranza", aStatusMovementTotalDTO.getIvaGastosCobranza());
		//Dispociosiones
		
		//falta-
		parameters.put("rtNumDisposiciones", aStatusMovementTotalDTO.getNumeroDisposiciones());
		//falta-
		parameters.put("rtImporteDispociones", aStatusMovementTotalDTO.getImporteDisposiciones());
		
		//campo demas en pagos
		parameters.put("rtImportTotalComisioes", aStatusMovementTotalDTO.getImporteTotal());
		parameters.put("rtTipoComision", aStatusMovementTotalDTO.getTipoComision());
		parameters.put("rtFechaComision", aStatusMovementTotalDTO.getFechaComision());
		
		//Comision Gastos de Cobranza
		parameters.put("cgcImptotalComi", aStatusMovementTotalDTO.getImporteToComCobranza());
		parameters.put("cgcFechaUlCobro", aStatusMovementTotalDTO.getFechaUlCobroCobranza());
		parameters.put("cgcComision", aStatusMovementTotalDTO.getComisionCobranza());
		
		//Comision por Disposicion 
		parameters.put("cpdImpTotalComi", aStatusMovementTotalDTO.getImporteToComDisposicion());
		parameters.put("cpdFechaUlCobro", aStatusMovementTotalDTO.getFechaUlCobroDisposicion());
		parameters.put("cpdComision", aStatusMovementTotalDTO.getComisionDisposicion());
		
		//Cargos Objetados
		parameters.put("coFecha", "");
		parameters.put("coMovimiento", "");
		parameters.put("coImporte", "");
		parameters.put("coNumFolio", "");
		
		//Timbre
		parameters.put("folioFiscal", aStatusHeader.getFolioFiscal());
		parameters.put("certificado", aStatusHeader.getCertificado());
		parameters.put("selloDigital", aStatusHeader.getSelloDigital());
		parameters.put("selloSat", aStatusHeader.getSelloSAT());
		parameters.put("serieCertificadoSAT", aStatusHeader.getSerieCertificado());
		parameters.put("fechaHoraCertificacion", aStatusHeader.getFechaCertificacion());
		parameters.put("estadoOp", aStatusHeader.getEstadoOp());
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
		
		if(header.getCodigoGrupo()!=null){
			parameters.put("ID_GRUPO", header.getCodigoGrupo());
		}else{
			parameters.put("ID_GRUPO", 0);
		}
		LOGGER.debug("Correo cliente antes de setear: " + correo);
		if(header.getNombreCliente()!=null){
			parameters.put("NOMBRE_GRUPO", header.getNombreCliente());
		}else{
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
		Connection cn = null;
		CallableStatement executeSP = null;
		
		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.ZFIEC);
		CopyFileJob copyFileJobEnvio = new CopyFileJob(FileJob.Job.MPDFI);

		try {
			ConfigManager ds = ConfigManager.getInstance();
			//cn = ConnectionManager.openNewConnection();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			ResultSet result = executeNotification(cn, executeSP, "V", null, "X",null);

			LOGGER.debug("result: " + result);
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
					LOGGER.debug("primera llamada al sp sp_cons_estado_cuenta-A");
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
					executeSPXml.setString(1, "C2");
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
						accountHeader.setEstadoOp(resultCabecera.getString(25));
						LOGGER.debug("resultCabecera.getString(26)" + resultCabecera.getString(26));
						LOGGER.debug("resultCabecera.getString(27)" + resultCabecera.getString(27));
						LOGGER.debug("resultCabecera.getString(28)" + resultCabecera.getString(28));
						accountHeader.setCadOriComSAT(resultCabecera.getString(26));
						accountHeader.setRfcEmisor(resultCabecera.getString(27));
						accountHeader.setMontoFactura(resultCabecera.getString(28));
					}
					/* No es lista Informacion */
					LOGGER.debug("segunda llamada al sp sp_cons_estado_cuenta-I2");
					String queryXml2 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml2);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "I2"); // Informacion
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultInformacion = executeSPXml.executeQuery();
					LOGGER.debug("resultInformacion.." + resultInformacion);

					AccountStatusInformationDTO accountInformation = new AccountStatusInformationDTO();
					while (resultInformacion.next()) {
						accountInformation.setFechaInicio(resultInformacion.getString(1));
						accountInformation.setFechaFin(resultInformacion.getString(2));					
						accountInformation.setLimiteCredito(resultInformacion.getDouble(3));
						accountInformation.setLineaDisponible(resultInformacion.getDouble(4));
						accountInformation.setCapital(resultInformacion.getDouble(5));
						accountInformation.setInteresParcial(resultInformacion.getDouble(6));
						accountInformation.setIvaInteres(resultInformacion.getDouble(7));
						accountInformation.setComisionGastosCobranza(resultInformacion.getDouble(8));
						accountInformation.setIvaGastosCobranza(resultInformacion.getDouble(9));
						accountInformation.setTotalParcial(resultInformacion.getDouble(10));
						accountInformation.setFrecuenciaPago(resultInformacion.getString(11));
						accountInformation.setPlazo(resultInformacion.getInt(12));
						accountInformation.setDiaPago(resultInformacion.getString(13));
						accountInformation.setTasaOrdinaria(resultInformacion.getDouble(14));
						accountInformation.setTasaMensual(resultInformacion.getDouble(15));
						accountInformation.setBaseCalculo(resultInformacion.getDouble(16));
						accountInformation.setCat(resultInformacion.getDouble(17));
						accountInformation.setComisiones(resultInformacion.getDouble(18));
					}
					/* Lista de Movimientos */
					LOGGER.debug("tercera llamada al sp sp_cons_estado_cuenta-M3");
					String queryXml3 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml3);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "M3"); // Movimientos
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
						accountMovement.setDetalleMovimiento(resultMovement.getString(4));
						accountMovement.setCapital(resultMovement.getDouble(5));
						accountMovement.setInteresOrdinario(resultMovement.getDouble(6));
						accountMovement.setIvaInt(resultMovement.getDouble(7));
						accountMovement.setOtros(resultMovement.getDouble(8));
						accountMovement.setIvacomisionDisposicion(resultMovement.getDouble(9));
						accountMovement.setComisionGastoCobranza(resultMovement.getDouble(10));
						accountMovement.setIvacomisionGastoCobranza(resultMovement.getDouble(11));
						accountMovement.setTotal(resultMovement.getDouble(12));
						accountMovement.setSaldoInsoluto(resultMovement.getDouble(13));
						LOGGER.debug("resultMovement.getInt(1).." + resultMovement.getInt(1));
						LOGGER.debug("(resultMovement.getString(2).." + resultMovement.getString(2));
						LOGGER.debug("resultMovement.getString(3).." + resultMovement.getString(3));
						LOGGER.debug("(resultMovement.getInt(4).." + resultMovement.getString(4));
						movementList.add(accountMovement);
					}
					LOGGER.debug("(totallll..." + movementList.size());

					/* Lista de Tabla de Cargos Objetados */
					LOGGER.debug("cuarta llamada al sp sp_cons_estado_cuenta-N1");
					String queryXml4 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml4);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "N1"); // Tabla de Amortización
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultObjectedCharges = executeSPXml.executeQuery();
					LOGGER.debug("resultObjectCharges.." + resultObjectedCharges);

					List<AccountStatusObjectedChargesTableDTO> chargesList = new ArrayList<AccountStatusObjectedChargesTableDTO>();

					while (resultObjectedCharges.next()) {
						AccountStatusObjectedChargesTableDTO accountObjectedCharges = new AccountStatusObjectedChargesTableDTO();
						accountObjectedCharges.setFecha(resultObjectedCharges.getString(1));
						accountObjectedCharges.setDetalleMovimiento(resultObjectedCharges.getString(2));
						accountObjectedCharges.setImporte(resultObjectedCharges.getDouble(3));
						accountObjectedCharges.setFolio(resultObjectedCharges.getInt(4));
						LOGGER.debug("resultObjectedCharges.getInt(1).." + resultObjectedCharges.getString(1));
						LOGGER.debug("(resultObjectedCharges.getString(2).." + resultObjectedCharges.getString(2));
						LOGGER.debug("resultObjectedCharges.getString(3).." + resultObjectedCharges.getDouble(3));
						LOGGER.debug("(resultObjectedCharges.getInt(4).." + resultObjectedCharges.getInt(4));
						
						chargesList.add(accountObjectedCharges);
					}
                   
					LOGGER.debug("(total Cargos Objetados" + chargesList.size());
					/* No es lista TOTAL MOVIMIENTOS */
					LOGGER.debug("quinta llamada al sp sp_cons_estado_cuenta-R1");
					String queryXml5 = "{ call cob_conta_super..sp_cons_estado_cuenta(?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml5);
					executeSPXml.setEscapeProcessing(true);
					executeSPXml.setString(1, "R1");
					executeSPXml.setString(2, banco);
					executeSPXml.setString(3, fecha);
					executeSPXml.setInt(4, formato);
					executeSPXml.setInt(5, codigo);
					ResultSet resultMovementTotal = executeSPXml.executeQuery();

					LOGGER.debug("resultMovementTotal.." + resultMovementTotal);

					AccountStatusMovementTotalDTO accountMovementTotal = new AccountStatusMovementTotalDTO();
					while (resultMovementTotal.next()) {
						
						accountMovementTotal.setPagos(resultMovementTotal.getDouble(1));
						accountMovementTotal.setCapital(resultMovementTotal.getDouble(2));
                        accountMovementTotal.setInteres(resultMovementTotal.getDouble(3));
						accountMovementTotal.setIva(resultMovementTotal.getDouble(4));
						accountMovementTotal.setGastosCobranza(resultMovementTotal.getDouble(5));
						accountMovementTotal.setIvaGastosCobranza(resultMovementTotal.getDouble(6));
						accountMovementTotal.setNumeroDisposiciones(resultMovementTotal.getInt(7));
						accountMovementTotal.setImporteDisposiciones(resultMovementTotal.getDouble(8));
						accountMovementTotal.setImporteToComCobranza(resultMovementTotal.getDouble(9));
						accountMovementTotal.setFechaUlCobroCobranza(resultMovementTotal.getString(10));
						accountMovementTotal.setImporteToComDisposicion(resultMovementTotal.getDouble(11));
						accountMovementTotal.setFechaUlCobroDisposicion(resultMovementTotal.getString(12));

					}
					/* Se setea todo a la clase principal */
					accountStatus.setAccountStatusHeader(accountHeader);
					accountStatus.setAccountStatusInformation(accountInformation);
					accountStatus.setMovement(movementList);
					accountStatus.setObjectedChargesTable(chargesList);
					accountStatus.setAccountStatusMovementTotalDTO(accountMovementTotal);

					LOGGER.debug("Antes de Generar el reporte");
					LOGGER.debug("Parametro de ingreso para generar el reporte arg0.getJobDetail().getName() >> " + arg0.getJobDetail().getName());
					LOGGER.debug("EL buc del cliente es >> "+ buc_cliente);
					LOGGER.debug("La fecha es >> " +fecha);
					
					// se obtiene la fecha de generacion
					LOGGER.debug("Fecha para pdf >> "+ fechaCreacionCliente);
					
					fechaInterfactura = dateformat.parse(fechaCreacionCliente);
					calendarInterfactura.setTime(fechaInterfactura);		
					diaInter =String.valueOf(calendarInterfactura.get(Calendar.DAY_OF_MONTH));
					mesInter =String.valueOf(calendarInterfactura.get(Calendar.MONTH)+1);
					anioInter =String.valueOf(calendarInterfactura.get(Calendar.YEAR));					
					if(mesInter.length() == 1) {
						mesInter='0'+mesInter;
					}
					
					String fechadoc = anioInter+mesInter+diaInter;
					
					LOGGER.debug("Fecha dia >> "+ diaInter);
					LOGGER.debug("Fecha mes >> "+ mesInter);
					LOGGER.debug("Fecha anio >> "+ anioInter);
					
					LOGGER.debug("Fecha extencion para pdf >> "+ fechadoc);
					String namePdfRevolvente="";
					namePdfRevolvente=GenerateReportInterfactura.generateReportReturnName(arg0.getJobDetail().getName(), String.valueOf(buc_cliente) + "-" +banco+ "-" + fechadoc, null, accountStatus,buc_cliente,fechadoc);			
					File temp=new File(namePdfRevolvente);
					LOGGER.debug("namePdf"+namePdfRevolvente);
					LOGGER.debug("tempnamePdf"+temp.getName());
					FileZipPassword.createZip(copyFileJob, temp.getName(), buc_cliente, true);
					
					LOGGER.debug("Antes del executeNotification");
					/*Una vez generado el pdf cambio el estado a D para que no vuelva a tomar el mismo registro*/
					executeNotification(cn, executeSP, "U", codigo, "G",namePdfRevolvente);// Estado D para que pueda generar el pdf o correo
					LOGGER.debug("Despues del executeNotification");
					
				} catch (ParseException e) {
					LOGGER.error("ParseException:", e);
				}catch (Exception e) {
					LOGGER.error("Exception:", e);
					executeNotification(cn, executeSP, "U", codigo, "F",null);// Estado Fallido
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

	public ResultSet executeNotification(Connection cn, CallableStatement executeSP, String operation, Integer codigo, String status,String nombrePdf ) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification EstadoCuentaLCR");
		}
		String query = "{ call cob_conta_super..sp_qr_ns_estado_cuenta(?,?,?,?,?) }";
		LOGGER.debug("query -->" + query);
		
		try {
			LOGGER.debug("-->>**REVOLVENTE-->>Operacion: " + operation + "-->Codigo: " + codigo + "-->>status: " + status + "-->>nombrePdf: " + nombrePdf);
			
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
			executeSP.setString(5, "REVOLVENTE");
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotificationLCR -->", ex);
			throw ex;
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotificationLCR");
			}
		}

	}
	
	public void executeNotificacionCode(Connection cn, CallableStatement executeSP) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotificacionCode");
		}
		String query = "{ call cob_conta_super..sp_notif_interfactura_clave(?) }";

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "X");
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

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
             if(executeDateECTLCR())
             {
			executeByTransaction(arg0);
             }
             else
             {
            	 LOGGER.debug("executeDateECTLCR fuera del rango de fechas"); 
             }
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
	
	public boolean executeDateECTLCR()
	{
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeDateECTLCR");
		}
		boolean ejecutar=false;
		String fechaIni = "";
		String fechaPro = "";
		String fechaFin = "";
		String ejecutar_sp = "";
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			String query = "{ call cob_conta_super..sp_eje_lcr_etc(?) }";
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "Q");
			executeSP.execute();
			ResultSet result=executeSP.getResultSet();
			while (result.next()) {
			 fechaIni = result.getString(1);
			 fechaPro = result.getString(2);
			 fechaFin = result.getString(3);
			 ejecutar_sp = result.getString(4);
			 
			 LOGGER.debug("fechaIni.."    + result.getString(1));
			 LOGGER.debug("fechaPro.."    + result.getString(2));
			 LOGGER.debug("fechaFin.."    + result.getString(3));
			 LOGGER.debug("ejecutar_sp.." + result.getString(4)); 
			
			}
			
			if(ejecutar_sp.equals("S"))
			{
				ejecutar=true;
			}
			else
			{
				ejecutar=false;
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			LOGGER.error("ERROR executeByCode General -->", e);
		}finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByCode General");
			}
		}
		
		 LOGGER.debug("ejecutar.." + ejecutar); 
		return ejecutar;
	}
	

}