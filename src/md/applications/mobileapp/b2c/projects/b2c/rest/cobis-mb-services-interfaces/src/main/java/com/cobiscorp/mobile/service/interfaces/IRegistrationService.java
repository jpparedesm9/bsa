package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.EnrollDevicelClient;
import com.cobiscorp.mobile.model.Password;

public interface IRegistrationService {

	/**
	 * Valida el codigo de 6 digitos recibido inicialmente
	 * 
	 * @param code
	 * @return
	 * @throws MobileServiceException
	 */
	Client validateOnboardCode(String code) throws MobileServiceException;

	/**
	 * Actualiza el numero de telefono
	 * 
	 * @param client
	 * @throws MobileServiceException
	 */
	void updateClientPhoneNumber(Integer clientId, String phoneNumber) throws MobileServiceException;

	/**
	 * Enrola al cliente en el servicio de banca mobile, debe realizar un login contra CTS
	 *  <H1>Este objeto EnrollDevicelClient </h1> contiene los siguientes atributos 
	 *<H1>---> phoneNumber numero de telefono del cliente </h1>
	 *<H1>---> password    nueva clave                    </h1>
	 *<H1>---> channel     constante del sistema (valor 8)</h1>
	 *<H1>---> clientId    id del cliente a enrolar       </h1>
	 *<H1>---> brandDevice marca del telefono             </h1>
	 *<H1>---> modelDevice modelo del telefono            </h1>
	 *<H1>---> versionOS   version sistema operativo      </h1>
	 *<H1>---> carrier     carrier o tipo de operador     </h1>
	 * @param EnrollDevicelClient -->contiene toda la informacion para el registro
	 * @throws MobileServiceException
	 */
	void enrollClient(EnrollDevicelClient enrolDevicelClient, boolean isEncrypted) throws MobileServiceException;
}
