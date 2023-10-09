/************************************************************************/
/*  Archivo               : icartera.sp                                 */
/*  Stored procedure      : sp_icartera                                 */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 29 de Noviembre de 2016                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa busca desacoplar el modulo de cartera con el modulo   */
/*  de plazo fijo                                                       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Oscar Saavedra     Emision Inicial DPF-H91368        */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where  name = 'sp_icartera')
   drop proc sp_icartera
go

create proc sp_icartera (
   @s_ssn               int             = NULL,
   @s_date              datetime        = NULL,
   @s_term              varchar(30)     = NULL,
   @s_sesn              int             = NULL,
   @s_srv               varchar(30)     = NULL,
   @s_lsrv              varchar(30)     = NULL,
   @s_user              varchar(30)     = NULL,
   @s_ofi               smallint        = NULL,
   @s_rol               smallint        = NULL,
   @s_ssn_corr          int             = NULL,
   @s_org               char(1)         = NULL,
   @s_ssn_branch        int             = NULL,
   @t_debug             char(1)         = NULL,
   @t_file              varchar(14)     = NULL,
   @t_trn               smallint        = NULL,
   @t_corr              char(1)         = 'N', 
   @t_ssn_corr          int             = NULL, 
   @i_operacion         varchar(2)      = NULL,
   @i_en_linea          char(1)         = NULL, 
   @i_fecha_valor       datetime        = NULL,
   @i_banco             varchar(24)     = NULL,
   @i_cta               varchar(24)     = NULL,
   @i_externo           char(1)         = NULL,      
   @i_mon               int             = NULL,
   @i_monto_mpg         money           = NULL,   
   @i_canal             tinyint         = NULL,
   @i_fecha_vig         datetime        = NULL,
   @i_moneda            int             = NULL,
   @i_fecha             datetime        = NULL,
   @i_cuenta            varchar(14)     = NULL,
   @i_cliente           int             = NULL,
   @i_modo              int             = NULL,
   @o_existe_cartera    char(1)         = NULL OUT,
   @o_secuencial_pag    int             = NULL OUT,
   @o_cotizacion        float           = NULL OUT,
   @o_existe_cta        int             = NULL OUT,
   @o_operacionca       int             = NULL OUT,
   @o_monto             money           = NULL OUT,
   @o_saldo             money           = NULL OUT
) 
with encryption   
as

declare @w_error           int,
        @w_mensaje         varchar(255),
        @w_producto        int,
        @w_return          int,
        @w_sp_name         varchar(24),
        @w_sec             int,
        @w_cotizacion      float

select @w_sp_name = 'sp_icartera'

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 7
  and pd_estado   = 'V'

if @w_producto = 0
begin
   /* MAPEO DE VARIBALES */
   select @o_existe_cartera    = 'N' 
   select @o_secuencial_pag    = 0 
   select @o_cotizacion        = null
   select @o_existe_cta        = 1
   select @o_operacionca       = 0
   select @o_monto             = 0
   select @o_saldo             = 0
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */

/*
if @w_producto > 0 
begin 
   
   select @o_existe_cartera    = 'S'

   if @i_operacion = 'A'
   begin
      
      exec @w_return = cob_cartera..sp_fecha_valor
           @s_date        = @s_date,
           @s_lsrv        = @s_lsrv,
           @s_ofi         = @s_ofi,
           @s_org         = @s_org,
           @s_rol         = @s_rol,
           @s_sesn        = @s_sesn,
           @s_ssn         = @s_ssn,
           @s_srv         = @s_srv,
           @s_term        = @s_term,
           @s_user        = @s_user,
           @t_trn         = @t_trn,
           @i_en_linea    = @i_en_linea,
           @i_fecha_valor = @i_fecha_valor, --fecha a la cual se quiere llevar la operacion
           @i_banco       = @i_banco, --Numero de operacion
           @i_operacion   = 'F',
           @i_externo     = @i_externo --Para que no ejecute begin tran

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end

   if @i_operacion = 'B'
   begin
      
      exec @w_return = cob_cartera..sp_abono_bv_cca
           @s_user       = @s_user,
           @s_term       = @s_term,
           @s_date       = @s_date,
           @s_sesn       = @s_sesn,
           @s_ofi        = @s_ofi,
           @s_srv        = @s_srv,
           @s_ssn        = @s_ssn,
           @s_lsrv       = @s_lsrv,
           @i_cta        = @i_cta,
           @i_banco      = @i_banco,             -- > Numero del prestamo
           @i_mon        = @i_mon,             -- > Moneda en la cual se efectua el pago
           @i_monto_mpg  = @i_monto_mpg,     -- > monto del pago.
           @i_canal      = @i_canal,                 -- > enviar 3 para el caso de DPF.
           @i_fecha_vig  = @i_fecha_vig,           -- > Fecha de vigencia
           @i_en_linea   = @i_en_linea,
           @o_secuencial_pag = @w_sec out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
      
      select @o_secuencial_pag = @w_sec
   end

   if @i_operacion = 'D'
   begin
      select @o_existe_cta  = 1,
             @o_operacionca = op_operacion
      from   cob_cartera..ca_operacion
      where  op_banco = @i_cuenta
   end
   
   if @i_operacion = 'E'
   begin
      set rowcount 20
      if @i_modo = 0
      begin
         select
         'PRESTAMO '       = op_banco, 
         'COD. CLIENTE '   = op_cliente,
         'NOM. CLIENTE '   = en_nomlar,
         'TIPO PRESTAMO '  = (select valor from cobis..cl_catalogo y, cobis..cl_tabla t where t.tabla = 'ca_toperacion' and y.tabla = t.codigo and y.codigo = x.op_toperacion)
         from   cob_cartera..ca_operacion x, cobis..cl_ente
         where (op_cliente = @i_cliente or @i_cliente is null)
         and    op_cliente = en_ente         
         and    op_moneda  = @i_moneda
         and    op_estado not in (0,3,6,98,99)
         order by op_banco
      end
	  if @i_modo = 1
	  begin
         select
         'PRESTAMO '       = op_banco, 
         'COD. CLIENTE '   = op_cliente,
         'NOM. CLIENTE '   = en_nomlar,
         'TIPO PRESTAMO '  = (select valor from cobis..cl_catalogo y, cobis..cl_tabla t where t.tabla = 'ca_toperacion' and y.tabla = t.codigo and y.codigo = x.op_toperacion)
         from   cob_cartera..ca_operacion x, cobis..cl_ente
         where (op_cliente = @i_cliente or @i_cliente is null)
         and    op_cliente = en_ente         
         and    op_moneda  = @i_moneda
         and    op_banco   > @i_cuenta
         and    op_estado not in (0,3,6,98,99)
         order by op_banco
      end	  
	  
      set rowcount 0
	  
      if @i_modo = 3 
	  begin
         select
         'COD. CLIENTE'   = op_cliente,
         'NOM. CLIENTE'   = en_nomlar,
         'TIPO PRESTAMO'  = (select valor from cobis..cl_catalogo y, cobis..cl_tabla t where t.tabla = 'ca_toperacion' and y.tabla = t.codigo and y.codigo = x.op_toperacion)
         from  cob_cartera..ca_operacion x, cobis..cl_ente
         where op_cliente = en_ente
         and   op_banco   = @i_cuenta
         and   op_moneda  = @i_moneda
         and   op_estado not in (0,3,6,98,99)
         order by op_banco  

         if @@rowcount = 0         
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 141183
            return 1
         end
      end
   end
   
   if @i_operacion = 'F'
   begin
      select @o_monto = 0
      select @o_saldo = 0
   end
end

*/

return 0

ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go