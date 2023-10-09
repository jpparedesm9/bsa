package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.cobiscorp.ecobis.fpm.bo.ItemStatusLog;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.ItemStatus;
import com.cobiscorp.ecobis.fpm.model.ItemStatusHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IItemStatusManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class ItemStausManagerTest {

	@Autowired
	private IItemStatusManager service;
	@Autowired
	private IBankingProductManager bankingProductService;

	@Before
	public void init() throws Exception {
		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Test
	public void testCreateItemStatus() {
		ItemStatus itemStatus = new ItemStatus();

		itemStatus.setItemId(3000);
		itemStatus.setProductId("ML");
		
		
		itemStatus.setStatusId(8);
		itemStatus.setStartdays(34);
		itemStatus.setFinishdays(98);
		service.insertItemStatus(itemStatus);
	}

	@Test
	public void testCreateItemStatusHistory() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 2);
		Date sytemDate = cal.getTime();
try{

		BankingProductHistory bankingProductHistory = new BankingProductHistory();
		//bankingProductHistory.setId(5000);
		bankingProductHistory.setProductId("ML");
		bankingProductHistory.setSystemDateId(new Date());
		bankingProductHistory.setProcessDate(new Date());


		Long id = bankingProductService.createBankingProductHistory(
				bankingProductHistory,
				Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);

	
		
		BankingProductHistory history=new BankingProductHistory();
		history=bankingProductService.getLatestHistorical("ML");
		
		System.out.println("ULTIMO"+history.getId());
		
		service.createItemStatusHistory(history,Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
		
//		BankingProductHistory history2=new BankingProductHistory();
//		history2=bankingProductService.getLatestHistorical("ML");
		
		List<ItemStatusHistory> acph = service.findItemStatusHistory(history.getId());
		Assert.assertNotSame(0, acph.size());
		System.out.println("CREACION" + acph );
		
		
}catch (Exception e) {
	// TODO: handle exception
	e.printStackTrace();
}
	}

	@Test
	public void testRestoreItemStatusFromHistory() {
		service.restoreItemStatusManagerFromHistory("ML");
		ItemStatus item = new ItemStatus();
		item.setProductId("ML");
//		List<ItemStatus> itemlist = service.findItemStatus(item);
//		Assert.assertNotSame(0, itemlist.size());

	}

	// @Test
	public void testGetItemStatusChanges() {
		Map<String, List<ItemStatusLog>> result = service
				.getItemStatusChanges("ML");
		Assert.assertSame(true, result.containsKey(Constants.AFTER_VALUE));
		Assert.assertSame(true, result.containsKey(Constants.BEFORE_VALUE));
	}

}
