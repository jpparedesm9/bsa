package com.cobiscorp.test;

import java.io.IOException;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.mobile.model.Answer;
import com.cobiscorp.mobile.model.Answers;
import com.cobiscorp.mobile.model.ResetPasswordRequest;

public class ResetPasswordTest extends SecurityBaseTest {

	private static final String PASSWORD = SERVER.concat("/security/password/reset");

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
		URL resource = this.getClass().getClassLoader().getResource(".");
		System.setProperty("COBIS_HOME", resource.getPath());
	}

	@Test
	public void shouldResetPassword() throws Exception {
		deleteChallengeCount(null);

		HttpResponse response = requestQuestions(null, null);
		String token = extractJwt(response);

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);
		Assert.assertNotNull(serviceResponse.getData());

		response = sendAnswers(token, correctAnswers(serviceResponse));

		token = extractJwt(response);

		HttpPost post = createHttpPost(PASSWORD);
		post.addHeader("Authorization", "Bearer ".concat(token));

		ResetPasswordRequest resetPassword = new ResetPasswordRequest();
		resetPassword.setPhone(TELEFONO);
		resetPassword.setPassword(new String (Base64.getDecoder().decode(CLAVE)));

		post.setEntity(new StringEntity(mapper.writeValueAsString(resetPassword)));

		response = httpclient.execute(post);
		token = extractJwt(response);

		CobisJwt jwt = new CobisJwt(token, new ShakeJwtKeyGenerator());
		String sessionId = jwt.getAttribute("cobisSessionId");

		Assert.assertNotNull(sessionId);
	}

	@Test
	public void shouldNotResetPassword() throws Exception {
		deleteChallengeCount(null);

		HttpResponse response = requestQuestions(null, null);
		String token = extractJwt(response);

		ServiceResponse serviceResponse = extractDataFromResponse(response, ServiceResponse.class);

		Answers answers = wrongAnswers(serviceResponse);

		response = sendAnswers(token, answers);

		StatusLine statusLine = response.getStatusLine();
		Assert.assertNotEquals(200, statusLine.getStatusCode());
	}

	private HttpResponse sendAnswers(String token, Answers answers) throws ClientProtocolException, IOException {
		HttpPut put = createHttpPut(CHALLENGE);
		put.addHeader("Authorization", "Bearer ".concat(token));
		StringEntity se = new StringEntity(mapper.writeValueAsString(answers));
		put.setEntity(se);
		return httpclient.execute(put);
	}

	private Answers wrongAnswers(ServiceResponse serviceResponse) {
		Answers answers = new Answers();

		@SuppressWarnings("unchecked")
		List<HashMap<String, Object>> questions = (List<HashMap<String, Object>>) serviceResponse.getData();
		for (HashMap<String, Object> question : questions) {
			String qId = question.get("questionId").toString();

			Answer answer = new Answer();
			answer.setQuestionId(Integer.valueOf(qId));
			answer.setAnswer("X");
			answers.addAnswersItem(answer);
		}
		return answers;
	}

}
