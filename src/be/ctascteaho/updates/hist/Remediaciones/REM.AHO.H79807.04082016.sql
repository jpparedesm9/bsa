/*****************************************************************************/
--No Historia				 : H79807
--Título de la Historia		 : Cobro del Impuesto a la Renta (ISR)
--Fecha					     : 08/04/2016
--Descripción del Problema	 : Se requiere nuevos parametros para cobro del ISR
--Descripción de la Solución : Creacion de parametros para cobro del ISR
--Autor						 : Jorge Salazar Andrade
/*****************************************************************************/
use cobis
go

delete cobis..cl_parametro 
 where pa_nemonico in ('AEXISR','NAISR','CIISR','PANISR','BINCR')
   and pa_producto = 'AHO'
go

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto)
values
('APLICACION DE EXCENCION ISR','AEXISR','C','S','AHO')

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_tinyint,pa_producto)
values
('NUMERO DE ANUALIDADES ISR','NAISR','T',5,'AHO')

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto)
values
('COBRO IMPUESTO A LA RENTA ISR','CIISR','C','S','AHO')

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_float,pa_producto)
values
('PORCENTAJE ANUAL IMPUESTO A LA RENTA ISR','PANISR','F',0.5,'AHO')

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values
('BASE DIARIA INTERES PARA CALCULO DE RETENCION','BINCR','M',0.00,'AHO')
go

delete cobis..cl_parametro 
 where pa_nemonico in ('SMV')
   and pa_producto = 'ADM'
go

insert into cobis..cl_parametro
(pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values
('SALARIO MINIMO VITAL MENSUAL','SMV','M',2191.20,'ADM')


use cob_remesas
go

delete cob_remesas..re_concepto_imp
 where ci_tran        = 308
   and ci_impuesto    = 'R'
   and ci_contabiliza = 'tm_valor'
go

insert into cob_remesas..re_concepto_imp
(ci_tran,ci_causal,ci_impuesto,ci_concepto,ci_producto,ci_base1,ci_base2,ci_contabiliza,ci_fecha)
values
(308,0,'R','0210',4,'tm_interes',null,'tm_valor',getdate())
go

delete cob_remesas..re_concepto_imp
 where ci_tran        = 334
   and ci_impuesto    = 'C'
   and ci_contabiliza = 'tm_valor'
go

insert into cob_remesas..re_concepto_imp
(ci_tran,ci_causal,ci_impuesto,ci_concepto,ci_producto,ci_base1,ci_base2,ci_contabiliza,ci_fecha)
values
(334,0,'C','4010',4,'tm_interes',null,'tm_valor',getdate()
)
go


use cob_conta
go

--cob_conta..cb_conc_retencion
if exists (select 1 from sysobjects where name = 'cb_conc_retencion') begin
delete cob_conta..cb_conc_retencion
 where cr_empresa   = 1
   and cr_codigo    = '0210'
   and cr_tipo      = 'R'   
   and cr_debcred   = 'D'
end
else begin
print '--> Indice: cb_conc_retencion_Key'
if exists (select 1 from sysindexes where name = 'cb_conc_retencion_Key')
   drop index cb_conc_retencion.cb_conc_retencion_Key

print '--> Tabla: cb_conc_retencion'
create table cb_conc_retencion 
(
    cr_empresa     tinyint     not null,
    cr_codigo      char(4)     not null,
    cr_descripcion varchar(30) not null,
    cr_base        money       null,
    cr_porcentaje  float       null,
    cr_debcred     char(1)     not null,
    cr_tipo        char(1)     not null
)

create unique clustered index cb_conc_retencion_Key
    on cb_conc_retencion (cr_empresa,cr_codigo,cr_tipo,cr_debcred)
end
go

insert into cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo) 
values (1, '0210', 'IENTOS-AHORRO-DIARIO(DB)', 0.0000, 0.5, 'D', 'R')
go

--cob_conta..cb_ica
if exists (select 1 from sysobjects where name = 'cb_ica') begin
delete cob_conta..cb_ica
 where ic_empresa   = 1
   and ic_codigo    = '4010'
   and ic_debcred   = 'D'
end
else begin
print '--> Indice: cb_ica_Key'
if exists (select 1 from sysindexes where name = 'cb_ica_Key')
   drop index cb_ica.cb_ica_Key

print '--> Tabla: cb_ica'
create table cb_ica 
(
	ic_empresa     tinyint      not null,
	ic_codigo      char(4)      not null,
	ic_descripcion varchar(255) not null,
	ic_base        money        null,
	ic_porcentaje  float        null,
	ic_ciudad      int          null,
	ic_debcred     char(1)      not null
)

create unique clustered index cb_ica_Key
    on cb_ica (ic_empresa,ic_codigo,ic_ciudad,ic_debcred)
end
go

--cob_conta..cb_exencion_producto
if exists (select 1 from sysobjects where name = 'cb_exencion_producto')
   drop table cb_exencion_producto
go

print '--> Tabla: cb_exencion_producto'
CREATE TABLE dbo.cb_exencion_producto 
(
    ep_empresa  tinyint  not null,
    ep_regimen  catalogo not null,
    ep_producto tinyint  not null,
    ep_impuesto char(1)  not null,
    ep_concepto char(4)  not null
)
go

