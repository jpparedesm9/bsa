package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import cobiscorp.ecobis.assets.cloud.dto.ReportLiquidationRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReportOperation;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.service.LiquidationService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class LiquidationServlet extends BaseReportServlet {
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(LiquidationServlet.class);

	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static LiquidationService service = new LiquidationService();
	private static ICTSServiceIntegration serviceIntegration;

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegrationset) {
		serviceIntegration = serviceIntegrationset;
	}

	public static void unsetServiceIntegration() {
		serviceIntegration = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		execute(request, response);
	}

	private void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Setea el path donde se encuentra el reporte
			super.setReportJasperPath(ConstantValue.PATH_LIQUIDATION);
			// Recupera parametros enviados por la url y se agregan en el mapa
			// local
			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);
			
			Integer secLiquidation = 1;
			Integer currencyLiquidation = request.getParameter(ConstantValue.LIQUIDATION_CURRENCY) != null ? Integer.parseInt((String) request
					.getParameter(ConstantValue.LIQUIDATION_CURRENCY)) : null;

			if (numOperation != null && secLiquidation != null && currencyLiquidation != null) {
				paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);
				paramsUrl.put(ConstantValue.LIQUIDATION_SEQUENTIAL, secLiquidation);
				paramsUrl.put(ConstantValue.LIQUIDATION_CURRENCY, currencyLiquidation);

				// genera reporte
				response.setContentType("application/pdf");
				super.generate(request, response);
			} else {
				response.getWriter().write("Lo sentimos, falta información para crear reporte");
				response.getWriter().flush();
				response.getWriter().close();
			}

		} catch (Exception e) {
			logger.logError("ERROR REPORT LIQUIDATION", e);
			try {
				response.getWriter().write("Lo sentimos ocurrió un error al crear el documento");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (Exception ie) {
				logger.logError("ERROR WRITE", ie);
			}
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("END REPORT LIQUIDATION");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getParameters REPORT LIQUIDATION");
		// Setea el mapa de parametros
		Util util = new Util();
		util.setParams(new HashMap<String, Object>());

		try {
			// logo de banco
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN, ConstantValue.UNDEFINED_VALUE);
			// titulo reporte
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_TITLE, ConstantValue.TITLE_LIQUIDATION, ConstantValue.UNDEFINED_VALUE);

		} catch (Exception e) {
			logger.logError("Exception REPORT LIQUIDATION", e);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("END getParameters REPORT LIQUIDATION");
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getDatasourceReport PartialDisbursement");

		// Obtiene los parametros de la peticion HTTPServleRequest
		String numOperation = (String) paramsUrl.get(ConstantValue.NUM_OPERATION);
		Integer secLiquidation = (Integer) paramsUrl.get(ConstantValue.LIQUIDATION_SEQUENTIAL);
		Integer currencyLiquidation = (Integer) paramsUrl.get(ConstantValue.LIQUIDATION_CURRENCY);

		ReportLiquidationRequest reportLiquidationRequest = new ReportLiquidationRequest();
		reportLiquidationRequest.setBank(numOperation);
		reportLiquidationRequest.setSecuential(secLiquidation);
		reportLiquidationRequest.setCurrency(currencyLiquidation);

		ReportOperation reportOperationResponse = service.queryLiquidationInfo(reportLiquidationRequest, serviceIntegration);

		List<ReportOperation> reportOperationResponses = new ArrayList<ReportOperation>();
		reportOperationResponses.add(reportOperationResponse);

		if (logger.isDebugEnabled())
			logger.logDebug("END getDatasourceReport PartialDisbursement");

		return new JRBeanCollectionDataSource(reportOperationResponses, true);
	}

}
