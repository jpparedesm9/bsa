/************************************************************************/
/*  Archivo:        grupoqry.sp                                         */
/*  Stored procedure:   sp_grupo_qry                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Sandra Ortiz                                    */
/*  Fecha de escritura:     01/Dic/1993                                 */
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
/*      Este stored procedure procesa las siguientes consultas:         */
/*      Miembros de grupo economico                                     */
/*      Grupos que son companias                                        */
/*      Productos por grupo (Posicion de grupo )                        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  01/Nov/93   R. Minga V.     Emision Inicial                         */
/*  04/Jul/96   A. Rmirez       Cambio Ente por prospecto  CEPP         */
/*  10/Mar/97   N. Velasco      Consul.Integrant GrEcon.Traiga          */
/*                                      Apellidos y Nombres             */
/*  04/May/2016 T. Baidal       Migracion a CEN                         */
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
           where  name = 'sp_grupo_qry') 
    drop proc sp_grupo_qry
go

create proc sp_grupo_qry
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
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_grupo        int = null,
  @i_ente         int = null,
  @i_producto     tinyint = null,
  @i_tipo         char(1) = null,
  @i_cuenta       cuenta = null
)
as
  declare @w_sp_name varchar (30)

  select
    @w_sp_name = 'sp_grupo_qry'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/* Consulta */
  /* Miembros de un grupo  se selecciona de 20 en 20 */
  if @i_operacion = 'M'
  begin
    if @t_trn = 1235
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'Prospecto' = en_ente,/*CEPP*/
          'Miembro' = convert(varchar(50), rtrim(p_p_apellido) + ' ' + rtrim(
                                           p_s_apellido)
                                           + ' ' +
                                                       rtrim(en_nombre)),
          'D.I./NIT' = en_ced_ruc,
          'Tipo' = en_subtipo,
          'Pasaporte' = p_pasaporte
        from   cl_ente
        where  en_grupo = @i_grupo
      /* and isnull(c_es_grupo,'N') <> 'S'    */
      end
      if @i_modo = 1
      begin
        select
          'Prospecto' = en_ente,/*CEPP*/
          'Miembro' = convert(varchar(50), rtrim(p_p_apellido) + ' ' + rtrim(
                                           p_s_apellido)
                                           + ' ' +
                                                       rtrim(en_nombre)),
          'D.I./NIT' = en_ced_ruc,
          'Tipo' = en_subtipo,
          'Pasaporte' = p_pasaporte
        from   cl_ente
        where  en_grupo = @i_grupo
           and en_ente  > @i_ente
        /* and isnull(c_es_grupo,'N') <> 'S'    */
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end

      end
      if @i_modo = 3
      begin
        select
          'Cod ' = cg_ente,
          /*      'Nombre'    = en_nombre ,*/
          'Nombre' = convert(varchar(50), rtrim(p_p_apellido) + ' ' + rtrim(
                                          p_s_apellido
                                          )
                                          + ' ' +
                                                     rtrim(en_nombre)),
          'Fecha Asig' = convert(char(10), cg_fecha_reg, 101),
          'Usuario       '= cg_usuario
        from   cl_cliente_grupo,
               cl_ente
        where  cg_grupo = @i_grupo
           and cg_ente  = en_ente
      end

      if @i_modo = 4
      begin
        select
          'Cod ' = cg_ente,
          'Nombre' = en_nombre,
          'Fecha Asig' = cg_fecha_reg,
          'Usuario       '= cg_usuario
        from   cl_cliente_grupo,
               cl_ente
        where  cg_grupo = @i_grupo
           and cg_ente  = en_ente
           and cg_ente  > @i_ente
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

/* Consulta */
  /* Grupos que son companias */
  if @i_operacion = 'C'
  begin
    if @t_trn = 1236
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Grupo' = gr_grupo,
          'Compania' = en_ente,
          'Nombre' = convert(char(30), gr_nombre),
          'NIT' = en_ced_ruc
        from   cl_grupo,
               cl_ente
        where  gr_compania = en_ente
           and c_es_grupo  = 'S'
        order  by gr_grupo
      if @i_modo = 1
      begin
        select
          'Grupo' = gr_grupo,
          'Compania' = en_ente,
          'Nombre' = convert(char(30), gr_nombre),
          'NIT' = en_ced_ruc
        from   cl_grupo,
               cl_ente
        where  gr_compania = en_ente
           and gr_grupo    > @i_grupo
           and c_es_grupo  = 'S'
        order  by gr_grupo

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      set rowcount 0

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

  /** Query **/
  if @i_operacion = 'P'
  /* Productos contratados por un grupo */
  begin
    if @t_trn = 1237
    begin
      set rowcount 20

      if @i_modo = 0
      begin
        select
          'Codigo' = dp_producto,
          'Producto' = convert(char(40), pd_descripcion),
          'Cod Tipo' = dp_tipo,
          'Tipo Prod' = valor,
          'Moneda' = convert(char(15), mo_descripcion),
          'Ente' = en_ente,/*CEPP*/
          'Nombre' = en_nomlar,
          'Cuenta' = dp_cuenta
        from   cl_ente,
               cl_producto,
               cl_catalogo,
               cl_moneda,
               cl_det_producto,
               cl_cliente,
               cl_tabla
        where  en_grupo        = @i_grupo
           and cl_cliente      = en_ente
           and cl_rol          <> 'F'
           and cl_det_producto = dp_det_producto
           and dp_producto     = pd_producto
           and dp_tipo         = pd_tipo
           and dp_moneda       = mo_moneda
           and cl_tabla.tabla  = 'cl_tproducto'
           and cl_tabla.codigo = cl_catalogo.tabla
           and dp_tipo         = cl_catalogo.codigo
        order  by dp_producto,
                  dp_tipo,
                  dp_cuenta
      end
      else if @i_modo = 1
      begin
        select
          'Codigo' = dp_producto,
          'Producto' = convert(char(40), pd_descripcion),
          'Cod Tipo' = dp_tipo,
          'Tipo Prod' = valor,
          'Moneda' = convert(char(15), mo_descripcion),
          'Ente' = en_ente,/*CEPP*/
          'Nombre' = en_nomlar,
          'Cuenta' = dp_cuenta
        from   cl_ente,
               cl_producto,
               cl_catalogo,
               cl_moneda,
               cl_det_producto,
               cl_cliente,
               cl_tabla
        where  en_grupo        = @i_grupo
           and cl_cliente      = en_ente
           and cl_rol          <> 'F'
           and cl_det_producto = dp_det_producto
           and dp_producto     = pd_producto
           and dp_tipo         = pd_tipo
           and dp_moneda       = mo_moneda
           and cl_tabla.tabla  = 'cl_tproducto'
           and cl_tabla.codigo = cl_catalogo.tabla
           and dp_tipo         = cl_catalogo.codigo
           and (dp_producto     > @i_producto
                 or (dp_producto     = @i_producto
                     and dp_tipo         > @i_tipo)
                 or (dp_producto     = @i_producto
                     and dp_tipo         = @i_tipo
                     and dp_cuenta       > @i_cuenta))
        order  by dp_producto,
                  dp_tipo,
                  dp_cuenta

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

  end

go

