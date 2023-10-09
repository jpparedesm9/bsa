/******************************************************************/
/*  Archivo:                 cb_reporte_contable_cb.sp            */
/*  Stored procedure:        sp_reporte_contable_cb               */
/*  Base de Datos:           cob_conta_tercero                    */
/*  Producto:                ahorros - CB                         */
/*  Fecha:                   Ene/2016                             */
/******************************************************************/
/*          IMPORTANTE                                            */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  "MACOSA",representantes exclusivos para el Ecuador de la      */
/*  AT&T                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier autorizacion o agregado hecho por alguno de sus     */
/*  usuario sin el debido consentimiento por escrito de la        */
/*  Presidencia Ejecutiva de MACOSA o su representante            */
/******************************************************************/
/*                        PROPOSITO                               */
/* Permite extraer transacciones de CB Red Posicionada para que   */
/* permita la revision de diferencias no identificadas            */
/* presentadas en el proceso de conciliación contable de CB,      */
/* por la ejecucion de los procesos de liberación de cupo         */
/* (Dispersión) fuera del horario establecido                     */
/* (No en el cierre sino durante el día).                         */
/******************************************************************/
/*                      MODIFICACIONES                            */
/*  FECHA       AUTOR                        RAZON                */
/*  Ene/2016    L.Guzmán                   Emisión Inicial REQ550 */
/******************************************************************/
use cob_conta_tercero
go

set nocount on
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_reporte_contable_cb')
   drop proc sp_reporte_contable_cb
go

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

go
