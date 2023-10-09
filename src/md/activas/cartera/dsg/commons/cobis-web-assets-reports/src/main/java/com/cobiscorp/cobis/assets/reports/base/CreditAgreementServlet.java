package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import cobiscorp.ecobis.assets.cloud.dto.DataCreditAgreement;
import cobiscorp.ecobis.assets.cloud.dto.DataReportCreditAgreement;
import cobiscorp.ecobis.assets.cloud.dto.ReportCreditAgreementClient;
import cobiscorp.ecobis.assets.cloud.dto.ReportCreditAgreementRequest;
import cobiscorp.ecobis.assets.cloud.dto.SwornDeclarationCredit;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.service.CreditAgreementService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class CreditAgreementServlet extends BaseReportServlet {
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(CreditAgreementServlet.class);

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static CreditAgreementService service = new CreditAgreementService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		CreditAgreementServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		CreditAgreementServlet.serviceIntegration = null;
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
			super.setReportJasperPath(ConstantValue.PATH_CREDIT_AGREEMENT);
			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Credit Agreement numOperation: " + numOperation);
			}

			paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);
			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			logger.logError("ERROR REPORT Credit Agreement", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza doPost");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getParameters");
		}

		Util util = new Util();
		util.setParams(new HashMap<String, Object>());

		try {
			// TITULO DE REPORTE
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_TITLE, ConstantValue.TITLE_CREDIT_AGREEMENT, ConstantValue.UNDEFINED_VALUE);

			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN, ConstantValue.UNDEFINED_VALUE);

			util.mapValuesToParams(ConstantValue.PARAM_TITLE_BANK_NAME, ConstantValue.VALUE_TITLE_BANK_NAME, ConstantValue.UNDEFINED_VALUE);

			util.mapValuesToParams(ConstantValue.PARAM_WEB_PAGE, ConstantValue.VALUE_WEB_PAGE, ConstantValue.UNDEFINED_VALUE);

			util.mapValuesToParams(ConstantValue.PARAM_PHONE_MSG, ConstantValue.VALUE_PHONE_MSG, ConstantValue.UNDEFINED_VALUE);

			util.mapValuesToParams(ConstantValue.PARAM_SUPPORT_EMAIL, ConstantValue.VALUE_SUPPORT_EMAIL, ConstantValue.UNDEFINED_VALUE);

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

		List<DataReportCreditAgreement> dataCreditAgreementResponses = new ArrayList<DataReportCreditAgreement>();
		String numOperation = (String) paramsUrl.get(ConstantValue.NUM_OPERATION);

		try {
			ReportCreditAgreementRequest reportCreditAgreementRequest = new ReportCreditAgreementRequest();
			DataReportCreditAgreement dataReportCreditAgreement = new DataReportCreditAgreement();
			reportCreditAgreementRequest.setBank(numOperation);

			DataCreditAgreement dataCreditAgreement = service.queryCreditAgreementAll(reportCreditAgreementRequest, serviceIntegration);

			dataReportCreditAgreement.setLoanBankId(numOperation);
			dataReportCreditAgreement.setBankName(ConstantValue.BANK_NAME);

			if (dataCreditAgreement != null && dataCreditAgreement.getCreditAgreement() != null) {

				dataReportCreditAgreement.setAmountLetters(dataCreditAgreement.getCreditAgreement().getAmountLetters());
				dataReportCreditAgreement.setTotalAmount(dataCreditAgreement.getCreditAgreement().getTotalAmount());
				dataReportCreditAgreement.setAmountApr(dataCreditAgreement.getCreditAgreement().getAmountApr());
				dataReportCreditAgreement.setTermQuotaLetters(dataCreditAgreement.getCreditAgreement().getTermQuotaLetters());
				dataReportCreditAgreement.setTermQuota(dataCreditAgreement.getCreditAgreement().getTermQuota());
				dataReportCreditAgreement.setLettersApercre(dataCreditAgreement.getCreditAgreement().getLettersApercre());
				dataReportCreditAgreement.setRateEfAnnual(dataCreditAgreement.getCreditAgreement().getRateEfAnnual());
				dataReportCreditAgreement.setDateLiq(dataCreditAgreement.getCreditAgreement().getDateLiq());
				dataReportCreditAgreement.setHeadlines(dataCreditAgreement.getCreditAgreementClient());

				// LISTAS DIFERENTES PARA LAS FIRMAS
				int cont = 1;
				ArrayList<ReportCreditAgreementClient> signaturesLeft = new ArrayList<ReportCreditAgreementClient>();
				ArrayList<ReportCreditAgreementClient> signaturesRight = new ArrayList<ReportCreditAgreementClient>();

				if (dataCreditAgreement.getCreditAgreementClient() != null) {
					for (ReportCreditAgreementClient client : dataCreditAgreement.getCreditAgreementClient()) {
						if (cont % 2 == 0) {
							signaturesRight.add(client);
						} else {
							signaturesLeft.add(client);
						}
						cont++;
					}
				}
				dataReportCreditAgreement.setSignaturesLeft(signaturesLeft);
				dataReportCreditAgreement.setSignaturesRight(signaturesRight);

				if (dataCreditAgreement.getSwornDeclarationCredit() != null && !dataCreditAgreement.getSwornDeclarationCredit().isEmpty()) {
					sortAssetsType(dataCreditAgreement.getSwornDeclarationCredit());
				}
				dataReportCreditAgreement.setAssets(dataCreditAgreement.getSwornDeclarationCredit());

				dataReportCreditAgreement.setDay(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 0));
				dataReportCreditAgreement.setMonth(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 1));
				dataReportCreditAgreement.setYear(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 2));
				dataReportCreditAgreement.setDayLetters(Util.convertNumberToLetter(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 0)));
				dataReportCreditAgreement.setMonthLetters(Util.convertMonthsToLetter(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 1)));
				dataReportCreditAgreement.setYearLetters(Util.convertNumberToLetter(StringSplit(dataCreditAgreement.getCreditAgreement().getDateLiq(), 2).substring(2)));

				dataCreditAgreementResponses.add(dataReportCreditAgreement);
			}

		} catch (Exception e) {
			logger.logError("Exception getJRDataSource", e);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza getJRDataSource");
		}
		return new JRBeanCollectionDataSource(dataCreditAgreementResponses, true);
	}

	/**
	 * Permite obtener la posicion de una fecha (dia, mes o anio)
	 * 
	 * @param date
	 * @param pos
	 * @return
	 * @throws NumberFormatException
	 */
	public static String StringSplit(String date, int pos)  {
		String[] parts = date.split("/");
		String part1 = parts[pos];
		return part1;
	}

	/**
	 * Permite ordenar un ArrayList de Bienes de acuerdo al Tipo de Bien
	 * 
	 * @param swornDeclarationCreditList
	 */
	public static void sortAssetsType(List<SwornDeclarationCredit> swornDeclarationCreditList) {
		Collections.sort(swornDeclarationCreditList, new Comparator<SwornDeclarationCredit>() {
			@Override
			public int compare(SwornDeclarationCredit obj1, SwornDeclarationCredit obj2) {
				return obj2.getAssetsType() - obj1.getAssetsType();
			}
		});
	}
}
