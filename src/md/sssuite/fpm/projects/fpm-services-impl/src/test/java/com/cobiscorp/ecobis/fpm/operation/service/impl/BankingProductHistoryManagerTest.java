package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
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
import com.cobiscorp.ecobis.fpm.bo.BankingProductLog;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class BankingProductHistoryManagerTest {

	@Autowired
	private IBankingProductHistoryManager service;
	@Autowired
	private IBankingProductManager bankingProductService;

	@Before
	public void init() throws Exception {
		String id = "154654614365";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Test
	public void testFindAllBankingProductHistorical() {
		List<BankingProductHistory> historical = service
				.findAllBankingProductHistorical("ML");
		System.out.println(historical);
		Assert.assertSame(false, historical.isEmpty());
	}

	
	@Test
	public void testFindBankingProductHistoricalByStatus()
			throws ParseException {

		Date operationDate = new SimpleDateFormat("MM/dd/yyyy")
				.parse("02/16/2012 00:00:00.0");
		// 23/07/2012 0:00:00
		List<BankingProductHistory> historical = service
				.findBankingProductHistoricalByStatus("ML", "A",
						"16/02/2012 00:00:00.0", "dd/MM/yyyy HH:mm:ss");
		System.out.println(historical);
		Assert.assertSame(false, historical.isEmpty());

	}

	@Test
	public void testFindProcessDateByProductAndStatus() {
		List<Date> historical = service.findHistoricalProcessDateBySatus("ML",
				"A");
		System.out.println(historical);
		Assert.assertNotNull(historical);
	}

	@Test
	public void testGetHistoricalLog() {
		List<BankingProductHistory> histories = service
				.findAllBankingProductHistorical("ML");
		Assert.assertSame(histories.isEmpty(), false);
		BankingProductLog log = service.getHistoricalLog(histories.get(0));
		Assert.assertNotNull(log);
	}
}
