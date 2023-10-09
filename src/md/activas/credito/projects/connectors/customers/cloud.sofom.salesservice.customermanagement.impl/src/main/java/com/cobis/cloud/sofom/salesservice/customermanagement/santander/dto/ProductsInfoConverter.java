package com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto;

import com.cobis.cloud.sofom.salesservice.customermanagement.dto.Product;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.ProductsInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class ProductsInfoConverter {
    public static Product toProduct(ProductByBuc productByBuc) {
        return new Product(productByBuc.getCodigoProducto(), productByBuc.getCodigoSubproducto(), productByBuc.getEstadoRelacion(), productByBuc.getNumeroContrato());
    }

    public static ProductsInfo toProductsInfo(ProductsByBucResponse productsByBucResponse) {
        List<ProductByBuc> productByBucList = productsByBucResponse.getOut();
        List<Product> productList = null;
        if (productByBucList == null) {
            productList = new ArrayList<Product>();
        } else {
            productList = new ArrayList<Product>(productByBucList.size());
            for (ProductByBuc productByBuc : productByBucList) {
                productList.add(toProduct(productByBuc));
            }
        }
        return new ProductsInfo(productList);
    }
}
