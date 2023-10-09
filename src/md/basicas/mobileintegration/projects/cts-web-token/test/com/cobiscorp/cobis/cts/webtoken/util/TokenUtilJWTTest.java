package com.cobiscorp.cobis.cts.webtoken.util;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import io.jsonwebtoken.Claims;
import org.glassfish.jersey.internal.util.Base64;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by fervincent on 16/08/17.
 */
public class TokenUtilJWTTest {

    Map<String, Object> claims;
    byte[] key = ByteConverter.tranformFromHex("30820275020100300D06092A864886F70D01010105000482025F3082025B02010002818100A7ECEEC1ABBDA1C6F2736284BCDB855BA59E4A9A164D21B32992905C25858E75F58974E50A006BBDF2638D952EEA4C8B2D98164D9A45292B94A37FEE94D6E7D99358EFB49ACBC24D6FC2D6031A12269557B5FBEB65DDDB545B22543AB7F641A0B06EA04CA2F43868743DA49274C22E7EBFD5D27F53E6B9EBAE7741F900AAE0A102030100010281802743C3600DA43D9BA33D4F9FF1F8F269C78407B597D95933E75899E0B1F554A6484F67C1D660DAD08348BBE6521DFEDFDC3D5F99ADA4D647966DD49018C55758AB6A0B15C902C3EA024FEE6A496A9DB31E67CB9AE9F003BE39467756740A417C7A284E997F5C7F8C0698877052BA060A82A50570501AA96EDAADD841829E8D01024100DDA234BCF2F2FA59596E0FF7D9A1EC8472944E843DDA3A1C76923D123FCF7382406E2922859C39C9C6E1996CE47FB3EE9E49E8E37C60D71903DC1CD36CDA1789024100C1F6C5A97886D71C02A716764E305BC863D8BD5415FD631A23B3075F5776911046E47431B320D11ABB73327DCD0798393FD34745D0860F91B65AF21AC554A25902400A78573575E4B49EF3F2971E865177F2E9D6C7BEC78D3FA188986FFA24B990235F17D529A4563504AB388D1EEFCC789B952EB8A9C67E6CAAE9DBC420D8CB94C1024024D2CEAFDFDBE996BDC22EF782DC977031D4820D26A7965AEE101D0432BCA5C9AB4BCFEB679081624BD810EBE532DDE9707E91F765212E6F81693EB16A6928F102402C25196793064AFBA9026DF581486B4C8A5D275D25401DBDF1C7C9C1C147B96EAE6D42939556302197C782AD60D6D21057652DE7CE92A5BEA729097518DBEF5C");

    @Before
    public void setUp() {
        claims = new HashMap<String, Object>();

        claims.put("user", "user1");
        claims.put("deviceId", "ABC1");

    }

    @Test
    public void itShouldTestGenerateExpirationDate() {
        Calendar currentDate = Calendar.getInstance();
        currentDate.add(Calendar.SECOND, 1200);
        Calendar expirationDate = TokenUtilJWT.calculateExpirationDate(1200);
        Assert.assertEquals(currentDate.get(Calendar.DAY_OF_MONTH), expirationDate.get(Calendar.DAY_OF_MONTH));
        Assert.assertEquals(currentDate.get(Calendar.HOUR), expirationDate.get(Calendar.HOUR));
        Assert.assertEquals(currentDate.get(Calendar.MINUTE), expirationDate.get(Calendar.MINUTE));
        Assert.assertTrue((currentDate.get(Calendar.SECOND) <= expirationDate.get(Calendar.SECOND))
                && (currentDate.get(Calendar.SECOND) + 1 >= expirationDate.get(Calendar.SECOND)));
    }

    @Test
    public void itShouldGenerateToken() {


//        LoginRequest loginRequest = new LoginRequest();
//        loginRequest.setDeviceId("ABC1");
//        loginRequest.setUser("user1");
//        loginRequest.setPassword("password");
//        loginRequest.setSignature("ABAC");
        long tini = System.currentTimeMillis();
        String token = TokenUtilJWT.generateToken(claims, "mobile", key);
        long tfin = System.currentTimeMillis();
        System.out.println("diff token:"  + (tfin - tini));
        System.out.println("token:" + token);
        String subtokens[] = token.split("\\.");
        String decoded = Base64.decodeAsString(subtokens[1]);
        System.out.println("decoded222:" + decoded);
        System.out.println("tenaz:" + Base64.decodeAsString("eyJkZXZpY2VJZCI6IkFCQ0QiLCJ1c2VyIjoiYWRtaW4iLCJleHAiOjE1MDI5NDYwMDB9"));
        Assert.assertTrue(decoded.contains("user1"));
        long var1 = 1503028800l;
        System.out.println(new Date(var1));
        Claims claimsTmp = TokenUtilJWT.getClaimsFromToken(token, key);
        Assert.assertEquals("user1", claimsTmp.get("user"));
        Assert.assertEquals("ABC1", claimsTmp.get("deviceId"));
    }

    @Test
    public void itShouldValidateExpired() {
        String token = TokenUtilJWT.generateToken(claims, "mobile", key);
        System.out.println("token expirado:" + token + ":");
        Assert.assertFalse(TokenUtilJWT.isExpiredToken(token, key, new Date()));
        int days = 2;

        Date moreOneDay = new Date(new Date().getTime() + (days * 24 * 60 * 60 * 1000));
        Assert.assertTrue(TokenUtilJWT.isExpiredToken(token, key, moreOneDay));
    }


}

