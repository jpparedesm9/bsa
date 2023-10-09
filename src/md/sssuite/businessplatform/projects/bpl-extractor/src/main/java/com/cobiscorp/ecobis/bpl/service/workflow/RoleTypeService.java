package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;

public interface RoleTypeService {

	/**
	 * Recupera el RoleType por idRole
	 * 
	 * @return
	 */
	List<RoleType> findByRole(Integer idRole);

	/**
	 * @param roleType
	 * @return
	 */
	RoleType save(RoleType roleType);

}
