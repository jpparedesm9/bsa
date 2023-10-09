/************************************************************************/
/*    Archivo            :     caracobs.sp                              */
/*    Stored procedure   :     sp_caract_obsequio                       */
/*    Base de datos      :     cobis                                    */
/*    Producto           :     Clientes                                 */
/*    Disenado por       :     Santiago Alban P                         */
/*    Fecha de escritura :     01/10/2008                               */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/*    Este programa procesa las transacciones del stored procedure      */
/*    Insercion, Borrado, Modificacion de las caracterisiticas          */
/*    que cumplen para entregar obsequios por cliente                   */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*    FECHA           AUTOR        RAZON                                */
/*    01/10/2008      FSAP         EmisionInicial                       */
/*    May/02/2016     DFu          Migracion CEN                        */
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
           where  name = 'sp_caract_obsequio')
  drop proc sp_caract_obsequio
go

create proc sp_caract_obsequio
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_cod_caract   smallint = null,
  @i_obsequio     smallint = null,
  @i_estado       char(1) = null,
  @i_modo         int = null,
  @i_tipo         char(1) = null
)
as
  declare
    @w_sp_name   varchar(32),
    @w_return    int,
    @w_cod_carct smallint,
    @w_obsequio  smallint,
    @w_estado    char(1)

  select
    @w_sp_name = 'sp_caract_obsequio'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    --   if @t_trn = 1195
    if @t_trn = 1012
    begin
      if exists (select
                   1
                 from   cl_obsequio_caract
                 where  oc_cod_caract = @i_cod_caract
                    and oc_obsequio   = @i_obsequio)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
        /* 'registro ya existe'*/
        return 1
      end

      /* insertar los datos */
      insert into cl_obsequio_caract
                  (oc_cod_caract,oc_obsequio,oc_estado)
      values      (@i_cod_caract,@i_obsequio,@i_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103084
        --/* 'Error en creacion de otros ingresos'*/
        return 1
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
  end

  if @i_operacion = 'U'
  begin
    --   if @t_trn = 1195
    if @t_trn = 1012
    begin
      begin tran

      update cl_obsequio_caract
      set    oc_estado = @i_estado
      where  oc_obsequio   = @i_obsequio
         and oc_cod_caract = @i_cod_caract

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103084
        /* 'Error en creacion de otros ingresos'*/
        return 1
      end
      commit tran
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
  end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    --   if @t_trn = 1193
    if @t_trn = 1012
    begin
      delete cl_obsequio_caract
      where  oc_cod_caract = @i_cod_caract

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101191,
          @i_msg  = 'Error al eliminar registro de otros ingresos'
        /* 'Error al eliminar otros ingresos'*/
        return 101191
      end
    end

  end
  /** Search **/

  if @i_operacion = 'S'
  begin
    if @t_trn = 1013
    begin
      if @i_modo = 0
      begin
        select
          'Codigo' = oc_obsequio,
          'Obsequio' = (select
                          valor
                        from   cobis..cl_catalogo a,
                               cl_tabla b
                        where  a.tabla  = b.codigo
                           and b.tabla  = 'cl_obsequios'
                           and a.codigo = c.oc_obsequio),
          'Cod.C' = oc_cod_caract,
          'Caracteristica' = cc_descripcion,
          'Estado' = oc_estado
        from   cl_obsequio_caract c,
               cr_caract_cli_prod d
        where  c.oc_obsequio   = @i_obsequio
           and c.oc_cod_caract = d.cc_cod_caract
        order  by c.oc_cod_caract,
                  c.oc_obsequio

      end
      /*        if @i_modo = 1
       begin 
          select'Codigo Caracteristica' = oc_cod_caract, 
                'Obsequio'              = oc_obsequio,     
                'Estado     '           = oc_estado
          from cl_obsequio_caract, cr_caract_cli_prod
          where oc_cod_caract > @i_cod_caract  
          
       end*/

      if @i_modo = 3 --buscar codigo y caracter del obsequio
      begin
        if @i_tipo = 'A'
        begin
          select
            'Codigo Caracteristica' = cc_cod_caract,
            'Descripcion' = cc_descripcion
          from   cr_caract_cli_prod
        end
        if @i_tipo = 'B'
        begin
          select -- 'Codigo Caracteristica'  = cc_cod_caract, 
            'Descripcion' = cc_descripcion
          from   cr_caract_cli_prod
          where  cc_cod_caract = @i_cod_caract
        end
      end--fin modo 3

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101191
        /* 'No existe dato solicitado'*/
        return 1
      end
    end
  end
  return 0

go

