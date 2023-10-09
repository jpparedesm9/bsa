package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import java.math.BigDecimal;

import org.apache.commons.lang.math.NumberUtils;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;

import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckResponse;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Biocheck {
	private Response response;
	private Signature signature;
	private String flag;
	private BigDecimal amount;
	private String sequential;
	private Integer instanceProcess;
	private String validateFingerPrint;
	private String hash;
	private TimeStamp timeStamp;
	private String status;

	// Getter Methods

	public String getSequential() {
		return sequential;
	}

	public String getValidateFingerPrint() {
		return validateFingerPrint;
	}

	public void setValidateFingerPrint(String validateFingerPrint) {
		this.validateFingerPrint = validateFingerPrint;
	}

	public Integer getInstanceProcess() {
		return instanceProcess;
	}

	public void setInstanceProcess(Integer instanceProcess) {
		this.instanceProcess = instanceProcess;
	}

	public void setSequential(String sequential) {
		this.sequential = sequential;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Response getResponse() {
		return response;
	}

	public Signature getSignature() {
		return signature;
	}

	// Setter Methods

	public void setResponse(Response responseObject) {
		this.response = responseObject;
	}

	public void setSignature(Signature signatureObject) {
		this.signature = signatureObject;
	}

	public String getHash() {
		return hash;
	}

	public void setHash(String hash) {
		this.hash = hash;
	}

	public TimeStamp getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(TimeStamp timeStamp) {
		this.timeStamp = timeStamp;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public CustomerBiocheckRequest toRequest(int customerId) {
		CustomerBiocheckRequest request = new CustomerBiocheckRequest();
		if (Parameter.N_FLAG.equalsIgnoreCase(this.getFlag())) {
			if (Parameter.BIOCHECK_OK.equalsIgnoreCase(this.getStatus())) {
				request.setLeftFinger(new Integer("100"));
				request.setRightFinger(new Integer("100"));
				request.setNoHash(this.getHash());
			}else { // if (Parameter.BIOCHECK_NOK.equalsIgnoreCase(this.getStatus())) {
				request.setLeftFinger(new Integer("0"));
				request.setRightFinger(new Integer("0"));
			}
		}
		request.setEnte(customerId);
		request.setFlag(this.getFlag());
		request.setAmount(this.getAmount().toPlainString());
		request.setSequential(this.getSequential());
		request.setInstance(this.getInstanceProcess());
		request.setValidateFingerPrint(this.getValidateFingerPrint());
		return request;
	}

	public Biocheck fromResponse(int customerId, CustomerBiocheckResponse customerBiocheckResponse) {
		Biocheck biocheckResponse = new Biocheck();
		Response responseObject = new Response();
		DataResponse dataResponseObject = new DataResponse();
		MinutiaeResponse minutiaeResponseObject = new MinutiaeResponse();
		RespuestaComparacion respuestaComparacionObject = new RespuestaComparacion();
		RespuestaSituacionRegistral respuestaSituacionRegistralObject = new RespuestaSituacionRegistral();

		respuestaComparacionObject
				.setAnioEmision(("TRUE".equals(customerBiocheckResponse.getYearEmission()) ? true : false));
		respuestaComparacionObject
				.setAnioRegistro(("TRUE".equals(customerBiocheckResponse.getYearRegistry()) ? true : false));
		respuestaComparacionObject
				.setApellidoMaterno(("TRUE".equals(customerBiocheckResponse.getMotherSurname()) ? true : false));
		respuestaComparacionObject
				.setApellidoPaterno(("TRUE".equals(customerBiocheckResponse.getSurname()) ? true : false));
		respuestaComparacionObject
				.setClaveElector(("TRUE".equals(customerBiocheckResponse.getVoterKey()) ? true : false));
		respuestaComparacionObject.setNombre(("TRUE".equals(customerBiocheckResponse.getName()) ? true : false));
		respuestaComparacionObject.setNumeroEmisionCredencial(
				("TRUE".equals(customerBiocheckResponse.getNoEmissionCredential()) ? true : false));
		dataResponseObject.setRespuestaComparacion(respuestaComparacionObject);
		dataResponseObject.setCodigoRespuestaDatos(customerId);
		minutiaeResponseObject.setSimilitud2(customerBiocheckResponse.getLeftFinger().toString());
		minutiaeResponseObject.setSimilitud7((customerBiocheckResponse.getRightFinger().toString()));
		respuestaSituacionRegistralObject.setTipoReporteRoboExtravio(customerBiocheckResponse.getTypeReportTheftLoss());
		respuestaSituacionRegistralObject
				.setTipoSituacionRegistral(customerBiocheckResponse.getTypeSituationRegistry());
		dataResponseObject.setRespuestaSituacionRegistral(respuestaSituacionRegistralObject);
		responseObject.setMinutiaeResponse(minutiaeResponseObject);
		responseObject.setDataResponse(dataResponseObject);
		// responseObject.setIndiceSolicitud(customerBiocheckResponse.getNoHash().toString());
		biocheckResponse.setResponse(responseObject);
		return biocheckResponse;
	}

	public static Integer processSimilitud(String similitud) {
		if (similitud != null) {
			String formated = similitud.replace("%", "").trim();
			if (NumberUtils.isNumber(formated)) {
				return Math.round(Float.parseFloat(formated));
			}
		}
		return 0;
	}

}
