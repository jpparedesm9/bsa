package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;

public interface RoleTypeDao {

	List<RoleType> findByRole(Integer idRole);

	RoleType insert(RoleType roleType);

}
