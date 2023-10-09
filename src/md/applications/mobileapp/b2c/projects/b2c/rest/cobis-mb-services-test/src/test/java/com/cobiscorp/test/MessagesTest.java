package com.cobiscorp.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class MessagesTest extends BaseTest {

	private static final String PARAMETERS = SERVER.concat("/security/client/parameters");
	private static final String LOAN_INFO = SERVER.concat("/loan/info");
	private static final String MESSAGES = SERVER.concat("/messages/execute");

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	@SuppressWarnings("rawtypes")
	public void shouldLoadNotifications() throws Exception {
		List notifications = (List) getNotifications().get("notifications");

		for (Object o : notifications) {
			LinkedHashMap notification = (LinkedHashMap) o;
			Assert.assertNotNull(notification.get("id"));
			Assert.assertNotNull(notification.get("description"));
			Assert.assertNotNull(notification.get("type"));
			Assert.assertNotNull(notification.get("needsOtp"));
		}
	}

	@Test
	@SuppressWarnings({ "rawtypes" })
	public void shouldExecuteOKNotification() throws Exception {
		Map<String, Object> result = getNotifications();
		List notifications = (List) result.get("notifications");

		String json = null;
		for (Object o : notifications) {
			LinkedHashMap notification = (LinkedHashMap) o;
			if ("OK".equals(notification.get("type"))) {
				json = String.format("{\"messageId\":%1$s, \"response\":\"OK\"}", notification.get("id").toString());
				break;
			}
		}

		String token = (String) result.get("jwt");
		Assert.assertNotNull(token);

		HttpPut put = createHttpPut(MESSAGES);
		put.setEntity(new StringEntity(json));
		put.addHeader("Authorization", "Bearer ".concat(token));
		HttpResponse response = httpclient.execute(put);

		int statusCode = response.getStatusLine().getStatusCode();

		if (200 != statusCode) {
			ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
			List<Message> messages = serviceResponse.getMessages();
			for (Message m : messages) {
				System.out.println(m.getCode() + " >> " + m.getMessage());
			}
		}

		Assert.assertEquals(200, statusCode);
	}

	@Test
	@SuppressWarnings({ "rawtypes" })
	public void shouldExecuteSINotificationWithoutPassword() throws Exception {
		Map<String, Object> result = getNotifications();
		List notifications = (List) result.get("notifications");

		String json = null;
		for (Object o : notifications) {
			LinkedHashMap notification = (LinkedHashMap) o;
			if ("SN".equals(notification.get("type")) && "N".equals(notification.get("needsOtp"))) {
				json = String.format("{\"messageId\":%1$s, \"response\":\"SI\"}", notification.get("id").toString());
				break;
			}
		}

		String token = (String) result.get("jwt");
		Assert.assertNotNull(token);

		HttpPut put = createHttpPut(MESSAGES);
		put.setEntity(new StringEntity(json));
		put.addHeader("Authorization", "Bearer ".concat(token));
		HttpResponse response = httpclient.execute(put);

		int statusCode = response.getStatusLine().getStatusCode();

		if (200 != statusCode) {
			ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
			List<Message> messages = serviceResponse.getMessages();
			for (Message m : messages) {
				System.out.println(m.getCode() + " >> " + m.getMessage());
			}
		}

		Assert.assertEquals(200, statusCode);
	}

	@Test
	@SuppressWarnings({ "rawtypes" })
	public void shouldExecuteSINotificationWithPassword() throws Exception {
		Map<String, Object> result = getNotifications();
		List notifications = (List) result.get("notifications");

		String json = null;
		for (Object o : notifications) {
			LinkedHashMap notification = (LinkedHashMap) o;
			if ("SN".equals(notification.get("type")) && "S".equals(notification.get("needsOtp"))) {
				json = String.format("{\"messageId\":%1$s, \"response\":\"SI\", \"password\":\"%2$s\"}", notification.get("id").toString(), new String (Base64.getDecoder().decode(CLAVE)));
				break;
			}
		}

		String token = (String) result.get("jwt");
		Assert.assertNotNull(token);

		HttpPut put = createHttpPut(MESSAGES);
		put.setEntity(new StringEntity(json));
		put.addHeader("Authorization", "Bearer ".concat(token));
		HttpResponse response = httpclient.execute(put);

		int statusCode = response.getStatusLine().getStatusCode();

		if (200 != statusCode) {
			ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
			List<Message> messages = serviceResponse.getMessages();
			for (Message m : messages) {
				System.out.println(m.getCode() + " >> " + m.getMessage());
			}
		}

		Assert.assertEquals(200, statusCode);
	}

	@Test
	@SuppressWarnings({ "rawtypes" })
	public void shouldNotExecuteSINotificationWithPassword() throws Exception {
		Map<String, Object> result = getNotifications();
		List notifications = (List) result.get("notifications");

		String json = null;
		for (Object o : notifications) {
			LinkedHashMap notification = (LinkedHashMap) o;
			if ("SN".equals(notification.get("type")) && "S".equals(notification.get("needsOtp"))) {
				json = String.format("{\"messageId\":%1$s, \"response\":\"SI\", \"password\":\"%2$s\"}", notification.get("id").toString(), "0000");
				break;
			}
		}

		String token = (String) result.get("jwt");
		Assert.assertNotNull(token);

		HttpPut put = createHttpPut(MESSAGES);
		put.setEntity(new StringEntity(json));
		put.addHeader("Authorization", "Bearer ".concat(token));
		HttpResponse response = httpclient.execute(put);

		int statusCode = response.getStatusLine().getStatusCode();

		String msg = null;
		if (200 != statusCode) {
			ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
			List<Message> messages = serviceResponse.getMessages();
			for (Message m : messages) {
				msg = m.getMessage();
				break;
			}
		}

		Assert.assertNotEquals(200, statusCode);
		Assert.assertEquals("La clave es incorrecta", msg);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Map<String, Object> getNotifications() throws Exception {
		prepareData();

		String token = login();
		Map<String, Object> result = getParameters(token);

		ServiceResponse serviceResponse = (ServiceResponse) result.get("result");

		LinkedHashMap<String, Object> data = (LinkedHashMap<String, Object>) serviceResponse.getData();

		List notifications = (List) data.get("notificaciones");
		Assert.assertNotNull(notifications);
		Assert.assertFalse(notifications.isEmpty());

		result.put("notifications", notifications);

		return result;
	}

	private Map<String, Object> getParameters(String jwt) throws Exception {
		String loanId = getLoanIdByEnrollmentCode(null);
		HttpPost httpPost = createHttpPost(LOAN_INFO);
		StringEntity se = new StringEntity("{\"loanId\": \"" + loanId + "\"}");
		httpPost.setEntity(se);
		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		HttpResponse response = httpclient.execute(httpPost);

		String _jwt = extractJwt(response);

		HttpGet get = createHttpGet(PARAMETERS);
		get.addHeader("Authorization", "Bearer ".concat(_jwt));
		response = httpclient.execute(get);

		_jwt = extractJwt(response);

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("jwt", _jwt);
		result.put("result", serviceResponse);

		return result;
	}

	private void prepareData() throws Exception {
		Connection connection = null;
		Statement statement = null;
		try {
			connection = getBVirtualConnection();
			statement = connection.createStatement();
			statement.executeUpdate("update cob_bvirtual..bv_b2c_msg set ms_fecha_resp = null, ms_respuesta = null, ms_fecha_ven = Cast('12/31/2018' as datetime)");
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
