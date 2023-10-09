/* **********************************************************************/
/*      Archivo:             clconscliccaact.sp                         */
/*      Stored procedure:    sp_cons_cli_ccaact                         */
/*      Base de datos:       cobis                                      */
/*      Producto:            Clientes                                   */
/*      Disenado por:        Juan David G                               */
/*      Fecha de escritura:  24-Abr-2008                                */
/* **********************************************************************/
/*                              IMPORTANTE                              */
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
/* **********************************************************************/
/*                              PROPOSITO                               */
/* **********************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      09-Sep-1993     S Ortiz         Emision inicial                 */
/*      03-Mar-2009     ELA             Desarrollo 016                  */
/*      25-May-2009     ELA             Caso 313 - data migrada         */
/*      02-May-2016     DFu             Migracion CEN                   */
/* **********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cons_cli_ccaact')
  drop proc sp_cons_cli_ccaact
go

create proc sp_cons_cli_ccaact
(
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cartera      char(1) = null,
  @i_criterio     char(1) = null,
  @i_agrupamiento char(1) = null,
  @i_fecha        datetime = null,
  @i_modo         tinyint = null,
  @i_secuencial   smallint = null
)
as
  declare
    @w_sp_name  char(30),
    @w_criterio varchar(16),
    @w_catalogo varchar(20),
    @w_sec      int

  select
    @w_sp_name = 'sp_cons_cli_ccaact'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/*
    ACTIVIDAD   A
    EDAD        D
    ESTRATO         E
    PROCEDENCIA     P
    SEXO        S
    MERCADO OBJETIVO M
*/
  --Version /*      25-May-2009     ELA             Caso 313 */

  create table #tmp_consulta
  (
    criterio varchar(30),
    consulta varchar(30),
    valor1   int,
    valor2   int
  )
  insert into #tmp_consulta
  values      ('21 - 30','between 21 and 30',21,30)
  insert into #tmp_consulta
  values      ('31 - 40','between 31 and 40',31,40)
  insert into #tmp_consulta
  values      ('41 - 50','between 41 and 50',41,50)
  insert into #tmp_consulta
  values      ('51 - 60','between 51 and 60',51,60)
  insert into #tmp_consulta
  values      ('61 - 70','between 61 and 70',61,70)
  insert into #tmp_consulta
  values      ('HASTA 20','between 1 and 20',1,20)
  insert into #tmp_consulta
  values      ('MAS DE 70','between 71 and 100',71,100)

  if(@i_criterio = 'A')
    select
      @w_criterio = 'Actividad  ',
      @w_catalogo = 'cl_actividad'
  if(@i_criterio = 'E')
    select
      @w_criterio = 'Estrato    ',
      @w_catalogo = 'cl_estrato'
  if(@i_criterio = 'P')
    select
      @w_criterio = 'Procedencia',
      @w_catalogo = 'cl_procedencia'
  if(@i_criterio = 'S')
    select
      @w_criterio = 'Sexo       ',
      @w_catalogo = 'cl_sexo'
  if(@i_criterio = 'M')
    select
      @w_criterio = 'Mercado Objetivo',
      @w_catalogo = 'cl_mercado_objetivo'

  if(@i_criterio = 'D')
  begin
    select
      @w_criterio = 'Edad'
    if @i_agrupamiento = 'O'
    begin
      select
        'OFICINA   ' = of_oficina,
        'NOMBRE    ' = substring(of_nombre,
                                 1,
                                 20),
        'CRITERIO  ' = substring(criterio,
                                 1,
                                 20),
        'CANTIDAD  ' = sum(ec_cantidad),
        'VALOR     ' = sum(ec_valor)
      from   cl_estad_clte,
             cobis..cl_oficina,
             #tmp_consulta
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
         and ec_criterio between valor1 and valor2
      group  by criterio,
                of_oficina,
                of_nombre
    end

    if @i_agrupamiento = 'Z'
    begin
      select
        'ZONA      ' = of_zona,
        'NOMBRE    ' = (select
                          substring(of_nombre,
                                    1,
                                    20)
                        from   cobis..cl_oficina
                        where  of_oficina = X.of_zona),
        'CRITERIO  ' = substring(criterio,
                                 1,
                                 20),
        'CANTIDAD  ' = sum(ec_cantidad),
        'VALOR     ' = sum(ec_valor)
      from   cl_estad_clte,
             cobis..cl_oficina X,
             #tmp_consulta
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
         and ec_criterio between valor1 and valor2
      group  by of_zona,
                criterio
    end

    if @i_agrupamiento = 'R'
    begin
      select
        'REGIONAL  ' = of_regional,
        'NOMBRE    ' = (select
                          substring(of_nombre,
                                    1,
                                    20)
                        from   cobis..cl_oficina
                        where  of_oficina = X.of_regional),
        'CRITERIO  ' = substring(criterio,
                                 1,
                                 20),
        'CANTIDAD  ' = sum(ec_cantidad),
        'VALOR     ' = sum(ec_valor)
      from   cl_estad_clte,
             cobis..cl_oficina X,
             #tmp_consulta
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
         and ec_criterio between valor1 and valor2
      group  by of_regional,
                criterio
    end

    if @i_agrupamiento = 'T'
    begin
      select
        'TOTAL   ',
        'CRITERIO' = substring(criterio,
                               1,
                               20),
        'CANTIDAD' = sum(ec_cantidad),
        'VALOR   ' = sum(ec_valor)
      from   cl_estad_clte,
             cobis..cl_oficina,
             #tmp_consulta
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
         and ec_criterio between valor1 and valor2
      group  by criterio
    end
  end
  else
  begin
    if @i_agrupamiento = 'O'
    begin
      drop table listado_tmp2

      select
        oficina= of_oficina,
        regional= "",
        zona = "",
        nombre = substring(of_nombre,
                           1,
                           20),
        criterio = isnull((select
                             substring(A.valor,
                                       1,
                                       25)
                           from   cobis..cl_catalogo A,
                                  cobis..cl_tabla B
                           where  B.codigo = A.tabla
                              and B.tabla  = @w_catalogo
                              and A.codigo = X.ec_criterio),
                          'No def catalogo ** ' + X.ec_criterio),
        cantidad = ec_cantidad,
        valor = ec_valor,
        secuencial = 0
      into   listado_tmp2
      from   cl_estad_clte X,
             cobis..cl_oficina
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
      order  by of_oficina,
                ec_criterio

      select
        @w_sec = 0

      update listado_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20

        select
          'OFICINA   ' = oficina,
          'NOMBRE    ' = nombre,
          'CRITERIO  ' = criterio,
          'CANTIDAD  ' = cantidad,
          'VALOR     ' = valor,
          'SECUENCIAL' = secuencial
        from   cobis..listado_tmp2
        order  by secuencial

      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'OFICINA   ' = oficina,
          'NOMBRE    ' = nombre,
          'CRITERIO  ' = criterio,
          'CANTIDAD  ' = cantidad,
          'VALOR     ' = valor,
          'SECUENCIAL' = secuencial
        from   listado_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end

    end --Agrupamiento = O

    if @i_agrupamiento = 'Z'
    begin
      drop table listado_tmp2
      select
        oficina= "",
        regional= "",
        zona = of_zona,
        nombre = (select
                    substring(of_nombre,
                              1,
                              20)
                  from   cobis..cl_oficina
                  where  of_oficina = X.of_zona),
        criterio = (select
                      substring(A.valor,
                                1,
                                20)
                    from   cobis..cl_catalogo A,
                           cobis..cl_tabla B
                    where  B.codigo = A.tabla
                       and B.tabla  = @w_catalogo
                       and A.codigo = Y.ec_criterio),
        cantidad = sum(ec_cantidad),
        valor = sum(ec_valor),
        secuencial = 0
      into   listado_tmp2
      from   cl_estad_clte Y,
             cobis..cl_oficina X
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
      group  by of_zona,
                ec_criterio

      select
        @w_sec = 0

      update listado_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'ZONA    ' = zona,
          'NOMBRE  ' = nombre,
          'CRITERIO' = criterio,
          'CANTIDAD' = cantidad,
          'VALOR   ' = valor,
          'SECUENCIAL' = secuencial
        from   listado_tmp2
        order  by secuencial

      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'ZONA    ' = zona,
          'NOMBRE  ' = nombre,
          'CRITERIO' = criterio,
          'CANTIDAD' = cantidad,
          'VALOR   ' = valor,
          'SECUENCIAL' = secuencial
        from   listado_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end
    end--agrupamiento = Z

    if @i_agrupamiento = 'R'
    begin
      drop table listado_tmp2
      select
        oficina= "",
        regional = of_regional,
        zona = "",
        nombre = (select
                    substring(of_nombre,
                              1,
                              20)
                  from   cobis..cl_oficina
                  where  of_oficina = X.of_regional),
        criterio = (select
                      substring(A.valor,
                                1,
                                20)
                    from   cobis..cl_catalogo A,
                           cobis..cl_tabla B
                    where  B.codigo = A.tabla
                       and B.tabla  = @w_catalogo
                       and A.codigo = Y.ec_criterio),
        cantidad = sum(ec_cantidad),
        valor = sum(ec_valor),
        secuencial = 0
      into   listado_tmp2
      from   cl_estad_clte Y,
             cobis..cl_oficina X
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
      group  by of_regional,
                ec_criterio

      select
        @w_sec = 0

      update listado_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'REGIONAL' = regional,
          'NOMBRE  ' = nombre,
          'CRITERIO' = criterio,
          'CANTIDAD' = cantidad,
          'VALOR   ' = valor,
          'SECUENCIAL'= secuencial
        from   listado_tmp2
        order  by secuencial
      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'REGIONAL' = regional,
          'NOMBRE  ' = nombre,
          'CRITERIO' = criterio,
          'CANTIDAD' = cantidad,
          'VALOR   ' = valor,
          'SECUENCIAL'= secuencial
        from   listado_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end
    end --Agrupamiento R

    if @i_agrupamiento = 'T'
    begin
      drop table listado_tmp2
      select
        oficina = "",
        regional = "",
        zona = "",
        nombre = "",
        criterio = (select
                      A.valor
                    from   cobis..cl_catalogo A,
                           cobis..cl_tabla B
                    where  B.codigo = A.tabla
                       and B.tabla  = @w_catalogo
                       and A.codigo = ec_criterio),
        cantidad = sum(ec_cantidad),
        valor = sum(ec_valor),
        secuencial = 0
      into   listado_tmp2
      from   cl_estad_clte,
             cobis..cl_oficina
      where  ec_tcriterio   = @i_criterio
         and ec_cartera     = @i_cartera
         and ec_fecha_corte = @i_fecha
         and ec_oficina     = of_oficina
      group  by ec_criterio

      select
        @w_sec = 0

      update listado_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'TOTAL     ' = "",
          'CRITERIO  ' = criterio,
          'CANTIDAD  ' = cantidad,
          'VALOR     ' = valor,
          'SECUENCIAL' = secuencial
        from   listado_tmp2
        order  by secuencial
      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'TOTAL     ' = "",
          'CRITERIO  ' = criterio,
          'CANTIDAD  ' = cantidad,
          'VALOR     ' = valor,
          'SECUENCIAL' = secuencial
        from   listado_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end
    end --agrupamiento = T

  --    end
  end
  return 0

go

