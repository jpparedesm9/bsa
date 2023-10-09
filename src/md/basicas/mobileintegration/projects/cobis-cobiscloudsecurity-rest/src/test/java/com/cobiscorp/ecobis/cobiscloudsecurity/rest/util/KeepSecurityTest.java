package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

public class KeepSecurityTest {

    String publicKey = "30819F300D06092A864886F70D010101050003818D0030818902818100A7ECEEC1ABBDA1C6F2736284BCDB855BA59E4A9A164D21B32992905C25858E75F58974E50A006BBDF2638D952EEA4C8B2D98164D9A45292B94A37FEE94D6E7D99358EFB49ACBC24D6FC2D6031A12269557B5FBEB65DDDB545B22543AB7F641A0B06EA04CA2F43868743DA49274C22E7EBFD5D27F53E6B9EBAE7741F900AAE0A10203010001";
    String privateKey = "30820275020100300D06092A864886F70D01010105000482025F3082025B02010002818100A7ECEEC1ABBDA1C6F2736284BCDB855BA59E4A9A164D21B32992905C25858E75F58974E50A006BBDF2638D952EEA4C8B2D98164D9A45292B94A37FEE94D6E7D99358EFB49ACBC24D6FC2D6031A12269557B5FBEB65DDDB545B22543AB7F641A0B06EA04CA2F43868743DA49274C22E7EBFD5D27F53E6B9EBAE7741F900AAE0A102030100010281802743C3600DA43D9BA33D4F9FF1F8F269C78407B597D95933E75899E0B1F554A6484F67C1D660DAD08348BBE6521DFEDFDC3D5F99ADA4D647966DD49018C55758AB6A0B15C902C3EA024FEE6A496A9DB31E67CB9AE9F003BE39467756740A417C7A284E997F5C7F8C0698877052BA060A82A50570501AA96EDAADD841829E8D01024100DDA234BCF2F2FA59596E0FF7D9A1EC8472944E843DDA3A1C76923D123FCF7382406E2922859C39C9C6E1996CE47FB3EE9E49E8E37C60D71903DC1CD36CDA1789024100C1F6C5A97886D71C02A716764E305BC863D8BD5415FD631A23B3075F5776911046E47431B320D11ABB73327DCD0798393FD34745D0860F91B65AF21AC554A25902400A78573575E4B49EF3F2971E865177F2E9D6C7BEC78D3FA188986FFA24B990235F17D529A4563504AB388D1EEFCC789B952EB8A9C67E6CAAE9DBC420D8CB94C1024024D2CEAFDFDBE996BDC22EF782DC977031D4820D26A7965AEE101D0432BCA5C9AB4BCFEB679081624BD810EBE532DDE9707E91F765212E6F81693EB16A6928F102402C25196793064AFBA9026DF581486B4C8A5D275D25401DBDF1C7C9C1C147B96EAE6D42939556302197C782AD60D6D21057652DE7CE92A5BEA729097518DBEF5C";
    KeepSecurity keepSecurity;

    @Before
    public void setup() {
        keepSecurity = new KeepSecurity(publicKey.toCharArray(), privateKey.toCharArray());
    }

    @Test
    public void generateKeys() throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException, IOException {
        int keySizeSugeridoParaEcommerceDividoPorDos = 1024;
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(keySizeSugeridoParaEcommerceDividoPorDos);
        KeyPair keyPair = keyPairGenerator.genKeyPair();


        System.out.println("public key:" + keyPair.getPublic());
        System.out.println("public key:" + keyPair.getPublic().getAlgorithm());
        System.out.println("public key:" + keyPair.getPublic().getFormat());
        System.out.println("Llave pública bytes hexa:" + ByteConverter.tranformToHex(keyPair.getPublic().getEncoded()) );
        System.out.println("private key:" + keyPair.getPrivate());
        System.out.println("Llave privada bytes hexa:" + ByteConverter.tranformToHex(keyPair.getPrivate().getEncoded()) );

        String outFile = "target/demo";
        FileOutputStream out = new FileOutputStream(outFile + ".key");
        out.write(keyPair.getPrivate().getEncoded());
        out.close();

        out = new FileOutputStream(outFile + ".pub");
        out.write(keyPair.getPublic().getEncoded());
        out.close();
    }

    @Test
    public void itShouldTestEncrypt() {
        String password = "PruebaPassword";
        byte[] bytesPassword = password.getBytes();
        String hexaBytesEncrypted = keepSecurity.encrypt(password.toCharArray());
        String recoverPassword = keepSecurity.decrypt(hexaBytesEncrypted);
        Assert.assertEquals(password, recoverPassword);
    }

    @Test
    public void itShouldTestKeyPair() throws IOException, InvalidKeySpecException, NoSuchAlgorithmException {
        byte[] privateKeyBytes = KeepSecurity.readBytes("src/test/java/com/cobiscorp/ecobis/cobiscloudsecurity/rest/util/mobkeyprod.key");
        byte[] publicKeyBytes = KeepSecurity.readBytes("src/test/java/com/cobiscorp/ecobis/cobiscloudsecurity/rest/util/mobkeyprod.pub");

        KeepSecurity keepSecurityTmp = new KeepSecurity(ByteConverter.tranformToHex(publicKeyBytes).toCharArray(),
                ByteConverter.tranformToHex(privateKeyBytes).toCharArray());
        String password = "PruebaPassword2006";
        String hexaBytesEncrypted = keepSecurityTmp.encrypt(password.toCharArray());
        String recoverPassword = keepSecurityTmp.decrypt(hexaBytesEncrypted);
        Assert.assertEquals(password, recoverPassword);

        String hexacPublicKey = getHexaBytesPublicKey(publicKeyBytes);
        System.out.println("hexacPublicKey:" + hexacPublicKey);

        keepSecurityTmp = new KeepSecurity(hexacPublicKey.toCharArray(),
                ByteConverter.tranformToHex(privateKeyBytes).toCharArray());
        hexaBytesEncrypted = keepSecurityTmp.encrypt(password.toCharArray());
        recoverPassword = keepSecurityTmp.decrypt(hexaBytesEncrypted);
        Assert.assertEquals(password, recoverPassword);

    }

    private String getHexaBytesPublicKey(byte[] publicKeyBytes) throws NoSuchAlgorithmException, InvalidKeySpecException {
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(KeepSecurity.KEY_FACTORY_INSTANCE);
        PublicKey pubKey = keyFactory.generatePublic(keySpec);
        return ByteConverter.tranformToHex(pubKey.getEncoded());
    }


    @Test
    public void itShouldTestEncrypt2() {
        keepSecurity = new KeepSecurity(null, privateKey.toCharArray());
        String password = "PruebaBayteq";
        String passwordEncryptedHex = "614F4FAF846797178339B711CE181DA1BE8B99F494E7437887D324B62BD2876549436E92D30C8E1D49B2C7E9DF1A295C0F94CB624B1DF698CDE895B562233BC3BB7DDA21546769EC54C4E4F1F196433832651204059740A108FE6FE5C8CBEFE7F2625CC9BC4F4F44F4EA852FEB55DEB715032F3CB5C43123A5CAC4DACD034F62";
        String recoverPassword = keepSecurity.decrypt(passwordEncryptedHex);
        Assert.assertEquals(password, recoverPassword);
        System.out.println("recover password:" + recoverPassword);

    }







}