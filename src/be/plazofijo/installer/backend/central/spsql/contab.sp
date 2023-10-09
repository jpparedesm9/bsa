/************************************************************************/
/*     Archivo:                contab.sp                                */
/*     Stored procedure:       sp_contabiliza                           */
/*     Base de datos:          cobis                                    */
/*     Producto:               Plazo Fijo                               */
/*     Disenado por:           Miguel Viejo M.                          */
/*     Fecha de documentacion: 20/Nov/95                                */
/************************************************************************/
/*                             IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     'MACOSA', representantes exclusivos para el Ecuador de la        */
/*     'NCR CORPORATION'.                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/*                             PROPOSITO                                */
/*     Genera los comprobantes contables de las transacciones           */
/*     realizadas.                                                      */
/*                                                                      */
/*                             MODIFICACIONES                           */
/*     FECHA        AUTOR              RAZON                            */
/*     20/Nov/95    M.Viejo            Emision Inicial                  */
/*     16-Mar-2005  N. Silva           Correcciones de indentacion      */
/*      18-Jul-2009  Y. Martinez     NYM PF00016 CERTRET - PC  */
/************************************************************************/  
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_contabiliza')
   drop proc sp_contabiliza
go
   
create proc sp_contabiliza (
   @s_ssn            int          = NULL,
   @s_user           login        = NULL,
   @s_ofi            smallint     = NULL,
   @s_date           datetime     = NULL,
   @s_srv            varchar(30)  = NULL,
   @s_term           varchar(30)  = NULL,
   @t_file           varchar(10)  = NULL,
   @t_from           varchar(32)  = NULL,
   @t_debug          char(1)      = 'N',
   @t_rty            char(1)      = 'N', 
   @t_trn            int,   
   @i_empresa        int,
   @i_fecha          datetime,
   @i_toperacion     catalogo,
   @i_producto       int,
   @i_afectacion     char(1),
   @i_perfil         varchar(10),
   @i_codval         smallint,         --+-+
   @i_tr_cuenta      varchar(20)  = NULL,  --+-+
   @i_debcred        char(1)      = NULL,
   @i_forma_pago     catalogo     = NULL,   
   @i_plazo          catalogo     = NULL,
   @i_contador       smallint,
   @i_comprobante    int, 
   @i_area_dest      int,
   @i_oficina_dest   int,
   @i_descripcion    varchar(150) = NULL,
   @i_valor          money,
   @i_valor_ext      money,
   @i_cotizacion     money,                      
   @i_moneda         int,
   @i_cambio         char(1)      = 'S',
   @i_tipo_persona   catalogo     = NULL,       -- Si es Local Normal (LN), etc.
   @i_tipo_banca     catalogo     = NULL,       -- Si es banca corportativa, comercial, consumo etc
   @i_ente           int,
   @i_tipo_ente      catalogo     = null,       -- NYM CPF00016 CERTRET
   @i_operacionpf    int          = null,       -- GAL 21/AGO/2009 - CSQL
   @i_fpago          catalogo     = null,       -- GAL 21/AGO/2009 - CSQL
   @i_td_tipo_banca  catalogo     = null,       -- GAL 21/AGO/2009 - CSQL
   @o_codval         varchar(20)  = NULL out
)
with encryption
as
declare @w_sp_name           descripcion,
        @w_string            varchar(30),
        @w_return            int,
        @w_constante         varchar(5),
        @w_error             int,
        @w_codval            varchar(20),   --+-+
        @w_producto          int,
        @w_oficina           int,  
        @w_tran              int, 
        @w_descripcion       descripcion,
        @w_comprobante       int,
        @w_monloc            int,
        @w_perfil            varchar(10),
        @w_contador          int,
        @w_tot_debito        money,
        @w_tot_debito_me     money,
        @w_tot_credito       money,
        @w_tot_credito_me    money,
        @w_plazo             catalogo,
        @w_valor             money,
        @w_valor_ext         money,
        @w_toperacion        char(3),
        @w_toperacion_orig   char(4),
        @w_area_dest         int,
        @w_dp_cuenta         varchar(20),
        @w_dp_debcred        char(1),
        @w_dp_tipo_tran      char(1),
        @w_dp_origen_dest    char(1),
        @w_param1            varchar(20),
        @w_param2            varchar(20),
        @w_param3            varchar(20),
        @w_param4            varchar(20),
        @w_param5            varchar(20),
        @w_param6            varchar(20),
        @w_param7            varchar(20),
        @w_param8            varchar(20),
        @w_param9            varchar(20),
        @w_param10           varchar(20),
        @w_fecha_valor_old   datetime
 

select   
   @w_sp_name = 'sp_contabiliza',
   @w_codval  = convert(varchar(20),@i_codval)
--------------------------------------------------------------------------------
-- Selecciona el registro del detalle del perfil que le corresponde al asiento 
--------------------------------------------------------------------------------
--print 'contab.sp PRODUCTO %1!, CODVAL %2! PERFIL %3! DEBCRED %4!', @i_producto, @i_codval, @i_perfil, @i_debcred

select   @w_dp_cuenta   = @i_tr_cuenta,
   @w_dp_debcred  = @i_debcred,
   @w_dp_tipo_tran   = 'N'

if  @w_dp_cuenta is null
begin
   select @w_dp_cuenta      = dp_cuenta,
          @w_dp_debcred     = dp_debcred,
          @w_dp_tipo_tran   = dp_tipo_tran,
          @w_dp_origen_dest = dp_origen_dest,
          @w_constante      = dp_constante
     from cob_conta..cb_det_perfil 
    where dp_empresa  = @i_empresa 
      and dp_producto = @i_producto 
      and dp_codval   = @w_codval      --+-+ 
      and dp_perfil   = @i_perfil 
      and dp_debcred  = @i_debcred
   if @@rowcount = 0 
   begin
      return     149064
   end
end

if @i_afectacion = 'R' and @i_cambio = 'S'
begin
   if @w_dp_debcred = '1'
      select @w_dp_debcred = '2'
   else
      select @w_dp_debcred = '1'
end 

select @o_codval = isnull(@w_constante,'0')



--print 'contab @i_valor %1! ', @i_valor
--------------------------------------------------
-- Cargar el detalle del perfil para el parametro
--------------------------------------------------
if @i_valor > 0 
begin 
--print 'contab.sp I_TOPERACION %1! ',@i_toperacion
   select @w_toperacion_orig = @i_toperacion
   select @w_toperacion = substring(@i_toperacion,1,3)
   ----------------------------------------------
   -- Construir parametros de la cuenta contable
   ----------------------------------------------
   exec @w_return     = cob_pfijo..sp_parametro_cuenta 
        @s_user            = @s_user,
        @t_trn             = 14931,
        @i_empresa         = 1,
        @i_toperacion      = @w_toperacion,
        @i_toperacion_orig = @w_toperacion_orig,     
        @i_cuenta          = @w_dp_cuenta,
        @i_forma_pago      = @i_forma_pago, 
        @i_plazo           = @i_plazo,
        @i_oficina         = @i_oficina_dest,
        @i_moneda          = @i_moneda,
   @i_tipo_ente      = @i_tipo_ente,   -- NYM CPF00016 CERTRET
        @i_tipo_persona    = @i_tipo_persona,   -- Si es Local Normal (LN), etc.
        @i_tipo_banca      = @i_tipo_banca,
        @o_param1          = @w_param1 out,
        @o_param2          = @w_param2 out,
        @o_param3          = @w_param3 out,
        @o_param4          = @w_param4 out,
        @o_param5          = @w_param5 out,
        @o_param6          = @w_param6 out,
        @o_param7          = @w_param7 out,
        @o_param8          = @w_param8 out,
        @o_param9          = @w_param9 out,
        @o_param10         = @w_param10 out,
        @o_area            = @w_area_dest out
 
   -- Error en la construccion de la cuenta contable
   if @w_return <> 0
   begin
      print 'EERROORR en sp_contabiliza 2 !!'
      return    @w_return
   end
   --print 'contab.sp PARAMETRO %1! ',@w_param1

   if @i_area_dest is not null
      select @w_area_dest = isnull(@w_area_dest, @i_area_dest)
    
   select @w_area_dest = isnull(@w_area_dest, 999)
   
   
   if @w_param1 in (select fp_mnemonico from pf_fpago where fp_estado = 'A')  --+-+ Coloca area correcta GLOBAL
      select @w_area_dest = isnull(fp_area_contable, 999)
        from pf_fpago 
       where fp_mnemonico = @w_param1

   ----------------------------------------  
   -- Ingresar detalle de asiento contable
   ----------------------------------------
   exec @w_return          = cob_pfijo..sp_sasiento
        @s_ssn             = @s_ssn,
        @s_date            = @s_date,
        @s_user            = @s_user,
        @s_term            = @s_term,
        @s_ofi             = @s_ofi,
        @t_rty             = @t_rty,
        @t_trn             = 6952,
        @t_debug           = @t_debug,
        @t_file            = @t_file,
        @t_from            = @t_from,
        @i_empresa         = @i_empresa,
        @i_producto        = @i_producto,
        @i_comprobante     = @i_comprobante,
        @i_fecha_tran      = @i_fecha,
        @i_asiento         = @i_contador,
        @i_cuenta          = @w_dp_cuenta,
        @i_area_dest       = @w_area_dest,
        @i_oficina_dest    = @i_oficina_dest,
        @i_valor           = @i_valor,
        @i_valor_me        = @i_valor_ext,
        @i_debcred         = @w_dp_debcred,
        -- @i_ente            = @i_ente,         GAL 21/AGO/2009 - CSQL
        @i_concepto        = @i_descripcion,
        @i_tipo_doc        = 'N',                -- Normal  
        @i_tipo_tran       = @w_dp_tipo_tran,
        @i_moneda          = @i_moneda,
        @i_cotizacion      = @i_cotizacion,
        @i_param1          = @w_param1,
        @i_param2          = @w_param2,
        @i_param3          = @w_param3,
        @i_param4          = @w_param4,
        @i_param5          = @w_param5,
        @i_param6          = @w_param6,
        @i_param7          = @w_param7,
        @i_param8          = @w_param8,
        @i_param9          = @w_param9,
        @i_param10         = @w_param10,
        @i_fecha_valor_old = @w_fecha_valor_old
     
   if @w_return <> 0
   begin
      print 'EERROORR en sp_contabiliza 3:%1!'+cast(@w_return as varchar)
      return @w_return
   end
   return 0
end /* if @w_valor > 0 */
else 
begin
   print 'El valor a contabilizar no puede ser cero '
   return 9
end

go
