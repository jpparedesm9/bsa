package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public interface ResultService {
	static HashMap<String, Result> hmResult = new LinkedHashMap<String, Result>();

	List<Result> findAllResults() throws Exception;

	Result findResultByName(String name) throws Exception;

	Result saveResult(Result result) throws Exception;

	Result findAndSave(Result result, DriverManagerDataSource dataSource) throws Exception;
	
	Result findById(Integer idResult);
}
