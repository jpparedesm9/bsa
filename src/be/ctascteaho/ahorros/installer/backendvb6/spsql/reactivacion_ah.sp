/************************************************************************/
/*  Archivo:            reactivacion_ah.sp                              */
/*  Stored procedure:   sp_reactivacion_ah                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 07-Dic-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*  Este programa realiza la transaccion de consulta de bloqueos        */
/*  contra valores de cuentas de ahorros.                               */
/*  203 = Reactivacion de cuentas de ahorros.                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA           AUTOR           RAZON                           */
/*  07/Dic/1993 P Mena          Emision inicial                         */
/*  04/Dic/1994 J. Bucheli      Personalizacion para Banco de           */
/*                              la Producciion                          */
/*  15/Ene/1995 M. Sanguino     B. Prestamos                            */
/*  02/May/2016 Juan Tagle      Migración a CEN                         */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reactivacion_ah')
   drop proc sp_reactivacion_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reactivacion_ah (
    @s_ssn                int,
    @s_ssn_branch         int,
    @s_srv                varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_org                char(1),
    @s_ofi                smallint,           /* Localidad origen transaccion */
    @s_rol                smallint    = 1,
    @s_org_err            char(1)     = null, /* Origen de error:[A], [S] */
    @s_error              int         = null,
    @s_sev                tinyint     = null,
    @s_msg                mensaje     = null,
    @t_debug              char(1)     = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(32) = null,
    @t_rty                char(1)     = 'N',
    @t_trn                smallint,
    @t_show_version       bit         = 0,
    @i_cta                cuenta,
    @i_mon                tinyint,
    @i_turno              smallint    = null,
    @i_corresponsal       char(1)     = 'N',  --Req. 381 CB Red Posicionada
    @o_oficina_cta        smallint    = null out,
    @o_saldo              money out,
    @o_prod_banc          smallint    = null out,
    @o_categoria          char(1)     = null out,
    @o_tipocta_super      char(1)     = null out
)
as
declare @w_return    int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial        tinyint,
    @w_estado        char(1),
    @w_moneda        tinyint,
    @w_oficina_cta   smallint,
    @w_causa         char(1),
    @w_clase_clte    char(1),
    @w_mon           tinyint,
    @w_cliente       int,
    @w_saldo_int     money,
    @w_contable      money,
    @w_prod_bancario   varchar(50) --Req. 381 CB Red Posicionada

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_reactivacion_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_turno is null
    select @i_turno = @s_rol

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
        i_mon           = @i_mon
    exec cobis..sp_end_debug
end

if @t_trn <> 203
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 201048
   return 201048
end

/* Se obtiene la filial */
select  @w_filial  = of_filial
  from  cobis..cl_oficina
 where  of_oficina = @s_ofi

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   select @w_cuenta        = ah_cuenta,
          @w_estado        = ah_estado,
          @w_oficina_cta   = ah_oficina,
          @w_clase_clte    = ah_clase_clte,
          @w_mon           = ah_moneda,
          @w_cliente       = ah_cliente,
          @o_saldo         = ah_disponible,
          @o_prod_banc     = ah_prod_banc,
          @o_categoria     = ah_categoria,
          @o_tipocta_super = ah_tipocta_super,
          @w_saldo_int     = ah_saldo_interes,
          @w_contable      = ah_disponible+ah_12h+ah_24h
   from  cob_ahorros..ah_cuenta
   where  ah_cta_banco = @i_cta
   and  ah_moneda    = @i_mon
   and  ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   /* Chequeo de existencias */
   if @@rowcount <> 1
   begin
   /* No existe cuenta_banco */
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251001
      return  251001
   end
end
else
begin
   select @w_cuenta        = ah_cuenta,
          @w_estado        = ah_estado,
          @w_oficina_cta   = ah_oficina,
          @w_clase_clte    = ah_clase_clte,
          @w_mon           = ah_moneda,
          @w_cliente       = ah_cliente,
          @o_saldo         = ah_disponible,
          @o_prod_banc     = ah_prod_banc,
          @o_categoria     = ah_categoria,
          @o_tipocta_super = ah_tipocta_super,
          @w_saldo_int     = ah_saldo_interes,
          @w_contable      = ah_disponible+ah_12h+ah_24h
   from  cob_ahorros..ah_cuenta
   where  ah_cta_banco = @i_cta
   and  ah_moneda    = @i_mon

   /* Chequeo de existencias */
   if @@rowcount <> 1
   begin
   /* No existe cuenta_banco */
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251001
      return  251001
   end
end

select @o_oficina_cta = @w_oficina_cta

/* Validaciones */
if @w_estado <> 'I'
begin
  /* Cuenta no se encuentra inactiva */
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 251040
   return 251040
end

begin tran

/* Actualizacion del estado de la cuenta de ahorros */

update  cob_ahorros..ah_cuenta
   set  ah_estado   = 'A',
   ah_fecha_ult_upd = @s_date     /* MSA */
 where  ah_cuenta   = @w_cuenta
if @@rowcount <> 1
begin
  /* Error al actualizar cuenta de ahorros */
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 255001
   return 255001
end

select @w_causa = 'I'

/* Se valida que la cuenta no este en la DTN */
if exists (select 1 from cob_remesas..re_tesoro_nacional
                   where tn_cuenta = @i_cta
                     and tn_estado = 'P')
begin
/* Se le cambia el estado a reintegrada, a la Cuenta de la DTN */
    update cob_remesas..re_tesoro_nacional
    set tn_estado        = 'S',
        tn_fecha_r_saldo = @s_date,
        tn_oficina_r     = @s_ofi,
        tn_fecha_act     = @s_date,
        tn_autorizante   = @s_user
    where tn_cuenta = @i_cta
    and tn_estado   = 'P'

    if @@rowcount <> 1
    begin
      /* Error al actualizar cuenta de ahorros */
       exec cobis..sp_cerror
           @t_debug   = @t_debug,
           @t_file    = @t_file,
           @t_from    = @w_sp_name,
           @i_num     = 255001
       return 255001
    end

 select @w_causa = 'T',
        @t_trn   = 376
end

/* Creacion de transaccion de servicio */

insert into cob_ahorros..ah_tscambia_estado
          (secuencial,    ssn_branch,    tipo_transaccion,   tsfecha,
           usuario,       terminal,      reentry,            oficina,  origen,
           cta_banco,     moneda,        oficina_cta,        valor,
           prod_banc,     categoria,
           tipocta_super, turno,         causa,              alterno,
           clase_clte,    cliente,       interes,            cuenta)
       values
          (@s_ssn,        @s_ssn_branch, @t_trn,             @s_date,
           @s_user,       @s_term,       @t_rty,             @s_ofi,   @s_org,
           @i_cta,        @w_mon,        @w_oficina_cta,     @w_contable  * -1,
           @o_prod_banc,  @o_categoria,
           @o_tipocta_super,             @i_turno,           'A', 2,
           @w_clase_clte, @w_cliente,    @w_saldo_int * -1,  @w_cuenta)

if @@error <> 0
begin
  /* Error en creacion de transaccion de servicio */
  exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 203005
  return 203005
end

insert into cob_ahorros..ah_tscambia_estado
          (secuencial,    ssn_branch,    tipo_transaccion, tsfecha,
           usuario,       terminal,      reentry,          oficina,    origen,
           cta_banco,     moneda,        oficina_cta,      valor,
           prod_banc,     categoria,
           tipocta_super, turno,         causa,            alterno,
           clase_clte,    cliente,       interes,          cuenta)
       values
          (@s_ssn,        @s_ssn_branch, @t_trn,           @s_date,
           @s_user,       @s_term,       @t_rty,           @s_ofi,     @s_org,
           @i_cta,        @w_mon,        @w_oficina_cta,   @w_contable,
           @o_prod_banc,  @o_categoria,
           @o_tipocta_super,             @i_turno,         @w_causa,   1,
           @w_clase_clte, @w_cliente,    @w_saldo_int,     @w_cuenta)

if @@error <> 0
begin
  /* Error en creacion de transaccion de servicio */
  exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 203005
  return 203005
end

commit tran
return 0

go

