/****************************************************************************/
/*     Archivo:          petirango.sp                                       */
/*     Stored procedure: sp_tip_rng_pe                                      */
/*     Base de datos:    cob_remesas                                        */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta//actualiza/consulta los tipos de rangos        */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      30/Sep/2003     Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tip_rng_pe')
  drop proc sp_tip_rng_pe
go

create proc sp_tip_rng_pe
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint=null,
  @i_tipo_rango   smallint=null,
  @i_descripcion  descripcion = null,
  @i_atributo     catalogo = null,
  @i_moneda       tinyint = null,
  @i_estado       char(1)=null
)
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_tipo_rango smallint,
    @w_estado     char(1)

  select
    @w_sp_name = 'sp_tip_rng_pe'

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
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_tipo_rango = @i_tipo_rango,
      i_descripcion = @i_descripcion,
      i_atributo = @i_atributo,
      i_estado = @i_estado
    exec cobis..sp_end_debug
  end

  /**Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn != 4032
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    /* Validaciones */
    if @i_estado not in ('V', 'N')
    begin
      /* Estado no esta definido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    if not exists (select
                     *
                   from   cobis..cl_catalogo
                   where  codigo = @i_atributo
                      and tabla  = (select
                                      codigo
                                    from   cobis..cl_tabla
                                    where  tabla = 'pe_tipo_atributo'))
    begin
      /*Error no existe atributo       */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351504
      return 351504
    end

    begin tran

    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_tipo_rango',
      @o_siguiente = @w_tipo_rango out

    if @w_return != 0
      return @w_return

    insert into pe_tipo_rango
                (tr_tipo_rango,tr_descripcion,tr_tipo_atributo,tr_moneda,
                 tr_estado
    )
    values      (@w_tipo_rango,@i_descripcion,@i_atributo,@i_moneda,@i_estado)

    /*Ocurrio un error en la insercion de tipo de rango*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353502
      return 353502
    end
    commit tran

    /*Retorna el nuevo codigo del rango   */
    select
      @w_tipo_rango

    return 0
  end

  /* Actualizacion  */
  if @i_operacion = 'U'
  begin
    if @t_trn != 4033
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    /* Validaciones */
    if @i_estado not in ('V', 'N')
    begin
      /* Estado no esta definido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    if not exists (select
                     *
                   from   cobis..cl_catalogo
                   where  codigo = @i_atributo
                      and tabla  = (select
                                      codigo
                                    from   cobis..cl_tabla
                                    where  tabla = 'pe_tipo_atributo'))
    begin
      /*Error no existe atributo       */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351504
      return 351504
    end

    select
      @w_estado = tr_estado
    from   pe_tipo_rango
    where  tr_tipo_rango = @i_tipo_rango

    if @@rowcount != 1
    begin
      /* No existe tipo de rango */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351507
      return 351507

    end

    begin tran
    update pe_tipo_rango
    set    tr_descripcion = @i_descripcion,
           tr_estado = @i_estado
    where  tr_tipo_rango    = @i_tipo_rango
       and tr_tipo_atributo = @i_atributo
       and tr_moneda        = @i_moneda

    /*Ocurrio un error en la actualizacion de tipo de rango*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355501
      return 355501
    end
    if @i_estado != @w_estado
    begin
      if exists (select
                   *
                 from   pe_rango
                 where  ra_tipo_rango = @i_tipo_rango)
      begin
        update pe_rango
        set    ra_estado = @i_estado
        where  ra_tipo_rango = @i_tipo_rango

        /*Ocurrio un error en la actualizacion de rango*/
        if @@error != 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 355508
          return 355508
        end
      end
    end
    commit tran
    return 0
  end

  /* Consulta */
  if @i_operacion = 'S'
  begin
    if @t_trn != 4034
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15
    select
      '1093' = tr_tipo_rango,                           --CODIGO
      '1185' = substring(tr_descripcion, 
                                1,
                                35),                    --DESC CODIGO
      '1021' = tr_tipo_atributo,                        --ATRIBUTO
      '1183' = substring(valor, 
                                  1,
                                  35),                 --DESC ATRIBUTO
      '1481' = tr_moneda,                              --MONEDA
      '1186' = substring(mo_descripcion, 
                                1,
                                15),                   --DESC MONEDA
      '1333' = tr_estado                               --ESTADO
    from   pe_tipo_rango,
           cobis..cl_catalogo,
           cobis..cl_moneda
    where  tr_tipo_atributo = codigo
       and mo_moneda        = tr_moneda
       and tabla            = (select
                                 codigo
                               from   cobis..cl_tabla
                               where  tabla = 'pe_tipo_atributo')
       and tr_tipo_rango    > @i_tipo_rango
    order  by tr_tipo_rango

    set rowcount 0
    return 0
  end

GO 
