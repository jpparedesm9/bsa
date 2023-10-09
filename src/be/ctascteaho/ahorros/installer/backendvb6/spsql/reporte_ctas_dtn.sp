/************************************************************************/
/*      Archivo:                reporte_ctas_dtn.sp                     */
/*      Stored procedure:       sp_reporte_ctas_dtn                     */
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
/*      Generar Archivo Plano de Reintegro de Cuentas a la DTN          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_ctas_dtn')
   drop proc sp_reporte_ctas_dtn
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_reporte_ctas_dtn (
   @t_show_version  bit = 0
)
as
declare @w_sp_name           varchar(64),
        @w_return            int,
        @w_fecha             varchar(10),
        @w_nro_uvrs          int,
        @w_vr_ref_uvr        money,
        @w_monto_canc        money,
        @w_msg               varchar(255),
        @w_rowcount          int,
        @w_path_s_app        varchar(30),
        @w_path              varchar(250),
        @w_s_app             varchar(250),
        @w_cmd               varchar(255),
        @w_error             int,
        @w_comando           varchar(250),
        @w_tot_reg           int,
        @w_errores           descripcion,
        @w_archivo           descripcion,
        @w_archivo_bcp       descripcion,
        @w_encabezado        varchar(255)

-- Captura nombre de Stored Procedure
select @w_sp_name = 'sp_reporte_ctas_dtn'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if exists(select 1 from sysobjects where name = 'ah_rep_cta_dtn')
   drop table ah_rep_cta_dtn

create table ah_rep_cta_dtn (
cd_cuenta                varchar(24)   null,
cd_id_ente               varchar(30)   null,
cd_nombre                varchar(60)   null,
cd_disponible            money         null,
cd_fecha_inac            datetime      null,
cd_tipo_cta              varchar(60)   null,
cd_dias_inac             smallint      null,
cd_tel_fijo              varchar(16)   null,
cd_celular               varchar(16)   null,
cd_oficina               smallint      null,
cd_nom_oficina           varchar(60)   null,
cd_zona                  smallint      null,
cd_nom_zona              varchar(30)   null,
cd_tipo_soc              varchar(60)   null,
cd_exenta                char(1)       null,
cd_tipo_cli              varchar(10)   null
)

select @w_fecha = convert(varchar(10),getdate(),101)

select @w_nro_uvrs = pa_int
from  cobis..cl_parametro
where pa_nemonico = 'CUVRT'
and   pa_producto = 'AHO'

if @@rowcount = 0
begin
   select @w_msg = 'NO SE ENCONTRO PARAMETRO DE CANTIDAD DE UVR, PARA CALCULO DE SALDO DE ENVIO'
   goto ERROR
end


-- Captura del valor de la UVR, para el dia de envio
select @w_vr_ref_uvr = ct_valor
from cob_conta..cb_cotizacion
where ct_moneda = 2     -- UVR --
and   ct_fecha  = @w_fecha

select  @w_rowcount = @@rowcount


if @w_rowcount = 0
begin
   select @w_msg = 'NO SE ENCONTRO VALOR DE UVR, PARA EL DIA DEL ENVIO'
   goto ERROR
end


-- Calculo del Monto para envio a la DTN
select @w_monto_canc =  isnull((@w_nro_uvrs * @w_vr_ref_uvr),0)



--selecci¾n de cuentas a trasladar
insert into ah_rep_cta_dtn
(cd_cuenta,
cd_id_ente,
cd_nombre,
cd_disponible,
cd_fecha_inac,
cd_tipo_cta,
cd_dias_inac,
cd_tel_fijo,
cd_celular,
cd_oficina,
cd_nom_oficina,
cd_zona,
cd_nom_zona,
cd_tipo_soc,
cd_exenta,
cd_tipo_cli
)
select
hi_cuenta,
ah_ced_ruc,
ah_nombre,
ah_disponible,
hi_fecha,
(select pb_descripcion from cob_remesas..pe_pro_bancario where pb_pro_bancario = ah_prod_banc),
datediff(dd,hi_fecha, @w_fecha),
isnull((select top 1 (CONVERT(VARCHAR,isnull(ltrim(rtrim(te_prefijo)),'0')) + '-' + te_valor) from cobis..cl_direccion, cobis..cl_telefono where di_principal  = 'S' and di_direccion = te_direccion and te_ente = di_ente and te_secuencial = di_telefono and di_ente = a.ah_cliente and te_tipo_telefono = 'F'),'NO TIENE'),
isnull((select top 1 (CONVERT(VARCHAR,isnull(ltrim(rtrim(te_prefijo)),'0')) + '-' + te_valor) from cobis..cl_direccion, cobis..cl_telefono where di_principal  = 'S' and di_direccion = te_direccion and te_ente = di_ente and te_secuencial = di_telefono and di_ente = a.ah_cliente and te_tipo_telefono = 'C'),'NO TIENE'),
ah_oficina,
(select of_nombre from cobis..cl_oficina where of_oficina = a.ah_oficina),
(select of_zona from cobis..cl_oficina where of_oficina = a.ah_oficina),
(select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_zona = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo = 'O' and a.of_oficina = ah_oficina),
(select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'ah_cla_cliente' and a.codigo = b.tabla and b.codigo = ah_tipocta_super),
null,
(select mo_mercado_objetivo from cobis..cl_mercado_objetivo_cliente where mo_ente = a.ah_cliente)
from  cob_ahorros..ah_his_inmovilizadas, cob_ahorros..ah_cuenta a
where hi_cuenta = ah_cta_banco
and   (@w_monto_canc = 0 or hi_saldo <= @w_monto_canc)
and   hi_saldo > 0
and   hi_cuenta not in (select tn_cuenta
                        from   cob_remesas..re_tesoro_nacional
                        where  tn_tipo_cta in (2,3))


if @@error <> 0
begin
   select @w_msg = 'ERROR AL INSERTAR DATOS EN cob_ahorros..ah_rep_cta_dtn '+ convert(varchar, @@error)
   goto ERROR
end

update cob_ahorros..ah_rep_cta_dtn
set cd_exenta = 'S'
from cob_ahorros..ah_exenta_gmf,cob_ahorros..ah_rep_cta_dtn
where eg_cta_banco  = cd_cuenta
and eg_marca = 'S'

if @@error <> 0
begin
   select @w_msg = 'ERROR AL ACTUALIZAR DATOS EN cob_ahorros..ah_rep_cta_dtn '+ convert(varchar, @@error)
   goto ERROR
end

update cob_ahorros..ah_rep_cta_dtn
set cd_exenta = 'N'
where  cd_exenta is null

if @@error <> 0
begin
   select @w_msg = 'ERROR AL ACTUALIZAR EXENCION EN cob_ahorros..ah_rep_cta_dtn '+ convert(varchar, @@error)
   goto ERROR
end

update cob_ahorros..ah_rep_cta_dtn
set cd_tipo_cli = 'URBANO'
where  cd_tipo_cli =  'U'

if @@error <> 0
begin
   select @w_msg = 'ERROR AL ACTUALIZAR TIPO DE CLIENTE EN cob_ahorros..ah_rep_cta_dtn '+ convert(varchar, @@error)
   goto ERROR
end

update cob_ahorros..ah_rep_cta_dtn
set cd_tipo_cli = 'RURAL'
where  cd_tipo_cli =  'R'

if @@error <> 0
begin
   select @w_msg = 'ERROR AL ACTUALIZAR TIPO DE CLIENTE RURAL EN cob_ahorros..ah_rep_cta_dtn '+ convert(varchar, @@error)
   goto ERROR
end

select @w_tot_reg = count(1)
  from cob_ahorros..ah_rep_cta_dtn

if @w_tot_reg > 1
begin
if exists(select 1 from sysobjects where name = 'tmp_detalle_dtn')
   drop table tmp_detalle_dtn

   create table tmp_detalle_dtn(
   registro     varchar(500))

   select @w_encabezado  = 'CUENTA|ID CLIENTE|NOMBRE|DISPONIBLE|FECHA INACTIVIDAD|TIPO CUENTA|DIAS INACTIVIDAD|TELEFONO FIJO|CELULAR|OFICINA|NOMBRE OFICINA|ZONA|NOMBRE ZONA|TIPO SOCIEDAD|EXENTA GMF|TIPO CLIENTE'


   insert into tmp_detalle_dtn(registro)
   values (@w_encabezado)

   if @@error <> 0
   begin
     select @w_msg = 'ERROR AL INSERTAR ENCABEZADO '+ convert(varchar, @@error)
     goto ERROR
   end

   select 'cuenta' = cd_cuenta, 'fecha' = max(cd_fecha_inac)
   into #cuentas
    from cob_ahorros..ah_rep_cta_dtn
   group by cd_cuenta
   having max(cd_fecha_inac) <= @w_fecha

   insert into tmp_detalle_dtn
   select cd_cuenta + '|' + cd_id_ente + '|' + isnull(cd_nombre,'NO EXISTE NOMBRE')   + '|' + convert(varchar(20),cd_disponible) + '|' + convert(varchar(10),cd_fecha_inac,103) +
        '|' + cd_tipo_cta + '|' + convert(varchar(6),cd_dias_inac)+ '|' + cd_tel_fijo + '|' + cd_celular + '|' +convert(varchar(4),cd_oficina) +
        '|' + cd_nom_oficina + '|' + convert(varchar(4),cd_zona) + '|' + cd_nom_zona + '|' +  cd_tipo_soc + '|' + cd_exenta + '|' +   cd_tipo_cli
   from  cob_ahorros..ah_rep_cta_dtn, #cuentas
   where cd_cuenta =  cuenta
     and cd_fecha_inac = fecha

   if @@error <> 0
   begin
     select @w_msg = 'ERROR AL INSERTAR DETALLES '+ convert(varchar, @@error)
     goto ERROR
   end

   delete tmp_detalle_dtn
   where registro is null

   if @@error <> 0
   begin
     select @w_msg = 'ERROR AL INSERTAR DETALLES '+ convert(varchar, @@error)
     goto ERROR
   end

   select @w_path_s_app = pa_char
   from   cobis..cl_parametro
   where  pa_nemonico = 'S_APP'

   if @w_path_s_app is null begin
      select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
      goto ERROR
   end

   /* Se Realiza BCP */
   select @w_s_app = @w_path_s_app + 's_app'

   select @w_path = ba_path_destino
    from  cobis..ba_batch
    where ba_batch = 4193

   select @w_archivo = 'ctas_traslado_dtn_' + convert(varchar(10),getdate(),112) + '.txt',
          @w_errores = 'ctas_traslado_dtn_' + convert(varchar(10),getdate(),112) + '.err'

   select @w_archivo_bcp = @w_path  + @w_archivo,
          @w_errores     = @w_path  + @w_errores,
          @w_cmd         = @w_s_app + ' bcp -auto -login cob_ahorros..tmp_detalle_dtn out '

   select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'  + @w_errores  +  ' -config '+ @w_s_app + '.ini'

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0
   begin
      select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo+ ' '+ convert(varchar, @w_error)
      goto ERROR
   end

end
else begin
         select @w_msg = 'No Existen datos Para Generar Archivo Plano de Reintegro de Cuentas a la DTN'
         goto ERROR
     end

return 0

ERROR:

exec sp_errorlog
@i_fecha   = @w_fecha,
@i_error   = 1,
@i_usuario = 'opbatch',
@i_tran    = 0,
@i_cuenta  = '',
@i_descripcion = @w_msg

return 1

go

