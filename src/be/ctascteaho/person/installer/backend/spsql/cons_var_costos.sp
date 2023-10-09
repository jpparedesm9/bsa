/****************************************************************************/
/*     Archivo:     convarco.sp                                             */
/*     Stored procedure: sp_cons_var_costos                                 */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:  Carmen Milan                                          */
/*     Fecha de escritura: 06-Junio-2002                                    */
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
/*     Consulta historica de variacion de costos o tasas                    */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*       06-Jun-2002    Pedro Marroquin Emision Inicial                     */
/*       16-Feb-2005    D. Villagomez   Campo usuario                       */
/*     02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
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
           where  name = 'sp_cons_var_costos')
  drop proc sp_cons_var_costos
go

create proc sp_cons_var_costos
(
  @s_ssn           int,
  @s_srv           varchar(30)=null,
  @s_lsrv          varchar(30)=null,
  @s_user          varchar(30)=null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char (1),
  @s_ofi           smallint,
  @s_rol           smallint =1,
  @s_org_err       char(1)=null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1)='N',
  @t_file          varchar(14)=null,
  @t_from          varchar(32)=null,
  @t_rty           char(1)='N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_fotmato_fecha smallint= null,
  @i_modo          smallint,
  @i_servicio_disp smallint,
  @i_pro_final     smallint,
  @i_rubro         catalogo,--  Varchar
  @i_tipo_rango    tinyint,
  @i_desde         money,
  @i_secuencial    int
)
as
  declare
    @w_sp_name         varchar(32),
    @w_return          int,
    @w_servicio_per    int,
    @w_tipo_rango      tinyint,
    @w_grupo_rango     smallint,
    @w_desc_tipo_rango descripcion

begin
  select
    @w_sp_name = 'sp_cons_var_costos'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn != 4086
  begin
    /*Error en codigo de transaccion*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 1
  end

  /*=============[ Determino servicio personalizable ]============*/
  select
    @w_servicio_per = sp_servicio_per,
    @w_tipo_rango = sp_tipo_rango,
    @w_grupo_rango = sp_grupo_rango
  from   pe_servicio_per
  where  sp_servicio_dis = @i_servicio_disp
     and sp_rubro        = @i_rubro
     and sp_pro_final    = @i_pro_final

  if @@rowcount = 0
  begin /*No existe servicio personalizable*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351540
  end

  select
    @w_desc_tipo_rango = tr_descripcion
  from   pe_tipo_rango
  where  tr_tipo_rango = @w_tipo_rango

  set rowcount 15

  if @i_modo = 0
  begin
    select
      '1892'= convert(varchar(10),co_fecha_vigencia, @i_fotmato_fecha),
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1478' = convert(money,co_minimo),
      '1893' = convert(money,co_val_medio),
      '1471' = convert(money,co_maximo),
      '1945' = co_tipo_rango,
      '1894' = @w_desc_tipo_rango,
      '1703' = co_secuencial,
      '1796' = co_usuario,
      '1895' = convert(varchar(10), co_fecha_vigencia, @i_fotmato_fecha)
    from   pe_costo a,
           pe_rango c
    where  co_servicio_per = @w_servicio_per
       and co_tipo_rango   = @w_tipo_rango
       and co_grupo_rango  = @w_grupo_rango
       and co_rango        = ra_rango
       and ra_tipo_rango   = @w_tipo_rango
       and ra_grupo_rango  = @w_grupo_rango
       and ra_estado       = 'V'
       and co_secuencial   = (select
                                max (b.co_secuencial)
                              from   pe_costo b
                              where  b.co_servicio_per   = @w_servicio_per
                                 and b.co_categoria      = a.co_categoria
                                 and b.co_tipo_rango     = @w_tipo_rango
                                 and b.co_rango          = c.ra_rango
                                 and b.co_grupo_rango    = @w_grupo_rango
                                 and b.co_fecha_vigencia = a.co_fecha_vigencia)
    order  by co_tipo_rango,
              ra_desde,
              co_secuencial
  end
  else
  begin
    select
      '1892'= convert(varchar(10), co_fecha_vigencia, @i_fotmato_fecha),
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1478' = convert(money,co_minimo),
      '1893' = convert(money,co_val_medio),
      '1471' = convert(money,co_maximo),
      '1945' = co_tipo_rango,
      '1894' = @w_desc_tipo_rango,
      '1703' = co_secuencial,
      '1796' = co_usuario,
      '1895' = convert(varchar(10), co_fecha_vigencia, @i_fotmato_fecha)
    from   pe_costo a,
           pe_rango c
    where  co_servicio_per = @w_servicio_per
       and co_tipo_rango   = @w_tipo_rango
       and co_grupo_rango  = @w_grupo_rango
       and co_rango        = ra_rango
       and ra_tipo_rango   = @w_tipo_rango
       and ra_grupo_rango  = @w_grupo_rango
       and ra_estado       = 'V'
       and co_secuencial   = (select
                                max (b.co_secuencial)
                              from   pe_costo b
                              where  b.co_servicio_per   = @w_servicio_per
                                 and b.co_categoria      = a.co_categoria
                                 and b.co_tipo_rango     = @w_tipo_rango
                                 and b.co_rango          = c.ra_rango
                                 and b.co_grupo_rango    = @w_grupo_rango
                                 and b.co_fecha_vigencia = a.co_fecha_vigencia)
       and ((co_tipo_rango > @i_tipo_rango)
             or (co_tipo_rango   = @i_tipo_rango
                 and ra_desde        > @i_desde)
             or (co_tipo_rango   = @i_tipo_rango
                 and ra_desde        = @i_desde
                 and co_secuencial   > @i_secuencial))
    order  by co_tipo_rango,
              ra_desde,
              co_secuencial

  end

  set rowcount 0
  return 0
end

go 
