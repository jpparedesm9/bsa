package com.cobiscorp.ecobis.bpl.util;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.object.StoredProcedure;

public class SeqnosProcedureManager extends StoredProcedure{
	
	private static final String SQL = "cobis..sp_cseqnos";

	public SeqnosProcedureManager(DriverManagerDataSource dataSource)
	{
		super(dataSource, SQL);
		declareParameter(new SqlParameter("@s_ssn", Types.INTEGER));
		declareParameter(new SqlParameter("@s_user", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_sesn", Types.INTEGER));
		declareParameter(new SqlParameter("@s_term", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_date", Types.DATE));
		declareParameter(new SqlParameter("@s_srv", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_lsrv", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_rol", Types.SMALLINT));
		declareParameter(new SqlParameter("@s_ofi", Types.SMALLINT));
		declareParameter(new SqlParameter("@s_org_err", Types.CHAR));
		declareParameter(new SqlParameter("@s_error", Types.INTEGER));
		declareParameter(new SqlParameter("@s_sev", Types.TINYINT));
		declareParameter(new SqlParameter("@s_msg", Types.VARCHAR));
		declareParameter(new SqlParameter("@s_org", Types.CHAR));
		declareParameter(new SqlParameter("@t_debug", Types.CHAR));
		declareParameter(new SqlParameter("@t_file", Types.VARCHAR));
		declareParameter(new SqlParameter("@t_from", Types.VARCHAR));
		
		declareParameter(new SqlParameter("@i_tabla", Types.VARCHAR));
		declareParameter(new SqlOutParameter("@o_siguiente", Types.INTEGER));
		compile();
	}
	
	public int execute(String table) {
	      Map<String, Object> parameters = new HashMap<String, Object>();
	      parameters.put("@s_ssn", 0);
	      parameters.put("@s_user", "");
	      parameters.put("@s_sesn", 0);
	      parameters.put("@s_term", 0);
	      parameters.put("@s_date", null);
	      parameters.put("@s_srv", "");
	      parameters.put("@s_lsrv", "");
	      parameters.put("@s_rol", 0);
	      parameters.put("@s_ofi", 0);
	      parameters.put("@s_org_err", " ");
	      parameters.put("@s_error", 0);
	      parameters.put("@s_sev", 0);
	      parameters.put("@s_msg", "");
	      parameters.put("@s_org", " ");
	      parameters.put("@t_debug"," ");
	      parameters.put("@t_file", "");
	      parameters.put("@t_from", "");
	      
	      parameters.put("@i_tabla", table);
	      parameters.put("@o_siguiente", 0);
	      Map<String, Object> parametersReturn = execute(parameters);
	      return Integer.parseInt(parametersReturn.get("@o_siguiente").toString());
	  }
}
