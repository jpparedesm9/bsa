/************************************************************************/
/*    Archivo:              cl_busmasiva.sp                             */
/*    Stored procedure:     sp_busqueda_masiva                          */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Giovanni White                              */
/*    Fecha de escritura:   19-Mar-2003                                 */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Consulta en Linea Masiva Centralizada                             */
/*    Este programa procesa la tabla cl_plano_consulta y realiza el     */
/*    llenado de la tabla cl_consulta_masiva                            */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*      FECHA       AUTOR             RAZON                             */
/*    19/Mar/03   Giovanni White    Emision Inicial                     */
/*    19/Sep/03   Diego Duran       Validacion cuando no existe Nit     */
/*    14/Ene/05   Diego Duran       Optimizacion consulta de Productos  */
/*    02/May/16   DFu               Migracion CEN                       */
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
           where  name = 'sp_busqueda_masiva')
  drop proc sp_busqueda_masiva
go

create proc sp_busqueda_masiva
(
  @i_archivo      varchar(50),
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name      varchar(32),
    @w_registros    int,
    @w_return       int,
    @w_tipo_doc     char(2),
    @w_num_doc      numero,
    @w_ente         int,
    @w_ced_ruc      numero,
    @w_tipo_ced     char(2),
    @w_nomlar       varchar(254),
    @w_cuenta       cuenta,
    @w_oficina      smallint,
    @w_saldo        money,
    @w_estado_ser   char(1),
    @w_fecha_cambio datetime,
    @w_fecha        datetime,
    @w_sino         char(1)

  select
    @w_sp_name = 'sp_busqueda_masiva'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -----------------------------------------
  -- Cursor sobre la tabla cl_cli_masiva --
  -----------------------------------------
  declare planoconsulta cursor for
    select
      pc_tipo_doc,
      pc_num_doc
    from   cobis..cl_plano_consulta
  -----------------
  -- Abre cursor --
  -----------------
  open planoconsulta
  --------------------------------------
  -- Ubica primer registro del cursor --
  --------------------------------------
  fetch planoconsulta into @w_tipo_doc, @w_num_doc

  -----------------------------------
  -- Control del estado del cursor --
  -----------------------------------
  if @@fetch_status = -2
  begin
    close planoconsulta
    deallocate planoconsulta
    print 'Salida SqlStatus = 1'
    return 2
  end
  else if @@fetch_status = -1
  begin
    close planoconsulta
    deallocate planoconsulta
    print 'Salida SqlStatus = 2'
    return 2
  end

  ----------------------------
  -- Proceso de informacion --
  ----------------------------
  while @@fetch_status <> -1
  begin
    select
      @w_sino = 'S'
    select
      @w_cuenta = null
    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close planoconsulta
      deallocate planoconsulta
      print 'Aborta ... cursor planoconsulta'
      return 2
    end

    if @w_tipo_doc is not null
    begin
      insert into cobis..cl_consulta_masiva
                  (cm_ente,cm_ced_ruc,cm_tipo_ced,cm_nomlar,cm_cuenta,
                   cm_oficina,cm_saldo,cm_estado_ser,cm_fecha_cambio,cm_fecha,
                   cm_encontrado,cm_archivo)
        select
          en_ente,en_ced_ruc,en_tipo_ced,en_nomlar,dp_cuenta,
          dp_oficina,dp_saldo,dp_estado_ser,dp_fecha_cambio,dp_fecha,
          @w_sino,upper(@i_archivo)
        from   cobis..cl_det_producto,
               cobis..cl_cliente,
               cobis..cl_ente
        where  en_tipo_ced     = @w_tipo_doc
           and en_ced_ruc      = @w_num_doc
           and cl_cliente      = en_ente
           and dp_det_producto = cl_det_producto

      if @@rowcount = 0
      begin /* CERO Registros */
        select
          @w_sino = 'N',
          @w_ente = 0,
          @w_ced_ruc = @w_num_doc,
          @w_tipo_ced = @w_tipo_doc,
          @w_nomlar = '*** NO ENCONTRADO ***'

        /* Insert o Update a la Tabla CL_ENTE */
        insert into cobis..cl_consulta_masiva
                    (cm_ente,cm_ced_ruc,cm_tipo_ced,cm_nomlar,cm_cuenta,
                     cm_oficina,cm_saldo,cm_estado_ser,cm_fecha_cambio,cm_fecha,
                     cm_encontrado,cm_archivo)
        values      (@w_ente,@w_ced_ruc,@w_tipo_ced,@w_nomlar,@w_cuenta,
                     @w_oficina,@w_saldo,@w_estado_ser,@w_fecha_cambio,@w_fecha,
                     @w_sino,upper(@i_archivo))

        if @@error != 0
        begin
          print 'ERROR en Insert cl_consulta_masiva'
          rollback

        end
      end
      goto LEER

    end

  /* ------------------------------------------ */
  /* Etiqueta LEER                              */
    /* ------------------------------------------ */
    LEER:
    -- Hace la lectura del siguiente registro en el cursor
    fetch planoconsulta into @w_tipo_doc, @w_num_doc

    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close planoconsulta
      deallocate planoconsulta
      return 2
    end
  end /* --> Fin del While @@fetch_status */
  --print 'FIN DEL While SqlStatus'

  ------------------------------------
  -- Cierra cursor y libera memoria --
  ------------------------------------
  close planoconsulta
  deallocate planoconsulta

  print ' Fin Ejecucion sp_busqueda_masiva'
  print '.'

  return 0

go

