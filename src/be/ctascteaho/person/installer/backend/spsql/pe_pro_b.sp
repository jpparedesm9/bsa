/****************************************************************************/
/*     Archivo:     pe_prod_b                                               */
/*     Stored procedure: sp_prod_bancario                                   */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
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
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    30/Sep/2003    Gloria Rueda   Retornar c¢digos de error               */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
/*    08/Junio/2016  Tania Baidal    Se elimina el substring de descripcion */
/*                                   de la opcion Q                         */
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
           where  name = 'sp_prod_bancario')
  drop proc sp_prod_bancario
go

create proc sp_prod_bancario
(
  @s_ssn           int,
  @s_srv           varchar(30)=null,
  @s_lsrv          varchar(30)=null,
  @s_user          varchar(30)=null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char (1),
  @s_ofi           smallint,
  @s_rol           smallint =1,
  @s_org_err       char(1)=null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1)='N',
  @t_file          varchar(14)=null,
  @t_from          varchar(32)=null,
  @t_rty           char(1)='N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_modo          tinyint= null,
  @i_codigo        smallint = 0,
  @i_descripcion   descripcion = null,
  @i_estado        char (1)=null,
  @i_formato_fecha int = 101,
  @o_codigo        smallint= null out
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_today   datetime,
    @w_codigo  int,
    @w_estado  char (1)

  select
    @w_sp_name = 'sp_prod_bancario',
    @w_today = @s_date

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_codigo = @i_codigo,
      i_descripcion = @i_descripcion,
      i_estado = @i_estado
    exec cobis..sp_end_debug
  end

/*OPERACIONES */
  /**INSERTAR **/

  if @i_operacion = 'I'
  begin
    if @t_trn != 4000
    begin
      /*Error en el codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if @i_estado not in ('V', 'N')
    begin
      /*Error en estado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end
    if exists (select
                 *
               from   pe_pro_bancario
               where  pb_descripcion = @i_descripcion
                  and pb_estado      = @i_estado)
    begin
      /*Ya existe producto bancario*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351536
      return 351536
    end

    begin tran
    /*Encontramos el secuencial para el producto bancario */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_pro_bancario',
      @o_siguiente = @w_codigo out
    if @w_return != 0
      return @w_return

    /*Insertar un nuevo producto */
    insert into pe_pro_bancario
                (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
    values      (@w_codigo,@i_descripcion,@i_estado,@w_today)
    /*Ocurrio un error en la insercion de producto bancario*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353504
      return 353504
    end
    commit tran

    /*Retorna el nuevo codigo del producto*/
    select
      @o_codigo = @w_codigo
    select
      @o_codigo
    return 0
  end

  /**ACTUALIZACION**/

  if @i_operacion = 'U'
  begin
    if @t_trn != 4001
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
                     *
                   from   pe_pro_bancario
                   where  pb_pro_bancario = @i_codigo)
    begin
      /*No existe producto bancario*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351508
      return 351508
    end

    begin tran
    /*Actualizacion del estado*/
    update pe_pro_bancario
    set    pb_estado = @i_estado,
           pb_fecha_estado = @w_today,
           pb_descripcion = @i_descripcion
    where  pb_pro_bancario = @i_codigo
    if @@rowcount != 1
    begin
      /*error en actualizacion del estado en producto bancario */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355502
      return 355502
    end
    update pe_mercado
    set    me_estado = @i_estado,
           me_fecha_estado = @w_today
    where  me_pro_bancario = @i_codigo
    if @@error != 0
    begin /*error en actualizacion de mercado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355503
      return 355503
    end
    commit tran
    return 0
  end

  /**BUSQUEDA **/
  if @i_operacion = 'S'
  begin
    if @t_trn != 4002
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
      '1093' = pb_pro_bancario,                                      --CODIGO
      '1196'=substring(pb_descripcion,                               --DESCRIPCION DE PROD. BANCARIO
                                                1,
                                                35),
      /* CHM Y2K */
      /*'FECHA DE ESTADO' = convert(char(10),pb_fecha_estado,101),*/
      '1358' = convert(char(10), pb_fecha_estado, @i_formato_fecha), --FECHA DE ESTADO
      '1333' = pb_estado                                             --ESTADO
    from   pe_pro_bancario
    where  pb_pro_bancario > @i_codigo
	order  by pb_pro_bancario
    set rowcount 0
    return 0
  end

  /**HELP **/
  if @i_operacion = 'H'
  begin
    if @t_trn != 4002
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
        '1093' = pb_pro_bancario,                       --CODIGO
         --'1896' = substring(pb_descripcion, 1, 25)                   --DESCRIPCION JCA BUG 76614
         '1896' = pb_descripcion                  --DESCRIPCION
      from   pe_pro_bancario
      where  pb_estado = 'V'
      order  by pb_pro_bancario
    end
    if @i_modo = 1
    begin
      select
        '1093' = pb_pro_bancario,                     --CODIGO
         --'1896' = substring(pb_descripcion, 1, 25)                   --DESCRIPCION JCA BUG 76614
         '1896' = pb_descripcion                  --DESCRIPCION
      from   pe_pro_bancario
      where  pb_pro_bancario > @i_codigo
         and pb_estado       = 'V'
      order  by pb_pro_bancario
    end
    set rowcount 0
    return 0
  end

/**QUERY**/
  /*Consulta para un registro especifico */
  if @i_operacion = 'Q'
  begin
    if @t_trn != 4003
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
      pb_descripcion,
      pb_estado,
      /*CHM Y2K */
      /*convert(char(10),pb_fecha_estado,101)*/
      convert(char(10), pb_fecha_estado, @i_formato_fecha)
    from   pe_pro_bancario
    where  pb_pro_bancario = @i_codigo
       and pb_estado       = 'V'
    if @@rowcount != 1
    begin
      /*No existe producto bancario*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351508
      return 351508
    end
    return 0
  end

go 
