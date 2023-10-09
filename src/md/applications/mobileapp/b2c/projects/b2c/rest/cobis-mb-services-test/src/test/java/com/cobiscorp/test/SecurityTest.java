package com.cobiscorp.test;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.mobile.model.Answers;

public class SecurityTest extends SecurityBaseTest {

	private static final String BLOCK = SERVER.concat("/security/client/block");
	private static final String UNBLOCK = SERVER.concat("/security/client/unblock");

	@Before
	public void init() {
		URL resource = this.getClass().getClassLoader().getResource(".");
		System.setProperty("COBIS_HOME", resource.getPath());
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	public void shouldLoginUser() throws Exception {
		unblockDatabaseLogin(TELEFONO);
		login();
	}

	@Test
	public void shouldBlockLogin() throws UnsupportedEncodingException, ClientProtocolException, IOException, Exception {
		unblockDatabaseLogin(TELEFONO);
		String token = login();
		HttpResponse response = blockLogin(token);

		Assert.assertEquals(200, response.getStatusLine().getStatusCode());

		response = tryLogin();

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);

		Assert.assertEquals(403, response.getStatusLine().getStatusCode());
		Assert.assertEquals("1890011", serviceResponse.getMessages().get(0).getCode());
		Assert.assertEquals("El usuario se encuentra bloqueado temporalmente", serviceResponse.getMessages().get(0).getMessage());
	}

	@Test
	public void shouldUnblockLogin() throws UnsupportedEncodingException, ClientProtocolException, IOException, Exception {
		unblockDatabaseLogin(TELEFONO);

		String token = login();

		CobisJwt cobisJwt = new CobisJwt(token, new ShakeJwtKeyGenerator());

		String customerId = cobisJwt.getAttribute("customerId");
		deleteChallengeCount(customerId);

		HttpResponse response = blockLogin(token);

		response = requestQuestions(cobisJwt.getAttribute("phoneNumber"), customerId);

		token = extractJwt(response);

		response = unblockLogin(token, correctAnswers(extractDataFromResponse(response, ServiceResponse.class)));

		Assert.assertEquals(200, response.getStatusLine().getStatusCode());

		login();

	}

	private HttpResponse blockLogin(String token) throws IOException, ClientProtocolException {
		HttpPut put = createHttpPut(BLOCK);
		put.addHeader("Authorization", "Bearer ".concat(token));

		HttpResponse response = httpclient.execute(put);
		return response;
	}

	private HttpResponse unblockLogin(String token, Answers answers) throws IOException, ClientProtocolException, ClassNotFoundException, SQLException {
		blockDatabaseLogin(TELEFONO);
		
		HttpPut put = createHttpPut(UNBLOCK);
		put.addHeader("Authorization", "Bearer ".concat(token));

		StringEntity se = new StringEntity(mapper.writeValueAsString(answers));
		put.setEntity(se);

		HttpResponse response = httpclient.execute(put);

		return response;
	}

	private void unblockDatabaseLogin(String login) throws ClassNotFoundException, SQLException {
		String sql = String.format("update cob_bvirtual..bv_login set lo_estado = 'A' where lo_login = '%1$s'", login);
		executeUpdate(sql);
	}

	private void blockDatabaseLogin(String login) throws ClassNotFoundException, SQLException {
		executeUpdate(String.format("update cob_bvirtual..bv_login set lo_estado = 'T' where lo_login = '%1$s'", login));
	}

	private void executeUpdate(String update) throws ClassNotFoundException, SQLException {
		Connection connection = null;
		Statement statement = null;
		connection = getBVirtualConnection();
		statement = connection.createStatement();
		statement.executeUpdate(update);

		connection.commit();
		connection.close();

	}

}
