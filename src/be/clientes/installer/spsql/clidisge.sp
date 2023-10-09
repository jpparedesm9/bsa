/************************************************************************/
/*  Archivo:            clidisge.sp                                     */
/*  Stored procedure:   sp_dgeografica                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           MIS                                             */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*      Dado el pais coloca la informacion del numero de clientes para  */
/*      cada region natural que se haya definido                        */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*  FECHA           AUTOR           RAZON                               */
/*  19/Feb/2000     D Villafuerte   Emision Inicial                     */
/*  28/Mar/2001     J Anaguano      Consulta: Por Zona de Ciudad        */
/*  18/Jul/2003     D Duran         Contador registros para funcion     */
/*                                  Actualizar_Reg_Proc                 */
/*  14/Ago/2003     E.Laguna        Ajuste generar todos los tdirec     */
/*  31/May/2004     E.Laguna        Tunning                             */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_dgeografica')
  drop proc sp_dgeografica
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_dgeografica
  @t_show_version bit = 0,
  @o_registros    int = 0 output
as
  declare
    @w_sp_name       varchar(32),
    @w_ciudad        int,
    @w_max_ente      int,
    @w_di_ente       int,
    @w_ciudad_ant    int,
    @w_di_tipo       char(1),
    @w_di_parroquia  smallint,
    @w_di_ciudad     int,
    @w_pv_pais       smallint,
    @w_pv_region_nat char(2),
    @w_pv_region_ope char(3),
    @w_pv_provincia  smallint,
    @w_ci_ciudad     int,
    @w_pq_parroquia  smallint,
    @w_parametro     varchar(10),
    @w_di_zona       catalogo,
    @w_pq_zona       char(3),
    @w_total         int

  select
    @w_sp_name = 'sp_dgeografica'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  create table #cl_tot_ciudad_tmp
  (
    ciudad int not null,
    total  int not null
  )

  insert into #cl_tot_ciudad_tmp
    select distinct
      (di_ciudad),count(0)
    from   cobis..cl_direccion
    group  by di_ciudad

  create index #cl_tot_ciudad_tmp_Key
    on #cl_tot_ciudad_tmp (ciudad)

  -- Cursor sobre direcciones de los clientes, de tipo Domiciliaria
  declare clidisgeo cursor for
    select
      ciudad,
      total
    from   #cl_tot_ciudad_tmp
    order  by ciudad

  -- Abre cursor
  open clidisgeo

  -- Ubica primer registro del cursor
  fetch clidisgeo into @w_ciudad, @w_total

  -- Control del estado del cursor
  if @@fetch_status = -2
  begin
    close clidisgeo
    deallocate clidisgeo
    exec cobis..sp_cerror
      @i_num = 201157
    return 201157
  end
  else if @@fetch_status = -1
  begin
    close clidisgeo
    deallocate clidisgeo
    return 0
  end

  -- Inicializa numero de ente de trabajo
  select
    @w_ciudad_ant = -1

  -- Proceso de informacion
  while @@fetch_status = 0
  begin
    -- Procesa unicamente una direccion domiciliaria del cliente
    if @w_ciudad = @w_ciudad_ant
      goto LEER
    -- Determina datos de la distribucion geografica
    select
      @w_pv_pais = pv_pais,
      @w_pv_region_nat = pv_region_nat,
      @w_pv_region_ope = pv_region_ope,
      @w_pv_provincia = pv_provincia,
      @w_ci_ciudad = ci_ciudad
    from   cobis..cl_provincia,
           cobis..cl_ciudad
    where  ci_ciudad    = @w_ciudad
       and ci_provincia = pv_provincia
    if @@rowcount = 0
      goto LEER

    -- Registra cliente por region natural y pais
    insert into cobis..cl_dgeografica
                (dg_pais,dg_regnat,dg_regope,dg_provincia,dg_parroquia,
                 dg_ciudad,dg_zona,dg_numero)
    values      (@w_pv_pais,@w_pv_region_nat,@w_pv_region_ope,@w_pv_provincia,0,
                 @w_ciudad,@w_pq_zona,@w_total)
    if @@error <> 0
      goto LEER

    LEER:
    -- Almacena ultimo numero de ente
    select
      @w_ciudad_ant = @w_ciudad

    -- Ubica siguiente registro del cursor
    fetch clidisgeo into @w_ciudad, @w_total

    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close clidisgeo
      deallocate clidisgeo
      exec cobis..sp_cerror
        @i_num = 201157
      return 201157
    end
  end

  -- Cierra cursor y libera memoria
  close clidisgeo
  deallocate clidisgeo

  select
    @o_registros = count(*)
  from   cl_dgeografica
  select
    @o_registros

  return 0

go

