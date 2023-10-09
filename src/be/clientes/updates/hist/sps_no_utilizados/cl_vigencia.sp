/************************************************************************/
/*  Archivo:            cl_vigencia.sp                                  */
/*  Stored procedure:   sp_verifica_vigencia                            */
/*  Base de datos:      cobis                                           */
/*  Producto:           MIS - Clientes                                  */
/*  Disenado por:       Raul Altamirano                                 */
/*  Fecha de escritura: 30-Mar-2010                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa implementa la busqueda de operaciones de plazo fijo   */
/*  de un cliente para la trasaccion 701 de caja                        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA         AUTOR             RAZON                           */
/*   30/Mar/10   Raul Altamirano         Emision Inicial                */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
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
           where  name = 'sp_verifica_vigencia')
  drop proc sp_verifica_vigencia
go

create proc sp_verifica_vigencia
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name       varchar(32),
    @w_tabla         varchar(64),
    @w_plazo         smallint,
    @w_fecha_proceso datetime,
    @w_today         datetime,
    @w_existe_error  bit,
    @w_deserror      varchar(255)

  select
    @w_sp_name = 'sp_verifica_vigencia'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  declare grupo_infor cursor for
    select
      vi_tabla,
      vi_plazo
    from   cobis..ad_vigencia

  /* Abrir el cursor para productos del cliente */
  open grupo_infor

  /*Ubicar el primer registro para el cursor*/
  fetch grupo_infor into @w_tabla, @w_plazo

  if @@fetch_status = -2
  begin
    select
      @w_deserror = 'Cursor grupo_infor no puede ser leido '
    select
      @w_deserror = @w_deserror + 'proceso: cobis..' + @w_sp_name

    insert into cl_error_log
                (er_fecha_proc,er_usuario,er_descripcion)
    values      (@w_today,'op_verivig',@w_deserror)

    /* Cerrar y liberar cursor */
    close grupo_infor
    deallocate grupo_infor

    return 201157
  end

  /*Barrer los registros para las operaciones del cliente */
  while @@fetch_status = 0
  begin
    select
      @w_existe_error = 0

    if @w_tabla = 'cl_ente'
    begin
      update cl_ente
      set    c_vigencia = 'N'
      where  datediff(dd,
                      en_fecha_mod,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ente
      set    c_vigencia = 'S'
      where  datediff(dd,
                      en_fecha_mod,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ente
      set    c_vigencia = 'N'
      where  en_fecha_mod is null
         and datediff(dd,
                      en_fecha_crea,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ente
      set    c_vigencia = 'S'
      where  en_fecha_mod is null
         and datediff(dd,
                      en_fecha_crea,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_direccion'
    begin
      update cl_direccion
      set    di_vigencia = 'N'
      where  datediff(dd,
                      di_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_direccion
      set    di_vigencia = 'S'
      where  datediff(dd,
                      di_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_direccion
      set    di_vigencia = 'N'
      where  di_fecha_modificacion is null
         and datediff(dd,
                      di_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_direccion
      set    di_vigencia = 'S'
      where  di_fecha_modificacion is null
         and datediff(dd,
                      di_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_trabajo'
    begin
      update cl_trabajo
      set    tr_vigencia = 'N'
      where  datediff(dd,
                      tr_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_trabajo
      set    tr_vigencia = 'S'
      where  datediff(dd,
                      tr_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_trabajo
      set    tr_vigencia = 'N'
      where  tr_fecha_modificacion is null
         and datediff(dd,
                      tr_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_trabajo
      set    tr_vigencia = 'S'
      where  tr_fecha_modificacion is null
         and datediff(dd,
                      tr_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_propiedad'
    begin
      update cl_propiedad
      set    pr_vigencia = 'N'
      where  datediff(dd,
                      pr_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_propiedad
      set    pr_vigencia = 'S'
      where  datediff(dd,
                      pr_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_propiedad
      set    pr_vigencia = 'N'
      where  pr_fecha_modificacion is null
         and datediff(dd,
                      pr_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_propiedad
      set    pr_vigencia = 'S'
      where  pr_fecha_modificacion is null
         and datediff(dd,
                      pr_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_referencia'
    begin
      update cl_referencia
      set    re_vigencia = 'N'
      where  datediff(dd,
                      re_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_referencia
      set    re_vigencia = 'S'
      where  datediff(dd,
                      re_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_referencia
      set    re_vigencia = 'N'
      where  re_fecha_modificacion is null
         and datediff(dd,
                      re_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_referencia
      set    re_vigencia = 'S'
      where  re_fecha_modificacion is null
         and datediff(dd,
                      re_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_ref_personal'
    begin
      update cl_ref_personal
      set    rp_vigencia = 'N'
      where  datediff(dd,
                      rp_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ref_personal
      set    rp_vigencia = 'S'
      where  datediff(dd,
                      rp_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ref_personal
      set    rp_vigencia = 'N'
      where  rp_fecha_modificacion is null
         and datediff(dd,
                      rp_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_ref_personal
      set    rp_vigencia = 'S'
      where  rp_fecha_modificacion is null
         and datediff(dd,
                      rp_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_relacion_inter'
    begin
      update cl_relacion_inter
      set    ri_vigencia = 'N'
      where  datediff(dd,
                      ri_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_relacion_inter
      set    ri_vigencia = 'S'
      where  datediff(dd,
                      ri_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_relacion_inter
      set    ri_vigencia = 'N'
      where  ri_fecha_modificacion is null
         and datediff(dd,
                      ri_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_relacion_inter
      set    ri_vigencia = 'S'
      where  ri_fecha_modificacion is null
         and datediff(dd,
                      ri_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_hijos'
    begin
      update cl_hijos
      set    hi_vigencia = 'N'
      where  datediff(dd,
                      hi_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_hijos
      set    hi_vigencia = 'S'
      where  datediff(dd,
                      hi_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_hijos
      set    hi_vigencia = 'N'
      where  hi_fecha_modificacion is null
         and datediff(dd,
                      hi_fecha_creacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_hijos
      set    hi_vigencia = 'S'
      where  hi_fecha_modificacion is null
         and datediff(dd,
                      hi_fecha_creacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else if @w_tabla = 'cl_origen_fondos'
    begin
      update cl_origen_fondos
      set    of_vigencia = 'N'
      where  datediff(dd,
                      of_fecha_modificacion,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_origen_fondos
      set    of_vigencia = 'S'
      where  datediff(dd,
                      of_fecha_modificacion,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_origen_fondos
      set    of_vigencia = 'N'
      where  of_fecha_modificacion is null
         and datediff(dd,
                      of_fecha_registro,
                      @w_fecha_proceso) > @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1

      update cl_origen_fondos
      set    of_vigencia = 'S'
      where  of_fecha_modificacion is null
         and datediff(dd,
                      of_fecha_registro,
                      @w_fecha_proceso) <= @w_plazo

      if @@error <> 0
        select
          @w_existe_error = 1
    end
    else
    begin
      select
        @w_deserror = 'Error no existe programacion para tabla: ' + @w_tabla
                      + ' para grupos de informacion de cliente - '
      select
        @w_deserror = @w_deserror + 'proceso: cobis..' + @w_sp_name

      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (@w_today,'op_verivig',@w_deserror)

      goto SIGUIENTE_REG
    end

    if @w_existe_error = 1
    begin
      select
        @w_deserror = 'Error al actualizar tabla: ' + @w_tabla +
                             ' para grupos de informacion de cliente - '
      select
        @w_deserror = @w_deserror + 'proceso: cobis..' + @w_sp_name

      insert into cl_error_log
                  (er_fecha_proc,er_usuario,er_descripcion)
      values      (@w_today,'op_actvig',@w_deserror)
    end

    SIGUIENTE_REG:

    --Lee siguiente registro
    fetch grupo_infor into @w_tabla, @w_plazo
  end

  /* Cerrar y liberar cursor */
  close grupo_infor
  deallocate grupo_infor

  return 0

go

