/************************************************************************/
/*  Archivo:                ref_eco2.sp                                 */
/*  Stored procedure:       sp_ref_eco2                                 */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Carlos Rodriguez V.                         */
/*  Fecha de escritura:     30-Dic-1994                                 */
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
/*  Busqueda de referencia economica  general y especifica              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  95/03/31    Bco. Prestamos  Ingreso de nuevos campos                */
/*  95/05/09    Sandra Ortiz    Campos adicionales en Ref.Bancarias     */
/*                              fecha de apertura, tipo de cuenta,      */
/*                              moneda.                                 */
/*  04/Jul/96   A. Ramirez      Cambio de Mensajes e ingreso de         */
/*                              campos        CMIC                      */
/*  14/Dic/96   J. Loyo         Ingreso de nuevos campos    INNUC       */
/*  10/May/03   E. Laguna       Ajustes prueba componente               */
/*  05/May/2016 T. Baidal       Migracion a CEN                         */
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
           where  name = 'sp_ref_eco2')
    drop proc sp_ref_eco2
go

create proc sp_ref_eco2
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @s_rol            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint = null,
  @t_show_version   bit = 0,
  @i_operacion      char(1),
  @i_ente           int = null,
  @i_tipo           char(1) = null,
  @i_referencia     tinyint = null,
  @i_banco          catalogo = null,
  @i_cuenta         varchar(30) = null,
  @i_tipo_cifras    char(2) = null,
  @i_numero_cifras  tinyint = null,
  @i_calificacion   catalogo = null,
  @i_observacion    varchar(254) = null,
  @i_verificacion   char(1) = 'N',
  @i_fecha_apertura char(10) = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_banco              catalogo,
    @w_cuenta             varchar(30),
    @w_tipo_cifras        char(2),
    @w_numero_cifras      tinyint,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_ver          datetime,
    @w_verificacion       char(1),
    @w_calificacion       char(2),
    @w_vigencia           char(1),
    @w_observacion        varchar(254),
    @w_fecha_apertura     char(10),
    @v_banco              catalogo,
    @v_cuenta             varchar(30),
    @v_tipo_cifras        char(2),
    @v_numero_cifras      tinyint,
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_fecha_ver          datetime,
    @v_verificacion       char(1),
    @v_calificacion       char(2),
    @v_vigencia           char(1),
    @v_observacion        varchar(254),
    @v_fecha_apertura     char(10),
    @o_ente               int,
    @o_cedruc             numero,
    @o_en_nombre          descripcion,
    @o_referencia         tinyint,
    @o_tipo               char(1),
    @o_desc_tipo          descripcion,
    @o_institucion        descripcion,
    @o_fecha_ingr_en_inst datetime,
    @o_banco              int,
    @o_banco_nombre       descripcion,
    @o_cuenta             varchar(30),
    @o_banco_tar          int,
    @o_tarjeta_nombre     descripcion,
    @o_cuenta_tar         varchar(30),
    @o_calificacion       char(2),
    @o_desc_calif         descripcion,
    @o_tipo_cifras        char(2),
    @o_numero_cifras      tinyint,
    @o_desc_tipo_cifras   descripcion,
    @o_verificacion       char(1),
    @o_fecha_ver          datetime,
    @o_vigencia           char(1),
    @o_fecha_modificacion datetime,
    @o_fecha_registro     datetime,
    @o_observacion        varchar(254),
    @o_fecha_apertura     char(10)

  select
    @w_sp_name = 'sp_ref_eco2'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/** Search **/
  /* Despliegue de todas las referencias economicas de un ente  no se
     controla de 20 en 20 pues se espera menos de 20 referencias */
  if @i_operacion = 'S'
  begin
    if @t_trn = 180
    begin
      -- Referencia bancaria
      if exists (select
                   1
                 from   cl_referencia
                 where  re_ente = @i_ente
                    and re_tipo = 'B')
      begin
        select
          'NUMERO ' = re_referencia,
          'TIPO ' = re_tipo,
          'DESC. TIPO ' = c.valor,
          'COD. ENTIDAD' = ec_banco,
          'ENTIDAD FINANCIERA' = substring(ba_descripcion,
                                           1,
                                           30),
          'CUENTA BANC.' = ec_cuenta,
          'TIPO DE CUENTA' = ec_tipo_cta,
          'DESC. TIPO CTA' = (select
                                valor
                              from   cobis..cl_tabla t1,
                                     cobis..cl_catalogo c1
                              where  t1.tabla  = 'cl_tipo_cuenta'
                                 and c1.tabla  = t1.codigo
                                 and c1.codigo = X.ec_tipo_cta),
          'TARJETA' = ' ',
          'NOMBRE de la TARJETA ' = ' ',
          'CLASE TARJETA' = ' ',
          'DESC. CLASE TARJETA' = ' ',
          'No. DE TARJETA' = ' ',
          'INSTITUCION' = ' ',
          'FECHA ING. EN INST.' = ' ',
          'MANEJO' = re_calificacion,
          'DESC. MANEJO' = (select
                              valor
                            from   cobis..cl_tabla t2,
                                   cobis..cl_catalogo c2
                            where  t2.tabla  = 'cl_posicion'
                               and c2.tabla  = t2.codigo
                               and c2.codigo = X.re_calificacion),
          'VERIF.' = re_verificacion,
          'VIGENCIA' = re_vigencia,
          'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
          'GARANTIA' = ' ',
          'CUPO        ' = ' ',
          'MONTO VENCIDO'= ' ',
          'SALDO        '= ' ',
          'CTA NACIONAL' = re_nacional,
          'SUCURSAL' = re_sucursal,
          'CIUDAD' = re_ciudad,
          'TELEFONO' = re_telefono,
          'ESTADO ' = re_estado,
          'OBS VERIFICADO'= re_obs_verificado
        from   cl_referencia X,
               cl_banco_rem,
               cl_catalogo c,
               cl_tabla d
        where  re_ente  = @i_ente
           and re_tipo  = c.codigo
           and c.tabla  = d.codigo
           and d.tabla  = 'cl_rtipo'
           and ec_banco = ba_banco
           and re_tipo  = 'B'

        -- Referencia Tarjeta
        if exists (select
                     1
                   from   cl_referencia
                   where  re_ente = @i_ente
                      and re_tipo = 'T')
        begin
          select
            'NUMERO ' = re_referencia,
            'TIPO ' = re_tipo,
            'DESC. TIPO ' = c.valor,
            'ENTIDAD' = ' ',
            'ENTIDAD FINANCIERA' = ' ',
            'CUENTA BANC.' = ' ',
            'TIPO CTA' = ' ',
            'DESC. TIPO Cta' = ' ',
            'TARJETA' = ta_banco,
            'NOMBRE DE LA TARJETA ' = substring(a.valor,
                                                1,
                                                30),
            'CLASE TARJETA' = ec_tipo_cta,
            'DESC. CLASE TARJETA' = c3.valor,
            'No. DE TARJETA' = ta_cuenta,
            'INSTITUCION' = ' ',
            'FECHA ING. EN INST.' = ' ',
            'MANEJO' = re_calificacion,
            'DESC. MANEJO' = (select
                                valor
                              from   cobis..cl_tabla t2,
                                     cobis..cl_catalogo c2
                              where  t2.tabla  = 'cl_posicion'
                                 and c2.tabla  = t2.codigo
                                 and c2.codigo = X.re_calificacion),
            'VERIF.' = re_verificacion,
            'VIGENCIA' = re_vigencia,
            'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
            'GARANTIA' = ' ',
            'CUPO        ' = monto,
            'MONTO VENCIDO' = ' ',
            'SALDO        ' = ' ',
            'CTA NACIONAL' = re_nacional,
            'SUCURSAL' = re_sucursal,
            'CIUDAD' = re_ciudad,
            'TELEFONO' = re_telefono,
            'ESTADO' = re_estado,
            'OBS VERIFICADO' = re_obs_verificado
          from   cl_referencia X,
                 cl_catalogo a,
                 cl_tabla b,
                 cl_catalogo c,
                 cl_tabla d,
                 cl_catalogo c3,
                 cl_tabla t3
          where  re_ente   = @i_ente
             and re_tipo   = c.codigo
             and c.tabla   = d.codigo
             and d.tabla   = 'cl_rtipo'
             and ta_banco  = a.codigo
             and a.tabla   = b.codigo
             and b.tabla   = 'cl_tarjeta'
             and re_tipo   = 'T'
             and t3.tabla  = 'cl_clase_tarjeta'
             and c3.tabla  = t3.codigo
             and c3.codigo = ec_tipo_cta
        end

        -- Referencia Comercial
        if exists (select
                     1
                   from   cl_referencia
                   where  re_ente = @i_ente
                      and re_tipo = 'C')
        begin
          select
            'NUMERO' = re_referencia,
            'TIPO' = re_tipo,
            'DESC. TIPO ' = c.valor,
            'ENTIDAD' = ' ',
            'ENTIDAD FINANCIERA' = ' ',
            'CUENTA BANC.' = ' ',
            'TIPO CTA' = ' ',
            'DESC. TIPO CTA' = ' ',
            'TARJETA' = ' ',
            'NOMBRE DE LA  TARJETA ' = ' ',
            'CLASE TARJETA' = ' ',
            'DESC. CLASE TARJETA' = ' ',
            'No. DE TARJETA' = ' ',
            'INSTITUCION' = substring(co_institucion,
                                      1,
                                      30),
            'FECHA ING. EN INST.' = convert(char(10), ec_fec_apertura, 103),
            'MANEJO' = re_calificacion,
            'DESC. MANEJO' = (select
                                valor
                              from   cobis..cl_tabla t2,
                                     cobis..cl_catalogo c2
                              where  t2.tabla  = 'cl_posicion'
                                 and c2.tabla  = t2.codigo
                                 and c2.codigo = X.re_calificacion),
            'VERIF.' = re_verificacion,
            'VIGENCIA' = re_vigencia,
            'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
            'GARANTIA' = ' ',
            'CUPO USADO' = monto,
            'MONTO VENCIDO' = ' ',
            'SALDO        ' = ' ',
            'CTA NACIONAL' = re_nacional,
            'SUCURSAL' = re_sucursal,
            'CIUDAD' = re_ciudad,
            'TELEFONO' = re_telefono,
            'ESTADO' = re_estado,
            'OBS VERIFICADO' = re_obs_verificado
          from   cl_referencia X,
                 cl_catalogo c,
                 cl_tabla d
          where  re_ente = @i_ente
             and re_tipo = c.codigo
             and c.tabla = d.codigo
             and d.tabla = 'cl_rtipo'
             and re_tipo = 'C'
        end

        -- Referencia Financiera
        if exists (select
                     1
                   from   cl_referencia
                   where  re_ente = @i_ente
                      and re_tipo = 'F')
        begin
          select
            'NUMERO' = re_referencia,
            'TIPO' = re_tipo,
            'DESC. TIPO' = c.valor,
            'COD. ENTIDAD' = fi_banco,
            'ENTIDAD FINANCIERA' = substring(ba_descripcion,
                                             1,
                                             30),
            'CUENTA BANC' = ' ',
            'TIPO CTA. ' = ' ',
            'DESC. TIPO CTA.'= ' ',
            'TARJETA ' = ' ',
            'NOMBRE TARJETA ' = ' ',
            'CLASE TARJETA' = ' ',
            'DESC. CLASE TARJETA' = ' ',
            'No.  TARJETA' = ' ',
            'INSTITUCION' = ' ',
            'FEC ING. INST' = ' ',
            'MANEJO' = re_calificacion,
            'DESC. MANEJO' = (select
                                valor
                              from   cobis..cl_tabla t2,
                                     cobis..cl_catalogo c2
                              where  t2.tabla  = 'cl_posicion'
                                 and c2.tabla  = t2.codigo
                                 and c2.codigo = X.re_calificacion),
            'VERIF.' = re_verificacion,
            'VIGENCIA' = re_vigencia,
            'FECHA Exp.' = convert(char(10), ec_fec_exp_ref, 103),
            'GARANTIA' = fi_garantia,
            'CUPO' = monto,
            'MONTO VENCIDO' = fi_monto_vencido,
            'SALDO   ' = fi_cupo_usado,
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            'OBS VERIFICADO'= re_obs_verificado
          from   cl_referencia X,
                 cl_banco_rem,
                 cl_catalogo c,
                 cl_tabla d
          where  re_ente  = @i_ente
             and re_tipo  = c.codigo
             and c.tabla  = d.codigo
             and d.tabla  = 'cl_rtipo'
             and fi_banco = ba_banco
             and re_tipo  = 'F'
        end
      end -- Trn 180

      else
      begin
        -- Referencia Tarjeta
        if exists (select
                     *
                   from   cl_referencia
                   where  re_ente = @i_ente
                      and re_tipo = 'T')
        begin
          select
            'NUMERO' = re_referencia,
            'TIPO' = re_tipo,
            'DESC. TIPO ' = c.valor,
            'ENTIDAD' = ' ',
            'ENTIDAD FINANCIERA' = ' ',
            'CUENTA BANC.' = ' ',
            'TIPO CTA' = ' ',
            'DESC. TIPO Cta' = ' ',
            'TARJETA' = ta_banco,
            'NOMBRE DE LA TARJETA ' = substring(a.valor,
                                                1,
                                                30),
            'CLASE TARJETA' = ec_tipo_cta,
            'DESC. CLASE TARJETA' = c3.valor,
            'No. DE TARJETA' = ta_cuenta,
            'INSTITUCION' = ' ',
            'FECHA ING. EN INST.' = ' ',
            'MANEJO' = re_calificacion,
            'DESC. MANEJO' = (select
                                valor
                              from   cobis..cl_tabla t2,
                                     cobis..cl_catalogo c2
                              where  t2.tabla  = 'cl_posicion'
                                 and c2.tabla  = t2.codigo
                                 and c2.codigo = X.re_calificacion),
            'VERIF.' = re_verificacion,
            'VIGENCIA' = re_vigencia,
            'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
            'GARANTIA' = ' ',
            'CUPO        ' = monto,
            'MONTO VENCIDO' = ' ',
            'SALDO        ' = ' ',
            'CTA NACIONAL' = re_nacional,
            'SUCURSAL' = re_sucursal,
            'CIUDAD' = re_ciudad,
            'TELEFONO' = re_telefono,
            'ESTADO' = re_estado,
            'OBS VERIFICADO' = re_obs_verificado
          from   cl_referencia X,
                 cl_catalogo a,
                 cl_tabla b,
                 cl_catalogo c,
                 cl_tabla d,
                 cl_catalogo c3,
                 cl_tabla t3
          where  re_ente   = @i_ente
             and re_tipo   = c.codigo
             and c.tabla   = d.codigo
             and d.tabla   = 'cl_rtipo'
             and ta_banco  = a.codigo
             and a.tabla   = b.codigo
             and b.tabla   = 'cl_tarjeta'
             and re_tipo   = 'T'
             and t3.tabla  = 'cl_clase_tarjeta'
             and c3.tabla  = t3.codigo
             and c3.codigo = ec_tipo_cta

          -- Referencia Comercial
          if exists (select
                       1
                     from   cl_referencia
                     where  re_ente = @i_ente
                        and re_tipo = 'C')
          begin
            select
              'NUMERO' = re_referencia,
              'TIPO' = re_tipo,
              'DESC. TIPO ' = c.valor,
              'ENTIDAD' = ' ',
              'ENTIDAD FINANCIERA' = ' ',
              'CUENTA BANC.' = ' ',
              'TIPO CTA' = ' ',
              'DESC. TIPO CTA' = ' ',
              'TARJETA' = ' ',
              'NOMBRE DE LA  TARJETA ' = ' ',
              'CLASE TARJETA' = ' ',
              'DESC. CLASE TARJETA' = ' ',
              'No. DE TARJETA' = ' ',
              'INSTITUCION' = substring(co_institucion,
                                        1,
                                        30),
              'FECHA INg. EN INST.' = convert(char(10), co_fecha_ingr_en_inst,
                                      103
                                      ),
              'MANEJO' = re_calificacion,
              'DESC. MANEJO' = (select
                                  valor
                                from   cobis..cl_tabla t2,
                                       cobis..cl_catalogo c2
                                where  t2.tabla  = 'cl_posicion'
                                   and c2.tabla  = t2.codigo
                                   and c2.codigo = X.re_calificacion),
              'VERIF.' = re_verificacion,
              'VIGENCIA' = re_vigencia,
              'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
              'GARANTIA' = ' ',
              'CUPO USADO' = monto,
              'MONTO VENCIDO' = ' ',
              'SALDO        ' = ' ',
              'CTA NACIONAL' = re_nacional,
              'SUCURSAL' = re_sucursal,
              'CIUDAD' = re_ciudad,
              'TELEFONO' = re_telefono,
              'ESTADO' = re_estado,
              'OBS VERIFICADO' = re_obs_verificado
            from   cl_referencia X,
                   cl_catalogo c,
                   cl_tabla d
            where  re_ente = @i_ente
               and re_tipo = c.codigo
               and c.tabla = d.codigo
               and d.tabla = 'cl_rtipo'
               and re_tipo = 'C'
          end

          -- Referencia Financiera
          if exists (select
                       1
                     from   cl_referencia
                     where  re_ente = @i_ente
                        and re_tipo = 'F')
          begin
            select
              'NUMERO' = re_referencia,
              'TIPO' = re_tipo,
              'DESC. TIPO' = c.valor,
              'COD. ENTIDAD' = fi_banco,
              'ENTIDAD FINANCIERA' = substring(ba_descripcion,
                                               1,
                                               30),
              'CUENTA BANC' = ' ',
              'TIPO CTA. ' = ' ',
              'DESC. TIPO CTA.' = ' ',
              'TARJETA ' = ' ',
              'NOMBRE TARJETA ' = ' ',
              'CLASE TARJETA' = ' ',
              'DESC. CLASE TARJETA' = ' ',
              'No.  TARJETA' = ' ',
              'INSTITUCION' = ' ',
              'FEC ING. INST' = ' ',
              'MANEJO' = re_calificacion,
              'DESC. MANEJO' = (select
                                  valor
                                from   cobis..cl_tabla t2,
                                       cobis..cl_catalogo c2
                                where  t2.tabla  = 'cl_posicion'
                                   and c2.tabla  = t2.codigo
                                   and c2.codigo = X.re_calificacion),
              'VERIF.' = re_verificacion,
              'VIGENCIA' = re_vigencia,
              'FECHA Exp.' = convert(char(10), ec_fec_exp_ref, 103),
              'GARANTIA' = fi_garantia,
              'CUPO' = monto,
              'MONTO VENCIDO' = fi_monto_vencido,
              'SALDO   ' = fi_cupo_usado,
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              'OBS VERIFICADO'= re_obs_verificado
            from   cl_referencia X,
                   cl_banco_rem,
                   cl_catalogo c,
                   cl_tabla d
            where  re_ente  = @i_ente
               and re_tipo  = c.codigo
               and c.tabla  = d.codigo
               and d.tabla  = 'cl_rtipo'
               and fi_banco = ba_banco
               and re_tipo  = 'F'
          end
        end
        else
        begin
          if exists (select
                       1
                     from   cl_referencia
                     where  re_ente = @i_ente
                        and re_tipo = 'C')
          begin
            select
              'NUMERO' = re_referencia,
              'TIPO' = re_tipo,
              'DESC. TIPO ' = c.valor,
              'ENTIDAD' = ' ',
              'ENTIDAD FINANCIERA' = ' ',
              'CUENTA BANC.' = ' ',
              'TIPO CTA' = ' ',
              'DESC. TIPO CTA' = ' ',
              'FECHA APER' = ' ',
              'TARJETA' = ' ',
              'NOMBRE DE LA  TARJETA ' = ' ',
              'CLASE TARJETA' = ' ',
              'DESC. CLASE TARJETA' = ' ',
              'No. DE TARJETA' = ' ',
              'INSTITUCION' = substring(co_institucion,
                                        1,
                                        30),
              'FECHA ING. EN INST.' = convert(char(10), co_fecha_ingr_en_inst,
                                      103
                                      ),
              'MANEJO' = re_calificacion,
              'DESC. MANEJO' = (select
                                  valor
                                from   cobis..cl_tabla t2,
                                       cobis..cl_catalogo c2
                                where  t2.tabla  = 'cl_posicion'
                                   and c2.tabla  = t2.codigo
                                   and c2.codigo = X.re_calificacion),
              'VERIF.' = re_verificacion,
              'VIGENCIA' = re_vigencia,
              'FECHA EXPEDICION' = convert(char(10), ec_fec_exp_ref, 103),
              'GARANTIA' = ' ',
              'CUPO USADO' = monto,
              'MONTO VENCIDO' = ' ',
              'SALDO        ' = ' ',
              'CTA NACIONAL' = re_nacional,
              'SUCURSAL' = re_sucursal,
              'CIUDAD' = re_ciudad,
              'TELEFONO' = re_telefono,
              'ESTADO' = re_estado,
              'OBS VERIFICADO' = re_obs_verificado
            from   cl_referencia X,
                   cl_catalogo c,
                   cl_tabla d
            where  re_ente = @i_ente
               and re_tipo = c.codigo
               and c.tabla = d.codigo
               and d.tabla = 'cl_rtipo'
               and re_tipo = 'C'

            if exists (select
                         1
                       from   cl_referencia
                       where  re_ente = @i_ente
                          and re_tipo = 'F')
            begin
              select
                'NUMERO' = re_referencia,
                'TIPO' = re_tipo,
                'DESC. TIPO' = c.valor,
                'COD. ENTIDAD' = fi_banco,
                'ENTIDAD FINANCIERA' = substring(ba_descripcion,
                                                 1,
                                                 30),
                'CUENTA BANC' = ' ',
                'TIPO CTA. ' = ' ',
                'DESC. TIPO CTA.' = ' ',
                'FEC. VINCULACION' = ' ',
                'TARJETA ' = ' ',
                'NOMBRE TARJETA ' = ' ',
                'CLASE TARJETA' = ' ',
                'DESC. CLASE TARJETA' = ' ',
                'No.  TARJETA' = ' ',
                'INSTITUCION' = ' ',
                'FEC ING. INST' = ' ',
                'MANEJO' = re_calificacion,
                'DESC. MANEJO' = (select
                                    valor
                                  from   cobis..cl_tabla t2,
                                         cobis..cl_catalogo c2
                                  where  t2.tabla  = 'cl_posicion'
                                     and c2.tabla  = t2.codigo
                                     and c2.codigo = X.re_calificacion),
                'VERIF.' = re_verificacion,
                'VIGENCIA' = re_vigencia,
                'FECHA Exp.' = convert(char(10), ec_fec_exp_ref, 103),
                'GARANTIA' = fi_garantia,
                'CUPO' = monto,
                'MONTO VENCIDO' = fi_monto_vencido,
                'SALDO   ' = fi_cupo_usado,
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                'OBS VERIFICADO'= re_obs_verificado
              from   cl_referencia X,
                     cl_banco_rem,
                     cl_catalogo c,
                     cl_tabla d
              where  re_ente  = @i_ente
                 and re_tipo  = c.codigo
                 and c.tabla  = d.codigo
                 and d.tabla  = 'cl_rtipo'
                 and fi_banco = ba_banco
                 and re_tipo  = 'F'
            end
          end
          else
          begin
            if exists (select
                         1
                       from   cl_referencia
                       where  re_ente = @i_ente
                          and re_tipo = 'F')
            begin
              select
                'NUMERO' = re_referencia,
                'TIPO' = re_tipo,
                'DESC. TIPO' = c.valor,
                'COD. ENTIDAD' = fi_banco,
                'ENTIDAD FINANCIERA' = substring(ba_descripcion,
                                                 1,
                                                 30),
                'CUENTA BANC' = ' ',
                'TIPO CTA. ' = ' ',
                'DESC. TIPO CTA.' = ' ',
                'TARJETA ' = ' ',
                'NOMBRE TARJETA ' = ' ',
                'CLASE TARJETA' = ' ',
                'DESC. CLASE TARJETA'= ' ',
                'No.  TARJETA' = ' ',
                'INSTITUCION' = ' ',
                'FEC ING. INST' = ' ',
                'MANEJO' = re_calificacion,
                'DESC. MANEJO' = (select
                                    valor
                                  from   cobis..cl_tabla t2,
                                         cobis..cl_catalogo c2
                                  where  t2.tabla  = 'cl_posicion'
                                     and c2.tabla  = t2.codigo
                                     and c2.codigo = X.re_calificacion),
                'VERIF.' = re_verificacion,
                'VIGENCIA' = re_vigencia,
                'FECHA Exp.' = convert(char(10), ec_fec_exp_ref, 103),
                'GARANTIA' = fi_garantia,
                'CUPO' = monto,
                'MONTO VENCIDO' = fi_monto_vencido,
                'SALDO   ' = fi_cupo_usado,
                'OBS VERIFICADO' = re_obs_verificado
              from   cl_referencia X,
                     cl_banco_rem,
                     cl_catalogo c,
                     cl_tabla d
              where  re_ente  = @i_ente
                 and re_tipo  = c.codigo
                 and c.tabla  = d.codigo
                 and d.tabla  = 'cl_rtipo'
                 and fi_banco = ba_banco
                 and re_tipo  = 'F'
            end
          end

        end
      end
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
  end -- @i_operacion

go

