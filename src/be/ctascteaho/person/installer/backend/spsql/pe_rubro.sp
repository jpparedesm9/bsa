/****************************************************************************/
/*     Archivo           : pe_rubros.sp                                     */
/*     Stored procedure  : sp_rubros                                        */
/*     Base de datos     : cob_remesas                                      */
/*     Producto          : Personalizacion                                  */
/*     Disenado por      :                                                  */
/*     Fecha de escritura: 02-Ene-1994                                      */
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
/*     Este programa inserta/elimina rubros                                 */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      JUN/95         J.Gordillo       Personalizacion Bco.Produccion      */
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
           where  name = 'sp_rubros')
  drop proc sp_rubros
go

create proc sp_rubros
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
  @i_operacion    char(1),
  @i_modo         tinyint=null,
  @i_pro_final    smallint = null,
  @i_cod_pfinal   smallint=null,
  @i_cod_subser   smallint=null,/* secuencial de servicio transaccion */
  @i_cod_detalle  catalogo=null,
  @i_moneda       tinyint=null,
  @i_producto     tinyint=null,
  @i_tipop        char(1)=null,
  @i_tipo_rango   tinyint=null,
  @i_grupo_rango  smallint = null,
  @i_rubro        smallint=null,
  @o_codigo       smallint=null out
)
as
  declare
    @w_sp_name  varchar(32),
    @w_return   int,
    @w_rubro    int,/*secuencial*/
    @w_producto tinyint

  select
    @w_sp_name = 'sp_rubros'

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
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_cod_pfinal = @i_cod_pfinal,
      i_cod_subser = @i_cod_subser,
      i_cod_detalle = @i_cod_detalle,
      i_producto = @i_producto,
      i_moneda = @i_moneda,
      i_tipop = @i_tipop,
      i_rubro = @i_rubro,
      i_tipo_rango = @i_tipo_rango

    exec cobis..sp_end_debug
  end

/*OPERACIONES */
  /**INSERTAR **/

  if @i_operacion = 'I'
  begin
    if @t_trn != 4015
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if not exists(select
                    *
                  from   pe_pro_final
                  where  pf_pro_final = @i_pro_final)
    begin
      /*no existe producto final asociado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351513
      return 351513
    end
    if not exists (select
                     *
                   from   pe_var_servicio
                   where  vs_servicio_dis = @i_cod_subser
                      and vs_rubro        = @i_cod_detalle)
    begin
      /*no existe subservicio asociado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351528
      return 351528
    end

    if not exists (select
                     *
                   from   pe_tipo_rango
                   where  tr_tipo_rango = @i_tipo_rango)
    begin
      /** no existe tipo de rango **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351507
      return 351507
    end

    select
      @w_producto = pf_producto
    from   pe_pro_final
    where  pf_pro_final = @i_pro_final

    if @w_producto != 70
      if exists (select
                   1
                 from   pe_servicio_per
                 where  sp_pro_final    = @i_pro_final
                    and sp_servicio_dis = @i_cod_subser
                    and sp_rubro        = @i_cod_detalle)
      begin
        /*Servicio personalizable ya existente*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351537
        return 351537
      end

    begin tran
    /*Encontramos el secuencial para el rubro */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_rubro out

    select
      @o_codigo = @w_rubro

    if @w_return != 0
      return @w_return

    /*Insertar un nuevo rubro*/
    insert into pe_servicio_per
                (sp_pro_final,sp_tipo_rango,sp_grupo_rango,sp_servicio_dis,
                 sp_rubro,
                 sp_servicio_per)
    values      (@i_pro_final,@i_tipo_rango,@i_grupo_rango,@i_cod_subser,
                 @i_cod_detalle,
                 @w_rubro)
    /*Ocurrio un error en la insercion de servicio personalizado*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353507
      return 353507
    end
    commit tran

    /*Retorna el nuevo codigo de rubro */

    select
      @o_codigo
    return 0
  end

  /**ELIMINAR**/

  if @i_operacion = 'D'
  begin
    if @t_trn != 4016
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if exists (select
                 *
               from   pe_costo
               where  co_servicio_per = @i_rubro)
    /*Hay registros asociados, no se puede eliminar*/
    begin
      /*Existe costo asociado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'Existe costo asociado',
        @i_num   = 351539
      return 351539
    end
    begin tran
    /*eliminacion del rubro*/
    delete from pe_servicio_per
    where  sp_servicio_per = @i_rubro
    if @@error != 0
    /*error en eliminacion de servicio personalizable*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357505
      return 357505
    end
    commit tran
    return 0
  end
/*
if @i_operacion = 'C'
begin
    if @t_trn !=4024
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
      select  'SECUENCIAL'=sp_servicio_per,
              'SERVICIO DISPONIBLE'=sp_servicio_dis,
              'VARIACION DE SERVICIO'= sp_rubro
      from    pe_servicio_per
      order by sp_servicio_per
    end

LOS 15 SIGUIENTES

   if @i_modo =1
      begin
      select  'SECUENCIAL'=sp_servicio_per,
              'SERVICIO DISPONIBLE'=sp_servicio_dis,
              'VARIACION DE SERVICIO'= sp_rubro
      from    pe_servicio_per
      where sp_servicio_per >  @i_rubro
      order by sp_servicio_per
        end
       set rowcount 0
end
return 0  */

go 
