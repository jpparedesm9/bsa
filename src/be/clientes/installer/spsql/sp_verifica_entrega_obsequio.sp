/************************************************************************/
/*  Archivo         :       sp_verifica_entrega_obsequio.sp             */
/*  Stored procedure    :   sp_verifica_entrega_obsequio                */
/*  Base de datos       :   cobis                                       */
/*  Producto            :   Clientes                                    */
/*  Disenado por        :                                               */
/*  Fecha de escritura  :                                               */
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
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  11/May/2016   T. Baidal   Migracion a CEN                           */
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
           where  name = 'sp_verifica_entrega_obsequio')
  drop proc sp_verifica_entrega_obsequio
go

create proc sp_verifica_entrega_obsequio
(
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_obsequio     int,
  @i_debug        char(1) = 'N',
  @o_msg          varchar(60) = null output
)
as
  declare
    @w_sp_name        varchar(40),
    @w_error          int,
    @w_mensaje        varchar(24),
    @w_return         int,
    @w_cc_cod_caract  smallint,
    @w_cc_tipo        char(1),
    @w_cc_descripcion varchar(35),
    @w_cc_desde       float,
    @w_cc_hasta       float,
    @w_cc_fecha1      datetime,
    @w_cc_fecha2      datetime,
    @w_cc_operador    char(10),
    @w_cc_cadena      varchar(10),
    @w_cc_proceso     char(1),
    @w_cc_rutina      smallint,
    @w_cc_base_datos  varchar(20),
    @w_cc_tabla       varchar(25),
    @w_cc_campo       varchar(20),
    @w_sql            varchar(255),
    @w_cc_indice_n    varchar(15),
    @w_errorsen       int,
    @w_resultado      varchar(15),
    @w_tipodato       varchar(25),
    @w_sql1           varchar(255),
    @w_edad           int,
    @w_edadmora       int,
    @w_aplicarutina   tinyint,
    @w_fecha_nac      datetime,
    @w_existevencido  smallint

  select
    @w_sp_name = 'sp_verifica_entrega_obsequio'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/*Con el obsequio que estamos reciviendo se procede a evaluar sus caracteristicas*/
  --select @i_ente = 12

  select
    cc_cod_caract,
    cc_tipo,
    cc_descripcion,
    cc_desde,
    cc_hasta,
    cc_fecha1,
    cc_fecha2,
    cc_operador,
    cc_cadena,
    cc_base_datos,
    cc_tabla,
    cc_campo,
    'cumple' = 'X',
    cc_indice_n
  into   #rel_obsequio_caract
  from   cl_obsequio_caract,
         cr_caract_cli_prod
  where  oc_obsequio   = @i_obsequio
     and cc_cod_caract = oc_cod_caract
     and oc_estado     = 'V'

  --select * from #rel_obsequio_caract
  declare cursor_obsequio cursor for
    select
      cc_cod_caract,
      cc_tipo,
      cc_descripcion,
      cc_desde,
      cc_hasta,
      cc_fecha1,
      cc_fecha2,
      cc_operador,
      cc_cadena,
      cc_base_datos,
      cc_tabla,
      cc_campo,
      cc_proceso,
      cc_rutina,
      cc_indice_n
    from   cl_obsequio_caract,
           cr_caract_cli_prod
    where  oc_obsequio   = @i_obsequio
       and cc_cod_caract = oc_cod_caract
    order  by cc_cod_caract
  open cursor_obsequio

  fetch cursor_obsequio into @w_cc_cod_caract,
                             @w_cc_tipo,
                             @w_cc_descripcion,
                             @w_cc_desde,
                             @w_cc_hasta,
                             @w_cc_fecha1,
                             @w_cc_fecha2,
                             @w_cc_operador,
                             @w_cc_cadena,
                             @w_cc_base_datos,
                             @w_cc_tabla,
                             @w_cc_campo,
                             @w_cc_proceso,
                             @w_cc_rutina,
                             @w_cc_indice_n

  while @@fetch_status = 0
  begin
    /*
       if (@@sqlstatus = -1)
       begin
          select @w_error = 2101015
          goto ERROR
       end
    */
    if @w_cc_proceso = 'A'
    begin
      select
        @w_sql = ''

      delete resultados
      delete tipodato
      select
        @w_sql1 = 'insert into tipodato select t.name from ' + ltrim(rtrim(
                                           @w_cc_base_datos)) +
                                           '..'
                  + 'sysobjects o,' + ltrim(rtrim(@w_cc_base_datos)) + '..' +
                                           'syscolumns c ,'
                  + ltrim(rtrim(@w_cc_base_datos)) + '..' +
                                           'systypes t  where  o.name = ' + char
                  (
                  39)
                  + ltrim(rtrim(@w_cc_tabla)) + char(39) + ' and c.name = ' +
                  char
                  (
                  39)
                  +
                                           @w_cc_campo + char(39)
                  + ' and    o.id = c.id and    c.usertype = t.usertype'

      if @i_debug = 'S'
        print @w_sql1

      exec (@w_sql1)

      select
        @w_tipodato = lower(nombretipo)
      from   tipodato

      if @i_debug = 'S'
        print @w_tipodato

      if @w_tipodato in ('char', 'varchar', 'text', 'catalogo',
                         'catalogo1', 'cuenta', 'descripcion', 'direccion',
                         'estado', 'login', 'mensaje', 'numero',
                         'sexo', 'url')
      begin
        if ltrim(rtrim(@w_cc_operador)) <> '='
        -- Para cadenas solo se utiliza el operador de igualdad
        begin
          select
            @o_msg = 'Para cadenas solo se utiliza el operador de igualdad'
          select
            @w_error = -1
          goto ERRORFIN
        end

        select
          @w_sql = 'insert into resultados select ' + ltrim(rtrim(@w_cc_campo))
                   +
                   ' from '
                   + ltrim(rtrim(@w_cc_base_datos)) + '..' + ltrim(rtrim(
                   @w_cc_tabla
                   ))
                   +
                                ' where '
                   + ltrim(rtrim(@w_cc_indice_n)) + ' = ' + convert(varchar(10),
                   @i_ente
                   )
                                + ' AND '
                   + ltrim(rtrim(@w_cc_campo)) + + ltrim(rtrim(@w_cc_operador))
                   +
                   +
                   char
                   (
                                39)
                   + ltrim(rtrim(@w_cc_cadena)) + char(39)

        if @i_debug = 'S'
          print @w_sql

        execute (@w_sql)

        select
          @w_resultado = resultado
        from   resultados

        if exists (select
                     1
                   from   resultados)
        begin
          --            if @i_debug = 'S'
          --              print   'Existe resultados numerico'

          if ltrim(rtrim(@w_cc_cadena)) = ltrim(rtrim(@w_resultado))
            update #rel_obsequio_caract
            set    cumple = 'S'
            where  cc_cod_caract = @w_cc_cod_caract
          else
            update #rel_obsequio_caract
            set    cumple = 'N'
            where  cc_cod_caract = @w_cc_cod_caract
        end
        else
        begin
          select
            @o_msg = 'Valor del cliente TEXTO se encuentra nulo o no existe'
          select
            @w_error = -6
          -- Valor del cliente  numerico se encuentra nulo o no existe
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract

        --GOTO ERRORFIN
        end
      end

      if @w_tipodato in ('int', 'float', 'money', 'numeric',
                         'smallmoney', 'decimal', 'smallint', 'tinyint')
      begin
        if @w_cc_operador = 'between'
          select
            @w_sql = 'insert into resultados select ' + ltrim(rtrim(@w_cc_campo)
                     )
                     +
                     ' from '
                     + ltrim(rtrim(@w_cc_base_datos)) + '..' + ltrim(rtrim(
                     @w_cc_tabla
                     ))
                     +
                                                          ' where '
                     + ltrim(rtrim(@w_cc_indice_n)) + ' = ' + convert(varchar(10
                     ),
                     @i_ente
                     )
                                                          + ' AND '
                     + ltrim(rtrim(@w_cc_campo)) + ltrim(rtrim(@w_cc_operador))
                     +
                     ltrim(
                                                          rtrim(@w_cc_desde))
                     + ' and ' + ltrim(rtrim(@w_cc_hasta))

        if @w_cc_operador in ('>', '>=', '<', '>=', '=')
          select
            @w_sql = 'insert into resultados select ' + ltrim(rtrim(@w_cc_campo)
                     )
                     +
                     ' from '
                     + ltrim(rtrim(@w_cc_base_datos)) + '..' + ltrim(rtrim(
                     @w_cc_tabla
                     ))
                     +
            ' where '
                     + ltrim(rtrim(@w_cc_indice_n)) + ' = ' + convert(varchar(10
                     ),
                     @i_ente
                     )
            + ' AND '
                     + ltrim(rtrim(@w_cc_campo)) + ltrim(rtrim(@w_cc_operador))
                     +
                     ltrim(
            rtrim(@w_cc_desde))

        if @i_debug = 'S'
          print @w_sql

        execute (@w_sql)

        if exists (select
                     1
                   from   resultados)
        begin
          if @i_debug = 'S'
            print 'Existe resultados numerico'

          if exists (select
                       1
                     from   resultados)
            update #rel_obsequio_caract
            set    cumple = 'S'
            where  cc_cod_caract = @w_cc_cod_caract
          else
            update #rel_obsequio_caract
            set    cumple = 'N'
            where  cc_cod_caract = @w_cc_cod_caract
        end
        else
        begin
          --            select @o_msg = 'Valor del cliente se encuentra nulo o no existe'
          --            select @w_error =  -5   -- Valor del cliente  numerico se encuentra nulo o no existe
          --GOTO ERRORFIN
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract
        end
      end

      if @w_tipodato in ('smalldatetime', 'datetime')
      begin
        if @w_cc_operador = 'between'
        begin
          if @w_cc_fecha2 is null
          begin
            select
              @o_msg =
  'Para el tipo fecha y operador between debe ingresarse las dos fechas'
  select
    @w_error = -2
            -- Para el tipo fecha y operador between debe ingresarse las dos fechas
            goto ERRORFIN
          end

          select
            @w_sql = 'insert into resultados select ' + ltrim(rtrim(@w_cc_campo)
                     )
                     +
                     ' from '
                     + ltrim(rtrim(@w_cc_base_datos)) + '..' + ltrim(rtrim(
                     @w_cc_tabla
                     ))
                     +
                                  ' where '
                     + ltrim(rtrim(@w_cc_indice_n)) + ' = ' + convert(varchar(10
                     ),
                     @i_ente
                     )
                                  + ' AND '
                     + ltrim(rtrim(@w_cc_campo)) + ltrim(rtrim(@w_cc_operador))
                     +
                     char
                     (
                     39)
                     + ltrim(rtrim(@w_cc_fecha1)) + char(39) + ' AND ' + char(39
                     )
                     +
                     ltrim(
                                  rtrim(@w_cc_fecha2))
                     + char(39)

        end

        if @w_cc_operador in ('>', '>=', '<', '>=', '=')
          select
                  @w_sql = 'insert into resultados select ' + ltrim(rtrim(
                           @w_cc_campo)
                           )
                           +
                           ' from '
                     + ltrim(rtrim(@w_cc_base_datos)) + '..' + ltrim(rtrim(
                           @w_cc_tabla
                           ))
                           +
                           ' where '
                     + ltrim(rtrim(@w_cc_indice_n)) + ' = ' + convert(varchar(10
                           ),
                           @i_ente
                           )
                           + ' AND '
                     + ltrim(rtrim(@w_cc_campo)) + ltrim(rtrim(@w_cc_operador))
                           +
                           char
                           (
                           39)
                     + ltrim(rtrim(@w_cc_fecha1)) + char(39)

        if @i_debug = 'S'
          print @w_sql

        execute (@w_sql)

        if exists (select
                     1
                   from   resultados)
        begin
          if @i_debug = 'S'
            print 'Existe resultados'

          if exists (select
                       1
                     from   resultados)
            update #rel_obsequio_caract
            set    cumple = 'S'
            where  cc_cod_caract = @w_cc_cod_caract
          else
            update #rel_obsequio_caract
            set    cumple = 'N'
            where  cc_cod_caract = @w_cc_cod_caract
        end
        else
        begin
          select
            @o_msg = 'Valor del cliente fecha se encuentra nulo o no existe'
          select
            @w_error = -4 -- Valor del cliente se encuentra nulo o no existe
          --   GOTO ERRORFIN
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract

        end
      end
    end --PROCESAMIENTO AUTOMATICO

    if @w_cc_proceso = 'M' --PROCESAMIENTO MANUAL
    begin
      if @i_debug = 'S'
        print 'M'
      select
        @w_aplicarutina = 0

      /* RUTINA EJEMPLO NO BORRAR */
      if @w_cc_rutina = 0
      begin
        select
          @w_edadmora = 0
        /*OBTENER EL VALOR REAL DE LA VARIABLE*/
        select
          @w_edadmora = datediff(dd,
                                 getdate(),
                                 dateadd(dd,
                                         70,
                                         getdate()))

        if @i_debug = 'S'
          print @w_edadmora
        print @w_cc_desde

      /*APLICAR LA VALIDACION PARAMETRIZADA ENTE LO ENCONTRADO CON EL VALOR DEL PARAMETRO DEPENDIENTE DEL TIPO DATO*/
        /*Y PROCEDER CON LA ACTUALZIACION PARA VERIFICAR CUMPLIMIENTO*/
        if @w_edadmora <= @w_cc_desde
          update #rel_obsequio_caract
          set    cumple = 'S'
          where  cc_cod_caract = @w_cc_cod_caract
        else
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract

        select
          @w_aplicarutina = 1
      end

    /*SE CREAN EN ADELANTE CUANTAS RUTINAS SEAN NECESARIAS PARA ATENDER LAS CARACTERISTICAS MANUALES*/
      /* RUTINA EJEMPLO NO BORRAR */
      if @w_cc_rutina = 1
      begin
        select
          @w_edad = 0

        /*OBTENER EL VALOR REAL DE LA VARIABLE*/
        select
          @w_fecha_nac = p_fecha_nac
        from   cobis..cl_ente
        where  en_ente = @i_ente

        select
          @w_edad = datediff(yy,
                             @w_fecha_nac,
                             getdate())

      /*APLICAR LA VALIDACION PARAMETRIZADA ENTE LO ENCONTRADO CON EL VALOR DEL PARAMETRO DEPENDIENTE DEL TIPO DATO*/
        /*Y PROCEDER CON LA ACTUALZIACION PARA VERIFICAR CUMPLIMIENTO*/
        if @w_cc_desde <= @w_edad
           and @w_edad <= @w_cc_hasta
          update #rel_obsequio_caract
          set    cumple = 'S'
          where  cc_cod_caract = @w_cc_cod_caract
        else
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract

        select
          @w_aplicarutina = 1
      end

      if @w_cc_rutina = 2
      begin
        select
          @w_existevencido = count(*)
        from   cob_cartera..ca_operacion,
               cob_cartera..ca_dividendo
        where  op_operacion = di_operacion
           and op_cliente   = @i_ente
           and op_estado in (1, 2, 9)
           and di_estado    = 2

        select
          @w_existevencido = isnull(@w_existevencido,
                                    0)

        if @w_existevencido > 0
          update #rel_obsequio_caract
          set    cumple = 'N'
          where  cc_cod_caract = @w_cc_cod_caract
        else
          update #rel_obsequio_caract
          set    cumple = 'S'
          where  cc_cod_caract = @w_cc_cod_caract

        select
          @w_aplicarutina = 1
      end

    /*...*/
    /*...*/
      /*...*/
      if @w_aplicarutina = 0
      begin
        select
          @w_error = -3
        -- Rutina definida en la parametrizacion no se encuentra programada. Solicite yuda tecnica.
        update #rel_obsequio_caract
        set    cumple = 'N'
        where  cc_cod_caract = @w_cc_cod_caract

      -- GOTO ERRORFIN
      end

    end
    fetch cursor_obsequio into @w_cc_cod_caract,
                               @w_cc_tipo,
                               @w_cc_descripcion,
                               @w_cc_desde,
                               @w_cc_hasta,
                               @w_cc_fecha1,
                               @w_cc_fecha2,
                               @w_cc_operador,
                               @w_cc_cadena,
                               @w_cc_base_datos,
                               @w_cc_tabla,
                               @w_cc_campo,
                               @w_cc_proceso,
                               @w_cc_rutina,
                               @w_cc_indice_n
  end --WHILE

  select
    'Cod'=cc_cod_caract,
    'Caracteristica' = cc_descripcion,
    'Cumple (S/N)' = cumple
  from   #rel_obsequio_caract

  close cursor_obsequio
  deallocate cursor_obsequio

  return 0

  ERRORFIN:
  return @w_error

--ERROR:    /* RUTINA QUE DISPARA sp_cerror DADO EL CODIGO DEL ERROR */
--   exec phoenix..sp_cerror
--   @t_from  = @w_sp_name,
--   @i_num   = @w_error
--   return 1

go

