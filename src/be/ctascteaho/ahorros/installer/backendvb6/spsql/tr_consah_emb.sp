use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_consah_emb.sp                                */
/*  Stored procedure:   sp_tr_consah_emb                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:               Cuentas Corrientes                          */
/*  Disenado por:           Carmen Milan                                */
/*  Fecha de escritura:     10-Jul-2002                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Consultas a la tabla de embargos de cuentas de ahorros              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Jul/2002 Adriana Pazmino Emision inicial                         */
/*  11/Abr/2005 D. Villagomez   Monto Pendiente                         */
/*      23/Sep/2005     ARiggs          Correccion en el formato de fe- */
/*                                      para el campo fecha de oficio   */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_consah_emb')
  drop proc sp_tr_consah_emb
go

create proc sp_tr_consah_emb
(
  @s_ssn           int=null,
  @s_srv           varchar(30)=null,
  @s_lsrv          varchar(30)=null,
  @s_user          varchar(30)=null,
  @s_sesn          int=null,
  @s_term          varchar(10)=null,
  @s_date          datetime=null,
  @s_ofi           smallint=null,/* Localidad origen transaccion */
  @s_rol           smallint=null,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_org           char(1)=null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint=null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @t_show_version  bit = 0,
  @i_nombre        descripcion=null,
  @i_cta_banco     cuenta=null,
  @i_mon           tinyint=null,
  @i_juzgado       varchar(64)=null,
  @i_referencia    varchar(64)=null,
  @i_fecha_desde   datetime=null,
  @i_fecha_hasta   datetime=null,
  @i_estado        char(1)=null,
  @i_formato_fecha int = 101
)
as
  declare
    @w_cadena        varchar(255),
    @w_sp_name       varchar(30),
    @w_cond_previa   char(1),
    @w_formato_fecha char(3)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_consah_emb'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
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
      s_lsrv = @s_lsrv,
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
      t_trn = @t_trn,
      i_nombre = @i_nombre,
      i_cta_banco = @i_cta_banco,
      i_mon = @i_mon,
      i_juzgado = @i_juzgado,
      i_referencia = @i_referencia,
      i_fecha_desde = @i_fecha_desde,
      i_fecha_hasta = @i_fecha_hasta,
      i_estado = @i_estado,
      i_formato_fecha = @i_formato_fecha
    exec cobis..sp_end_debug
  end

  select
    @w_formato_fecha = convert(char(3), @i_formato_fecha)

  if @t_trn = 329
  begin
    select
      @w_cond_previa = 'N'

    if @i_cta_banco is not null
    begin
      if exists(select
                  1
                from   cob_ahorros..ah_cuenta
                where  ah_cta_banco = @i_cta_banco)
      begin
        select
          @w_cadena = 'he_cta_banco=' + "'" + @i_cta_banco + "' "
        select
          @w_cond_previa = 'S'
      end
    end

    if @i_fecha_desde is not null
       and @i_fecha_hasta is not null
    begin
      if @w_cond_previa = 'S'
        select
          @w_cadena = @w_cadena + 'and he_fecha_embargo between ' + "'" +
                      convert(
                      varchar
                                                     ( 11),
                                                     @i_fecha_desde)
                      + "'" + ' and ' + "'" + convert(varchar(11),
                      @i_fecha_hasta)
                      +
                      "' "
      else
        select
          @w_cadena = 'he_fecha_embargo between ' + "'" + convert(varchar(11),
                                  @i_fecha_desde) + "'" +
                                  ' and ' + "'"
                      + convert(varchar(11), @i_fecha_hasta) + "' "
      select
        @w_cond_previa = 'S'
    end

    if @i_juzgado is not null
    begin
      if @w_cond_previa = 'S'
        select
          @w_cadena = @w_cadena + 'and he_juzgado=' + "'" + @i_juzgado + "' "
      else
        select
          @w_cadena = 'he_juzgado=' + "'" + @i_juzgado + "' "
      select
        @w_cond_previa = 'S'
    end

    if @i_referencia is not null
    begin
      if @w_cond_previa = 'S'
        select
          @w_cadena = @w_cadena + 'and he_referencia=' + "'" + @i_referencia +
                      "' "
      else
        select
          @w_cadena = 'he_referencia=' + "'" + @i_referencia + "' "
      select
        @w_cond_previa = 'S'
    end

    if @i_estado is not null
    begin
      if @i_estado = 'V'
      begin
        if @w_cond_previa = 'S'
          select
            @w_cadena = @w_cadena + 'and he_fecha_lev is null '
        else
          select
            @w_cadena = 'he_fecha_lev is null '
      end
      else
      begin
        if @w_cond_previa = 'S'
          select
            @w_cadena = @w_cadena + 'and he_fecha_lev is not null '
        else
          select
            @w_cadena = 'he_fecha_lev is not null '
      end
      select
        @w_cond_previa = 'S'
    end

    if @w_cond_previa = 'S'
    begin
      exec ( 'select'+"'"+'SECUENCIAL'+"'"+'=he_secuencial,'+ "'"+'CUENTA'+"'"+
      '= he_cta_banco,'+ "'"+'CATEGORIA'+"'"+'= (select Y.valor
                  from cobis..cl_tabla X,cobis..cl_catalogo Y
                  where X.tabla = '
      +
      "'"+'cc_tipo_embargo'+"'"+
      ' and   X.codigo = Y.tabla
                  and   Y.codigo = A.he_tipo_embargo),'+ "'"+
      'DESC TIPO EMB'
      + "'"+ '= (select Y.valor
                  from cobis..cl_tabla X,cobis..cl_catalogo Y
                  where X.tabla = ' +"'"+'cc_clase_embargo'+"'"+
      ' and   X.codigo = Y.tabla
                  and   Y.codigo = A.he_id_embargo),'+ "'"+
      'MONTO EMBARGADO'
      + "'"+'=he_monto,'+ "'"+'MONTO EMBARGO'+"'"+'=he_monto_solicitado,'+ "'"+
      'MONTO PENDIENTE'+"'"+'=he_monto_pendiente,'+ "'"+'No DE OFICIO'+"'"+
      '=he_referencia,'+ "'"+'FECHA OFICIO'+"'"+
      '=convert(varchar(10),he_fecha_oficio,' + @w_formato_fecha +'), '+ "'"+
      'COMENTARIO'+"'"+'=he_comentario,'+ "'"+'AUTORIDAD'+"'"+'=he_autoridad,'+
      "'"+
      'FECHA EMBARGO'+"'"+'=convert(varchar(10),he_fecha_embargo,' +
      @w_formato_fecha +'),'+ "'"+'FECHA LEVANTAMIENTO'+"'"+
      '=convert(varchar(10),he_fecha_lev,' + @w_formato_fecha +') '+
      'from cob_ahorros..ah_embargo  A '+ 'where '+ @w_cadena)
    end
    else
    begin
      exec ( 'select'+"'"+'SECUENCIAL'+"'"+'=he_secuencial,'+ "'"+'CUENTA'+"'"+
      '= he_cta_banco,'+ "'"+'CATEGORIA'+"'"+'= (select Y.valor
                  from cobis..cl_tabla X,cobis..cl_catalogo Y
                  where X.tabla = '
      +
      "'"+'cc_tipo_embargo'+"'"+
      ' and   X.codigo = Y.tabla
                  and   Y.codigo = A.he_tipo_embargo),'+ "'"+
      'DESC TIPO EMB'
      + "'"+ '= (select Y.valor
                  from cobis..cl_tabla X,cobis..cl_catalogo Y
                  where X.tabla = ' +"'"+'cc_clase_embargo'+"'"+
      ' and   X.codigo = Y.tabla
                  and   Y.codigo = A.he_id_embargo),'+ "'"+
      'MONTO EMBARGADO'
      + "'"+'=he_monto,'+ "'"+'MONTO EMBARGO'+"'"+'=he_monto_solicitado,'+ "'"+
      'MONTO PENDIENTE'+"'"+'=he_monto_pendiente,'+ "'"+'No DE OFICIO'+"'"+
      '=he_referencia,'+ "'"+'FECHA OFICIO'+"'"+
      '=convert(varchar(10),he_fecha_oficio,' + @w_formato_fecha +'), '+ "'"+
      'COMENTARIO'+"'"+'=he_comentario,'+ "'"+'AUTORIDAD'+"'"+'=he_autoridad,'+
      "'"+
      'FECHA EMBARGO'+"'"+'=convert(varchar(10),he_fecha_embargo,' +
      @w_formato_fecha +'),'+ "'"+'FECHA LEVANTAMIENTO'+"'"+
      '=convert(varchar(10),he_fecha_lev,' + @w_formato_fecha +'), '+ "'"+
      'DESC TIPO EMB'+"'"+ '= (select Y.valor
                  from cobis..cl_tabla X,cobis..cl_catalogo Y
                  where X.tabla = ' +"'"+
      'cc_clase_embargo'+"'"+
      ' and   X.codigo = Y.tabla
                  and   Y.codigo = A.he_id_embargo)'
      +
      'from cob_ahorros..ah_embargo  A ')

    end

  end

  return (0)

go

