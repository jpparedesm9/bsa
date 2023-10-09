package com.cobiscorp.mobile.services;

import static java.lang.System.out;
import static org.junit.Assert.assertEquals;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.mobile.model.Password;
import com.cobiscorp.mobile.model.ShapeOfPayment;
import com.fasterxml.jackson.databind.ObjectMapper;

public class RestTest {

	private static final String ONBOARD = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/security/onboard";
	private static final String CHANGE_PHONE = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/security/client/changePhone";
	private static final String REGISTER_PASSWORD = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/security/password";
	private static final String LOGIN = "http://192.168.64.253:9090/CTSProxy/services/resources/channels/mobilebanking/security/login";
	private static final String GET_RAND_IMAGES = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/image/getRandomImages";
	private static final String INSERT_IMAGE = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/image/insert";

	private static final String GET_IMAGE = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/image/getImageLogin";

	private static final String VALIDATE_MAIL = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/security/mail/valid";
	private static final String LOGOUT = "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/security/logout";
	
	private static final String GET_LOANS =   "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/loan/info";
	private static final String PAYMENT_LOANS="http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/loan/payments"; 
	
	private static final String GET_PARAM =    "http://192.168.67.195:9090/CTSProxy/services/resources/channels/mobilebanking/security/client/parameters";
	private static final String PAY_WEBPAY_EP =   "http://192.168.67.195:9080/CTSProxy/services/resources/channels/mobilebanking/loan/info";
	private HttpClient httpclient;

	@Before
	public void init() {
		httpclient = HttpClientBuilder.create().build();
	}

	@Test
	@Ignore
	public void shouldLogin() throws Exception {
		HttpPost httpPost = createHttpPost(LOGIN);
		StringEntity se = new StringEntity(
				"{\"username\":\"5574286929\",\"password\":\"3104CFE25BCCF900A65EE1F1859186693DB8B5E5E7BE591F3694B312D4B3DC2B050E5DEF55CDC890063D4D3D32B2388C0A3747C6FE2B30F41BC75169AC63FECD941BE643174C2691051BDA72321C9250150428976BBEC3FA311C0217184E9E7E1FEE8E871C1477E831F71725923276F8E51382897CF1437C8AF51F70EAEB03E5\", \"culture\":\"ES-EC\"}");
		httpPost.setEntity(se);
		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);
		System.out.println(extractJwt(response));
	}

	@Test
	@Ignore
	public void shouldExecuteChangePhoneRequest() throws Exception {

		String jwt = "";
		jwt = onboard();
		System.out.println("login listo");
		System.out.println(jwt);

		jwt = requestPhoneChange(jwt);
		System.out.println("requestChangePhone listo");
		System.out.println(jwt);

//        jwt = confirmPhoneChangeOtp(jwt);
//        System.out.println("confirmChangePhoneOtp listo");
//        System.out.println(jwt);
//        
//        jwt = sendNewPassword(jwt);
//        System.out.println("sendNewPassword listo");
//        System.out.println(jwt);
	}

	@Test
	@Ignore
	public void getRandomImages() throws Exception {
		// String jwt = login();
		// System.out.println("Bearer ".concat(jwt));

		// String jwt = onboard();

		HttpGet httpPost = new HttpGet(GET_RAND_IMAGES);
		StringEntity se = new StringEntity("{\"alias\":\"\"}");
		// httpPost.setEntity(se);

		// httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		// httpPost.addHeader("Authorization", "Bearer
		// eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTYwMzY3MjY2LCJpc3MiOiJjb2Jpcy1idDItand0IiwiY2JzVG9rZW5QYXlsb2FkIjp7ImN1c3RvbWVySWQiOiIxMzA4MCIsImNvYmlzU2Vzc2lvbklkIjoiSUQ6NDY3QzQ2N0U3QjdDMzQ0NDdCN0M0NjdFMzQzMDQ2MzQ3QjM0NDY2NTQ2M0I0NjdCN0IzNDYzNDQ2MzdDMzQ0NDVBNzczQjVBN0U3QzdCNzAzNDQ0N0M3NzdFNDY2MzM0IiwicGhvbmVOdW1iZXIiOiI1NTc0Mjg2OTI5IiwiY3VsdHVyZSI6IkVTLUVDIiwiY2xpZW50SWQiOiI5MiJ9fQ._ZbiG_K2H1McLBCLWRGvc81XK4ZjTSNaQucSMqP0VDM");

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

	}

	@Test
	@Ignore
	public void logout() throws Exception {
		// String jwt = login();

		// System.out.println("Bearer ".concat(jwt));
		HttpPost httpPost = createHttpPost(LOGOUT);

		// httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		httpPost.addHeader("Authorization",
				"Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTYxOTkzODQ1LCJpc3MiOiJjb2Jpcy1idDItand0IiwiY2JzVG9rZW5QYXlsb2FkIjp7ImN1c3RvbWVySWQiOiIxMzA4MCIsImNvYmlzU2Vzc2lvbklkIjoiSUQ6NDY3QzQ2N0U3QjdDMzQ0NDdCN0M0NjdFMzQzMDQ2MzQ3QjM0NDY2NTQ2M0I0NjdCN0IzNDYzNDQ2MzdDMzQ0NDdFNjM3RTU1N0M0NDdCN0UzNDQ0NDQ2RjVDNjM3QzM0Iiwic2Vzc2lvblRpbWVPdXQiOiI1IiwicGhvbmVOdW1iZXIiOiI1NTc0Mjg2OTI5IiwiZGV2aWNlSWQiOiIxMjM0NTYiLCJjdWx0dXJlIjoiRVMtRUMiLCJjbGllbnRJZCI6IjkyIn19.HLQsMBeRMn8aqqjBZHPZeU2nUd6VeEVF7WD_wLLt7r8");

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);
	}

	@Test
	@Ignore
	public void insertImage() throws Exception {
		// String jwt = login();
		String jwt = onboard();
		// System.out.println("Bearer ".concat(jwt));
		HttpPut httpPost = createHttpPut(INSERT_IMAGE);
		StringEntity se = new StringEntity("{\"alias\":\"Frase de prueba app1\",\"imageId\":\"7\", \"mode\":\"U\", \"otp\":\"1234\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		//httpPost.addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTYyMTcyMzIzLCJpc3MiOiJjb2Jpcy1idDItand0In0.XaTsAg0JEY0sdpKmMFqaOKW4GnsjiqoU9DB1cVTGRLQ");

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

	}

	@Test
	@Ignore
	public void getImage() throws Exception {
		//String jwt = login();
		String jwt = onboard();
		 System.out.println("Bearer ".concat(jwt));
		HttpPost httpPost =createHttpPost(GET_IMAGE);
		StringEntity se = new StringEntity("{\"login\":\"5574286929\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		// httpPost.addHeader("Authorization", "Bearer
		// eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTYwMzY3MjY2LCJpc3MiOiJjb2Jpcy1idDItand0IiwiY2JzVG9rZW5QYXlsb2FkIjp7ImN1c3RvbWVySWQiOiIxMzA4MCIsImNvYmlzU2Vzc2lvbklkIjoiSUQ6NDY3QzQ2N0U3QjdDMzQ0NDdCN0M0NjdFMzQzMDQ2MzQ3QjM0NDY2NTQ2M0I0NjdCN0IzNDYzNDQ2MzdDMzQ0NDVBNzczQjVBN0U3QzdCNzAzNDQ0N0M3NzdFNDY2MzM0IiwicGhvbmVOdW1iZXIiOiI1NTc0Mjg2OTI5IiwiY3VsdHVyZSI6IkVTLUVDIiwiY2xpZW50SWQiOiI5MiJ9fQ._ZbiG_K2H1McLBCLWRGvc81XK4ZjTSNaQucSMqP0VDM");

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

	}

	@Test
	@Ignore
	public void validateMail() throws Exception {
		// String jwt = login();
		// String jwt = onboard();
		// System.out.println("Bearer ".concat(jwt));
		HttpPost httpPost = createHttpPost(VALIDATE_MAIL);
		// StringEntity se = new
		// StringEntity("{\"mail\":\"santander.desarrollo@cobiscorp.com\"}");
		StringEntity se = new StringEntity("{\"mail\":\"josue.ortiz@bayteq.com\"}");
		httpPost.setEntity(se);

		// httpPost.addHeader("Authorization", "Bearer ".concat(jwt));
		// httpPost.addHeader("Authorization", "Bearer
		// eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDb2Jpc2NvcnAgQjJDIiwiZXhwIjoxNTYwMzY3MjY2LCJpc3MiOiJjb2Jpcy1idDItand0IiwiY2JzVG9rZW5QYXlsb2FkIjp7ImN1c3RvbWVySWQiOiIxMzA4MCIsImNvYmlzU2Vzc2lvbklkIjoiSUQ6NDY3QzQ2N0U3QjdDMzQ0NDdCN0M0NjdFMzQzMDQ2MzQ3QjM0NDY2NTQ2M0I0NjdCN0IzNDYzNDQ2MzdDMzQ0NDVBNzczQjVBN0U3QzdCNzAzNDQ0N0M3NzdFNDY2MzM0IiwicGhvbmVOdW1iZXIiOiI1NTc0Mjg2OTI5IiwiY3VsdHVyZSI6IkVTLUVDIiwiY2xpZW50SWQiOiI5MiJ9fQ._ZbiG_K2H1McLBCLWRGvc81XK4ZjTSNaQucSMqP0VDM");

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

	}

	public String login() throws Exception {
		HttpPost httpPost = createHttpPost(LOGIN);
		/*StringEntity se = new StringEntity(
				"{\"username\":\"5520181985\",\"password\":\"8508728474311914A9BA16166ADE9139FD969A893D4B9E5C215BCFF2D7B37161\",\"device\":\"123456\", \"culture\":\"ES-EC\"}");*/
		/*StringEntity se = new StringEntity(
				"{\"username\":\"5582800701\",\"password\":\"6C50204FC75C4CE3858561E9071B4353A0E045059540D35A2C63C0B7A3B22CDEA8449BF5F88664097C0867D9D3DAE17DDD6A4140068D5A336E533EA4638B84C74E3745B9ECD7CE6CD978267BD096B35B70A10DC821A92F445706398C0881289099662D0EB82CD057506E3CC8215C83E6DE0AB89438C8164ADB8CC04BE7679C7C\",\"device\":\"123456\", \"culture\":\"ES-EC\"}");*/
		StringEntity se = new StringEntity(
				"{\"username\":\"5579569375\",\"password\":\"2C8D339DC638F0B64CC8FD8792F37A1B30BB0AF140060AC6E448EDD400C756BF0BD48834B27AD9330656B10263392983633F882AEB4B1926E9F3A0F122E2578514B09B6E566360F9E19E1D20956F57E585483619B8E40F90E93B957CFB3C9FDB42915AA1B9E9FEFF0E93D44EAE25091A9ACECF6DAF45D04E7F2A3A46815A8E62\",\"device\":\"123456\", \"culture\":\"ES-EC\"}");
		
		httpPost.setEntity(se);
		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);
		return extractJwt(response);
	}

	public String onboard() throws Exception {
		HttpPost httpPost = createHttpPost(ONBOARD);

		// Para uo de bayteq
		// StringEntity se = new StringEntity("{\"codigo\": \"098780\"}");
		//StringEntity se = new StringEntity("{\"codigo\": \"039495\"}");
		// StringEntity se = new StringEntity("{\"codigo\": \"098590\"}");
		StringEntity se = new StringEntity("{\"codigo\": \"571671\"}"); //DEV4
		//"{\"username\":\"5579569375\",\"device\":\"123456\", \"culture\":\"ES-EC\"}"

		httpPost.setEntity(se);
		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);
		return extractJwt(response);
	}

	public String requestPhoneChange(String jwt) throws Exception {
		HttpPut httpPut = createHttpPut(CHANGE_PHONE);
		StringEntity se = new StringEntity("{\"numero\":\"123456789\"}");
		httpPut.setEntity(se);

		httpPut.addHeader("Authorization", "Bearer ".concat(jwt));

		HttpResponse response = httpclient.execute(httpPut);
		printResponse(response);

		return extractJwt(response);
	}

	public String confirmPhoneChangeOtp(String jwt) throws Exception {
		HttpPost httpPost = createHttpPost(CHANGE_PHONE);

		StringEntity se = new StringEntity("{\"requestId\":\"1\", \"otp\":\"90249\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

		return extractJwt(response);
	}

	public String sendNewPassword(String jwt) throws Exception {
		HttpPost httpPost = createHttpPost(REGISTER_PASSWORD);

		StringEntity se = new StringEntity("{\"value\":\"mypassword\"}");
		httpPost.setEntity(se);

		httpPost.addHeader("Authorization", "Bearer ".concat(jwt));

		HttpResponse response = httpclient.execute(httpPost);
		printResponse(response);

		return extractJwt(response);
	}

	private String extractJwt(HttpResponse response) {
		Header[] headers = response.getHeaders("cobis-jwt");
		if (headers.length > 0)
			return headers[0].getValue();
		System.out.println("cobis-jwt no esta en cabecera");
		return "";
	}

	private void printResponse(HttpResponse response) throws Exception {
		HttpEntity entity = response.getEntity();
		if (entity != null) {
			System.out.println(convert(entity.getContent()));
		}
		StatusLine statusLine = response.getStatusLine();
		if (statusLine.getStatusCode() != 200) {
			throw new Exception(statusLine.getStatusCode() + ": " + statusLine.getReasonPhrase());
		}
	}

	private HttpPost createHttpPost(String url) {
		HttpPost httpPost = new HttpPost(url);
		httpPost.addHeader("Content-Type", "application/json");
		return httpPost;
	}

	private HttpPut createHttpPut(String url) {
		HttpPut httpPut = new HttpPut(url);
		httpPut.addHeader("Content-Type", "application/json");
		return httpPut;
	}

	private HttpGet createHttpGet(String url) {
		HttpGet httpGet = new HttpGet(url);
		httpGet.addHeader("Content-Type", "application/json");
		return httpGet;
	}
	public String convert(InputStream inputStream) throws IOException {
		StringBuilder stringBuilder = new StringBuilder();
		String line = null;

		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}

		return stringBuilder.toString();
	}
	/**
	 * <h1>registerUser()</h1>
	 *  method for register new user and save date of phone
	 *  <br>
	 *  <h2>Example of request services</h2>
	 * <h1> 
	 * {
	 *  "value":"PASSWORD"
	 * ,"brandDevice":"NOKI2A"
	 * ,"modelDevice":"ATX20004"
	 * ,"versionOS":"Andorid2 Os oreo"
	 * , "carrier":"CLAR2O"
	 * }
	 * Debemos aregrar esto para que funcione debido a es un test
	 * jwt.addAttribute(JWT_TOKEN_OLD_PHONE_NUMBER_KEY, client.getTelefono());
 	 * </h1> 
	 * @throws Exception
	 */
	@Test
	@Ignore
	public void registerUser() throws Exception {		
		String jwt = onboard();
		out.println("**********************************************************");
		HttpPost httpPostRequest = createHttpPost(REGISTER_PASSWORD);
		httpPostRequest.addHeader("Authorization", "Bearer ".concat(jwt));
		Password passwordRequest = new Password();
		passwordRequest.setBrandDevice("NOKI2A");
		passwordRequest.setModelDevice("ATX20004");
		/* 1234 Contraseña*/
		passwordRequest.setValue("6C50204FC75C4CE3858561E9071B4353A0E045059540D35A2C63C0B7A3B22CDEA8449BF5F88664097C0867D9D3DAE17DDD6A4140068D5A336E533EA4638B84C74E3745B9ECD7CE6CD978267BD096B35B70A10DC821A92F445706398C0881289099662D0EB82CD057506E3CC8215C83E6DE0AB89438C8164ADB8CC04BE7679C7C");
		passwordRequest.setCarrier("Andorid2 Os oreo");
		passwordRequest.versionOS("CLAR2O");
		String passwordJson = new ObjectMapper().writeValueAsString(passwordRequest);
		StringEntity seJson = new StringEntity(passwordJson);
		httpPostRequest.setEntity(seJson);
		HttpResponse responseRegister = httpclient.execute(httpPostRequest);
		printResponse(responseRegister);
		out.println(responseRegister);
		//validation of success
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}
	
	@Test
	@Ignore
	public void QueryLoans() throws Exception{
		
		String jwt = login();
		System.out.println("************************** QueryLoans *******************************");
		
		HttpPost httpPostRequest = createHttpPost(GET_LOANS);
		httpPostRequest.addHeader("Authorization", "Bearer ".concat(jwt));
		
		StringEntity se = new StringEntity("{\"customerId\":\"6282\"}");
		httpPostRequest.setEntity(se);
		
		HttpResponse responseRegister = httpclient.execute(httpPostRequest);
		printResponse(responseRegister);
		System.out.println(responseRegister);
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}
	@Test
	@Ignore
	public void getLoanParameters() throws Exception{
		String jwt = login();
		System.out.println("************************** GetParameters *******************************");
		HttpPost httpReq = createHttpPost(GET_PARAM);
		httpReq.addHeader("Authorization", "Bearer ".concat(jwt));
		StringEntity se1 = new StringEntity("{\"loanId\":\"233510003228\"}"); //233450004020
		httpReq.setEntity(se1);
		HttpResponse responseRegister = httpclient.execute(httpReq);
		printResponse(responseRegister);
		System.out.println(responseRegister);
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}
	@Test
	@Ignore
	public void getGeneralParameters() throws Exception{
		String jwt = login();
		System.out.println("************************ getGeneralParameters *****************************");
		HttpGet httpReq = createHttpGet(GET_PARAM);
		httpReq.addHeader("Authorization", "Bearer ".concat(jwt));
		HttpResponse responseRegister = httpclient.execute(httpReq);
		printResponse(responseRegister);
		
		System.out.println(responseRegister);
		
		//validation of success
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}
	
	@Test
	@Ignore
	public void paymentServices() throws Exception {		
		String jwt =login();
		out.println("**********************************************************");
		HttpPost httpPostRequest = createHttpPost(PAYMENT_LOANS);
		httpPostRequest.addHeader("Authorization", "Bearer ".concat(jwt));
		
		ShapeOfPayment paymentRequest= new ShapeOfPayment();
		paymentRequest.setMaximumPayment(1500);
		paymentRequest.setMaximumPayment(75000);
		paymentRequest.setEmailClient("testing@cobis.com");
		paymentRequest.setDeadlinePayment(new Date().toString());
		paymentRequest.setReferencePayment("PG5456465465");
		paymentRequest.setValuePayment(7500);		
		
		String paymentRequesthttp = new ObjectMapper().writeValueAsString(paymentRequest);
		StringEntity seJson = new StringEntity(paymentRequesthttp);
		httpPostRequest.setEntity(seJson);
		HttpResponse responseRegister = httpclient.execute(httpPostRequest);
		//printResponse(responseRegister);
		out.println(responseRegister);
		//validation of success
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}
	@Test
	@Ignore
	public void WebpayPayment() throws Exception{
		
		String jwt = login();
		System.out.println("************************** WebpayPayment *******************************");
		
		HttpPost httpPostRequest = createHttpPost(PAY_WEBPAY_EP);
		httpPostRequest.addHeader("Authorization", "Bearer ".concat(jwt));
		
		StringEntity se = new StringEntity("strResponse=5mBf1dZcU5%2F4u2U4FIDpIVnIuLR7yjxkQEAgRmb%2FoqJzON2M7HTDWhFgjGZtnCG0%0D%0AFSh7TIlgrLiNCNMgW8G8MRrAAcwakKS8maVxUhC%2FGT8wjhkOpc3CnjxHctxn%2F7Zy%0D%0A2KlKmwTvd6zj%2BLHzpVvoQbon3B6d58XjXkGMu965RHBxJIZ7E660CQM3qh%2FYWbwv%0D%0AerB%2FSuM8m%2BesVX7bicbFuOJnfyJodFNkDXDPWE1Q7mPBV87XC%2FZpiC3Aa0oRIMMi%0D%0AMxJ5iLM4ch7V4hYsLMJHZWwN3vOpletj2JvT0I8oyk6%2BO14A8u2FZwHai2jvOeHC%0D%0A%2B1UPrJvGmPbar2poUdecfrFmuFWakHZKAriLYE0oKU5BbfH8oDpZW2wk7ganCK0B%0D%0AVnJ7C%2F7ajd8QAwd%2FRGImO8xBZpDimVBKoY7NRcutUHMYwIgYGC053GNWbDB73LeH%0D%0AxHsASsMyyzDFN%2BgTYUtoAE5tZq5G%2BAfGg6oHXR%2By2qNiH0SMxXC0Zu5Yq1LmrEBL%0D%0Ayr%2F8V%2B4iAkjl4WBSFp4Whkg64lksOkidNQCAsBBud8HCZp1pNr3J3Iqjc%2FRmZPmT%0D%0ASQZOqpZANKIXmfTxI1x5pxDROfobCBI7U%2FO4nQG5Kli4GBi%2BzzrYkCnW6uQrMWs1%0D%0AMxQI6WgwCRC1qnRoVy9E8gik04V23Bj64uQR9hixQvKDKNKudoUFbL%2FhS%2BtkgG%2FI%0D%0AOOWBFHxueKuWIAMtO6OJ1Qy4%2FH%2FKOmwowBONIR3sZCpJl9PlE7tdL%2FIOq3nD2TyI%0D%0ADpRm5WcqYee5wLEqkTZWmkDTftcgUgiAN3B%2FC2m8MryQfMRyZtlK%2BWBQEDnw%2Favp%0D%0A0XMeVZYcRqK3tlj95UvmtY76WeIO9M7n3AkdZFZxdh89yeX%2F5Y6t6gRdafU%2BKnB%2F%0D%0AhvHtTSgrkkpbLI%2B0nUizcPOJ9sYqpBC7wX%2B9fm4sIfjZkONZC%2F08ZkB5MkG%2F7CG1%0D%0A0EF30AqmlMVspqqGVcPy0uO%2BM9UbAgLk2N%2FU8%2FTDZiSoYOGqq93CbR50bluC6%2FdF%0D%0AI1%2BN8Eamm6XapwJ53sF0TPHNZZwPrllEwSVix8oqhWJ2l4ZDVaPw4ODcMMuXKYpg%0D%0Adedhz8MoZd%2BRQ0U6AmzGVwR%2FPQBj3%2F%2Blr0yIoLAcQQjV8thewPpEbhDK6jRS3%2BPF%0D%0Ao%2FWbr3%2FXLB58i2TtagAW%2FnlMbriUmhk4IeF0VIswiAa4oRBc8gM69u4LSOzhDpSy%0D%0AHYUnIxDbAOFdpX4pFmJ1IV5nR%2B7ly4O%2BTNLjHa8sanZCJEWtEVSB%2BKhk97sebQri%0D%0AHQ0CBEiDvKlAIBQLAVHnaA%3D%3D");
		httpPostRequest.setEntity(se);
		
		HttpResponse responseRegister = httpclient.execute(httpPostRequest);
		printResponse(responseRegister);
		System.out.println(responseRegister);
		assertEquals(responseRegister.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	}

}
