/*
 * File: PurposePortfolioManager.java
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

package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.fpm.portfolio.model.PurposeType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IPurposePortfolioManager;

public class PurposePortfolioManager implements IPurposePortfolioManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PurposePortfolioManager.class);

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	
	public void insertPurposeType(List<PurposeType> destinationList) {
		// TODO Auto-generated method stub
		
	}


}
