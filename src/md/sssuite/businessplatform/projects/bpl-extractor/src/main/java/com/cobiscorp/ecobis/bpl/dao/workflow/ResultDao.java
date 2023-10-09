package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

/**
 * @author srojas
 * 
 */
public interface ResultDao {

	/**
	 * @description Find all results
	 * @return
	 */
	List<Result> findAllResults() throws Exception;

	/**
	 * @description Find a result by name
	 * @param name
	 * @return
	 */
	Result findResultByName(String name) throws Exception;

	Result saveResult(Result result) throws Exception;

	Result findAndSave(Result result, DriverManagerDataSource dataSource) throws Exception;

	Result findById(Integer idResult);

}
