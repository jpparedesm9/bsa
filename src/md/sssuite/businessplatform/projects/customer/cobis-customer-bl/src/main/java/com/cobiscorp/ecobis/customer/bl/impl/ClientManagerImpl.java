package com.cobiscorp.ecobis.customer.bl.impl;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.ClientManager;
import com.cobiscorp.ecobis.customer.dal.ClientDAO;
import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public class ClientManagerImpl implements ClientManager{
	
	ClientDAO clientDAO;
	
	public void setClientDAO(ClientDAO clientDAO) {
		this.clientDAO = clientDAO;
	}

	@Override
	public ClientDTO createClient(ClientDTO client) {
		try{
			if (client==null)
				throw new BusinessException(100016,"CLIENT IS EMPTY");
			else if(client.getProductDetail()==null)
				throw new BusinessException(100017,"PRODUCT DETAIL IS EMPTY");
			else if(client.getProductDetail().getCode()==null)
				throw new BusinessException(100018,"DETAIL PRODUCT NOT EXISTS");				
			
			clientDAO.createClient(client);
			return client;
		}
		catch(BusinessException ex){
			throw new BusinessException(100015,"NOT COULD CREATE CLIENT");
		}		
	}

}
