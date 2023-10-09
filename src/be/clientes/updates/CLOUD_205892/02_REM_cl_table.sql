-- Autor: WToledo
-- Fecha: 25/05/2023
-- Instalador: \\src\be\clientes\installer\sql\cl_table.sql

use cobis
go

IF OBJECT_ID ('rte_eval_grp_en017') IS NOT NULL
	DROP TABLE rte_eval_grp_en017
GO
print '=====> rte_eval_grp_en017'
create table rte_eval_grp_en017(
	eg_bc_secuencial				int			, -- 1 a 10,000,000
	eg_folio_solicitud              varchar(64)	, -- 1 a 10,000,000
	eg_fecha_solicitud              datetime	, -- 01/01/2000 en adelante
	eg_bc_fecha_solicitud_num       varchar(6),	  -- 202001 en adelante
	eg_bc_fecha_solicitud_semana    varchar(6),	  -- 202001 en adelante
	eg_sucursal                     varchar(64)	, -- Catálogo Sucursales
	eg_cc                           int	,	      -- 1 al 1,000,000
	eg_regional                     varchar(64) , -- Catálogo Regionales
	eg_clave_asesor                 int	,	      -- 1 al 1,000,000
	eg_clave_gerente                int	,	      -- 1 al 1,000,000
	eg_clave_cordinador             int	,	      -- 1 al 1,000,000
	eg_ciclo_cliente                smallint,	  -- 1 a 1000
	eg_monto_solicitado             money	,	  -- 1000 a 200,000
	eg_plazo_solicitado             smallint,	  -- 1 a 350
	eg_periodicidad_solicitada      varchar(64)	, -- S,Q,M
	eg_bc_score                     int	,	      -- <ValorScore>
	eg_clave_score                  varchar(3)	, -- 17
	eg_bc_score_nombre              varchar(50)	, -- <nombreScore>
	eg_bc_score_codrazon            varchar(4),	  -- <CodigoRazon>
	eg_id_cliente_cobis             int	,	      -- 1 a 10,000,000
	eg_producto_prestamos           varchar(10),  -- Grupal, Individual, Revolvente
	eg_subprod_prestamo             char(1)	,	  -- Individual, Promo, Tradicional
	eg_bc_tiene_cuentas             smallint,	  -- 0,1
	eg_bc_saldo_vencido             money,	-- Positivos
	eg_bc_max_morosidad_hist        varchar(5),	-- En orden de menor a mayor: ' ', D,U,-,0,1,2,3,4,5,6,7,9
	eg_bc_clave_observacion         smallint,	-- Anexo 6, Manual Técnico BC xml
	eg_nivel_riesgo                 char(1)	,	-- A,B,C,D, E, F
	eg_nivel_riesgo_score           char(2),	-- MB: Muy Bajo | B: Bajo | M: Medio | A: Alto | MA: Muy Alto
	eg_semaforo                     varchar(15),	-- Amarillo, Rojo o Verde
	eg_estatus_aprobacion           smallint,		-- -1,0,1
	-- -----------------------------------
	eg_fecha_reg					datetime,
	eg_login					    varchar(30)
)                                                       
go

print '=====> rte_eval_grp_en017_Key'
go

CREATE CLUSTERED INDEX rte_eval_grp_en017_Key ON rte_eval_grp_en017 (eg_login,eg_fecha_reg)
go


-- --------------------------------------------------------------------------------------------------------------
IF OBJECT_ID ('rte_eval_grp_en017_hist') IS NOT NULL
	DROP TABLE rte_eval_grp_en017_hist
GO
print '=====> rte_eval_grp_en017_hist'
create table rte_eval_grp_en017_hist(
	eh_bc_secuencial				int			,
	eh_folio_solicitud              varchar(64)	,
	eh_fecha_solicitud              datetime	,
	eh_bc_fecha_solicitud_num       varchar(6),	 
	eh_bc_fecha_solicitud_semana    varchar(6),	 
	eh_sucursal                     varchar(64)	,
	eh_cc                           int	,	     
	eh_regional                     varchar(64) ,
	eh_clave_asesor                 int	,	     
	eh_clave_gerente                int	,	     
	eh_clave_cordinador             int	,	     
	eh_ciclo_cliente                smallint,	 
	eh_monto_solicitado             money	,	 
	eh_plazo_solicitado             smallint,	 
	eh_periodicidad_solicitada      varchar(64)		,
	eh_bc_score                     int	,	     
	eh_clave_score                  varchar(3)	,
	eh_bc_score_nombre              varchar(50)	,
	eh_bc_score_codrazon            varchar(4),	 
	eh_id_cliente_cobis             int	,	     
	eh_producto_prestamos           varchar(10), 
	eh_subprod_prestamo             char(1)	,	 
	eh_bc_tiene_cuentas             smallint,	 
	eh_bc_saldo_vencido             money,
	eh_bc_max_morosidad_hist        varchar(5),
	eh_bc_clave_observacion         smallint,
	eh_nivel_riesgo                 char(1)	,	
	eh_nivel_riesgo_score           char(2),	
	eh_semaforo                     varchar(15),
	eh_estatus_aprobacion           smallint,
	eh_fecha_reg					datetime,
	eh_login					    varchar(30),
	-- -----------------------------------
	eh_fecha_hist					datetime
)                                                       
go

print '=====> rte_eval_grp_en017_hist_Key'
go

CREATE CLUSTERED INDEX rte_eval_grp_en017_hist_Key ON rte_eval_grp_en017_hist (eh_fecha_hist)
go


/*************** Tabla de varchars para reporte ***********************************************************/
use cobis
go

if object_id ('rte_eval_grp_en017_rpt') is not null
	drop table rte_eval_grp_en017_rpt
go

print '=====> rte_eval_grp_en017_rpt'
create table rte_eval_grp_en017_rpt(
	re_bc_secuencial				varchar(13), 
	re_folio_solicitud              varchar(64), 
	re_fecha_solicitud              varchar(15),
	re_bc_fecha_solicitud_num       varchar(22),	  
	re_bc_fecha_solicitud_semana    varchar(25),	  
	re_sucursal                     varchar(64), 
	re_cc                           varchar(8),	      
	re_regional                     varchar(64), 
	re_clave_asesor                 varchar(14),	      
	re_clave_gerente                varchar(14),	      
	re_clave_cordinador             varchar(16),	     
	re_ciclo_cliente                varchar(13),	  
	re_monto_solicitado             varchar(16),	  
	re_plazo_solicitado             varchar(16),	 
	re_periodicidad_solicitada      varchar(64), 
	re_bc_score                     varchar(8),	      
	re_clave_score                  varchar(11),
	re_bc_score_nombre              varchar(30),
	re_bc_score_codrazon            varchar(17),	  
	re_id_cliente_cobis             varchar(16),	     
	re_producto_prestamos           varchar(21),
	re_subprod_prestamo             varchar(20),	  
	re_bc_tiene_cuentas             varchar(16),
	re_bc_saldo_vencido             varchar(16),	
	re_bc_max_morosidad_hist        varchar(21),	
	re_bc_clave_observacion         varchar(20),	
	re_nivel_riesgo                 varchar(12),	
	re_nivel_riesgo_score           varchar(18),	
	re_semaforo                     varchar(10),
	re_estatus_aprobacion           varchar(18)
)                                                       
go

