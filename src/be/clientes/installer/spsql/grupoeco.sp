/************************************************************************/
/*      Archivo:                grupoeco.sp                             */
/*      Stored procedure:       sp_grupoeco                             */
/*      Base de datos:          cobis                                   */
/*      Producto: Clientes                                              */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 08-Nov-1992                                 */
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
/*      Este programa procesa las transacciones del stored procedure    */
/*      Insercion de grupo                                              */
/*      Actualizacion de grupo                                          */
/*      Ayuda de grupo                                                  */
/*      Query de grupo                                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  23/Sep/97       Nydia Velasco  Consolidado de Grupos Economicos     */
/*                                     Personalizacion Banco del Estado */
/*  04/May/2016     T. Baidal      Migracion a CEN                      */
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
           where  name = 'sp_grupoeco') 
    drop proc sp_grupoeco
go

create proc sp_grupoeco
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
  @i_modo         tinyint = null,
  @i_grupo        int = null,
  @i_operacion    char(1) = null,
  @i_tipo         char(1) = null
)
as
  declare
    @w_siguiente     int,
    @w_return        int,
    @w_ente          int,
    @w_num_cl_gr     int,
    @w_contador      int,
    @w_sp_name       varchar(32),
    @w_codigo        int,
    @w_tipo          char(1),
    @w_nombre        descripcion,
    @w_representante int,
    @w_ruc           numero,
    @w_compania      int,
    @w_oficial       smallint,
    @w_oficial_ant   smallint,
    @w_oficial_cia   smallint,
    @w_valor_a       money,
    @w_valor_p       money,
    @v_nombre        descripcion,
    @v_representante int,
    @v_ruc           numero,
    @v_compania      int,
    @v_oficial       smallint,
    @v_oficial_ant   smallint

  select
    @w_sp_name = 'sp_grupoeco'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_valor_a = 0
  select
    @w_valor_p = 0

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_file = @t_file,
      t_from = @t_from,
      i_grupo = @i_grupo
    exec cobis..sp_end_debug
  end

  /** Query **/
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1297
    begin
      if @i_tipo = 'Z'
      begin
        select
          'Cliente' = en_ente,
          'T.Prod' = dp_tipo_producto,
          'Cod.' = dp_producto,
          'Producto' = pd_descripcion,
          'Vlr.Inicial' = dp_valor_inicial,
          'Saldo' = dp_monto,
          'Vlr.Promedio' = dp_valor_promedio,
          'Negocio ' = dp_cuenta
        from   cl_cliente_grupo,
               cl_ente,
               cl_det_producto,
               cl_producto
        where  cg_grupo      = @i_grupo
           and en_ente       = cg_ente
           and dp_cliente_ec = en_ente
           and pd_producto   = dp_producto

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
      /* sumar todos los productos Tipo A(activos)*/
      if @i_tipo = 'A'
      begin
        select
          @w_valor_a = sum(dp_monto)
        from   cl_cliente_grupo,
               cl_ente,
               cl_det_producto,
               cl_producto
        where  cg_grupo         = @i_grupo
           and en_ente          = cg_ente
           and dp_cliente_ec    = en_ente
           and pd_producto      = dp_producto
           and dp_tipo_producto = 'A'
        select
          @w_valor_a
      end

      /* sumar todos los productos Tipo P(pasivos)*/
      if @i_tipo = 'P'
      begin
        select
          @w_valor_p = sum(dp_monto)
        from   cl_cliente_grupo,
               cl_ente,
               cl_det_producto,
               cl_producto
        where  cg_grupo         = @i_grupo
           and en_ente          = cg_ente
           and dp_cliente_ec    = en_ente
           and pd_producto      = dp_producto
           and dp_tipo_producto = 'P'

        select
          @w_valor_p
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

/** Search **/
/* consultar todos los miembros de un grupo economico que tienen negocios*/
  /* creados, de 20 en 20 */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1296
    begin
      set rowcount 20
      if @i_modo = 0
        select distinct
          'Codigo' = en_ente,
          -- 'Nombre'   = convert(varchar(50),rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre)),
          'Nombre' = en_nomlar,
          'Documento'= en_ced_ruc
        from   cl_cliente_grupo,
               cl_ente -- , cl_det_producto
        where  cg_grupo = @i_grupo
           and en_ente  = cg_ente
      --          and dp_cliente_ec = en_ente

      if @i_modo = 1
        select distinct
          'Codigo' = en_ente,
          --               'Nombre'   = convert(varchar(50),rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre)),
          'Nombre' = en_nomlar,
          'Documento'= en_ced_ruc
        from   cl_cliente_grupo,
               cl_ente -- , cl_det_producto
        where  cg_grupo = @i_grupo
           and en_ente  = cg_ente
      --          and dp_cliente_ec = en_ente

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

