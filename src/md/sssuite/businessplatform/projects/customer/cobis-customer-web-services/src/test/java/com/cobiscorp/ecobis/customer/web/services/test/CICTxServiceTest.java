package com.cobiscorp.ecobis.customer.web.services.test;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public class CICTxServiceTest {
	private UtilClientTest util = null;
	@Ignore
	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Ignore
	@Test
	public void getCIC() {
		try{
			System.out.println("Obtener CIC");
			CustomerQuickCreateRequest request = new CustomerQuickCreateRequest();
	        request.setIdentificationTypeCode("1.1");
	        request.setId("0101230972");

	        String requestJSON =  util.serializeJson(request);
	        System.out.println("TRAMA:"+requestJSON);
	        String responseJSON = util.sendHttpPut("CICTxService/executeGetCIC", requestJSON);
	        
	        	if (responseJSON.indexOf("code") != -1)
	        		System.out.println ("Error: "+ responseJSON);
	        	else
	        	{
	        		ServiceResponse serviceResponse = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
	        		Assert.assertNotNull(serviceResponse);
	        		CustomerDataResponse customer=(CustomerDataResponse)serviceResponse.getData();			
	        		System.out.println("Identificacion: "+customer.getCustomerIdentification());						
	        		Assert.assertEquals(true, serviceResponse.isResult());
	        	}

	        } catch (Throwable ex) {                        
	                System.out.println("Error al registrar la prueba");
	                System.out.println("error:" + ex);
	                Assert.assertTrue(false);
	         }
	
	}
	@Ignore
	@After
	public void tearDown() {

	}

}
