/************************************************************************/
/*      Archivo:                rep_extractos.sp                        */
/*      Stored procedure:       sp_rep_extractos                        */
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
/*   EJECUCION comando bcp Extracto                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_extractos')
   drop proc sp_rep_extractos
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc  sp_rep_extractos(
   @t_show_version  bit = 0,
   @i_param1  tinyint,    -- Empresa
   @i_param2  datetime,   -- Fecha Inicio
   @i_param3  datetime,   -- Fecha Cierre Mes a Reportar
   @i_corresponsal char(1) = 'N'  --Req. 381 CB Red Posicionada
)

as
declare
@w_fecha             datetime,
@w_sp_name           varchar(30),
@w_s_app             varchar(255),
@w_path              varchar(255),
@w_nombre            varchar(255),
@w_nombre_cab        varchar(255),
@w_destino           varchar(2500),
@w_errores           varchar(1500),
@w_error             int,
@w_comando           varchar(3500),
@w_nombre_plano      varchar(2500),
@w_msg               varchar(255),
@w_empresa           tinyint,
@w_fecha_ini         datetime,
@w_fecha_fin         datetime,
@w_path_destino      varchar(100),
@w_col_id            int,
@w_columna           varchar(30),
@w_cabecera          varchar(2500),
@w_prod_bancario     varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_extractos'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_empresa     =  @i_param1,
       @w_fecha_ini   =  @i_param2,
       @w_fecha_fin   =  @i_param3,
       @w_fecha        = getdate()


print 'Detalle'
print ' '


if exists(select 1 from sysobjects where name = 'ah_rep_extractos')
   drop table ah_rep_extractos

create table ah_rep_extractos (
Nombre_Cliente           varchar(255)  null,
Cuenta                   varchar(16)   null,
Oficina                  smallint      null,
Cant_Extractos           int           null,
Mes                      varchar(20)   null,
Anio                     varchar(10)   null,
Fecha_Solicitud          varchar(20)   null
)

if exists(select 1 from sysobjects where name = 'ah_tot_rep_extractos')
   drop table ah_tot_rep_extractos

create table ah_tot_rep_extractos (
Oficina                  smallint      null,
Cant_Extractos           int           null,
Mes                      varchar(30)   null,
Anio                     varchar(10)   null
)

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   insert into ah_rep_extractos
   select en_nomlar, rtrim(he_cta_banco), ah_oficina, he_cont,  he_mes,  he_ano,  he_fecha
   from cob_remesas..re_his_extracto, cob_ahorros..ah_cuenta, cobis..cl_ente
   where he_fecha between @w_fecha_ini and @w_fecha_fin
   and he_cta_banco = ah_cta_banco
   and ah_ced_ruc   = en_ced_ruc
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   order by en_nomlar

   if @@error <> 0
   begin
      select @w_error = 2805004, @w_msg = 'Error en Insercion en cob_ahorros..ah_rep_extractos'
      goto ERROR
   end

   print 'Totalizado'
   print ' '
   select 'Oficina1' = ah_oficina, 'Contador' = sum(he_cont), 'Mes1' = datepart(mm,he_fecha), 'Anio1' = datepart(yyyy,he_fecha)
   into #ah_tot_rep_extrac_cb
   from cob_remesas..re_his_extracto  with (nolock), cob_ahorros..ah_cuenta with (nolock), cobis..cl_ente  with (nolock)
   where he_fecha  between @w_fecha_ini and @w_fecha_fin
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   and he_cta_banco = ah_cta_banco
   and ah_ced_ruc   = en_ced_ruc
   group by ah_oficina, datepart(mm,he_fecha), datepart(yyyy,he_fecha)
   order by ah_oficina

   if @@error <> 0
   begin
      select @w_error = 2805004, @w_msg = 'Error en Insercion en #ah_tot_rep_extrac_cb'
      goto ERROR
   end

   insert into ah_tot_rep_extractos
   select Oficina1, Contador,
   (case when Mes1 = 1 then 'ENERO' when Mes1 = 2  then 'FEBRERO'  when Mes1 = 3 then 'MARZO'
         when Mes1 = 4 then 'ABRIL' when Mes1 = 5  then 'MAYO'  when Mes1 = 6 then 'JUNIO'
         when Mes1 = 7 then 'JULIO' when Mes1 = 8  then 'AGOSTO'  when Mes1 = 9 then 'SEPTIEMBRE'
         when Mes1 = 10 then 'OCTUBRE' when Mes1 = 11  then 'NOVIEMBRE'
    else 'DICIEMBRE' end),
    Anio1
    from #ah_tot_rep_extrac_cb

    if @@error <> 0
    begin
       select @w_error = 2805004, @w_msg = 'Error en Insercion en cob_ahorros..ah_tot_rep_extractos_cb'
       goto ERROR
    end
end
else
begin
   insert into ah_rep_extractos
   select en_nomlar, rtrim(he_cta_banco), ah_oficina, he_cont,  he_mes,  he_ano,  he_fecha
   from cob_remesas..re_his_extracto, cob_ahorros..ah_cuenta, cobis..cl_ente
   where he_fecha between @w_fecha_ini and @w_fecha_fin
   and he_cta_banco = ah_cta_banco
   and ah_ced_ruc   = en_ced_ruc
   order by en_nomlar

   if @@error <> 0
   begin
      select @w_error = 2805004, @w_msg = 'Error en Insercion en cob_ahorros..ah_rep_extractos'
      goto ERROR
   end

   print 'Totalizado'
   print ' '
   select 'Oficina1' = ah_oficina, 'Contador' = sum(he_cont), 'Mes1' = datepart(mm,he_fecha), 'Anio1' = datepart(yyyy,he_fecha)
   into #ah_tot_rep_extrac
   from cob_remesas..re_his_extracto  with (nolock), cob_ahorros..ah_cuenta with (nolock), cobis..cl_ente  with (nolock)
   where he_fecha  between @w_fecha_ini and @w_fecha_fin
   and he_cta_banco = ah_cta_banco
   and ah_ced_ruc = en_ced_ruc
   group by ah_oficina, datepart(mm,he_fecha), datepart(yyyy,he_fecha)
   order by ah_oficina

   if @@error <> 0
   begin
      select @w_error = 2805004, @w_msg = 'Error en Insercion en #ah_tot_rep_extrac'
      goto ERROR
   end

   insert into ah_tot_rep_extractos
   select Oficina1, Contador,
   (case when Mes1 = 1 then 'ENERO' when Mes1 = 2  then 'FEBRERO'  when Mes1 = 3 then 'MARZO'
         when Mes1 = 4 then 'ABRIL' when Mes1 = 5  then 'MAYO'  when Mes1 = 6 then 'JUNIO'
         when Mes1 = 7 then 'JULIO' when Mes1 = 8  then 'AGOSTO'  when Mes1 = 9 then 'SEPTIEMBRE'
         when Mes1 = 10 then 'OCTUBRE' when Mes1 = 11  then 'NOVIEMBRE'
    else 'DICIEMBRE' end),
    Anio1
    from #ah_tot_rep_extrac

    if @@error <> 0
    begin
       select @w_error = 2805004, @w_msg = 'Error en Insercion en cob_ahorros..ah_tot_rep_extractos'
       goto ERROR
    end
end

select @w_path_destino = ba_path_destino
from cobis..ba_batch
where ba_batch = 4188

if @@rowcount = 0
Begin
   select
   @w_error = 201165,
   @w_msg = 'No Existe path_destino para el proceso : '
   GOTO ERROR
End

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount = 0
Begin
      select
   @w_error = 201164,
   @w_msg = 'NO EXISTE RUTA DEL S_APP'
   GOTO ERROR
End

--Generar Archivo de Cabeceras Detalle
----------------------------------------
select
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = 'rep_det_extracto'


select
@w_nombre_plano = @w_path_destino + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,@w_fecha)) + '_' + convert(varchar(2), datepart(mm,@w_fecha)) + '_' + convert(varchar(4), datepart(yyyy, @w_fecha))


select
@w_nombre_plano = @w_nombre_plano + '_' + convert(varchar(2), datepart(hh,@w_fecha)) + '_' + convert(varchar(2), datepart(mi,@w_fecha)) + + '_' + convert(varchar(2), datepart(ss,@w_fecha)) + '.txt'

while 1 = 1
begin
   set rowcount 1

   select @w_columna = c.name,
          @w_col_id  = c.colid
   from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
   where o.id    = c.id
   and   o.name  = 'ah_rep_extractos'
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
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERROR
end

--Ejecucion para Generar Archivo Datos

select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_rep_extractos out '

select
@w_destino  = @w_path_destino + 'tmp_datos_aho_ext.txt',
@w_errores  = @w_path_destino + 'tmp_datos_aho_ext.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   print 'Error Generando Archivo tmp_datos_aho_ext '
   return @w_error
end

----------------------------------------
--Union de archivo @w_nombre_plano con archivo tmp_datos_aho_ext.txt
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path_destino + 'tmp_datos_aho_ext.txt' + ' ' + @w_nombre_plano

select @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERROR
end


--Generar Archivo de Cabeceras Totales
----------------------------------------
select
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = 'rep_tot_extracto'


select
@w_nombre_plano = @w_path_destino + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,@w_fecha)) + '_' + convert(varchar(2), datepart(mm,@w_fecha)) + '_' + convert(varchar(4), datepart(yyyy, @w_fecha))


select
@w_nombre_plano = @w_nombre_plano + '_' + convert(varchar(2), datepart(hh,@w_fecha)) + '_' + convert(varchar(2), datepart(mi,@w_fecha)) + + '_' + convert(varchar(2), datepart(ss,@w_fecha)) + '.txt'

while 1 = 1
begin
   set rowcount 1

   select @w_columna = c.name,
          @w_col_id  = c.colid
   from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
   where o.id    = c.id
   and   o.name  = 'ah_tot_rep_extractos'
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
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERROR
end

--Ejecucion para Generar Archivo Datos

select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_tot_rep_extractos out '

select
@w_destino  = @w_path_destino + 'tmp_tot_aho_ext.txt',
@w_errores  = @w_path_destino + 'tmp_tot_aho_ext.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   print 'Error Generando Archivo tmp_tot_aho_ext '
   return @w_error
end

----------------------------------------
--Union de archivo @w_nombre_plano con archivo tmp_tot_aho_ext.txt
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path_destino + 'tmp_tot_aho_ext.txt' + ' ' + @w_nombre_plano

select @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERROR
end


select @w_comando = 'del ' +  @w_path_destino + 'tmp_datos_aho_ext.txt'
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando del FALLIDA'
    return 1
end



select @w_comando = 'del ' +  @w_path_destino + 'tmp_tot_aho_ext.txt'
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando del FALLIDA'
    return 1
end

return 0


ERROR:
  exec sp_errorlog
      @i_cuenta       = '0',
      @i_fecha        = @w_fecha,
      @i_error        = @w_error,
      @i_usuario      = 'batch',
      @i_tran         = 264,
      @i_descripcion  = @w_msg,
      @i_programa     = @w_sp_name

go

