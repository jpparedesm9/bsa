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
import com.cobiscorp.cobis.assets.reports.dto.CollateralResponseDTO;
import com.cobiscorp.cobis.assets.reports.dto.ReferenceDTO;
import com.cobiscorp.cobis.assets.reports.service.CollaterallPaymentService;
import com.cobiscorp.cobis.assets.reports.service.FooterPageService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.GroupInfoResponse;
import cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.PaymentDetGarResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class CollateralPaymentServlet extends BaseReportServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(CollateralPaymentServlet.class);
	private Util util = new Util();

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static CollaterallPaymentService service = new CollaterallPaymentService();
	private static FooterPageService footerPageService = new FooterPageService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		CollateralPaymentServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		CollateralPaymentServlet.serviceIntegration = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia doPost");
		}

		try {
			// SETEA PATH DE REPORTE
			super.setReportJasperPath(ConstantValue.PATH_COLLATERAL_PAYMENT);
			util.setParams(new HashMap<String, Object>());
			String transactionNumber = request.getParameter(ConstantValue.NUM_TRAN);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Trámite: " + transactionNumber);
			}

			paramsUrl.put(ConstantValue.NUM_TRAN, transactionNumber);
			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			logger.logError("ERROR REPORT Collateral Payment", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza doPost");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getParameters CollateralPaymentServlet");
		}

		try {
			// TITULO DE REPORTE
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN_TUIIO, ConstantValue.UNDEFINED_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_FOOTER, footerPageService.getFooterPage(serviceIntegration), ConstantValue.EMPTY_VALUE);
			util.mapValuesToParams(ConstantValue.PARAM_ENTERPRISE_NAME, ConstantValue.EMPTY_VALUE, ConstantValue.EMPTY_VALUE);

		} catch (Exception e) {
			logger.logError("Exception getParameters", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza getParameters");
			}
		}
		return util.getParams();
	}

	@Override
	protected JRDataSource getJRDataSource() {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getJRDataSource");
		}

		List<ReferenceDTO> referencesResult = new ArrayList<ReferenceDTO>();
		Integer transactionNumber = paramsUrl.get(ConstantValue.NUM_TRAN) == null ? null : Integer.valueOf((String) paramsUrl.get(ConstantValue.NUM_TRAN));

		try {
			GroupPaymentRequest groupPaymentRequest = new GroupPaymentRequest();
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator(serviceIntegration);

			if (transactionNumber == null) {
				logger.logError("No se envió número de Trámite.");
			} else {
				groupPaymentRequest.setTransaction(transactionNumber);

				List<CollateralResponseDTO> collateralResponse = service.queryCollateralPayment(groupPaymentRequest, serviceIntegration);

				if (collateralResponse != null) {
					logger.logDebug("GroupInfoResponse: " + collateralResponse);

					for (CollateralResponseDTO collateral : collateralResponse) {

						if (collateral != null && collateral.getGroupInfoResponse() != null && collateral.getReferences() != null && collateral.getDetallePagos() != null) {

							GroupInfoResponse groupInfoResponse = collateral.getGroupInfoResponse();
							util.mapValuesToParams(ConstantValue.PARAM_INIT_DATE,
									groupInfoResponse.getLiquidationDate() == null ? null : groupInfoResponse.getLiquidationDate().getTime(), null);
							util.mapValuesToParams(ConstantValue.PARAM_CUSTOMER_NAME, groupInfoResponse.getGroupName(), null);
							util.mapValuesToParams(ConstantValue.PARAM_EXPIRATION_DATE,
									groupInfoResponse.getExpirationDate() == null ? null : groupInfoResponse.getExpirationDate().getTime(), null);
							util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_NUMBER, groupInfoResponse.getPaymentNumber(), null);

							DecimalFormat df = new DecimalFormat("###,###.00");
							DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
							dfs.setDecimalSeparator('.');
							dfs.setGroupingSeparator(',');
							df.setDecimalFormatSymbols(dfs);
							util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_AMOUNT, groupInfoResponse.getAmount() == null ? null : df.format(groupInfoResponse.getAmount()),
									null);
							util.mapValuesToParams(ConstantValue.PARAM_OFFICE_NAME, groupInfoResponse.getOfficeName(), null);

							List<ReferenceDTO.Payment> payments = new ArrayList<ReferenceDTO.Payment>();
							for (ReferenceResponse reference : collateral.getReferences()) {
								payments.add(new ReferenceDTO.Payment(reference.getInstitution(), reference.getReferenceString(), reference.getAgreement(),
										barCodeGenerator.createBarCode128(reference.getReferenceString(), groupInfoResponse.getOfficeName(), reference.getInstitution())));

							}

							List<ReferenceDTO.DetallePaymentGar> paymentsGar = new ArrayList<ReferenceDTO.DetallePaymentGar>();
							for (PaymentDetGarResponse paymentGar : collateral.getDetallePagos()) {
								paymentsGar.add(new ReferenceDTO.DetallePaymentGar(paymentGar.getCustumerName(), paymentGar.getSafeAmount(), paymentGar.getGuaranteeAmount(),
										paymentGar.getMedicalAssitanceAmount()));

							}

							referencesResult.add(new ReferenceDTO(payments, paymentsGar));
						}
					}
				}
			}
		} catch (Exception e) {
			logger.logError("Exception getJRDataSource", e);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza getJRDataSource");
		}

		return new JRBeanCollectionDataSource(referencesResult, true);
	}
}
