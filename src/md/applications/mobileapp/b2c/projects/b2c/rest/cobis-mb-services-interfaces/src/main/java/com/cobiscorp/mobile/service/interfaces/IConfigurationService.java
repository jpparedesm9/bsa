package com.cobiscorp.mobile.service.interfaces;

import java.util.List;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.mobile.model.ExecuteMessageRequest;
import com.cobiscorp.mobile.model.GeneralParameters;
import com.cobiscorp.mobile.model.Notification;
import com.cobiscorp.mobile.model.TransactionInfo;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

public interface IConfigurationService {

	/**
	 * Obtains general parameters for the user
	 * 
	 * @param cobisSessionId
	 * @param customerId
	 * @return
	 * @throws MobileServiceException
	 */
	GeneralParameters getGeneralParameters(String cobisSessionId, String loanId, Integer customerId)
			throws MobileServiceException;

	/**
	 * Obtains notifications for the user
	 * 
	 * @param cobisSessionId
	 * @param customerId
	 * @return
	 * @throws MobileServiceException
	 */
	List<Notification> getNotifications(String cobisSessionId, Integer customerId) throws MobileServiceException;

	/**
	 * Executes a message
	 * 
	 * @param cobisSessionId
	 * @param request
	 * @throws MobileServiceException
	 */
	TransactionInfo executeNotification(String cobisSessionId, ExecuteMessageRequest request)
			throws MobileServiceException;

	/**
	 * 
	 * @param cobisSessionId
	 * @param messageId
	 * @param customerId
	 * @return
	 * @throws MobileServiceException
	 */
	Notification getNotification(String cobisSessionId, String messageId, Integer customerId)
			throws MobileServiceException;

	/**
	 * 
	 * @param paramNemonic
	 * @param paramNemonic
	 * @param cobisSessionId
	 * @return
	 * @throws MobileServiceException
	 */
	String getParameterValue(String paramNemonic, String productNemonic, String cobisSessionId)
			throws MobileServiceException;
	
	/**
	 * 
	 * @param dateFormat
	 * @return
	 * @throws MobileServiceException
	 */
	String getProcessDate(int dateFormat) throws MobileServiceException;
	
	
	/**
	 * Registro de Geolocalizacion Bancaria 
	 *
	 * @param aBankGeoloc
	 * @param cobisSessionId
	 * @throws MobileServiceException
	 */
	ServiceResponseTO registerBankGeolocation(BankGeolocation aBankGeoloc) throws MobileServiceException;
}