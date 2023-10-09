package com.cobiscorp.test;

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;

import javax.crypto.Cipher;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;

import com.fasterxml.jackson.databind.ObjectMapper;

@SuppressWarnings("unused")
public class BaseTest {

	protected static String SERVER = null;
	protected static String DBSERVER = null;
	protected static String VERIFICATION_CODE = null;
	protected static String TELEFONO = null;
	protected static String CLAVE = null;

	//private static final String ENV = "201";
	private static final String ENV = "138";
	
	static {
		if (ENV == "201") {
			// datos para amb dev01
			SERVER = "http://192.168.67.201:9080/CTSProxy/services/resources/channels/mobilebanking";
			DBSERVER = "192.168.66.108";
			VERIFICATION_CODE = "098582";
			TELEFONO = "0999777777";
			CLAVE = "Nzc3Nw==";
		}
		if (ENV == "138") {
			// datos para amb dev02
			SERVER = "http://192.168.66.138:9080/CTSProxy/services/resources/channels/mobilebanking";
			DBSERVER = "192.168.66.206";
			VERIFICATION_CODE = "033654";
			TELEFONO = "0999888888";
			CLAVE = "ODg4OA==";
			// Usuario de pruebas usado por Joyner
			// VERIFICATION_CODE = "033654";
			// TELEFONO = "5551467459";
			// CLAVE = "0000";
		}

	}

	protected static final String LOGIN = SERVER.concat("/security/login");
	protected static final String LOGOUT = SERVER.concat("/security/logout");

	protected HttpClient httpclient;

	protected ObjectMapper mapper = new ObjectMapper();

	protected String extractJwt(HttpResponse response) throws Exception {
		Header[] headers = response.getHeaders("cobis-jwt");
		if (headers.length > 0) {
			return headers[0].getValue();
		}
		// return null;
		throw new Exception("cobis-jwt not found in response");
	}

	protected <T> T extractDataFromResponse(HttpResponse response, Class<T> klass) throws Exception {
		HttpEntity entity = response.getEntity();
		if (entity == null) {
			throw new Exception("No entity in response");
		} else {
			String jsonEntity = convert(entity.getContent());
			return mapper.readValue(jsonEntity, klass);
		}

	}

	protected HttpPost createHttpPost(String url) {
		HttpPost httpPost = new HttpPost(url);
		httpPost.addHeader("Content-Type", "application/json");
		return httpPost;
	}

	protected HttpGet createHttpGet(String url) {
		HttpGet get = new HttpGet(url);
		get.addHeader("Content-Type", "application/json");
		return get;
	}

	protected HttpPut createHttpPut(String url) {
		HttpPut httpPut = new HttpPut(url);
		httpPut.addHeader("Content-Type", "application/json");
		return httpPut;
	}

	protected String convert(InputStream inputStream) throws IOException {
		StringBuilder stringBuilder = new StringBuilder();
		String line = null;

		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}

		return stringBuilder.toString();
	}

	protected Connection getBVirtualConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://" + DBSERVER + ":1433;databaseName=cob_bvirtual";
		Connection connection = DriverManager.getConnection(url, "sa", "Passw0rd2017");
		return connection;
	}

	protected String getOTP() throws Exception {
		Connection connection = null;
		Statement statement = null;
		try {
			connection = getBVirtualConnection();

			String customerId = getCustomerIdByEnrollmentCode(connection);

			statement = connection.createStatement();

			String sql = String.format("select nd.nd_body from cobis..ns_notificaciones_despacho nd where nd.nd_ente = %1$s and nd_servicio = 8 order by nd_id desc", customerId);

			ResultSet result = statement.executeQuery(sql);
			if (result.next()) {
				String otp = result.getString(1);
				return otp.replaceAll("Estimado Cliente, su clave temporal es:", "").trim();
			} else {
				return null;
			}
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

	protected String login() throws UnsupportedEncodingException, IOException, ClientProtocolException, Exception {
		HttpPost httpPost = createHttpPost(LOGIN);
		StringEntity se = new StringEntity("{\"username\": \"" + TELEFONO + "\",\"password\": \"" + new String (Base64.getDecoder().decode(CLAVE)) + "\",\"culture\": \"ES-EC\"}");
		httpPost.setEntity(se);
		
		HttpResponse response = httpclient.execute(httpPost);
		String token = extractJwt(response);
		return token;
	}

	protected HttpResponse loginNoToken() throws UnsupportedEncodingException, IOException, ClientProtocolException, Exception {
		HttpPost httpPost = createHttpPost(LOGIN);
		StringEntity se = new StringEntity("{\"username\": \"" + TELEFONO + "\",\"password\": \"" + new String (Base64.getDecoder().decode(CLAVE)) + "\",\"culture\": \"ES-EC\"}");
		httpPost.setEntity(se);

		return httpclient.execute(httpPost);
	}

	protected HttpResponse logout(String token) throws UnsupportedEncodingException, IOException, ClientProtocolException, Exception {
		HttpPost httpPost = createHttpPost(LOGOUT);
		httpPost.addHeader("Authorization", "Bearer ".concat(token));
		return httpclient.execute(httpPost);
	}

	protected void deleteChallengeCount(String _customerId) throws Exception {
		Connection connection = null;
		Statement statement = null;
		try {
			connection = getBVirtualConnection();

			String customerId = (_customerId == null) ? getCustomerIdByEnrollmentCode(connection) : _customerId;

			statement = connection.createStatement();
			statement.executeUpdate(String.format("delete cob_bvirtual.dbo.bv_b2c_intento_desafio where id_cliente = %1$s", customerId));

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

	protected String getCustomerIdByEnrollmentCode(Connection _connection) throws Exception {
		boolean closeConnection = true;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			if (_connection == null) {
				connection = getBVirtualConnection();
			} else {
				connection = _connection;
				closeConnection = false;
			}
			statement = connection.prepareStatement("select rb_cliente from cob_credito.dbo.cr_b2c_registro where rb_registro_id = ?");
			statement.setString(1, VERIFICATION_CODE);
			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				return resultSet.getString(1);
			}
		} catch (ClassNotFoundException e) {
			throw e;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (closeConnection) {
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

		return null;
	}

	protected Integer getProcessIdByEnrollmentCode(Connection _connection) throws Exception {
		boolean closeConnection = true;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			if (_connection == null) {
				connection = getBVirtualConnection();
			} else {
				connection = _connection;
				closeConnection = false;
			}
			statement = connection.prepareStatement("select rb_id_inst_proc from cob_credito.dbo.cr_b2c_registro where rb_registro_id = ?");
			statement.setString(1, VERIFICATION_CODE);
			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				return resultSet.getInt(1);
			}
		} catch (ClassNotFoundException e) {
			throw e;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (closeConnection) {
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

		return null;
	}

	protected String getLoanIdByEnrollmentCode(Connection _connection) throws Exception {
		boolean closeConnection = true;
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			if (_connection == null) {
				connection = getBVirtualConnection();
			} else {
				connection = _connection;
				closeConnection = false;
			}
			statement = connection.prepareStatement(
					"select top 1 op_banco from cob_cartera.dbo.ca_operacion where op_cliente = (select rb_cliente from cob_credito.dbo.cr_b2c_registro where rb_registro_id = ?) and op_toperacion = 'REVOLVENTE' and op_operacion > 0");
			statement.setString(1, VERIFICATION_CODE);
			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				return resultSet.getString(1);
			}
		} catch (ClassNotFoundException e) {
			throw e;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (closeConnection) {
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

		return null;
	}
}
