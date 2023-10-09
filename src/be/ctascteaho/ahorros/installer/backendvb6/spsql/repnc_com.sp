/************************************************************************/
/*      Archivo:                repnc_com.sp                            */
/*      Stored procedure:       sp_repnc_com                            */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Reporte Nota de Credito Comisiones                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_repnc_com')
   drop proc sp_repnc_com
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_repnc_com (
   @t_show_version  bit = 0
)
as
declare
        @w_return                    int,
        @w_fecha             varchar(12),
        @w_error            varchar(255),
        @w_sp_name           varchar(30),
        --variables para bcp
        @w_archivo          varchar(255),
        @w_nom_archivo      varchar(100),
        @w_cmd              varchar(255),
        @w_comando          varchar(500),
        @w_path_s_app       varchar(100),
        @w_msg               varchar(50),
        @w_path             varchar(250),
        @w_anio                      int,
        @w_mes                       int,
        @w_dia                       int,
        @w_mensaje          varchar(1000),
        @w_fecha_max        datetime,
        @w_cod_prod         int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_repnc_com'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha_max = max(convert(datetime,tr_fecha,103)) from cob_ahorros..ah_tran_rechazos

if @w_fecha_max is null or @w_fecha_max = ''
   select @w_fecha_max = @w_fecha

select @w_cod_prod =  codigo
from   cobis..cl_tabla
where  tabla = 'cl_producto'

/* CREACION DE TABLA PARA TRANSACCIONES RECHAZADAS TMP*/
print '===> Creacion tabla transacciones rechazadas TMP'
if exists (select 1 from sys.objects where object_id = object_id('ah_tran_rechazos_tmp'))
   drop table cob_ahorros..ah_tran_rechazos_tmp

create table cob_ahorros..ah_tran_rechazos_tmp(
         tr_oficina             varchar(30),
         tr_cod_cliente         varchar(30),
         tr_id_cliente          varchar(30),
         tr_nom_cliente         varchar(255),
         tr_cta_banco           varchar(24),
         tr_tipo_tran           varchar(30),
         tr_nom_tran            varchar(64),
         tr_causal_rech         varchar(30),
         tr_cons_comision       varchar(30),
         tr_cons_iva            varchar(30),
         tr_modulo              varchar(30),
         tr_cantidad            varchar(30))

--INCLUIR CABECERA DEL ARCHIVO

insert into ah_tran_rechazos_tmp values
('Oficina',
'Codigo Ente',
'No. Cedula',
'Nombre del Cliente',
'No. Cuenta Ahorros',
'Codigo Transaccion',
'Nombre Transaccion',
'Causal Rechazo',
'Valor Acumulado Comision',
'Valor Acumulado Iva',
'Nombre del Modulo TRN',
'Cantidad')

if @@error <> 0 begin
    select @w_error = 999999, @w_msg = 'ERROR AL INSERTAR CABECERA EN LA TABLA ah_tran_rechazos_tmp'
    goto ERROR
end

insert into cob_ahorros..ah_tran_rechazos_tmp
select
convert(varchar,tr_oficina),
convert(varchar,tr_cod_cliente),
convert(varchar,tr_id_cliente),
tr_nom_cliente,
convert(varchar,tr_cta_banco),
convert(varchar,tr_tipo_tran),
tr_nom_tran = (select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code = tr_tipo_tran),
tr_causal_rech = (select mensaje from cobis..cl_errores where numero = tr_causal_rech),
convert(varchar,sum(tr_vlr_comision)),
convert(varchar,sum(tr_vlr_comision*0.16)),
(select valor from cobis..cl_catalogo where tabla = @w_cod_prod and codigo = 26),
count(1)
from cob_ahorros..ah_tran_rechazos
group by tr_oficina, tr_cod_cliente, tr_id_cliente,tr_nom_cliente,tr_cta_banco,tr_tipo_tran,tr_nom_tran,tr_vlr_comision,tr_vlr_iva,tr_causal_rech,tr_modulo--,tr_cons_comision,tr_cons_iva
order by tr_oficina, tr_cod_cliente, tr_id_cliente,tr_nom_cliente,tr_cta_banco,tr_tipo_tran,tr_nom_tran,tr_vlr_comision,tr_vlr_iva,tr_causal_rech,tr_modulo--,tr_cons_comision,tr_cons_iva

if @@error <> 0 begin
    select @w_error = 999999, @w_msg = 'ERROR AL INSERTAR DATOS EN LA TABLA ah_tran_rechazos_tmp'
    goto ERROR
end

select
@w_anio = convert(varchar(4),datepart(yyyy,@w_fecha)),
@w_mes  = replicate ('0', 2 - datalength(convert(varchar(2),'00'+datepart(mm,@w_fecha)))) + convert(varchar(2),'00'+datepart(mm,@w_fecha)),
@w_dia  = replicate ('0', 2 - datalength(convert(varchar(2),'00'+datepart(dd,@w_fecha)))) + convert(varchar(2),'00'+datepart(dd,@w_fecha))

--********************************************--
---> GENERAR BCP
--********************************************--

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
    select @w_error = 999999, @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
end

select @w_path = ba_path_destino
from  cobis..ba_batch
where ba_batch = 4163

if @@rowcount = 0
Begin
   select @w_msg = 'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_repnc_com',
          @w_error = 400001
   print  @w_msg
   goto ERROR
End

--GENERA BCP

select @w_nom_archivo = 'sp_rechazos_comisiones_' +convert(varchar(4),@w_anio)+convert(varchar(2),@w_mes)+convert(varchar(4),@w_dia)+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo
select @w_cmd = 'bcp "select tr_oficina,tr_cod_cliente,tr_id_cliente,'+
                'tr_nom_cliente,tr_cta_banco,tr_tipo_tran,tr_nom_tran,tr_causal_rech,tr_cons_comision,tr_cons_iva,tr_modulo,tr_cantidad '+
                'from cob_ahorros..ah_tran_rechazos_tmp" queryout '

select @w_comando = @w_cmd + @w_archivo + ' -t"|" -b5000 -c -T -S'+@@servername+ ' -e' + @w_archivo + '.err' --+ ' -config '+ @w_path_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

If @@error <> 0 Begin
   print 'ERROR GENERANDO BCP ' + @w_comando
   select @w_mensaje = 'NO EXISTE RUTA DE S_APP',
          @w_error = 400010
   Goto ERROR
End

drop table cob_ahorros..ah_tran_rechazos_tmp

return 0

ERROR:

exec cob_ahorros..sp_errorlog
   @i_fecha        = @w_fecha,
   @i_error        = @w_error,
   @i_usuario      = 'admuser',
   @i_tran         = null,
   @i_descripcion  = @w_mensaje,
   @i_programa     = @w_sp_name

Return @w_error

go

