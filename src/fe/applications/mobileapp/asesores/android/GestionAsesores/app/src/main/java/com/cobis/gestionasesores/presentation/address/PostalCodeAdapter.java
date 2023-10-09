package com.cobis.gestionasesores.presentation.address;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.PostalCode;

import java.util.List;

/**
 * Created by Miguel on 14/06/2017.
 */

public class PostalCodeAdapter extends ArrayAdapter<PostalCode> {
    private List<PostalCode> mData;
    @StringRes
    private int mHint;

    @StringRes
    private int mError;
    private PostalCode mUniqueResult;

    public PostalCodeAdapter(@NonNull Context context, List<PostalCode> postalCodes,@StringRes int hint) {
        this(context,postalCodes,hint,true);
    }

    public PostalCodeAdapter(@NonNull Context context, List<PostalCode> postalCodes,@StringRes int hint, boolean addDefaultValue) {
        super(context, android.R.layout.simple_list_item_1,postalCodes);
        mData = postalCodes;
        if(addDefaultValue) {
            mData.add(0, getDefaultItem());
        }
        mHint = hint;
    }

    public void setUniqueResult(PostalCode uniqueResult) {
        mData.clear();
        mData.add(uniqueResult);
        notifyDataSetChanged();
    }

    @Nullable
    @Override
    public PostalCode getItem(int position) {
        return  mData.get(position);
    }

    @Override
    public int getCount() {
        return mData.size();
    }

    public int getPositionByCode(String code){
        if(code == null) return 0;
        for (int i = 0; i < mData.size(); i++){
            if(code.equals(mData.get(i).getCode())){
                return i;
            }
        }
        return 0;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        ItemViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ItemViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_spinner_item, parent, false);
            viewHolder.name = (TextView) convertView.findViewById(R.id.text_value);
            viewHolder.hint = (TextView) convertView.findViewById(R.id.text_hint);
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (ItemViewHolder) convertView.getTag();
        }

        PostalCode item = getItem(position);
        if (item != null) {
            viewHolder.name.setText(item.getName());
            viewHolder.hint.setText(mHint);
            viewHolder.name.setError(mError > 0 ? getContext().getString(mError) : null);
        }
        return convertView;
    }

    public void showError(@StringRes int error) {
        mError = error;
        notifyDataSetChanged();
    }

    public void clearError() {
        mError = -1;
        notifyDataSetChanged();
    }

    private PostalCode getDefaultItem() {
        return new PostalCode(-1, -1, getContext().getString(R.string.form_hint_select_spinner),null,null);
    }

    static final class ItemViewHolder {
        TextView name;
        TextView hint;
    }
}
