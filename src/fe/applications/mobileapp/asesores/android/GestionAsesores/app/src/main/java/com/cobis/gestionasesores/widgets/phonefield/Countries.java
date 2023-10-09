package com.cobis.gestionasesores.widgets.phonefield;

import java.util.ArrayList;
import java.util.List;

public final class Countries {
  public static final List<Country> COUNTRIES = new ArrayList<>();
  static {
    COUNTRIES.add(new Country("mx", "Mexico (México)", 52));
  }
  private Countries(){}
}
