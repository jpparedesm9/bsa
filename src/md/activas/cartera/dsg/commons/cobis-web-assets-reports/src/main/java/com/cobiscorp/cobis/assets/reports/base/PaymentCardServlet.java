package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
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
import com.cobiscorp.cobis.assets.reports.dto.PaymentCardDTO;
import com.cobiscorp.cobis.assets.reports.dto.ReferenceDTO;
import com.cobiscorp.cobis.assets.reports.service.FooterPageService;
import com.cobiscorp.cobis.assets.reports.service.PaymentCardService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.PaymentCardDetailResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentCardHeaderResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentCardRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class PaymentCardServlet extends BaseReportServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger LOGGER = LogFactory.getLogger(PaymentCardServlet.class);
	private Util util = new Util();

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static PaymentCardService service = new PaymentCardService();
	private static FooterPageService footerPageService = new FooterPageService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		PaymentCardServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		PaymentCardServlet.serviceIntegration = null;
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
			LOGGER.logDebug("Inicia doPost - PaymentCardServlet");
		}

		try {
			// SETEA PATH DE REPORTE
			super.setReportJasperPath(ConstantValue.PATH_PAYMENT_CARD);
			util.setParams(new HashMap<String, Object>());

			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);
			String sendMail = request.getParameter(ConstantValue.SEND_MAIL);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("bankNumber: " + numOperation);
				LOGGER.logDebug("sendMail: " + sendMail);
			}

			paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);
			paramsUrl.put(ConstantValue.SEND_MAIL, sendMail);
			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			LOGGER.logError("ERROR REPORT PaymentCard", e);
		} catch (Exception e) {
			LOGGER.logError("ERROR REPORT PaymentCard", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza doPost PaymentCard");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia getParameters PreCancellationServlet");
		}

		try {
			// TITULO DE REPORTE
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN_TUIIO2, ConstantValue.UNDEFINED_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_INFO_IMAGE, ConstantValue.URL_IMAGEN_PAYMENT_INFO, ConstantValue.UNDEFINED_VALUE);

		} catch (Exception e) {
			LOGGER.logError("Exception getParameters - PaymentCardServlet", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza getParameters - PaymentCardServlet");
			}
		}
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia getJRDataSource-PaymentCardServlet");
		}

		List<ReferenceDTO> referencesResult = new ArrayList<ReferenceDTO>();
		LOGGER.logDebug("reporte PARAM_LOAN_ID " + paramsUrl.get(ConstantValue.NUM_OPERATION));

		String bankNumber = paramsUrl.get(ConstantValue.NUM_OPERATION) == null ? null : (String) paramsUrl.get(ConstantValue.NUM_OPERATION);
		String sendMail = paramsUrl.get(ConstantValue.SEND_MAIL) == null ? null : (String) paramsUrl.get(ConstantValue.SEND_MAIL);
		try {
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator(serviceIntegration);
			PaymentCardRequest paymentCardRequest = new PaymentCardRequest();

			if (bankNumber == null) {
				LOGGER.logError("No se envió número de Operacion ");
			} else {
				paymentCardRequest.setBankId(bankNumber);
				paymentCardRequest.setReportType(Integer.valueOf(sendMail));

				LOGGER.logDebug("paymentCardRequest.getBankId(): " + paymentCardRequest.getBankId());
				LOGGER.logDebug("paymentCardRequest.getSendMail(): " + paymentCardRequest.getReportType());

				PaymentCardDTO response = service.queryPaymentcard(paymentCardRequest, serviceIntegration);

				if (response != null) {
					LOGGER.logDebug("paymentCardResponses: " + response);

					if (response.getPaymentCardHeaderResponse() != null && response.getPaymentCardDetailResponse() != null) {
						LOGGER.logDebug("PaymentCard response is not null--->");

						DecimalFormat df = new DecimalFormat("$###,###.00");
						DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
						dfs.setDecimalSeparator('.');
						dfs.setGroupingSeparator(',');
						df.setDecimalFormatSymbols(dfs);

						PaymentCardHeaderResponse paymentCardHeaderResponse = response.getPaymentCardHeaderResponse();
						util.mapValuesToParams(ConstantValue.PARAM_LOAN_ID, paymentCardHeaderResponse.getBankId() == null ? null : paymentCardHeaderResponse.getBankId(), null);
						util.mapValuesToParams(ConstantValue.PARAM_CLIENT_NAME, paymentCardHeaderResponse.getCustomerName() == null ? null : paymentCardHeaderResponse.getCustomerName(), null);
						util.mapValuesToParams(ConstantValue.PARAM_NEXT_PAYMENT_DATE, paymentCardHeaderResponse.getNextPaymentDate() == null ? null : paymentCardHeaderResponse.getNextPaymentDate(),
								null);
						util.mapValuesToParams(ConstantValue.PARAM_AMOUNT_NO_INTERESTS,
								paymentCardHeaderResponse.getPaymentNoInterest() == null ? null : df.format(paymentCardHeaderResponse.getPaymentNoInterest()), null);
						util.mapValuesToParams(ConstantValue.PARAM_MINIMIUM_PAYMENT,
								paymentCardHeaderResponse.getMinimiumPayment() == null ? null : df.format(paymentCardHeaderResponse.getMinimiumPayment()), null);

						PaymentCardDetailResponse[] paymentCardDetailsResponse = response.getPaymentCardDetailResponse();

						List<ReferenceDTO.Payment> payments = new ArrayList<ReferenceDTO.Payment>();

						for (PaymentCardDetailResponse paymentCardDetailResponse : paymentCardDetailsResponse) {
							LOGGER.logDebug("REFERENCIA:" + paymentCardDetailResponse.getInstitution() + paymentCardDetailResponse.getReference());
							payments.add(new ReferenceDTO.Payment(paymentCardDetailResponse.getInstitution(), paymentCardDetailResponse.getReference(), paymentCardDetailResponse.getConventionNumber(),
									barCodeGenerator.createBarCode128(paymentCardDetailResponse.getReference(), paymentCardDetailResponse.getInstitution())));
						}
						referencesResult.add(new ReferenceDTO(payments));
					}
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
