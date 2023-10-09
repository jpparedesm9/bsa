package com.cobiscorp.ecobis.report.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.OwnWarrantyTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RequestRejectedTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryProductDTO;
import com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO;
import com.cobiscorp.ecobis.report.servlet.ProductHistoryServlet;

public class Util {
	/**
	 * formatea la fecha al de Panamá
	 * 
	 * @param Date
	 * @return String
	 */

	private static final ILogger logger = LogFactory.getLogger(Util.class);

	public static String obtenerFecha(Date date) {
		DateFormat df;
		df = DateFormat.getDateInstance(DateFormat.LONG, Locale.ENGLISH);
		String f = df.format(date);
		return f;
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	public static ServiceResponse loadHistoryDataClient(HttpServletRequest request) {
		ServiceResponse serviceResponse = (ServiceResponse) request.getSession().getAttribute(Constants.HISTORY_DATA_CLIENT);
		return serviceResponse;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	public static JRBeanCollectionDataSource getDataSourceCollection(HashMap<String, Object> prepareDataHistoryMap, String typeReport, String dateFormatPattern) {
		JRBeanCollectionDataSource beanColDataSource = null;
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.DEBTS_LOANS_HIST)) {

			List<SummaryDebtsDTO> debts = (List<SummaryDebtsDTO>) prepareDataHistoryMap.get(Constants.DEBTS_LOANS_HIST);
			for (SummaryDebtsDTO debt : debts) {
				logger.logDebug("report DEBTS_LOANS_HIST --> date" + debt.getDateCancellation()+","+debt.getOpeningDate());
				logger.logDebug("report DEBTS_LOANS_HIST -->" + debt.toString());
			}
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.CREDITS_HIST)) {

			List<SummaryCreditsDTO> debts = (List<SummaryCreditsDTO>) prepareDataHistoryMap.get(Constants.CREDITS_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.WARRANTIE_HIST)) {
			List<WarrantyTmpDTO> debts = (List<WarrantyTmpDTO>) prepareDataHistoryMap.get(Constants.WARRANTIE_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.CONTINGENCE_HIST)) {
			List<SummaryDebtsDTO> debts = (List<SummaryDebtsDTO>) prepareDataHistoryMap.get(Constants.CONTINGENCE_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.CURRENT_ACOUNT_HIST)) {
			List<SummaryInvestmentsDTO> debts = (List<SummaryInvestmentsDTO>) prepareDataHistoryMap.get(Constants.CURRENT_ACOUNT_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}
		/* revisar DTO */
		/*
		 * if (typeReport != null &&
		 * typeReport.equalsIgnoreCase(Constants.CUSTOMER_LINKED_HIST)) {
		 * List<Object> debts = (List<Object>)
		 * prepareDataHistoryMap.get(Constants.CUSTOMER_LINKED_HIST);
		 * beanColDataSource = new JRBeanCollectionDataSource(debts); }
		 */
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.DEBIT_CARD_HIST)) {
			List<SummaryOtherDTO> debts = (List<SummaryOtherDTO>) prepareDataHistoryMap.get(Constants.DEBIT_CARD_HIST);
			for (SummaryOtherDTO debt : debts) {
				logger.logDebug("report debts --> date" + debt.getDateVTCRegistry());
				logger.logDebug("report debts -->" + debt.toString());
			}
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}
		/*
		 * if (typeReport != null &&
		 * typeReport.equalsIgnoreCase(Constants.DEBT_SOURCE_HIST)) { Object
		 * debts = (Object)
		 * prepareDataHistoryMap.get(Constants.DEBT_SOURCE_HIST); List<Object>
		 * sumary = new ArrayList<Object>(); sumary.add(debts);
		 * beanColDataSource = new JRBeanCollectionDataSource(sumary); }
		 */
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.FIXED_TERMS_HIST)) {
			List<SummaryInvestmentsDTO> debts = (List<SummaryInvestmentsDTO>) prepareDataHistoryMap.get(Constants.FIXED_TERMS_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.INDIRECT_PORT_HIST)) {
			List<DebtTmpDTO> debts = (List<DebtTmpDTO>) prepareDataHistoryMap.get(Constants.INDIRECT_PORT_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		// Fie no tiene sobregiros
		/*
		 * if(typeReport != null &&
		 * typeReport.equalsIgnoreCase(Constants.OVERDRAFTS_HIST)){
		 * List<SummaryDebtsDTO> debts = (List<SummaryDebtsDTO>)
		 * prepareDataHistoryMap.get(Constants.OVERDRAFTS_HIST);
		 * beanColDataSource = new JRBeanCollectionDataSource(debts); }
		 */
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.PRODUCT_OTHER_COMEX_HIST)) {
			List<SummaryOtherDTO> debts = (List<SummaryOtherDTO>) prepareDataHistoryMap.get(Constants.PRODUCT_OTHER_COMEX_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.PROMISORY_NOTES_HIST)) {
			List<OwnWarrantyTmpDTO> debts = (List<OwnWarrantyTmpDTO>) prepareDataHistoryMap.get(Constants.PROMISORY_NOTES_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}

		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.SAVING_ACOUNTE_HIST)) {
			List<SummaryInvestmentsDTO> debts = (List<SummaryInvestmentsDTO>) prepareDataHistoryMap.get(Constants.SAVING_ACOUNTE_HIST);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
		}
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.DEBT_REQUESTREJECT)) {
			logger.logDebug("Inicio RequestRejected" );
			List<RequestRejectedTmpDTO> debts = (List<RequestRejectedTmpDTO>) prepareDataHistoryMap.get(Constants.DEBT_REQUESTREJECT);
			beanColDataSource = new JRBeanCollectionDataSource(debts);
			logger.logDebug("Fin RequestRejected" + debts.toString());
		}
		return beanColDataSource;

	}

	public static String getDirectory() {
		return COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE) + Constants.DIR_JASPER;

	}

}
