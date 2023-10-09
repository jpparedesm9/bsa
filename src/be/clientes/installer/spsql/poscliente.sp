/************************************************************************/
/*  Archivo:        poscliente.sp                                       */
/*  Stored procedure:   sp_poscliente                                   */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 06-Nov-1992                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*      de servicios contratados por un cliente                         */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  21/Mar/97   N.Velasco   Posicion Cliente                            */
/*      16/Jun/97       N.Velasco       Nuevos Campos Pos.CLiente en las*/
/*                                      cl_det_producto y               */
/*                                      cl_det_producto_no_cobis_tmp    */
/*  05/May/2016 T. Baidal      Migracion a CEN                          */
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
           where  name = 'sp_poscliente')
    drop proc sp_poscliente
go

create proc sp_poscliente
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
  @i_modo         tinyint = null,
  @i_suma1        tinyint = null,
  @i_suma2        tinyint = null,
  @i_suma3        tinyint = null,
  @i_suma4        tinyint = null,
  @i_ente         int = null,
  @i_det_producto int = null,
  @i_tipoA        int = null,
  @i_tipoP        int = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_valor1  money,
    @w_valor2  money,
    @w_valor3  money,
    @w_valor4  money
  select
    @w_sp_name = 'sp_poscliente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_valor1 = 0
  select
    @w_valor2 = 0
  select
    @w_valor3 = 0
  select
    @w_valor4 = 0

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      i_modo = @i_modo,
      i_suma1 = @i_suma1,
      i_suma2 = @i_suma2,
      i_ente = @i_ente,
      i_detpro = @i_det_producto,
      i_tipoA = @i_tipoA,
      i_tipoP = @i_tipoP

    exec cobis..sp_end_debug
  end

  if @t_trn = 1343
  begin
    if @i_tipoA = 1
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'EstadoServ' = dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'A'
        union
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'EstadoServ' = dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto_no_cobis_tmp,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'A'
        set rowcount 0
        return 0
      end
      else if @i_modo = 1
      begin
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'Estado Ser'= dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and cl_det_producto  > @i_det_producto
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'A'
        union
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'EstadoServ' = dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto_no_cobis_tmp,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and cl_det_producto  > @i_det_producto
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'A'
        set rowcount 0
        return 0
      end
    end
    /* else*/
    if @i_tipoP = 1
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'EstadoServ' = dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'P'
        union
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'EstadoServ' = dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona,
          'TipoProd   '= dp_tipo_producto
        --'Vlr.Inicial'= dp_valor_inicial,
        --'Vlr.Promed.'= dp_valor_promedio,
        --'Fch.Prox.Vcto'=dp_fecha_prox_ven,
        --'Rol_cliente'  =dp_rol_cliente,
        --'Fch.Cambio'=dp_fecha_cambio

        from   cl_cliente,
               cl_det_producto_no_cobis_tmp,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente       = @i_ente
           and dp_det_producto  = cl_det_producto
           and fi_filial        = dp_filial
           and of_oficina       = dp_oficina
           and pd_producto      = dp_producto
           and mo_moneda        = dp_moneda
           and dp_tipo_producto = 'P'
        set rowcount 0
        return 0
      end
      else if @i_modo = 1
      begin
        select
          'Filial' = fi_abreviatura,
          'Oficina' = substring(of_nombre,
                                1,
                                15),
          'Cliente' = cl_cliente,
          'Producto' = pd_abreviatura,
          'Tipo' = pd_tipo,
          'Moneda' = substring(mo_descripcion,
                               1,
                               10),
          'Comentario'= dp_comentario,
          --'Monto'     = dp_monto,
          --'Tiempo'    = dp_tiempo,
          'Servicio' = cl_det_producto,
          --'Cuenta'    = dp_cuenta,
          'Rol' = cl_rol,
          'Fecha' = convert(char(8), cl_fecha, 1),
          'Estado Ser'= dp_estado_ser,
          'Autorizante'= dp_autorizante,
          'Oficial    '= dp_oficial_cta,
          'Sector     '= dp_sector,
          'Zona       '= dp_zona
        from   cl_cliente,
               cl_det_producto,
               cl_oficina,
               cl_producto,
               cl_moneda,
               cl_filial
        where  cl_cliente      = @i_ente
           and cl_det_producto > @i_det_producto
           and dp_det_producto = cl_det_producto
           and fi_filial       = dp_filial
           and of_oficina      = dp_oficina
           and pd_producto     = dp_producto
           and mo_moneda       = dp_moneda
        set rowcount 0
        return 0
      end
    end

    if @i_suma1 = 1 /* para sumar en tabla prod.cobis TipoProd=A*/
    begin
      --select @w_valor1=sum (dp_monto)
      select
        @w_valor1 = 10000
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente       = @i_ente
         and dp_det_producto  = cl_det_producto
         and fi_filial        = dp_filial
         and of_oficina       = dp_oficina
         and pd_producto      = dp_producto
         and mo_moneda        = dp_moneda
         and dp_tipo_producto = 'A'
      select
        @w_valor1
    end

    if @i_suma2 = 1 /* para sumar en tabla prod.NO cobis TipoProd=A */
    begin
      --select @w_valor2=sum (dp_monto)
      select
        @w_valor2 = 10000
      from   cl_cliente,
             cl_det_producto_no_cobis_tmp,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente       = @i_ente
         and dp_det_producto  = cl_det_producto
         and fi_filial        = dp_filial
         and of_oficina       = dp_oficina
         and pd_producto      = dp_producto
         and mo_moneda        = dp_moneda
         and dp_tipo_producto = 'A'
      select
        @w_valor2
    end

    if @i_suma3 = 1 /* para sumar en tabla prod.cobis TipoProd=P*/
    begin
      --select @w_valor3=sum (dp_monto)
      select
        @w_valor3 = 10000
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente       = @i_ente
         and dp_det_producto  = cl_det_producto
         and fi_filial        = dp_filial
         and of_oficina       = dp_oficina
         and pd_producto      = dp_producto
         and mo_moneda        = dp_moneda
         and dp_tipo_producto = 'P'
      select
        @w_valor3
    end

    if @i_suma4 = 1 /* para sumar en tabla prod.NO cobis TipoProd=P */
    begin
      --select @w_valor4=sum (dp_monto)
      select
        @w_valor4 = 10000
      from   cl_cliente,
             cl_det_producto_no_cobis_tmp,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente       = @i_ente
         and dp_det_producto  = cl_det_producto
         and fi_filial        = dp_filial
         and of_oficina       = dp_oficina
         and pd_producto      = dp_producto
         and mo_moneda        = dp_moneda
         and dp_tipo_producto = 'P'
      select
        @w_valor4
    end

  end
  else
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101183
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go

