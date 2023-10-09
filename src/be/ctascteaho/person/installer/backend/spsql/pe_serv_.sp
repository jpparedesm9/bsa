/****************************************************************************/
/*     Archivo           : pe_serv_cont                                     */
/*     Stored procedure  : sp_serv_contratado                               */
/*     Base de datos     : cob_remesas                                      */
/*     Producto          : Personalizacion                                  */
/*     Disenado por      :                                                  */
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
/*    30/Sep/2003      Gloria Rueda     Retornar c¢digos de error           */
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
           where  name = 'sp_serv_contratado')
  drop proc sp_serv_contratado
go

create proc sp_serv_contratado
(
  @s_ssn           int,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_user          varchar(30) = null,
  @s_sesn          int=null,
  @s_term          varchar(10)=null,
  @s_date          datetime=null,
  @s_org           char(1)=null,
  @s_ofi           smallint=null,
  @s_rol           smallint=null,
  @s_org_err       char(1)=null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint=null,
  @t_show_version  bit = 0,
  @i_operacion     char(1)=null,
  @i_modo          tinyint=null,
  @i_tipo          char(1)=null,
  @i_servicio_dis  smallint=null,
  @i_codigo        cuenta=null,
  @i_ciclo         catalogo=null,
  @i_tipo_val      char (1)=null,
  @i_valor         money=null,
  @i_estado        char (1)=null,
  @i_fecha_estado  datetime=null,
  @i_producto      tinyint=null,
  @i_formato_fecha int = 101
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_codigo  int,
    @w_today   datetime

  select
    @w_sp_name = 'sp_serv_contratado',
    @w_today = getdate()

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
      i_modo = @i_modo,
      i_tipo = @i_tipo,
      i_servicio_dis = @i_servicio_dis,
      i_codigo = @i_codigo,
      i_ciclo = @i_ciclo,
      i_tipo_val = @i_tipo_val,
      i_valor = @i_valor,
      i_estado = @i_estado,
      i_fecha_estado = @i_fecha_estado,
      i_producto = @i_producto

    exec cobis..sp_end_debug
  end

  if @i_producto not in (3, 4)
  /*Producto no valido */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351518
    return 351518
  end
  if @i_producto = 3
  begin
    if not exists (select
                     *
                   from   cob_cuentas..cc_ctacte
                   where  cc_cta_banco = @i_codigo)
    /*No existe esa cuenta corriente*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351522
      return 351522
    end
    else
    begin
      select
        @w_codigo = cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_codigo
    end
  end
  else
  begin
    if not exists (select
                     *
                   from   cob_ahorros..ah_cuenta
                   where  ah_cta_banco = @i_codigo)
    /*No existe esa cuenta de ahorro*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351523
      return 351523
    end
    else
    begin
      select
        @w_codigo = ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_codigo
    end
  end

/*Operaciones */
  /**Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn != 4019
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
                   from   pe_servicio_dis
                   where  sd_servicio_dis = @i_servicio_dis)
    /*No existe ese servicio disponible */
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351501
      return 351501
    end

    if exists (select
                 *
               from   pe_servicio_contr
               where  sc_servicio_dis = @i_servicio_dis
                  and sc_producto     = @i_producto
                  and sc_codigo       = @w_codigo
                  and sc_ciclo        = @i_ciclo
                  and sc_tipo         = @i_tipo_val
                  and sc_valor        = @i_valor
                  and sc_estado       = @i_estado)
    begin
      /*Servicio contratado ya existente*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351538
      return 351538
    end

    begin tran

    /*Insertar un nuevo servicio contratado */
    insert into pe_servicio_contr
                (sc_servicio_dis,sc_codigo,sc_producto,sc_ciclo,sc_tipo,
                 sc_valor,sc_estado,sc_fecha_estado)
    values      (@i_servicio_dis,@w_codigo,@i_producto,@i_ciclo,@i_tipo_val,
                 @i_valor,@i_estado,@w_today)

    /*Ocurrio un error en la insercion de servicio contratado*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353508
      return 353508
    end
    commit tran
  end

  /**ACTUALIZACION**/
  if @i_operacion = 'U'
  begin
    if @t_trn != 4020
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
    /*Actualizacion del servicio contratado*/
    update pe_servicio_contr
    set    sc_servicio_dis = @i_servicio_dis,
           sc_ciclo = @i_ciclo,
           sc_tipo = @i_tipo_val,
           sc_valor = @i_valor,
           sc_estado = @i_estado,
           sc_fecha_estado = @w_today
    where  sc_servicio_dis = @i_servicio_dis
       and sc_codigo       = @w_codigo
       and sc_producto     = @i_producto
    if @@error != 0
    begin /*error en actualizacion de servicio contratado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355512
      return 355512
    end
    commit tran
    return 0
  end

  /**BUSQUEDA **/
  if @i_operacion = 'S'
  begin
    if @t_trn != 4021
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
      '1710' = sc_servicio_dis,                                       --SERVICIO
      '1187' = substring(sd_descripcion,                              
                                  1,                                  
                                  35),                                --DESC SERVICIO
      '1080' = sc_ciclo,                                              --CICLO
      '1184' = substring(b.valor,                                     
                               1,                                     
                               15),                                   --DESC CICLO
      /*CHM Y2K */
      /*'FECHA DE ESTADO'     = convert(char(10),sc_fecha_estado,101),*/
      '1358' = convert(char(10), sc_fecha_estado, @i_formato_fecha),  --FECHA DE ESTADO
      '1333' = sc_estado                                              --ESTADO
    from   pe_servicio_contr,
           pe_servicio_dis,
           cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  sc_servicio_dis > @i_servicio_dis
       and sc_codigo       = @w_codigo
       and sc_producto     = @i_producto
       and sd_servicio_dis = sc_servicio_dis
       and a.tabla         = 'pe_ciclo'
       and b.tabla         = a.codigo
       and b.codigo        = sc_ciclo
    order  by sc_servicio_dis
    set rowcount 0

    return 0
  end

/**QUERY**/
  /*Consulta para actualizar un registro especifico */
  if @i_operacion = 'Q'
  begin
    if @t_trn != 4022
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
      sc_servicio_dis,
      sc_ciclo,
      sc_tipo,
      sc_valor,
      sc_estado,
      /*CHM Y2K */
      /*convert(char(10),sc_fecha_estado,101)*/
      convert(char(10), sc_fecha_estado, @i_formato_fecha)
    from   pe_servicio_contr
    where  sc_servicio_dis = @i_servicio_dis
       and sc_codigo       = @w_codigo
       and sc_producto     = @i_producto
    if @@rowcount = 0
    begin
      /*No existe servicio solicitado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351515
      return 351515
    end
    return 0
  end

go 
