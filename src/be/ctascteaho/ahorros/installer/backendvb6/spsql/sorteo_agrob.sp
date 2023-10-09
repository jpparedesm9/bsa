use cob_ahorros
go

/************************************************************************/
/*  Archivo:            sorteo_agrob.sp                                 */
/*  Stored procedure:   sp_sorteo_agrob                                 */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:               Cuentas Corrientes                          */
/*  Disenado por:           Carmen Mil n                                */
/*  Fecha de escritura:     28-Ago-2002                                 */
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
/*  Este programa realiza las operaciones necesarias sobre la tabla     */
/*      de embargos.                                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Jul/2002 Adriana Pazmi¤o  Emision inicial                        */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_sorteo_agrob')
  drop proc sp_sorteo_agrob
go

create proc sp_sorteo_agrob
(
  @s_ssn          int=null,
  @t_show_version bit = 0,
  @i_tipo_sorteo  char(1),
  @i_agencia      smallint,
  @i_fecha        smalldatetime
)
as
  declare
    @w_sp_name          char(20),
    @w_mes_actual       int,
    @w_cod_agroben      int,
    @w_nombre           varchar(64),
    @w_cta_banco        varchar(16),
    @w_min_dispmes      money,
    @w_total_disponible money,
    @w_hora             char(2),
    @w_minuto           char(2),
    @w_segundo          char(2),
    @w_msegundo         char(3),
    @w_tiempo           varchar(30),
    @w_unomasuno        int,
    @w_cta_banco_n      int,
    @w_llave            int,
    @w_agencia          smallint,
    @w_llave_char       char(20)

  /*  Captura nombre de Stored Procedure  */

  select
    @i_fecha = getdate()
  select
    @w_sp_name = 'sp_sorteo_agrob'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_mes_actual = datepart(mm,
                             @i_fecha)
  select
    @w_cod_agroben = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBAB'
  if @i_tipo_sorteo = 'O'
  begin
    declare cuentas_agroben cursor for
      select
        ah_cta_banco,
        ah_nombre,
        ah_min_dispmes,
        ah_disponible + ah_12h + ah_24h + ah_remesas,
        ah_oficina
      from   cob_ahorros..ah_cuenta
      where  (ah_oficina     = @i_agencia
               or @i_agencia     = 0)
         and ah_prod_banc   = @w_cod_agroben
         and ah_estado      = 'A'
         and ah_min_dispmes >= 100
      --order by ah_cta_banco

      for read only

    open cuentas_agroben
    fetch cuentas_agroben into @w_cta_banco,
                               @w_nombre,
                               @w_min_dispmes,
                               @w_total_disponible,
                               @w_agencia

    if @@fetch_status = -1
    begin
      close cuentas_agroben
      deallocate cuentas_agroben
      exec cobis..sp_cerror
        @i_num = 201157
      return 201157
    end
    else if @@fetch_status = -2
    begin
      close cuentas_agroben
      deallocate cuentas_agroben
      return 0
    end

    select
      @w_tiempo = convert(varchar(30), getdate(), 109)
    select
      @w_hora = substring(@w_tiempo,
                          13,
                          15)
    select
      @w_minuto = substring(@w_tiempo,
                            16,
                            18)
    select
      @w_segundo = substring(@w_tiempo,
                             19,
                             21)
    select
      @w_msegundo = substring(@w_tiempo,
                              22,
                              26)
    select
      @w_unomasuno = convert(int, @w_hora + @w_minuto + @w_segundo + @w_msegundo
                     )

    while @@fetch_status = 0
    begin
      select
        @w_tiempo = convert(varchar(30), getdate(), 109)
      select
        @w_hora = substring(@w_tiempo,
                            13,
                            15)
      select
        @w_minuto = substring(@w_tiempo,
                              16,
                              18)
      select
        @w_segundo = substring(@w_tiempo,
                               19,
                               21)
      select
        @w_msegundo = substring(@w_tiempo,
                                22,
                                26)

      if convert(int, @w_hora) = 0
        select
          @w_hora = '24'
      if convert(int, @w_minuto) = 0
        select
          @w_minuto = '60'
      if convert(int, @w_segundo) = 0
        select
          @w_segundo = '60'
      if convert(int, @w_msegundo) = 0
        select
          @w_msegundo = '999'

      select
        @w_cta_banco_n = convert(int, substring(@w_cta_banco,
                                                2,
                                                10))

      select
        @w_llave_char = convert(char(20), convert(int, @w_hora) *
                        convert(int, @w_minuto)
        *
        convert(int, @w_segundo
        ) * (
        @w_cta_banco_n
        / convert(int, @w_msegundo)))

      select
        @w_llave_char = convert (char(20), convert(int, @w_llave_char) +
                                           @w_unomasuno)
      select
        @w_llave_char = convert(char(9), @w_llave_char)
      select
        @w_llave = convert(int, @w_llave_char)
      while (exists(select
                      1
                    from   cob_ahorros..ah_sorteo_agrob
                    where  sa_secuencial = @w_llave))
        select
          @w_llave = @w_llave + 1

      insert into cob_ahorros..ah_sorteo_agrob
                  (sa_secuencial,sa_agencia,sa_cta_banco,sa_nombre,
                   sa_saldo_minimo
                   ,
                   sa_saldo_actual,sa_tipo_sorteo)
      values      (@w_llave,@w_agencia,@w_cta_banco,@w_nombre,@w_min_dispmes,
                   @w_total_disponible,@i_tipo_sorteo)

      fetch cuentas_agroben into @w_cta_banco,
                                 @w_nombre,
                                 @w_min_dispmes,
                                 @w_total_disponible,
                                 @w_agencia
    end
    close cuentas_agroben
    deallocate cuentas_agroben
  end

  if @i_tipo_sorteo = 'E'
  begin
    declare cuentas_agroben cursor for
      select
        ah_cta_banco,
        ah_nombre,
        ah_min_dispmes,
        ah_disponible + ah_12h + ah_24h + ah_remesas,
        ah_oficina
      from   cob_ahorros..ah_cuenta
      where  (ah_oficina                                                      =
              @i_agencia
               or @i_agencia
                  =
                  0)
         and ah_prod_banc                                                    =
             @w_cod_agroben
         and ah_estado                                                       =
             'A'
         and (((ah_disponible + ah_12h + ah_24h + ah_remesas)
               >=
               500
               and (ah_disponible + ah_12h + ah_24h + ah_remesas
                    - ah_min_dispmes)
                   >= 100
              )
               or (ah_disponible + ah_12h + ah_24h + ah_remesas)
                  >=
                  10000
               or ((ah_disponible + ah_12h + ah_24h + ah_remesas)
                   >= 500
                   and datepart(mm,
                                ah_fecha_aper)
                       = @w_mes_actual))
      --order by ah_cta_banco

      for read only

    open cuentas_agroben
    fetch cuentas_agroben into @w_cta_banco,
                               @w_nombre,
                               @w_min_dispmes,
                               @w_total_disponible,
                               @w_agencia

    if @@fetch_status = -1
    begin
      close cuentas_agroben
      deallocate cuentas_agroben
      exec cobis..sp_cerror
        @i_num = 201157
      return 201157
    end
    else if @@fetch_status = -2
    begin
      close cuentas_agroben
      deallocate cuentas_agroben
      return 0
    end

    select
      @w_tiempo = convert(varchar(30), getdate(), 109)
    select
      @w_hora = substring(@w_tiempo,
                          13,
                          15)
    select
      @w_minuto = substring(@w_tiempo,
                            16,
                            18)
    select
      @w_segundo = substring(@w_tiempo,
                             19,
                             21)
    select
      @w_msegundo = substring(@w_tiempo,
                              22,
                              26)
    select
      @w_unomasuno = convert(int, @w_hora + @w_minuto + @w_segundo + @w_msegundo
                     )
    /*print @w_tiempo
    print @w_hora
    print @w_minuto
    print @w_segundo
    print @w_msegundo
    print '%1!',@w_unomasuno*/
    while @@fetch_status = 0
    begin
      select
        @w_tiempo = convert(varchar(30), getdate(), 109)
      select
        @w_hora = substring(@w_tiempo,
                            13,
                            15)
      select
        @w_minuto = substring(@w_tiempo,
                              16,
                              18)
      select
        @w_segundo = substring(@w_tiempo,
                               19,
                               21)
      select
        @w_msegundo = substring(@w_tiempo,
                                22,
                                26)

      if convert(int, @w_hora) = 0
        select
          @w_hora = '24'
      if convert(int, @w_minuto) = 0
        select
          @w_minuto = '60'
      if convert(int, @w_segundo) = 0
        select
          @w_segundo = '60'
      if convert(int, @w_msegundo) = 0
        select
          @w_msegundo = '999'

      select
        @w_cta_banco_n = convert(int, substring(@w_cta_banco,
                                                2,
                                                10))

      select
        @w_llave_char = convert(char(20), convert(int, @w_hora) *
                        convert(int, @w_minuto)
        *
        convert(int, @w_segundo
        ) * (
        @w_cta_banco_n
        / convert(int, @w_msegundo)))

      select
        @w_llave_char = convert (char(20), convert(int, @w_llave_char) +
                                           @w_unomasuno)
      select
        @w_llave_char = convert(char(9), @w_llave_char)
      select
        @w_llave = convert(int, @w_llave_char)

      while (exists(select
                      1
                    from   cob_ahorros..ah_sorteo_agrob
                    where  sa_secuencial = @w_llave))
        select
          @w_llave = @w_llave + 1

      insert into cob_ahorros..ah_sorteo_agrob
                  (sa_secuencial,sa_agencia,sa_cta_banco,sa_nombre,
                   sa_saldo_minimo
                   ,
                   sa_saldo_actual,sa_tipo_sorteo)
      values      (@w_llave,@w_agencia,@w_cta_banco,@w_nombre,@w_min_dispmes,
                   @w_total_disponible,@i_tipo_sorteo)

      fetch cuentas_agroben into @w_cta_banco,
                                 @w_nombre,
                                 @w_min_dispmes,
                                 @w_total_disponible,
                                 @w_agencia
    end
    close cuentas_agroben
    deallocate cuentas_agroben
  end
  return 0

go

