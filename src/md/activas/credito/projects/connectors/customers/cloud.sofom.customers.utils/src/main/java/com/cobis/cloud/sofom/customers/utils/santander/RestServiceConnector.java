package com.cobis.cloud.sofom.customers.utils.santander;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.net.ssl.SSLContext;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.client.ClientProperties;

import com.cobis.cloud.sofom.customers.utils.santander.dto.AuthorizationInfo;
import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.customers.utils.santander.dto.ErrorsResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.fasterxml.jackson.databind.ObjectMapper;

public abstract class RestServiceConnector {
	private static ILogger logger = LogFactory.getLogger(RestServiceConnector.class);
	private static final String className = "[RestServiceConnector]";

	public static final String UNAUTHORIZED = "Unauthorized";
	private static String accessToken = "";

	public static Client initializeClient() {
		SSLContext sslContext = null;
		try {
			sslContext = SSLContext.getInstance("TLSv1.2");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		if (sslContext != null) {
			try {
				sslContext.init(null, null, null);
			} catch (KeyManagementException e) {
				e.printStackTrace();
			}
		}

		ClientConfig configuration = new ClientConfig();
		configuration.property(ClientProperties.CONNECT_TIMEOUT, 5000);
		configuration.property(ClientProperties.READ_TIMEOUT, 60000);
		Client client = ClientBuilder.newBuilder().withConfig(configuration).sslContext(sslContext).build();

		return client;
	}

	public static String checkResponseStatus(Response response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug(className + "[checkResponseStatus]");
		}

		int statusCode = response.getStatus();
		if (logger.isDebugEnabled()) {
			logger.logDebug("Response status code: " + statusCode);
		}

		String jsonResponse = response.readEntity(String.class);
		response.close();
		if (logger.isTraceEnabled()) {
			logger.logTrace("jsonResponse: " + jsonResponse);
		}

		if (statusCode != 200) { // OK
			if (logger.isDebugEnabled()) {
				logger.logDebug("jsonResponse: " + jsonResponse);
			}

			if (statusCode == 401 || statusCode == 403) { // 401: Unauthorized, 403: Forbidden
				synchronized (accessToken) {
					accessToken = "";
				}
				return UNAUTHORIZED;
			}

			if (statusCode == 500) { // Internal Server Error
				ObjectMapper mapper = new ObjectMapper();
				ErrorsResponse errorsResponse = mapper.readValue(jsonResponse, ErrorsResponse.class);
				throw new Exception(errorsResponse.getErrors().get(0).getMoreInfo());
			} else {
				throw new Exception(jsonResponse);
			}
		}

		return jsonResponse;
	}

	public synchronized static String getAuthorizationInfo(String accessToken, ConnectionInfo connectionInfo) throws IOException {
		if ("".contentEquals(accessToken)) {
			Form form = new Form();
			form.param("client_id", connectionInfo.getClientId());
			form.param("clientSecret", connectionInfo.getClientSecret());

			String resource = "/oauth/token";
			String url = String.format("%s%s", connectionInfo.getBaseUrl(), resource);
			Client client = initializeClient();
			WebTarget webTarget = client.target(url).queryParam("client_id", connectionInfo.getClientId());
			if (logger.isDebugEnabled()) {
				logger.logDebug("webTarget.getUri(): get token " + webTarget.getUri());
			}
			Response response = webTarget.request().post(Entity.form(form));

			String jsonResponse = response.readEntity(String.class);
			if (logger.isTraceEnabled()) {
				logger.logTrace("jsonResponse: " + jsonResponse);
			}

			AuthorizationInfo authorizationInfo;
			if (response.getStatus() == 200) { // OK
				ObjectMapper mapper = new ObjectMapper();
				authorizationInfo = mapper.readValue(jsonResponse, AuthorizationInfo.class);
				if (logger.isTraceEnabled()) {
					logger.logDebug("authorizationInfo: " + authorizationInfo.toString());
				}
			} else if (response.getStatus() == 401 || response.getStatus() == 403) { // 401: Unauthorized, 403: Forbidden
				throw new COBISInfrastructureRuntimeException("Credentials unauthorized to use web services");
			} else {
				throw new COBISInfrastructureRuntimeException("Error validating authentication information");
			}

			return authorizationInfo.getAccess_token();
		} else
			return accessToken;
	}

	public static Integer getRandom() {
		Random random = new Random();
		return random.nextInt(Integer.MAX_VALUE) + 1;
	}

	public static Response callService(String url, String jsonBody, ConnectionInfo connectionInfo) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(className + "[callService]");
		}

		accessToken = getAuthorizationInfo(accessToken, connectionInfo);
		if (logger.isTraceEnabled()) {
			logger.logTrace("accessToken: " + accessToken);
		}

		Client client = RestServiceConnector.initializeClient();
		WebTarget webTarget = client.target(url);
		Invocation.Builder builder = webTarget.request();
		if (logger.isDebugEnabled()) {
			logger.logDebug("webTarget.getUri(): consume " + webTarget.getUri());
		}

		builder.header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken);
		builder.header("X-Santander-Global-Id", String.valueOf(RestServiceConnector.getRandom()));
		builder.header("X-Ibm-Client-Id", connectionInfo.getClientId());

		if (logger.isDebugEnabled()) {
			logger.logDebug("jsonBody: " + jsonBody);
		}

		return builder.post(Entity.json(jsonBody));
	}
}
