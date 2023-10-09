/************************************************************************/
/*      Archivo:                rep_embargos.sp                         */
/*      Stored procedure:       sp_rep_embargos                         */
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
/*      Reporte de Embargos                                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_embargos')
   drop proc sp_rep_embargos
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_embargos (
   @t_show_version  bit = 0
)

as
declare @w_sp_name          varchar(30),
        @w_periodo          smallint,
        @w_empresa          tinyint,
        @w_pais             smallint,
        @w_dir_bancamia     varchar(64),
        @w_comando          varchar(255),
        @w_path             varchar(64),
        @w_archivo          varchar(100),
        @w_destino          varchar(255),
        @w_errores          varchar(255),
        @w_s_app            varchar(64),
        @w_error            int,
        @w_super            tinyint,
        @w_puc              tinyint,
        @w_fecha_ini        datetime,
        @w_fecha_fin        datetime,
        @w_fecha            varchar(10),
        @w_fecha_arch       varchar(10),
        @w_cmd              varchar(255),
        @w_sec              int,
        @w_cadena           varchar(255),
        @w_sec1             int,
        @w_cliente          int,
        @w_sec2             int,
        @w_cadena2          varchar(255),
        @w_sec3             int,
        @w_cadena3          varchar(255),
        @w_prod             tinyint

/* Captura del nombre del stored procedure */
select @w_sp_name = 'sp_rep_embargos'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha = convert(varchar(10), getdate(), 101)

select @w_fecha_arch = substring(@w_fecha ,1,2)  + substring(@w_fecha ,4,2)  + substring(@w_fecha ,7,4)

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

if @@rowcount = 0
begin
    print 'No Existe Path de Cartera'
    return 1
end

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount = 0
begin
    print 'No Existe Ruta de s_app'
    return 1
end

set rowcount 0

select 'ente' = ca_ente,
'cta' = de_num_cuenta,
'oficio' = ca_oficio,
'demanda' =  ca_demandante,
'juzgado' = ca_juzgado,
'monto' = ca_monto,
'producto' = ca_producto,
'oficina' = ca_oficina,
'tipo_doc' = ca_tipo_doc_demandante,
'doc' = ca_numero_doc_demandante,
'estado' = ca_estado,
'fecha_embargo' =  ca_fecha,
'fecha_oficio' =  ca_fecha_ofi ,
'nombre' = ca_nombre_demandante
into #datos
 from cobis..cl_cab_embargo with(nolock), cobis..cl_det_embargo with(nolock)
 where ca_ente >= 0
   and ca_ente = de_ente
   and ca_secuencial = de_secuencial
   and ca_tipo_proceso = 'B'
   and de_estado_levantamiento = 'N'
   and ca_nro_cta_especifica = de_num_cuenta


if exists(select 1 from sysobjects where name = 'ca_emb_temp')
   drop table ca_emb_temp

create table ca_emb_temp
(
 dt_data varchar(1000)
)

insert into ca_emb_temp values('PRODUCTO|OFICINA|TIPO DOC|DOCUMENTO|NOMBRE|ESTADO|NRO CTA ESPECIFICA|FECHA EMBARGO|FECHA OFICIO|JUZGADO|DEMANDANTE|MONTO|No. OFICIO')


insert into ca_emb_temp
select isnull(convert(varchar(15),producto),'0') + '|' + isnull(convert(varchar(6),oficina),'  ') + '|' + isnull(tipo_doc,' ' ) + '|' + isnull(convert(varchar(15),doc),'  ') + '|' + isnull(nombre,'  ') + '|' + isnull(estado, '  ') + '|' +  isnull(cta, '  ')   + '|' +
       isnull(convert(varchar(10),fecha_embargo, 101), '  ')  + '|' +  isnull(convert(varchar(10),fecha_oficio, 101), '  ')  + '|' + isnull(juzgado,'  ') + '|' + isnull(demanda,'  ')  + '|' + isnull(convert(varchar(20),monto),'  ') + '|' +  isnull(convert(varchar(40),oficio),'  ')
from  #datos

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ca_emb_temp out '

select
@w_destino  = @w_path + 'PROD_EMBA_'+ @w_fecha_arch + '.csv',
@w_errores  = @w_path + 'PROD_EMBA'+ @w_fecha_arch + '.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000   -c -e' + @w_errores + ' -t' + '"' +'&&'+ '"' + ' -config '+ @w_s_app + 's_app.ini'

  --    select @w_comando  = @w_cmd + @w_plano + @w_archivo + '.csv' + ' -b5000 -c ' + ' -t' + '"' +'&&'+ '"' + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   print 'Error generando el archivo plano'
   return 1
end

return 0

go

