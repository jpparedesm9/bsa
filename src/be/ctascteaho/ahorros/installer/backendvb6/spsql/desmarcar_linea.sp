/********************************************************************/
/*  Archivo:            desmarcar_linea.sp                          */
/*  Stored procedure:   sp_desmarcar_linea                          */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas de Ahorros                          */
/*  Disenado por:                                                   */
/*  Fecha de escritura: 22 Nov 1994                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa desmarca  las lineas pendientes cuando no se a    */
/*       podido terminar el envio del total de las mismas           */
/*  233 = Consulta de lineas pendientes de cuentas de ahorros.      */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA           AUTOR           RAZON                           */
/*  22/Nov/1994     V Alvarez       Emision inicial                 */
/*  17/May/2006     P. Coello       Aumentar Fecha de la linea      */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/********************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_desmarcar_linea')
   drop proc sp_desmarcar_linea
go

/****** Object:  StoredProcedure [dbo].[sp_desmarcar_linea]    Script Date: 03/05/2016 9:52:01 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_desmarcar_linea
(
    @s_ssn            int,
    @s_srv            varchar(30) = null,
    @s_user           varchar(30) = null,
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_org            char(1),
    @s_ofi            smallint,    /* Localidad origen transaccion */
    @s_rol            smallint    = 1,
    @s_org_err        char(1)     = null, /* Origen de error:[A], [S] */
    @s_error          int         = null,
    @s_sev            tinyint     = null,
    @s_msg            mensaje     = null,
    @t_debug          char(1)     = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1)     = 'N',
    @t_trn            smallint,
    @t_show_version   bit = 0,
    @i_cta            cuenta,         /*cta banco */
    @i_mon            tinyint,
    @i_linea          int,      /*comienzo de la linea pendiente*/
    @i_sldlib         money,
    @i_nctrl          smallint,
    @i_numlin         smallint,
    @i_fecha          datetime  --PCOELLO MAYO DEL 2006
)
as
declare @w_return    int,
        @w_sp_name   varchar(30),
        @w_cuenta    int,
        @w_filial    tinyint,
        @w_estado    char(1),
        @w_moneda    tinyint,
        @w_error     int

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_desmarcar_linea'

-- Versionamiento del Programa --
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name +  ' Version=' + '4.0.0.0'
   return 0
end

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
        s_ssn           = @s_ssn,
        s_srv           = @s_srv,
        s_user          = @s_user,
        s_sesn          = @s_sesn,
        s_term          = @s_term,
        s_date          = @s_date,
        s_ofi           = @s_ofi,
        s_rol           = @s_rol,
        s_org_err       = @s_org_err,
        s_error         = @s_error,
        s_sev           = @s_sev,
        s_msg           = @s_msg,
        t_debug         = @t_debug,
        t_file          = @t_file,
        t_from          = @t_from,
        t_rty           = @t_rty,
        t_trn           = @t_trn,
        i_cta           = @i_cta,
        i_mon           = @i_mon,
        i_linea         = @i_linea,
        i_sldlib        = @i_sldlib,
        i_nctrl         = @i_nctrl,
        i_numlin        = @i_numlin
    exec cobis..sp_end_debug
end

/*Seleccion de la cuenta interna */

select @w_cuenta = ah_cuenta,
       @w_estado = ah_estado
  from cob_ahorros..ah_cuenta
 where ah_cta_banco = @i_cta

/* Chequeo de existencias */
if @@rowcount <> 1
begin
  /* No existe cuenta_banco */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251001
   return 1
end

/* Validaciones */
if @w_estado <> 'A'
begin
  /* Cuenta no activa o cancelada */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251002
   return 1
end

/* Inicio de la transaccion */

begin tran
   /***** PEDRO COELLO SE CAMBIA EL ORDEN DE ACTUALIZACION Y EN EL MAESTRO SE ACTUALIZA EL CAMPO CON LA CANTIDAD DE LINEAS
          QUE TENIA LA CUENTA + LAS LINEAS ACTUALIZADAS ********/

  update   cob_ahorros..ah_linea_pendiente
     set   lp_enviada    =   'N' 
   where   lp_cuenta = @w_cuenta 
     and   ((lp_fecha = @i_fecha and lp_linea  >= @i_linea) or --PCOELLO EL NUMERO DE LINEA PUEDE SER MENOR PERO LA FECHA
            lp_fecha > @i_fecha)                               --POSTERIOR
     and   lp_enviada = 'S'

  select @w_return = @@rowcount,  --PCOELLO
         @w_error = @@error       --PCOELLO

  /* Error en la actualizacion  de la tabla ah_linea_pendiente */

  if @w_error <> 0
    begin
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 255002
      return 1
    end

  /*  Actualizacion el saldo de libreta y numero de control */
  
  update   cob_ahorros..ah_cuenta
     set   ah_saldo_libreta     = @i_sldlib,
           ah_control           = @i_nctrl,
           ah_linea             = ah_linea + @w_return --PCOELLO
   where   ah_cuenta = @w_cuenta

  /* Error en la actualizacion de la tabla ah_linea_pendiente */

  if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 255009
      return 1
    end

commit tran

return 0

go

