package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.ConfirmDisbursementRequest;
import com.cobiscorp.mobile.model.LoanInfoRequest;
import com.cobiscorp.mobile.model.LoanRequest;
import com.cobiscorp.mobile.model.ShapeOfPayment;

/**
 * Credito en Línea
 *
 * <p>
 * Servicios para aplicación de crédito en
 *
 */
public interface IRestCreditService {

	public Response channelsMobilebankingLoanInfoPost(LoanInfoRequest loanInfoRequest, HttpServletRequest httpRequest);

	public Response channelsMobilebankingLoanPost(LoanRequest loanRequest, HttpServletRequest httpRequest);

	public Response channelsMobilebankingLoanPut(ConfirmDisbursementRequest confirmation, HttpServletRequest httpRequest);
	
	/**
	 * metodo de forma de pago
	 * @param shapeOfPayment
	 * @param httpRequest
	 * @return Response
	 */
	public Response channelsMobilebakingPayment(ShapeOfPayment shapeOfPayment,HttpServletRequest httpRequest);
	
}
