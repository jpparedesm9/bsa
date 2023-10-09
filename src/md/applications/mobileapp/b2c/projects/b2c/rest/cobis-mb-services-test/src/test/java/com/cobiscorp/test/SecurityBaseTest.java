package com.cobiscorp.test;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.junit.Assert;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.mobile.model.Answer;
import com.cobiscorp.mobile.model.Answers;

public class SecurityBaseTest extends BaseTest {

	protected static final String CHALLENGE = SERVER.concat("/security/challenge");

	protected HttpResponse tryLogin() throws UnsupportedEncodingException, IOException, ClientProtocolException {
		HttpResponse response;
		HttpPost post = createHttpPost(LOGIN);
		StringEntity se = new StringEntity("{\"username\": \"" + TELEFONO + "\",\"password\": \"" + new String (Base64.getDecoder().decode(CLAVE)) + "\",\"culture\": \"ES-EC\"}");
		post.setEntity(se);

		response = httpclient.execute(post);
		return response;
	}

	protected HttpResponse requestQuestions(String _telefono, String _customerId) throws Exception {
		String customerId = (_customerId == null) ? getCustomerIdByEnrollmentCode(null) : _customerId;
		Assert.assertNotNull(customerId);

		String telefono = (_telefono == null) ? TELEFONO : _telefono;

		HttpPost post = createHttpPost(CHALLENGE);
		String client = "{\"idCliente\": \"" + customerId + "\", \"telefono\": \"" + telefono + "\"}";
		StringEntity se = new StringEntity(client);
		System.out.println(se.toString());
		post.setEntity(se);
		return httpclient.execute(post);
	}

	protected Answers correctAnswers(ServiceResponse serviceResponse) throws Exception {
		Answers answers = new Answers();

		@SuppressWarnings("unchecked")
		List<HashMap<String, Object>> questions = (List<HashMap<String, Object>>) serviceResponse.getData();
		for (HashMap<String, Object> question : questions) {
			String qId = question.get("questionId").toString();

			String answerText = getAnswerFromDB(qId);
			Assert.assertNotNull(answerText);

			System.out.println("qID " + qId + " answer " + answerText);

			Answer answer = new Answer();
			answer.setQuestionId(Integer.valueOf(qId));
			answer.setAnswer(answerText);
			answers.addAnswersItem(answer);
		}
		return answers;
	}

	private String getAnswerFromDB(String questionId) throws Exception {
		String sql = null;
		String answer = null;
		if ("1".equals(questionId)) {
			sql = "select convert(varchar, en_ente) from cobis..cl_ente where en_ente = %1$s";
		} else if ("2".equals(questionId)) {
			sql = "select substring(en_rfc, 1, len(en_rfc)-2) from cobis..cl_ente where en_ente = %1$s";
		} else if ("3".equals(questionId)) {
			sql = "select isnull(LTRIM(RTRIM(upper(p_s_apellido))),'') from cobis..cl_ente where en_ente = %1$s";
		} else if ("4".equals(questionId)) {
			sql = "select isnull(LTRIM(RTRIM(upper(p_s_nombre))),'') from cobis..cl_ente where en_ente = %1$s";
		} else if ("5".equals(questionId)) {
			sql = "select top 1 substring(te_valor, len(te_valor) - 2, 3) from cobis..cl_telefono where te_ente = %1$s and te_tipo_telefono = 'C' order by te_direccion, te_secuencial";
		} else if ("6".equals(questionId)) {
			sql = "select top 1 isnull(di_codpostal,'') from cobis..cl_ente, cobis..cl_direccion where en_ente = %1$s and en_ente = di_ente and di_tipo != 'CE' order by di_direccion";
		} else if ("7".equals(questionId)) {
			sql = "select convert(varchar(10),p_fecha_nac,101) from cobis..cl_ente where en_ente = %1$s";
		} else if ("8".equals(questionId)) {
			sql = "select top 1 isnull(RTRIM(LTRIM(upper(di_descripcion))),'') from cobis..cl_direccion where di_ente = %1$s and di_tipo = 'CE' order by di_direccion";
		}

		Connection connection = null;
		ResultSet resultSet = null;
		try {
			connection = getBVirtualConnection();

			String customerId = getCustomerIdByEnrollmentCode(connection);

			resultSet = connection.prepareStatement(String.format(sql, customerId)).executeQuery();
			if (resultSet.next()) {
				answer = resultSet.getString(1);
			}
		} catch (ClassNotFoundException e) {
			Assert.fail(e.getMessage());
		} catch (SQLException e) {
			Assert.fail(e.getMessage());
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return answer;
	}

}
