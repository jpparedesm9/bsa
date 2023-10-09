/*
 * File: PortfolioAccountingProfileManager.java
 * Date: April 23, 2012
 *
 * This application is part of banking packages owned by COBISCORP. 
 * Unauthorized use is prohibited as well as any alteration or 
 * addition made by any of its users without due due COBISCORP 
 * written consent.
 * This program is protected by copyright law and by international 
 * intellectual property conventions. Its unauthorized use COBISCORP 
 * right to give orders for retention and to prosecute those 
 * responsible for any breach.
 */

package com.cobiscorp.ecobis.fpm.portfolio.integration.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.AccountingProfile;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileId;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IAccountingProfileManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioAccountingProfileManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.TranOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.ITranOperationManager;

/**
 * Implementation for the integration services in the accounting profile
 * operations
 * 
 * @author bron
 */
public class PortfolioAccountingProfileManager implements
		IPortfolioAccountingProfileManager {

	private IAccountingProfileManager accountingProfileService;
	private ITranOperationManager trnOperationService;
	private IBankingProductHistoryManager bankingProductHistoryService;
	

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioAccountingProfileManager.class);

	/**
	 * Replicate data to ca_trn_oper
	 */
	public void createAccountingProfileHistory(
			Long bankingProductHistoryId) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOACCOUNTINGPROFILEMANAGER.001",
					"createAccountingProfileHistory"));

			BankingProductHistory bankingProductHistory=new BankingProductHistory();
			
			bankingProductHistory=bankingProductHistoryService.getBankingProductHistoryById(bankingProductHistoryId);
			// Get all data of accountingprofiles
			List<AccountingProfile> accProfileList = accountingProfileService
					.findAllAccountingProfile(new AccountingProfileId(
							bankingProductHistory.getProductId(), null, null));

			List<TranOperation> trnOperationList = new ArrayList<TranOperation>();

			for (AccountingProfile accProfile : accProfileList) {

				TranOperation trnOper = new TranOperation();
				trnOper.setOperation(accProfile.getProductId());
				trnOper.setType(accProfile.getTransactionTypeId());
				trnOper.setFilial(accProfile.getFilialId());
				trnOper.setProfile(accProfile.getProfileId());

				trnOperationList.add(trnOper);
			}

			this.trnOperationService.insertTranOperation(trnOperationList);

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PORTFOLIOACCOUNTINGPROFILEMANAGER.003"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOACCOUNTINGPROFILEMANAGER.002",
					"createAccountingProfileHistory"));
		}

	}

	/**
	 * @param accountingProfileService
	 *            the accountingProfileService to set
	 */
	public void setAccountingProfileService(
			IAccountingProfileManager accountingProfileService) {
		this.accountingProfileService = accountingProfileService;
	}

	/**
	 * @param trnOperationService
	 *            the trnOperationService to set
	 */
	public void setTrnOperationService(ITranOperationManager trnOperationService) {
		this.trnOperationService = trnOperationService;
	}

	public void setBankingProductHistoryService(
			IBankingProductHistoryManager bankingProductHistoryService) {
		this.bankingProductHistoryService = bankingProductHistoryService;
	}
	
	

	

}
