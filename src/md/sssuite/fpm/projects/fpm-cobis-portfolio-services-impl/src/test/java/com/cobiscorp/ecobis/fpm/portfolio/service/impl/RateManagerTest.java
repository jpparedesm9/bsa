package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.portfolio.model.ValuePortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IRatePortfolio;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })

@Ignore
public class RateManagerTest {

	
	@Autowired
	@Qualifier("ratePortfolioManager")
	private IRatePortfolio ratePortfolio;
	
	
	@Test
	public void getValuePortfolioTest()
	{
		List<ValuePortfolio> vl = ratePortfolio.getValuePortfolio();
		
		
		System.out.println("Size -->" + vl.size() );
	}
	
}
