package com.cobis.gestionasesores.presentation.sections;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.CatalogItem;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public class CatalogItemAdapter extends ArrayAdapter<CatalogItem> {

    private List<CatalogItem> mCatalogItems;

    @StringRes
    private int mHint;

    @StringRes
    private int mError;

    public CatalogItemAdapter(@NonNull Context context, List<CatalogItem> catalogItems, @StringRes int hint) {
        super(context, R.layout.row_catalog_spinner_item, catalogItems);
        mCatalogItems = catalogItems;
        mCatalogItems.add(0, getDefaultItem());
        mHint = hint;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        CatalogItemViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new CatalogItemViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_catalog_spinner_item, parent, false);
            viewHolder.mCatalogItemNameText = (TextView) convertView.findViewById(R.id.text_value);
            viewHolder.mHintText = (TextView) convertView.findViewById(R.id.text_hint);
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (CatalogItemViewHolder) convertView.getTag();
        }

        CatalogItem item = getItem(position);
        if (item != null) {
            viewHolder.mCatalogItemNameText.setText(item.getValue());
            viewHolder.mHintText.setText(mHint);
            viewHolder.mCatalogItemNameText.setError(mError > 0 ? getContext().getString(mError) : null);
        }
        return convertView;
    }

    @Override
    public View getDropDownView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        CatalogDropDownItemViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new CatalogDropDownItemViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(android.R.layout.simple_dropdown_item_1line, parent, false);
            viewHolder.mCatalogItemNameText = (TextView) convertView;
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (CatalogDropDownItemViewHolder) convertView.getTag();
        }

        CatalogItem item = getItem(position);
        if (item != null) {
            viewHolder.mCatalogItemNameText.setText(item.getValue());
        }
        return convertView;
    }

    public String getItemCode(int position) {
        return mCatalogItems.get(position).getCode();
    }

    public String getItemCode(int position, String defaultValue) {
        String result = getItemCode(position);
        return StringUtils.isEmpty(result) ? defaultValue : result;
    }

    public String getItemValue(int position) {
        return mCatalogItems.get(position).getValue();
    }

    public void setCatalogItems(List<CatalogItem> newItems) {
        mCatalogItems.clear();
        mCatalogItems.add(0, getDefaultItem());
        mCatalogItems.addAll(newItems);
        notifyDataSetChanged();
    }

    public void showError(@StringRes int error) {
        mError = error;
        notifyDataSetChanged();
    }

    public void clearError() {
        mError = -1;
        notifyDataSetChanged();
    }

    public int getItemPositionByCode(String code) {
        if (code == null) return 0;
        for (int i = 0; i < mCatalogItems.size(); i++) {
            if (code.equals(mCatalogItems.get(i).getCode())) {
                return i;
            }
        }
        return 0;
    }

    private static class CatalogItemViewHolder {
        TextView mCatalogItemNameText;
        TextView mHintText;
    }

    private static class CatalogDropDownItemViewHolder {
        TextView mCatalogItemNameText;
    }

    private CatalogItem getDefaultItem() {
        return new CatalogItem(-1, null, getContext().getString(R.string.form_hint_select_spinner));
    }
}
