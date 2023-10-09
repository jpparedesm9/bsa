package com.cobiscorp.ecobis.frm.business.service;

import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.frm.business.dto.FormAnswers;
import com.cobiscorp.ecobis.frm.business.exception.FormBusinessException;

public interface IFormBusinessService {
	Response getFormData(Integer id, Integer processInstance, String stage) throws FormBusinessException;

	Response saveAnswer(FormAnswers formAnswers) throws FormBusinessException;
}
