/****************************************************************************/
/*     Archivo:          pe_profi.sp                                        */
/*     Stored procedure: sp_prodfin                                         */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
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
/*     Este programa inserta/elimina/actualiza/consulta de productos        */
/*     finales.                                                             */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA          AUTOR          RAZON                                   */
/*    JUN/1995       J.Gordillo     Personalizacion Bco. Produccion         */
/*    FEB/2001       E.Pulido       Cambio tabla cc_sector por cc_tipo_banca*/
/*    SEP/2003       Gloria Rueda   Retornar codigos de error               */
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
           where  name = 'sp_prodfin')
  drop proc sp_prodfin
go

create proc sp_prodfin
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
  @i_filial       tinyint = null,
  @i_sucursal     smallint = null,
  @i_operacion    char(2),
  @i_modo         tinyint = null,
  @i_descripcion  descripcion=null,
  @i_cod_merc     smallint= 0,
  @i_producto     tinyint= 0,
  @i_moneda       tinyint= 0,
  @i_tipop        catalogo=null,
  @i_pro_final    smallint = null,
  @o_pro_final    smallint = null out
)
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_pro_final  smallint,
    @w_codigo_cta varchar(6),
    @w_prodbanc   smallint,
    @w_pbancario  smallint,
    @w_lonprod    smallint

  select
    @w_sp_name = 'sp_prodfin'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/*OPERACIONES */
  /**INSERTAR **/

  if @i_operacion = 'I'
  begin
    if @t_trn <> 4008
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if not exists (select
                     1
                   from   cobis..cl_filial
                   where  fi_filial = @i_filial)
    begin
      /*Error en codigo de filial*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101002
    end

    if not exists (select
                     1
                   from   cobis..cl_sucursal
                   where  sucursal = @i_sucursal)
    begin
      /*Error en codigo de sucursal*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101028
    end
    if not exists (select
                     1
                   from   cobis..cl_pro_moneda
                   where  pm_moneda   = @i_moneda
                      and pm_producto = @i_producto
                      and pm_tipo     = @i_tipop)
    begin
      exec cobis..sp_cerror
      /*No existe moneda definida*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351510
      return 351510
    end

    select
      @w_prodbanc = me_pro_bancario
    from   pe_mercado
    where  me_mercado = @i_cod_merc

    if @@rowcount = 0
    begin
      /*No existe codigo de mercado definido*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351511
      return 351511
    end

    select
      @w_lonprod = datalength (convert(varchar(2), @w_prodbanc))
    select
      @w_codigo_cta = replicate (0, (2-@w_lonprod)) + convert (varchar(2),
                      @w_prodbanc
                      )

    if exists (select
                 1
               from   pe_pro_final
               where  pf_filial   = @i_filial
                  and pf_sucursal = @i_sucursal
                  and pf_mercado  = @i_cod_merc
                  and pf_producto = @i_producto
                  and pf_moneda   = @i_moneda
                  and pf_tipo     = @i_tipop)
    begin
      /* Ya existe ese codigo de producto final*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351517
      return 351517
    end

    begin tran
    /* Encontramos el secuencial de producto final */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_pro_final',
      @o_siguiente = @w_pro_final out
    if @w_return <> 0
      return @w_return

    /*Insertar un nuevo producto */
    insert into pe_pro_final
                (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,
                 pf_moneda,pf_tipo,pf_descripcion)
    values      ( @w_pro_final,@i_filial,@i_sucursal,@i_cod_merc,@i_producto,
                  @i_moneda,@i_tipop,@i_descripcion)

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

    /*Insertando registros en re_conversion*/
    insert into cob_remesas..re_conversion
                (cv_filial,cv_oficina,cv_producto,cv_moneda,cv_tipo,
                 cv_tipo_cta,cv_codigo_cta,cv_num_actual,cv_cta_anterior)
      select
        @i_filial,of_oficina,@i_producto,@i_moneda,'R',
        @w_prodbanc,(replicate(0, (4-datalength(convert(varchar(4), of_oficina))
                     )
                     )
         + convert(varchar(4), of_oficina)) + @w_codigo_cta,0,'N'
      from   cobis..cl_oficina
      where  (of_regional = @i_sucursal
               or of_oficina  = @i_sucursal)
         and (of_oficina not in (select
                                   cv_oficina
                                 from   cob_remesas..re_conversion
                                 where  cv_producto = @i_producto
                                    and cv_tipo_cta = @w_prodbanc))

    /*Ocurrio un error en la insercion de re_conversion*/
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353506
      return 353506
    end

    commit tran
    return 0
  end

  /**ACTUALIZACION**/
  if @i_operacion = 'U'
  begin
    if @t_trn <> 4009
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    begin tran
    /*Actualizar productos finales*/
    update pe_pro_final
    set    pf_descripcion = @i_descripcion
    where  pf_filial   = @i_filial
       and pf_sucursal = @i_sucursal
       and pf_producto = @i_producto
       and pf_moneda   = @i_moneda
       and pf_tipo     = @i_tipop
       and pf_mercado  = @i_cod_merc
    if @@rowcount <> 1
    begin
      /*Error en actualizacion de producto final*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355506
      return 355506
    end
    commit tran
    return 0
  end

  /**ELIMINAR**/
  if @i_operacion = 'D'
  begin
    if @t_trn <> 4010
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    /*Validacion que no exista un producto bancario asociado a la
      tabla de servicios personalizables*/

    if exists (select
                 1
               from   pe_servicio_per
               where  sp_pro_final in
                      (select
                         pf_pro_final
                       from   pe_pro_final
                       where  pf_filial   = @i_filial
                          and pf_sucursal = @i_sucursal
                          and pf_mercado  = @i_cod_merc
                          and pf_producto = @i_producto
                          and pf_moneda   = @i_moneda
                          and pf_tipo     = @i_tipop))
    begin
      /*Ya existe el servicio personalizable asociado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351512
      return 351512
    end

    select
      @w_prodbanc = me_pro_bancario
    from   pe_mercado
    where  me_mercado = @i_cod_merc

    begin tran
    /*eliminacion del producto final*/
    delete from pe_pro_final
    where  pf_filial   = @i_filial
       and pf_sucursal = @i_sucursal
       and pf_mercado  = @i_cod_merc
       and pf_producto = @i_producto
       and pf_moneda   = @i_moneda
       and pf_tipo     = @i_tipop
    if @@error <> 0
    /*error en eliminacion de producto final*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357504
      return 357504
    end

    delete re_conversion
    from   re_conversion,
           cobis..cl_oficina
    where  cv_oficina  = of_oficina
       and (of_regional = @i_sucursal
             or of_oficina  = @i_sucursal)
       and cv_filial   = @i_filial
       and cv_moneda   = @i_moneda
       and cv_tipo_cta = @w_prodbanc
       and cv_producto = @i_producto

    commit tran
    return 0
  end

  /**BUSQUEDA **/

  if @i_operacion = 'S'
  begin
    if @t_trn <> 4011
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    set rowcount 15
    select
      '1652' = pf_pro_final,                                                      --PROD.FINAL
      '1896' = substring(pf_descripcion,                                          --DESCRIPCION
                                1,
                                50),
      '1475' = pf_mercado,                                                        --MERCADO
      '1199' = substring(pb_descripcion, 1, 35) + ' ' +                           --DESCRIPCION DEL MERCADO
                                  substring(b.valor, 1, 15),
      '1653' = pf_producto,                                                       --PRODUCTO
      '1201' = substring(pm_descripcion,                                          --DESCRIPCION DEL PRODUCTO
                                             1,
                                             35),
      '1481' = pf_moneda,                                                          --MONEDA
      '1193' = substring(mo_descripcion,                                           --DESCRIPCION DE MONEDA
                                          1,
                                          25),
      '1742' = pf_tipo    ,                                                         --TIPO
	  '502098' =  pf_sucursal,
	  '502099' = (SELECT of_nombre FROM cobis..cl_oficina WHERE of_oficina= @i_sucursal AND of_filial=@i_filial AND of_subtipo = 'R')
	  
    from   pe_pro_final,
           cobis..cl_pro_moneda,
		   pe_mercado,
           pe_pro_bancario,
           cobis..cl_moneda,
           cobis..cl_tabla a,
           cobis..cl_catalogo b
	where  pf_producto     = pm_producto
       and pf_moneda       = pm_moneda
       and me_mercado      = pf_mercado
       and pb_pro_bancario = me_pro_bancario
       and mo_moneda       = pf_moneda
       and a.tabla         = 'cc_tipo_banca'
       and b.tabla         = a.codigo
       and b.codigo        = me_tipo_ente
       and pf_filial       = @i_filial
       and pf_sucursal     = @i_sucursal
       and pf_pro_final    > @i_pro_final
	     order  by pf_pro_final,
              pf_producto,
              pf_mercado,
              pf_moneda

    set rowcount 0
    return 0
  end

  if @i_operacion = 'S2'
  begin
    if @t_trn <> 4011
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15
    select
      '1652' = pf_pro_final,                                              --PROD.FINAL
      '1896' = substring(pf_descripcion, 
                                1,
                                50),                                      --DESCRIPCION
      '1475' = pf_mercado,                                                --MERCADO
      '1199' = substring(pb_descripcion,
                                            1,
                                            35),                          --DESCRIPCION DEL MERCADO
      '1653' = pf_producto,                                               --PRODUCTO
      '1201' = substring(pm_descripcion,
                                             1,
                                             35),                         --DESCRIPCION DEL PRODUCTO
      '1481' = pf_moneda,                                                 --MONEDA
      '1193' = substring(mo_descripcion,
                                          1,
                                          25),                            --DESCRIPCION DE MONEDA
      '1742' = pf_tipo                                                    --TIPO
    from   pe_pro_final,
           cobis..cl_pro_moneda,
           pe_mercado,
           pe_pro_bancario,
           cobis..cl_moneda
    where  pm_producto     = pf_producto
       and pm_moneda       = pf_moneda
       and mo_moneda       = pf_moneda
       and me_mercado      = pf_mercado
       and pb_pro_bancario = me_pro_bancario
       and pf_mercado in
           (select
              me_mercado
            from   pe_mercado
            where  me_tipo_ente = 'P')
       and pf_pro_final    > @i_pro_final
       and pf_filial       = @i_filial
       and pf_sucursal     = @i_sucursal
    order  by pf_pro_final
    set rowcount 0
    return 0
  end

  /* QUERY */
  if @i_operacion = 'Q'
  begin
    if @t_trn <> 4045
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      substring(pb_descripcion, 1, 50) + ' ' + substring(b.valor, 1, 15)
    from   pe_mercado,
           pe_pro_bancario,
           cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  me_pro_bancario = pb_pro_bancario
       and me_mercado      = @i_cod_merc
       and a.tabla         = 'cc_tipo_banca'
       and b.tabla         = a.codigo
       and b.codigo        = me_tipo_ente
    order  by me_mercado

    if @@rowcount = 0
    begin
      /*error en consulta de producto final*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351527
      return 351527
    end
    return 0
  end

  /**CONSULTA **/

  if @i_operacion = 'C'
  begin
    if @t_trn <> 4012
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15
    if @i_modo = 0
    begin
      select
        '1475' = me_mercado,                          --MERCADO
        '1896' = substring(pb_descripcion,
                                  1,
                                  50),                --DESCRIPCION
        '1752'= substring(valor, 
                                    1,
                                    15)               --TIPO DE SECTOR
      from   pe_mercado,
             pe_pro_bancario,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  me_pro_bancario = pb_pro_bancario
         and a.tabla         = 'cc_tipo_banca'
         and b.tabla         = a.codigo
         and b.codigo        = me_tipo_ente
         and me_estado       = 'V'
      order  by me_mercado
    end
    else if @i_modo = 1
    begin
      select
        '1475' = me_mercado,                        --MERCADO
        '1896' = substring(pb_descripcion,   
                                  1,
                                  50),              --DESCRIPCION
        '1752'= substring(valor,  
                                    1,
                                    15)             --TIPO DE SECTOR
      from   pe_mercado,
             pe_pro_bancario,
             cobis..cl_tabla a,
             cobis..cl_catalogo b
      where  me_mercado      > @i_cod_merc
         and me_pro_bancario = pb_pro_bancario
         and a.tabla         = 'cc_tipo_banca'
         and b.tabla         = a.codigo
         and b.codigo        = me_tipo_ente
         and me_estado       = 'V'
      order  by me_mercado
    end
    set rowcount 0
    return 0
  end

  if @i_operacion = 'H'
  begin
    if @t_trn <> 4077
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

	SELECT @w_pbancario = me_pro_bancario
	FROM   cob_remesas..pe_mercado
	INNER  JOIN cob_remesas..pe_pro_final ON me_mercado = pf_mercado
	WHERE  pf_pro_final  = @i_pro_final
    and    pf_filial     = @i_filial
    and    pf_sucursal   = @i_sucursal

    select
      pf_descripcion,
      pf_moneda,
      pf_producto,
	  @w_pbancario
    from   pe_pro_final
    where  pf_pro_final = @i_pro_final
       and pf_filial    = @i_filial
       and pf_sucursal  = @i_sucursal

    if @@rowcount <> 1
    begin
      /*No existe producto final*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351527
      return 351527
    end
			
    return 0
  end

  if @i_operacion = 'H2'
  begin
    if @t_trn <> 4077
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if not exists (select
                     1
                   from   pe_pro_final
                   where  pf_pro_final = @i_pro_final
                      and pf_mercado in
                          (select
                             me_mercado
                           from   pe_mercado
                           where  me_tipo_ente = 'P'))
    begin
      /* Mercado no es de tipo ente Persona */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351557
      return 351557
    end

    select
      substring(pf_descripcion,
                1,
                50)
    from   pe_pro_final
    where  pf_pro_final = @i_pro_final
       and pf_filial    = @i_filial
       and pf_sucursal  = @i_sucursal

    if @@rowcount <> 1
    begin
      /* No existe Producto Final */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351527
      return 351527
    end
    return 0
  end
  
go 
