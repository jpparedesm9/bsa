package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.LinkConditionDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.LinkConditionService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.workflow.ProcessQueryManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public class LinkConditionServiceImpl implements LinkConditionService {

	private LinkConditionDao linkConditionDao;
	private VariableService variableService;
	private ResultService resultService;

	static Logger log = Logger.getLogger(ProcessQueryManager.class);

	/**
	 * @return the linkConditionDao
	 */
	public LinkConditionDao getLinkConditionDao() {
		return linkConditionDao;
	}

	/**
	 * @param linkConditionDao
	 *            the linkConditionDao to set
	 */
	public void setLinkConditionDao(LinkConditionDao linkConditionDao) {
		this.linkConditionDao = linkConditionDao;
	}

	/**
	 * @return the variableService
	 */
	public VariableService getVariableService() {
		return variableService;
	}

	/**
	 * @param variableService
	 *            the variableService to set
	 */
	public void setVariableService(VariableService variableService) {
		this.variableService = variableService;
	}

	/**
	 * @return the resultService
	 */
	public ResultService getResultService() {
		return resultService;
	}

	/**
	 * @param resultService
	 *            the resultService to set
	 */
	public void setResultService(ResultService resultService) {
		this.resultService = resultService;
	}

	public List<LinkCondition> findByLink(Integer idLink) {
		List<LinkCondition> linkConditionList = linkConditionDao.findByLink(idLink);
		for (LinkCondition linkCondition : linkConditionList) {
			linkCondition.setCondition(replaceExpression(linkCondition.getCondition()));
		}
		return linkConditionList;
	}

	@SuppressWarnings("unused")
	private String replaceExpression(String expression) {

		log.debug("Expression a ser modificada----->" + expression);

		// Declaro variables a utilizar
		String expressionModified = "";
		String expressionTemp = "";
		String expressionEvaluated = new String(expression);
		String beforeValue = "";

		for (int i = 0; i < expressionEvaluated.length(); i++) {
			String valueExpression = "";
			String caracter = String.valueOf(expressionEvaluated.charAt(i)).trim();

			if (caracter.equals("#")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("#"));
				i = expressionTemp.indexOf("#") + i + 1;

				log.debug("valueExpression----->" + valueExpression);

				Variable variable = variableService.findById(new Short("" + valueExpression));
				if (variable != null) {
					expressionModified = expressionModified + "#" + variable.getAbreviaturaVariable().trim() + "#";
				}

			} else if (caracter.equals("%")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("%"));
				i = expressionTemp.indexOf("%") + i + 1;

				log.debug("valueExpression----->" + valueExpression);
				Result result = resultService.findById(Integer.valueOf(valueExpression));
				if (result != null) {
					expressionModified = expressionModified + "%" + result.getName().trim() + "%";
				}

			} else {

				expressionModified = expressionModified + caracter;
				
				log.debug("expressionModified---------------->"+expressionModified);

			}
			beforeValue = caracter;
		}

		return expressionModified;
	}

}
