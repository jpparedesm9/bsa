package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.fpm.bo.CatalogConstraintLog;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.EconomicDestination;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicDestinationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class EconomicDestinationManagerTest {
	@Autowired
	private IEconomicDestinationManager service;

	@Before
	public void init() throws Exception {
		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Test
	public void testGetDestination() {
		List<EconomicDestination> list = service.getEconomicDestinations("ML");
		Assert.assertNotNull(list);
	}

	//@Test
	public void testManageDestination() {
		EconomicDestination destination = new EconomicDestination();
		destination.setCode("123");
		destination.setBankingProduct(new BankingProduct("ML", "Mortage Loan"));
		long id = service.createEconomicDestination(destination);
		destination.setId(id);
		List<EconomicDestination> destinations = service
				.getEconomicDestinations("ML");
		Assert.assertNotSame(destinations.isEmpty(), true);
		// Delete
		service.deleteEconomicDestination(id);
		destinations = service.getEconomicDestinations("ML");
		Assert.assertSame(destinations.isEmpty(), true);
	}

	@Test
	public void testManageHistoricalInformation() {
		// Create the object
		EconomicDestination destination = new EconomicDestination();
		destination.setCode("123");
		destination.setBankingProduct(new BankingProduct("ML", "Mortage Loan"));
		long id = service.createEconomicDestination(destination);
		List<EconomicDestination> destinations = service
				.getEconomicDestinations("ML");
		Assert.assertNotSame(destinations.isEmpty(), true);
		// Create the historical
//		BankingProductHistoryId historyId = new BankingProductHistoryId(
//				new Date(), "ML");
		BankingProductHistory historyId = new BankingProductHistory();
		historyId.setId(1001);
		historyId.setSystemDateId(new Date());
		historyId.setProductId("ML");
		
		service.createEconomicDestinationHistory(historyId,
				Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
				
		// Delete
		service.deleteEconomicDestination(id);
		destinations = service.getEconomicDestinations("ML");
		Assert.assertSame(destinations.isEmpty(), true);
		// Restore from historical
		service.restoreEconomicDestinationFromHistory(historyId.getId());
		destinations = service.getEconomicDestinations("ML");
		Assert.assertNotSame(destinations.isEmpty(), true);
		
	}

	@Test
	public void testCheckConfigurationComplete() {
		EconomicDestination destination = new EconomicDestination();
		destination.setCode("123");
		destination.setBankingProduct(new BankingProduct("ML", "Mortage Loan"));
		service.createEconomicDestination(destination);
		Assert.assertTrue(service
				.checkEconomicDestinationConfigurationComplete("ML"));
	}

	@Test
	public void testGetEconomicDestinationChanges() {
		Map<String, List<CatalogConstraintLog>> changes = service.getEconomicDestinationChanges("ML");
		Assert.assertTrue(changes.containsKey(Constants.AFTER_VALUE));
		Assert.assertTrue(changes.containsKey(Constants.BEFORE_VALUE));
	}
}
