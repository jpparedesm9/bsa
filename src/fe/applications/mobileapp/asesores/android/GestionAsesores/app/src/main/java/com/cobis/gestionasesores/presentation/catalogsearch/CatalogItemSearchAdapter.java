package com.cobis.gestionasesores.presentation.catalogsearch;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.data.models.CatalogItem;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public class CatalogItemSearchAdapter extends RecyclerView.Adapter<CatalogItemSearchAdapter.CatalogItemSearchViewHolder> {

    private Context mContext;
    private List<CatalogItem> mCatalogItems;
    private CatalogItemSearchListener mListener;

    public CatalogItemSearchAdapter(Context context, CatalogItemSearchListener listener) {
        mContext = context;
        mCatalogItems = new ArrayList<>();
        mListener = listener;
    }

    @Override
    public CatalogItemSearchViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(mContext).inflate(android.R.layout.simple_list_item_1, parent, false);
        return new CatalogItemSearchViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final CatalogItemSearchViewHolder holder, int position) {
        holder.bindCatalogItem(mCatalogItems.get(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mListener.onClickItem(mCatalogItems.get(holder.getAdapterPosition()));
            }
        });
    }

    @Override
    public int getItemCount() {
        return mCatalogItems.size();
    }

    public void setCatalogItems(List<CatalogItem> catalogItems) {
        mCatalogItems.clear();
        mCatalogItems.addAll(catalogItems);
        notifyDataSetChanged();
    }

    public void clear() {
        mCatalogItems.clear();
        notifyDataSetChanged();
    }

    public static class CatalogItemSearchViewHolder extends RecyclerView.ViewHolder {

        private TextView mCatalogItemNameText;

        public CatalogItemSearchViewHolder(View itemView) {
            super(itemView);
            mCatalogItemNameText = (TextView) itemView;
        }

        public void bindCatalogItem(CatalogItem catalogItem) {
            mCatalogItemNameText.setText(catalogItem.getValue());
        }
    }

    interface CatalogItemSearchListener {
        void onClickItem(CatalogItem catalogItem);
    }
}
