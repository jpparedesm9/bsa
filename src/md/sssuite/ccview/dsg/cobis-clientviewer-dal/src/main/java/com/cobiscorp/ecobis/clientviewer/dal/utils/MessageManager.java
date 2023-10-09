package com.cobiscorp.ecobis.clientviewer.dal.utils;

import java.text.MessageFormat;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class MessageManager {

	private static final String BUNDLE_NAME = "messages"; 

	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle
			.getBundle(BUNDLE_NAME);

	/**
	 * Method used to show message logs and exceptions.
	 * @param key, Number of resource for the message.
	 * @return A string with the message.
	 */
	public static String getString(String key) {
		try {
			return RESOURCE_BUNDLE.getString(key);
		} catch (MissingResourceException e) {
			return '!' + key + '!';
		}
	}
	
	/**
	 * Method used to show message logs and exceptions.
	 * @param key, Number of resource for the message.
	 * @param params, Object that provides essential information.
	 * @return A string with the message.
	 */
	public static String getString(String key, Object... params) {
        try {
            return MessageFormat.format(RESOURCE_BUNDLE.getString(key), params);
        } catch (MissingResourceException e) {
            return '!' + key + '!';
        }
    }
}
