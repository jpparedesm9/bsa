package com.cobiscorp.cobis.assets.reports.commons;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;

import com.cobiscorp.cobis.assets.reports.service.BaseService;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.designer.api.DataEntity;
import com.lowagie.text.pdf.Barcode128;
import com.lowagie.text.pdf.BarcodeEAN;

import cobiscorp.ecobis.assets.cloud.dto.HpCatalogRequest;
import cobiscorp.ecobis.assets.cloud.dto.HpCatalogResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * 
 * Generador de codigos de barras
 * 
 * @author fsanmiguel
 * 
 */
public class BarCodeGenerator extends BaseService {
	private static final String CL_INSTITUTION_BARCODES = "cl_institution_barcodes";
	private static final String RETURN_HP_CATALOG_RESPONSE = "returnHpCatalogResponse";
	private static final String CL_OFFICES_BARCODES = "cl_offices_barcodes";

	private static final ILogger logger = LogFactory.getLogger(BarCodeGenerator.class);

	private static final String SANS_SERIF = "SansSerif";
	private static final String INHPCATALOGREQUEST = "inHpCatalogRequest";

	private ICTSServiceIntegration serviceIntegration;

	public BarCodeGenerator(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Retorna el codigo de barras en imagen si la oficina y la institucion permite
	 * codigos de barras
	 * 
	 * @param code
	 * @param office
	 * 
	 * @return {@link BufferedImage}
	 */
	public BufferedImage createBarCode128(String code, String office, String institution) {
//      Se comenta debido a que ya no existe restriccion de oficinas para generar el codigo
//		if (validateOfficeBarCode(office) && validateInstitutionBarCode(institution)) {		
		if (validateInstitutionBarCode(institution)) {
			return createBarCode128(code);
		}
		return null;
	}

	/**
	 * Retorna el codigo de barras en imagen si la institucion permite codigos de
	 * barras
	 * 
	 * @param code
	 * @param office
	 * 
	 * @return {@link BufferedImage}
	 */
	public BufferedImage createBarCode128(String code, String institution) {

		if (validateInstitutionBarCode(institution)) {
			return createBarCode128(code);
		}
		return null;
	}

	/**
	 * Valida la oficina que permite agregar el oodigo de barras
	 * 
	 * @param office
	 * @return {@link Boolean}
	 */
	private boolean validateOfficeBarCode(String office) {
		HpCatalogRequest hpCatalogRequest = new HpCatalogRequest();
		hpCatalogRequest.setType('A');
		hpCatalogRequest.setTable(CL_OFFICES_BARCODES);

		ServiceRequestTO serviceRequest = getHeaderRequest(ConstantValue.GETCATALOG_SERVICE_ID);
		serviceRequest.addValue(INHPCATALOGREQUEST, hpCatalogRequest);
		try {
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceRequest);
			if (serviceResponseTo.isSuccess()) {
				HpCatalogResponse[] hpCatalogResponse = (HpCatalogResponse[]) serviceResponseTo
						.getValue(RETURN_HP_CATALOG_RESPONSE);

				if (hpCatalogResponse != null) {
					for (HpCatalogResponse hpcatalog : hpCatalogResponse) {
						if (hpcatalog.getValue().equalsIgnoreCase(office)) {
							return true;
						}
					}
				}

			}
		} catch (Exception ex) {

			logger.logError("Error validando la officina", ex);
		}

		return false;
	}

	/**
	 * Valida la institucion que permite agregar el oodigo de barras
	 * 
	 * @param institution
	 * @return {@link Boolean}
	 */
	private boolean validateInstitutionBarCode(String institution) {
		HpCatalogRequest hpCatalogRequest = new HpCatalogRequest();
		hpCatalogRequest.setType('A');
		hpCatalogRequest.setTable(CL_INSTITUTION_BARCODES);

		ServiceRequestTO serviceRequest = getHeaderRequest(ConstantValue.GETCATALOG_SERVICE_ID);
		serviceRequest.addValue(INHPCATALOGREQUEST, hpCatalogRequest);

		try {
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceRequest);
			if (serviceResponseTo.isSuccess()) {
				HpCatalogResponse[] hpCatalogResponse = (HpCatalogResponse[]) serviceResponseTo
						.getValue(RETURN_HP_CATALOG_RESPONSE);
				if (hpCatalogResponse != null) {
					for (HpCatalogResponse hpcatalog : hpCatalogResponse) {
						if (hpcatalog.getValue().equalsIgnoreCase(institution)) {
							return true;
						}
					}
				}
			}
		} catch (Exception ex) {

			logger.logError("Error validando la institucion", ex);
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
