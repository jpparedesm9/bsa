package com.cobiscorp.ecobis.customer.web.services.test;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public class GetActivityTest {
	private UtilClientTest util = null;
	//private static ILogger logger = LogFactory.getLogger(executeTransaferFundsTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();		
		//System.out.println("LOGIN CTS: "+util.doLogin());
		util.doLogin();
	}
	@Ignore
	@Test
	public void getActivityEconomic() {
		try{
		EconomicActivityResponse resp = new EconomicActivityResponse();
		resp.setIndustry("01");
		
		String requestJSON =  util.serializeJson(resp);		
		String responseJSON = util.sendHttpPut("ActivityTxService/executeGetEconomicActivity", requestJSON);

		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
		
		if(serviceResponse.isResult()){
			System.out.println("Trama EconomicActivity: "+responseJSON);			
		}
		
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());		
		} catch (Throwable ex) {			
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}
	//@Ignore
	@Test
	public void getMainActivity() {
		try{
			
		MainActivityResponse request = new MainActivityResponse();
		request.setBusiness("V");
		String requestJSON =  util.serializeJson(request);		
		String responseJSON = util.sendHttpPut("ActivityTxService/executeGetMainActivity", requestJSON);

		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
		
		if(serviceResponse.isResult()){
			System.out.println("Trama MainActivity: "+responseJSON);			
		}
		
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());		
		
		} catch (Throwable ex) {			
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@After
	public void tearDown() {

	}

}
