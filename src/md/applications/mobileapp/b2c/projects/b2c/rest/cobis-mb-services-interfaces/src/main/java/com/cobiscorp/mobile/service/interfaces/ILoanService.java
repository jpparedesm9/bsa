package com.cobiscorp.mobile.service.interfaces;

import java.math.BigDecimal;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.model.ClientInformation;
import com.cobiscorp.mobile.model.CreditlineInfo;
import com.cobiscorp.mobile.model.DisbursementRequest;
import com.cobiscorp.mobile.model.ElavonRequest;
import com.cobiscorp.mobile.model.ElavonResponse;
import com.cobiscorp.mobile.model.KYCFormRequestLocal;
import com.cobiscorp.mobile.model.LoanInfoRequest;
import com.cobiscorp.mobile.model.OperationCreateRequest;
import com.cobiscorp.mobile.model.OperationCreateResponse;
import com.cobiscorp.mobile.model.SimulationRequest;
import com.cobiscorp.mobile.model.SimulationResponse;
import com.cobiscorp.mobile.model.TransactionInfo;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

public interface ILoanService {

	/**
	 * Gets credit info for client
	 * 
	 * @param loanId
	 * @param cobisSessionId
	 * @return
	 * @throws MobileServiceException
	 */
	CreditlineInfo getCreditInfo(String loanId, String cobisSessionId) throws MobileServiceException;

	/**
	 * Gets loans info for client
	 * 
	 * @param customerId
	 * @param cobisSessionId
	 * @return
	 * @throws MobileServiceException
	 */
	ClientInformation getLoansInfo(LoanInfoRequest loanInfoRequest, String cobisSessionId) throws MobileServiceException;

	/**
	 * Prepares a disbursement
	 * 
	 * @param loanId
	 * @param amount
	 * @param tax
	 * @param commission
	 * @param capitalBalance
	 * @param customerId
	 * @param phone
	 * @throws MobileServiceException
	 */
	public void storeDisburse(String loanId, BigDecimal amount, BigDecimal tax, BigDecimal commission, BigDecimal capitalBalance, String customerId, String phone)
			throws MobileServiceException;

	/**
	 * Confirms a disbursement
	 * 
	 * @param loanId
	 * @param clientId
	 * @param customerId
	 * @param password
	 * @param cobisSessionId
	 * @throws MobileServiceException
	 */
	TransactionInfo applyDisburse(String loanId, String clientId, String login, String password, String cobisSessionId) throws MobileServiceException;

	/**
	 * Confirms a disbursement
	 * 
	 * @param loanId
	 * @param clientId
	 * @param customerId
	 * @param password
	 * @param cobisSessionId
	 * @throws MobileServiceException
	 */
	TransactionInfo applyGenerateReference(String loanId, String clientId, String login, String password, String cobisSessionId) throws MobileServiceException;

	/**
	 * Confirms a disbursement
	 * 
	 * @param ElavonRequest
	 * @param cobisSessionId
	 * @return ElavonResponse
	 * @throws MobileServiceException
	 */
	ElavonResponse getPayLeague(ElavonRequest elavonRequest, String cobisSessionId) throws MobileServiceException;

	/**
	 * Confirms a disbursement
	 * 
	 * @param String
	 * @return String
	 * @throws MobileServiceException
	 */
	String getEndPointElavon(String endPointRequest) throws MobileServiceException;

	/**
	 * Generar una simulacion
	 * 
	 * @param SimulationRequest (monto,plazo,periodicidad)
	 * @return SimulationResponse (valor: monto a pagar)
	 * @throws MobileServiceException
	 */
	SimulationResponse simulate(SimulationRequest simulationRequest, String sessionId) throws MobileServiceException;

	/**
	 * Crea operacion
	 * 
	 * @param OperationCreateRequest
	 * @return OperationResponse (pagos, tramite)
	 * @throws MobileServiceException
	 */
	OperationCreateResponse createOperation(OperationCreateRequest operationCreateRequest, String cobisSessionId) throws MobileServiceException;

	/**
	 * Generate desembolso de la operacion
	 * 
	 * @param DisbursementRequest
	 * @return BaseResponse (si es exitoso o no)
	 * @throws MobileServiceException
	 */
	ServiceResponseTO generateDisbursement(DisbursementRequest disbursementRequest, String sessionId) throws MobileServiceException;

	/**
	 * Guardar formulario KYC
	 * 
	 * @param KYCFormRequestLocal
	 * @return ServiceResponseTO (si es exitoso o no)
	 * @throws MobileServiceException
	 */
	ServiceResponseTO saveKYCForm(KYCFormRequestLocal kycFormRequestLocal, String sessionID) throws MobileServiceException;

}
