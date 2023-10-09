/************************************************************************/
/*      Archivo:                cl_val_doc.sp                           */
/*      Stored procedure:       sp_val_doc                              */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Diego Duran                             */
/*      Fecha de escritura:     08/02/05                                */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Valida en forma general un tipo de documento ingresado            */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      04/Abr/2005     D.DURAN            Emision Inicial              */
/*      09/Sep/2005     I.JIMENEZ       Validaciones de Documentos NUIP */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists(select
            *
          from   sysobjects
          where  name = 'sp_val_doc')
  drop proc sp_val_doc
go

create proc sp_val_doc
(
  @s_ssn              int = null,
  @s_user             login = null,
  @s_term             varchar(30) = null,
  @s_date             datetime = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_rol              smallint = null,
  @s_ofi              smallint = null,
  @s_org_err          char(1) = null,
  @s_error            int = null,
  @s_sev              tinyint = null,
  @s_msg              descripcion = null,
  @s_org              char(1) = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(10) = null,
  @t_from             varchar(32) = null,
  @t_trn              smallint = null,
  @t_show_version     bit = 0,
  @i_tipo_documento   char(2) = null,
  @i_numero_documento numero = null,
  @i_tipo_persona     char(1) = null,
  @i_sexo             char(1) = 'O',
  @i_emm_fecha_nacim  varchar(10) = null,
  @i_operacion        char(1) = null,
  @i_longitud         char(1) = null,
  @i_subtipo          char(1) = null,
  @i_fecha_exp        datetime = null,
  @i_fecha_nac        datetime = null,
  @i_signo            varchar(4) = null,
  @i_formato_nac      varchar(10) = null,
  @i_formato_fecha    int = null,
  @i_linea            char(1) = 'S',
  @i_tram_ext         char(1) = 'N',
  @o_mensaje          mensaje = null out,
  @o_retorno          int = null out
)
as
  declare
    @w_sp_name         varchar(32),
    @w_lon_documento   int,
    @w_longitud        int,
    @w_numerodoc       int,
    @w_caracter        varchar(16),
    @v_bucle           int,
    @v_retorno         char(1),
    @w_contador        int,
    @w_dianac          int,
    @w_mesnac          int,
    @w_annnac          int,
    @w_dia             int,
    @w_mes             int,
    @w_ann             int,
    @w_biciesto        int,
    @w_num_digito_doc  int,
    @w_num_min_digitos int,
    @w_anotarjeta      int,
    @w_anoactual       int,
    @w_valor           int,
    @w_nit             numero,
    @w_valida_nui_ct   char(1),
    @w_sexo_tipo       char(1),
    @w_rango_tipo      numero,
    @w_edad_exp        int,
    @w_formato         char(1),
    @w_rango_inclu     varchar(10),
    @w_cadena_dato     varchar(15),
    @w_tipo_dato       char(1),
    @w_longitud_unica  char(1),
    @w_valida_nit      char(1),
    @w_rango_nuip      numero,
    @w_fecha_exp       datetime,
    @w_val_fecha_exp   char(1),
    @w_sexo_i          char(1),
    @w_tipodoc_rango   char(1),
    @w_rango_ini       numero,
    @w_anios_e         int,
    @w_anios           int,
    @w_signo           varchar(4),
    @w_rango_fin       numero,
    @w_valor_exp       int,
    @w_campo_inc       char(1),
    @w_formato_f       varchar(8),
    @w_rango_inc       varchar(15),
    @w_registros       int,
    @w_revisa          int,
    @w_campo           int,
    @w_annacimiento    int,
    @w_rang_ini        int,
    @w_rang_fin        int,
    @w_return          int,
    @w_valida          int,
    @w_canios          varchar(20),
    @w_cvalor          varchar(20),
    @w_rini            int,
    @w_rfin            int,
    @w_valfor          varchar(6),
    @w_mensaje         mensaje,
    @w_fecha_nac1      varchar(10),
    @w_num_minimo      int,
    @w_num_maximo      int,
    @w_error           int,--I.Jimenez Sep/08/2005 NR 236
    @w_valida_nuip     char(1),--I.Jimenez Sep/08/2005 NR 236
    @w_nuevo_nuip      char(1),--I.Jimenez Sep/08/2005 NR 236
    @w_fecha_nuip      varchar(10),--I.Jimenez Sep/08/2005 NR 236
    @w_rango_ini_nuip  float --I.Jimenez Sep/08/2005 NR 236

  --ASIGNACIONES

  select
    @w_sp_name = 'sp_val_doc'
  --select @t_debug = 'N'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1116
  begin
    if @t_debug = 'S'
      print '01 sp_val_doc'

    select
      @w_sexo_tipo = ct_sexo,
      @w_val_fecha_exp = ct_valida_fecha_exp,-- S/N
      @w_edad_exp = ct_valor_exp,-- 7 A¥OS
      @w_formato = ct_campo_incluido,--AA/MM/DD
      @w_rango_inclu = ct_rango_campo_inclu,-- 0-6
      @w_cadena_dato = ct_valor_cade_campo_inclu,--
      @w_tipo_dato = ct_tipo_dato,-- N/A
      @w_longitud_unica = ct_longitud_unica,--V/U
      @w_valida_nit = ct_valida_nit,--S/N
      @w_rango_nuip = ct_rango_nui,
      @w_fecha_exp = ct_feccha_exp,
      @w_num_minimo = ct_num_dijitos_docu,
      @w_num_maximo = ct_num_dijitos_docu_max,
      @w_valida_nuip = ct_valida_nui
    from   cobis..cl_tipo_documento
    where  ct_codigo  = @i_tipo_documento
       and ct_subtipo = @i_subtipo
       and ct_estado  = 'V'

    select
      @w_nuevo_nuip = 'N'
    if @w_valida_nuip = 'S'
       and datediff(dd,
                    @w_fecha_exp,
                    @i_fecha_exp) >= 0
      select
        @w_nuevo_nuip = 'S'

    --SI ES VARIABLE
    if @w_longitud_unica = 'V'
    begin
      if datalength(@i_numero_documento) < @w_num_minimo
      begin
        select
          @w_mensaje = 'La Longitud del Documento es inferior al parametrizado'
        goto ERROR
      end
      if datalength(@i_numero_documento) > @w_num_maximo
      begin
        select
          @w_mensaje = 'La Longitud del Documento es superior al parametrizado'
        goto ERROR
      end
    end

    if @w_longitud_unica = 'U'
    begin
      if datalength(@i_numero_documento) <> @w_num_maximo
      begin
        select
          @w_mensaje = 'La Longitud del Documento No es Variable'
        goto ERROR
      end
    end

    --CONTROL DE LOS RANGOS
    select
      @w_registros = count(1)
    from   cobis..cl_rango_tipo_doc
    where  ct_codigo = @i_tipo_documento
       and ct_sexo   = @i_sexo

    if @t_debug = 'S'
      print '02 sp_val_doc'

    if @w_registros = 1
    begin
      select
        @w_rango_ini = ct_rango_ini,
        @w_rango_fin = ct_rango_fin
      from   cobis..cl_rango_tipo_doc
      where  ct_codigo = @i_tipo_documento
         and ct_sexo   = @i_sexo

      select
        @w_valida = 0
      if @w_valida_nuip = 'S'
         and @w_rango_nuip <> '0'
         and ((@w_nuevo_nuip = 'N'
               and convert(float, @w_rango_ini) >= convert(float, @w_rango_nuip)
              )
               or (@w_nuevo_nuip = 'S'
                   and convert(float, @w_rango_ini) <
                       convert(float, @w_rango_nuip))
             )
        select
          @w_valida = 1

      if @w_valida = 0
      begin
        if (convert(float, @i_numero_documento) < convert(float, @w_rango_ini))
            or (convert(float, @i_numero_documento) >
                convert(float, @w_rango_fin)
               )
        begin
          if @i_sexo <> 'O'
          begin
            select
              @w_mensaje = 'Rango No Corresponde al Sexo Especificado'
            goto ERROR
          end
          else
          begin
            select
              @w_mensaje = 'Rango No Corresponde al Documento Especificado'
            goto ERROR
          end
        end
      end
    --Fin    I.Jimenez Sep/08/2005 NR 236
    end

    if @w_registros > 1
    begin
      if @t_debug = 'S'
        print '03 sp_val_doc'

      select
        @w_revisa = 0

      declare cur_rango cursor for
        select
          ct_rango_ini,
          ct_rango_fin
        from   cobis..cl_rango_tipo_doc
        where  ct_codigo = @i_tipo_documento
           and ct_sexo   = @i_sexo

      open cur_rango

      fetch cur_rango into @w_rango_ini, @w_rango_fin

      while @@fetch_status <> -1
      begin
        if @t_debug = 'S'
          print '04 sp_val_doc'

        select
          @w_valida = 0
        if @w_valida_nuip = 'S'
           and @w_rango_nuip <> '0'
           and ((@w_nuevo_nuip = 'N'
                 and convert(float, @w_rango_ini) >=
                     convert(float, @w_rango_nuip)
                )
                 or (@w_nuevo_nuip = 'S'
                     and convert(float, @w_rango_ini) <
                         convert(float, @w_rango_nuip))
               )
          select
            @w_valida = 1

        if @w_valida = 0
        begin
          if (convert(float, @i_numero_documento)) >= (
             convert(float, @w_rango_ini))
             and (convert(float, @i_numero_documento)) <= (
                 convert(float, @w_rango_fin))
            select
              @w_revisa = 1
        end

        fetch cur_rango into @w_rango_ini, @w_rango_fin
      end

      close cur_rango
      deallocate cur_rango

      if @w_revisa = 0
      begin
        if @i_sexo <> 'O'
        begin
          select
            @w_mensaje = 'Rango No Corresponde al Sexo Especificado'
          goto ERROR
        end
        else
        begin
          select
            @w_mensaje = 'Rango No Corresponde al Documento Especificado'
          goto ERROR
        end
      end
    end

    if @t_debug = 'S'
      print '05 sp_val_doc'

    -- Req  353  Alianzas comerciales
    if @i_tram_ext = 'S'
    begin
      select
        @o_retorno = @w_error
      select
        @o_mensaje = @w_mensaje
      return 0
    end

    select
      @w_val_fecha_exp = ct_valida_fecha_exp,
      @w_valor_exp = ct_valor_exp,
      @w_campo_inc = ct_campo_incluido,
      @w_formato_f = ct_formato_fecha,
      @w_rango_inc = ct_rango_campo_inclu
    from   cobis..cl_tipo_documento
    where  ct_codigo  = @i_tipo_documento
       and ct_subtipo = @i_subtipo
       and ct_estado  = 'V' --I.Jimenez Sep/08/2005 NR 236

    if @w_val_fecha_exp = 'S'
       and @i_fecha_exp is not null
    begin
      select
        @w_anios_e = datediff(yy,
                              @i_fecha_nac,
                              @i_fecha_exp)

      if @w_anios_e < @w_valor_exp
      begin
        select
          @w_mensaje = 'La Fecha de Emisi¢n del Documento debe ser ' + char(13)
                       +
                              'M¡nimo de '
                       + convert(varchar, @w_valor_exp) + ' Anios'
        goto ERROR
      end
    end

    --VALIDAR SOLO SI EL FORMATO ES VALIDO SIN FECHA DE NACIMIENTO
    -- if @w_campo_inc = 'S' --I.Jimenez Sep/08/2005 NR 236
    if @w_campo_inc = 'S'
       and @w_nuevo_nuip = 'N' --I.Jimenez Sep/08/2005 NR 236
    begin
      select
        @w_rini = convert(int, substring(ct_rango_campo_inclu,
                                         1,
                                         (charindex(',',
                                                    ct_rango_campo_inclu) - 1)))
        ,
        @w_rfin = convert(int, substring(ct_rango_campo_inclu,
                                         (charindex(',', ct_rango_campo_inclu) +
                                          1
                               ),
                                         (datalength(ct_rango_campo_inclu) -
                                          charindex(',',
                                                    ct_rango_campo_inclu))))
      from   cobis..cl_tipo_documento
      where  ct_codigo = @i_tipo_documento
         and ct_estado = 'V' --I.Jimenez Sep/08/2005 NR 236

      --EXTRAER DEL NUMERO DEL DOCUMENTO LOS VALORES A VALIDAR
      select
        @w_valfor = substring(convert(varchar, @i_numero_documento),
                              @w_rini,
                              (@w_rfin - @w_rini) + 1)

      if @w_formato_f = 'AA/MM/DD'
        select
          @w_ann = convert(int, substring(@w_valfor,
                                          1,
                                          2)),
          @w_mes = convert(int, substring(@w_valfor,
                                          3,
                                          2)),
          @w_dia = convert(int, substring(@w_valfor,
                                          5,
                                          2))

      if @w_formato_f = 'MM/DD/AA'
        select
          @w_ann = convert(int, substring(@w_valfor,
                                          5,
                                          2)),
          @w_mes = convert(int, substring(@w_valfor,
                                          1,
                                          2)),
          @w_dia = convert(int, substring(@w_valfor,
                                          3,
                                          2))

      if @w_formato_f = 'DD/MM/AA'
        select
          @w_ann = convert(int, substring(@w_valfor,
                                          5,
                                          2)),
          @w_mes = convert(int, substring(@w_valfor,
                                          3,
                                          2)),
          @w_dia = convert(int, substring(@w_valfor,
                                          1,
                                          2))

      if (@w_mes < 1
           or @w_mes > 12)
          or (@w_dia < 1
               or @w_dia > 32)
      begin
        select
          @w_mensaje = 'Formato de fecha en Documento No Valido'
        goto ERROR
      end
    end

    -- FECHA DE NACIMIENTO

    if @i_fecha_nac is not null
    begin
      select
        @w_signo = ct_signo,
        @w_valor = ct_valor
      from   cobis..cl_fecha_tipo_doc
      where  ct_codigo = @i_tipo_documento

      if @@rowcount > 0
      begin
        select
          @w_canios = convert(varchar, abs(datediff(yy,
                                                    getdate(),
                                                    @i_fecha_nac)))
        select
          @w_cvalor = convert(varchar, @w_valor)

        exec @w_return = cob_credito..sp_comparador
          @i_modo         = 2,
          @i_valor_actual = @w_canios,
          @i_valor        = @w_cvalor,
          @i_operador     = @w_signo,
          @o_retorno      = @w_valida out

        if @w_valida = 0
        begin
          select
            @w_mensaje =
            'La Edad del Cliente no Concuerda con el Tipo de Documento'
          goto ERROR
        end

      end

      -- if @w_campo_inc = 'S' --I.Jimenez Sep/08/2005 NR 236
      if @w_campo_inc = 'S'
         and @w_nuevo_nuip = 'N' --I.Jimenez Sep/08/2005 NR 236
      begin
        select
          @w_rini = convert(int, substring(ct_rango_campo_inclu,
                                           1,
                                           (charindex(',',
                                                      ct_rango_campo_inclu) - 1)
                                 ))
          ,
          @w_rfin = convert(int, substring(ct_rango_campo_inclu,
                                           (charindex(',', ct_rango_campo_inclu)
                                            +
                                            1
                                 ),
                                           (datalength(ct_rango_campo_inclu) -
                                            charindex(',',
                                                      ct_rango_campo_inclu))))
        from   cobis..cl_tipo_documento
        where  ct_codigo = @i_tipo_documento

        --EXTRAER DEL NUMERO DEL DOCUMENTO LOS VALORES A VALIDAR
        select
          @w_valfor = substring(convert(varchar, @i_numero_documento),
                                @w_rini,
                                (@w_rfin - @w_rini) + 1)

        if @w_formato_f = 'AA/MM/DD'
          select
            @w_ann = convert(int, substring(@w_valfor,
                                            1,
                                            2)),
            @w_mes = convert(int, substring(@w_valfor,
                                            3,
                                            2)),
            @w_dia = convert(int, substring(@w_valfor,
                                            5,
                                            2))

        if @w_formato_f = 'MM/DD/AA'
          select
            @w_ann = convert(int, substring(@w_valfor,
                                            5,
                                            2)),
            @w_mes = convert(int, substring(@w_valfor,
                                            1,
                                            2)),
            @w_dia = convert(int, substring(@w_valfor,
                                            3,
                                            2))

        if @w_formato_f = 'DD/MM/AA'
          select
            @w_ann = convert(int, substring(@w_valfor,
                                            5,
                                            2)),
            @w_mes = convert(int, substring(@w_valfor,
                                            3,
                                            2)),
            @w_dia = convert(int, substring(@w_valfor,
                                            1,
                                            2))

        --EXTRAER DE LA FECHA LOS DATOS
        select
          @w_fecha_nac1 = convert(varchar, @i_fecha_nac, @i_formato_fecha)
        if @i_formato_nac = 'dd/mm/yyyy'
          select
            @w_annnac = convert(int, substring(@w_fecha_nac1,
                                               9,
                                               2)),
            @w_mesnac = convert(int, substring(@w_fecha_nac1,
                                               4,
                                               2)),
            @w_dianac = convert(int, substring(@w_fecha_nac1,
                                               1,
                                               2))

        if @i_formato_nac = 'mm/dd/yyyy'
          select
            @w_annnac = convert(int, substring(@w_fecha_nac1,
                                               9,
                                               2)),
            @w_mesnac = convert(int, substring(@w_fecha_nac1,
                                               1,
                                               2)),
            @w_dianac = convert(int, substring(@w_fecha_nac1,
                                               4,
                                               2))

        if @i_formato_nac = 'yyyy/dd/mm'
          select
            @w_annnac = convert(int, substring(@w_fecha_nac1,
                                               3,
                                               2)),
            @w_mesnac = convert(int, substring(@w_fecha_nac1,
                                               9,
                                               2)),
            @w_dianac = convert(int, substring(@w_fecha_nac1,
                                               6,
                                               2))

        if @i_formato_nac = 'yyyy/mm/dd'
          select
            @w_annnac = convert(int, substring(@w_fecha_nac1,
                                               3,
                                               2)),
            @w_mesnac = convert(int, substring(@w_fecha_nac1,
                                               6,
                                               2)),
            @w_dianac = convert(int, substring(@w_fecha_nac1,
                                               9,
                                               2))

        if @w_ann <> @w_annnac
            or @w_mes <> @w_mesnac
            or @w_dia <> @w_dianac
        begin
          select
            @w_mensaje = 'Formato de Fecha en Documento de Identidad' + char(13)
                         + 'No coincide con Fecha de Nacimiento'
          goto ERROR
        end

      end --@w_campo_inc = 'S'

    end --@i_fecha_nac is not null

    select
      @o_retorno = 0
  end -- del trn

  return 0

  ERROR:

  select
    @w_error = 101061 --     1           NIT o Documento de identidad duplicado

  if @i_tram_ext = 'S'
  begin
    select
      @o_retorno = @w_error
    select
      @o_mensaje = @w_mensaje
    return @w_error
  end

  if @i_linea = 'S'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_msg   = @w_mensaje
  end
  else
  begin
    select
      @o_retorno = @w_error
    select
      @o_mensaje = @w_mensaje
    select
      @o_retorno
    select
      @o_mensaje
  end

go

