/****************************************************************************/
/*     Archivo:     pe_corubro.sp                                           */
/*     Stored procedure: sp_corubros                                        */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa consulta rubros   Servicio Personalizable              */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      JUN/95         J.Gordillo    Personalizacion de Bco. Produccion     */
/*      30/Sep/2003    Gloria Rueda    Retornar c¢digos de error            */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_corubros')
  drop proc sp_corubros
go
create proc sp_corubros
(
  @s_ssn          int,
  @s_srv          varchar(30)=null,
  @s_lsrv         varchar(30)=null,
  @s_user         varchar(30)=null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char (1),
  @s_ofi          smallint,
  @s_rol          smallint =1,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1)='N',
  @t_file         varchar(14)=null,
  @t_from         varchar(32)=null,
  @t_rty          char(1)='N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint,
  @i_filial       tinyint = null,
  @i_sucursal     smallint = null,
  @i_producto     smallint=null,
  @i_codigo       smallint=null,
  @i_cod_subser   smallint=null,
  @i_cod_detalle  catalogo=null,
  @i_pro_final    smallint=null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_corubros'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      i_filial = @i_filial,
      i_sucursal = @i_sucursal,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_pro_final = @i_pro_final
    exec cobis..sp_end_debug
  end
/*Operaciones */
  /**BUSQUEDA **/
  if @i_operacion = 'S'
  begin
    if @t_trn != 4013
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15

    if @i_modo = 0
    begin
      select
        '1713' = sp_servicio_per,                  --SERVICIO PERSO.
        '1650' = sp_pro_final,                     --PROD.FINAL
	'1200' = pf_descripcion,                   --DESCRIPCION DEL PROD. FINAL
        '1707' = sp_servicio_dis,                  --SERV. DISPONIBLE
        '1203' = substring(sd_descripcion, 1, 35), --DESCRIPCION DEL SERVICIO
        '1689' = sp_rubro,                         --RUBRO
        '1197' = substring(valor, 1, 25),          --DESCRIPCION DEL RUBRO
        '1653' = pf_producto,                      --PRODUCTO
        '1206' = substring(pm_descripcion, 1, 35), --DESCRIPCION DEL PRODUCTO
        '1481' = pf_moneda,                        --MONEDA
        '1193' = substring(mo_descripcion, 1, 15), --DESCRIPCION DE MONEDA
        '1756' = pf_tipo,                          --TIPO PRODUCTO
        '1751' = substring(tr_descripcion, 1, 35), --TIPO DE RANGO
        '1759' = sp_tipo_rango,                    --TIPO RANGO
        '1382' = sp_grupo_rango                    --GRUPO DE RANGO
      from   pe_servicio_per,
             pe_pro_final,
             pe_servicio_dis,
             cobis..cl_catalogo,
             cobis..cl_pro_moneda,
             cobis..cl_moneda,
             pe_tipo_rango
      where  pf_pro_final    = sp_pro_final
         and sd_servicio_dis = sp_servicio_dis
         and pm_moneda       = pf_moneda
         and pm_producto     = pf_producto
         and sp_rubro        = codigo
         and tabla           = (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'pe_rubro')
         and mo_moneda       = pf_moneda
         and tr_tipo_rango   = sp_tipo_rango
         and pf_filial       = @i_filial
         and pf_sucursal     = @i_sucursal
      order  by sp_servicio_per
    end
    if @i_modo = 1
    begin
      select
        '1713' = sp_servicio_per,                  --SERVICIO PERSO.
        '1650' = sp_pro_final,                     --PROD.FINAL
        '1200'= substring(pf_descripcion, 1, 35),  --DESCRIPCION DEL PROD. FINAL
        '1707' = sp_servicio_dis,                  --SERV. DISPONIBLE
        '1203' = substring(sd_descripcion, 1, 35), --DESCRIPCION DEL SERVICIO
        '1689' = sp_rubro,                         --RUBRO
        '1202' = substring(valor, 1, 25),          --DESCRIPCION DEL RUBRO
        '1653' = pf_producto,                      --PRODUCTO
        '1206' = substring(pm_descripcion, 1, 35), --DESCRIPCION DEL PRODUCTO
        '1481' = pf_moneda,                        --MONEDA
        '1193' = substring(mo_descripcion, 1, 15), --DESCRIPCION DE MONEDA
        '1756' = pf_tipo,                          --TIPO PRODUCTO
        '1751' = substring(tr_descripcion, 1, 35), --TIPO DE RANGO
        '1759' = sp_tipo_rango,                    --TIPO RANGO
        '1383' = sp_grupo_rango                    --GRUPO DE RANGO
      from   pe_servicio_per,
             pe_pro_final,
             pe_servicio_dis,
             cobis..cl_catalogo,
             cobis..cl_pro_moneda,
             cobis..cl_moneda,
             pe_tipo_rango
      where  pf_pro_final    = sp_pro_final
         and sd_servicio_dis = sp_servicio_dis
         and pm_moneda       = pf_moneda
         and pm_producto     = pf_producto
         and sp_rubro        = codigo
         and tabla           = (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'pe_rubro')
         and mo_moneda       = pf_moneda
         and tr_tipo_rango   = sp_tipo_rango
         and pf_filial       = @i_filial
         and pf_sucursal     = @i_sucursal
         and sp_servicio_per > @i_cod_subser
      order  by sp_servicio_per
    end

    set rowcount 0
    return 0
  end
/*
/**QUERY**/
/*Consulta para actualizar un registro especifico */
if @i_operacion = 'Q'
   begin
    if @t_trn !=4014
        begin
          /*Error en codigo de transaccion*/
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
                   @i_num   = 351516
                  return 351516
     end
    select sp_servicio_per,
           sp_mercado,
           substring(pf_descripcion,1,35),
           sp_servicio_dis,
           substring(vs_descripcion,1,35),
           sp_rubro,
           sp_producto,
           sp_moneda,
           sp_tipo,
           sp_tipo_rango,
        sp_grupo_rango
    from pe_servicio_per,pe_var_servicio,pe_pro_final
    where sp_producto = @i_producto and sp_servicio_dis = @i_cod_subser
          and sp_rubro = @i_cod_detalle
    order by sp_servicio_per
   if @@rowcount =0
          begin
          /*no existe servicio personalizado solicitado*/
            exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
            @i_num   = 351515
          return 351515
          end
return 0
end */

go 
