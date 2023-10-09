IF OBJECT_ID ('ct_conciliacion') IS NOT NULL
	DROP TABLE ct_conciliacion
GO

IF OBJECT_ID ('ct_saldo_tercero') IS NOT NULL
	DROP TABLE ct_saldo_tercero
GO

IF OBJECT_ID ('ct_sasiento') IS NOT NULL
	DROP TABLE ct_sasiento
GO

IF OBJECT_ID ('ct_sasiento_tmp') IS NOT NULL
	DROP TABLE ct_sasiento_tmp
GO

IF OBJECT_ID ('ct_scomprobante') IS NOT NULL
	DROP TABLE ct_scomprobante
GO

IF OBJECT_ID ('ct_scomprobante_tmp') IS NOT NULL
	DROP TABLE ct_scomprobante_tmp
GO

IF OBJECT_ID ('sp_borrindmig') IS NOT NULL
	DROP PROCEDURE sp_borrindmig
GO

IF OBJECT_ID ('sp_reporte_contable_cb') IS NOT NULL
	DROP PROCEDURE sp_reporte_contable_cb
GO

CREATE TABLE dbo.ct_conciliacion
	(
	cl_producto          TINYINT NOT NULL,
	cl_comprobante       INT NOT NULL,
	cl_empresa           TINYINT NOT NULL,
	cl_fecha_tran        DATETIME NOT NULL,
	cl_asiento           INT NOT NULL,
	cl_cuenta            VARCHAR (30) NULL,
	cl_oficina_dest      INT NOT NULL,
	cl_area_dest         INT NOT NULL,
	cl_debcred           CHAR (1) NOT NULL,
	cl_valor             MONEY NOT NULL,
	cl_oper_banco        CHAR (4) NOT NULL,
	cl_doc_banco         CHAR (20) NULL,
	cl_banco             CHAR (3) NULL,
	cl_fecha_est         DATETIME NULL,
	cl_cuenta_cte        VARCHAR (20) NULL,
	cl_detalle           INT NULL,
	cl_relacionado       CHAR (1) NOT NULL,
	cl_modulo            SMALLINT NULL,
	cl_cheque            VARCHAR (64) NULL,
	cl_refinterna        INT NULL,
	cl_fecha_conc        DATETIME NULL,
	cl_tipo_conciliacion CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX i_ct_conciliacion1
	ON dbo.ct_conciliacion (cl_fecha_tran,cl_comprobante,cl_asiento)
GO

CREATE NONCLUSTERED INDEX i_ct_conciliacion2
	ON dbo.ct_conciliacion (cl_oper_banco,cl_comprobante,cl_asiento)
GO

CREATE TABLE dbo.ct_saldo_tercero
	(
	st_empresa        INT NOT NULL,
	st_periodo        INT NOT NULL,
	st_corte          INT NOT NULL,
	st_cuenta         cuenta_contable NOT NULL,
	st_oficina        SMALLINT NOT NULL,
	st_area           SMALLINT NOT NULL,
	st_ente           INT NOT NULL,
	st_saldo          MONEY NOT NULL,
	st_saldo_me       MONEY NOT NULL,
	st_mov_debito     MONEY NOT NULL,
	st_mov_credito    MONEY NOT NULL,
	st_mov_debito_me  MONEY NOT NULL,
	st_mov_credito_me MONEY NOT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_saldo_tercero_Key
	ON dbo.ct_saldo_tercero (st_corte,st_periodo,st_cuenta,st_oficina,st_area,st_ente,st_empresa)
GO

CREATE NONCLUSTERED INDEX ct_saldo_tercero_Key_cuenta
	ON dbo.ct_saldo_tercero (st_cuenta,st_periodo,st_corte)
GO

CREATE NONCLUSTERED INDEX ct_saldo_tercero_Key_ente
	ON dbo.ct_saldo_tercero (st_ente,st_periodo,st_corte)
GO

CREATE TABLE dbo.ct_sasiento
	(
	sa_producto               TINYINT NOT NULL,
	sa_comprobante            INT NOT NULL,
	sa_empresa                TINYINT NOT NULL,
	sa_fecha_tran             DATETIME NOT NULL,
	sa_asiento                INT NOT NULL,
	sa_cuenta                 CHAR (14) NOT NULL,
	sa_oficina_dest           SMALLINT NOT NULL,
	sa_area_dest              SMALLINT NOT NULL,
	sa_credito                MONEY NULL,
	sa_debito                 MONEY NULL,
	sa_concepto               VARCHAR (160) NOT NULL,
	sa_credito_me             MONEY NULL,
	sa_debito_me              MONEY NULL,
	sa_cotizacion             MONEY NULL,
	sa_tipo_doc               CHAR (1) NOT NULL,
	sa_tipo_tran              CHAR (1) NOT NULL,
	sa_moneda                 TINYINT NULL,
	sa_opcion                 TINYINT NULL,
	sa_ente                   INT NULL,
	sa_con_rete               CHAR (4) NULL,
	sa_base                   MONEY NULL,
	sa_valret                 MONEY NULL,
	sa_con_iva                CHAR (4) NULL,
	sa_valor_iva              MONEY NULL,
	sa_iva_retenido           MONEY NULL,
	sa_con_ica                CHAR (4) NULL,
	sa_valor_ica              MONEY NULL,
	sa_con_timbre             CHAR (4) NULL,
	sa_valor_timbre           MONEY NULL,
	sa_con_iva_reten          CHAR (4) NULL,
	sa_con_ivapagado          CHAR (4) NULL,
	sa_valor_ivapagado        MONEY NULL,
	sa_documento              CHAR (24) NULL,
	sa_mayorizado             CHAR (1) NOT NULL,
	sa_origen_mvto            VARCHAR (20) NULL,
	sa_con_dptales            CHAR (4) NULL,
	sa_valor_dptales          MONEY NULL,
	sa_posicion               CHAR (1) NULL,
	sa_debcred                CHAR (1) NULL,
	sa_oper_banco             CHAR (4) NULL,
	sa_cheque                 VARCHAR (64) NULL,
	sa_doc_banco              CHAR (20) NULL,
	sa_fecha_est              DATETIME NULL,
	sa_detalle                SMALLINT NULL,
	sa_error                  CHAR (1) NULL,
	sa_fecha_fin_difer        DATETIME NULL,
	sa_plazo_difer            INT NULL,
	sa_desc_difer             VARCHAR (160) NULL,
	sa_fecha_fin_difer_fiscal DATETIME NULL,
	sa_plazo_difer_fiscal     INT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_sasiento_AKey0
	ON dbo.ct_sasiento (sa_comprobante,sa_fecha_tran,sa_producto,sa_asiento)
GO

CREATE NONCLUSTERED INDEX ct_sasiento_AKey1
	ON dbo.ct_sasiento (sa_ente,sa_cuenta,sa_fecha_tran,sa_oficina_dest)
GO

CREATE NONCLUSTERED INDEX ct_sasiento_AKey2
	ON dbo.ct_sasiento (sa_cuenta,sa_fecha_tran,sa_oficina_dest)
GO

CREATE TABLE dbo.ct_sasiento_tmp
	(
	sa_producto               TINYINT NOT NULL,
	sa_comprobante            INT NOT NULL,
	sa_empresa                TINYINT NOT NULL,
	sa_fecha_tran             DATETIME NOT NULL,
	sa_asiento                INT NOT NULL,
	sa_cuenta                 VARCHAR (30) NULL,
	sa_oficina_dest           SMALLINT NOT NULL,
	sa_area_dest              SMALLINT NOT NULL,
	sa_credito                MONEY NULL,
	sa_debito                 MONEY NULL,
	sa_concepto               VARCHAR (160) NOT NULL,
	sa_credito_me             MONEY NULL,
	sa_debito_me              MONEY NULL,
	sa_cotizacion             MONEY NULL,
	sa_tipo_doc               CHAR (1) NOT NULL,
	sa_tipo_tran              CHAR (1) NOT NULL,
	sa_moneda                 TINYINT NULL,
	sa_opcion                 TINYINT NULL,
	sa_ente                   INT NULL,
	sa_con_rete               CHAR (4) NULL,
	sa_base                   MONEY NULL,
	sa_valret                 MONEY NULL,
	sa_con_iva                CHAR (4) NULL,
	sa_valor_iva              MONEY NULL,
	sa_iva_retenido           MONEY NULL,
	sa_con_ica                CHAR (4) NULL,
	sa_valor_ica              MONEY NULL,
	sa_con_timbre             CHAR (4) NULL,
	sa_valor_timbre           MONEY NULL,
	sa_con_iva_reten          CHAR (4) NULL,
	sa_con_ivapagado          CHAR (4) NULL,
	sa_valor_ivapagado        MONEY NULL,
	sa_documento              CHAR (24) NULL,
	sa_mayorizado             CHAR (1) NOT NULL,
	sa_origen_mvto            VARCHAR (20) NULL,
	sa_con_dptales            CHAR (4) NULL,
	sa_valor_dptales          MONEY NULL,
	sa_posicion               CHAR (1) NULL,
	sa_debcred                CHAR (1) NULL,
	sa_oper_banco             CHAR (4) NULL,
	sa_cheque                 VARCHAR (64) NULL,
	sa_doc_banco              CHAR (20) NULL,
	sa_fecha_est              DATETIME NULL,
	sa_detalle                SMALLINT NULL,
	sa_error                  CHAR (1) NULL,
	sa_fecha_fin_difer        DATETIME NULL,
	sa_plazo_difer            INT NULL,
	sa_desc_difer             VARCHAR (160) NULL,
	sa_fecha_fin_difer_fiscal DATETIME NULL,
	sa_plazo_difer_fiscal     INT NULL
	)
GO

CREATE NONCLUSTERED INDEX ct_sasiento_tmp_Key
	ON dbo.ct_sasiento_tmp (sa_fecha_tran,sa_producto,sa_comprobante,sa_asiento,sa_empresa)
GO

CREATE TABLE dbo.ct_scomprobante
	(
	sc_producto       TINYINT NOT NULL,
	sc_comprobante    INT NOT NULL,
	sc_empresa        TINYINT NOT NULL,
	sc_fecha_tran     DATETIME NOT NULL,
	sc_oficina_orig   SMALLINT NOT NULL,
	sc_area_orig      SMALLINT NOT NULL,
	sc_fecha_gra      DATETIME NOT NULL,
	sc_digitador      VARCHAR (160) NOT NULL,
	sc_descripcion    VARCHAR (160) NOT NULL,
	sc_perfil         VARCHAR (20) NOT NULL,
	sc_detalles       INT NOT NULL,
	sc_tot_debito     MONEY NOT NULL,
	sc_tot_credito    MONEY NOT NULL,
	sc_tot_debito_me  MONEY NOT NULL,
	sc_tot_credito_me MONEY NOT NULL,
	sc_automatico     INT NULL,
	sc_reversado      CHAR (1) NOT NULL,
	sc_estado         CHAR (1) NOT NULL,
	sc_mayorizado     CHAR (1) NOT NULL,
	sc_observaciones  VARCHAR (160) NULL,
	sc_comp_definit   INT NULL,
	sc_usuario_modulo VARCHAR (160) NOT NULL,
	sc_causa_error    CHAR (30) NULL,
	sc_comp_origen    INT NULL,
	sc_tran_modulo    VARCHAR (20) NULL,
	sc_error          CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX ct_scomprobante_AKey1
	ON dbo.ct_scomprobante (sc_estado,sc_fecha_tran)
GO

CREATE NONCLUSTERED INDEX ct_scomprobante_idx5
	ON dbo.ct_scomprobante (sc_estado,sc_fecha_tran)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_scomprobante_Key
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_producto,sc_comprobante,sc_empresa)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_mayorizado)
GO

CREATE NONCLUSTERED INDEX i_ct_scomp_1
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_producto,sc_oficina_orig,sc_area_orig,sc_perfil)
GO

CREATE TABLE dbo.ct_scomprobante_tmp
	(
	sc_producto       TINYINT NOT NULL,
	sc_comprobante    INT NOT NULL,
	sc_empresa        TINYINT NOT NULL,
	sc_fecha_tran     DATETIME NOT NULL,
	sc_oficina_orig   SMALLINT NOT NULL,
	sc_area_orig      SMALLINT NOT NULL,
	sc_fecha_gra      DATETIME NOT NULL,
	sc_digitador      VARCHAR (160) NOT NULL,
	sc_descripcion    VARCHAR (160) NOT NULL,
	sc_perfil         VARCHAR (20) NOT NULL,
	sc_detalles       INT NOT NULL,
	sc_tot_debito     MONEY NOT NULL,
	sc_tot_credito    MONEY NOT NULL,
	sc_tot_debito_me  MONEY NOT NULL,
	sc_tot_credito_me MONEY NOT NULL,
	sc_automatico     INT NULL,
	sc_reversado      CHAR (1) NOT NULL,
	sc_estado         CHAR (1) NOT NULL,
	sc_mayorizado     CHAR (1) NOT NULL,
	sc_observaciones  VARCHAR (160) NULL,
	sc_comp_definit   INT NULL,
	sc_usuario_modulo VARCHAR (160) NOT NULL,
	sc_causa_error    CHAR (30) NULL,
	sc_comp_origen    INT NULL,
	sc_tran_modulo    VARCHAR (20) NULL,
	sc_error          CHAR (1) NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_scomprobante_tmp_Key
	ON dbo.ct_scomprobante_tmp (sc_fecha_tran,sc_producto,sc_comprobante,sc_empresa)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.ct_scomprobante_tmp (sc_oficina_orig,sc_fecha_tran,sc_producto)
GO

create proc sp_borrindmig 
as 

drop index ct_migtran.i_migtran

return 0

GO

create proc sp_reporte_contable_cb(
   @i_param1   datetime                  -- FECHA TRANSACCION 
)

as
declare
   @w_fecha_trn      datetime,
   @w_fecha_proceso  varchar(10),
   @w_fecha_trn2     varchar(10),
   @w_error          int,
   @w_msg            varchar(250),
   @w_sp_name        varchar(32),   
   --PARAMETROS PARA BCP
   @w_s_app          varchar(50),
   @w_path           varchar(60),
   @w_cmd            varchar(255),
   @w_destino        varchar(255),   
   @w_comando        varchar(5000),
   @w_errores        varchar(1500),
   @w_path_destino   varchar(255),
   @w_anio			   varchar(4),
   @w_mes			   varchar(2),
   @w_dia			   varchar(2),
   @w_fecha1		   varchar(50),      
   @w_nombre		   varchar(255),
   @w_columna		   varchar(100),
   @w_nom_tabla	   varchar(100),
   @w_col_id		   int,
   @w_cabecera		   varchar(5000),
   @w_nombre_cab	   varchar(255),
   @w_nombre_plano	varchar(2500)

   /* INICIALIZACION DE VARIABLE */
select @w_fecha_trn     = @i_param1,
       @w_fecha_proceso = (select convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso),
       @w_sp_name       = 'sp_reporte_contable_cb',
       @w_error         = 0,
       @w_msg           = '',
       @w_fecha_trn2    = convert(varchar(10),@w_fecha_trn,101)

/*** PARAMETROS GENERALES ***/
--PATH DE UBICACION
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

/*** RUTA GENERACIÓN DE LOS LISTADO ***/
select @w_path = pp_path_destino 
from   cobis..ba_path_pro
where  pp_producto = 4

-----------------------------------------------------------------------
--GENERANDO BCP
-----------------------------------------------------------------------
select @w_anio    = substring(@w_fecha_trn2,7,10),
       @w_mes     = substring(@w_fecha_trn2,1,2), 
       @w_dia     = substring(@w_fecha_trn2,4,5)

select @w_fecha1  = (right('00' + @w_mes,2) + right('00'+ @w_dia,2) +  @w_anio)

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select 
@w_nombre       = 'reporte_contable_cb',
@w_nom_tabla    = 'ah_reporte_cont_tmp',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(1000), ''),
@w_nombre_cab   = @w_nombre

select @w_nombre_plano = @w_path + @w_nombre_cab + '_' + @w_fecha1 + '.txt'				

if exists (select 1 from sysobjects where name = 'ah_reporte_cont_tmp')
begin
   drop table ah_reporte_cont_tmp

   if @@error <> 0
   begin
      select @w_msg   = 'ERROR ELIMINANDO TABLA DE GENERACION DE PLANO TEMPORAL',
             @w_error = 1

      goto ERROR
   end
end

select 
OFICINA_DEST = convert(varchar, sa_oficina_dest),
AREA_DEST    = convert(varchar, sa_area_dest),
COMPROBANTE  = convert(varchar, sc_comprobante),
COMP_DEFINIT = convert(varchar, sc_comp_definit),
ASIENTO      = convert(varchar, sa_asiento),
EMPRESA      = convert(varchar, sa_empresa),
CUENTA       = convert(varchar, sa_cuenta), 
FECHA_TRAN   = convert(varchar, sa_fecha_tran, 101),
CONCEPTO     = convert(varchar, sa_concepto), 
DEBITO       = convert(varchar, sa_debito),
CREDITO      = convert(varchar, sa_credito),
ENTE         = sa_ente,
TIPO_DOC     = convert(varchar (255), 'NO APLICA'),
DOCUMENTO    = convert(varchar (255), 'NO APLICA'),
NOMBRE       = convert(varchar (255), 'NO APLICA'),
CHEQUE       = convert(varchar, sa_cheque),
OFICINA_ORIG = convert(varchar, sc_oficina_orig),
FECHA_GRA    = convert(varchar, sc_fecha_gra, 101)
into ah_reporte_cont_tmp
from cob_conta_tercero..ct_scomprobante, cob_conta_tercero..ct_sasiento
where sc_comprobante = sa_comprobante
and   sc_fecha_tran  = sa_fecha_tran
and   sc_producto    = sa_producto
and   sc_empresa     = sa_empresa
and   sc_fecha_tran  = @w_fecha_trn
and   sa_cuenta      in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso = 4273)

if @@error <> 0 
begin
   select @w_msg = 'ERROR CONSULTANDO TRANSACCIONES CB PARA REPORTE CONTABLE',
          @w_error = 1
   goto ERROR
end

update ah_reporte_cont_tmp set
TIPO_DOC  = en_tipo_ced,
DOCUMENTO = en_ced_ruc,
NOMBRE    = en_nomlar
from cobis..cl_ente
where ENTE = en_ente

if @@error <> 0 
begin
   select @w_msg = 'ERROR ACTUALIZANDO INFORMACION DEL CLIENTE',
          @w_error = 1
   goto ERROR
end

while 1 = 1 
begin
   set rowcount 1
   select 
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_conta_tercero..sysobjects o, cob_conta_tercero..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 
   begin
	   set rowcount 0
	   break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 
begin
   select @w_error = 2902797, @w_msg = 'EJECUCION COMANDO BCP FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERROR
end

--EJECUCION PARA GENERAR ARCHIVO DATOS
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_tercero..ah_reporte_cont_tmp out '

select  
@w_destino  = @w_path + 'reporte_contable_cb.txt',
@w_errores  = @w_path + 'reporte_contable_cb.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 
begin
   select @w_msg = 'ERROR GENERANDO ARCHIVO REPORTE CONTABLE CB' 
   goto ERROR
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'reporte_contable_cb.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando
	
select @w_cmd = 'del ' + @w_destino 
exec xp_cmdshell @w_cmd

if @w_error <> 0 
begin
   select @w_msg = 'EJECUCION COMANDO BCP FALLIDA. ELIMINACION DE ARCHIVO, REVISAR ARCHIVOS DE LOG GENERADOS'
   goto ERROR
end

RETURN 0

ERROR:

   print @w_msg
   return @w_error


GO

