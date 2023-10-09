package com.cobiscorp.ecobis.fpm.portfolio.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;

public class PropertiesManager {

	private PropertiesManager() {
	}

	private static HashMap<String, String> mappings = new PropertiesManager().loadProperties();


	public static String getProperty(String key) {
		return mappings.get(key);
	}

	public static String getProperty(String key, String defaultValue) {
		return mappings.containsKey(key) ? mappings.get(key) : defaultValue;
	}
	
	public HashMap<String, String> loadProperties() {
		HashMap<String, String> _mappingsHashMap = new HashMap<String, String>();		
		try {
			InputStream is = this.getClass().getClassLoader().getResourceAsStream("mappingTypes.properties");
			System.out.println("*** input stream: "+is);
			Properties properties = new Properties();
			if (is != null) {
				properties.load(is);
				_mappingsHashMap = new HashMap<String, String>();
				for (Object key : properties.keySet()) {
					_mappingsHashMap.put(key.toString(),
							properties.getProperty(key.toString()));
				}
				is.close();
			}
		} catch (IOException io) {			
			io.printStackTrace();
			_mappingsHashMap = null;
		}
		return _mappingsHashMap;
	}

}
