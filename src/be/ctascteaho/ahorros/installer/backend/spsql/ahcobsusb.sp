/************************************************************************/
/*      Archivo:                ahcobsusb.sp                            */
/*      Stored procedure:       sp_ah_cobsus_batch                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Carlos Avendaño                         */
/*      Fecha de escritura:     12-Ene-1993                             */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*                                                                      */
/*      Este programa realiza el cobro de valores en suspenso Req 371   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR         RAZON                            */
/*      28/Feb/2014      C. Avendaño   Emision inicial                  */
/*      30/Nov/2015      A. Diab       Inclusion de parametro para      */
/*                                     procesar cuentas con saldo > 0   */
/*      02/Mayo/2016     Ignacio Yupa  Migración a CEN                  */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_cobsus_batch')
  drop proc sp_ah_cobsus_batch
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cobsus_batch
(
  @t_show_version bit = 0,
  @i_param1       int
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_error       int,
    @w_mensaje     varchar(255),
    @w_contador    int,
    @w_max         int,
    @w_cuenta      int,
    @w_sencuencial int,
    @w_valor       money,
    @w_servicio    char(3),
    @w_procesada   char(1),
    @w_estado      char(1),
    @w_oficina     int,
    @w_impuesto    char(1),
    @w_ssn         int,
    @w_fecha_proc  datetime

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cobsus_batch'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proc = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    Cuenta = vs_cuenta,
    Sec = vs_secuencial,
    Valor = vs_valor,
    Servicio = vs_servicio,
    Procesada = vs_procesada,
    Estado = vs_estado,
    Oficina = vs_oficina,
    Impuesto = vs_impuesto
  into   #valsus
  from   cob_ahorros..ah_val_suspenso
  where  1 = 2

  alter table #valsus
    add Registro int identity (1, 1)

  insert into #valsus
    select
      vs_cuenta,vs_secuencial,vs_valor,vs_servicio,vs_procesada,
      vs_estado,vs_oficina,vs_impuesto
    from   cob_ahorros..ah_val_suspenso
    where  vs_procesada = 'N'
    order  by vs_cuenta,
              vs_ssn

  if @@error <> 0
  begin
    select
      @w_error = 203011,
      @w_mensaje = 'ERROR EN INSERCION DE VALORES EN SUSPENSO'
    exec cob_ahorros..sp_errorlog
      @i_fecha       = @w_fecha_proc,
      @i_error       = @w_error,
      @i_tran        = 303,--Cobro valores en suspenso
      @i_usuario     = 'opbatch',
      @i_descripcion = @w_mensaje,
      @i_programa    = @w_sp_name

  end

  select
    @w_max = isnull(max(Registro),
                    0)
  from   #valsus

  if @w_max = 0
  begin
    select
      @w_error = 208158,
      @w_mensaje = 'NO EXISTEN REGISTROS DE VALORES EN SUSPENSO'
    exec cob_ahorros..sp_errorlog
      @i_fecha       = @w_fecha_proc,
      @i_error       = @w_error,
      @i_tran        = 303,--Cobro valores en suspenso
      @i_usuario     = 'opbatch',
      @i_descripcion = @w_mensaje,
      @i_programa    = @w_sp_name

  end

  exec @w_ssn = ADMIN...rp_ssn

  select
    @w_contador = 1

  select
    @w_contador,
    @w_max
  while (@w_contador <= @w_max)
  begin
    select
      @w_cuenta = Cuenta,
      @w_sencuencial = Sec,
      @w_valor = Valor,
      @w_servicio = convert(char(3), Servicio),
      @w_procesada = Procesada,
      @w_estado = Estado,
      @w_oficina = Oficina,
      @w_impuesto = Impuesto
    from   #valsus
    where  Registro = @w_contador

    select
      @w_contador,
      @w_max,
      @w_cuenta,
      @w_valor,
      @w_servicio

    exec @w_error = cob_ahorros..sp_ahcobsus_batch
      @s_srv    = @@servername,
      @s_ofi    = @w_oficina,
      @s_date   = @w_fecha_proc,
      @i_cuenta = @w_cuenta,
      @i_sec    = @w_sencuencial,
      @i_valor  = @w_valor,
      @i_cau    = @w_servicio,
      @i_imp    = @w_impuesto,
      @i_ssn    = @w_ssn

    if @w_error <> 0
    begin
      select
        @w_mensaje = isnull(mensaje,
                     'ERROR REALIZANDO COBRO DE VALOR EN SUSPENSO'
                     )
                     +
                            ' CUENTA: '
                     + cast(@w_cuenta as varchar)
      from   cobis..cl_errores
      where  numero = @w_error

      exec cob_ahorros..sp_errorlog
        @i_fecha       = @w_fecha_proc,
        @i_error       = @w_error,
        @i_tran        = 303,--Cobro valores en suspenso
        @i_usuario     = 'opbatch',
        @i_descripcion = @w_mensaje,
        @i_programa    = @w_sp_name

    end

    select
      @w_contador = @w_contador + 1
    select
      @w_ssn = @w_ssn + 1
  end

  drop table #valsus

  return 0

go

