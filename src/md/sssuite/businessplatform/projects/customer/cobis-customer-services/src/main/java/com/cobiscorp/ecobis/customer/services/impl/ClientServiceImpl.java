package com.cobiscorp.ecobis.customer.services.impl;

import com.cobiscorp.ecobis.customer.bl.ClientManager;
import com.cobiscorp.ecobis.customer.services.ClientService;
import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public class ClientServiceImpl implements ClientService{
	ClientManager clientManager;
	
	public void setClientManager(ClientManager clientManager) {
		this.clientManager = clientManager;
	}

	@Override
	public ClientDTO createClient(ClientDTO client) {
		return clientManager.createClient(client);
	}

}
