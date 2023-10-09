package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ResultDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public class ResultServiceImpl implements ResultService {

	private ResultDao resultDao;

	public ResultDao getResultDao() {
		return resultDao;
	}

	public void setResultDao(ResultDao resultDao) {
		this.resultDao = resultDao;
	}

	public List<Result> findAllResults() throws Exception {
		return resultDao.findAllResults();
	}

	public Result findResultByName(String name) throws Exception {
		return resultDao.findResultByName(name);
	}

	public Result saveResult(Result result) throws Exception {
		return resultDao.saveResult(result);
	}

	public Result findAndSave(Result result, DriverManagerDataSource dataSource) throws Exception {

		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		Result searchResult = hmResult.get(result.getName());
		if (searchResult == null) {
			searchResult = findResultByName(result.getName());
			if (searchResult == null) {
				result.setIdResult(seqnos.execute("wf_resultado"));
				result = saveResult(result);
				hmResult.put(result.getName(), result);
				return result;
			} else {
				hmResult.put(searchResult.getName(), searchResult);
				return searchResult;
			}

		}

		return searchResult;

	}

	public Result findById(Integer idResult) {
		return resultDao.findById(idResult);
	}

}
