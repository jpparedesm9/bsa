package com.cobiscorp.cloud.scheduler.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.lowagie.text.pdf.Barcode128;
import com.lowagie.text.pdf.BarcodeEAN;

/**
 * 
 * Generador de codigos de barras
 * 
 * @author fsanmiguel
 * 
 */
public class BarCodeGenerator {
	private static final ILogger logger = LogFactory.getLogger(BarCodeGenerator.class);

	private static final String SANS_SERIF = "SansSerif";

	/**
	 * Retorna el codigo de barras en imagen validando institucion y oficina
	 * 
	 * @param code
	 * @param office
	 * @param institution
	 * @return {@link BufferedImage}
	 */
	public BufferedImage createBarCode128(String code, String office, String institution) {

		if (validateInstitutionBarCode(institution) && validateOfficeBarCode(office)) {
			return createBarCode128(code);
		}
		return null;
	}

	/**
	 * Valida si la oficina permite codigo de barras
	 * 
	 * @param office
	 * @return {@link Boolean}
	 */
	private Boolean validateOfficeBarCode(String office) {

		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;
		try {
			cn = ConnectionManager.newConnection();
			String query = "{ call cobis..sp_hp_catalogo(?,?,?) }";
			executeSP = cn.prepareCall(query);
			executeSP.setInt(1, 0);
			executeSP.setString(2, "A");
			executeSP.setString(3, "cl_offices_barcodes");
			boolean hasResult = executeSP.execute();
			
			if (hasResult) {
				ResultSet rs = executeSP.getResultSet();
				if(rs != null) {
					while(rs.next()) {
						String value = rs.getString(2);
						if (value.equalsIgnoreCase(office)) {
							rs.close();
							return true;
						}
					}
				}
			}

		} catch (Exception ex) {
			logger.logError("Error validando institucion", ex);
		}
		return false;
	}

	/**
	 * Valida si la institucion permite codigo de barras
	 * 
	 * @param office
	 * @return {@link Boolean}
	 */
	private Boolean validateInstitutionBarCode(String institution) {
		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;
		try {
			cn = ConnectionManager.newConnection();
			String query = "{ call cobis..sp_hp_catalogo(?,?,?) }";
			executeSP = cn.prepareCall(query);
			executeSP.setInt(1, 0);
			executeSP.setString(2, "A");
			executeSP.setString(3, "cl_institution_barcodes");
			boolean hasResult = executeSP.execute();
			
			if (hasResult) {
				ResultSet rs = executeSP.getResultSet();
				if(rs != null) {
					while(rs.next()) {
						String value = rs.getString(2);
						if (value.equalsIgnoreCase(institution)) {
							rs.close();
							return true;
						}
					}
				}
			}

		} catch (Exception ex) {
			logger.logError("Error validando institucion", ex);
		}
		return false;
	}

	/**
	 * Retorna el codigo de barras en imagen
	 * 
	 * @param code
	 * @return {@link BufferedImage}
	 */
	public BufferedImage createBarCode128(String code) {
		try {
			java.awt.Image im = getITextImageBarCode128(code);
			BufferedImage bi = new BufferedImage(im.getWidth(null), im.getHeight(null), BufferedImage.TYPE_INT_ARGB);
			Graphics bg = bi.getGraphics();
			bg.drawImage(im, 0, 0, null);
			bg.setColor(Color.WHITE);
			bg.setFont(new Font(SANS_SERIF, Font.PLAIN, 10));
			FontMetrics fm = bg.getFontMetrics();
			int textWidth = fm.stringWidth(code);
			bg.fillRect(0, bi.getHeight() - 9, bi.getWidth(), bi.getHeight());
			bg.setColor(Color.BLACK);
			bg.drawString(code, (bi.getWidth() / 2) - textWidth / 2, bi.getHeight());

			bg.dispose();
			return bi;

		} catch (Exception e) {
			logger.logError(e);
		}
		return null;

	}

	/**
	 * Retorna el codigo de barras en imagen
	 * 
	 * @param code
	 * @return {@link Image}
	 */
	private java.awt.Image getITextImageBarCode128(String code) {
		Barcode128 barcode = new Barcode128();
		barcode.setCodeType(BarcodeEAN.CODE128);
		barcode.setCode(code);
		barcode.setBarHeight(30);
		Color foreground = Color.BLACK;
		Color background = Color.WHITE;
		return barcode.createAwtImage(foreground, background);
	}

}
