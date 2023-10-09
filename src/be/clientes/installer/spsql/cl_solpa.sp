/************************************************************************/
/*   Archivo             :     cl_solpa.sp                              */
/*   Stored procedure    :     sp_parametriza_sol                       */
/*   Base de datos       :     cobis                                    */
/*   Producto            :     Clientes                                 */
/*   Disenado por        :     Mauricio Rincon Romero                   */
/*   Fecha de escritura  :     08-Junio-2006                            */
/************************************************************************/
/*                         IMPORTANTE                                   */
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
/*                  PROPOSITO                                           */
/*   Este programa actualiza las tablas cl_param_sol y cl_def_grupo     */
/*   correspondientes a parametrizacion formato Solicitud Productos     */
/************************************************************************/
/*                  MODIFICACIONES                          */
/*   FECHA          AUTOR               RAZON                   */
/*   08/Jun/2006    Mauricio Rincon R.  Emision Inicial         */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_parametriza_sol')
  drop proc sp_parametriza_sol
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_parametriza_sol
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_sesn         int = null,
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
  @t_trn          int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_empresa      tinyint = null,
  @i_modo         tinyint = null,
  @i_operacion    char(1) = null,
  @i_grupo        varchar(14) = null,
  @i_estado_g     char(1) = null,
  @i_posicion     int = null,
  @i_tabla        varchar(30) = null,
  @i_campo        varchar(64) = null,
  @i_opcion       char(1) = null,
  @i_etiqueta     varchar(255) = null,
  @i_estado       char(1) = null,
  @i_catalogo     varchar(30) = null,
  @i_origen       varchar(14) = null,
  @i_llave        varchar(124) = null,
  @i_fpresenta    char(1) = 'V',
  @i_llave_ing    varchar(30) = null,
  @i_ente         int = 0,
  @i_registros    int = 15
)
as
  declare
    @w_sp_name   varchar(32),
    @w_tip_param char(1),
    @w_rowcount  int,
    @w_contador  int,
    @w_grupos    int,
    @w_campos    int,
    @w_cadena    varchar(2200),
    @w_cadena0   varchar(2200),
    @w_cadena1   varchar(1024),
    @w_cadena2   varchar(1024),
    @w_grupo     char(10),
    @w_tabla     char(30),
    @w_campo     varchar(64),
    @w_posicion  int,
    @w_etiqueta  varchar(255),
    @w_catalogo  varchar(30),
    @w_fpresenta char(1),
    @w_llave_ing varchar(30),
    @w_tabla0    char(30),
    @w_campo0    varchar(64),
    @w_posicion0 int,
    @w_etiqueta0 varchar(255),
    @w_catalogo0 varchar(30),
    @w_origen0   varchar(255),
    @w_tabla1    char(30),
    @w_campo1    varchar(64),
    @w_posicion1 int,
    @w_etiqueta1 varchar(255),
    @w_catalogo1 varchar(30),
    @w_origen1   varchar(255),
    @w_cont_prod int

  select
    @w_sp_name = 'sp_parametriza_sol'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if (@t_trn <> 162
      and @i_operacion = 'E')
      or (@t_trn <> 162
          and @i_operacion = 'G')
      or (@t_trn <> 162
          and @i_operacion = 'S')
      or (@t_trn <> 162
          and @i_operacion = 'Q')
      or (@t_trn <> 163
          and @i_operacion = 'P')
      or (@t_trn <> 164
          and @i_operacion = 'T')
      or (@t_trn <> 164
          and @i_operacion = 'F')
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2805023
    return 1
  end

  if @i_modo = 0
  begin
    set rowcount 20
    if @i_operacion = 'S'
    begin
      if @i_opcion = 'A'
        select
          'GRUPO' = ps_grupo,
          'TABLA' = ps_tabla,
          'CAMPO' = ps_campo,
          'ETIQUETA' = ps_etiqueta,
          'POSICION' = ps_posicion,
          'ESTADO' = ps_estado,
          'CATALOGO' = ps_catalogo,
          'ORIGEN' = ps_origen,
          'LLAVE' = ps_grupo + ps_tabla + ps_campo
        from   cobis..cl_param_sol
        order  by ps_grupo + ps_tabla + ps_campo

      if @i_opcion = 'G'
        select
          'GRUPO' = ps_grupo,
          'TABLA' = ps_tabla,
          'CAMPO' = ps_campo,
          'ETIQUETA' = ps_etiqueta,
          'POSICION' = ps_posicion,
          'ESTADO' = ps_estado,
          'CATALOGO' = ps_catalogo,
          'LLAVE' = ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo = @i_grupo
        order  by ps_tabla + ps_campo

      if @i_opcion = 'S'
        select
          'GRUPO' = ps_grupo,
          'TABLA' = ps_tabla,
          'CAMPO' = ps_campo,
          'ETIQUETA' = ps_etiqueta,
          'POSICION' = ps_posicion,
          'ESTADO' = ps_estado,
          'CATALOGO' = ps_catalogo,
          'ORIGEN' = ps_origen,
          'LLAVE' = ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo  = @i_grupo
           and ps_estado = 'V'
        order  by ps_posicion

      if @i_opcion = 'N'
        select
          'GRUPO' = ps_grupo,
          'TABLA' = ps_tabla,
          'CAMPO' = ps_campo,
          'ETIQUETA' = ps_etiqueta,
          'POSICION' = ps_posicion,
          'ESTADO' = ps_estado,
          'CATALOGO' = ps_catalogo,
          'ORIGEN' = ps_origen,
          'LLAVE' = ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo  = @i_grupo
           and ps_estado <> 'V'
        order  by ps_grupo,
                  ps_tabla + ps_campo
    end

    if @i_operacion = 'G'
    begin
      if @i_opcion = 'S'
      begin
        select
          'GRUPO' = dg_grupo,
          'ESTADO' = dg_estado,
          'POSICION' = dg_posicion,
          'F.PRESENTA'= dg_fpresenta,
          'LLAVE ING' = dg_llave_ing,
          'DESCRIPCION' = valor
        from   cobis..cl_def_grupo,
               cobis..cl_tabla a,
               cobis..cl_catalogo b
        where  a.codigo = b.tabla
           and a.tabla  = 'cl_grupos_datos'
           and b.codigo = dg_grupo
        order  by dg_posicion
      end
      if @i_opcion = 'U'
      begin
        select
          @w_rowcount = count(0)
        from   cl_def_grupo
        where  dg_grupo = @i_grupo
        if @w_rowcount = 0
        begin
          if @i_posicion > 20
          begin
            print 'Posicion para impresion invalida (Maxima Permitida 20)'
            return 1
          end
          select
            @w_rowcount = count(0)
          from   cl_def_grupo
          where  dg_posicion = @i_posicion
          if @w_rowcount = 0
          begin
            insert cl_def_grupo
            values (@i_grupo,@i_estado_g,@i_posicion,@i_fpresenta,@i_llave_ing)
          end
          else
          begin
            print 'Posicion para impresion ocupada por otro grupo'
            return 1
          end
        end
        else
        begin
          select
            @w_contador = count(0)
          from   cl_def_grupo
          if @w_contador = 0
            select
              @w_contador = 1
          if @i_posicion > @w_contador
          begin
            print 'Posicion para imprimir invalida - Maxima Permitida ' +
                  @w_contador
            return 1
          end
          select
            @w_rowcount = count(0)
          from   cl_def_grupo
          where  dg_posicion = @i_posicion
             and dg_grupo    <> @i_grupo
          if @w_rowcount = 0
          begin
            update cl_def_grupo
            set    dg_posicion = @i_posicion,
                   dg_estado = @i_estado_g,
                   dg_fpresenta = @i_fpresenta,
                   dg_llave_ing = @i_llave_ing
            where  dg_grupo = @i_grupo
          end
          else
          begin
            print 'Posicion para impresion ocupada por otro grupo'
            return 1
          end
        end
      end
    end
    if @i_operacion = 'E'
    begin
      select
        dg_grupo,
        valor,
        dg_estado,
        dg_posicion,
        dg_fpresenta,
        dg_llave_ing
      from   cobis..cl_def_grupo,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  dg_grupo = 'DIRECCION'
         and a.codigo = b.tabla
         and a.tabla  = 'cl_grupos_datos'
         and b.codigo = dg_grupo
         and dg_grupo = @i_grupo
    end

    if @i_operacion = 'Q'
    begin
      set rowcount 20
      select
        'GRUPO' = b.codigo,
        'DESCRIPCION GRUPO' = b.valor
      from   cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  a.codigo = b.tabla
         and a.tabla  = 'cl_grupos_datos'
      set rowcount 20
    end

    if @i_operacion = 'P'
    begin
      if @i_opcion = 'U'
      begin
        select
          @w_rowcount = count(0)
        from   cl_param_sol
        where  ps_grupo = @i_grupo
        if ((@i_posicion > 0)
            and (@i_posicion > @w_rowcount))
        begin
          print 'Posicion para impresion invalida - Maxima Permitida  ' +
                @w_rowcount
          return 1
        end
        if @i_posicion > 0
        begin
          select
            @w_rowcount = count(0)
          from   cl_param_sol
          where  ps_grupo    = @i_grupo
             and ps_campo    <> @i_campo
             and ps_posicion = @i_posicion
          if @w_rowcount > 0
          begin
            print 'Posicion para impresion ocupada por otro campo'
            return 1
          end
        end

        update cobis..cl_param_sol
        set    ps_etiqueta = @i_etiqueta,
               ps_posicion = @i_posicion,
               ps_estado = @i_estado,
               ps_catalogo = @i_catalogo,
               ps_origen = @i_origen
        where  ps_grupo = @i_grupo
           and ps_tabla = @i_tabla
           and ps_campo = @i_campo

        update cobis..cl_param_sol
        set    ps_posicion = null,
               ps_estado = 'B'
        where  ps_grupo = @i_grupo
           and ps_tabla = @i_tabla
           and ps_campo = @i_campo
           and ps_posicion is null
      end
    end
  end

  if @i_modo = 1
  begin
    set rowcount 20
    if @i_operacion = 'S'
    begin
      if @i_opcion = 'A'
        select
          ps_grupo,
          ps_tabla,
          ps_campo,
          ps_etiqueta,
          ps_posicion,
          ps_estado,
          ps_catalogo,
          ps_origen,
          ps_grupo + ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo + ps_tabla + ps_campo > @i_llave
        order  by ps_grupo,
                  ps_tabla + ps_campo

      if @i_opcion = 'G'
        select
          ps_grupo,
          ps_tabla,
          ps_campo,
          ps_etiqueta,
          ps_posicion,
          ps_estado,
          ps_catalogo,
          ps_origen,
          ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo            = @i_grupo
           and ps_tabla + ps_campo > @i_llave
        order  by ps_tabla + ps_campo

      if @i_opcion = 'S'
        select
          ps_grupo,
          ps_tabla,
          ps_campo,
          ps_etiqueta,
          ps_posicion,
          ps_estado,
          ps_catalogo,
          ps_origen,
          ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo    = @i_grupo
           and ps_estado   = 'V'
           and ps_posicion > @i_posicion
        order  by ps_posicion

      if @i_opcion = 'N'
        select
          ps_grupo,
          ps_tabla,
          ps_campo,
          ps_etiqueta,
          ps_posicion,
          ps_estado,
          ps_catalogo,
          ps_origen,
          ps_tabla + ps_campo
        from   cobis..cl_param_sol
        where  ps_grupo            = @i_grupo
           and ps_estado           <> 'V'
           and ps_tabla + ps_campo > @i_llave
        order  by ps_tabla + ps_campo
    end
    set rowcount 0
  end

  if @i_modo = 3
  begin
    if (@i_operacion = 'T')
    begin
      select
        dg_grupo,
        dg_posicion,
        count(0),
        (count(0) / @i_registros) + 1,
        dg_fpresenta
      from   cl_def_grupo,
             cl_param_sol
      where  dg_grupo  = ps_grupo
         and ps_estado = 'V'
      group  by dg_grupo,
                dg_posicion,
                dg_fpresenta
      order  by dg_grupo

      select
        dg_grupo,
        @i_registros,
        (count(0) / @i_registros) + 1
      from   cl_def_grupo,
             cl_param_sol
      where  dg_grupo  = ps_grupo
         and ps_estado = 'V'
         and ps_grupo  = '001'
      group  by dg_grupo
      select
        count(distinct(dg_grupo))
      from   cl_def_grupo,
             cl_param_sol
      where  dg_grupo  = ps_grupo
         and ps_estado = 'V'
      select
        ltrim(rtrim(p_p_apellido)) + ' ' + ltrim(rtrim(p_s_apellido)) + ' '
        + ltrim(rtrim(en_nombre)),
        en_tipo_ced,
        en_ced_ruc
      from   cobis..cl_ente
      where  en_ente = @i_ente

      set rowcount 1
      select
        of_origen_fondos
      from   cobis..cl_origen_fondos a
      where  a.of_ente           = @i_ente
         and a.of_fecha_registro = (select
                                      max(of_fecha_registro)
                                    from   cobis..cl_origen_fondos
                                    where  of_ente = @i_ente)
         and a.of_origen_fondos is not null
      set rowcount 0

      create table #sl_productos
      (
        pr_descripcion varchar(255) not null,
        pr_producto    char(25) null,
        pr_fecha_aper  datetime null,
        pr_estado      char(10) null
      )

      select
        @w_cont_prod = 0
      select
        @w_cont_prod = count(0)
      from   cob_ahorros..ah_cuenta
      where  ah_cliente   = @i_ente
         and ah_estado    != 'C'
         and ah_prod_banc = 2

      if @w_cont_prod > 0
      begin
        insert into #sl_productos
          select
            'Cuenta Ahorro Tradicional',ah_cta_banco,ah_fecha_aper,ah_estado
          from   cob_ahorros..ah_cuenta
          where  ah_cliente   = @i_ente
             and ah_estado    != 'C'
             and ah_prod_banc = 2
          order  by ah_cta_banco
      end
      else
      begin
        insert into #sl_productos
        values      ('Cuenta Ahorro Tradicional',null,null,null)
      end

      select
        @w_cont_prod = 0
      select
        @w_cont_prod = count(0)
      from   cob_ahorros..ah_cuenta
      where  ah_cliente   = @i_ente
         and ah_estado    != 'C'
         and ah_prod_banc = 3

      if @w_cont_prod > 0
      begin
        insert into #sl_productos
          select
            'Cuenta Ahorro Activo',ah_cta_banco,ah_fecha_aper,ah_estado
          from   cob_ahorros..ah_cuenta
          where  ah_cliente   = @i_ente
             and ah_estado    != 'C'
             and ah_prod_banc = 3
          order  by ah_cta_banco
      end
      else
      begin
        insert into #sl_productos
        values      ('Cuenta Ahorro Activo',null,null,null)
      end

      select
        @w_cont_prod = 0
      select
        @w_cont_prod = count(0)
      from   cob_cuentas..cc_ctacte
      where  cc_cliente = @i_ente
         and cc_estado  != 'C'
         and cc_estado  != 'G'

      if @w_cont_prod > 0
      begin
        insert into #sl_productos
          select
            'Cuenta Corriente',cc_cta_banco,cc_fecha_aper,cc_estado
          from   cob_cuentas..cc_ctacte
          where  cc_cliente = @i_ente
             and cc_estado  != 'C'
             and cc_estado  != 'G'
          order  by cc_cta_banco
      end
      else
      begin
        insert into #sl_productos
        values      ('Cuenta Corriente',null,null,null)
      end

    /*
           select @w_cont_prod = 0
           select @w_cont_prod = count(0)
           from cob_pfijo..pf_operacion
           where op_ente = @i_ente
           and op_toperacion like 'CDT%'
           and (op_estado like 'ACT%' or op_estado like 'VEN%')
    
           if @w_cont_prod > 0
           begin
              insert into #sl_productos
              select 'CDT',op_num_banco,op_fecha_crea,op_estado
              from cob_pfijo..pf_operacion
              where op_ente = @i_ente
              and op_toperacion like 'CDT%'
              and (op_estado like 'ACT%' or op_estado like 'VEN%')
              order by op_num_banco
           end
           else
           begin
              insert into #sl_productos values ('CDT',null,null,null)
           end
    
           select @w_cont_prod = 0
           select @w_cont_prod = count(0)
           from cob_pfijo..pf_operacion
           where op_ente = @i_ente
           and op_toperacion like 'CDAT%'
           and (op_estado like 'ACT%' or op_estado like 'VEN%')
    
           if @w_cont_prod > 0
           begin
              insert into #sl_productos
              select 'CDAT',op_num_banco,op_fecha_crea,op_estado
              from cob_pfijo..pf_operacion
              where op_ente = @i_ente
              and op_toperacion like 'CDAT%'
              and (op_estado like 'ACT%' or op_estado like 'VEN%')
              order by op_ente,op_num_banco
           end
           else
           begin
              insert into #sl_productos values ('CDAT',null,null,null)
           end
           select 'Producto'=pr_descripcion,'No. Producto'=pr_producto,'Fecha Apertura'=convert(varchar(10),pr_fecha_aper,103) from #sl_productos
    
    */

    end

    if (@i_operacion = 'F')
    begin
      declare grupo cursor for
        select
          dg_grupo,
          dg_fpresenta,
          dg_llave_ing
        from   cobis..cl_def_grupo
        where  dg_estado   = 'V'
           and dg_posicion > 0
        order  by dg_posicion
      open grupo
      fetch grupo into @w_grupo, @w_fpresenta, @w_llave_ing

      if @@fetch_status = -2
      begin /* Error en la base */
        return 1
      end
      else
      begin
        while (@@fetch_status != -1)
        begin -- while
          if @@fetch_status = -2
          begin /* Error en la base */
            return 1
          end
          if @w_grupo is not null
          begin
          /*******************************/
          /* Retorno Campos Otros Grupos */
            /*******************************/
            if @w_fpresenta = 'V'
            begin
              select
                @w_campos = count(0)
              from   cobis..cl_param_sol
              where  ps_grupo    = @w_grupo
                 and ps_estado   = 'V'
                 and ps_posicion > 0
              if @w_campos > 0
              begin
                select
                  @w_cadena = 'select '
                select
                  @w_contador = 0

                declare parametrizacion cursor for
                  select
                    ps_tabla,
                    ps_campo,
                    ps_posicion,
                    ps_etiqueta,
                    ps_catalogo,
                    ps_origen
                  from   cobis..cl_param_sol
                  where  ps_grupo    = @w_grupo
                     and ps_estado   = 'V'
                     and ps_posicion > 0
                  order  by ps_posicion

                open parametrizacion
                fetch parametrizacion into @w_tabla0,
                                           @w_campo0,
                                           @w_posicion0,
                                           @w_etiqueta0,
                                           @w_catalogo0,
                                           @w_origen0

                if @@fetch_status = -2
                begin /* error en la base */
                  return 1
                end
                else
                begin
                  while (@@fetch_status != -1)
                  begin -- while
                    if @@fetch_status = -2
                    begin /* error en la base */
                      return 1
                    end

                    select
                      @w_contador = @w_contador + 1
                    ---print 'Contador %1!',@w_contador

                    if @w_origen0 = 'datetime'
                    begin
                      select
                        @w_campo0 = 'convert(varchar(10),' + @w_campo0 + ',103)'
                    ---print 'Fecha_0 %1!',@w_campo0
                    end

                    select
                      @w_cadena1 =
                      ''' + ltrim(rtrim(convert(char(50),@w_etiqueta0))) + '''
                    if @w_catalogo0 is null
                    begin
                      select
                        @w_cadena = @w_cadena + @w_cadena1 + ',' + @w_campo0
                    end
                    else
                    begin
                      select
                        @w_cadena2 =
              ',(select b.valor from cobis..cl_tabla a,cobis..cl_catalogo b '
              + 'where a.codigo = b.tabla ' + 'and a.tabla  = ' +
                     ''' + @w_catalogo0 + '' '
              + 'and b.codigo = convert(char,c.' + @w_campo0 + '))'
                      select
                        @w_cadena = @w_cadena + @w_cadena1 + @w_cadena2
                    end

                    if @w_contador < @i_registros
                    begin
                      select
                        @w_cadena0 = @w_cadena
                      select
                        @w_cadena = @w_cadena + ','
                    ---print '%1!',@w_cadena
                    end

                    if @w_contador = @i_registros
                    begin
                      select
                        @w_cadena = @w_cadena + ' from cobis..' + @w_tabla0 +
                                    ' c where '
                                    +
                                    @w_llave_ing
                                           + ' = '
                                    + convert(char, @i_ente)
                      exec(@w_cadena)
                      select
                        @w_cadena = 'select '
                      select
                        @w_cadena0 = ''
                      select
                        @w_cadena2 = ''
                      select
                        @w_contador = 0
                    end

                    fetch parametrizacion into @w_tabla0,
                                               @w_campo0,
                                               @w_posicion0,
                                               @w_etiqueta0,
                                               @w_catalogo0,
                                               @w_origen0

                  end
                  close parametrizacion
                  deallocate parametrizacion
                end
                if @w_contador <> 0
                begin
                  select
                    @w_cadena = @w_cadena0 + ' from cobis..' + @w_tabla0 +
                                ' c where '
                                +
                                       @w_llave_ing + ' = '
                                + convert(char, @i_ente)
                  ---print '%1!',@w_cadena0
                  ---print '%1!',@w_cadena
                  exec(@w_cadena)
                  select
                    @w_cadena = ''
                  select
                    @w_cadena0 = ''
                  select
                    @w_cadena2 = ''
                end
              end
            end

            if @w_fpresenta = 'H'
            begin
              select
                @w_campos = count(0)
              from   cobis..cl_param_sol
              where  ps_grupo    = @w_grupo
                 and ps_estado   = 'V'
                 and ps_posicion > 0
              if @w_campos > 0
              begin
                select
                  @w_cadena = 'select '
                select
                  @w_contador = 0

                declare parametrizacion1 cursor for
                  select
                    ps_tabla,
                    ps_campo,
                    ps_etiqueta,
                    ps_posicion,
                    ps_catalogo,
                    ps_origen
                  from   cobis..cl_param_sol
                  where  ps_grupo    = @w_grupo
                     and ps_estado   = 'V'
                     and ps_posicion > 0
                  order  by ps_posicion

                open parametrizacion1
                fetch parametrizacion1 into @w_tabla1,
                                            @w_campo1,
                                            @w_etiqueta1,
                                            @w_posicion1,
                                            @w_catalogo1,
                                            @w_origen1

                if @@fetch_status = -2
                begin /* error en la base */
                  return 1
                end
                else
                begin
                  while (@@fetch_status != -1)
                  begin -- while
                    if @@fetch_status = -2
                    begin /* error en la base */
                      return 1
                    end

                    select
                      @w_contador = @w_contador + 1
                    ---print 'Contador %1!',@w_contador

                    if @w_origen1 = 'datetime'
                    begin
                      select
                        @w_campo1 = 'convert(varchar(10),' + @w_campo1 + ',103)'
                    ---print 'Fecha_1 %1!',@w_campo1
                    end

                    if @w_catalogo1 is null
                    begin
                      select
                        @w_cadena = @w_cadena +
                                    ''' + ltrim(rtrim(@w_etiqueta1)) + '''
                                    +
                                    '='
                                    +
                                    @w_campo1
                    end
                    else
                    begin
                      select
                        @w_cadena2 = ''' + ltrim(rtrim(@w_etiqueta1)) + '''
                                     +
              '=(select b.valor from cobis..cl_tabla a,cobis..cl_catalogo b '
                           + 'where a.codigo = b.tabla ' + 'and a.tabla  = ' +
                                  ''' + @w_catalogo1 + '' '
                           + 'and b.codigo = convert(char,c.' + @w_campo1 +
                           '))'
                      select
                        @w_cadena = @w_cadena + @w_cadena2
                    end

                    if @w_contador < @i_registros
                    begin
                      select
                        @w_cadena0 = @w_cadena
                      select
                        @w_cadena = @w_cadena + ','
                    ---print '%1!',@w_cadena
                    end

                    if @w_contador = @i_registros
                    begin
                      select
                        @w_cadena = @w_cadena + ' from cobis..' + @w_tabla1 +
                                    ' c where '
                                    +
                                    @w_llave_ing
                                           + ' = '
                                    + convert(char, @i_ente)
                      exec(@w_cadena)
                      select
                        @w_cadena = 'select '
                      select
                        @w_cadena0 = ''
                      select
                        @w_cadena2 = ''
                      select
                        @w_contador = 0
                    end

                    fetch parametrizacion1 into @w_tabla1,
                                                @w_campo1,
                                                @w_etiqueta1,
                                                @w_posicion1,
                                                @w_catalogo1,
                                                @w_origen1

                  end
                  close parametrizacion1
                  deallocate parametrizacion1
                end
                if @w_contador <> 0
                begin
                  select
                    @w_cadena = @w_cadena0 + ' from cobis..' + @w_tabla1 +
                                ' c where '
                                +
                                       @w_llave_ing + ' = '
                                + convert(char, @i_ente)
                  ---print '%1!',@w_cadena0
                  ---print '%1!',@w_cadena
                  exec(@w_cadena)
                  select
                    @w_cadena = ''
                  select
                    @w_cadena0 = ''
                  select
                    @w_cadena2 = ''
                end
              end
            end
          end
          fetch grupo into @w_grupo, @w_fpresenta, @w_llave_ing
        end
        close grupo
        deallocate grupo
      end
    end
  end
  return 0

go

