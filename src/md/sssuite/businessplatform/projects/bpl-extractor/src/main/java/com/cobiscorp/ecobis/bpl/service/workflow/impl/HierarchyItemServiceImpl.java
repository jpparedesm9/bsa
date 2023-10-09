package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyItemService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public class HierarchyItemServiceImpl implements HierarchyItemService {

	private HierarchyItemDao hierarchyItemDao;
	private VariableService variableService;
	private ResultService resultService;

	static Logger log = Logger.getLogger(HierarchyItemServiceImpl.class);

	/**
	 * @return the hierarchyItemDao
	 */
	public HierarchyItemDao getHierarchyItemDao() {
		return hierarchyItemDao;
	}

	/**
	 * @param hierarchyItemDao
	 *            the hierarchyItemDao to set
	 */
	public void setHierarchyItemDao(HierarchyItemDao hierarchyItemDao) {
		this.hierarchyItemDao = hierarchyItemDao;
	}

	public VariableService getVariableService() {
		return variableService;
	}

	public void setVariableService(VariableService variableService) {
		this.variableService = variableService;
	}

	public ResultService getResultService() {
		return resultService;
	}

	public void setResultService(ResultService resultService) {
		this.resultService = resultService;
	}

	public List<HierarchyItem> findByHierarchyItemStep(Integer idStep) {
		List<HierarchyItem> hierarchyItemList = hierarchyItemDao.findByHierarchyItemStep(idStep);
		// HashMap<Integer, HierarchyItem> hmHierarchyItem = new HashMap<Integer, HierarchyItem>();
		for (HierarchyItem hierarchyItem : hierarchyItemList) {
			// if (!hmHierarchyItem.containsKey(hierarchyItem.getIdHierarchyItem().getIdHierarchyItemTpl())) {
			hierarchyItem.setIjCondiciones(replaceExpression(hierarchyItem.getIjCondiciones()));
			hierarchyItem.getHierarchyItemTpl().getHierarchyTypeTpl().setHierarchyLevelTplList(null);
			// hmHierarchyItem.put(hierarchyItem.getIdHierarchyItem().getIdHierarchyItemTpl(), hierarchyItem);
			// }
		}
		return hierarchyItemList;
	}

	@SuppressWarnings("unused")
	private String replaceExpression(String expression) {

		log.debug("Expression a ser modificada----->" + expression);

		// Declaro variables a utilizar
		String expressionModified = "";
		String expressionTemp = "";
		String expressionEvaluated = expression == null ? "%1%" : new String(expression);
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

				log.debug("expressionModified---------------->" + expressionModified);

			}
			beforeValue = caracter;
		}

		return expressionModified;
	}

}
