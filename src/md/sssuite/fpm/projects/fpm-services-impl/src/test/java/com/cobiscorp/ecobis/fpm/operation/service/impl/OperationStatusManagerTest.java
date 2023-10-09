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
import com.cobiscorp.ecobis.fpm.bo.OperationStatusLog;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.OperationStatus;
import com.cobiscorp.ecobis.fpm.model.OperationStatusHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IOperationStatusManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class OperationStatusManagerTest {

	@Autowired
	private IOperationStatusManager service;
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
	public void testCreateOperation() {
		OperationStatus operationStatus = new OperationStatus();
		operationStatus.setChangeType("D");
		operationStatus.setFinalStatusId(1);
		operationStatus.setFinishDays(23);
		operationStatus.setInitialStatusId(2);
		operationStatus.setProductId("ML");
		operationStatus.setStartDays(2);
		service.insertOperationChangeStatus(operationStatus);
	}

	@Test
	public void testCreateOperationStatusHistory() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 3);
		Date sytemDate = cal.getTime();
		
		
		
		BankingProductHistory bankingProductHistory = new BankingProductHistory();
//		bankingProductHistory.setProductId("ML");
//		bankingProductHistory.setId(5000);
		bankingProductHistory=bankingProductService.getLatestHistorical("ML");
		
		Long id = bankingProductService.createBankingProductHistory(bankingProductHistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
		BankingProductHistory history2 = new BankingProductHistory();
		history2=bankingProductService.getLatestHistorical("ML");
//		historyId.setProductId("ML");
//		historyId.setSystemDateId(sytemDate);
		service.createOperationStatusHistory(history2, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
		List<OperationStatusHistory> acph = service
				.findOperationChangeStatusHistory(history2.getId());
		Assert.assertNotSame(0, acph.size());
		
		
		
	}

	
	@Test
	public void testRestoreOperationFromHistory(){
		
		service.restoreOperationStatusFromHistory("ML");
		OperationStatus operationStatus=new OperationStatus();
		operationStatus.setProductId("ML");
		List<OperationStatus> operationStatusList=service.findOperationChangeStatus(operationStatus);
		Assert.assertNotSame(0, operationStatusList.size());
	}
	
	@Test
	public void testGetOperationStatusChanges() {
		Map<String, List<OperationStatusLog>> result = service
				.getOperationStatusChanges("ML");
		Assert.assertSame(true, result.containsKey(Constants.AFTER_VALUE));
		Assert.assertSame(true, result.containsKey(Constants.BEFORE_VALUE));
	}

}
