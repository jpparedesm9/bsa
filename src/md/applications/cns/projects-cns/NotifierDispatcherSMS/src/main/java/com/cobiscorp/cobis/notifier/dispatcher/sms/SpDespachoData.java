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

import com.cobiscorp.airmovil.client.NotificationRestClientAirmovil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.DataSms;

public class SpDespachoData extends StoredProcedure {

	private static final ILogger logger = LogFactory.getLogger(SpDespachoData.class);

	public SpDespachoData(DataSource ds, String name) {
		super(ds, name);

		declareParameter(new SqlParameter("@i_id_plantilla", Types.VARCHAR));
		declareParameter(new SqlParameter("@i_operacion", Types.CHAR));
		declareParameter(new SqlParameter("@i_cliente", Types.VARCHAR));
		declareParameter(new SqlParameter("@i_bloque", Types.INTEGER));

		declareParameter(new SqlReturnResultSet("Notifications", new RowMapper<DataSms>() {

			@Override
			public DataSms mapRow(ResultSet rs, int a) throws SQLException {
				DataSms dto = new DataSms();

				dto.setKey(rs.getString("KEY"));
				dto.setValue(rs.getString("VALOR"));
				dto.setType(rs.getString("TIPO"));

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

		SpDespachoData sp = new SpDespachoData(dataSource, "sp_despacho_sms_ins");
		Map<String, Object> inputParam = new HashMap<>();
		inputParam.put("@i_operacion", "Q");
		inputParam.put("@i_id_plantilla", "304162");
		inputParam.put("@i_cliente", 100);
		inputParam.put("@i_bloque", 1);

		Map<String, Object> result = sp.execute(inputParam);
		List<DataSms> a = (List<DataSms>) result.get("Notifications");

		for (DataSms not : a) {
			logger.logDebug(not);

		}

		for (DataSms dataSms : a) {
			if (dataSms.getKey().equals("Buc")) {
				logger.logDebug(dataSms.getValue());
			} else {
				logger.logDebug("Elemento no encotrado");
			}
		}

	}
}
