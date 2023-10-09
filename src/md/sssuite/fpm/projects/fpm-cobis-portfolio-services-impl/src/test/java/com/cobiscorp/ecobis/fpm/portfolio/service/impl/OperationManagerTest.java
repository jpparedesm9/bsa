package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })

public class OperationManagerTest {

	//@Test
	public void test() {
		fail("Not yet implemented");
	}
	

	@Autowired
	@Qualifier("defaultOperationManager")
	private IDefaultOperationManager defaultOperation;
	@Test
	public void createOperation(){
		
		DefaultOperation operation=new DefaultOperation();
		operation.setOperation("NEW-HPOT");
		operation.setCurrency(0);
		operation.setChange("N");
		operation.setChangePeriod(0);
		operation.setSpecialChange(null);
		operation.setRenew("N");
		operation.setType("N");
		operation.setState(null);
		operation.setPrePayment("N");
		operation.setCompleteQuota("N");
		operation.setChargeType("A");
		operation.setReductionType("N");
		
		operation.setAceptAdvances("N");
		operation.settTerm("ANUAL");
		operation.setApplicationType("D");
		operation.setTerm(1);
		operation.settDividend("ANUAL");
		operation.setCapPeriod(6);
		operation.setIntPeriod(1);
		operation.setCapGrace(0);
		operation.setIntGrace(0);
		operation.setDistGrace("N");
		operation.setDaysYear(360);
		
		operation.setAmortizationType("ALEMANA");
		operation.setFixedDate("S");
		operation.setDayPayment(20);
		operation.setFixedQuota("S");
		operation.setDaysGrace(0);
		operation.setAvoidHolidays("S");
		operation.setMonth(0);
		operation.setFundsOwns("S");
		operation.setDestination(null);
		operation.setOriginFunds("PROPIOS");
		operation.setQuotaThrid(null);
		operation.setSectionAccountant(null);
		operation.setClabas(null);
		operation.setClabope(null);
		operation.setQuotaLess("N");
		operation.setPrdCobis(0);
		operation.setCalculationBase("C");
		operation.setCurrencyAdjustment("N");
		//operation.setAdjustmentCurrency(0);
		operation.setAccountingPeriod("A-PLAZO");
		operation.setFamily("EMP");
		operation.setPriorityType("N");
		operation.setDayPayment(0);
		operation.setSubsidy("S");
		operation.settPreference("S");
		operation.setGroupReport("04");
		operation.setModeReest("1");
		operation.setPaymentEffect("M");
		//operation.
		defaultOperation.manageDefaultOperation("INSERT", operation);
		
		
		
	}
	
	
	
	@Autowired
	@Qualifier("defaultOperationManager")
	private IDefaultOperationManager updatedefaultOperation;
	@Test
	public void UpdateDefaultOperationTest(){
		
		
		DefaultOperation operation=new DefaultOperation();
		operation.setOperation("NEW-HPOT");
		operation.setCurrency(0);
		operation.setChange("N");
		operation.setChangePeriod(0);
		operation.setSpecialChange(null);
		operation.setRenew("N");
		operation.setType("N");
		operation.setState(null);
		operation.setPrePayment("N");
		operation.setCompleteQuota("N");
		operation.setChargeType("A");
		operation.setReductionType("N");
		
		operation.setAceptAdvances("N");
		operation.settTerm("ANUAL");
		operation.setApplicationType("D");
		operation.setTerm(1);
		operation.settDividend("ANUAL");
		operation.setCapPeriod(6);
		operation.setIntPeriod(1);
		operation.setCapGrace(0);
		operation.setIntGrace(0);
		operation.setDistGrace("N");
		operation.setDaysYear(360);
		
		operation.setAmortizationType("ALEMANA");
		operation.setFixedDate("S");
		operation.setDayPayment(20);
		operation.setFixedQuota("S");
		operation.setDaysGrace(0);
		operation.setAvoidHolidays("S");
		operation.setMonth(0);
		operation.setFundsOwns("S");
		operation.setDestination(null);
		operation.setOriginFunds("PROPIOS");
		operation.setQuotaThrid(null);
		operation.setSectionAccountant(null);
		operation.setClabas(null);
		operation.setClabope(null);
		operation.setQuotaLess("N");
		operation.setPrdCobis(0);
		operation.setCalculationBase("C");
		operation.setCurrencyAdjustment("N");
		//operation.setAdjustmentCurrency(0);
		operation.setAccountingPeriod("A-PLAZO");
		operation.setFamily("PER");
		operation.setPriorityType("N");
		operation.setDayPayment(0);
		operation.setSubsidy("S");
		operation.settPreference("S");
		operation.setGroupReport("04");
		operation.setModeReest("1");
		operation.setPaymentEffect("M");
		//operation.
		updatedefaultOperation.manageDefaultOperation("UPDATE", operation);
		
		
		
		
		
		
	}
	
	
	
	
	
	@Autowired
	@Qualifier("defaultOperationManager")
	private IDefaultOperationManager deletedefaultOperation;
	@Test
	public void deleteOperationTest(){
		
		try{
		DefaultOperation operation=new DefaultOperation();
		operation.setOperation("NEW-HPOT");
		deletedefaultOperation.manageDefaultOperation("DELETE", operation);
		
		
		
		}catch (Exception e) {
			
			System.out.println("ERROR"+e.getMessage());
		}
		
		
	}
	

}
