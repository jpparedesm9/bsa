package com.cobiscorp.ecobis.fpm.operation.service.impl;

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
import com.cobiscorp.ecobis.fpm.bo.AccountingProfileLog;
import com.cobiscorp.ecobis.fpm.model.AccountingProfile;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileId;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IAccountingProfileManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class AccountingProfileManagerTest {

	
	@Autowired
	private IAccountingProfileManager service;
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
	public void testCreateAccountingProfile() {
		AccountingProfile accounting = new AccountingProfile();
		accounting.setFilialId(1);
		accounting.setProductId("ML");
		accounting.setProfileId("P1");
		accounting.setTransactionTypeId("T");
		service.insertAccountingProfile(accounting);
		List<AccountingProfile> profiles = service.findAllAccountingProfile(new AccountingProfileId("ML", null, null));
		Assert.assertSame(false, profiles.isEmpty());
	}

	//@Test
	public void testCreateAccountingProfileHistory() {
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.DATE, 1);
//		Date sytemDate = cal.getTime();
//		
//		BankingProductHistory bankingProductHistory = new BankingProductHistory(5000);
//		
//		bankingProductService.createBankingProductHistory(bankingProductHistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
//		BankingProductHistory historyId = new BankingProductHistory();
//		historyId.setProductId("ML");
//		historyId.setSystemDateId(sytemDate);
//		service.createAccountingProfileHistory(historyId, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
//		List<AccountingProfileHistory> acph = service
//				.findAccountingProfileHistory(historyId);
//		Assert.assertNotSame(0, acph.size());
	}
	
	
	//@Test
	public void testRestoreAccountingProfileFromHistory(){
		//bankingProductService.getLatestHistorical("ML");
//		service.restoreAccountingProfileFromHistory("ML");
//		AccountingProfileId accPId=new AccountingProfileId();
//		accPId.setProductId("ML");
//		List<AccountingProfile> acplist=service.findAllAccountingProfile(accPId);
//		Assert.assertNotSame(0,acplist.size());
		
		
		
	}
	
	
	

	@Test
	public void testGetAccountingProfileChanges() {
		Map<String, List<AccountingProfileLog>> result = service
				.getAccountingProfileChanges("ML");
		Assert.assertSame(true, result.containsKey(Constants.AFTER_VALUE));
		Assert.assertSame(true, result.containsKey(Constants.BEFORE_VALUE));
	}

}
