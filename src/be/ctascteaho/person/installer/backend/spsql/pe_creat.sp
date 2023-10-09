/************************************************************************/
/*      Archivo               : pe_creat.sp                            */
/*      Store Procedure       : sp_crea_temp                        */
/*      Base de Datos         : cob_remesas                 */
/*      Producto              : Personalizacion                       */
/*      Disenado por          :                             */
/*      Fecha de escritura    : 04 dic 1994                 */
/************************************************************************/
/*                           IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                   */
/*       Este programa crea tabla temporal de la registros de           */
/*       Personalizacion                                                */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*        FECHA             AUTOR                 RAZON                 */
/*      02/Mayo/2016   Roxana Sánchez    Migración a CEN                */
/************************************************************************/
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'pint')
  drop table tempdb..pint
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'scon')
  drop table tempdb..scon
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'soca')
  drop table tempdb..soca
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'ufon')
  drop table tempdb..ufon
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'cdev')
  drop table tempdb..cdev
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'rvoc')
  drop table tempdb..rvoc
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'cech')
  drop table tempdb..cech
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'secu')
  drop table tempdb..secu
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'anch')
  drop table tempdb..anch
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'poch')
  drop table tempdb..poch
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'eect')
  drop table tempdb..eect
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'ccta')
  drop table tempdb..ccta
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'mcta')
  drop table tempdb..mcta
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'mora')
  drop table tempdb..mora
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'ren')
  drop table tempdb..ren
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'crem')
  drop table tempdb..crem
go

if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'crem4')
  drop table tempdb..crem4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'pint4')
  drop table tempdb..pint4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'cdev4')
  drop table tempdb..cdev4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'secu4')
  drop table tempdb..secu4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'eect4')
  drop table tempdb..eect4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'ccta4')
  drop table tempdb..ccta4
if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'mcta4')
  drop table tempdb..mcta4
go

use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_crea_temp')
  drop proc sp_crea_temp
go

create proc sp_crea_temp
(
  @i_serdisponible char(4),
  @i_prod_cobis    tinyint,
  @i_batch         char(1) = 'N',
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_show_version  bit = 0
)
as
  declare
    @w_fecha          smalldatetime,
    @w_sp_name        varchar(32),
    @w_prod_cobis_paq tinyint

  if exists (select
               *
             from   tempdb..sysobjects
             where  name = 'auxiliar')
    drop table tempdb..auxiliar

  if exists (select
               *
             from   tempdb..sysobjects
             where  name = '#secuencial')
    drop table #secuencial

  select
    @w_sp_name = 'sp_crea_temp'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Busca fecha de proceso */
  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  /* Busco producto cobis de paquete */
  select
    @w_prod_cobis_paq = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PCPP'
     and pa_producto = 'REM'

  if @@rowcount = 0
  begin
    if @i_batch != 'S'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077

      drop table tempdb..auxiliar
      return 101077
    end
    else
      print 'ERROR: NO EXISTE PARAMETRO PRODUCTO COBIS DE PAQUETE DE PRODUCTOS'
  end

  print ' Servicio dis ' + @i_serdisponible

  /* Selecciona registros de personalizacion */

  select
    tipo_ente = me_tipo_ente,
    pro_bancario = me_pro_bancario,
    filial = pf_filial,
    sucursal = pf_sucursal,
    producto = pf_producto,
    moneda = pf_moneda,
    servicio_dis = sd_nemonico,
    rubro = sp_rubro,
    tipo_atributo = tr_tipo_atributo,
    rango_desde = ra_desde,
    rango_hasta = ra_hasta,
    valor = co_val_medio,
    secuencial = co_secuencial,
    categoria = co_categoria,
    rango = co_rango
  into   tempdb..auxiliar
  from   pe_servicio_dis,
         pe_servicio_per,
         pe_pro_final,
         pe_costo,
         pe_mercado,
         pe_tipo_rango,
         pe_rango
  where  sd_nemonico       = @i_serdisponible
     and sp_servicio_dis   = sd_servicio_dis
     and pf_pro_final      = sp_pro_final
     and pf_producto in (@i_prod_cobis, @w_prod_cobis_paq)
     and co_servicio_per   = sp_servicio_per
     and co_rango          = ra_rango
     and co_grupo_rango    = ra_grupo_rango
     and co_tipo_rango     = ra_tipo_rango
     and me_mercado        = pf_mercado
     and tr_tipo_rango     = sp_tipo_rango
     and sp_tipo_rango     = ra_tipo_rango
     and sp_grupo_rango    = ra_grupo_rango
     and me_estado         = 'V'
     and sd_estado         = 'V'
     and co_fecha_vigencia <= @w_fecha

  --if @@rowcount = 0 and @i_batch != 'S'
  if @@rowcount = 0
  begin
    if @i_batch != 'S'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351048
      drop table tempdb..auxiliar
      return 351048
    end
  --   else
  --      return 0
  end

  /*** Generamos los secuenciales maximos de cada grupo    ****/
  select
    sec= max(secuencial)
  into   #secuencial
  from   tempdb..auxiliar
  group  by tipo_ente,
            pro_bancario,
            filial,
            sucursal,
            producto,
            moneda,
            servicio_dis,
            rubro,
            tipo_atributo,
            rango_desde,
            rango_hasta,
            categoria,
            rango
  if @@rowcount = 0
    print ' No hay datos ' + @i_serdisponible

  /* Genera tabla temporal dependiente del servicio disponible */
  if @i_prod_cobis = 3
  begin
    if @i_serdisponible = 'PINT'
      select
        *
      into   tempdb..pint
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/

    else if @i_serdisponible = 'SCON'
      select
        *
      into   tempdb..scon
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'SOCA'
      select
        *
      into   tempdb..soca
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'UFON'
      select
        *
      into   tempdb..ufon
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CPEX'
      select
        *
      into   tempdb..cpex
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CDEV'
      select
        *
      into   tempdb..cdev
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'RVOC'
      select
        *
      into   tempdb..rvoc
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CECH'
      select
        *
      into   tempdb..cech
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'SECU'
      select
        *
      into   tempdb..secu
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'ANCH'
      select
        *
      into   tempdb..anch
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'POCH'
      select
        *
      into   tempdb..poch
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'EECT'
      select
        *
      into   tempdb..eect
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CCTA'
      select
        *
      into   tempdb..ccta
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'MCTA'
      select
        *
      into   tempdb..mcta
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'MORA'
      select
        *
      into   tempdb..mora
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CREM'
      select
        *
      into   tempdb..crem
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

  /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
         moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                categoria
         having secuencial = max(secuencial)
     **/
  end

  if @i_prod_cobis = 4
  begin
    if @i_serdisponible = 'PINT'
      select
        *
      into   tempdb..pint4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'SCON'
      select
        *
      into   tempdb..scon4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'SOCA'
      select
        *
      into   tempdb..soca4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'UFON'
      select
        *
      into   tempdb..ufon4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CPEX'
      select
        *
      into   tempdb..cpex4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CDEV'
      select
        *
      into   tempdb..cdev4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'RVOC'
      select
        *
      into   tempdb..rvoc4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CECH'
      select
        *
      into   tempdb..cech4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'SECU'
      select
        *
      into   tempdb..secu4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'ANCH'
      select
        *
      into   tempdb..anch4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'POCH'
      select
        *
      into   tempdb..poch4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'EECT'
      select
        *
      into   tempdb..eect4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CCTA'
      select
        *
      into   tempdb..ccta4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'MCTA'
      select
        *
      into   tempdb..mcta4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'MORA'
      select
        *
      into   tempdb..mora4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CREM'
      select
        *
      into   tempdb..crem4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'CSLM'
      select
        *
      into   tempdb..cslm4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

    /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
           moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                  categoria
           having secuencial = max(secuencial)
       **/
    else if @i_serdisponible = 'INAC'
      select
        *
      into   tempdb..inac4
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

  /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
         moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                categoria
         having secuencial = max(secuencial)
     **/

  end

  if @i_prod_cobis = 16
  begin
    if @i_serdisponible = 'REN '
      select
        *
      into   tempdb..ren
      from   tempdb..auxiliar
      where  secuencial in
             (select
                sec
              from   #secuencial)

  /** group  by tipo_ente,pro_bancario,filial,sucursal,producto,
         moneda,servicio_dis,rubro,tipo_atributo,rango_desde,rango_hasta,
                categoria
         having secuencial = max(secuencial)
     **/
  end

  drop table tempdb..auxiliar
  drop table #secuencial

go 
