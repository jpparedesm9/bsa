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
import com.cobiscorp.cobis.assets.reports.dto.CorresponsalPaymentResponseDTO;
import com.cobiscorp.cobis.assets.reports.dto.ReferenceDTO;
import com.cobiscorp.cobis.assets.reports.service.CorresponsalPaymentService;
import com.cobiscorp.cobis.assets.reports.service.FooterPageService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.CorresponsalPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.CorresponsalPaymentResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class CorresponsalPaymentServlet extends BaseReportServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger LOGGER = LogFactory.getLogger(CorresponsalPaymentServlet.class);
	private Util util = new Util();

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static CorresponsalPaymentService service = new CorresponsalPaymentService();
	private static FooterPageService footerPageService = new FooterPageService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		CorresponsalPaymentServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		CorresponsalPaymentServlet.serviceIntegration = null;
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
			LOGGER.logDebug("Inicia doPost CorresponsalPaymentServlet");
		}

		try {
			// SETEA PATH DE REPORTE
			String report = ConstantValue.INDIVIDUAL.equals(request.getParameter(ConstantValue.OPERATION_TYPE)) ? ConstantValue.PATH_CORRESPONSAL_PAYMENT_IND
					: ConstantValue.PATH_CORRESPONSAL_PAYMENT;
			super.setReportJasperPath(report);

			// super.setReportJasperPath(ConstantValue.PATH_CORRESPONSAL_PAYMENT);
			util.setParams(new HashMap<String, Object>());
			String bank = request.getParameter(ConstantValue.BANK);
			String sendMail = request.getParameter(ConstantValue.SEND_MAIL);
			String operationType = request.getParameter(ConstantValue.OPERATION_TYPE);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Bank: " + bank);
				LOGGER.logDebug("sendMail: " + sendMail);
				LOGGER.logDebug("report: " + report);
				LOGGER.logDebug("operationType: " + operationType);
			}

			paramsUrl.put(ConstantValue.BANK, bank);
			paramsUrl.put(ConstantValue.SEND_MAIL, sendMail);
			paramsUrl.put(ConstantValue.OPERATION_TYPE, operationType);
			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			LOGGER.logError("ERROR REPORT CorresponsalPaymentServlet", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza doPost CorresponsalPaymentServlet");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia getParameters CorresponsalPaymentServlet");
		}

		try {
			// TITULO DE REPORTE
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN_TUIIO, ConstantValue.UNDEFINED_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_FOOTER, footerPageService.getFooterPage(serviceIntegration), ConstantValue.EMPTY_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_ENTERPRISE_NAME, ConstantValue.EMPTY_VALUE, ConstantValue.EMPTY_VALUE);

		} catch (Exception e) {
			LOGGER.logError("Exception getParameters CorresponsalPaymentServlet", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza getParameters CorresponsalPaymentServlet");
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

		String bank = (String) paramsUrl.get(ConstantValue.BANK);
		String sendMail = (String) paramsUrl.get(ConstantValue.SEND_MAIL);
		String operationType = (String) paramsUrl.get(ConstantValue.OPERATION_TYPE);
		if (sendMail == null)
			sendMail = "1";

		try {
			CorresponsalPaymentRequest request = new CorresponsalPaymentRequest();
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator(serviceIntegration);
			if (bank == null) {
				LOGGER.logError("No se envió operación");
			} else {
				request.setBank(bank);
				request.setType(Integer.parseInt(sendMail));

				CorresponsalPaymentResponseDTO response = null;

				LOGGER.logDebug("CorresponsalPaymentServlet>>operationType: " + operationType);
				if (ConstantValue.INDIVIDUAL.equals(operationType)) {
					request.setOperation("I");
					response = service.queryCorresponsalPaymentInd(request, serviceIntegration);
				} else {
					response = service.queryCorresponsalPayment(request, serviceIntegration);
				}

				// CorresponsalPaymentResponseDTO response = service.queryCorresponsalPayment(request, serviceIntegration);

				if (response != null) {
					LOGGER.logDebug("corresponsalPaymentResponses: " + response);

					if (response.getCorresponsalPaymentResponse() != null && response.getReferences() != null) {
						CorresponsalPaymentResponse corresponsalPaymentResponse = response.getCorresponsalPaymentResponse();
						util.mapValuesToParams(ConstantValue.PARAM_INIT_DATE, corresponsalPaymentResponse.getStartDate().getTime(), null);
						util.mapValuesToParams(ConstantValue.PARAM_CUSTOMER_NAME, corresponsalPaymentResponse.getClientName(), null);
						util.mapValuesToParams(ConstantValue.PARAM_EXPIRATION_DATE, corresponsalPaymentResponse.getEffectiveDate().getTime(), null);

						DecimalFormat df = new DecimalFormat("###,###.00");
						DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
						dfs.setDecimalSeparator('.');
						dfs.setGroupingSeparator(',');
						df.setDecimalFormatSymbols(dfs);
						util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_AMOUNT, new BigDecimal(corresponsalPaymentResponse.getAmount()), null);
						util.mapValuesToParams(ConstantValue.PARAM_OFFICE_NAME, corresponsalPaymentResponse.getOffice(), null);
						util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_NUMBER, corresponsalPaymentResponse.getFeeNumber(), null);
						ReferenceResponse[] references = response.getReferences();
						List<ReferenceDTO.Payment> payments = new ArrayList<ReferenceDTO.Payment>();
						for (ReferenceResponse reference : references) {
							LOGGER.logDebug("REFERENCIA:" + reference.getInstitution() + reference.getReferenceString());
							payments.add(new ReferenceDTO.Payment(reference.getInstitution(), reference.getReferenceString(), reference.getAgreement(),
									barCodeGenerator.createBarCode128(reference.getReferenceString(), corresponsalPaymentResponse.getOffice(), reference.getInstitution())));
						}
						referencesResult.add(new ReferenceDTO(payments));

					}
				}
			}
		} catch (Exception e) {
			LOGGER.logError("Exception getJRDataSource CorresponsalPaymentServlet", e);
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finaliza getJRDataSource CorresponsalPaymentServlet");
		}

		return new JRBeanCollectionDataSource(referencesResult, true);
	}
}
