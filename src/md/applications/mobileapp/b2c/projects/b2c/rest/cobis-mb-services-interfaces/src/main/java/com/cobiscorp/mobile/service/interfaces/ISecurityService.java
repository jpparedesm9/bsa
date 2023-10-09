package com.cobiscorp.mobile.service.interfaces;

import java.util.List;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Answer;
import com.cobiscorp.mobile.model.ChangePasswordRequest;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.LoginResponse;
import com.cobiscorp.mobile.model.LogoutResponse;
import com.cobiscorp.mobile.model.Registration;
import com.cobiscorp.mobile.model.Question;

/**
 * @author josemiguel.loor@ndeveloper.com
 * 
 */
public interface ISecurityService {

	/**
	 * Realiza el login contra CTS
	 * 
	 * @param credentials credenciales del usuario
	 * @param channel     constante del sistema (valor 8)
	 * @return el cobis session id
	 * @throws MobileServiceException
	 */
	LoginResponse login(Credentials credentials, Integer channel, boolean isEncrypted) throws MobileServiceException;

	/**
	 * Finaliza la sesion contra CTS
	 * 
	 * @param cobisSessionId
	 * @param phoneNumber
	 */
	LogoutResponse logout(String cobisSessionId, String phoneNumber, String deviceId) throws MobileServiceException;

	/**
	 * Recupera las preguntas de seguridad para un usuario
	 * 
	 * @param customerId
	 * @return
	 * @throws MobileServiceException
	 */
	List<Question> findSecurityQuestions(Integer customerId) throws MobileServiceException;

	/**
	 * Valida las respuestas de las preguntas de seguridad
	 * 
	 * @param answers
	 * @throws MobileServiceException
	 */
	void validateSecurityAnswers(Integer customerId, List<Answer> answers) throws MobileServiceException;

	/**
	 * Cambia el password del usuario
	 * 
	 * @param client         objeto con el id del cliente
	 * @param changePassword objeto con la data de la clave a cambiar
	 * @throws MobileServiceException
	 */
	void changePassword(Client client, ChangePasswordRequest changePassword, String cobisSessionId)
			throws MobileServiceException;

	/**
	 * Resetea el password del usuario
	 * 
	 * @param customerId
	 * @param phone
	 * @param password
	 * @throws MobileServiceException
	 */
	void resetPassword(String customerId, String phone, String password) throws MobileServiceException;

	/**
	 * Bloquea temporalmente la cuenta de un usuario
	 * 
	 * @param phone
	 * @param clientId
	 * @param cobisSessionId TODO
	 * @throws MobileServiceException
	 */
	void temporalBlock(String phone, String clientId, String cobisSessionId) throws MobileServiceException;

	/**
	 * Desbloquea una cuenta temporalmente la cuenta de un usuario
	 * 
	 * @param phone
	 * @param phone
	 * @param customerId
	 * @param password
	 * @throws MobileServiceException
	 */
	void unblock(String phone, Integer customerId, List<Answer> answers) throws MobileServiceException;

	Registration validateRegistration(Registration registration) throws MobileServiceException;

	

}
