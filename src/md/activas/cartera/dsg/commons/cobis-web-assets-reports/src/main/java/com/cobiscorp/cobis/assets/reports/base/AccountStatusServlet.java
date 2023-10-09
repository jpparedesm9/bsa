package com.cobiscorp.cobis.assets.reports.base;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.assets.cloud.dto.AccountStatusRequest;
import cobiscorp.ecobis.assets.cloud.dto.HeaderStateAccountResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanInformationResponse;
import cobiscorp.ecobis.assets.cloud.dto.TotalMovementsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.dto.AccountStateAtribute;
import com.cobiscorp.cobis.assets.reports.dto.AccountStatusAmortizationTableDTO;
import com.cobiscorp.cobis.assets.reports.dto.AccountStatusDTO;
import com.cobiscorp.cobis.assets.reports.dto.AccountStatusMovementDTO;
import com.cobiscorp.cobis.assets.reports.service.AccountStatusService;
import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;

/* 			ESTA CLASE QUEDA INACTIVA DEBIDO A QUE YA NO EXISTE LA PANTALLA
 *          DE LLAMADO LOS FUENTES DEL JASPER FUERON MOVIDOS AL NOTIFICADOR 
 *          QUE ES DONDE SE ESTAN USANDO ACTUALMENTE */

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "AccountStatus") })
public class AccountStatusServlet implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(AccountStatusServlet.class);

	@Reference(bind = "setCacheManager", unbind = "unsetCacheManager", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICacheManager cacheManager;

	public void setCacheManager(ICacheManager aCacheManager) {
		this.cacheManager = aCacheManager;
		logger.logDebug("--->Ingresa a setCacheManager:" + this.cacheManager);
	}

	public ICacheManager getCacheManager() {
		logger.logDebug("--->Ingresa a getCacheManager" + this.cacheManager);
		return this.cacheManager;
	}

	public void unsetCacheManager(ICacheManager aCacheManager) {
		this.cacheManager = null;
	}

	private String mnsOperation = "NO EXISTE OPERACION";
	// private Integer sequentialI = 0;
	ICache datos;

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> parameters) {
		Util util = new Util();
		try {
			String numBank = (String) parameters.get(ConstantValue.PARAM_BANK_NUMBER);
			String dateFrom = (String) parameters.get(ConstantValue.PARAM_DATE);
			// @i_operacion = 'C1' ->Cabecera
			// @i_operacion = 'I1' -> Informacion Credito
			// @i_operacion = 'M1' --Movimientos
			// @i_operacion = 'M2' --Movimientos Totales
			// @i_operacion = 'T1' --Tabla Amortizacion
			// @i_operacion = 'A' --LLenado de tablas para luego obtener la info

			AccountStatusService accountStatusService = new AccountStatusService();
			DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
			AccountStatusRequest accountStatusRequest = new AccountStatusRequest();

			logger.logDebug("START AccountStatusServlet getParamsReport");
			logger.logDebug("----->> AccountStatusServlet getParamsReport - dateFrom1:" + dateFrom);
			logger.logDebug("----->> AccountStatusServlet getParamsReport - numBank1:" + numBank);
			Calendar actual = Calendar.getInstance();

			initParam(parameters);
			parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO2);
			parameters.put("urlPathCodigo", ConstantValue.URL_IMAGEN_COD);
			parameters.put("REPORT_LOCALE", new Locale("en", "US"));// aparece
																	// como
																	// 122,345.56
			// parametros.put("REPORT_LOCALE", new Locale("es", "ES"));--
			// aparece como 122.345,56

			accountStatusRequest.setBanco(numBank);

			Calendar fechaCalendar = Calendar.getInstance();
			Date fechaDate = formatoFecha.parse(dateFrom);

			fechaCalendar.setTime(fechaDate);
			logger.logDebug("----->> AccountStatusServlet getParamsReport - fechaDate:" + fechaDate);
			logger.logDebug("----->> AccountStatusServlet getParamsReport - fecha_calendar:" + fechaCalendar);

			accountStatusRequest.setFecha(fechaCalendar);
			accountStatusRequest.setFormatofecha(ConstantValue.DATE_FORMAT);

			// CachÃ©wCache.get(bank)
			logger.logDebug("----->> AccountStatusServlet getParamsReport - Secuencial :" + getSequetial(numBank) + "-NumeroBanco:" + numBank);

			if (getSequetial(numBank) > 0) {
				accountStatusRequest.setSequential(getSequetial(numBank));
				accountStatusRequest.setOperacion("C1");
				HeaderStateAccountResponse headerStateAccountResponse = accountStatusService.searchStateSccountHeadboard(accountStatusRequest, serviceIntegration);
				// CABECERA
				util.setParams(parameters);
				if (headerStateAccountResponse != null) {
					util.mapValuesToParams("sucursal", headerStateAccountResponse.getDescSucursal(), "");
					util.mapValuesToParams("nombreCliente", headerStateAccountResponse.getNombreCliente(), "");
					util.mapValuesToParams("rfc", headerStateAccountResponse.getRfc(), "");
					util.mapValuesToParams("domicilio", headerStateAccountResponse.getCalle() + " " + headerStateAccountResponse.getNumero() + " " + headerStateAccountResponse.getParroquia() + " "
							+ headerStateAccountResponse.getDelegacion() + " " + headerStateAccountResponse.getCodigoPostal() + " " + headerStateAccountResponse.getEstado(), "");
					util.mapValuesToParams("producto", headerStateAccountResponse.getTipoOperacion(), "");
					util.mapValuesToParams("nombreGrupo", headerStateAccountResponse.getNombreGrupo(), "");
					util.mapValuesToParams("numCredito", headerStateAccountResponse.getOperacion(), mnsOperation);
					util.mapValuesToParams("periodo", headerStateAccountResponse.getFechaInicio() + " - " + headerStateAccountResponse.getFechaReporte(), "");
					util.mapValuesToParams("fecheCorte", headerStateAccountResponse.getDiaHabil(), "");
					//
					util.mapValuesToParams("folioFiscal", headerStateAccountResponse.getFolioFiscal(), "");
					util.mapValuesToParams("certificado", headerStateAccountResponse.getCertificado(), "");

					util.mapValuesToParams("selloDigital", headerStateAccountResponse.getSelloDigital(), "");
					util.mapValuesToParams("selloSat", headerStateAccountResponse.getSelloSAT(), "");
					util.mapValuesToParams("serieCertificadoSAT", headerStateAccountResponse.getSerieCertificado(), "");
					util.mapValuesToParams("fechaHoraCertificacion", headerStateAccountResponse.getFechaCertificacion(), "");

					util.mapValuesToParams("eDiaEmitido", util.numberCero(actual.get(Calendar.DAY_OF_MONTH)), "");
					util.mapValuesToParams("eMesEmitido", util.monthDescription(actual), "");
					util.mapValuesToParams("eAnioEmitido", String.valueOf(actual.get(Calendar.YEAR)), "");
					util.mapValuesToParams("eHoraEmitido", String.valueOf(actual.get(Calendar.HOUR_OF_DAY)) + ":" + String.valueOf(actual.get(Calendar.MINUTE)), "");
					util.mapValuesToParams("fechaImpresion",
							util.numberCero(actual.get(Calendar.DAY_OF_MONTH)) + "/" + util.numberCero(actual.get(Calendar.MONTH) + 1) + "/" + String.valueOf(actual.get(Calendar.YEAR)), "");
					util.mapValuesToParams("importes", headerStateAccountResponse.getImportes(), "");
				}

				// String opStrLoanInformation = "I";INFORMACIÃ“N DEL
				// CRÃ‰DITO
				accountStatusRequest.setOperacion("I1");
				LoanInformationResponse loanInformationResponse = accountStatusService.searchLoanInformation(accountStatusRequest, serviceIntegration);
				if (loanInformationResponse != null) {
					logger.logDebug("START 4 loanInformationResponse.getLimiteCredito:" + loanInformationResponse.getLimiteCredito());

					if (loanInformationResponse.getLimiteCredito() != null)
						util.mapValuesToParams("icLimCredito", loanInformationResponse.getLimiteCredito().doubleValue(), 0.0);

					if (loanInformationResponse.getSaldoInicial() != null)
						util.mapValuesToParams("icSaldoIni", loanInformationResponse.getSaldoInicial().doubleValue(), 0.0);

					if (loanInformationResponse.getInteresOrdinario() != null)
						util.mapValuesToParams("icIntOrdinario", loanInformationResponse.getInteresOrdinario().doubleValue(), 0.0);

					if (loanInformationResponse.getTotalCredito() != null)
						util.mapValuesToParams("icTotalPagar", loanInformationResponse.getTotalCredito().doubleValue(), 0.0);

					if (loanInformationResponse.getCapital() != null)
						util.mapValuesToParams("icmCapital", loanInformationResponse.getCapital().doubleValue(), 0.0);

					if (loanInformationResponse.getInteresParcial() != null)
						util.mapValuesToParams("icmIntOrdinarios", loanInformationResponse.getInteresParcial().doubleValue(), 0.0);

					if (loanInformationResponse.getIvaInteres() != null)
						util.mapValuesToParams("icmIvaIntOrd", loanInformationResponse.getIvaInteres().doubleValue(), 0.0);

					if (loanInformationResponse.getTotalParcial() != null)
						util.mapValuesToParams("icmTotal", loanInformationResponse.getTotalParcial().doubleValue(), 0.0);

					if (loanInformationResponse.getBaseCalculo() != null)
						util.mapValuesToParams("icBaseCalculoInt", loanInformationResponse.getBaseCalculo().doubleValue(), 0.0);

					if (loanInformationResponse.getSaldoFinalCap() != null)
						util.mapValuesToParams("icSaldoFinalCap", loanInformationResponse.getSaldoFinalCap().doubleValue(), 0.0);

					if (loanInformationResponse.getEstado() != null)
						util.mapValuesToParams("icEstCredito", loanInformationResponse.getEstado(), "");

					if (loanInformationResponse.getFechaInicio() != null)
						util.mapValuesToParams("icPlazoIni", loanInformationResponse.getFechaInicio(), "");

					if (loanInformationResponse.getFechaFin() != null)
						util.mapValuesToParams("icPlazoFin", loanInformationResponse.getFechaFin(), "");

					if (loanInformationResponse.getFrecuenciaPago() != null)
						util.mapValuesToParams("icFrecPago", loanInformationResponse.getFrecuenciaPago(), "");

					if (loanInformationResponse.getPlazo() != null)
						util.mapValuesToParams("icPlazoSemanas", loanInformationResponse.getPlazo(), 0);

					if (loanInformationResponse.getDiaPago() != null)
						util.mapValuesToParams("icDiaPago", loanInformationResponse.getDiaPago(), "");

					if (loanInformationResponse.getTasaOrdinaria() != null)
						util.mapValuesToParams("icTasOrdAnual", loanInformationResponse.getTasaOrdinaria(), 0.0);

					util.mapValuesToParams("icTasOrdMensual", loanInformationResponse.getTasaMensual(), 0.0);

					if (loanInformationResponse.getDepGarantias() != null)
						util.mapValuesToParams("icDeposGar", loanInformationResponse.getDepGarantias().doubleValue(), 0.0);

					if (loanInformationResponse.getFecDepGarantias() != null)
						util.mapValuesToParams("icFechaDepositoGar", loanInformationResponse.getFecDepGarantias(), "");

					if (loanInformationResponse.getCat() != null)
						util.mapValuesToParams("icInfoCat", loanInformationResponse.getCat(), 0.0);

					if (loanInformationResponse.getComisiones() != null)
						util.mapValuesToParams("icInfoComisiones", loanInformationResponse.getComisiones().doubleValue(), 0.0);
				}
				// RESUMEN (TOTALES)
				accountStatusRequest.setOperacion("M2");

				TotalMovementsResponse totalMovementsRespons = accountStatusService.searchTotalMovements(accountStatusRequest, serviceIntegration);

				if (totalMovementsRespons != null) {
					Double total = 0.0;
					if (totalMovementsRespons.getCapital() != null)
						total = totalMovementsRespons.getCapital().doubleValue();

					if (totalMovementsRespons.getInteres() != null)
						total = total + totalMovementsRespons.getInteres().doubleValue();

					if (totalMovementsRespons.getIva() != null)
						total = total + totalMovementsRespons.getIva().doubleValue();

					util.mapValuesToParams("rtTotalPagos", total, 0.0);
					if (totalMovementsRespons.getCapital() != null)
						util.mapValuesToParams("rtCapital", totalMovementsRespons.getCapital().doubleValue(), 0.0);

					if (totalMovementsRespons.getInteres() != null)
						util.mapValuesToParams("rtInteresOrdinarios", totalMovementsRespons.getInteres().doubleValue(), 0.0);

					if (totalMovementsRespons.getIva() != null)
						util.mapValuesToParams("rtIvaInteresOrd", totalMovementsRespons.getIva().doubleValue(), 0.0);

					if (totalMovementsRespons.getImporteTotal() != null)
						util.mapValuesToParams("rtImportTotalComisioes", totalMovementsRespons.getImporteTotal().doubleValue(), 0.0);

					util.mapValuesToParams("rtTipoComision", "Gastos de cobranza", "");
					// No esta en el documento
					util.mapValuesToParams("rtFechaComision", totalMovementsRespons.getFechaComision(), "");
				}

				// util.mapValuesToParams("coFecha", "", ""); //Documento
				// indica
				// que: Por el momento no se llenaran
				// util.mapValuesToParams("coMovimiento", "",
				// "");//Documento
				// indica
				// que: Por el momento no se llenaran
				// util.mapValuesToParams("coImporte", "", "");//Documento
				// indica
				// que: Por el momento no se llenaran
				util.mapValuesToParams("coNumFolio", "", "");
			} else {
				// parameters.put("numCredito", mnsOperation);
				logger.logError("----->> AccountStatusServlet getParamsReport -  Secuencial 0 - numero banco:" + numBank);
				throw new RuntimeException("----->> AccountStatusServlet getParamsReport -  Secuencial 0 - numero banco:" + numBank);
			}

		} catch (BusinessException e) {
			logger.logError("ERROR AccountStatusServlet getParamsReport", e);
			throw new RuntimeException("ERROR AccountStatusServlet getParamsReport", e);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return util.getParams();
	}

	private void initParam(Map<String, Object> parameters) {
		// Primera parte
		parameters.put("icLimCredito", 0.0);
		parameters.put("icSaldoIni", 0.0);
		parameters.put("icIntOrdinario", 0.0);
		parameters.put("icTotalPagar", 0.0);
		parameters.put("icmCapital", 0.0);
		parameters.put("icmIntOrdinarios", 0.0);
		parameters.put("icmIvaIntOrd", 0.0);
		parameters.put("icmTotal", 0.0);
		parameters.put("icBaseCalculoInt", 0.0);
		parameters.put("icSaldoFinalCap", 0.0);
		parameters.put("icEstCredito", "");
		parameters.put("icPlazoIni", "");
		parameters.put("icPlazoFin", "");
		parameters.put("icFrecPago", "");
		parameters.put("icPlazoSemanas", 0);
		parameters.put("icDiaPago", "");
		parameters.put("icTasOrdAnual", 0.0);
		parameters.put("icTasOrdMensual", 0.0);
		parameters.put("icDeposGar", 0.0);
		parameters.put("icFechaDepositoGar", "");
		parameters.put("icInfoCat", 0.0);
		parameters.put("icInfoComisiones", 0.0);
		//
		parameters.put("sucursal", "");
		parameters.put("nombreCliente", "");
		parameters.put("rfc", "");
		parameters.put("domicilio", "");
		parameters.put("producto", "");
		parameters.put("nombreGrupo", "");
		parameters.put("numCredito", mnsOperation);
		parameters.put("periodo", "");
		parameters.put("fecheCorte", "");
		//
		parameters.put("rtTotalPagos", 0.0);
		parameters.put("rtCapital", 0.0);
		parameters.put("rtInteresOrdinarios", 0.0);
		parameters.put("rtIvaInteresOrd", 0.0);
		parameters.put("rtImportTotalComisioes", 0.0);
		parameters.put("rtTipoComision", "");
		parameters.put("rtFechaCobroUltima", "");
		parameters.put("rtFechaComision", "");

		parameters.put("coFecha", "");// Documento indica que: Por el momento no
										// se llenaran
		parameters.put("coMovimiento", "");// Documento indica que: Por el
											// momento no se llenaran
		parameters.put("coImporte", "");// Documento indica que: Por el momento
										// no se llenaran
		parameters.put("coNumFolio", "");
		parameters.put("folioFiscal", "");
		parameters.put("certificado", "");
		parameters.put("selloDigital", "");
		parameters.put("selloSat", "");
		parameters.put("serieCertificadoSAT", "");
		parameters.put("fechaHoraCertificacion", "");
		parameters.put("eDiaEmitido", "");
		parameters.put("eMesEmitido", "");
		parameters.put("eAnioEmitido", "");
		parameters.put("eHoraEmitido", "");
		parameters.put("fechaImpresion", "");
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> parameters) {
		Collection<AccountStatusDTO> collection = new ArrayList<AccountStatusDTO>();
		try {
			AccountStatusService accountStatusService = new AccountStatusService();
			DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
			AccountStatusRequest accountStatusRequest = new AccountStatusRequest();
			AccountStateAtribute accountStateAtribute = new AccountStateAtribute();
			logger.logDebug("----->> START AccountStatusServlet getDatasourceReport 22a");

			String numBank = (String) parameters.get(ConstantValue.PARAM_BANK_NUMBER);
			String dateFrom = (String) parameters.get(ConstantValue.PARAM_DATE);
			String sequentialCTSString = (String) parameters.get(ConstantValue.PARAM_SEQUENTIAL);
			Integer sequentialI = Integer.parseInt(sequentialCTSString);

			List<AccountStatusAmortizationTableDTO> amoritizationTable = new ArrayList<AccountStatusAmortizationTableDTO>();
			List<AccountStatusMovementDTO> movement = new ArrayList<AccountStatusMovementDTO>();

			logger.logDebug("----->> AccountStatusServlet getDatasourceReport - dateFrom2:" + dateFrom);
			logger.logDebug("----->> AccountStatusServlet getDatasourceReport - numBank2:" + numBank);

			Calendar fechaCalendar = Calendar.getInstance();
			Date fechaDate = formatoFecha.parse(dateFrom);
			fechaCalendar.setTime(fechaDate);
			logger.logDebug("----->> AccountStatusServlet getDatasourceReport - fechaDate:" + fechaDate);
			logger.logDebug("----->> AccountStatusServlet getDatasourceReport - fechaCalendar:" + fechaCalendar);

			// CachÃ©
			// Llenado de tablas
			accountStateAtribute.setNumBankm(numBank);
			accountStateAtribute.setFechaDatem(fechaCalendar);

			// Envio de datos comunes
			accountStatusRequest.setFormatofecha(ConstantValue.DATE_FORMAT);
			accountStatusRequest.setBanco(accountStateAtribute.getNumBankm());
			accountStatusRequest.setFecha(accountStateAtribute.getFechaDatem());

			//accountStatusRequest.setOperacion("A");
			//accountStateAtribute.setSequentialIm(sequentialCTS);
			//Integer sequentialI = 0;
			//sequentialI = accountStatusService.executionOptions(accountStatusRequest, serviceIntegration);
			accountStateAtribute.setSequentialIm(sequentialI);
			setAccountStateReport(numBank, sequentialI);
			datos = getAccountStateReport();
			logger.logDebug("----->> AccountStatusServlet getDatasourceReport - Secuencial :" + getSequetial(numBank) + "-NumeroBanco:" + numBank);

			if (getSequetial(numBank) > 0) {
				// accountStatusRequest.setBanco(datos.get("account").getNumBankm());
				accountStatusRequest.setSequential(getSequetial(numBank));

				// accountStatusRequest.setFecha(datos.get("account").getFechaDatem());
				// Movi
				accountStatusRequest.setOperacion("M1");
				movement = accountStatusService.getListMovement(accountStatusRequest, serviceIntegration);

				// Tabla Amortizacion
				accountStatusRequest.setOperacion("T1");
				amoritizationTable = accountStatusService.getListAmortizationTable(accountStatusRequest, serviceIntegration);
			} else {
				// parameters.put("numCredito", mnsOperation);
				logger.logError("----->> AccountStatusServlet getDatasourceReport -  Secuencial 0 - numero banco:" + numBank);
				throw new RuntimeException("----->> AccountStatusServlet getDatasourceReport -  Secuencial 0 - numero banco:" + numBank);
			}

			AccountStatusDTO accountStatusDTO = new AccountStatusDTO();
			accountStatusDTO.setMovement(movement);
			accountStatusDTO.setAmortizationTable(amoritizationTable);

			collection.add(accountStatusDTO);

		} catch (BusinessException e) {
			logger.logError("ERROR AccountStatusServlet getDatasourceReport", e);
			throw new RuntimeException("ERROR AccountStatusServlet getDatasourceReport", e);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> parameters) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.PATH_ACCOUNT_STATUS);

	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.PATH_ACCOUNT_STATUS;
	}

	// Seguridad para presentar el reporte
	@Override
	public Boolean controlReportGeneration(Map<String, Object> parameters) {
		return true;
	}

	private Integer getSequetial(String bank) {
		ICache myCache = getAccountStateReport();
		List<Serializable> keys = myCache.getKeys();
		Integer sequential = 0;
		for (Serializable key : keys) {
			logger.logDebug("getSequetial->>Key:" + key + "-bank:" + bank + "-Secuencial:" + (Integer) myCache.get(key));
			if (bank.equals(key)) {
				sequential = (Integer) myCache.get(key);
				break;
			}
		}
		return sequential;
	}

	private ICache getAccountStateReport() {
		ICache wCache = cacheManager.getCache("AccountStateReport");
		if (wCache == null) {
			throw new IllegalStateException("Cache with AccountStateReport should be configured in $COBIS_HOME/CTS_MF/services-as/cache/cts-cache.xml");
		}
		return wCache;
	}

	private void setAccountStateReport(String bank, Integer sequential) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start getAccountStateReport");
		}
		ICache wCache = cacheManager.getCache("AccountStateReport");
		if (wCache == null) {
			throw new IllegalStateException("Cache with AccountStateReport should be configured in $COBIS_HOME/CTS_MF/services-as/cache/cts-cache.xml");
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("accountStateAtribute:-sequential:" + sequential + "-bank:" + bank);
		}
		wCache.put(bank, sequential);

	}
}
