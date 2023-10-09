/************************************************************************/
/*      Archivo:                ahmsgnot.sp                             */
/*      Stored procedure:       sp_msg_notificacion                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Fecha de escritura:     06-Ago-2014                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      PROCESO:  Genera base de informacion para notificacion por msg  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      06/Ago/2014     A.Correa        Emision Inicial                 */
/*      04/May/2016     J.Salazar       Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_msg_notificacion')
  drop proc sp_msg_notificacion
go

/****** Object:  StoredProcedure [dbo].[sp_msg_notificacion]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_msg_notificacion
  @t_show_version bit = 0
as
  declare
    @w_consec     int,
    @w_fecha_proc varchar(20),
    @w_tabla_1    int,
    @w_tabla_2    int,
    @w_msg        varchar(64),
    @w_secuencial int,
    @w_sp_name    varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_msg_notificacion'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  set nocount on
  set ansi_warnings off

  execute as login = 'opbatch'

  --declare @FechaIni datetime
  --declare @FechaFin datetime

  --set @FechaIni = getdate()

  --Tabla temporal de transacciones
  create table #tranxhora_tmp
  (
    fechaproc  varchar(20) null,
    cedula     char(20) null,
    cuenta     varchar(24) null,
    tipotel    char(2) null,
    telefono   varchar(20) null,
    tipotran   varchar(34) null,
    valor      money null,
    fecha      datetime null,
    hora       smalldatetime null,
    oficina    smallint null,
    secuencial varchar(20) null,
    canal      varchar(40) null,
    concepto   varchar(34) null
  )

  select
    @w_fecha_proc = convert(varchar(30), getdate(), 101) + ' ' + convert(varchar
                    (
                               30), getdate(),
                               108 )

  select
    @w_tabla_1 = codigo
  from   cobis..cl_tabla with (nolock)
  where  tabla = 're_canales'
  if @@error <> 0
  begin
    select
      @w_msg = 'NO EXISTE CATALOGO DE CANALES'
    goto ERROR
  end

  select
    @w_tabla_2 = codigo
  from   cobis..cl_tabla with (nolock)
  where  tabla = 'ah_causa_nd'
  if @@error <> 0
  begin
    select
      @w_msg = 'NO EXISTE CATALOGO DE CAUSALES DE DEBITO'
    goto ERROR
  end

  select
    causa = codigo
  into   #excluidas
  from   cobis..cl_catalogo with (nolock)
  where  tabla = @w_tabla_2
     and upper(valor) like 'COMISION%'

  insert into #excluidas
  values      ('26')-- Pago de cartera

  insert into #tranxhora_tmp
              (fechaproc,cedula,cuenta,tipotel,telefono,
               tipotran,valor,fecha,hora,oficina,
               secuencial,canal,concepto)
    select
      @w_fecha_proc,ah_ced_ruc,tm_cta_banco,te_tipo_telefono,ltrim(rtrim(
      te_prefijo
      ) ) + ltrim(rtrim(te_valor)),
      substring(tn_descripcion,
                1,
                34),tm_valor,tm_fecha,tm_hora,tm_oficina,
      tm_secuencial,substring(c.valor,
                1,
                34),isnull((select
                substring(d.valor,
                          1,
                          30)
              from   cobis..cl_catalogo d with (nolock)
              where  d.tabla  = @w_tabla_2
                 and d.codigo = tm_causa),
             '')
    from   cob_ahorros..ah_tran_monet with (nolock),
           cob_ahorros..ah_cuenta with (nolock),
           cobis..cl_ttransaccion with (nolock),
           cobis..cl_direccion with (nolock),
           cobis..cl_telefono with (nolock),
           cobis..cl_catalogo c with (nolock)
    where  tm_cta_banco     = ah_cta_banco
       and tm_tipo_tran     = tn_trn_code
       and tm_cliente       = di_ente
       and di_ente          = te_ente
       and di_principal     = 'S'
       and di_direccion     = te_direccion
       and te_tipo_telefono = 'C'
       and tm_secuencial not in (select
                                   cv_secuencial
                                 from   cob_externos..ex_consec_validado with (
                                        nolock)
                                )
       and c.tabla          = @w_tabla_1
       and codigo           = tm_canal
       and tm_estado is null
       and tm_signo         = 'D'
       and isnull(tm_causa,
                  '') not in (select
                                causa
                              from   #excluidas)
    order  by tm_secuencial asc
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR GENERANDO INFORMACION DE TRANSACCIONES A TABLA TEMPORAL'
    goto ERROR
  end

  --Ingresa transacciones ya enviadas
  insert into cob_externos..ex_consec_validado
    select
      secuencial,null
    from   #tranxhora_tmp

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR MARCANDO SECUENCIALES VALIDADOS'
    goto ERROR
  end

  --Inserta la informaci¾n historica de acuerdo a lo cargado de la base de datos
  insert into cob_externos..ex_tranxhora
              (tr_cedula,tr_telefono,tr_tipotran,tr_valor,tr_fecha,
               tr_hora,tr_oficina,tr_secuencial,tr_nombre_canal,tr_cuenta)
    select
      cedula,replace(telefono,
              ' ',
              ''),case tipotran
        when 'N/D' then concepto
        else tipotran
      end,cast(round(valor,
                 0,
                 0) as decimal (18, 0)),convert(char(8), fecha, 1)       fecha,
      cast(datepart(hh, hora) as varchar) + ':' + cast(datepart(mi, hora) as
      varchar
      )
      + replicate('0', 2-datalength(cast(datepart(mi, hora) as varchar)))hora,(
      select
         of_nombre
       from   cobis..cl_oficina with (nolock)
       where  of_oficina = #tranxhora_tmp.oficina),(select
         max(secuencial)
       from   #tranxhora_tmp)
      + 1,case canal
        when 'BRANCH' then 'OFICINA'
        else canal
      end,'**' + substring(cuenta, 9, 4)
    from   #tranxhora_tmp
    where  tipotel = 'C'
       and valor   > 0

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR GENERANDO INFORMACION DE TRANSACCIONES'
    goto ERROR
  end

  --Actualiza para la primera insercion
  update cob_externos..ex_tranxhora
  set    tr_secuencial = 1
  where  tr_secuencial is null
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR SECUENCIAL'
    goto ERROR
  end

  --Limpia la tabla de mensajes actuales a enviar
  truncate table cob_externos..ex_cuerpo_mensaje
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL LIMPIAR TABLA DE MENSAJES'
    goto ERROR
  end

  select
    @w_secuencial = max(secuencial) + 1
  from   #tranxhora_tmp

  --Inserta los datos del nuevo archivo
  insert into cob_externos..ex_cuerpo_mensaje
              (cm_cedula,cm_telefono,cm_tipo_msg,cm_tipo_tel,cm_mensaje)
    select
      tr_cedula,substring(tr_telefono,
                1,
                10),'NV','Celular',substring(('ESTIMADO CLIENTE, EL ' + convert(
                                              varchar(10), tr_fecha, 103) +
                                              ' A LAS '
                 + convert(varchar(5), tr_hora, 108) + ' REALIZO ' + substring(
                                              tr_tipotran, 1,
                                                        34) + ' EN ' + case
                                              tr_nombre_canal when
                                                        'OFICINA' then
                                              'OFICINA '+
                                              substring(
                                                        tr_oficina, 1, 20) else
                                              tr_nombre_canal
                                                        end
                 + ' POR $' + isnull(convert(varchar(50), cast(tr_valor as money
                                              )
                                              ,
                                              1
                                              ), '0')
                 + ' DE SU CUENTA ' + tr_cuenta + '. BANCAMIA'),
                1,
                159)
    from   cob_externos..ex_tranxhora with (nolock)
    where  tr_secuencial = @w_secuencial

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR MENSAJES'
    goto ERROR
  end

  --set @FechaFin = getdate()
  --insert into SQLAdmin.dbo.log_sp_msg_notificacion values (@FechaIni, @FechaFin)

  revert

  goto FIN

  ERROR:
  print @w_msg

  FIN:
  return 0

go

