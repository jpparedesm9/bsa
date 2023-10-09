package com.cobiscorp.test;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class LoanInfoTest extends BaseTest {

	private static final String HOME = SERVER.concat("/loan/info");

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void shouldLoadLoanInfo() throws Exception {

		String token = login();

		ServiceResponse serviceResponse = getLoanInfo(token);

		LinkedHashMap<String, Object> data = (LinkedHashMap<String, Object>) serviceResponse.getData();

		Assert.assertTrue((Double) data.get("lineaCredito") >= 0);
		Assert.assertTrue((Double) data.get("utilizado") >= 0);
		Assert.assertTrue((Double) data.get("pagoSinIntereses") >= 0);
		Assert.assertTrue((Double) data.get("pagoMinimo") >= 0);
		Assert.assertTrue(((String) data.get("referenciaDePago")).length() > 0);

		List disbursements = (List) data.get("details");
		Assert.assertNotNull(disbursements);
		Assert.assertFalse(disbursements.isEmpty());

	}

	private ServiceResponse getLoanInfo(String jwt) throws Exception {
		String loanId = getLoanIdByEnrollmentCode(null);
		HttpPost httpPost = createHttpPost(HOME);
		StringEntity se = new StringEntity("{\"loanId\": \"" + loanId + "\"}");
		httpPost.setEntity(se);
		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		HttpResponse response = httpclient.execute(httpPost);
		return extractDataFromResponse(response, ServiceResponse.class);
	}

}
