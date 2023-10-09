

/*************************************************/
---Fecha Creación del Script: 
--WTO   05/07/2016   Se crea la Tabla cc_causa_ingegr para la pantalla:
--                   Mantenimiento Causales Otro Ingresos/Egresos
/***************************************************/

USE cob_cuentas
GO


/* cc_causa_ingegr */
print '=====> cc_causa_ingegr'
go
if exists (select * from sysobjects where name = 'cc_causa_ingegr') 
 drop table cc_causa_ingegr
go
create table cc_causa_ingegr (
   ci_tipo             char(1)        not null,
   ci_causal           varchar(3)     not null,
   ci_cobro_iva        char(1)        null,
   ci_costo            money          null,
   ci_gasto_banco      char(1)        null,
   ci_efectivo         char(1)        null,
   ci_chq_propio       char(1)        null,
   ci_chq_local        char(1)        null,
   ci_ndnc_cte         char(1)        null,
   ci_ndnc_aho         char(1)        null,
   ci_causa_cte        char(3)        null,
   ci_caurev_cte       char(3)        null,
   ci_causa_aho        char(3)        null,
   ci_caurev_aho       char(3)        null,
   ci_programa         varchar(40)    null,
   ci_vigencia         tinyint        null
)
go
ALTER TABLE cc_causa_ingegr ADD CONSTRAINT pk_cc_causa_ingegr PRIMARY KEY (ci_tipo,ci_causal) 

go

	
