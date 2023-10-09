/************************************************************************/
/*  Archivo:            cl_valid.sp                                     */
/*  Stored procedure:   sp_valida_identidad                             */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       David Pulido                                    */
/*  Fecha de escritura: 08/Feb/2013                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza mantenimiento transacciones en las            */
/*  cuales se valida la identidad del cliente.                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  08/Feb/2013     David Pulido    Emision inicial                     */
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
           where  name = 'sp_valida_identidad')
  drop proc sp_valida_identidad
go

create proc sp_valida_identidad
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_ssn_corr     int = null,
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_producto     tinyint = null,
  @i_transaccion  smallint = null,
  @i_ind_causal   char(1) = null,
  @i_causal       varchar(10) = null,
  @i_estado       char(1) = 'V'
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_sec           int,
    @w_fecha_proceso datetime,
    @w_fecha_reg     datetime,
    @w_transaccion   varchar(10)

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_valida_identidad'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn
    exec cobis..sp_end_debug
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso
  if @i_operacion = 'I'
  begin
    if @t_trn <> 1470
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 1
    end

    select
      @w_transaccion = C.valor
    from   cobis..cl_tabla T,
           cobis..cl_catalogo C
    where  T.codigo = C.tabla
       and T.tabla  = 'cl_trn_central_local'
       and C.codigo = @i_transaccion
    if @w_transaccion is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end

    if exists (select
                 1
               from   cobis..cl_val_iden
               where  vi_transaccion = @w_transaccion
                  and vi_causal      = @i_causal
                  and vi_producto    = @i_producto)
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 1
    end

    insert into cobis..cl_val_iden
                (vi_producto,vi_transaccion,vi_ind_causal,vi_causal,vi_estado,
                 vi_fecha_registro)
    values      (@i_producto,@w_transaccion,@i_ind_causal,@i_causal,@i_estado,
                 @w_fecha_proceso)

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 803004
      return 1
    end

    select
      @w_sec = isnull(max(secuencial), 0) + 1
    from   cobis..ts_val_iden

    insert into cobis..ts_val_iden
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,producto,transaccion,
                 indcausal,causal,estado,fecha_registro,oficina)
    values      (@w_sec,1,'I',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_producto,@i_transaccion,
                 @i_ind_causal,@i_causal,@i_estado,@w_fecha_proceso,@s_ofi)

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 803004,
        @i_msg   = 'ERROR EN LA INSERCION TRANSACCION DE SERVICIO'
      return 1
    end

  end

  if @i_operacion = 'U'
  begin
    if @t_trn <> 1450
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
      return 1
    end

    select
      @w_transaccion = C.valor
    from   cobis..cl_tabla T,
           cobis..cl_catalogo C
    where  T.codigo = C.tabla
       and T.tabla  = 'cl_trn_central_local'
       and C.codigo = @i_transaccion
    if @w_transaccion is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end

    update cobis..cl_val_iden
    set    vi_estado = @i_estado,
           vi_fecha_modif = getdate()
    where  vi_producto    = @i_producto
       and vi_transaccion = @w_transaccion
       and vi_causal      = @i_causal

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601162
      return 1
    end

    select
      @w_sec = isnull(max(secuencial), 0) + 1
    from   cobis..ts_val_iden

    select
      @w_fecha_reg = vi_fecha_registro
    from   cobis..cl_val_iden
    where  vi_producto    = @i_producto
       and vi_transaccion = @w_transaccion
       and vi_causal      = @i_causal

    insert into cobis..ts_val_iden
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,producto,transaccion,
                 indcausal,causal,estado,fecha_registro,fecha_modif,
                 oficina)
    values      (@w_sec,2,'U',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_producto,@i_transaccion,
                 @i_ind_causal,@i_causal,@i_estado,@w_fecha_reg,getdate(),
                 @s_ofi)

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 803004,
        @i_msg   = 'ERROR EN LA INSERCION TRANSACCION DE SERVICIO'
      return 1
    end
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1469
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 1
    end

    select
      'PRODUCTO' = vi_producto,
      'TRANSACCION' = (select
                         C.codigo
                       from   cobis..cl_tabla T,
                              cobis..cl_catalogo C
                       where  T.codigo = C.tabla
                          and T.tabla  = 'cl_trn_central_local'
                          and C.valor  = vi_transaccion),
      'IND CAUSAL' = vi_ind_causal,
      'CAUSAL' = vi_causal,
      'ESTADO' = vi_estado
    from   cobis..cl_val_iden
  end

  if @i_operacion = 'S'
  begin
    if @t_trn <> 1469
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
      return 1
    end

    if @i_transaccion is not null
    begin
      select
        @w_transaccion = C.valor
      from   cobis..cl_tabla T,
             cobis..cl_catalogo C
      where  T.codigo = C.tabla
         and T.tabla  = 'cl_trn_central_local'
         and C.codigo = @i_transaccion
      if @w_transaccion is null
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

    select
      'PRODUCTO' = vi_producto,
      'TRANSACCION' = (select
                         C.codigo
                       from   cobis..cl_tabla T,
                              cobis..cl_catalogo C
                       where  T.codigo = C.tabla
                          and T.tabla  = 'cl_trn_central_local'
                          and C.valor  = vi_transaccion),
      'IND CAUSAL' = vi_ind_causal,
      'CAUSAL' = vi_causal,
      'ESTADO' = vi_estado
    from   cobis..cl_val_iden
    where  vi_producto    = @i_producto
        or vi_transaccion = @w_transaccion
  end

go

