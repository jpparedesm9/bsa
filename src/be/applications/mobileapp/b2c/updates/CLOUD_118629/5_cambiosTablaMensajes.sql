

use cob_bvirtual 
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('bv_b2c_tipo_msg')
                and name = 'tm_pos_boton' ) 
	alter table bv_b2c_tipo_msg add tm_pos_boton varchar(20) null
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('bv_b2c_tipo_msg')
                and name = 'tm_neg_boton' ) 
	alter table bv_b2c_tipo_msg add tm_neg_boton varchar(20) null
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('bv_b2c_tipo_msg')
                and name = 'tm_mostrar_resp' ) 
	alter table bv_b2c_tipo_msg add tm_mostrar_resp varchar(1) null
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('bv_b2c_msg')
                and name = 'ms_var5' ) 
	alter table bv_b2c_msg add ms_var5 varchar(64) null
go
