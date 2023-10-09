package com.cobiscorp.cobis.clcol.model;

import com.cobiscorp.designer.api.Property;
import java.util.ArrayList;
import java.util.List;

public class CollectiveAdvisorFile
{
  public static final String EN_COLLECTIA_440 = "EN_COLLECTIA_440";
  public static final String VERSION = "1.0.0";
  public static final String ENTITY_NAME = "CollectiveAdvisorFile";
  public static final Property<Integer> EJECUTION = new Property("ejecution", Integer.class, false);
  public static final Property<String> NAMEFILE = new Property("nameFile", String.class, false);
  
  public static final List<Property<?>> getPks()
  {
    List<Property<?>> pks = new ArrayList();
    return pks;
  }
}
