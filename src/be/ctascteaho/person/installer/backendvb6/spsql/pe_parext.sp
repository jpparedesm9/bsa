/****************************************************************************/
/*     Archivo:          pe_parext.sp                                       */
/*     Stored procedure: sp_parametro_extracto                              */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:     S.Molano                                           */
/*     Fecha de escritura: 27-Sep-2011                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta/elimina/actualiza/parametrizacion              */
/*     extractos                                                            */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA          AUTOR          RAZON                                   */
/*    Sep/2011       S.Molano       Emision Inicial                         */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_parametro_extracto')
  drop proc sp_parametro_extracto
go

create proc sp_parametro_extracto
(
  @s_ssn          int,
  @s_srv          varchar(30)=null,
  @s_lsrv         varchar(30)=null,
  @s_user         varchar(30)=null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char (1),
  @s_ofi          smallint,
  @s_rol          smallint =1,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1)='N',
  @t_file         varchar(14)=null,
  @t_from         varchar(32)=null,
  @t_rty          char(1)='N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(2),
  @i_modo         tinyint = null,
  @i_descripcion  descripcion=null,
  @i_cod_merc     smallint= 0,
  @i_producto     tinyint= 0,
  @i_valor        smallint = null,
  @i_profinal     smallint = null,
  @i_fecha_mod    datetime = null,
  @i_codigo       tinyint= 0,
  @i_tipo         tinyint= 0,
  @i_categoria    char(1) = null,
  @o_pro_final    smallint = null out
)
as
  declare
    @w_sp_name       varchar(32),
    @w_return        int,
    @w_pro_final     smallint,
    @w_fecha_proceso datetime,
    @w_cant          smallint,
    @w_desde         smallint,
    @w_hasta         smallint,
    @w_anos          smallint,
    @w_cont          smallint

  select
    @w_sp_name = 'sp_parametro_extracto'
  truncate table cob_ahorros..ah_ano

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- VALIDACION DE TRANSACCION
  if (@t_trn <> 4136
      and @i_operacion = 'I')
      or (@t_trn <> 4139
          and @i_operacion = 'D')
      or (@t_trn <> 4137
          and @i_operacion = 'U')
      or (@t_trn <> 4140
          and (@i_operacion = 'S'
                or @i_operacion = 'V'
                or @i_operacion = 'V1'))
      or (@t_trn <> 4138
          and (@i_operacion = 'S2'
                or @i_operacion = 'S3'))
  begin
    --Transaccion no valida
    exec cobis..sp_cerror
      @i_num  = 351516,
      @t_from = @w_sp_name
    return 351516
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  --INSERTAR
  if @i_operacion in ('I', 'U', 'D')
  begin
    if @i_operacion = 'I'
    begin
      -- Valida Existencia
      if exists (select
                   *
                 from   cob_remesas..re_parametro_extracto
                 where  pe_producto  = @i_producto
                    and pe_prodbanc  = @i_profinal
                    and pe_categoria = @i_categoria)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357529
        return 357529
      end

      -- Encontramos el secuencial de producto final
      exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @i_tabla     = 're_parametro_extracto',
        @o_siguiente = @w_pro_final out
      if @w_return <> 0
        return @w_return

      --Insertar un nuevo producto
      insert into re_parametro_extracto
                  (pe_codigo,pe_producto,pe_prodbanc,pe_valor,pe_login,
                   pe_fecha,pe_fecha_mod,pe_categoria)
      values      ( @w_pro_final,@i_producto,@i_profinal,@i_valor,@s_user,
                    @w_fecha_proceso,@i_fecha_mod,@i_categoria)

      /*Ocurrio un error en la insercion de producto final*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353506
        return 353506
      end
    end

    if @i_operacion = 'U'
    begin
      select
        @w_cant = pe_valor
      from   re_parametro_extracto
      where  pe_producto  = @i_producto
         and pe_prodbanc  = @i_profinal
         and pe_categoria = @i_categoria

      if (@@rowcount = 0)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357530
        return 357530
      end

      update re_parametro_extracto
      set    pe_valor = @i_valor
      where  pe_producto  = @i_producto
         and pe_prodbanc  = @i_profinal
         and pe_categoria = @i_categoria

      if @@error <> 0 --or @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357531
        return 357531
      end
    end

    if @i_operacion = 'D'
    begin
      if not exists (select
                       1
                     from   re_parametro_extracto
                     where  pe_producto  = @i_producto
                        and pe_prodbanc  = @i_profinal
                        and pe_categoria = @i_categoria)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357530
        -- No existe Registro
        return 357530
      end

      delete from re_parametro_extracto
      where  pe_producto  = @i_producto
         and pe_prodbanc  = @i_profinal
         and pe_categoria = @i_categoria

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357533
        return 357533
      end
    end

    select
      '1093' = pe_codigo,
      '1653' = pf_producto,
      '1201' = substring(pm_descripcion,
                                             1,
                                             35),
      '1656' = pe_prodbanc,
      '1189' = substring(pf_descripcion,
                                1,
                                50),
      '1797' = pe_valor,
      '1063' = pe_categoria
    from   cob_remesas..re_parametro_extracto,
           cob_remesas..pe_pro_final,
           cobis..cl_pro_moneda
    where  pe_producto  = pf_producto
       and pm_producto  = pe_producto
       and pf_pro_final = @i_profinal
       and pf_producto  = @i_producto
       and pe_categoria = @i_categoria
    order  by pe_codigo,
              pe_prodbanc

  /* if (@@rowcount = 0)
   begin
     exec cobis..sp_cerror
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 357530
     return 357530
   end */
    -- Creacion de Transaccion de Servicio
    if @i_producto = 4 -- CTAS DE AHORROS
    begin
      insert into cob_ahorros..ah_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                   ts_terminal,
                   ts_oficina,ts_hora,ts_valor,ts_producto,ts_indicador,
                   ts_accion,ts_categoria)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @s_ofi,getdate(),@i_valor,@i_producto,@i_profinal,
                   @i_operacion,@i_categoria)

      -- Error en creacion de transaccion de servicio
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
    end
    else
    begin -- Transaccion de servicios en Cuentas corrientes
      insert into cob_cuentas..cc_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                   ts_terminal,
                   ts_oficina,ts_hora,ts_valor,ts_producto,ts_indicador,
                   ts_estado,ts_tipocta)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @s_ofi,getdate(),@i_valor,@i_producto,@i_profinal,
                   @i_operacion,@i_categoria)

      -- Error en creacion de transaccion de servicio
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
    end
  end

  if @i_operacion = 'S'
  begin
    set rowcount 20

    select
      'PROD.FINAL' = pf_pro_final,
      'DESCRIPCION' = substring(pf_descripcion,
                                1,
                                50)
    from   pe_pro_final
    where  pf_producto = @i_producto
    order  by pf_producto

    set rowcount 0
  end

  if @i_operacion = 'V'
  begin
    select
      'DESCRIPCION' = substring(pf_descripcion,
                                1,
                                50)
    from   pe_pro_final
    where  pf_producto  = @i_producto
       and pf_pro_final = @i_profinal
    order  by pf_producto

    if (@@rowcount = 0)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357534
      return 357534
    end
  end

  if @i_operacion = 'V1'
  begin
    --print '@i_profinal' + convert(varchar(5),@i_profinal)
    if @i_modo = 1
    begin
      select
        'CODIGO' = cp_categoria,
        'DESCRIPCION' = valor
      from   cob_remesas..pe_categoria_profinal,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  cp_profinal = @i_profinal
         and a.tabla     = 'pe_categoria'
         and a.codigo    = b.tabla
         and b.codigo    = cp_categoria

      if (@@rowcount = 0)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357535
        return 357535
      end
    end
    if @i_modo = 2
    begin
      select
        'DESCRIPCION' = valor
      from   cob_remesas..pe_categoria_profinal,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  cp_profinal  = @i_profinal
         and a.tabla      = 'pe_categoria'
         and a.codigo     = b.tabla
         and b.codigo     = cp_categoria
         and cp_categoria = @i_categoria

      if (@@rowcount = 0)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357535
        return 357535
      end
    end
    return 0
  end

  if @i_operacion = 'S2'
  begin
    set rowcount 20
    select
      '1093' = pe_codigo,
      '1653' = pf_producto,
      '1201' = substring(pm_descripcion,
                                             1,
                                             35),
      '1656' = pe_prodbanc,
      '1189' = substring(pf_descripcion,
                                1,
                                50),
      '1797' = pe_valor,
      '1063' = pe_categoria
    from   cob_remesas..re_parametro_extracto,
           cob_remesas..pe_pro_final,
           cobis..cl_pro_moneda
    where  pe_prodbanc  = pf_pro_final
       and pe_producto  = pf_producto
       and pe_producto  = pm_producto
       and pf_producto  = @i_producto
       and pf_pro_final = isnull (@i_profinal,
                                  pf_pro_final)
       and pe_categoria = isnull (@i_categoria,
                                  pe_categoria)
    order  by pe_codigo,
              pe_prodbanc

    if (@@rowcount = 0)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357530
      return 357530
    end
    set rowcount 0
  end

  if @i_operacion = 'S3'
  begin
    set rowcount 20
    select
      '1093' = pe_codigo,
      '1653' = pf_producto,
      '1201' = substring(pm_descripcion,
                                             1,
                                             35),
      '1656' = pe_prodbanc,
      '1189' = substring(pf_descripcion,
                                1,
                                50),
      '1797' = pe_valor,
      '1063' = pe_categoria
    from   cob_remesas..re_parametro_extracto,
           cob_remesas..pe_pro_final,
           cobis..cl_pro_moneda
    where  pe_prodbanc = pf_pro_final
       and pe_producto = pf_producto
       and pe_producto = pm_producto
       and pf_producto = @i_producto
       and pe_codigo   > @i_codigo
    order  by pe_codigo,
              pe_prodbanc

    /*if (@@rowcount = 0)
    begin
      exec cobis..sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 357530
      return 357530
    end*/
    set rowcount 0
  end
  --Consulta Mes
  if @i_operacion = 'X'
  begin
    if @i_tipo = 1
      select
        '1093' = a.codigo,
        '1189' = a.valor
      from   cobis..cl_catalogo a,
             cobis..cl_tabla b
      where  a.tabla = b.codigo
         and b.tabla = 're_mes'

    if @i_tipo = 2
      select
        '1189' = a.valor
      from   cobis..cl_catalogo a,
             cobis..cl_tabla b
      where  a.tabla  = b.codigo
         and b.tabla  = 're_mes'
         and a.codigo = @i_codigo
  end

  if @i_operacion = 'A'
  begin
    select
      @w_anos = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'NANOS'

    select
      @w_cont = 1

    select
      @w_hasta = (datepart (yy,
                            fp_fecha))
    from   cobis..ba_fecha_proceso

    while @w_cont <= @w_anos
    begin
      insert into cob_ahorros..ah_ano
      values      (@w_hasta)

      select
        @w_hasta = @w_hasta - 1
      select
        @w_cont = @w_cont + 1
    end
    select
      '1093' = ah_ano,
      ''
    from   cob_ahorros..ah_ano
  end

  return 0

go 
