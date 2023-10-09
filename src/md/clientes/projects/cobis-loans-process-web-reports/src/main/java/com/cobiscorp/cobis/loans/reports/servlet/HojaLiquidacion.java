package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.HojaLiquidacionDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.FormatDateExpression;
import com.cobiscorp.cobis.loans.reports.dto.HojaLiquidacionDTO;
import com.cobiscorp.cobis.loans.reports.impl.HojaLiquidacionListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "hojaLiquidacion") })
public class HojaLiquidacion implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(HojaLiquidacion.class);
	
	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia Lista - Reporte HojaLiquidacion");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);

		@SuppressWarnings("rawtypes")
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		Collection<HojaLiquidacionDATABEAN> collection = new ArrayList<HojaLiquidacionDATABEAN>();
		Services services = new Services();
		Method method = new Method();
		
		try {
			HojaLiquidacionListIMPL hojaLiquidacionListIMPL = new HojaLiquidacionListIMPL();
			HojaLiquidacionDATABEAN hojaLiquidacionDATABEAN = new HojaLiquidacionDATABEAN();

			// Servicio
			ReportResponse[] reportResponse = services.getClearanceSheetDetail(sessionId, bankCTS, serviceIntegration);

			// Suma de valores
			method.setPrmMain(params);// Envia los parametros del metodo method.mapValuesToParams..
			sumValues(reportResponse);

			// Listas
			List<HojaLiquidacionDTO> hojaLiquidacionDetalle = hojaLiquidacionListIMPL.getClearanceSheetDetail(reportResponse, sessionId, serviceIntegration);

			// Mapeo
			hojaLiquidacionDATABEAN.setDetalleLiquidacion(hojaLiquidacionDetalle);

			// Envio a Collection
		
			collection.add(hojaLiquidacionDATABEAN);
			

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - Reporte HojaLiquidacion", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia  - Reporte HojaLiquidacion");
		// Datos Iniciales
		FormatDateExpression formatDateExpression = new FormatDateExpression();
		Services services = new Services();
		Method method = new Method();
		
		initParamHeader(params);
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);

			@SuppressWarnings("rawtypes")
			String bank = (String) params.get(ConstantValue.Params.BANK);
			Date dateHeader = new Date();
			method.setPrmMain(params);// Envia los parametros del metodo method.mapValuesToParams..

			// Informacion del grupo
			ReportResponse reportResponse = services.getClearanceSheetHeader(sessionId, bank, serviceIntegration);
			if (reportResponse != null) {
				logger.logDebug("*****>>Reporte HojaLiquidacion-getPeriodicity:" + reportResponse.getPeriodicity());
				method.mapValuesToParams("fechaCabecera", formatDateExpression.formatDMY(dateHeader), "");
				method.mapValuesToParams("fechaPago", reportResponse.getDatePayment(), "");
				method.mapValuesToParams("monto", reportResponse.getAmountBorrowed(), 0.0);
				method.mapValuesToParams("grupo", reportResponse.getGroup(), "");
				method.mapValuesToParams("ciclo", reportResponse.getCycle(), 0);
				method.mapValuesToParams("codigo", String.valueOf(reportResponse.getGroupId()), "");
				logger.logDebug(" codigo >>>  " +reportResponse.getGroupId());
				method.mapValuesToParams("sucursal", reportResponse.getBranchOffice(), "");
				// Aumentar
				// method.mapValuesToParams("montoLiquidoRecibir", reportResponse.getDeliverDate(), "");
				// method.mapValuesToParams("montoEntregado", reportResponse.getDeliverDate(), "");
				// method.mapValuesToParams("montoDevuelto", reportResponse.getDeliverDate(), "");
				// method.mapValuesToParams("fecha", reportResponse.getDeliverDate(), "");

				method.mapValuesToParams("fechaInicio", reportResponse.getDatePayment(), "");
				method.mapValuesToParams("fechaVencimiento", reportResponse.getEndDate(), "");
				method.mapValuesToParams("plazo", reportResponse.getTerm(), "");
				method.mapValuesToParams("periocidad", reportResponse.getPeriodicity(), "");
				// method.mapValuesToParams("montoFinanciado", reportResponse.getDeliverDate(), "");
				// method.mapValuesToParams("montoLiquidoARecibir", reportResponse.getDeliverDate(), "");
				method.mapValuesToParams("tasaInteresFijAnual", reportResponse.getRate(), 0.0);
				// method.mapValuesToParams("valorDescontar", reportResponse.getDeliverDate(), "");				
				//method.mapValuesToParams("simboloMoneda", "MXN", "");

			}

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte HojaLiquidacion: ", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("fechaCabecera", "");
		params.put("fechaPago", "");
		params.put("monto", 0.0);
		params.put("grupo", "");
		params.put("ciclo", 0);
		params.put("codigo", "");
		params.put("sucursal", "");
		// params.put("montoLiquidoRecibir", "");
		// params.put("montoEntregado", "");
		// params.put("montoDevuelto", "");
		// params.put("fecha", "");
		params.put("fechaInicio", "");
		params.put("fechaVencimiento", "");
		params.put("plazo", "");
		params.put("periocidad", "");
		// params.put("montoFinanciado", "");
		// params.put("montoLiquidoARecibir", "");
		params.put("tasaInteresFijAnual", 0.0);
		//params.put("simboloMoneda", "");
		// params.put("valorDescontar", "");
	}

	private void sumValues(ReportResponse[] reportResponse) {
		Method method = new Method();
		logger.logDebug("*****>> - Reporte HojaLiquidacion - sumValues");
		Double amountFin = 0.0;// monto Financiado
		Double amountLiq = 0.0;// monnto liquido a recibir
		Double amountDes = 0.0;// valores a descontar
		if (reportResponse != null) {
			if (reportResponse.length > 0) {
				for (int i = 0; i < reportResponse.length; i++) {

					amountFin = amountFin + reportResponse[i].getAmountApproved();
					amountLiq = amountLiq + reportResponse[i].getNetToDeliver();
					amountDes = amountDes + reportResponse[i].getValuesDiscounting();
				}
			}
		}
		method.mapValuesToParams("montoFinanciado", amountFin, 0.0);
		method.mapValuesToParams("montoLiquidoARecibir", amountLiq, 0.0);
		method.mapValuesToParams("valorDescontar", amountDes, 0.0);
		logger.logDebug("*****>> - Reporte HojaLiquidacion - amountFin:" + amountFin);
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.HOJA_LIQUIDACION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.HOJA_LIQUIDACION;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	// Seguridad para presentar el reporte
	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}
}
