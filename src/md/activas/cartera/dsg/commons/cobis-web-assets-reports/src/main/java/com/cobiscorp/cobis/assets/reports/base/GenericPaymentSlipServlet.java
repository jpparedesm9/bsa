package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cobiscorp.cobis.assets.reports.commons.BarCodeGenerator;
import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.dto.ReferenceDTO;
import com.cobiscorp.cobis.assets.reports.service.FooterPageService;
import com.cobiscorp.cobis.assets.reports.service.GenericPaymentSlipService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.GenericPaymentSlipResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class GenericPaymentSlipServlet extends BaseReportServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger LOGGER = LogFactory.getLogger(GenericPaymentSlipServlet.class);
	private Util util = new Util();

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static GenericPaymentSlipService service = new GenericPaymentSlipService();
	private static FooterPageService footerPageService = new FooterPageService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		GenericPaymentSlipServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		GenericPaymentSlipServlet.serviceIntegration = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia doPost");
		}

		try {
			// SETEA PATH DE REPORTE
			super.setReportJasperPath(ConstantValue.PATH_GENERICPAYMENTSLIP);
			util.setParams(new HashMap<String, Object>());
			String clientID = request.getParameter(ConstantValue.CLIENTID);
			String bank = request.getParameter(ConstantValue.BANK);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Cliente: " + clientID);
				LOGGER.logDebug("Prestamo: " + bank);
			}

			paramsUrl.put(ConstantValue.CLIENTID, clientID);
			paramsUrl.put(ConstantValue.BANK, bank);

			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			LOGGER.logError("ERROR REPORT GenericPaymentSlip", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza doPost");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia getParameters GenericPaymentSlipServlet");
		}

		try {
			// TITULO DE REPORTE
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN_TUIIO, ConstantValue.UNDEFINED_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_FOOTER, footerPageService.getFooterPage(serviceIntegration), ConstantValue.EMPTY_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_ENTERPRISE_NAME, ConstantValue.EMPTY_VALUE, ConstantValue.EMPTY_VALUE);

		} catch (Exception e) {
			LOGGER.logError("Exception getParameters", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza getParameters");
			}
		}
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia getJRDataSource");
		}

		List<ReferenceDTO> referencesResult = new ArrayList<ReferenceDTO>();
		LOGGER.logDebug("reporte clientID " + paramsUrl.get(ConstantValue.CLIENTID));
		LOGGER.logDebug("reporte bank " + paramsUrl.get(ConstantValue.BANK));

		Integer clientID = paramsUrl.get(ConstantValue.CLIENTID) == null ? null : Integer.valueOf((String) paramsUrl.get(ConstantValue.CLIENTID));
		String bankId = (String) paramsUrl.get(ConstantValue.BANK);

		try {
			LoanRequest loanRequest = new LoanRequest();
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator(serviceIntegration);

			if ((clientID == null && bankId == null)) {
				LOGGER.logError("Debe enviar código del cliente o del banco");
			} else {
				if (clientID != null) {
					loanRequest.setClient(clientID);
				}
				loanRequest.setBank(bankId);
				GenericPaymentSlipResponse response = service.queryGenericPaymentSlip(loanRequest, serviceIntegration);

				if (response != null) {
					LOGGER.logDebug("genericPaymentSlipResponse: " + response);

					String iniDate = (String) (response.getInitialDate() == null ? "" : response.getInitialDate());
					String endDate = (String) (response.getEndDate() == null ? "" : response.getEndDate());

					util.mapValuesToParams(ConstantValue.PARAM_INIT_DATE, iniDate, null);
					util.mapValuesToParams(ConstantValue.PARAM_EXPIRATION_DATE, endDate, null);

					util.mapValuesToParams(ConstantValue.PARAM_CUSTOMER_NAME, response.getNameClient(), null);

					DecimalFormat df = new DecimalFormat("###,###.00");
					DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
					dfs.setDecimalSeparator('.');
					dfs.setGroupingSeparator(',');
					df.setDecimalFormatSymbols(dfs);
					util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_AMOUNT,  df.format(new BigDecimal(response.getAmount())), null);

					util.mapValuesToParams(ConstantValue.PARAM_OFFICE_NAME, response.getNameOffice(), null);

					List<ReferenceDTO.Payment> payments = new ArrayList<ReferenceDTO.Payment>();
					String santander = "BANCO SANTANDER";
					String elavon = "ELAVON";
					String oxxo = "OXXO";
					LOGGER.logDebug("santanderConv: " + response.getStdConv());
					LOGGER.logDebug("elavonConv: " + response.getElavConv());
					LOGGER.logDebug("oxxoConv: " + response.getOxxoConv());
					payments.add(new ReferenceDTO.Payment(santander, response.getStdRef(), response.getStdConv(),
							barCodeGenerator.createBarCode128(response.getStdRef(), response.getNameOffice(), santander)));
					payments.add(new ReferenceDTO.Payment(elavon, response.getElvRef(), response.getElavConv(),
							barCodeGenerator.createBarCode128(response.getElvRef(), response.getNameOffice(), elavon)));
					payments.add(new ReferenceDTO.Payment(oxxo, response.getOxxoRef(), response.getOxxoConv(),
							barCodeGenerator.createBarCode128(response.getOxxoRef(), response.getNameOffice(), oxxo)));

					referencesResult.add(new ReferenceDTO(payments));
				}
			}
		} catch (Exception e) {
			LOGGER.logError("Exception getJRDataSource", e);
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finaliza getJRDataSource");
		}

		return new JRBeanCollectionDataSource(referencesResult, true);
	}
}
