/****************************************************************************/
/*     Archivo:     pelimite.sp                                             */
/*     Stored procedure: sp_limite                                          */
/*     Base de datos: cob_remesas                                           */
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
/*     Este programa inserta/actualiza/consulta de limites                  */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_limite')
  drop proc sp_limite
go

create proc sp_limite
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
  @s_org_err      char(1)=null,
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
  @i_servicio     smallint= null,
  @i_categoria    catalogo= null,
  @i_minimo       float= null,
  @i_maximo       float= null
)
as
  declare
    @w_sp_name   varchar(32),
    @w_tipo_dato char(1),
    @w_return    int

  select
    @w_sp_name = 'sp_limite'

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
      i_servicio = @i_servicio,
      i_categoria = @i_categoria,
      i_minimo = @i_minimo,
      i_maximo = @i_maximo
    exec cobis..sp_end_debug
  end

  if @i_operacion = 'I'
  begin
    /* Validaciones */
    if @t_trn != 4062
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      @w_tipo_dato = vs_tipo_dato
    from   pe_var_servicio,
           pe_servicio_per
    where  vs_servicio_dis = sp_servicio_dis
       and vs_rubro        = sp_rubro
       and sp_servicio_per = @i_servicio

    if @w_tipo_dato = 'P'
       and @i_maximo > 100
    begin
      /* Limite superior no es valido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351545
      return 351545
    end

    if exists (select
                 *
               from   pe_limite
               where  li_servicio_per = @i_servicio
                  and li_categoria    = @i_categoria)
    begin
      /* Ya existe limite para ese servicio y categoria */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351547
      return 351547
    end

    begin tran

    /*Insertar un nuevo limite    */
    insert into pe_limite
                (li_servicio_per,li_categoria,li_minimo,li_maximo)
    values      (@i_servicio,@i_categoria,@i_minimo,@i_maximo)

    /*Ocurrio un error en la insercion de limite*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353514
      return 353514
    end
    commit tran

    return 0
  end

  /* Actualiza */
  if @i_operacion = 'U'
  begin
    /* Validaciones */
    if @t_trn != 4063
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if not exists (select
                     *
                   from   pe_limite
                   where  li_servicio_per = @i_servicio
                      and li_categoria    = @i_categoria)
    begin
      /* No existe limite  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351541
      return 351541
    end

    begin tran

    update pe_limite
    set    li_minimo = @i_minimo,
           li_maximo = @i_maximo
    where  li_servicio_per = @i_servicio
       and li_categoria    = @i_categoria

    /*Ocurrio un error en la actualizacion de limite*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355516
      return 355516
    end
    commit tran
    return 0
  end

  /* Consulta */
  if @i_operacion = 'S'
  begin
    if @t_trn != 4064
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 20
    if @i_modo = 0
      select
        'CATEGORIA' = li_categoria,
        'MINIMO' = li_minimo,
        'MAXIMO' = li_maximo
      from   pe_limite
      where  li_servicio_per = @i_servicio
      order  by li_categoria
    else
    begin
      select
        'CATEGORIA' = li_categoria,
        'MINIMO' = li_minimo,
        'MAXIMO' = li_maximo
      from   pe_limite
      where  li_servicio_per = @i_servicio
         and li_categoria    > @i_categoria
      order  by li_categoria

    end

    set rowcount 0
    return 0
  end

  /* Query */
  if @i_operacion = 'Q'
  begin
    if @t_trn != 4065
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      li_minimo,
      li_maximo
    from   pe_limite
    where  li_servicio_per = @i_servicio
       and li_categoria    = @i_categoria

    if @@rowcount != 1
    begin
      /* No existen limites para ese servicio y categoria */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351542
      return 351542
    end
    return 0
  end

GO 
