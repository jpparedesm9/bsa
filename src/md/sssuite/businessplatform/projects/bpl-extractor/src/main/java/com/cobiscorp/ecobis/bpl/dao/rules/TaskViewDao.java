package com.cobiscorp.ecobis.bpl.dao.rules;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;

public interface TaskViewDao {

	/**
	 * Recupera los TaskView por idProcess ,version y idActivity
	 * 
	 * @return
	 */
	List<TaskView> findTaskViewByProcessVersion(Integer idProcess, Short versionProcess);

}
