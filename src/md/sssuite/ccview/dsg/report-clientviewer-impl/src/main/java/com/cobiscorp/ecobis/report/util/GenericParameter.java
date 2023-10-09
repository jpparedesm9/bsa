package com.cobiscorp.ecobis.report.util;

import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.report.servlet.ProductHistoryServlet;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class GenericParameter {

	private static final ILogger logger = LogFactory.getLogger(GenericParameter.class);

	public Map<String, Object> getReportsParameter(String title, String show, String clientName, String dateFormatPattern, JRBeanCollectionDataSource datasource) {
		// TODO Remove hardcoded sorry :(
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("Title", title);
		parameters.put("show", show);
		parameters.put("clientName", clientName);
		parameters.put("dateFormatPattern", dateFormatPattern);
		if (logger.isDebugEnabled()) {
			logger.logDebug("El tipo de reporte es " + show);
		}
		if (show != null && show.equals(Constants.DEBTS_LOANS_HIST)) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a DEBTS_LOANS_HIST");
			}
			parameters.put("DebtLoansDataSource", datasource);
		}
		if (show != null && show.equals(Constants.CREDITS_HIST)) {
			parameters.put("CreditHistDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a CREDITS_HIST");
			}
		}
		if (show != null && show.equals(Constants.PRODUCT_OTHER_COMEX_HIST)) {
			parameters.put("ProductsOtherComextDataSouce", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a PRODUCT_OTHER_COMEX_HIST");
			}
		}
		if (show != null && show.equals(Constants.WARRANTIE_HIST)) {
			parameters.put("WarrantyHistDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a WARRANTIE_HIST");
			}
		}
		if (show != null && show.equals(Constants.INDIRECT_PORT_HIST)) {
			parameters.put("IndirectPortfolioHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a INDIRECT_PORT_HIST");
			}
		}
		/* Contingeste dividido en credito y otros productos */
		if (show != null && show.equals(Constants.CONTINGENCE_HIST)) {
			parameters.put("ContingenciesHistDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a CONTINGENCE_HIST");
			}
		}

		if (show != null && show.equals(Constants.CURRENT_ACOUNT_HIST)) {
			parameters.put("currentAccountsHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a CURRENT_ACOUNT_HIST");
			}
		}

		if (show != null && show.equals(Constants.SAVING_ACOUNTE_HIST)) {
			parameters.put("savingAccountsHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a SAVING_ACOUNTE_HIST");
			}
		}

		if (show != null && show.equals(Constants.FIXED_TERMS_HIST)) {
			parameters.put("fixedTermsHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a FIXED_TERMS_HIST");
			}
		}

		if (show != null && show.equals(Constants.PROMISORY_NOTES_HIST)) {
			parameters.put("promissoryNotesHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a PROMISORY_NOTES_HIST");
			}
		}
		if (show != null && show.equals(Constants.CUSTOMER_LINKED_HIST)) {
			parameters.put("customerLinkedHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a CUSTOMER_LINKED_HIST");
			}
		}
		if (show != null && show.equals(Constants.DEBIT_CARD_HIST)) {
			parameters.put("debitCardDataHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a DEBIT_CARD_HIST");
			}
		}
		if (show != null && show.equals(Constants.DEBT_SOURCE_HIST)) {
			parameters.put("debtsSourceHistDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a DEBT_SOURCE_HIST");
			}
		}

		if (show != null && show.equals(Constants.DEBT_REQUESTREJECT)) {
			parameters.put("requestRejectedHisDataSource", datasource);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa a DEBT_REQUESTREJECT");
			}
		}

		return parameters;
	}
}
