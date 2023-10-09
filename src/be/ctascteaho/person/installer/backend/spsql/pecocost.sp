/****************************************************************************/
/*     Archivo:            pe_consulta_costos.sp                            */
/*     Stored procedure:   sp_con_costot_linea                              */
/*     Base de datos:      cob_remesas                                      */
/*     Producto:           Sub-Modulo de Personalizacion                    */
/*     Disenado por:       Julio Navarrete/Javier Bucheli                   */
/*     Fecha de escritura: 21-Ene-1997                                      */
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
/*     Esta transaccion permite consultar los costos asignados a un         */
/*     Producto Bancario especifico para una sucursal dada                  */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     21-01-97         J. Bucheli      Emision Inicial                     */
/*     Nov 07 2002      Jorge Galeano   Cambia texto medio por base         */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*     02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*     18/Julio/2016    Jorge Baque     Se corrige consulta 1 de registros  */
/*	                                    duplicados                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_con_costot_linea')
  drop proc sp_con_costot_linea

go
create proc sp_con_costot_linea
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,
  @s_rol           smallint,
  @s_org_err       char(1)= null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_pro_banc      smallint,
  @i_sector        varchar(10),
  @i_filial        tinyint,
  @i_suc           smallint,
  @i_pro_cobis     tinyint,
  @i_mon           tinyint,
  @i_categoria     varchar(3),
  @i_ser_disp      smallint = null,
  @i_rubro         varchar(10) = null,
  @i_sec           int = 0,
  @i_formato_fecha int = 101
)
as
  declare
    @w_sp_name   varchar(32),
    @w_mercado   smallint,
    @w_pro_final smallint

  select
    @w_sp_name = 'sp_con_costot_linea'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Determinacion del Mercado

  select
    @w_mercado = me_mercado
  from   cob_remesas..pe_mercado
  where  me_pro_bancario = @i_pro_banc
     and me_tipo_ente    = @i_sector

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351511
    return 351511
  end

  -- Determinacion del produto final

  select
    @w_pro_final = pf_pro_final
  from   cob_remesas..pe_pro_final
  where  pf_filial   = @i_filial
     and pf_sucursal = @i_suc
     and pf_mercado  = @w_mercado
     and pf_producto = @i_pro_cobis
     and pf_moneda   = @i_mon
     and pf_tipo     = 'R'

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351511
    return 351511
  end

  -- Consulta General para todos los servicios disponibles

  if @i_ser_disp is null
     and @i_rubro is null
  begin
    -- Consulta de todos los servicios disponibles para un producto
    -- bancario y suscursal dado

    set rowcount 20
    /* JBA: SE CORRIGE LOS REGISTROS DUPLICADOS 18/Julio/2016*/
    select 
	  '2522' = substring(sd_descripcion, 1, 35),
      '1689' = substring(vs_descripcion, 1, 35),
      '1759' = substring(tr_descripcion, 1, 35),
      '1381' = a.co_grupo_rango,
      '1678' = a.co_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1026' = convert(money, a.co_val_medio),
      '1478' = convert(money, a.co_minimo),
      '1471' = convert(money, a.co_maximo),
      '1355' = convert(char(10), a.co_fecha_vigencia, @i_formato_fecha),
      '1703' = a.co_secuencial
    from cob_remesas..pe_costo a, 
         cob_remesas..pe_servicio_per,
         cob_remesas..pe_tipo_rango,
         cob_remesas..pe_rango,
         cob_remesas..pe_servicio_dis,
         cob_remesas..pe_var_servicio
    where sp_pro_final    = @w_pro_final
	    and sp_servicio_dis   = sd_servicio_dis
         and sd_servicio_dis   = vs_servicio_dis
         and a.co_categoria    = @i_categoria
         and sp_servicio_per   = a.co_servicio_per
         and vs_rubro          = sp_rubro
         and sp_tipo_rango     = tr_tipo_rango
         and sp_tipo_rango     = ra_tipo_rango
         and a.co_grupo_rango  = ra_grupo_rango
         and a.co_rango        = ra_rango
	 and a.co_secuencial in
           (select
              max(b.co_secuencial)
            from   cob_remesas..pe_costo b
            where  a.co_servicio_per = b.co_servicio_per
               and a.co_tipo_rango   = b.co_tipo_rango
               and a.co_grupo_rango  = b.co_grupo_rango
               and a.co_rango        = b.co_rango
               and a.co_categoria    = b.co_categoria)
       and a.co_secuencial  > @i_sec
	   order by a.co_secuencial
    /* FIN JBA 18/Julio/2016*/
    set rowcount 0

  end
  else
  begin
    -- Consulta de un servicio especifico para un producto bancario
    -- y sucursal dada
	set rowcount 20
    select
      '1759' = substring(tr_descripcion, 1, 35),
      '1381' = a.co_grupo_rango,
      '1678' = a.co_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1026' = convert(money, a.co_val_medio),
      '1478' = convert(money, a.co_minimo),
      '1471' = convert(money, a.co_maximo),
      '1355' = convert(char(10), a.co_fecha_vigencia, @i_formato_fecha),
      '1703' = a.co_secuencial
    from   cob_remesas..pe_costo a,
           cob_remesas..pe_servicio_per,
           cob_remesas..pe_tipo_rango,
           cob_remesas..pe_rango
    where  sp_pro_final     = @w_pro_final
       and sp_servicio_dis  = @i_ser_disp
       and sp_rubro         = @i_rubro
       and a.co_categoria   = @i_categoria
       and sp_servicio_per  = a.co_servicio_per
       and sp_tipo_rango    = tr_tipo_rango
       and sp_tipo_rango    = ra_tipo_rango
       and a.co_grupo_rango = ra_grupo_rango
       and a.co_rango       = ra_rango
       and a.co_secuencial in
           (select
              max(b.co_secuencial)
            from   cob_remesas..pe_costo b
            where  a.co_servicio_per = b.co_servicio_per
               and a.co_tipo_rango   = b.co_tipo_rango
               and a.co_grupo_rango  = b.co_grupo_rango
               and a.co_rango        = b.co_rango
               and a.co_categoria    = b.co_categoria)
       and a.co_secuencial  > @i_sec
	   order by a.co_secuencial
	   set rowcount 0
  end
  return 0

go


