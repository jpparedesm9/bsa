package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemPortfolioManager;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })


public class ItemPortFolioManagerTest {

	//@Test
	public void test() {
		fail("Not yet implemented");
	}
	
	@Autowired
	@Qualifier("itemPortfolioManager")
	private IItemPortfolioManager itemsporfolio;
	@Test
	public void insertItemsPortfolio(){
		
		try{
			
			ItemsPortfolio item=new ItemsPortfolio();
			item.setOperation("NEW-HPOT");
			item.setCurrency(0);
			item.setConcept("FECI");
			item.setPriority(0);
			item.setItemType("V");
			item.setRu_paga_mora("N");
			item.setProvision("S");
			item.setfPayment("P");
			item.setAlwaysCreate("S");
			item.settPeriod(null);
			item.setReference("FECI");
			item.setChangeRate(null);
			item.setBank("G");
			item.setState("V");
			item.setConceptAssociated(null);
			item.setMaxValue(0);
			item.setMinValue(0);
			item.setDefer("N");
			item.setSecureType(null);
			item.setEffectiveRate(null);
			itemsporfolio.manageItemsPortfolio("INSERT", item);
			//itemsporfolio 
			
			
		}catch (Exception e) {
			
			System.out.println(e.getMessage());
			
		}
		
	}
	
/**
 * MODIFICAR OPERACION
 */
	@Autowired
	@Qualifier("itemPortfolioManager")
	private IItemPortfolioManager updateItemsPortfolio;
	@Test
	public void updateItemsPortfolio(){
		
		try{
			
			ItemsPortfolio item=new ItemsPortfolio();
			item.setOperation("NEW-HPOT");
			item.setCurrency(0);
			item.setConcept("FECI");
			item.setPriority(0);
			item.setItemType("V");
			item.setRu_paga_mora("N");
			item.setProvision("S");
			item.setfPayment("P");
			item.setAlwaysCreate("S");
			item.settPeriod(null);
			item.setReference("FECI");
			item.setChangeRate(null);
			item.setBank("G");
			item.setState("V");
			item.setConceptAssociated(null);
			item.setMaxValue(0);
			item.setMinValue(0);
			item.setDefer("S");
			item.setSecureType(null);
			item.setEffectiveRate(null);
			updateItemsPortfolio.manageItemsPortfolio("UPDATE", item);
			//itemsporfolio 
			
			
		}catch (Exception e) {
			
			System.out.println(e.getMessage());
			
		}
		
	}

	
	/**
	 * ELIMINAR OPERACION
	 */
	
	@Autowired
	@Qualifier("itemPortfolioManager")
	private IItemPortfolioManager deleteItemsPortfolio;
	@Test
	public void deleteItemsPortfolio(){
		
		try{
			
			ItemsPortfolio item=new ItemsPortfolio();
			item.setOperation("NEW-HPOT");
			item.setCurrency(0);
			item.setConcept("FECI");

			deleteItemsPortfolio.manageItemsPortfolio("DELETE", item);
			//itemsporfolio 
			
			
		}catch (Exception e) {
			
			System.out.println(e.getMessage());
			
		}
		
	}

	
	
	

}
