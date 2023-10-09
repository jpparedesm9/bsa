/************************************************************************/
/*      Archivo:                rep_retiro_ofic.sp                      */
/*      Stored procedure:       sp_rep_retiro_ofic                      */
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
/*      Reporte Retiro de Oficina                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_retiro_ofic')
   drop proc sp_rep_retiro_ofic
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_rep_retiro_ofic (
   @t_show_version  bit = 0,
   @i_param1      varchar(255)  -- Fecha Corte
)
as

declare
   @i_fecha_fin   datetime,
   @w_sp_name     varchar(32),
   @w_return      int,
   @w_error       int,
   @w_msg         varchar(255),
   @w_s_app             varchar(50),
   @w_cmd               varchar(255),
   @w_comando           varchar(255),
   @w_nombre_archivo    varchar(255),
   @w_mensaje           varchar(1000),
   @w_path_destino      varchar(100),
   @w_anio        char(4),
   @w_mes         char(2),
   @w_dia         char(2)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_retiro_ofic'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @i_fecha_fin = convert(datetime,@i_param1)

/* LIMPIAR TABLA */
delete ah_rep_retiros_ofic

/* UNIVERSO DE CUENTAS CON RETIROS */
select
'tipo_tran' = tm_tipo_tran,
'oficina'   = tm_oficina,
'cta_banco' = tm_cta_banco,
'ente'      = convert(varchar(10),null),
'tipo_ced'  = convert(varchar(10),null),
'ced_ruc'   = convert(varchar(30),null),
'valor_efectivo' = case when tm_tipo_tran in (263,371) then sum(isnull(tm_valor,0)) else 0 end,
'valor_cheque'   = case when tm_tipo_tran in (380) then sum(isnull(tm_valor,0)) else 0 end,
'num_retiros'    = count(1)
into #universo_retiro
from cob_ahorros..ah_tran_monet_tmp
where tm_fecha = @i_fecha_fin
and   tm_estado is null
and   tm_tipo_tran in (263,371,380)
group by tm_tipo_tran, tm_cta_banco, tm_oficina
if @@rowcount = 0 Begin
   print 'NO EXISTEN CUENTAS PARA PROCESAR. FECHA: '+ convert(varchar(10),@i_fecha_fin,103)
   select @w_mensaje = 'NO EXISTEN CUENTAS PARA PROCESAR. FECHA: '+ convert(varchar(10),@i_fecha_fin,103),
          @w_error   = 0
   Goto ERROR
End

insert into cob_ahorros..ah_rep_retiros_ofic
(rr_oficina, rr_cta_banco, rr_num_retiros,
 rr_ente,    rr_tipo_ced,  rr_ced_ruc,
 rr_retiro_efec,
 rr_retiro_chq)
select
oficina,     cta_banco,    sum(isnull(num_retiros,0)),
ente,        tipo_ced,     ced_ruc,
sum(isnull(valor_efectivo,0)),
sum(isnull(valor_cheque,0))
from #universo_retiro
group by cta_banco, oficina, ente, tipo_ced, ced_ruc
if @@error <> 0 Begin
   print 'ERROR INSERTANDO INFORMACION RETIROS. FECHA: '+convert(varchar(10),@i_fecha_fin,103)
   select @w_mensaje = 'ERROR INSERTANDO INFORMACION RETIROS. FECHA: '+convert(varchar(10),@i_fecha_fin,103),
          @w_error   = 400002
   Goto ERROR
End

/* ACTUALIZAR DATOS DEL CLIENTE */
update cob_ahorros..ah_rep_retiros_ofic set
rr_ente = ah_cliente,
rr_ced_ruc  = ah_ced_ruc
from cob_ahorros..ah_cuenta,
    cob_ahorros..ah_rep_retiros_ofic
where ah_cta_banco = rr_cta_banco
if @@error <> 0 Begin
   print 'ERROR ACTUALIZANDO CODIGO TITULAR'
   select @w_mensaje = 'ERROR ACTUALIZANDO CODIGO TITULAR',
          @w_error = 400003
   Goto ERROR
End

update cob_ahorros..ah_rep_retiros_ofic set
rr_tipo_ced = en_tipo_ced
from cobis..cl_ente,
     cob_ahorros..ah_rep_retiros_ofic
where en_ente = rr_ente
if @@error <> 0 Begin
   print 'ERROR ACTUALIZANDO DOCUMENTO TITULAR'
   select @w_mensaje = 'ERROR ACTUALIZANDO DOCUMENTO TITULAR',
          @w_error = 400004
   Goto ERROR
End

--*******************************************--
---> GENERAR BCP
--*******************************************--

if exists(select 1 from sysobjects where id = object_id('tmp_rep_retiros_ofic'))
   drop table tmp_rep_retiros_ofic

create table tmp_rep_retiros_ofic
(tmp_ced_ruc varchar(30), tmp_ente varchar(12),
 tmp_cta_banco varchar(30), tmp_num_retiros varchar(15), tmp_retiro_efec varchar(20),
 tmp_retiro_chq varchar(20),  tmp_oficina varchar(10)
)
create nonclustered index idx1 on tmp_rep_retiros_ofic(tmp_ced_ruc)

/* INSERTAR CABECERA DEL ARCHIVO */
insert into tmp_rep_retiros_ofic
select
convert(varchar(30),'No. DOCUMENTO'),
convert(varchar(12),'COD. CLIENTE'),
convert(varchar(30),'No. CUENTA'),
convert(varchar(15),'CANT. RETIROS'),
convert(varchar(20),'VALOR RETIROS EFE.'),
convert(varchar(20),'VALOR RETIROS CHQ.'),
convert(varchar(10),'OFICINA')
if @@error <> 0 Begin
   print 'ERROR INSERTANDO CABECERA DE ARCHIVO'
   select @w_mensaje = 'ERROR INSERTANDO CABECERA DE ARCHIVO',
          @w_error = 400005
   Goto ERROR
End

 /* INSERTAR DETALLE DEL ARCHIVO */
insert into tmp_rep_retiros_ofic
(tmp_ced_ruc,     tmp_ente,
 tmp_cta_banco,   tmp_num_retiros, tmp_retiro_efec,
 tmp_retiro_chq,  tmp_oficina)
select
 convert(varchar(30),rr_ced_ruc),
 convert(varchar(12),rr_ente),
 convert(varchar(30),rr_cta_banco),
 convert(varchar(15),rr_num_retiros),
 convert(varchar(20),rr_retiro_efec),
 convert(varchar(20),rr_retiro_chq),
 convert(varchar(10),rr_oficina)
from cob_ahorros..ah_rep_retiros_ofic
order by rr_ced_ruc asc
if @@error <> 0 Begin
   print 'ERROR INSERTANDO DETALLE DE ARCHIVO'
   select @w_mensaje = 'ERROR INSERTANDO DETALLE DE ARCHIVO',
          @w_error = 400006
   Goto ERROR

End


/* PATH DE LISTADOS */
Select @w_path_destino = ba_path_destino
from cobis..ba_batch
where ba_batch = 4254
if @@rowcount = 0 Begin
   print 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH 4254'
   select @w_mensaje = 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH 4254',
          @w_error = 400007
   Goto ERROR
End

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
if @@rowcount = 0 Begin
   print 'NO EXISTE RUTA DE S_APP'
   select @w_mensaje = 'NO EXISTE RUTA DE S_APP',
          @w_error = 400075
   Goto ERROR
End

select @w_anio = convert(varchar(4),datepart(yyyy,@i_fecha_fin)),
       @w_mes  = convert(varchar(2),'00'+datepart(mm,@i_fecha_fin)),
       @w_dia  = convert(varchar(2),datepart(dd,@i_fecha_fin))

if len(@w_mes) = 1
   select @w_mes = '0'+@w_mes

if len(@w_dia) = 1
   select @w_dia = '0'+@w_dia


select @w_nombre_archivo = @w_path_destino + 'REPRETAHO_' +@w_anio+@w_mes+@w_dia+ '.txt'

select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_ahorros..tmp_rep_retiros_ofic out '
select @w_comando = @w_cmd + @w_nombre_archivo + ' -t"|" -b5000 -c -e' + 'ERREPRET.err' + ' -config '+ @w_s_app + 's_app.ini'

--select @w_cmd     = 'bcp "select tmp_ced_ruc,tmp_ente,tmp_cta_banco,tmp_num_retiros,tmp_retiro_efec,tmp_retiro_chq,tmp_oficina from cob_ahorros..tmp_rep_retiros_ofic order by tmp_reg asc " queryout '
--select @w_comando = @w_cmd + @w_nombre_archivo + ' -t"|" -b5000 -c -T -S'+ @@servername + ' -eERREPRET.err'

exec @w_error = xp_cmdshell @w_comando

If @@error <> 0 Begin
   print 'ERROR GENERANDO BCP ' + @w_comando
   select @w_mensaje = 'NO EXISTE RUTA DE S_APP',
          @w_error = 400008
   Goto ERROR
End

drop table tmp_rep_retiros_ofic

Return 0

ERROR:

exec cob_ahorros..sp_errorlog
   @i_fecha        = @i_fecha_fin,
   @i_error        = @w_error,
   @i_usuario      = 'admuser',
   @i_tran         = null,
   @i_descripcion  = @w_mensaje,
   @i_programa     = @w_sp_name

Return @w_error

go

