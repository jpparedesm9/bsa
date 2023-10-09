package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.Task;

/**
 * Procesos en Línea
 *
 * <p>
 * Servicios para aplicación de procesos en línea
 *
 */
public interface IRestProcessService {

	public Response getTaskList(HttpServletRequest httpRequest);

	public Response startProcess(HttpServletRequest httpRequest);

	public Response nextActivity(@Valid Task task, HttpServletRequest httpRequest);

}
