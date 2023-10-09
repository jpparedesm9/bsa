package com.cobiscorp.ecobis.clientviewer.dal.utils;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;


public class Utils {

	/**
	 * Method used to map Objects to ConsolidatePositionDTO
	 * 
	 * @param key
	 *            , Number of resource for the message.
	 * @return A string with the message.
	 */
	
	public static List<ConsolidatePositionDTO> toConsolidatePositionDTO(
			List<Object[]> list) {
		List<ConsolidatePositionDTO> positionList = new ArrayList<ConsolidatePositionDTO>();

		for (Object[] consolidatePositionDTO : list) {
			ConsolidatePositionDTO item = new ConsolidatePositionDTO(
					validateData(consolidatePositionDTO[0]),
					validateData(consolidatePositionDTO[1]),
					validateData(consolidatePositionDTO[2]),
					validateDataDouble(consolidatePositionDTO[3]),
					validateData(consolidatePositionDTO[4]),
					validateData(consolidatePositionDTO[5]));

			positionList.add(item);
		}

		return positionList;
	}

	
	private static String validateData(Object obj) {
		return obj == null ? "" : obj.toString();

	}

	private static Double validateDataDouble(Object obj) {
		return (Double) (obj == null ? null : obj);
	}

}
