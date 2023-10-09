package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public class DebtorUtil {
	private static ILogger logger = LogFactory.getLogger(DebtorUtil.class);

	public static DataEntity getDebtorEntity(DataEntityList debtors, ICommonEventArgs args, BehaviorOption options) {
		for (DataEntity dataEntity : debtors) {
			logger.logDebug("---->Debtor: " + dataEntity.get(DebtorGeneral.CUSTOMERNAME) + ", Tipo:" + dataEntity.get(DebtorGeneral.ROLE));
			if (Mnemonic.DEBTOR_GRUPAL.equals(dataEntity.get(DebtorGeneral.ROLE)) || Mnemonic.DEBTOR.equals(dataEntity.get(DebtorGeneral.ROLE))) {
				return dataEntity;
			}
		}
		if (options.showMessage())
			logger.logDebug("---->getDebtorEntity showMessage");
		args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_SAOUCENTD_07389");
		if (options.isSuccessFalse())
			args.setSuccess(false);
		return null;
	}

	public static DebtorResponse getDebtorDTO(DebtorResponse[] debtors, ICommonEventArgs args, BehaviorOption options) {
		for (DebtorResponse debtorResponse : debtors) {
			logger.logDebug("---->DebtorResponse: " + debtorResponse.getDebtorName() + ", Tipo:" + debtorResponse.getRole());
			if (Mnemonic.DEBTOR_GRUPAL.equals(debtorResponse.getRole()) || Mnemonic.DEBTOR.equals(debtorResponse.getRole())) {
				return debtorResponse;
			}
		}
		if (options.showMessage())
			args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_SAOUCENTD_07389");
		if (options.isSuccessFalse())
			args.setSuccess(false);
		return null;
	}
}
