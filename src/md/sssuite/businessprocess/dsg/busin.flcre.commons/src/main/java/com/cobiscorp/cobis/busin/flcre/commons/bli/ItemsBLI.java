package com.cobiscorp.cobis.busin.flcre.commons.bli;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.MessageLevel;

public class ItemsBLI {

	private static final ILogger logger = LogFactory.getLogger(ItemsBLI.class);

	public ItemsBLI() {
	}

	public static void read(DynamicRequest entities, ICommonEventArgs arg1, String numeroOperacion, ICTSServiceIntegration iServiceIntegration) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso readItems");
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

					eLoanItems.set(Category.CONCEPT, iteratorItem.getConcept());
					eLoanItems.set(Category.CONCEPTTYPE, iteratorItem.getConceptType() == null ? null : String.valueOf(iteratorItem.getConceptType()));
					eLoanItems.set(Category.METHODOFPAYMENT, iteratorItem.getMethodOfPayment());
					eLoanItems.set(Category.SIGN, iteratorItem.getSign());
					eLoanItems.set(Category.FACTOR, iteratorItem.getFactor());
					eLoanItems.set(Category.REFERENCE, iteratorItem.getReference());
					eLoanItems.set(Category.PERCENTAGE, iteratorItem.getPercentage());
					items.add(eLoanItems);
				}
				entities.setEntityList(Category.ENTITY_NAME, items);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("ERROR EN TRAER RUBROS:", e);
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
			arg1.setSuccess(false);
		}
	}

}
