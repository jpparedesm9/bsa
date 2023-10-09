package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.LinkConditionDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.LinkDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.StepDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.LinkService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.StepService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdLinkCondition;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class LinkServiceImpl implements LinkService {

	private LinkDao linkDao;
	private LinkConditionDao linkConditionDao;
	private VariableService variableService;
	private ResultService resultService;
	private StepService stepService;

	static Logger log = Logger.getLogger(LinkServiceImpl.class);

	/**
	 * @return the linkDao
	 */
	public LinkDao getLinkDao() {
		return linkDao;
	}

	/**
	 * @param linkDao
	 *            the linkDao to set
	 */
	public void setLinkDao(LinkDao linkDao) {
		this.linkDao = linkDao;
	}

	public LinkConditionDao getLinkConditionDao() {
		return linkConditionDao;
	}

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

	/**
	 * @return the stepService
	 */
	public StepService getStepService() {
		return stepService;
	}

	/**
	 * @param stepService
	 *            the stepService to set
	 */
	public void setStepService(StepService stepService) {
		this.stepService = stepService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.service.workflow.LinkService#findLinkByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	public List<Link> findLinkByProcessVersion(Integer idProcess, Short version) {

		List<Link> linkList = new ArrayList<Link>();

		for (Link link : linkDao.findLinkByProcessVersion(idProcess, version)) {
			Link linkNew = new Link();
			linkNew.setFinalStep(link.getFinalStep());
			linkNew.setIdLink(link.getIdLink());
			linkNew.setIdProcess(link.getIdProcess());
			linkNew.setInitialStep(link.getInitialStep());
			linkNew.setLinkConditionList(new ArrayList<LinkCondition>());
			linkNew.setName(link.getName());
			linkNew.setPoints(link.getPoints());
			linkNew.setProcessVersion(link.getProcessVersion());
			linkNew.setReturnLink(link.getReturnLink());
			linkNew.setVersion(link.getVersion());

			linkList.add(linkNew);

		}

		return linkList;
	}

	public void saveLink(Process process, ProcessVersion processVersion, ProcessVersion searchedProcessVersion, DriverManagerDataSource dataSource)
			throws Exception {
		List<Link> newLinks = new ArrayList<Link>();

		try {

			List<Link> links = processVersion.getLinkList();

			for (Link link : links) {
				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

				Link newLink = new Link();
				newLink.setIdLink(seqnos.execute("wf_enlace"));
				log.debug(newLink.getIdLink());

				newLink.setProcessVersion(searchedProcessVersion);
				// log.debug("Process:" + process.getIdProcess() + "-" + searchedProcessVersion.getVersionProcess() + "-"
				// + link.getFinalStep().getActivity().getName() + "-" + link.getInitialStep().getActivity().getName());

				if (link.getFinalStep() != null) {
					log.debug("3_getFinalStep----------------------------->" + link.getFinalStep().getIdStep());
					Step finalStep = stepService.hmStepNew.get(link.getFinalStep().getIdStep());
					log.debug("finalStep: " + finalStep.getIdStep());
					newLink.setFinalStep(null);
					newLink.setIdFinalStep(finalStep.getIdStep());
				}

				if (link.getInitialStep() != null) {
					Step initialStep = stepService.hmStepNew.get(link.getInitialStep().getIdStep());
					log.debug("initialStep: " + initialStep.getIdStep());
					newLink.setInitialStep(null);
					newLink.setIdInitialStep(initialStep.getIdStep());
				}

				newLink.setIdProcess(process.getIdProcess());
				newLink.setLinkConditionList(new ArrayList<LinkCondition>());
				newLink.setName(link.getName());
				newLink.setPoints(link.getPoints());
				newLink.setReturnLink(link.getReturnLink());
				newLink.setVersion(searchedProcessVersion.getVersionProcess());

				for (LinkCondition linkCondition : link.getLinkConditionList()) {
					LinkCondition newLinkCondition = new LinkCondition();
					newLinkCondition.setCondition(replaceExpression(linkCondition.getCondition()));
					newLinkCondition.setRequirement(linkCondition.getRequirement());
					newLinkCondition.setSignatureNumber(linkCondition.getSignatureNumber());
					newLinkCondition.setLink(newLink);
					newLinkCondition.setVersionProcess(searchedProcessVersion.getVersionProcess());
					newLinkCondition.setIdLinkCondition(new IdLinkCondition(newLink.getIdLink()));
					newLinkCondition.setIdProcess(process.getIdProcess());
					newLink.getLinkConditionList().add(newLinkCondition);
				}
				newLinks.add(newLink);
				saveLink(newLink);
			}
		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo saveLink", ex);
			ex.printStackTrace();
			throw ex;
		}

	}

	public Link saveLink(Link link) throws Exception {
		return linkDao.save(link);
	}

	@SuppressWarnings("unused")
	private String replaceExpression(String expression) throws Exception {

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

				Variable variable = variableService.findByAbreviaturaVariable(valueExpression);
				if (variable != null) {
					expressionModified = expressionModified + "#" + variable.getCodigoVariable() + "#";
				}

			} else if (caracter.equals("%")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("%"));
				i = expressionTemp.indexOf("%") + i + 1;

				log.debug("valueExpression----->" + valueExpression);
				Result result = resultService.findResultByName(valueExpression);
				if (result != null) {
					expressionModified = expressionModified + "%" + result.getIdResult() + "%";
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
