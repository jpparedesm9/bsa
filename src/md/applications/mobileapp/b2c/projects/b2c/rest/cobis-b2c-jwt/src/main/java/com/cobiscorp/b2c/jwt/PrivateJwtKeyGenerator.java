package com.cobiscorp.b2c.jwt;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.Key;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class PrivateJwtKeyGenerator implements JwtKeyGenerator {
	private ILogger logger = LogFactory.getLogger(PrivateJwtKeyGenerator.class);


    public Key genKey() {
        KeyStore store;
        try {
            store = KeyStore.getInstance("JKS");
            store.load(new FileInputStream("/home/pablo/proyectos/cobis/santander/cobis-b2c-jwt/keystore.jks"), "changeit".toCharArray());
            if (logger.isDebugEnabled()) {
    			logger.logDebug("store listo");
    		}
            PrivateKey privateKey = (PrivateKey) store.getKey("b2c_key", "changeit".toCharArray());
            if (logger.isDebugEnabled()) {
    			logger.logDebug("listoooooooooooo");
    			logger.logDebug(privateKey);
    		}
            return privateKey;
        } catch (KeyStoreException e) {        	
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        } catch (NoSuchAlgorithmException e) {
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        } catch (CertificateException e) {
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        } catch (FileNotFoundException e) {
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        } catch (IOException e) {
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        } catch (UnrecoverableKeyException e) {
        	if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
        }
        return null;
    }

}
