/************************************************************************/
/*  Archivo:            ente_pro.sp                                     */
/*  Stored procedure:   sp_se_ente_prod                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 31-Ago-1994                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa implementa la busqueda de clientes (personas          */
/*  y companias) de un producto indicado segun distintos                */
/*  criterios de busqueda:                                              */
/*      codigo de cliente                                               */
/*      apellido                                                        */
/*      cedula o pasaporte                                              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR          RAZON                                    */
/*  31/Ago/94 C. Rodriguez V.  Emision Inicial                          */
/*  04/May/16 T. Baidal        Migracion a CEN                          */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_se_ente_prod')
           drop proc sp_se_ente_prod
go

create proc sp_se_ente_prod
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
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_subtipo      char(1) = null,
  @i_tipo         tinyint = null,
  @i_modo         tinyint = null,
  @i_valor        varchar(32) = '%',
  @i_ente         int = null,
  @i_nombre       descripcion = null,
  @i_p_apellido   varchar(16) = null,
  @i_s_apellido   varchar(16) = null,
  @i_ced_ruc      numero = null,
  @i_pasaporte    numero = null,
  @i_producto     smallint = null,
  @i_oficina      smallint = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_contador int

  /* Captura nombre de Stored Procedure */
  select
    @w_sp_name = 'sp_se_ente_prod'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1242
  begin
    /* Traer los resultados de 20 en 20 */
    set rowcount 20

    /* Si subtipo es P, traer datos de persona */
    if @i_subtipo = 'P'
    begin
      /* Si tipo es 1, traer los datos ordenados por ente */
      if @i_tipo = 1
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_cliente) like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ente

        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_cliente) like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and cl_cliente      > @i_ente
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ente

        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  cl_cliente      = convert(int, @i_valor)
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end

      /* Si tipo es 2, traer los datos ordenados por cedula */
      if @i_tipo = 2
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_ced_ruc) like @i_valor
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ced_ruc
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_ced_ruc) like @i_valor
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and cl_ced_ruc      > @i_ced_ruc
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ced_ruc

        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  cl_ced_ruc      = @i_valor
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end

      /* Si tipo es 3, traer los datos ordenados por pasaporte */
      if @i_tipo = 3
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30),
            'Pasaporte' = p_pasaporte
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_pasaporte is not null
             and p_pasaporte like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by p_pasaporte

        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30),
            'Pasaporte' = p_pasaporte
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_pasaporte is not null
             and p_pasaporte like @i_valor
             and p_pasaporte     > @i_pasaporte
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by p_pasaporte
        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30),
            'Pasaporte' = p_pasaporte
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_pasaporte is not null
             and p_pasaporte     = @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end

      /* Si tipo es 4, traer los datos cuyo primer apellido son como
         un valor dado */
      if @i_tipo = 4
      begin
        if @i_modo = 0
        begin
          select distinct
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_p_apellido like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
        --                         select @w_contador = @@rowcount

        end
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_p_apellido like @i_valor
             and ((p_p_apellido > @i_p_apellido)
                   or (p_p_apellido    = @i_p_apellido
                       and p_s_apellido    > @i_s_apellido)
                   or (p_p_apellido    = @i_p_apellido
                       and p_s_apellido    = @i_s_apellido
                       and en_nombre       >= @i_nombre))
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido'= p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  p_p_apellido    = @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'P'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end
    end
    /* Si subtipo es C, traer datos de compania */
    else
    begin
      /* Si tipo es 1, traer los datos de las companias ordenados por ente */
      if @i_tipo = 1
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_cliente) like @i_valor
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_cliente) like @i_valor
             and cl_cliente      > @i_ente
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)

        else
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  cl_cliente      = convert(int, @i_valor)
             and en_ente         = cl_cliente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end
      /* Si tipo es 2, traer los datos de las companias ordenados por RUC */
      if @i_tipo = 2
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_ced_ruc) like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ced_ruc

        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), cl_ced_ruc) like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and cl_ced_ruc      > @i_ced_ruc
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_ced_ruc
        else
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  cl_ced_ruc      = @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        return 0
      end
      /* Si tipo es 4, traer los datos de las companias de acuerdo
         al nombre */
      if @i_tipo = 4
      begin
        if @i_modo = 0
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre like @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_nombre
        end
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre like @i_valor
             and en_nombre       > @i_nombre
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          order  by en_nombre
        else
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'NIT' = en_ced_ruc,
            'Oficina' = en_oficina,
            'Nombre Oficina' = c.valor,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_cliente,
                 cl_det_producto,
                 cl_tabla t,
                 cl_catalogo c,
                 cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre       = @i_valor
             and cl_cliente      = en_ente
             and cl_det_producto = dp_det_producto
             and en_subtipo      = 'C'
             and dp_producto     = @i_producto
             and (en_oficina      = @i_oficina
                   or @i_oficina is null)
             and t.tabla         = 'cl_oficina'
             and t.codigo        = c.tabla
             and c.codigo        = convert (char (10), en_oficina)
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /*'No existe dato solicitado'*/
            return 1
          end
        end
      end
    end
    set rowcount 0

    return 0
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

go

