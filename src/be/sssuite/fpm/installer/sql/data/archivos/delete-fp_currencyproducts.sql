use cob_fpm
go
delete from fp_currencyproducts where bp_product_idfk ='GRUPAL' and cp_currency_id= '0'
delete from fp_currencyproducts where bp_product_idfk ='INDIVIDUAL' and cp_currency_id= '0'
delete from fp_currencyproducts where bp_product_idfk ='INTERCICLO' and cp_currency_id= '0'
go
