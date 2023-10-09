/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Dic/2017     LGU                  Version Inicial             */
/*                                                                       */
/* ********************************************************************* */


use cob_cartera
go
/*

IF OBJECT_ID ('dbo.ca_precancela_refer') IS NOT NULL
    DROP TABLE dbo.ca_precancela_refer
GO

CREATE TABLE dbo.ca_precancela_refer (
    pr_secuencial     int not null,
	pr_operacion      int not null,
	pr_banco          varchar(32) not null,
	pr_cliente        int not null,
	pr_monto_pre      money  not null,
	pr_monto_seg      money  not null,
	pr_grupo          int not null,
	pr_tramite_grupal int not null,
	pr_referencia     varchar (64) not null,
	pr_fecha_pro      datetime not null,
	pr_fecha_ven      datetime     null,
	pr_user           varchar(32) not null,
	pr_term           varchar(32) not null,
	pr_mail           varchar(64) not null,

	pr_fecha_liq      datetime not null,
	pr_nombre_cl      varchar(100) not null,
	pr_num_abono      smallint not null,
	pr_nombre_of      varchar(100) not null,
	pr_nombre_banco   varchar(100) not null,
	pr_convenio       int not null,
	pr_estado         varchar(10) not null
)
go

create index idx_1 on ca_precancela_refer(pr_operacion, pr_secuencial)
go
create index idx_2 on ca_precancela_refer(pr_operacion, pr_referencia)
go
*/

--/////////////////////////////////////////////////////////////////////////////////////////
PRINT '======>>  creacion del producto'
go
delete ca_producto where cp_producto = 'DEV_SEG'
go
insert into ca_producto(
    cp_producto,    cp_descripcion,            
    cp_categoria,   cp_moneda, 
    cp_codvalor,    cp_desembolso,             cp_pago,      cp_atx, 
    cp_retencion,   cp_pago_aut,               cp_pcobis,    cp_producto_reversa, 
    cp_afectacion,  cp_estado,                 cp_act_pas,   cp_instrum_SB, 
    cp_canal)
values(
    'DEV_SEG',      'DEVOLUCION PAGO SEGURO',   
    'OTRO',         0, 
    138,            'N',                       'N',           'N', 
    0,              'S',                       NULL,          'DEV_SEG',   
    NULL,           'V',                       'T',           NULL, 
    NULL)
go

SELECT * FROM ca_producto WHERE cp_producto IN ('DEV_SEG', 'ND_BCO_MN')
GO

--/////////////////////////////////////////////////////////////////////////////////////////
PRINT '======>>  creacion del codigo valor'
go

DELETE cob_conta..cb_codigo_valor WHERE cv_empresa = 1 AND cv_producto = 7 AND cv_codval = 138
go

insert into cob_conta..cb_codigo_valor
select 
    1,  7,  cp_codvalor,    cp_descripcion
from   cob_cartera..ca_producto
WHERE cp_codvalor = 138
go

SELECT * FROM cob_conta..cb_codigo_valor WHERE cv_empresa = 1 AND cv_producto = 7 AND cv_codval = 138

go
--/////////////////////////////////////////////////////////////////////////////////////////
PRINT '======>>  creacion del parametro contable'
go
DELETE cob_conta..cb_relparam WHERE re_empresa = 1 AND re_parametro = 'F_PAGO' AND re_clave = 'DEV_SEG' AND re_producto = 7
GO

INSERT INTO cob_conta..cb_relparam  VALUES( 1, 'F_PAGO' , 'DEV_SEG', '240123', 7, 'CTB_OF', 'D')
GO

SELECT * FROM cob_conta..cb_relparam WHERE re_empresa = 1 AND re_parametro = 'F_PAGO' AND re_clave = 'DEV_SEG' AND re_producto = 7
GO

--/////////////////////////////////////////////////////////////////////////////////////////
PRINT '======>>  creacion del perfil contable'
go

delete cob_conta..cb_det_perfil where dp_producto =7 and dp_perfil = 'CCA_RPA' and dp_codval = 138
go

insert into cob_conta..cb_det_perfil values (
    1,  7,  'CCA_RPA',  8,  'F_PAGO',     'CTB_OF',   1,  138,    'N',    'O', null, 'L')

go

select * from cob_conta..cb_det_perfil where dp_producto =7 and dp_perfil = 'CCA_RPA' and dp_codval = 138

go

