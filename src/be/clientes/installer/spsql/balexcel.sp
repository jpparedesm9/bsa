/************************************************************************/
/*   Archivo:            balanexc.sp                                    */
/*   Stored procedure:   sp_balance_excel                               */
/*   Base de datos:      cobis                                          */
/*   Producto:           MIS                                            */
/*   Disenado por:       Carlos Rodriguez V.                            */
/*   Fecha de escritura: 18/Enero/94                                    */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Este stored procedure retorna los tres ultimos balances de un      */
/*   cliente, retorna el plan de cuentas y su descripcion               */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   Agosto 1/2001  E. Laguna      Retorno de 3 ultimos ordenados       */
/*   May/02/2016    DFu            Migracion CEN                        */
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
           where  name = 'sp_balance_excel')
  drop proc sp_balance_excel
go

create proc sp_balance_excel
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar (30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         descripcion = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_balance      smallint = null,
  @i_cliente      int = null,
  @i_tbalance     catalogo = null
)
as
  declare
    @w_sp_name  descripcion,
    @w_return   int,
    @w_contador tinyint,
    @w_anio     smallint

  /*  Inicializar nombre del stored procedure  */
  select
    @w_sp_name = 'sp_balance_excel'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if not ((@i_operacion = 'B'
           and @t_trn = 1250)
           or (@i_operacion = 'V'
               and @t_trn = 1252)
           or (@i_operacion = 'P'
               and @t_trn = 1251))
  begin
    /* Codigo de transaccion invalido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  /* ** Balance ** */
  if @i_operacion = 'B'
  begin
    set rowcount 3

    select
      @w_anio = max(ba_anio)
    from   cl_balance
    where  ba_cliente  = @i_cliente
       and ba_tbalance = @i_tbalance

    create table #tmpbal
    (
      balance      smallint null,
      tipo_balance char(3) null,
      anio         smallint null,
      mes          varchar(15)
    )

    insert into #tmpbal
      select
        ba_balance,ba_tbalance,ba_anio,convert(varchar(2), datepart(mm,
                                     ba_fecha_corte))
      from   cl_balance
      where  ba_cliente  = @i_cliente
         and ba_tbalance = @i_tbalance
         --and    ba_anio >= datepart(yy,@s_date) - 4 
         --and    ba_anio >= datepart(yy,getdate()) - 4  ELA ENVIAR 3 ULTIMOS AÑOS A LAS HOJAS
         and ba_anio     >= datepart(yy,
                                     getdate()) - 3
      order  by ba_anio desc

    select
      @w_contador = count(*)
    from   #tmpbal
    where  tipo_balance = @i_tbalance

    while @w_contador < 3
    begin
      insert into #tmpbal
      values      (0,@i_tbalance,(@w_anio - @w_contador),'')
      select
        @w_contador = @w_contador + 1
    end

    update #tmpbal
    set    mes = 'ENERO'
    where  mes = '1'
    update #tmpbal
    set    mes = 'FEBRERO'
    where  mes = '2'
    update #tmpbal
    set    mes = 'MARZO'
    where  mes = '3'
    update #tmpbal
    set    mes = 'ABRIL'
    where  mes = '4'
    update #tmpbal
    set    mes = 'MAYO'
    where  mes = '5'
    update #tmpbal
    set    mes = 'JUNIO'
    where  mes = '6'
    update #tmpbal
    set    mes = 'JULIO'
    where  mes = '7'
    update #tmpbal
    set    mes = 'AGOSTO'
    where  mes = '8'
    update #tmpbal
    set    mes = 'SEPTIEMBRE'
    where  mes = '9'
    update #tmpbal
    set    mes = 'OCTUBRE'
    where  mes = '10'
    update #tmpbal
    set    mes = 'NOVIEMBRE'
    where  mes = '11'
    update #tmpbal
    set    mes = 'DICIEMBRE'
    where  mes = '12'

    select
      *
    from   #tmpbal
    where  anio >= datepart(yy,
                            getdate()) - 3
    order  by anio asc

    /* Si no encuentra balance, error */
    if @@error <> 0
    begin
      /* No existe balance para este cliente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101156
      return 1
    end
    set rowcount 0
  end

  /* ** Plan de Cuentas ** */
  if @i_operacion = 'P'
  begin
    select
      ct_cuenta,
      substring(ct_descripcion,
                1,
                40)
    from   cl_tplan,
           cl_cuenta
    where  tp_tbalance = @i_tbalance
       and tp_cuenta   = ct_cuenta
    order  by ct_cuenta

    /* Si no se pudo consultar, error */
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        /* No existen cuentas asociadas a este tipo de balance */
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101157
      return 1
    end
  end

  /*** Valores de plan de cuentas ***/
  if @i_operacion = 'V'
  begin
    select
      pl_valor
    from   cl_plan
           left outer join cl_tplan
                        on pl_cuenta = tp_cuenta
                           and tp_tbalance = @i_tbalance
    --where  pl_cuenta   = *  tp_cuenta
    where  pl_cliente = @i_cliente
       and pl_balance = @i_balance

    /* Si no se retornan valores, error */
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101158
      return 1
    end
  end
  return 0

go

