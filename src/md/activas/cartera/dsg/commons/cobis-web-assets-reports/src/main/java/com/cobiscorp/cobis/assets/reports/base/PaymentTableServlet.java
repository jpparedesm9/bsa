package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.service.PaymentTableService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableHead;
import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class PaymentTableServlet extends BaseReportServlet {
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(PaymentTableServlet.class);

	private ICTSServiceIntegration serviceIntegration;
	private Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private PaymentTableService service = new PaymentTableService();

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration() {
		this.serviceIntegration = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		execute(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Setea el path donde se encuentra el reporte
			super.setReportJasperPath(ConstantValue.PATH_PAYMENT_TABLE);
			// Recupera parametros enviados por la url y se agregan en el mapa
			// local
			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);
			String paymentTableHis = request.getParameter(ConstantValue.PAYMENT_TABLE_HIST);

			if (numOperation != null && paymentTableHis != null) {
				paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);
				paramsUrl.put(ConstantValue.PAYMENT_TABLE_HIST, paymentTableHis);

				// genera reporte
				response.setContentType("application/pdf");
				super.generate(request, response);
			} else {
				response.getWriter().write("Lo sentimos, falta información para crear reporte");
				response.getWriter().flush();
				response.getWriter().close();
			}

		} catch (Exception e) {
			logger.logError("ERROR REPORT PAYMENT TABLE", e);
			try {
				response.getWriter().write("Lo sentimos ocurrió un error al crear el documento");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (Exception ie) {
				logger.logError("ERROR WRITE", ie);
			}
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("END REPORT PAYMENT TABLE");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getParameters REPORT PAYMENT TABLE");
		// Setea el mapa de parametros
		Util util = new Util();
		util.setParams(new HashMap<String, Object>());

		try {
			// logo de banco
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN, ConstantValue.UNDEFINED_VALUE);
			// titulo reporte
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_TITLE, ConstantValue.TITLE_PAYMENT_TABLE, ConstantValue.UNDEFINED_VALUE);

		} catch (Exception e) {
			logger.logError("Exception REPORT PAYMENT TABLE", e);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("END getParameters REPORT PAYMENT TABLE");
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getJRDataSource  PAYMENT TABLE");

		List<QueryPaymentTableHead> queryPaymentTableHeadResponses = new ArrayList<QueryPaymentTableHead>();

		// Obtiene los parametros de la peticion HTTPServleRequest
		String numOperation = (String) paramsUrl.get(ConstantValue.NUM_OPERATION);
		String paymentTableHis = (String) paramsUrl.get(ConstantValue.PAYMENT_TABLE_HIST);

		QueryPaymentTableRequest queryPaymentTableRequest = new QueryPaymentTableRequest();
		queryPaymentTableRequest.setBank(numOperation);
		QueryPaymentTableHead queryPaymentTableHeadResponse = null;

		if ("S".equals(paymentTableHis)) {
			queryPaymentTableHeadResponse = service.queryPaymentTableHist(queryPaymentTableRequest, serviceIntegration);
		} else if ("N".equals(paymentTableHis)) {
			queryPaymentTableHeadResponse = service.queryPaymentTable(queryPaymentTableRequest, serviceIntegration);
		}

		if (queryPaymentTableHeadResponse != null) {
			queryPaymentTableHeadResponses.add(queryPaymentTableHeadResponse);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("END getJRDataSource PAYMENT TABLE");

		return new JRBeanCollectionDataSource(queryPaymentTableHeadResponses, true);
	}

}
