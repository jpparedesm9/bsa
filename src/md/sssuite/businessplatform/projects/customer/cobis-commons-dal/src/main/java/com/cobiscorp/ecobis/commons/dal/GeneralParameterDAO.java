package com.cobiscorp.ecobis.commons.dal;

import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameter;
import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameterId;

public interface GeneralParameterDAO {
	
	/**
	 * This method is used to obtain the parameter information of the table "cl_parametro" by the product and mnemonic.
	 * @param key, It's the parameter code.
	 * @return Parameter information.
	 */
	public abstract GeneralParameter getParameter (GeneralParameterId key);
	
	/**
	 * This method is used to obtain the parameter information of the table "cl_parametro" by the mnemonic.
	 * @param key, It's the parameter code.
	 * @return Parameter information.
	 */
	public abstract GeneralParameter getParameterByMnemonic (GeneralParameterId key);

}
