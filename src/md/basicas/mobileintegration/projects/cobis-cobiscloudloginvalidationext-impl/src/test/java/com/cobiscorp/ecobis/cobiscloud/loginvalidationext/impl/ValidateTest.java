package com.cobiscorp.ecobis.cobiscloud.loginvalidationext.impl;
import com.cobiscorp.cobis.commons.converters.ByteConverter;
import org.apache.commons.codec.binary.Base64;

import org.codehaus.jackson.map.ObjectMapper;
import org.junit.Before;
import org.junit.Test;

import javax.crypto.Cipher;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ValidateTest {

    public static final int KEY_LENGTH = 2048;
    //String token = "UAFMKnrUG/32W5eGr5NIKROjdMhw7NyzoG3q9BHzEsBJpIisZAPgjTORQ9MFxwFYPi54UK0KP+yQHxVZFi71pyc7JqIqCC3Z+WuZI5pxF0Anl2KoVcwXKsPsX7TF4Z1EqGkPbo/TmtPlyOZGPCXe5r1V8YZd/FbvYzPuq7NslMigtTZI+Mm8HkaBpvvZt12XubE7sBLcvnFDYgMaEoCOBo2BQK8qeQ9vVMteLWwVVtfL7bTIVVYRG7bJ6ziO8ddWOUrMIUF6ja01pTPPsrRiT+/hjqL/lw880lTsPTyV3ZiwS8+M2meWcsLLybX6Mfu35Bza/P9PTABhczkmOy+Njg\u003d\u003d";
    //String token = "OWvxvJdUIwzEqRmMhwff3BQ36Q12H1euNMr7e79DWyudd3Yx3YRCFBJM34R2KeTp1v2GNFUYyGTagoiWopp3CnL9leZrpM941isyeTFJQ/o36v6NkvtM0ALXyafEfj9N91+NiaGzBdCylsTMNN33GClUr4ZOAGpkl1GIvhOttATpDleOKmmaaH2c0dew3Biht//kElgRBBT6v/+cuFsVBZWBqGSTjv1KV7liElxjwE4ekRPJr68/OP8bbgo2ofrMN1qu5HPeG/ng3aM4V6wMVYtBVBPkjMLLbiZZwW2+VgnnOLHhOQLd3tE8M1R3IOKlLndXg+RxsSdqPkWFXKQQ/g\u003d\u003d";
    //String token = "VYfpIiytv8ROqCv2UkN00a3hET8m5IxssdEG0AdEuFEXePpM2P1C1Vv+mS6G+MqHnGXv47yWrAA4WtvbzZJtNwKZJGUG2OIYlfyeZhfQGQ0aqMSuRGuoegkxfUqVgJXRIh9K7HoXWSA68dXNJl/wXitTZE9gmCLwyRhvPMTUZfGN17BE1z0x5rXSn52S4KlRT29TKQDQC0yLigjL8YgWy5X6Sf1jDYNO9z7vNQokUEvwO5dYi3M0MqJrveHFRw9FjB4BSF13dHf7aoBpuXpzISXLfSFP9h0gM7iNulKeARwD94VtSFtn+kXMYA7yXpEtFBC3jqwigyzJvCqmwZKi5Q==jys/ToCHayLUVaIc2HuTf+oxfd1QH7kAzA4EeD8RdhMouMIVZI4spolY1y4ojtW8nVGmrRVVZjKygLimaaUhHWbiL8DB7l4EhzUho81Yn/Lm8TgmdjY4xh9RyqfIifmhTt/k0TfNXgBYZrImi1HAeq0R8wN5/zzTR3xD3CEaWDKR9EG8Nij5RMByEx62Lb2kvjPfRjeKjC4x6Ll/Ro8Y+OboXTUElFzUp2gOk4vwDGA7ZHipdaannK2xWRcTpWH0Xnh16lrulAji64sII3Pf+Hz/s4T6YVZOBTBwPVWQTgbLhc2rypyWzq2InfBFe+P/zkUm6n+8n3iLxsROgSziPg==";
    //String token = "c4e2cSD8e5GX7rOYZWIHbnSPt5XfNptEamKWkQ/U4Rbc/7fZTwTTELZfF/me/9JPzsR+x3l+VxqmE2RgCxNrSzg4jvXQP+ud3iWqLHmZTP1m3BDj40PDDEpaRTHCsbTAdU019kE6ihnIhHgZuEkqO53zLwmQ4QjjYBoUgw/gCujMLA1oen/NGz9ZUU80qTK7XwhGUZ36GEfCPzroR9S5YpCzZ4ArbGvktlw2dn3kWO2+8cmfpHedEHi/S7bBJNpA2cCuYm33tRrZjlDVly0j+E0QSxRIJIIRfVbX7QPLk2ERm2jQ0vOLJMOX0iKPC9OoLQ85nRZ1mpvOCUC507mEHw\u003d\u003dJ8/DQiudn/cB3Okcp6X2qZZSbtRsCPsTdDwST5Zv337CliKzvmu06/CkNRxnEhUf/YVHUv/RAmS6p90q2Xdq3z3HNa5MCGKea+72zx0k5LPJbCT3f6iOLBORU+FrEcw7aPNuHxqWvsG/oRuTjcoKncrtTxDhNcdkSrP+nT7AmPQMIfm11vs3BQdcUmMF1K8D6tSpZthDDxEHiCPoDmU3C94seNdBGntHiAloW8FABaAmMz5F/uKaCMeHDFKi6ZPIr0XqbQ80bH13rsijUDD7i4F0SrlwT/RCesJFhhrzMhNK1kwpzHf5CDc+EjuybztE14WhIjRl9anQLqvSYtcGGA\u003d\u003d";
    String token = "BQAq+3IN845TpKwc/vdJ9lqhDnW3xVEivTMLS9b8j4ZZtT0iGsOV7b+Tp4cFO+mkxlBhH3PevObGxmyyV+CpwTQXXJUaEtG+KNPu3qglvGr7zbyW+rwYv4+PjcfABCN4MiOmC6Ex4hTrWKtM50CLvbQvVq72QNQeCw0TtWLnwhJh/XokB27gzrOPkoJ6pvTWE+6JaYmePqTTZKtt272VTIyARt6MlZDN+b0llq08Mi37quKHdOhXqHX+teRok7Cy5f+0r2teIG+buYR2Ez15T3xmtsltqDrIsxfeJG738a8A7uVtWd/X/qfL/U2KXejeBzG1BEGYjcY8Ox50zCQjEWywUPWVG62URh9e6NBM8cr1HzBHF7rv8JpKNQ9unG9GSerbVKk9XHhnGnoif5HwWDjvUF7g51FgGV3p2eCWm8vkz/1TaktFwOjvfn5iAIMcYGTmXzXwUSAaHqonuxOtqnD0gXZyWShS3J0H+1trTb1KUu6ga/qkKb4Zcm94f+EbRA7zI4ftqgUaNvP+DKy1EFAL4jyrLkfkPFqRSjndUXJ3cEJZgfKPbo6UfXfxt9JpfR9leTpIRgf+JrYzLqG13i3pXnkBO5GySKEQh+1flFxIG64W6OP82eZXIkKue4JtSguMjqs7qpeoEOGw8fI3oLzdjlNYqE+GUwiwTzfNQpyRum1VI4UrFPwmtquXWkT+NRULpb1MKd+RHSihvqDYxMWTRsIt1sm9YhRrSE2568BlrLAo50/7S28PWHg1ohLXrysXMvYBmxj8jB1GRxMxte2lfPSrGgAGkkrzdPSpZ9tcbDBvsTSCvI2uOOtau0iFMAOiOsJMAAHhomeCHbUP8/GKZ1MZajI9r9N9KY5ZgKQBz+B/2oBhnlYrDdAsc7aOQ+/yaL1DPGxSv2KvNO0NKrCxpcGqUf/vvCtfy4hFxaLQRna9aTGJe/cezD690yiP1bX1GE8UseKGPNLyHr/CdYcgUjx8+YcD/8BadrQoQDxRSxVrgfT/cxDwkw/NkSG2";
    @Before
    public void setUp() {
        System.setProperty("COBIS_HOME","COBIS_HOME");
        Activator.loadConfig();
    }
    private int getBlockSize(int mode) {
        return (mode == Cipher.DECRYPT_MODE)? 256 : 245;
    }
    @Test
    public void validate() throws IOException {
        long tini = System.currentTimeMillis();
        Base64 base64 = new Base64();
        byte[] bytesToken = base64.decode(token);
        KeepSecurity keepSecurity = new KeepSecurity(
                ByteConverter.tranformToHex(Activator.getPrivateKey()).toCharArray());
        String decrypted = keepSecurity.decrypt(ByteConverter.tranformToHex(bytesToken));
        System.out.println("decrypted string:" + decrypted);

        long tfin = System.currentTimeMillis();
        System.out.println("diff:" + (tfin - tini));
    }

    @Test
    public void transformTo() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        List<String> macs = new ArrayList<String>();
        macs.add("10-08-B1-3A-E8-31");
        macs.add("38-63-BB-82-DE-F4");
        Map<String, Object> values = new HashMap<String, Object>();
        values.put("macs", macs);
        values.put("user:", "user1");
        values.put("terminal:" , "terminal");
        String json = mapper.writeValueAsString(values);
        System.out.println("json:" + json);

    }

    @Test
    public void test1() {

    }

}
