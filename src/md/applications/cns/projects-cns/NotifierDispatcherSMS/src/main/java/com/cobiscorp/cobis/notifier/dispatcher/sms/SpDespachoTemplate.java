package com.cobiscorp.cobis.notifier.dispatcher.sms;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.object.StoredProcedure;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.TemplateSms;

public class SpDespachoTemplate extends StoredProcedure {

	private static final ILogger logger = LogFactory.getLogger(SpDespachoTemplate.class);

	public SpDespachoTemplate(DataSource ds, String spname) {
		super(ds, spname);

		declareParameter(new SqlParameter("@i_id_plantilla", Types.VARCHAR));
		declareParameter(new SqlParameter("@i_operacion", Types.CHAR));
		declareParameter(new SqlParameter("@i_cliente", Types.VARCHAR));
		declareParameter(new SqlParameter("@i_bloque", Types.INTEGER));
		declareParameter(new SqlParameter("@i_valid_buc", Types.CHAR));

		declareParameter(new SqlReturnResultSet("Notifications", new RowMapper<TemplateSms>() {

			@Override
			public TemplateSms mapRow(ResultSet rs, int a) throws SQLException {
				TemplateSms dto = new TemplateSms();

				dto.setPlantilla(rs.getString("PLANTILLA"));
				dto.setVendor(rs.getInt("VENDOR"));
				dto.setEvento(rs.getInt("EVENTO"));
				dto.setNotificacion(rs.getInt("NOTIFICACION"));
				dto.setBuc(rs.getString("BUC"));

				return dto;
			}
		}));

	}

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		dataSource.setUrl(String.format("jdbc:sqlserver://%s;databaseName=%s;", "192.168.67.92", "cobis"));
		dataSource.setUsername("sa");
		dataSource.setPassword("Sqlcarga");

		SpDespachoTemplate sp = new SpDespachoTemplate(dataSource, "sp_despacho_sms_ins");
		Map<String, Object> inputParam = new HashMap<>();
		inputParam.put("@i_operacion", "P");
		inputParam.put("@i_id_plantilla", "304162");
		inputParam.put("@i_cliente", 100);
		inputParam.put("@i_bloque", 1);
		inputParam.put("@i_valid_buc", "S");

		Map<String, Object> result = sp.execute(inputParam);
		List<TemplateSms> a = (List<TemplateSms>) result.get("Notifications");

		for (TemplateSms not : a) {
			logger.logDebug(not);

		}

	}
}