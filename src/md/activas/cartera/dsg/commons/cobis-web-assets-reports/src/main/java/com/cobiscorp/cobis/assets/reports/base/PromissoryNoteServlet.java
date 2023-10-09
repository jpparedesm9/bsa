package com.cobiscorp.cobis.assets.reports.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import cobiscorp.ecobis.assets.cloud.dto.ReportPromissoryNote;
import cobiscorp.ecobis.assets.cloud.dto.ReportPromissoryNoteRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.service.PromissoryNoteService;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class PromissoryNoteServlet extends BaseReportServlet {
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(PromissoryNoteServlet.class);

	private static ICTSServiceIntegration serviceIntegration;
	private static Map<String, Object> paramsUrl = new HashMap<String, Object>();
	private static PromissoryNoteService service = new PromissoryNoteService();

	public static void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		PromissoryNoteServlet.serviceIntegration = serviceIntegration;
	}

	public static void unsetServiceIntegration() {
		PromissoryNoteServlet.serviceIntegration = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		execute(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		execute(request, response);
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		try {
			// Setea el path donde se encuentra el reporte
			super.setReportJasperPath(ConstantValue.PATH_PROMISSORY_NOTE);
			// Recupera parametros enviados por la url y se agregan en el mapa
			// local
			String numOperation = request.getParameter(ConstantValue.NUM_OPERATION);
			paramsUrl.put(ConstantValue.NUM_OPERATION, numOperation);

			// genera reporte
			response.setContentType("application/pdf");
			super.generate(request, response);

		} catch (JRException e) {
			logger.logError("ERROR REPORT PROMISSORY NOTE", e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("END REPORT PROMISSORY NOTE");
			}
		}
	}

	@Override
	protected Map<String, Object> getParameters() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getParameters REPORT PROMISSORY NOTE");
		// Setea el mapa de parametros
		Util util = new Util();
		util.setParams(new HashMap<String, Object>());

		try {
			// logo de banco
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_LOGO, ConstantValue.URL_IMAGEN, ConstantValue.UNDEFINED_VALUE);
			// titulo reporte
			util.mapValuesToParams(ConstantValue.PARAM_REPORT_TITLE, ConstantValue.TITLE_PROMISSORY_NOTE, ConstantValue.UNDEFINED_VALUE);

		} catch (Exception e) {
			logger.logError("Exception PROMISSORY NOTE", e);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("END getParameters PROMISSORY NOTE");
		return util.getParams();
	}

	// Se listan los subreports
	@Override
	protected JRDataSource getJRDataSource() {
		if (logger.isDebugEnabled())
			logger.logDebug("START getDatasourceReport PromissoryNote");

		// Obtiene los parametros de la peticion HTTPServleRequest
		String numOperation = (String) paramsUrl.get(ConstantValue.NUM_OPERATION);

		ReportPromissoryNoteRequest reportPromissoryNoteRequest = new ReportPromissoryNoteRequest();
		reportPromissoryNoteRequest.setBank(numOperation);

		ReportPromissoryNote reportPromissoryNote = service.queryPromissoryNote(reportPromissoryNoteRequest, serviceIntegration);

		List<ReportPromissoryNote> reportPromissoryNotes = new ArrayList<ReportPromissoryNote>();
		reportPromissoryNotes.add(reportPromissoryNote);

		if (logger.isDebugEnabled())
			logger.logDebug("END getDatasourceReport PromissoryNote");

		return new JRBeanCollectionDataSource(reportPromissoryNotes, true);
	}
}
