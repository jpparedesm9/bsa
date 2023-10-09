/********************************************************************/
/*  Archivo:            creactah.sp                                 */
/*  Stored procedure:   sp_crea_num_ctah                            */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas de Ahorros                          */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura: 01-Mar-1993                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa realiza la generacion del numero de cuenta        */
/*  de ahorros tanto del banco como el interno del sistema.         */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA          AUTOR          RAZON                             */
/*  01/Mar/1993    P. Mena        Emision inicial                   */
/*  10/Oct/1994    J. Bucheli     Personalizacion Banco de la       */
/*                                Produccion                        */
/*  21/May/1998    J. Cadena      Personalizacion B. del Caribe     */
/*  03/May/2016    J. Salazar     Migracion COBIS CLOUD MEXICO      */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_crea_num_ctah')
  drop proc sp_crea_num_ctah
go

/****** Object:  StoredProcedure [dbo].[sp_crea_num_ctah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_crea_num_ctah
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_cli          int,
  @i_filial       tinyint,
  @i_oficina      smallint,
  @i_producto     tinyint,
  @i_mon          tinyint,
  @i_tipo_cta     smallint,
  @o_cuenta_int   int out,
  @o_cta_banco    cuenta out
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_cta_sec      int,
    @w_cta_ofi      cuenta,
    @w_cuenta       cuenta,
    @w_pesos        cuenta,
    @w_cta_banco    cuenta,
    @w_indice_cta   tinyint,
    @w_indice_pesos tinyint,
    @w_long_max_cta tinyint,
    @w_long_cta     tinyint,
    @w_suma         smallint,
    @w_valor_cta    smallint,
    @w_valor_pesos  smallint,
    @w_digito       tinyint,
    @w_residuo      tinyint,
    @w_modulo       tinyint,
    @w_ceros        tinyint,
    @w_codigo       cuenta,
    @w_producto     varchar(6),
    @w_moneda       varchar(2),
    @w_oficina      varchar(3),
    @w_codigo_cta   varchar(6),
    @w_lonprod      smallint,
    @w_sucursal     int,
    @w_reg          int,
    @w_error        int,
    @o_siguiente    int

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_crea_num_ctah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_cli = @i_cli,
      i_filial = @i_filial,
      i_oficina = @i_oficina,
      i_producto = @i_producto,
      o_cuenta_int= @o_cuenta_int,
      o_cta_banco = @o_cta_banco
    exec cobis..sp_end_debug
  end

  begin tran
  /* Generacion del numero de cuenta interno (ah_cuenta) */
  exec @w_return = cobis..sp_cseqnos
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'ah_cuenta',
    @o_siguiente = @o_cuenta_int out
  if @w_return <> 0
    return @w_return

  -- Paso previo a la creaci¾n de Cta, 
  -- si no existe la oficina en la re_conversion
  if (select
        count(1)
      from   cob_remesas..re_conversion
      where  cv_filial       = @i_filial
         and cv_oficina      = @i_oficina
         and cv_producto     = @i_producto
         and cv_moneda       = @i_mon
         and cv_tipo         = 'R'
         and cv_tipo_cta     = @i_tipo_cta
         and (cv_cta_anterior is null
               or cv_cta_anterior = 'N')) = 0
  begin
    select
      @w_lonprod = datalength (convert(varchar(2), @i_tipo_cta))
    select
      @w_codigo_cta = (replicate(0, (4-datalength(convert(varchar(4), @i_oficina
                       )
                       )
                       )
                       )
                       + convert(varchar(4), @i_oficina)) +
      replicate (0,
                 (2 - @w_lonprod)) + convert (varchar(2), @i_tipo_cta)

    select
      @w_sucursal = of_regional
    from   cobis..cl_oficina
    where  of_oficina = @i_oficina

    if @w_sucursal is null
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201094
      return 201094
    end

    insert into cob_remesas..re_conversion
      select distinct
        pf_filial,@i_oficina,@i_producto,@i_mon,'R',
        @i_tipo_cta,@w_codigo_cta,0,'N',null
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado
      where  pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal
         and pf_mercado      = me_mercado
         and pf_producto     = @i_producto
         and pf_moneda       = @i_mon
         and me_pro_bancario = @i_tipo_cta

    select
      @w_reg = @@rowcount,
      @w_error = @@error

    if @w_error <> 0
    begin
      /* Error Insertado registro de oficina re_conversion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201242
      return 201242
    end
    else if @w_reg = 0
    begin
      print 'PRODUCTO NO AUTORIZADO'
      return 1
    end
  end -- Count(1)
  -- Fin Paso Previo

  /* Generacion del numero de cuenta del banco (ah_cta_banco) */
  select
    @w_cta_sec = isnull(cv_num_actual, 0) + 1,
    @w_cta_ofi = cv_codigo_cta
  from   cob_remesas..re_conversion
  where  cv_filial       = @i_filial
     and cv_oficina      = @i_oficina
     and cv_producto     = @i_producto
     and cv_moneda       = @i_mon
     and cv_tipo         = 'R'
     and cv_tipo_cta     = @i_tipo_cta
     and (cv_cta_anterior is null
           or cv_cta_anterior = 'N')

  if @@rowcount = 1
  begin
    update cob_remesas..re_conversion
    set    cv_num_actual = @w_cta_sec
    where  cv_filial       = @i_filial
       and cv_oficina      = @i_oficina
       and cv_producto     = @i_producto
       and cv_moneda       = @i_mon
       and cv_tipo         = 'R'
       and cv_tipo_cta     = @i_tipo_cta
       and (cv_cta_anterior is null
             or cv_cta_anterior = 'N')
       and cv_codigo_cta   = @w_cta_ofi -- lgr

    if @@error <> 0
    begin
      /* Error en actualizacion de registro en re_conversion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 255001
    end

  end
  else
  begin
    /* Combinacion no valida para la apertura */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251069
    return 251069
  end

  /*  En caso que el correlativo pase de 999,999 se toma otro prefijo */
  if @w_cta_sec > 99998
  begin
    update cob_remesas..re_conversion
    set    cv_tipo = 'U'
    where  cv_filial       = @i_filial
       and cv_oficina      = @i_oficina
       and cv_producto     = @i_producto
       and cv_moneda       = @i_mon
       and cv_tipo         = 'R'
       and cv_tipo_cta     = @i_tipo_cta
       and (cv_cta_anterior is null
             or cv_cta_anterior = 'N')

    set rowcount 1
    update cob_remesas..re_conversion
    set    cv_tipo = 'R'
    where  cv_filial       = @i_filial
       and cv_oficina      = @i_oficina
       and cv_producto     = @i_producto
       and cv_moneda       = @i_mon
       and cv_tipo         = 'N'
       and cv_tipo_cta     = @i_tipo_cta
       and (cv_cta_anterior is null
             or cv_cta_anterior = 'N')
       and cv_codigo_cta   > @w_cta_ofi

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en ah_cuenta */
      print 'No se ha definido prefijo para el producto: ' + convert(varchar(10)
            ,
            @i_producto)
            + ' Prod. Banc. ' + convert(varchar(10), @i_tipo_cta) + ' Moneda '
            + convert(varchar(10), @i_mon) + ' prefiko: ' + @w_cta_ofi
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 255001
    end
    set rowcount 0
  end

  /* Calculo del digito verificador */
  select
    @w_pesos = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'POP'
     and pa_producto = 'AHO'

  select
    @w_long_max_cta = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOP'
     and pa_producto = 'AHO'

  select
    @w_modulo = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'MOP'
     and pa_producto = 'AHO'

  /* secuencial */
  select
    @w_codigo = convert(varchar(24), @w_cta_sec)
  select
    @w_ceros = 5 - datalength(@w_codigo)
  select
    @w_codigo = replicate('0', @w_ceros) + @w_codigo

/* DENTRO DEL PRODUCTO SE TOMA LA OFICINA */
  /* tipo de cuenta ahorro (producto) */
  select
    @w_producto = convert(varchar(6), @w_cta_ofi)
  select
    @w_ceros = 6 - datalength(@w_producto)
  select
    @w_producto = @w_producto + replicate('0', @w_ceros)

  /* moneda */
  select
    @w_moneda = convert(varchar(2), @i_mon)
  select
    @w_ceros = 2 - datalength(@w_moneda)
  select
    @w_moneda = replicate('0', @w_ceros) + @w_moneda

  /* oficina */
  select
    @w_oficina = convert(varchar(4), @i_oficina)
  select
    @w_ceros = 4 - datalength(@w_oficina)
  select
    @w_oficina = replicate('0', @w_ceros) + @w_oficina

  --select    @w_cuenta = @w_oficina + @w_producto + @w_codigo

  select
    @w_cuenta = @w_producto + @w_codigo

  select
    @w_long_cta = datalength(@w_cuenta),
    @w_suma = 0,
    @w_indice_cta = 1
  select
    @w_indice_pesos = @w_long_max_cta - @w_long_cta

  while @w_indice_pesos < @w_long_max_cta
  begin
    select
      @w_valor_cta = convert(smallint, substring(@w_cuenta,
                                                 @w_indice_cta,
                                                 1)),
      @w_valor_pesos = convert(smallint, substring(@w_pesos,
                                                   @w_indice_pesos,
                                                   1))
    select
      @w_suma = @w_suma + @w_valor_cta * @w_valor_pesos
    select
      @w_indice_cta = @w_indice_cta + 1
    select
      @w_indice_pesos = @w_indice_pesos + 1
  end

  select
    @w_residuo = @w_suma % @w_modulo

  select
    @w_digito = @w_modulo - @w_residuo

  if @w_digito >= 10
    select
      @w_digito = 0

  select
    @o_cta_banco = @w_cuenta + convert(char(1), @w_digito)

  commit tran

  return 0

go

