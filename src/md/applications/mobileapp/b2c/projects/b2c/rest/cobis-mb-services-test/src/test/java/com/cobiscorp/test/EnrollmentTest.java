package com.cobiscorp.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class EnrollmentTest extends BaseTest {

	private static final String ONBOARD = SERVER.concat("/security/onboard");
	private static final String CHANGE_PHONE = SERVER.concat("/security/client/changePhone");
	private static final String REGISTER_PASSWORD = SERVER.concat("/security/password");

	private HttpClient httpclient;

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	public void shouldReturnInvalidCode() throws Exception {
		String expected = "ERROR: NO EXISTE CODIGO DE REGISTRO 11111111";
		HttpResponse response = onboard("11111111");

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);

		Assert.assertEquals(expected, serviceResponse.getMessages().get(0).getMessage());
	}

	@Test
	@SuppressWarnings("unchecked")
	public void shouldEnrollUser() throws Exception {
		prepareData();

		HttpResponse response = onboard(VERIFICATION_CODE);

		String jwt = extractJwt(response);

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
		Map<String, Object> client = (Map<String, Object>) serviceResponse.getData();
		Assert.assertNotNull(client.get("idCliente"));

		String telefono = (String) client.get("telefono");
		if (telefono == null || telefono.trim().isEmpty()) {
			telefono = TELEFONO;
		}

		jwt = requestPhoneChange(jwt, telefono);
		Assert.assertNotNull(jwt);

		jwt = confirmPhoneChangeOtp(jwt);
		Assert.assertNotNull(jwt);

		jwt = sendNewPassword(jwt);
		Assert.assertNotNull(jwt);

		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	@SuppressWarnings("unchecked")
	public void shouldNoteEnrollUserTwoTimes() throws Exception {
		prepareData();

		HttpResponse httpResponse = onboard(VERIFICATION_CODE);

		String jwt = (String) extractJwt(httpResponse);

		ServiceResponse response = extractDataFromResponse(httpResponse, ServiceResponse.class);
		Map<String, Object> client = (Map<String, Object>) response.getData();

		String telefono = (String) client.get("telefono");
		if (telefono == null || telefono.trim().isEmpty()) {
			telefono = TELEFONO;
		}

		jwt = requestPhoneChange(jwt, telefono);

		jwt = confirmPhoneChangeOtp(jwt);

		jwt = sendNewPassword(jwt);

		httpResponse = onboard(VERIFICATION_CODE);
		response = extractDataFromResponse(httpResponse, ServiceResponse.class);

		Assert.assertFalse(response.isResult());

	}

	public HttpResponse onboard(String codigo) throws Exception {
		HttpPost httpPost = createHttpPost(ONBOARD);
		StringEntity se = new StringEntity("{\"codigo\": \"" + codigo + "\"}");
		httpPost.setEntity(se);
		return httpclient.execute(httpPost);
	}

	public String requestPhoneChange(String jwt, String numero) throws Exception {
		HttpPut httpPut = createHttpPut(CHANGE_PHONE);
		StringEntity se = new StringEntity("{\"numero\":\"" + numero + "\"}");
		httpPut.setEntity(se);
		httpPut.addHeader("Authorization", "Bearer ".concat(jwt));
		HttpResponse response = httpclient.execute(httpPut);
		return extractJwt(response);
	}

	public String confirmPhoneChangeOtp(String jwt) throws Exception {
		String otp = getOTP();

		Assert.assertNotNull(otp);
		Assert.assertFalse(otp.trim().isEmpty());

		HttpPost httpPost = createHttpPost(CHANGE_PHONE);

		StringEntity se = new StringEntity("{\"otp\":\"" + otp + "\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));

		HttpResponse response = httpclient.execute(httpPost);

		return extractJwt(response);
	}

	public String sendNewPassword(String jwt) throws Exception {
		HttpPost httpPost = createHttpPost(REGISTER_PASSWORD);

		StringEntity se = new StringEntity("{\"value\":\"" + new String (Base64.getDecoder().decode(CLAVE))  + "\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));

		HttpResponse response = httpclient.execute(httpPost);

		return extractJwt(response);
	}

	private void prepareData() throws Exception {
		Connection connection = null;
		Statement statement = null;
		PreparedStatement spStatement = null;
		try {
			connection = getBVirtualConnection();

			Integer processId = getProcessIdByEnrollmentCode(connection);
			String customerId = getCustomerIdByEnrollmentCode(connection);

			statement = connection.createStatement();
			statement.executeUpdate(String.format("delete from bv_login where lo_ente = (select en_ente from bv_ente where en_ente_mis = %1$s)", customerId));
			statement.executeUpdate(String.format("delete from bv_ente where en_ente_mis = %1$s", customerId));
			statement.executeUpdate(String.format("delete from cobis..cl_telefono where te_ente = %1$s and te_tipo_telefono = 'C'", customerId));

			ResultSet result = statement.executeQuery(String.format("select rb_registro_id from cob_credito..cr_b2c_registro where rb_id_inst_proc = %1$s", processId));
			if (!result.next()) {
				StringBuilder spSql = new StringBuilder();
				spSql.append("declare @w_registro_id varchar(100), @w_msg varchar(255)\n");
				spSql.append("exec cob_credito..sp_lcr_ingresar_registro @i_id_inst_proc = ?, @o_registro_id = @w_registro_id output, @o_msg = @w_msg output");
				spStatement = connection.prepareStatement(spSql.toString());
				spStatement.setInt(1, processId);
				spStatement.execute();
			}
			connection.commit();
		} catch (ClassNotFoundException e) {
			throw e;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (statement != null) {
				statement.close();
			}
			if (connection != null) {
				connection.close();
			}
			statement = null;
			connection = null;
		}
	}

}
