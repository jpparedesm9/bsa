package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cobiscorp.cobis.assets.reports.commons.BarCodeGenerator;
import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.dto.PrecancellationResponseDTO;
import com.cobiscorp.cobis.assets.reports.dto.ReferenceDTO;
import com.cobiscorp.cobis.assets.reports.service.FooterPageService;
import com.cobiscorp.cobis.assets.reports.service.PreCancellationService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.util.ServerParamUtil;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class PreCancellationServlet extends BaseReportServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger LOGGER = LogFactory.getLogger(PreCancellationServlet.class);
	private Util util = new Util();

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static PreCancellationService service = new PreCancellationService();
	private static FooterPageService footerPageService = new FooterPageService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		PreCancellationServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		PreCancellationServlet.serviceIntegration = null;
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
			super.setReportJasperPath(ConstantValue.PATH_PRECANCELLATION);
			util.setParams(new HashMap<String, Object>());
			String clientID = request.getParameter(ConstantValue.CLIENTID);
			String amountPRE = request.getParameter(ConstantValue.AMOUNTPRE);
			String bank = request.getParameter(ConstantValue.BANK);
			String sendMail = request.getParameter(ConstantValue.SEND_MAIL);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Cliente: " + clientID);
			}

			paramsUrl.put(ConstantValue.CLIENTID, clientID);
			paramsUrl.put(ConstantValue.AMOUNTPRE, amountPRE);
			paramsUrl.put(ConstantValue.BANK, bank);
			paramsUrl.put(ConstantValue.SEND_MAIL, sendMail);

			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			LOGGER.logError("ERROR REPORT PreCancellation", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza doPost");
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
		LOGGER.logDebug("reporte amountPRE " + paramsUrl.get(ConstantValue.AMOUNTPRE));
		LOGGER.logDebug("reporte bank " + paramsUrl.get(ConstantValue.BANK));
		LOGGER.logDebug("sendMail " + paramsUrl.get(ConstantValue.SEND_MAIL));

		Integer clientID = paramsUrl.get(ConstantValue.CLIENTID) == null ? null : Integer.valueOf((String) paramsUrl.get(ConstantValue.CLIENTID));

		Double amountPRE = paramsUrl.get(ConstantValue.AMOUNTPRE) == null ? null : Double.valueOf((String) paramsUrl.get(ConstantValue.AMOUNTPRE));

		String bankId = (String) paramsUrl.get(ConstantValue.BANK);

		Integer sendMail = paramsUrl.get(ConstantValue.SEND_MAIL) == null ? null : Integer.valueOf((String) paramsUrl.get(ConstantValue.SEND_MAIL));

		try {
			LoanRequest loanRequest = new LoanRequest();
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator(serviceIntegration);

			if ((clientID == null && bankId == null) || amountPRE == null) {
				LOGGER.logError("Debe enviar código del cliente o del banco y el monto de precancelación");
			} else {
				if (clientID != null) {
					loanRequest.setClient(clientID);
				}
				loanRequest.setAmountDs(new BigDecimal(amountPRE).setScale(2, BigDecimal.ROUND_HALF_UP));

				loanRequest.setBank(bankId);
				loanRequest.setType(sendMail);
				PrecancellationResponseDTO response = service.queryPreCancellation(loanRequest, serviceIntegration);

				if (response != null) {
					LOGGER.logDebug("preCancellationResponses: " + response);

					if (response.getPrecancellation() != null && response.getReferences() != null) {
						LOGGER.logDebug("entró 1--->");
						PreCancellationResponse preCancelattionResponse = response.getPrecancellation();
						String operationDate = preCancelattionResponse.getOperationDate() == null ? "" : preCancelattionResponse.getOperationDate();
						String expirationDate = preCancelattionResponse.getPrecancellationDate() == null ? "" : preCancelattionResponse.getPrecancellationDate();
						SimpleDateFormat sdfOrigen = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						SimpleDateFormat sdfDestino = new SimpleDateFormat("dd/MM/yyyy");
						try {
							Date date = sdfOrigen.parse(operationDate);
							operationDate = sdfDestino.format(date);
						} catch (ParseException pe) {
							LOGGER.logError("error al convertir la fecha operationDate" + operationDate);
						}

						try {
							Date date = sdfOrigen.parse(expirationDate);
							expirationDate = sdfDestino.format(date);
						} catch (ParseException pe) {
							LOGGER.logError("error al convertir la fecha expirationDate " + expirationDate);
						}
						util.mapValuesToParams(ConstantValue.PARAM_INIT_DATE, operationDate, null);
						util.mapValuesToParams(ConstantValue.PARAM_EXPIRATION_DATE, expirationDate, null);

						util.mapValuesToParams(ConstantValue.PARAM_CUSTOMER_NAME, preCancelattionResponse.getClientName(), null);

						DecimalFormat df = new DecimalFormat("###,###.00");
						DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
						dfs.setDecimalSeparator('.');
						dfs.setGroupingSeparator(',');
						df.setDecimalFormatSymbols(dfs);
						util.mapValuesToParams(ConstantValue.PARAM_PAYMENT_AMOUNT, df.format(preCancelattionResponse.getAmountPRE()), null);
						util.mapValuesToParams(ConstantValue.PARAM_OFFICE_NAME, preCancelattionResponse.getOfficeName(), null);

						ReferenceResponse[] references = response.getReferences();
						List<ReferenceDTO.Payment> payments = new ArrayList<ReferenceDTO.Payment>();
						for (ReferenceResponse reference : references) {
							LOGGER.logDebug("REFERENCIA:" + reference.getInstitution() + reference.getReferenceString());
							payments.add(new ReferenceDTO.Payment(reference.getInstitution(), reference.getReferenceString(), reference.getAgreement(),
									barCodeGenerator.createBarCode128(reference.getReferenceString(), preCancelattionResponse.getOfficeName(), reference.getInstitution())));
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
