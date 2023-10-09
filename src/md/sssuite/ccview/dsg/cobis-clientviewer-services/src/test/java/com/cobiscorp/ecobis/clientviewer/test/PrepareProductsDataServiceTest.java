package com.cobiscorp.ecobis.clientviewer.test;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;

public class PrepareProductsDataServiceTest {

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void test() {

        int customer = 1;
        int group = 0;
        		
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/ProductsService/prepareProductsData/" + customer + "/" +group,
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		
		System.out.println("--- " + serviceResponse.getData());
		
		Assert.assertNotNull(serviceResponse);
	}

}
