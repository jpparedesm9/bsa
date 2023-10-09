package com.cobis.gestionasesores.infrastructure.jwt;

/**
 * Created by mnaunay on 22/08/2017.
 */

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Base64;

import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.Map;

/**
 * Wrapper class for values contained inside a Json Web Token (JWT).
 */
public class JWT {
    private static final String ENCODING_UTF_8 = "UTF-8";
    private final String token;

    private Map<String, String> header;
    private JWTPayload payload;
    private String signature;

    /**
     * Decode a given string JWT token.
     *
     * @param token the string JWT token.
     * @throws DecodeException if the token cannot be decoded
     */
    public JWT(@NonNull String token) {
        decode(token);
        this.token = token;
    }

    /**
     * Get the Header values from this JWT as a Map of Strings.
     *
     * @return the Header values of the JWT.
     */
    @NonNull
    public Map<String, String> getHeader() {
        return header;
    }

    /**
     * Get the Signature from this JWT as a Base64 encoded String.
     *
     * @return the Signature of the JWT.
     */
    @NonNull
    public String getSignature() {
        return signature;
    }

    /**
     * Get the value of the "exp" claim, or null if it's not available.
     *
     * @return the Expiration Time value or null.
     */
    @Nullable
    public Date getExpiresAt() {
        return new Date(payload.exp * 1000);
    }

    /**
     * Get the value of the "jti" claim, or null if it's not available.
     *
     * @return the JWT ID value or null.
     */
    @Nullable
    public String getId() {
        return payload.sessionId;
    }

    /**
     * Validates that this JWT was issued in the past and hasn't expired yet.
     *
     * @param leeway the time leeway in seconds in which the token should still be considered valid.
     * @return if this JWT has already expired or not.
     */
    public boolean isExpired(long leeway) {
        if (leeway < 0) {
            throw new IllegalArgumentException("The leeway must be a positive value.");
        }
        long todayTime = (long) (Math.floor(new Date().getTime() / 1000) * 1000); //truncate millis
        Date pastToday = new Date((todayTime - leeway * 1000));
        Date exp = new Date(payload.exp * 1000);
        boolean expValid = exp == null || !pastToday.after(exp);
        return !expValid;
    }

    /**
     * Returns the String representation of this JWT.
     *
     * @return the String Token.
     */
    @Override
    public String toString() {
        return token;
    }

    // =====================================
    // ===========Private Methods===========
    // =====================================

    private void decode(String token) {
        final String[] parts = splitToken(token);
        Type mapType = new TypeToken<Map<String, String>>() {
        }.getType();
        header = parseJson(base64Decode(parts[0]), mapType);
        payload = parseJson(base64Decode(parts[1]), JWTPayload.class);
        signature = parts[2];
    }

    private String[] splitToken(String token) {
        String[] parts = token.split("\\.");
        if (parts.length != 3) {
            throw new DecodeException(String.format("The token was expected to have 3 parts, but got %s.", parts.length));
        }
        return parts;
    }

    @Nullable
    private String base64Decode(String string) {
        String decoded;
        try {
            byte[] bytes = Base64.decode(string, Base64.URL_SAFE | Base64.NO_WRAP | Base64.NO_PADDING);
            decoded = new String(bytes, ENCODING_UTF_8);
        } catch (IllegalArgumentException e) {
            throw new DecodeException("Received bytes didn't correspond to a valid Base64 encoded string.", e);
        } catch (UnsupportedEncodingException e) {
            throw new DecodeException("Device doesn't support UTF-8 charset encoding.", e);
        }
        return decoded;
    }

    private <T> T parseJson(String json, Type typeOfT) {
        T payload;
        try {
            payload = new GsonBuilder().create().fromJson(json, typeOfT);
        } catch (Exception e) {
            throw new DecodeException("The token's payload had an invalid JSON format.", e);
        }
        return payload;
    }
}
