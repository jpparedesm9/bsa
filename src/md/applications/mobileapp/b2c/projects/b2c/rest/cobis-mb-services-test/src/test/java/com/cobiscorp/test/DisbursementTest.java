package com.cobiscorp.test;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.Base64;
import java.util.LinkedHashMap;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class DisbursementTest extends BaseTest {

	private static final String HOME = SERVER.concat("/loan/info");
	private static final String LOAN = SERVER.concat("/loan");

	@Before
	public void init() {
		URL resource = this.getClass().getClassLoader().getResource(".");
		System.setProperty("COBIS_HOME", resource.getPath());

		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	public void shouldMakeSuccessDisbursement() throws Exception {
		String token = login();

		HttpResponse response = getLoanInfo(token);

		token = extractJwt(response);

		response = requestDisburment(token, "101");
		token = extractJwt(response);

		response = confirmOtp(token, new String (Base64.getDecoder().decode(CLAVE)));

		Assert.assertEquals(200, response.getStatusLine().getStatusCode());
	}

	@Test
	public void shouldNotMakeSuccessDisbursementWitHighAmount() throws Exception {
		String token = login();

		HttpResponse response = getLoanInfo(token);

		token = extractJwt(response);

		response = requestDisburment(token, "10000");
		token = extractJwt(response);

		response = confirmOtp(token, new String (Base64.getDecoder().decode(CLAVE)));
		Assert.assertNotEquals(200, response.getStatusLine().getStatusCode());
	}

	@Test
	@Ignore
	@SuppressWarnings("unchecked")
	public void shouldNotAllowOverDisburment() throws Exception {
		String token = login();

		HttpResponse response = getLoanInfo(token);

		ServiceResponse data = extractDataFromResponse(response, ServiceResponse.class);

		LinkedHashMap<String, Object> datos = (LinkedHashMap<String, Object>) data.getData();

		Double lineaCredito = (Double) datos.get("lineaCredito");

		token = extractJwt(response);

		response = requestDisburment(token, 10 + lineaCredito.toString());
		token = extractJwt(response);

		response = confirmOtp(token, new String (Base64.getDecoder().decode(CLAVE)));
		// Assert.assertNotEquals(200, response.getStatusLine().getStatusCode());
	}

	@Test
	public void shouldThrowInvalidOtp() throws Exception {
		String token = login();
		HttpResponse response = getLoanInfo(token);
		token = extractJwt(response);

		response = requestDisburment(token, "0");
		token = extractJwt(response);

		response = confirmOtp(token, "1111");

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
		Assert.assertFalse(serviceResponse.isResult());
		Assert.assertEquals("La clave es incorrecta", serviceResponse.getMessages().get(0).getMessage());
		Assert.assertNotEquals(200, response.getStatusLine().getStatusCode());
	}

	@Test
	public void shouldThrowInvalidJwt() throws Exception {
		String token = login();

		HttpResponse response = getLoanInfo(token);
		token = extractJwt(response);

		response = requestDisburment(token, "0");
		token = extractJwt(response);

		response = confirmOtp(token.concat("a"), "1111");

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
		Assert.assertFalse(serviceResponse.isResult());
		Assert.assertTrue(serviceResponse.getMessages().get(0).getMessage().contains("JWT signature does not match"));
		Assert.assertNotEquals(200, response.getStatusLine().getStatusCode());
	}

	private HttpResponse confirmOtp(String token, String otp) throws UnsupportedEncodingException, IOException, ClientProtocolException {
		HttpResponse response;
		HttpPut httpPut = createHttpPut(LOAN);
		httpPut.addHeader("Authorization", "Bearer ".concat(token));

		StringEntity se = new StringEntity("{\"otp\": \"" + otp + "\"}");
		httpPut.setEntity(se);

		response = httpclient.execute(httpPut);
		return response;
	}

	private HttpResponse requestDisburment(String token, String amount) throws UnsupportedEncodingException, IOException, ClientProtocolException {
		HttpPost httpPost = createHttpPost(LOAN);
		httpPost.addHeader("Authorization", "Bearer ".concat(token));

		StringEntity se = new StringEntity("{\"amount\": \"" + amount + "\"}");

		httpPost.setEntity(se);
		HttpResponse response = httpclient.execute(httpPost);
		return response;
	}

	private HttpResponse getLoanInfo(String token) throws Exception {
		String loanId = getLoanIdByEnrollmentCode(null);
		HttpPost httpPost = createHttpPost(HOME);
		httpPost.addHeader("Authorization", "Bearer ".concat(token));
		StringEntity se = new StringEntity("{\"loanId\": \"" + loanId + "\"}");
		httpPost.setEntity(se);
		return httpclient.execute(httpPost);
	}
}
