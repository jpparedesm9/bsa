package com.cobiscorp.ecobis.bpl.util.workflow;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.object.StoredProcedure;

public class ProcessVersionProcedureManager extends StoredProcedure {

	private static final String SQL = "cob_workflow..sp_version_proc_wf";
	static Logger log = Logger.getLogger(ProcessVersionProcedureManager.class);

	public ProcessVersionProcedureManager(DriverManagerDataSource dataSource) {
		super(dataSource, SQL);

		declareParameter(new SqlParameter("@s_ssn", Types.INTEGER));
		declareParameter(new SqlParameter("@s_user", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_sesn", Types.INTEGER));
		declareParameter(new SqlParameter("@s_term", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_date", Types.DATE));
		declareParameter(new SqlParameter("@s_srv", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_lsrv", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_ofi", Types.SMALLINT));
		declareParameter(new SqlParameter("@t_trn", Types.INTEGER));
		declareParameter(new SqlParameter("@t_debug", Types.CHAR));
		declareParameter(new SqlParameter("@t_file", Types.VARCHAR));
		declareParameter(new SqlParameter("@t_from", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_rol", Types.SMALLINT));
		declareParameter(new SqlParameter("@s_org_err", Types.CHAR));
		declareParameter(new SqlParameter("@s_error", Types.INTEGER));
		declareParameter(new SqlParameter("@s_sev", Types.TINYINT));
		declareParameter(new SqlParameter("@s_msg", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_org", Types.CHAR));
		declareParameter(new SqlParameter("@t_rty", Types.CHAR));

		declareParameter(new SqlParameter("@i_operacion", Types.CHAR));
		declareParameter(new SqlParameter("@i_codigo", Types.SMALLINT));
		declareParameter(new SqlParameter("@i_version", Types.SMALLINT));

		declareParameter(new SqlOutParameter("@o_tipo_error", Types.INTEGER));

		compile();
	}

	public int execute(int idProcess, int idProcessVersion, char operacion) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("@s_ssn", 0);
		parameters.put("@s_user", "");
		parameters.put("@s_sesn", 0);
		parameters.put("@s_term", 0);
		parameters.put("@s_date", null);
		parameters.put("@s_srv", "");
		parameters.put("@s_lsrv", "");
		parameters.put("@s_ofi", 0);
		parameters.put("@t_trn", 0);
		parameters.put("@t_debug", ' ');
		parameters.put("@t_file", "");
		parameters.put("@t_from", "");
		parameters.put("@s_rol", 0);
		parameters.put("@s_org_err", ' ');
		parameters.put("@s_error", 0);
		parameters.put("@s_sev", 0);
		parameters.put("@s_msg", "");
		parameters.put("@s_org", ' ');
		parameters.put("@t_rty", ' ');

		parameters.put("@i_operacion", operacion);
		parameters.put("@i_codigo", idProcess);
		parameters.put("@i_version", idProcessVersion);

		parameters.put("@o_tipo_error", 0);
		Map<String, Object> parametersReturn = execute(parameters);

		int retorno = 0;
		if (parametersReturn.get("@o_tipo_error") != null) {
			retorno = Integer.parseInt(parametersReturn.get("@o_tipo_error").toString());
		}
		return retorno;
	}
}
