package com.cobis.gestionasesores.utils;

import com.cobis.gestionasesores.widgets.RegexInputFilter;

import org.junit.Test;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Pattern;

import static junit.framework.Assert.assertEquals;

/**
 * Created by mnaunay on 12/03/2018.
 */

public class NamesRegex {

    @Test
    public void testFirstName(){
        Pattern pattern = Pattern.compile(RegexInputFilter.REGEX_FIRST_NAME);
        Map<String, Boolean> examples = new HashMap<String,Boolean>();
        examples.put("Ma.",true);
        examples.put("Doña Ma.",true);
        examples.put("Doña.",false);
        examples.put("Maria dolores",true);
        examples.put("Ñatita",true);

        Iterator<String> values = examples.keySet().iterator();
        String value;
        while(values.hasNext()){
            value = values.next();
            System.out.println(value + " - "+examples.get(value));
            assertEquals((boolean)examples.get(value),pattern.matcher(value.toUpperCase()).matches());
        }
    }

    @Test
    public void testOthersNames(){
        Pattern pattern = Pattern.compile(RegexInputFilter.REGEX_NAMES);
        Map<String, Boolean> examples = new HashMap<String,Boolean>();
        examples.put("Ma.",false);
        examples.put("Doña Ma",true);
        examples.put("Doña.",false);
        examples.put("Maria dolores",true);
        examples.put("Ñatita",true);

        Iterator<String> values = examples.keySet().iterator();
        String value;
        while(values.hasNext()){
            value = values.next();
            System.out.println(value + " - "+examples.get(value));
            assertEquals((boolean)examples.get(value),pattern.matcher(value.toUpperCase()).matches());
        }
    }
}
