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
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentHead;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.service.ReceiptPaymentService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class ReceiptPaymentServlet extends BaseReportServlet {
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(ReceiptPaymentServlet.class);

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static ReceiptPaymentService service = new ReceiptPaymentService();
	private static Util util = new Util();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegrationset) {
		serviceIntegration = serviceIntegrationset;
	}

	public static void unsetServiceIntegration() {
		serviceIntegration = null;
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
			super.setReportJasperPath(ConstantValue.PATH_RECEIPT_PAYMENT_UVR);
			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);
			String secPayment = request.getParameter(ConstantValue.PAYMENT_TABLE_SEQUENTIAL);
			String nameUser = request.getParameter(ConstantValue.RPAYMENT_NAME_USER);

			if (numOperation != null && secPayment != null && nameUser != null) {
				paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);
				paramsUrl.put(ConstantValue.PAYMENT_TABLE_SEQUENTIAL, secPayment);
				paramsUrl.put(ConstantValue.RPAYMENT_NAME_USER, nameUser);

				// genera reporte
				response.setContentType("application/pdf");
				super.generate(request, response);
			} else {
				response.getWriter().write("Lo sentimos, falta información para crear reporte");
				response.getWriter().flush();
				response.getWriter().close();
			}

		} catch (Exception e) {
			logger.logError("ERROR REPORT RECEIPT PAYMENT", e);
			try {
				response.getWriter().write("Lo sentimos ocurrió un error al crear el documento");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (Exception ie) {
				logger.logError("ERROR WRITE", ie);
			}
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("END REPORT RECEIPT PAYMENT");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getParameters REPORT RECEIPT PAYMENT");
		// Setea el mapa de parametros
		util.setParams(new HashMap<String, Object>());

		try {
			// logo de banco
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN, ConstantValue.UNDEFINED_VALUE);
			// titulo reporte
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_TITLE, ConstantValue.TITLE_RECEIPT_PAYMENT, ConstantValue.UNDEFINED_VALUE);

		} catch (Exception e) {
			logger.logError("Exception REPORT RECEIPT PAYMENT", e);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("END getParameters REPORT RECEIPT PAYMENT");
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getJRDataSource RECEIPT PAYMENT");

		// Obtiene los parametros de la peticion HTTPServleRequest
		String numOperation = (String) paramsUrl.get(ConstantValue.NUM_OPERATION);
		Integer secPayment = paramsUrl.get(ConstantValue.PAYMENT_TABLE_SEQUENTIAL) != null ? Integer.parseInt((String) paramsUrl.get(ConstantValue.PAYMENT_TABLE_SEQUENTIAL))
				: null;
		String user = (String) paramsUrl.get(ConstantValue.RPAYMENT_NAME_USER);

		QueryReceiptPaymentRequest queryReceiptPaymentRequest = new QueryReceiptPaymentRequest();
		queryReceiptPaymentRequest.setBank(numOperation);
		queryReceiptPaymentRequest.setSecPag(secPayment);
		queryReceiptPaymentRequest.setUser(user);

		QueryReceiptPaymentHead receiptPaymentHeadResponse = service.queryReceiptPaymentAllInfo(queryReceiptPaymentRequest, serviceIntegration, util.getParams());

		List<QueryReceiptPaymentHead> receiptPaymentHeadResponses = new ArrayList<QueryReceiptPaymentHead>();
		if (receiptPaymentHeadResponse != null) {
			if (0 == receiptPaymentHeadResponse.getCurrency()) {
				super.setReportJasperPath(ConstantValue.PATH_RECEIPT_PAYMENT);
			}

			receiptPaymentHeadResponses.add(receiptPaymentHeadResponse);
		}
		if (logger.isDebugEnabled())
			logger.logDebug("END getJRDataSource RECEIPT PAYMENT");

		return new JRBeanCollectionDataSource(receiptPaymentHeadResponses, true);
	}

}
