package com.cobiscorp.cloud.util.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.configuration.ConfigManager;

public class ConnectionManager {

	private static final Logger logger = Logger.getLogger(ConnectionManager.class);
	private static ConnectionManager connectionManager;

	private static Connection connection;

	private static Integer cont = 0;

	private ConnectionManager() {
	}

	public static ConnectionManager getInstance() {
		if (connectionManager == null) {
			connectionManager = new ConnectionManager();
		}
		return connectionManager;
	}

	public static synchronized Connection openConnection() throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia openConnection ConnectionUtil");
		}

		if (cont == 0) {
			ConfigManager ds = ConfigManager.getInstance();
			Class.forName(ds.getJdbDriver());

			connection = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza openConnection ConnectionUtil");
			}
		}

		cont++;
		logger.debug("openConnection Contador: " + cont);
		return connection;
	}

	public static synchronized void closeConnection() throws SQLException {

		try {
			if (logger.isDebugEnabled()) {
				logger.debug("Inicia closeConnection ");
			}
			cont--;
			if (cont == 0) {
				if (connection != null) {
					connection.close();
				}
			}
			logger.debug("closeConnection Contador: " + cont);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza closeConnection ");
			}
		}

	}

	public static synchronized Connection newConnection() throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia newConnection ConnectionUtil");
		}
		Connection connect;
		ConfigManager ds = ConfigManager.getInstance();
		Class.forName(ds.getJdbDriver());

		connect = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza newConnection ConnectionUtil");
		}

		return connect;
	}

	public static synchronized void saveConnection(Connection connect) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia saveConnection ConnectionUtil");
		}
		try {
			connect.close();
		} catch (SQLException e) {
			logger.error("Error al cerrar la conexión: ", e);
		} finally {
			logger.debug("Finaliza saveConnection ConnectionUtil");
		}
	}

	public static PreparedStatement executeQuery(String query, Map<Integer, Object> params) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia executeQuery " + params);
		}
		Connection con = openConnection();
		PreparedStatement ps = con.prepareStatement(query);
		// Itera el mapa de parametros
		for (Map.Entry<Integer, Object> entry : params.entrySet()) {
			ps.setObject(entry.getKey(), entry.getValue());

			if (logger.isDebugEnabled()) {
				logger.debug("Dentro de For parametros: " + entry.getKey() + "/" + entry.getValue());
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza executeQuery " + ps);
		}
		return ps;
	}
}
