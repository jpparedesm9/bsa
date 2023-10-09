package com.cobiscorp.cobis.busin.customevents.bli;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ItemsBLI {

	private static final ILogger LOGGER = LogFactory.getLogger(ItemsBLI.class);

	public ItemsBLI() {
	}

	public static void read(DynamicRequest entities, ICommonEventArgs arg1, String numeroOperacion, ICTSServiceIntegration iServiceIntegration) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso readItems");
		try {

			ReadLoanItemsRequest itemsRequest = new ReadLoanItemsRequest();
			itemsRequest.setBank(numeroOperacion);
			itemsRequest.setOperation('S');

			TransactionManagement tranManager = new TransactionManagement(iServiceIntegration);
			ReadLoanItemsResponse[] listItemsResponse = tranManager.getItems(itemsRequest, arg1, new BehaviorOption(true));

			if (listItemsResponse != null && listItemsResponse.length != 0) {

				DataEntityList items = new DataEntityList();
				for (ReadLoanItemsResponse iteratorItem : listItemsResponse) {
					DataEntity eLoanItems = new DataEntity();

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logInfo("1....CONCEPT ....................." + iteratorItem.getConcept());
						LOGGER.logInfo("2....CONCEPTDESCRIPTION .........." + iteratorItem.getDescConcept());
						LOGGER.logInfo("3....CONCEPTTYPE ................." + iteratorItem.getConceptType());
						LOGGER.logInfo("4....CONCEPTTYPEDESCRIPTION ......" + iteratorItem.getConceptTypeDescription());
						LOGGER.logInfo("5....METHODOFPAYMENT ............." + iteratorItem.getMethodOfPayment());
						LOGGER.logInfo("6....PAYMENTFORMDESCRIPTION ......" + iteratorItem.getPaymentFormDescription());
						LOGGER.logInfo("7....SIGN ........................" + iteratorItem.getSign());
						LOGGER.logInfo("8....FACTOR ......................" + iteratorItem.getFactor());
						LOGGER.logInfo("9....REFERENCE ..................." + iteratorItem.getReference());
						LOGGER.logInfo("10...PERCENTAGE .................." + iteratorItem.getPercentage());
						LOGGER.logInfo("11...VALUE .     ................." + iteratorItem.getValue().toString());
					}

					eLoanItems.set(Category.CONCEPT, iteratorItem.getConcept());
					eLoanItems.set(Category.CONCEPTDESCRIPTION, iteratorItem.getDescConcept());
					eLoanItems.set(Category.CONCEPTTYPE, iteratorItem.getConceptType() == null ? null : String.valueOf(iteratorItem.getConceptType()));
					eLoanItems.set(Category.CONCEPTTYPEDESCRIPTION, iteratorItem.getConceptTypeDescription());
					eLoanItems.set(Category.METHODOFPAYMENT, iteratorItem.getMethodOfPayment());
					eLoanItems.set(Category.PAYMENTFORMDESCRIPTION, iteratorItem.getPaymentFormDescription());
					eLoanItems.set(Category.SIGN, iteratorItem.getSign());
					eLoanItems.set(Category.FACTOR, iteratorItem.getFactor());
					eLoanItems.set(Category.REFERENCE, iteratorItem.getReference());
					eLoanItems.set(Category.PERCENTAGE, iteratorItem.getPercentage());
					eLoanItems.set(Category.VALUE, iteratorItem.getValue());

					items.add(eLoanItems);
				}
				entities.setEntityList(Category.ENTITY_NAME, items);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_BLI_ITEMS, e, arg1, LOGGER);
		}
	}

}
