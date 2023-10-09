package com.cobiscorp.ecobis.customer.bl;

import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public interface ClientManager {
	/**
	 * Create a Client with DTO ClientDTO, return ClientDTO if not errors and null if having errors
	 *
	 */
	public ClientDTO createClient(ClientDTO client);
}
