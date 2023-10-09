package com.cobiscorp.ecobis.busin.web.services.test.warranties;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;

public class WarrantiesManagerTest {

	
	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// System.out.println("pwd" + util.getProperty("security.password") );
		System.out.println("LOGIN CTS: " + util.doLogin());
	}
	
	@Ignore
	public void getAllCompaniesTest() {
		try {

			String responseJSON = util.sendHttpPut(
					"busin/WarrantiesManager/getAllWarrantiesTypes/"+null, "");
			System.out.println("responseJSON: " + responseJSON);
			ServiceResponse serviceResponse = util
					.deserializeServiceResponse(responseJSON);

			System.out.println(serviceResponse.getData());

			Assert.assertNotNull(serviceResponse);
			Assert.assertEquals(true, serviceResponse.isResult());

		} catch (Throwable ex) {
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}
}
