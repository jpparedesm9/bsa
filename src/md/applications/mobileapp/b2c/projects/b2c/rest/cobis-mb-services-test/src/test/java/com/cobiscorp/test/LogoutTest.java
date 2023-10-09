package com.cobiscorp.test;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class LogoutTest extends BaseTest {
	private static final String HOME = SERVER.concat("/loan/info");

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	public void shouldLogoutUser() throws Exception {

		String token = login();
		System.out.println(token);
		HttpResponse response = logout(token);

		Assert.assertEquals(200, response.getStatusLine().getStatusCode());

		ServiceResponse serviceResponse = getLoanInfo(token);
		Assert.assertEquals(false, serviceResponse.isResult());
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
