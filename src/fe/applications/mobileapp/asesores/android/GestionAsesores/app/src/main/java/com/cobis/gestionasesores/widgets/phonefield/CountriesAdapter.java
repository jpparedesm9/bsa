package com.cobis.gestionasesores.widgets.phonefield;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.SpinnerAdapter;
import android.widget.TextView;

import com.cobis.gestionasesores.R;

import java.util.List;

/**
 * Adapter for the countries list spinner
 * Created by Ismail on 5/6/16.
 */
public class CountriesAdapter extends ArrayAdapter<Country> implements SpinnerAdapter {

  private final LayoutInflater mInflater;
  public CountriesAdapter(Context context, List<Country> countries) {
    super(context, R.layout.pf_item_country, R.id.name, countries);
    mInflater = LayoutInflater.from(getContext());
  }

  @Override
  public View getView(int position, View convertView, ViewGroup parent) {
    Country country = getItem(position);
    if (convertView == null) {
      convertView = mInflater.inflate(R.layout.pf_spinner_value, parent, false);
    }
    ImageView imageView = (ImageView) convertView.findViewById(R.id.flag);
    imageView.setImageResource(country.getResId(getContext()));
    return convertView;
  }

  @Override
  public View getDropDownView(int position, View convertView, ViewGroup parent) {
    return getCustomView(position, convertView, parent);
  }

  private View getCustomView(int position, View convertView, ViewGroup parent) {
    ViewHolder viewHolder;
    if (convertView == null) {
      convertView = mInflater.inflate(R.layout.pf_item_country, parent, false);
      viewHolder = new ViewHolder();
      viewHolder.mName = (TextView) convertView.findViewById(R.id.name);
      viewHolder.mDialCode = (TextView) convertView.findViewById(R.id.dial_code);
      viewHolder.mFlag = (ImageView) convertView.findViewById(R.id.flag);
      convertView.setTag(viewHolder);
    } else {
      viewHolder = (ViewHolder) convertView.getTag();
    }
    Country country = getItem(position);
    viewHolder.mFlag.setImageResource(country.getResId(getContext()));
    viewHolder.mName.setText(country.getDisplayName());
    viewHolder.mDialCode.setText(String.valueOf(country.getDialCode()));
    return convertView;

  }

  private static class ViewHolder {
    TextView mName;
    TextView mDialCode;
    ImageView mFlag;
  }
}
