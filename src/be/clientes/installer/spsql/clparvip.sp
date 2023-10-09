/************************************************************************/
/*  Archivo:            clparvip.sp                                     */
/*  Stored procedure:   sp_parametrizacion_cl_vip                       */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                           PROPOSITO                                  */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR                    RAZON                        */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go
if exists (select
             1
           from   cobis..sysobjects
           where  name = 'sp_parametrizacion_cl_vip')
  drop proc sp_parametrizacion_cl_vip
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO
create proc sp_parametrizacion_cl_vip
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
  @i_operacion      int = null,
  @i_oficina        smallint = null,
  @i_tipo_ofi       char(1) = null,
  @i_tipo           char(1),
  @i_modo           smallint = 0,
  @i_banca          varchar(64) = null,
  @i_tipo_emp       varchar(64) = null,
  @i_act_desde      money = null,
  @i_act_hasta      money = null,
  @i_banca_cat      varchar(64) = null,
  @i_ofi_cat        char(1) = null,
  @i_nro_pro_cat    smallint = null,
  @i_categorizacion varchar(24) = null,
  @i_empre_prod_cat varchar(24) = null,
  @i_prom_desde     money = null,
  @i_prom_hasta     money = null,
  @i_secuencial     int = 0,
  @i_sec_empresario int = null,
  @i_sec_banca      int = null,
  @i_cod_banca      char(10) = null,
  @o_nombre_ofi     varchar (64) = null out
)
as
  declare
    @w_today              datetime,
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_sig_oficina        smallint,
    @w_sig_empresario     smallint,
    @w_sig_categorizacion smallint,
    @w_oficina            smallint,
    @w_tipo_ofi           char(1),
    @v_oficina            smallint,
    @v_tipo_ofi           char(1),
    @w_banca              varchar(64),
    @w_tipo_emp           varchar(64),
    @w_act_desde          money,
    @w_act_hasta          money,
    @v_banca              varchar(64),
    @v_tipo_emp           varchar(64),
    @v_act_desde          money,
    @v_act_hasta          money,
    @w_banca_cat          varchar(64),
    @w_ofi_cat            char(1),
    @w_nro_pro_cat        smallint,
    @w_categorizacion     varchar(24),
    @w_empre_prod_cat     varchar(24),
    @w_prom_desde         money,
    @w_prom_hasta         money,
    @v_banca_cat          varchar(64),
    @v_ofi_cat            char(1),
    @v_nro_pro_cat        smallint,
    @v_categorizacion     varchar(24),
    @v_empre_prod_cat     varchar(24),
    @v_prom_desde         money,
    @v_prom_hasta         money,
    @w_cli_vip_A          varchar(64),--CAMBIO LNP Jun. 2005
    @w_cli_vip_B          varchar(64) --CAMBIO LNP Jun. 2005

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  select
    @w_sp_name = 'sp_parametrizacion_cl_vip'

  if @t_trn <> 1119
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 161500

    return 161500

  end

/*  Search  */
  /* Encontrar todas las relaciones definidas */

  if @i_tipo = 'O'
  begin
    select
      of_nombre
    from   cobis..cl_oficina,
           cobis..cl_parametrizacion_ofi
    where  cl_vip_oficina = of_oficina
       and cl_vip_oficina = @i_oficina

  end

  if @i_tipo = 'S'
  begin
    if @i_operacion = 1
    begin
      set rowcount 20

      select
        'OFICINA' = cl_vip_oficina,
        'NOMBRE' = of_nombre,
        'TIPO' = cl_vip_linea
      from   cobis..cl_parametrizacion_ofi,
             cobis..cl_oficina
      where  cl_vip_oficina = of_oficina
         and cl_vip_oficina > @i_secuencial
      order  by cl_vip_oficina

      set rowcount 0

    end

    else if @i_operacion = 2
    begin
      set rowcount 20

      select
        'SEC' = cl_vip_sec,
        'NOMBRE' = cl_vip_banca_emp,
        'TIPO EMPRESARIO' = cl_vip_tipo_emp,
        'DESDE' = cl_vip_act_desde,
        'HASTA' = cl_vip_act_hasta
      from   cobis..cl_vip_tipo_empresario
      where  cl_vip_sec > @i_secuencial
      order  by cl_vip_sec

      set rowcount 0

    end

    else if @i_operacion = 3
    begin
      set rowcount 20

      select
        'SEC' = cl_vip_sec,
        'TIPO DE BANCA' = cl_vip_banca_cat,
        'TIPO DE OFICINA' = cl_vip_ofi_linea_cat,
        'No. DE PRODUCTOS' = cl_vip_nro_pro_cat,
        'TIPO CATEGORIA' = cl_vip_categorizacion,
        'EMPRESARIO/PRODUCTOR' = cl_vip_empre_productor_cat,
        'DESDE' = cl_vip_promedios_desde,
        'HASTA' = cl_vip_promedios_hasta
      from   cobis..cl_vip_categorizacion
      where  cl_vip_sec > @i_secuencial
      order  by cl_vip_sec

      set rowcount 0

    end

    else if @i_operacion = 4
    begin
      set rowcount 20

      begin
        select
          'BANCA' = a.codigo,
          'NOMBRE' = a.valor
        from   cobis..cl_catalogo a,
               cobis..cl_tabla b
        where  b.tabla  = 'cl_banca_cliente'
           and a.codigo = '2'
           and b.codigo = a.tabla

      end

      set rowcount 0

    end

    else if @i_operacion = 5
    begin
      set rowcount 20

      select
        'BANCA' = a.codigo,
        'NOMBRE' = a.valor
      from   cobis..cl_catalogo a,
             cobis..cl_tabla b
      where  b.tabla  = 'cl_banca_cliente'
         and b.codigo = a.tabla

      set rowcount 0

    end

  end --Fin Búsquedas

  if @i_tipo = 'Q'
  begin
    if @i_operacion = 1
    begin
      select
        cl_vip_oficina,
        of_nombre,
        cl_vip_linea
      from   cobis..cl_parametrizacion_ofi,
             cobis..cl_oficina
      where  cl_vip_oficina = @i_oficina
         and cl_vip_oficina = of_oficina

      if @@rowcount = 0
      begin
        /*  No existe oficina  */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101001

      end

      return 0

    end

    else if @i_operacion = 2
    begin
      select
        cl_vip_sec,
        cl_vip_banca_emp,
        cl_vip_tipo_emp,
        cl_vip_act_desde,
        cl_vip_act_hasta
      from   cobis..cl_vip_tipo_empresario
      where  cl_vip_sec = @i_sec_empresario
      if @@rowcount = 0
      begin
        /*  No existe Tipo de empresario  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101001

      end

      return 0

    end

    else if @i_operacion = 3
    begin
      select
        cl_vip_sec,
        cl_vip_banca_cat,
        cl_vip_ofi_linea_cat,
        cl_vip_nro_pro_cat,
        cl_vip_categorizacion,
        cl_vip_empre_productor_cat,
        cl_vip_promedios_desde,
        cl_vip_promedios_hasta
      from   cobis..cl_vip_categorizacion
      where  cl_vip_sec = @i_sec_banca

      if @@rowcount = 0
      begin
        /*  No existe tipo de categorizacion  */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101001

      end

      return 0

    end

  end --fin Tipo Q

  if @i_tipo = 'I'
  begin
    if @i_operacion = 1
    begin
      begin tran

      /* obtener un secuencial para la nueva oficina */

      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_parametrizacion_ofi',
        @o_siguiente = @w_sig_oficina out

      /* Verificar que no exista oficina */

      if exists (select
                   1
                 from   cl_parametrizacion_ofi
                 where  cl_vip_oficina = @i_oficina)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 169999,
          @i_msg   = 'YA EXISTE EL REGISTRO A INSERTAR'

        return 1

      end

      /* insertar la nueva oficina */

      insert into cobis..cl_parametrizacion_ofi
                  (cl_vip_sec,cl_vip_oficina,cl_vip_linea)
      values      (@w_sig_oficina,@i_oficina,@i_tipo_ofi)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        /*  Error en creacion */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 15100020 /*CREACION DE ERROR PARA INSERCIÓN DE OFICINA*/

        return 1

      end

      commit tran

      select
        @w_sig_oficina

      return 0

    end

    else if @i_operacion = 2
    begin
      begin tran

      /* obtener un secuencial para el nuevo tipo de empresario */

      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_vip_tipo_empresario',
        @o_siguiente = @w_sig_empresario out
      if exists (select
                   1
                 from   cl_vip_tipo_empresario
                 where  cl_vip_tipo_emp = @i_tipo_emp)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 169999,
          @i_msg   = 'YA EXISTE EL REGISTRO A INSERTAR'

        return 1

      end

      /* insertar el nuevo tipo de empresario */

      insert into cobis..cl_vip_tipo_empresario
                  (cl_vip_sec,cl_vip_banca_emp,cl_vip_tipo_emp,cl_vip_act_desde,
                   cl_vip_act_hasta)
      values      (@w_sig_empresario,@i_banca,@i_tipo_emp,@i_act_desde,
                   @i_act_hasta)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        /*  Error en creacion */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 15100021
        /*CREACION DE ERROR PARA INSERCIÓN DE TIPO DE EMPRESARIO*/

        return 1

      end

      commit tran

      select
        @w_sig_empresario

      return 0

    end

    else if @i_operacion = 3
    begin
      begin tran

      /* obtener un secuencial para la nueva categorización */

      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_vip_categorizacion',
        @o_siguiente = @w_sig_categorizacion out

      if exists (select
                   1
                 from   cl_vip_categorizacion
                 where  cl_vip_banca_cat           = @i_banca_cat
                    and cl_vip_ofi_linea_cat       = @i_ofi_cat
                    and cl_vip_categorizacion      = @i_categorizacion
                    and cl_vip_empre_productor_cat = @i_empre_prod_cat)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 169999,
          @i_msg   = 'YA EXISTE EL REGISTRO A INSERTAR'

        return 1

      end

      /* insertar la nueva categorización */

      insert into cobis..cl_vip_categorizacion
                  (cl_vip_sec,cl_vip_banca_cat,cl_vip_ofi_linea_cat,
                   cl_vip_nro_pro_cat,
                   cl_vip_categorizacion,
                   cl_vip_empre_productor_cat,cl_vip_promedios_desde,
                   cl_vip_promedios_hasta)
      values      (@w_sig_categorizacion,@i_banca_cat,@i_ofi_cat,@i_nro_pro_cat,
                   @i_categorizacion,
                   @i_empre_prod_cat,@i_prom_desde,@i_prom_hasta)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        /*  Error en creacion */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 15100022
        /*CREACION DE ERROR PARA INSERCIÓN DE TIPO DE CATEGORIZACIÓN*/

        return 1

      end

      commit tran

      select
        @w_sig_categorizacion

      return 0

    end

  end --Fin tipo 'I'

  if @i_tipo = 'U'
  begin
    if @i_operacion = 1
    begin
      /* Verificar que exista la oficina */

      select
        @w_oficina = cl_vip_oficina,
        @w_tipo_ofi = cl_vip_linea
      from   cl_parametrizacion_ofi
      where  cl_vip_oficina = @i_oficina

      /* si no existe la oficina, error */

      if @@rowcount = 0
      begin
        /*  No existe oficina  */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 141035

        return 1

      end

      begin
        /* modificar los datos */

        update cl_parametrizacion_ofi
        set    cl_vip_oficina = @i_oficina,
               cl_vip_linea = @i_tipo_ofi
        where  cl_vip_oficina = @i_oficina

        /* si no se puede modificar, error */

        if @@rowcount = 0
        begin
          /*  Error en actualizacion de oficina  */

          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 105049

          return 1

        end

      end

      return 0

    end

    if @i_operacion = 2
    begin
      /* Verificar que exista el tipo de empresario */

      select
        @w_banca = cl_vip_banca_emp,
        @w_tipo_emp = cl_vip_tipo_emp,
        @w_act_desde = cl_vip_act_desde,
        @w_act_hasta = cl_vip_act_hasta
      from   cobis..cl_vip_tipo_empresario
      where  cl_vip_tipo_emp = @i_tipo_emp

      --cl_vip_sec = @i_sec_empresario

      /* si no existe el tipo de empresario, error */

      if @@rowcount = 0
      begin
        /*  No existe el tipo de empresario  */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101001

        return 1

      end

      begin
        /* modificar los datos */

        update cl_vip_tipo_empresario
        set    cl_vip_banca_emp = @i_banca,
               cl_vip_tipo_emp = @i_tipo_emp,
               cl_vip_act_desde = @i_act_desde,
               cl_vip_act_hasta = @i_act_hasta
        where  cl_vip_tipo_emp = @i_tipo_emp

        --cl_vip_sec = @i_sec_empresario

        /* si no se puede modificar, error */

        if @@rowcount = 0
        begin
          /*  Error en actualizacion de tipo de empresario*/

          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 15100023

          return 1

        end

      end

      return 0

    end

    if @i_operacion = 3
    begin
      /* Verificar que exista la categorización */

      select
        @w_banca_cat = cl_vip_banca_cat,
        @w_ofi_cat = cl_vip_ofi_linea_cat,
        @w_nro_pro_cat = cl_vip_nro_pro_cat,
        @w_categorizacion = cl_vip_categorizacion,
        @w_empre_prod_cat = cl_vip_empre_productor_cat,
        @w_prom_desde = cl_vip_promedios_desde,
        @w_prom_hasta = cl_vip_promedios_hasta
      from   cobis..cl_vip_categorizacion
      where  cl_vip_banca_cat           = @i_banca_cat
         and cl_vip_ofi_linea_cat       = @i_ofi_cat
         and cl_vip_categorizacion      = @i_categorizacion
         and cl_vip_empre_productor_cat = @i_empre_prod_cat

      /* si no existe la categorización, error */

      if @@rowcount = 0
      begin
        /*  No existe la categorización */

        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101001

        return 1

      end

      begin
        /* modificar los datos */

        update cl_vip_categorizacion
        set    cl_vip_banca_cat = @i_banca_cat,
               cl_vip_ofi_linea_cat = @i_ofi_cat,
               cl_vip_nro_pro_cat = @i_nro_pro_cat,
               cl_vip_categorizacion = @i_categorizacion,
               cl_vip_empre_productor_cat = @i_empre_prod_cat,
               cl_vip_promedios_desde = @i_prom_desde,
               cl_vip_promedios_hasta = @i_prom_hasta
        where  cl_vip_banca_cat           = @i_banca_cat
           and cl_vip_ofi_linea_cat       = @i_ofi_cat
           and cl_vip_categorizacion      = @i_categorizacion
           and cl_vip_empre_productor_cat = @i_empre_prod_cat

        --cl_vip_sec = @i_sec_banca

        /* si no se puede modificar, error */

        if @@rowcount = 0
        begin
          /*  Error en actualizacion de banca*/

          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 15100024

          return 1

        end
      end
      return 0
    end
  end --Fin Tipo U

  if @i_tipo = 'D'
  begin
    if @i_operacion = 1
    begin
      delete cl_parametrizacion_ofi
      where  cl_vip_oficina = @i_oficina
    end

    if @i_operacion = 2
    begin
      delete cl_vip_tipo_empresario
      where  cl_vip_sec = @i_sec_empresario
    end

    if @i_operacion = 3
    begin
      delete cl_vip_categorizacion
      where  cl_vip_sec = @i_sec_banca
    end
  end --Fin Tipo D
  return 0

go

