package com.cobiscorp.ecobis.clientviewer.test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;


public class QueryProductsServiceTest {
	@SuppressWarnings("unused")
	private static ILogger logger = LogFactory
			.getLogger(QueryProductsServiceTest.class);

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@SuppressWarnings({ "rawtypes" })
	@Test
	public void consolidatePosition() {

		int customer = 1;
		int group = 0;

		// PrepareData		
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/ProductsService/prepareProductsData/" + customer + "/" + group,
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		// QueryConsolidatePosition		
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryConsolidatedPosition/"
						+ customer, "");
		serviceResponse = util.deserializeServiceResponse(responseJSONC);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();

		for (Object object : resp2) {
			
			System.out.println("--------------------"+object.toString());

		}

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@SuppressWarnings("unchecked")
	@Test
	public void preparedDataAndGetData() {

		int customer = 1;
		SearchCustomerDTO request = new SearchCustomerDTO();
		request.setClientNumber(customer);

		String requestJSON = util.serializeJson(request);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/ProductsService/prepareProductsData/"+customer+"/"+0,
						"");//requestJSON);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		Map<String, Object> resp = (Map<String, Object>) serviceResponse
				.getData();

		Integer spid = Integer.parseInt(resp.get("spid").toString());

		String responseJSONByClient = util.sendHttpPut(
				"clientviewer/ProductsService/queryProductsByClientId/"
						+ customer + "/" + spid, "");

		ServiceResponse serviceResponseByClient = util
				.deserializeServiceResponse(responseJSONByClient);
		Map<String, Object> prod = (Map<String, Object>) serviceResponseByClient
				.getData();

		for (String key : prod.keySet()) {
			System.out.println(key);
			List<Object> list = (ArrayList<Object>) prod.get(key);
			if (list != null) {
				for (Object object : list) {
					System.out.println("----------------------**** "+object.toString());
				}
			}
		}

		Assert.assertEquals(true, serviceResponse.isResult());
		Assert.assertNotNull(serviceResponseByClient);
		Assert.assertEquals(true, serviceResponseByClient.isResult());
	}

}
