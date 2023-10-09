package com.cobiscorp.ecobis.customer.test;

import java.util.ArrayList;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;

public class CustomerServiceTest {

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void queryGroup() {

		SearchGroupDTO searchGroup = new SearchGroupDTO();
		searchGroup.setGroupName("GENERAL");

		String requestJSON = util.serializeJson(searchGroup);
		String responseJSON = util.sendHttpPut(
				"clientviewer/ClientService/queryGroup", requestJSON);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		System.out.println(serviceResponse.getData());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryCustomerType() {

		int customer = 5;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryClientType/" + customer, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());

		Assert.assertEquals(true, serviceResponse.isResult());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryCustomerAddresses() {
		int customer = 3;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryClientDirections/" + customer,
				"");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());

		Assert.assertEquals(true, serviceResponse.isResult());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryGroupMembers() {
		int customer = 6;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryGroupMembers/" + customer, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());

		Assert.assertEquals(true, serviceResponse.isResult());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryClientRate() {
		int customer = 3;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryClientRate/" + customer, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryClient() {
		int customer = 3;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryClient/" + customer, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryGroupDetail() {
		int customer = 3;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryGroupDetail/" + customer, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@SuppressWarnings("rawtypes")
	@Test
	public void queryCustomerByParameters() {

		SearchCustomerDTO inputClient = new SearchCustomerDTO();
		inputClient.setSubType("C");
		inputClient.setType(5);
		inputClient.setMode(2);
		inputClient.setComercialName("CAICEDO Y CAICEDO");
		inputClient.setClientNumber(0);
		inputClient.setClientName("");
		inputClient.setClientLastName("");
		inputClient.setCedRuc("");
		inputClient.setIsClient('S');

		String requestJSONC = util.serializeJson(inputClient);

		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryClientByParameters",
				requestJSONC);

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();

		for (Object object : resp2) {

			System.out.println(object.toString());

		}
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryLegalCustomer() {
		int customer = 112;
		String responseJSONC = util.sendHttpPut(
				"clientviewer/ClientService/queryLegalClient/" + customer, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());
		Assert.assertEquals(true, serviceResponse.isResult());
		Assert.assertNotNull(serviceResponse);

	}

	@Test
	public void queyMaxDebt() {

		int customer = 3;
		int group = 0;

		String responseJSONC = util.sendHttpPut(
				"clientviewer/MaxDebtService/queryMaxDebt/" + customer + "/"
						+ group, "");

		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSONC);

		System.out.println(serviceResponse.getData());
		
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}
}
