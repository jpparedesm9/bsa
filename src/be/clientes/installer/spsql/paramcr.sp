/************************************************************************/
/*      Archivo:                paramcr.sp                              */
/*      Stored procedure:       sp_parametros_cr                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               MIS                                     */
/*      Disenado por:           Doris Lozano                            */
/*      Fecha de escritura:     12-Jun-07                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones del store procedure     */
/*      Insercion de parametrizacion centrales de riesgo                */
/*      Modificacion de parametrizacion centrales de riesgo             */
/*      Busqueda de parametrizacion centrales de riesgo                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      12/06/07       D. Lozano        Emision Inicial                 */
/*  04/May/2016        T. Baidal        Migracion a CEN                 */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_parametros_cr')
    drop proc sp_parametros_cr
go

create proc sp_parametros_cr
(
  @s_ssn          int = null,
  @s_user         login = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = 'N',
  @i_tipo         varchar(10) = null,
  @i_tipo_cons    varchar(10) = null,
  @i_motivo       varchar(10) = null,
  @i_estado       char(1) = null
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(32),
    @w_tabla_tipo   varchar(30),
    @w_tabla_motivo varchar(30)

  select
    @w_sp_name = 'sp_parametros_cr'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1018
  begin
    if @i_operacion = 'S'
    begin
      select
        @i_tipo = pw_tipo
      from   cl_parametros_ws
      where  pw_estado = 'V'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101077
        return 1
      end
    end

    if @i_tipo = '1'
      select
        @w_tabla_tipo = 'cl_tipo_consulta_cifin',
        @w_tabla_motivo = 'cl_motivo_consulta_cifin'
    else
      select
        @w_tabla_tipo = 'cl_tipo_consulta_datacredito',
        @w_tabla_motivo = 'cl_motivo_consulta_datacredito'

    select
      'Tipo Central' = pw_tipo,
      'Tipo Cons' = pw_tipo_cons,
      'Descripcion Tipo cons' = (select
                                   A.valor
                                 from   cobis..cl_catalogo A,
                                        cobis..cl_tabla B
                                 where  B.codigo = A.tabla
                                    and B.tabla  = @w_tabla_tipo
                                    and A.codigo = L.pw_tipo_cons),
      'Motivo Cons ' = pw_motivo,
      'Descripcion Motivo cons' = (select
                                     A.valor
                                   from   cobis..cl_catalogo A,
                                          cobis..cl_tabla B
                                   where  B.codigo = A.tabla
                                      and B.tabla  = @w_tabla_motivo
                                      and A.codigo = L.pw_motivo),
      'Estado ' = pw_estado,
      'Descripcion Estado' = (select
                                A.valor
                              from   cobis..cl_catalogo A,
                                     cobis..cl_tabla B
                              where  B.codigo = A.tabla
                                 and B.tabla  = 'cl_estado_ser'
                                 and A.codigo = L.pw_estado)
    from   cl_parametros_ws L
    where  pw_tipo   = @i_tipo
       and pw_estado = 'V'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077
      return 1
    end
    return 0
  end

  if @t_trn in (1016, 1017)
  begin
    if exists (select
                 1
               from   cl_parametros_ws
               where  pw_tipo   = @i_tipo
                  and pw_estado = 'V')
    begin
      if @i_estado = 'V'
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151046
        return 1
      end
    end

    if exists (select
                 1
               from   cl_parametros_ws
               where  pw_tipo      = @i_tipo
                  and pw_tipo_cons = @i_tipo_cons
                  and pw_motivo    = @i_motivo)
    begin
      update cl_parametros_ws
      set    pw_estado = @i_estado
      where  pw_tipo      = @i_tipo
         and pw_tipo_cons = @i_tipo_cons
         and pw_motivo    = @i_motivo

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 155024
        return 1
      end
    end
    else
    begin
      insert into cl_parametros_ws
      values      (@i_tipo,@i_tipo_cons,@i_motivo,@i_estado)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 803004
        return 1
      end
    end

  end
  else
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  return 0

go

