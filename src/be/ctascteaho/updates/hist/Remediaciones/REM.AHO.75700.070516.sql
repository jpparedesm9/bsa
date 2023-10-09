/***************************************************************************/
--No Bug					 : 75700
--Título del Bug			 : MAN - Actualización GMF Ahorros y Corrientes
--Fecha					     : 07/05/2016
--Descripción del Problema	 : Presenta mensaje de error al presionar Buscar
--Descripción de la Solución : Creacion de la tabla cobis..cl_marc_cifin_gen
--Autor						 : Jorge Salazar Andrade
/***************************************************************************/

print 'Crea tabla Marcacion GMF Clientes'
use cobis
go

if exists (select 1 from sysobjects where name = 'cl_marc_cifin_gen')
   drop table cl_marc_cifin_gen
go
create table cl_marc_cifin_gen
(
    mcg_cod        int identity   not null,      
    mcg_tipo_ide   char(16)       not null,
    mcg_num_ide    varchar(20)    not null,
    mcg_nom_cli    varchar(254)   not null,
    mcg_est_ide    varchar(30)    not null,
    mcg_fec_exp    varchar(10)    not null,
    mcg_lug_exp    varchar(30)    not null,
    mcg_cod_msg    char(2)        not null,
    mcg_desc_msg   varchar(254)   not null,
)
go
create index idx1 on cl_marc_cifin_gen (mcg_tipo_ide, mcg_num_ide)
go

print 'Crea tabla Marcacion GMF Cuentas'
if exists (select 1 from sysobjects where name = 'cl_marc_cifin_ctas')
   drop table cl_marc_cifin_ctas
go
create table cl_marc_cifin_ctas
(
    mcc_cod           int            not null,      
    mcc_tipo_ent      varchar(10)    not null,
    mcc_nom_ent       varchar(100)   not null,
    mcc_num_cta       cuenta         not null,
    mcc_fec_ini_exe   varchar(10)    not null,
    mcc_fec_fin_exe   varchar(10)    not null,
    mcc_nom_suc       varchar(100)   not null,    
    mcc_cod_est_cta   char(2)        not null
)
go
create index idx1 on cl_marc_cifin_ctas (mcc_cod)
go

