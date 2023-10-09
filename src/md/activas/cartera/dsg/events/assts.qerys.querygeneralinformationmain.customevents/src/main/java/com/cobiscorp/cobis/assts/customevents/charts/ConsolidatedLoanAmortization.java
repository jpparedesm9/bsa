package com.cobiscorp.cobis.assts.customevents.charts;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Amortization;
import com.cobiscorp.cobis.assts.model.ConsolidatedLoanStatus;
import com.cobiscorp.cobis.assts.model.ItemsLoan;
import com.cobiscorp.cobis.assts.model.SummaryLoanStatus;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.common.BaseEvent;

public class ConsolidatedLoanAmortization extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(ConsolidatedLoanAmortization.class);

	public ConsolidatedLoanAmortization(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void consolidateLoanStatus(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia consolidateLoanStatus");
		}
		try {
			DataEntityList consolidateLoanList = entities
					.getEntityList(ConsolidatedLoanStatus.ENTITY_NAME);
			DataEntityList arrearList = entities
					.getEntityList(ItemsLoan.ENTITY_NAME);

			DataEntity cancelConsolidated = new DataEntity();
			this.loadDefaultData(cancelConsolidated,
					"ASSTS.LBL_ASSTS_CANCELADD_36478");

			DataEntity expiredConsolidated = new DataEntity();
			this.loadDefaultData(expiredConsolidated,
					"ASSTS.LBL_ASSTS_VENCIDASS_52104");

			DataEntity dueExpireConsolidated = new DataEntity();
			this.loadDefaultData(dueExpireConsolidated,
					"ASSTS.LBL_ASSTS_PORVENCER_21871");

			//DataEntityList consolidated = new DataEntityList();
			for (DataEntity consolidated : consolidateLoanList) {

				String statusStr = "";
				if (consolidated.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS) != null) {
					statusStr = consolidated.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS).trim()
							.replaceAll(" ", "_");
				}
				if (logger.isDebugEnabled()) {
					logger.logDebug("statusStr:" + statusStr);
				}
				
				Parameter.AMORTIZATION_STATUS status = Parameter.AMORTIZATION_STATUS
						.getValue(statusStr);
				if (logger.isDebugEnabled()) {
					logger.logDebug("status:" + statusStr);
				}  
				
				switch (status) {
				case CANCELADO:
					this.setConsolidateForStatus(consolidated, arrearList,
							cancelConsolidated);
					break;
				case VENCIDO:
					this.setConsolidateForStatus(consolidated, arrearList,
							expiredConsolidated);
					break;
				case VIGENTE:
				case NO_VIGENTE:
					this.setConsolidateForStatus(consolidated, arrearList,
							dueExpireConsolidated);
					break;
				default:
					break;
				}
			}

			this.setTotal(cancelConsolidated);
			this.setTotal(expiredConsolidated);
			this.setTotal(dueExpireConsolidated);

			//consolidated.add(cancelConsolidated);
			//consolidated.add(expiredConsolidated);
			//consolidated.add(dueExpireConsolidated);

			//entities.setEntityList(ConsolidatedLoanStatus.ENTITY_NAME,
			//		consolidated);

			this.setSummary(entities, cancelConsolidated, expiredConsolidated,
					dueExpireConsolidated);

		} catch (Exception ex) {
			logger.logError(ex);
			this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza consolidateLoanStatus");
			}
		}
	}

	private void loadDefaultData(DataEntity consolidated, String statusLabel) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia loadDataDefault");
		}
		consolidated
				.set(ConsolidatedLoanStatus.AMORTIZATIONSTATUS, statusLabel);
		consolidated.set(ConsolidatedLoanStatus.NUMBERPAYMENTS, 0);
		consolidated.set(ConsolidatedLoanStatus.CAPITAL,
				BigDecimal.valueOf(0.00));
		consolidated.set(ConsolidatedLoanStatus.INTEREST,
				BigDecimal.valueOf(0.00));
		consolidated.set(ConsolidatedLoanStatus.ARREAR,
				BigDecimal.valueOf(0.00));
		consolidated.set(ConsolidatedLoanStatus.INTERESTARREAR,
				BigDecimal.valueOf(0.00));
		consolidated.set(ConsolidatedLoanStatus.OTHERITEMS,
				BigDecimal.valueOf(0.00));
		consolidated
				.set(ConsolidatedLoanStatus.TOTAL, BigDecimal.valueOf(0.00));

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza loadDataDefault");
		}

	}

	private void setTotal(DataEntity consolidated) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia setTotal");
		}
		BigDecimal total = BigDecimal.valueOf(0.0);
		total = total.add(consolidated.get(ConsolidatedLoanStatus.CAPITAL));
		total = total.add(consolidated
				.get(ConsolidatedLoanStatus.INTERESTARREAR));
		total = total.add(consolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
		consolidated.set(ConsolidatedLoanStatus.TOTAL, total);

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza setTotal");
		}
	}

	private void setConsolidateForStatus(DataEntity consolidatedIn,
			DataEntityList arrearList, DataEntity consolidated) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia setConsolidateForStatus");
		}
		//BigDecimal arrearValue = new BigDecimal(0);
		//arrearValue.add(BigDecimal.valueOf(0));
		
		consolidated.set(ConsolidatedLoanStatus.CAPITAL, consolidatedIn.get(ConsolidatedLoanStatus.CAPITAL));
		consolidated.set(ConsolidatedLoanStatus.INTEREST, consolidatedIn.get(ConsolidatedLoanStatus.INTEREST));
		consolidated.set(ConsolidatedLoanStatus.INTERESTARREAR, consolidatedIn.get(ConsolidatedLoanStatus.INTERESTARREAR));
		consolidated.set(ConsolidatedLoanStatus.OTHERITEMS , consolidatedIn.get(ConsolidatedLoanStatus.OTHERITEMS));
		consolidated.set(ConsolidatedLoanStatus.TOTAL, consolidatedIn.get(ConsolidatedLoanStatus.TOTAL));

		/*consolidated.set(ConsolidatedLoanStatus.NUMBERPAYMENTS,
				consolidated.get(ConsolidatedLoanStatus.NUMBERPAYMENTS) + 1);

		for (int i = 0; i < arrearList.size(); i++) {
			String itemName = "items" + (i + 1);
			String concept = arrearList.get(i).get(ItemsLoan.CONCEPT).trim();

			arrearValue = amortization.get(new Property<BigDecimal>(itemName,
					BigDecimal.class, false));
			Parameter.ARREARS_CODES conceptCode = Parameter.ARREARS_CODES
					.getValue(concept);

			switch (conceptCode) {
			case CAP:
				consolidated.set(ConsolidatedLoanStatus.CAPITAL, consolidated
						.get(ConsolidatedLoanStatus.CAPITAL).add(arrearValue));
				break;
			case INT:
			case IMO:
				consolidated.set(ConsolidatedLoanStatus.INTERESTARREAR,
						consolidated.get(ConsolidatedLoanStatus.INTERESTARREAR)
								.add(arrearValue));
				break;
			case OTHER:
			default:
				consolidated.set(ConsolidatedLoanStatus.OTHERITEMS,
						consolidated.get(ConsolidatedLoanStatus.OTHERITEMS)
								.add(arrearValue));
				break;
			}
		}*/
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza consolidated CAPITAL:" +  consolidated.get(ConsolidatedLoanStatus.CAPITAL));
			logger.logDebug("Finaliza consolidated INTEREST:" +  consolidated.get(ConsolidatedLoanStatus.INTEREST));
			logger.logDebug("Finaliza consolidated INTERESTARREAR:" +  consolidated.get(ConsolidatedLoanStatus.INTERESTARREAR));
			logger.logDebug("Finaliza consolidated OTHERITEMS:" +  consolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
			logger.logDebug("Finaliza consolidated TOTAL:" +  consolidated.get(ConsolidatedLoanStatus.TOTAL));
			logger.logDebug("Finaliza setConsolidateForStatus");
		}
	}

	private void setSummary(DynamicRequest entities,
			DataEntity cancelConsolidated, DataEntity expiredConsolidated,
			DataEntity dueExpireConsolidated) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia setSummary");
		}

		DataEntityList summaryList = new DataEntityList();
		DataEntity entityExpire = new DataEntity();
		entityExpire.set(SummaryLoanStatus.STATUSAMORTIZATION,
				expiredConsolidated
						.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS));
		entityExpire.set(SummaryLoanStatus.CAPITAL,
				expiredConsolidated.get(ConsolidatedLoanStatus.CAPITAL));
		entityExpire.set(SummaryLoanStatus.INTERESTARREAR,
				expiredConsolidated.get(ConsolidatedLoanStatus.INTERESTARREAR));
		entityExpire.set(SummaryLoanStatus.OTHERITEMS,
				expiredConsolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
		entityExpire.set(SummaryLoanStatus.TOTAL,
				expiredConsolidated.get(ConsolidatedLoanStatus.TOTAL));

		DataEntity entityDueExpire = new DataEntity();
		entityDueExpire.set(SummaryLoanStatus.STATUSAMORTIZATION,
				dueExpireConsolidated
						.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS));
		entityDueExpire.set(SummaryLoanStatus.CAPITAL,
				dueExpireConsolidated.get(ConsolidatedLoanStatus.CAPITAL));
		entityDueExpire.set(SummaryLoanStatus.INTERESTARREAR,
				dueExpireConsolidated
						.get(ConsolidatedLoanStatus.INTERESTARREAR));
		entityDueExpire.set(SummaryLoanStatus.OTHERITEMS,
				dueExpireConsolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
		entityDueExpire.set(SummaryLoanStatus.TOTAL,
				dueExpireConsolidated.get(ConsolidatedLoanStatus.TOTAL));

		DataEntity entityPreCancel = new DataEntity();
		entityPreCancel.set(SummaryLoanStatus.STATUSAMORTIZATION,
				"ASSTS.LBL_ASSTS_PRECANCLR_55986");

		entityPreCancel.set(
				SummaryLoanStatus.CAPITAL,
				expiredConsolidated.get(ConsolidatedLoanStatus.CAPITAL).add(
						dueExpireConsolidated
								.get(ConsolidatedLoanStatus.CAPITAL)));
		entityPreCancel.set(
				SummaryLoanStatus.INTERESTARREAR,
				expiredConsolidated.get(ConsolidatedLoanStatus.INTERESTARREAR)
						.add(dueExpireConsolidated
								.get(ConsolidatedLoanStatus.INTERESTARREAR)));

		entityPreCancel.set(
				SummaryLoanStatus.OTHERITEMS,
				expiredConsolidated.get(ConsolidatedLoanStatus.OTHERITEMS).add(
						dueExpireConsolidated
								.get(ConsolidatedLoanStatus.OTHERITEMS)));

		entityPreCancel.set(
				SummaryLoanStatus.TOTAL,
				expiredConsolidated.get(ConsolidatedLoanStatus.TOTAL)
						.add(dueExpireConsolidated
								.get(ConsolidatedLoanStatus.TOTAL)));

		DataEntity entityCancel = new DataEntity();
		/*entityCancel.set(SummaryLoanStatus.STATUSAMORTIZATION,
				cancelConsolidated
						.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS));
		entityCancel.set(SummaryLoanStatus.CAPITAL,
				cancelConsolidated.get(ConsolidatedLoanStatus.CAPITAL));
		entityCancel.set(SummaryLoanStatus.INTERESTARREAR,
				cancelConsolidated.get(ConsolidatedLoanStatus.INTERESTARREAR));
		entityCancel.set(SummaryLoanStatus.OTHERITEMS,
				cancelConsolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
		entityCancel.set(SummaryLoanStatus.TOTAL,
				cancelConsolidated.get(ConsolidatedLoanStatus.TOTAL));*/

		/*DataEntity entityOriginalAmount = new DataEntity();
		entityOriginalAmount.set(SummaryLoanStatus.STATUSAMORTIZATION,
				"ASSTS.LBL_ASSTS_MONTOORGI_46642");
		entityOriginalAmount
				.set(SummaryLoanStatus.CAPITAL,
						entityPreCancel.get(ConsolidatedLoanStatus.CAPITAL)
								.add(cancelConsolidated
										.get(ConsolidatedLoanStatus.CAPITAL)));

		entityOriginalAmount.set(
				SummaryLoanStatus.INTERESTARREAR,
				entityPreCancel.get(ConsolidatedLoanStatus.INTERESTARREAR).add(
						cancelConsolidated
								.get(ConsolidatedLoanStatus.INTERESTARREAR)));

		entityOriginalAmount.set(
				SummaryLoanStatus.OTHERITEMS,
				entityPreCancel.get(ConsolidatedLoanStatus.OTHERITEMS).add(
						cancelConsolidated
								.get(ConsolidatedLoanStatus.OTHERITEMS)));

		entityOriginalAmount.set(
				SummaryLoanStatus.TOTAL,
				entityPreCancel.get(ConsolidatedLoanStatus.TOTAL).add(
						cancelConsolidated.get(ConsolidatedLoanStatus.TOTAL)));*/

		summaryList.add(entityExpire);
		summaryList.add(entityDueExpire);
		summaryList.add(entityPreCancel);
		//summaryList.add(entityCancel);
		//summaryList.add(entityOriginalAmount);

		entities.setEntityList(SummaryLoanStatus.ENTITY_NAME, summaryList);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza setSummary");
		}
	}
}
