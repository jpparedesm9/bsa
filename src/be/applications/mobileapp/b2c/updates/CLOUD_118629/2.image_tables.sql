use cob_bvirtual
go
print 'bv_catg_img'

if object_id ('bv_catg_img') is not null
    drop table bv_catg_img
go

create table bv_catg_img
(
	ci_id          int not null,
	ci_imagen      varchar (max) not null,
	ci_nombre_arch varchar (64) not null,
	ci_estado	   char(1) not null
)
go