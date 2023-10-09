use cob_cuentas
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 28/06/28  J.Salazar  Tabla cc_cta_gerencia          */
/* 28/06/28  J.Salazar  Tabla cc_centro_canje          */
/* 28/06/28  J.Salazar  Tabla cc_ofi_centro            */
/* Modulo :  CTACTE - AHO                              */
/*******************************************************/
if object_id ('cc_cta_gerencia') is not null
    drop table cc_cta_gerencia
go
create table cc_cta_gerencia
(
   cg_oficina   smallint      not null,
   cg_moneda    tinyint       not null,
   cg_cuenta    varchar(24)   not null
)
go

if object_id ('cc_centro_canje') is not null
    drop table cc_centro_canje
go
create table cc_centro_canje
(
   ca_sec       int            not null,
   ca_oficina   int            not null,
   ca_desc      varchar(255)   not null,
   ca_ciudad    int            not null
)
go

if object_id ('cc_ofi_centro') is not null
    drop table cc_ofi_centro
go
create table cc_ofi_centro
(
   oc_oficina   int   not null,
   oc_centro    int   not null,
   oc_ciudad    int   not null,
   oc_ruta      int   not null
)
go


use cob_remesas
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 28/06/28  J.Salazar  Tabla re_conversion            */
/* Modulo :  REM - AHO                                 */
/*******************************************************/
if object_id ('re_conversion') is not null
    drop table re_conversion
go
create table re_conversion
(
   cv_filial         tinyint      NOT NULL,
   cv_oficina        smallint     NOT NULL,
   cv_producto       tinyint      NOT NULL,
   cv_moneda         tinyint      NOT NULL,
   cv_tipo           char(1)      NOT NULL,
   cv_tipo_cta       smallint     NOT NULL,
   cv_codigo_cta     char(6)      NOT NULL,
   cv_num_actual     int          NOT NULL,
   cv_cta_anterior   varchar(1)   NULL,
   cv_fin_stock      int          NULL
)
go
create unique nonclustered index pk_re_conversion on re_conversion
(
   cv_filial     asc,
   cv_moneda     asc,
   cv_oficina    asc,
   cv_producto   asc,
   cv_tipo       asc,
   cv_tipo_cta   asc
)
go


use cobis
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 28/06/28  J.Salazar  Seqnos cc_cencanje             */
/* Modulo :  CTACTE - AHO                              */
/*******************************************************/
delete from cl_seqnos
 where bdatos = 'cob_cuentas'
   and tabla  = 'cc_cencanje' 

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values('cob_cuentas','cc_cencanje',0,'NULL')


use cob_cuentas
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 28/06/28  J.Salazar  Datos Iniciales                */
/*                      cc_centro_canje                */
/*                      cc_ofi_centro                  */
/* Modulo :  CTACTE - AHO                              */
/*******************************************************/
delete cc_centro_canje
go
insert into cc_centro_canje values (1,7070,'MEDELLIN',5001)
insert into cc_centro_canje values (2,4068,'BOGOTA',11001)
insert into cc_centro_canje values (3,7017,'CARTAGENA',5001)
insert into cc_centro_canje values (4,7020,'CAUCACIA',5154)
insert into cc_centro_canje values (5,7027,'EL BAGRE',5250)
insert into cc_centro_canje values (6,7016,'CAREPA',5147)
insert into cc_centro_canje values (7,7037,'MANIZALEZ',17001)
insert into cc_centro_canje values (8,7040,'MONTERIA',23001)
insert into cc_centro_canje values (9,4059,'TUNJA',15001)
insert into cc_centro_canje values (10,4053,'SOGAMOSO',15759)
insert into cc_centro_canje values (11,4014,'DUITAMA',15238)
insert into cc_centro_canje values (12,7032,'LA DORADA',17380)
insert into cc_centro_canje values (13,7003,'APARTADO',5045)
insert into cc_centro_canje values (14,4011,'CHIQUINQUIRA',15176)
insert into cc_centro_canje values (15,7064,'TURBO',5837)
insert into cc_centro_canje values (16,4036,'MONIQUIRA',15469)
insert into cc_centro_canje values (17,7033,'LORICA',23417)
insert into cc_centro_canje values (18,7046,'PLANETA RICA',23555)
insert into cc_centro_canje values (19,7054,'SAHAGUN',23660)
insert into cc_centro_canje values (20,4015,'CENTRO DE CANJE TEJAR',11001)
insert into cc_centro_canje values (21,4027,'GIRARDOT',25290)
insert into cc_centro_canje values (22,4070,'YOPAL',85001)
insert into cc_centro_canje values (23,4071,'OCAÑA',54498)
insert into cc_centro_canje values (24,4072,'GARAGOA',15299)
insert into cc_centro_canje values (25,4073,'PAMPLONA',54518)
insert into cc_centro_canje values (26,7060,'SINCELEJO',70001)
insert into cc_centro_canje values (27,7071,'ARMENIA',63001)
insert into cc_centro_canje values (28,7079,'BARRANQUILLA',8001)
insert into cc_centro_canje values (29,7072,'CALARCA',63130)
insert into cc_centro_canje values (30,7073,'PEREIRA',66001)
insert into cc_centro_canje values (31,7076,'SANTA MARTA',47001)
go

update cobis..cl_seqnos
   set siguiente = 32
 where bdatos = 'cob_cuentas'
   and tabla  = 'cc_cencanje' 

delete cc_ofi_centro
go
insert into cc_ofi_centro values (7001,1,5001,2)
insert into cc_ofi_centro values (7006,1,5001,2)
insert into cc_ofi_centro values (7008,1,5001,2)
insert into cc_ofi_centro values (7010,1,5001,2)
insert into cc_ofi_centro values (7012,1,5001,2)
insert into cc_ofi_centro values (7019,1,5001,2)
insert into cc_ofi_centro values (7021,1,5001,2)
insert into cc_ofi_centro values (7025,1,5001,2)
insert into cc_ofi_centro values (7028,1,5001,2)
insert into cc_ofi_centro values (7029,1,5001,2)
insert into cc_ofi_centro values (7030,1,5001,2)
insert into cc_ofi_centro values (7031,1,5001,2)
insert into cc_ofi_centro values (7038,1,5001,2)
insert into cc_ofi_centro values (7039,1,5001,2)
insert into cc_ofi_centro values (7041,1,5001,2)
insert into cc_ofi_centro values (7044,1,5001,2)
insert into cc_ofi_centro values (7051,1,5001,2)
insert into cc_ofi_centro values (7052,1,5001,2)
insert into cc_ofi_centro values (7056,1,5001,2)
insert into cc_ofi_centro values (7059,1,5001,2)
insert into cc_ofi_centro values (7067,1,5001,2)
insert into cc_ofi_centro values (7068,1,5001,2)
insert into cc_ofi_centro values (7069,1,5001,2)
insert into cc_ofi_centro values (4003,2,11001,1)
insert into cc_ofi_centro values (4005,2,11001,1)
insert into cc_ofi_centro values (4010,2,11001,1)
insert into cc_ofi_centro values (4015,2,11001,1)
insert into cc_ofi_centro values (4017,2,11001,1)
insert into cc_ofi_centro values (4018,2,11001,1)
insert into cc_ofi_centro values (4019,2,11001,1)
insert into cc_ofi_centro values (4022,2,11001,1)
insert into cc_ofi_centro values (4024,2,11001,1)
insert into cc_ofi_centro values (4025,2,11001,1)
insert into cc_ofi_centro values (4030,2,11001,1)
insert into cc_ofi_centro values (4031,2,11001,1)
insert into cc_ofi_centro values (4032,2,11001,1)
insert into cc_ofi_centro values (4033,2,11001,1)
insert into cc_ofi_centro values (4034,2,11001,1)
insert into cc_ofi_centro values (4035,2,11001,1)
insert into cc_ofi_centro values (4040,2,11001,1)
insert into cc_ofi_centro values (4043,2,11001,1)
insert into cc_ofi_centro values (4044,2,11001,1)
insert into cc_ofi_centro values (4045,2,11001,1)
insert into cc_ofi_centro values (4046,2,11001,1)
insert into cc_ofi_centro values (4049,2,11001,1)
insert into cc_ofi_centro values (4050,2,11001,1)
insert into cc_ofi_centro values (4054,2,11001,1)
insert into cc_ofi_centro values (4056,2,11001,1)
insert into cc_ofi_centro values (4057,2,11001,1)
insert into cc_ofi_centro values (4058,2,11001,1)
insert into cc_ofi_centro values (4060,2,11001,1)
insert into cc_ofi_centro values (4061,2,11001,1)
insert into cc_ofi_centro values (4064,2,11001,1)
insert into cc_ofi_centro values (4065,2,11001,1)
insert into cc_ofi_centro values (4067,2,11001,1)
insert into cc_ofi_centro values (7020,4,5154,157)
insert into cc_ofi_centro values (7027,5,5250,161)
insert into cc_ofi_centro values (7016,6,5147,847)
insert into cc_ofi_centro values (7037,7,17001,6)
insert into cc_ofi_centro values (4059,9,15001,18)
insert into cc_ofi_centro values (4053,10,15759,28)
insert into cc_ofi_centro values (4014,11,15238,30)
insert into cc_ofi_centro values (7032,12,17380,31)
insert into cc_ofi_centro values (7003,13,5045,39)
insert into cc_ofi_centro values (4011,14,15176,52)
insert into cc_ofi_centro values (7064,15,5837,144)
insert into cc_ofi_centro values (4036,16,15469,235)
insert into cc_ofi_centro values (7033,17,23417,373)
insert into cc_ofi_centro values (7046,18,23555,378)
insert into cc_ofi_centro values (7054,19,23660,383)
insert into cc_ofi_centro values (7040,8,23001,25)
insert into cc_ofi_centro values (7047,1,5001,2)
insert into cc_ofi_centro values (7060,26,70001,27)
insert into cc_ofi_centro values (7066,1,5001,2)
insert into cc_ofi_centro values (7070,1,5001,2)
insert into cc_ofi_centro values (7071,27,63001,11)
insert into cc_ofi_centro values (7072,29,63130,0)
insert into cc_ofi_centro values (7073,30,66001,0)
insert into cc_ofi_centro values (7074,1,66682,0)
insert into cc_ofi_centro values (7075,7,17001,6)
insert into cc_ofi_centro values (7076,31,47001,0)
insert into cc_ofi_centro values (7079,28,8001,4)
go


use cobis
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 28/06/28  J.Salazar  Autorizacion sp_centro_canje   */
/* Modulo :  ADMIN - AHO                               */
/*******************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 3

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 2810
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,2810,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 2810
   and pt_procedure   = 2627

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,2810,'V',getdate(),2627,null)
go

delete from ad_procedure
 where pd_procedure = 2627
go
insert into ad_procedure values (2627,'sp_centro_canje','cob_cuentas','V', getdate(),'cccencanje.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 2810
go
insert into cl_ttransaccion values (2810,'MANTENIMIENTO CENTROS DE CANJE','MCDC','MANTENIMIENTO CENTROS DE CANJE')
go


use cobis
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 01/07/28  J.Salazar  Autorizacion sp_ofi_canje      */
/* Modulo :  ADMIN - AHO                               */
/*******************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 3

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 2811
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,2811,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 2811
   and pt_procedure   = 2628

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,2811,'V',getdate(),2628,null)
go

delete from ad_procedure
 where pd_procedure = 2628
go
insert into ad_procedure values (2628,'sp_ofi_canje','cob_cuentas','V',getdate(),'ccoficanje.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 2811
go
insert into cl_ttransaccion values (2811,'RELACION OFICINA - CENTRO DE CANJE','ROCC','RELACION OFICINA - CENTRO DE CANJE')
go


use cobis
go
/*******************************************************/
/* Fecha Creación del Script: 2016/06/28               */
/* Historial Dependencias:                             */
/* 01/07/28  J.Salazar  Autorizacion sp_oficina        */
/* Modulo :  ADMIN - AHO                               */
/*******************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 1

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 1574
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,1574,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 1574
   and pt_procedure   = 5047

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,1574,'V',getdate(),5047,null)
go

delete from ad_procedure
 where pd_procedure = 5047
go
insert into ad_procedure values (5047,'sp_oficina','cobis','V',getdate(),'oficina.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 1574
go
insert into cl_ttransaccion values (1574,'HELP DE OFICINAS','HOFI','DESCRIPCION')
go

