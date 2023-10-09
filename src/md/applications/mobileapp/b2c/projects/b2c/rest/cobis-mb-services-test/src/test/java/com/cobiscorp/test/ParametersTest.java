package com.cobiscorp.test;

import java.util.LinkedHashMap;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class ParametersTest extends BaseTest {

	private static final String PARAMETERS = SERVER.concat("/security/client/parameters");

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	@SuppressWarnings("unchecked")
	public void shouldLoadLoanInfo() throws Exception {
		String token = login();
		ServiceResponse serviceResponse = getParameters(token);

		LinkedHashMap<String, Object> data = (LinkedHashMap<String, Object>) serviceResponse.getData();

		Assert.assertNotNull(data.get("porcentajeIva"));
		Assert.assertNotNull(data.get("tablaComision"));
		Assert.assertNotNull(data.get("tablaComision"));
	}

	private ServiceResponse getParameters(String jwt) throws Exception {
		HttpGet get = createHttpGet(PARAMETERS);
		get.addHeader("Authorization", "Bearer ".concat(jwt));
		HttpResponse response = httpclient.execute(get);
		return extractDataFromResponse(response, ServiceResponse.class);
	}
}
