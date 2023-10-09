package com.cobiscorp.ecobis.customer.services;

import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public interface ClientService {
	/**
	 * Create a Client with DetailProduct
	 *
	 */
	public ClientDTO createClient(ClientDTO client);
}
