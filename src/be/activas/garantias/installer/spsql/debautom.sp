/************************************************************************/
/*	Archivo: 	        debautom.sp                             */ 
/*	Stored procedure:       sp_deb_automatico                       */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Debito automatico por  las inspecciones de las prendas          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Abr/1996  Luis Castellanos  Emision Inicial			*/
/*	28/Jul/97 Zulma Reyes	    Comentarios de cob_cuentas		*/	
/*      18/Mayo/98 Laura Alvarado   Retirar comentarios y aniadir cxcob */
/*      15/Jun/98  Laura Alvarado   Cambio del sp, todo en base a       */
/*                                  sp_cuentas_por_cobrar               */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_deb_automatico')
    drop proc sp_deb_automatico
go
create proc sp_deb_automatico (
   @s_ssn                int      = null,
   @s_sesn               int = null,
   @s_rol                int = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_srv                varchar(30) =null,
   @s_lsrv                varchar(30) =null,
   @s_ofi                smallint  = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_fecha              datetime = null,
   @i_fecha_insp         datetime = null,
   @i_secuencial         int = null,    --- REVISAR
   @i_banco              cuenta = null, --- REVISAR
   @i_concepto           catalogo = null,
   @i_monto              money,
   @i_moneda             tinyint = null,
   @i_oficina            smallint = null,
   @i_lote               smallint = null,
   @i_empresa	         tinyint = null,
   @i_filial 	         tinyint = null,
   @i_sucursal           smallint = null,
   @i_tipo_cust          varchar(64) = null,
   @i_custodia           int = null,
   @i_codigo_externo     varchar(64) = null,
   @i_tipo_cta_cli       char(3) = null,
   @i_cuenta_cliente     cuenta = null,
   @i_tipo_cta_insp      char(3)  = null,
   @i_cuenta_insp        cuenta = null,
   @i_inspector          int = null,
   @i_oficina_contabiliza smallint = null
)
as

declare @w_error        int,
        @w_today        datetime,     /* fecha del dia */ 
        @w_return       int,          /* valor que retorna */
        @w_sp_name      varchar(32),  /* nombre stored proc*/
        @w_existe       tinyint,      /* existe el registro*/
        @w_codigo_externo varchar(64),
        @w_estado       char(1),
        @w_sector       char(1),
        @w_debitado     char(1),
        @w_fpago        catalogo,
        @w_fdesembolso  catalogo,
        @w_toperacion   catalogo,
        @w_tantos       int,
        @w_cliente       int,
        @w_oficial       int,
        @w_oficina       smallint,
        @w_ciudad       int,
        @w_trn_prod     int,
        @w_ind          tinyint,
        @w_money        money,
        @w_valor_pagado money,
        @w_rever_credito money,
        @w_rever_debito money,
        @w_fecha_hoy    datetime,
        @w_fenv_carta   datetime,
        @w_cg_cuenta    cuenta,
        @w_moneda       tinyint,
	@w_cuenta       cuenta,
        @w_ssn          int   


/***********************************************************/
/** CARGADO DE VARIABLES DE TRABAJO                       **/

--select @w_today     = convert(varchar(10),getdate(),101),
select @w_today     = convert(varchar(10),@s_date,101),
       @w_sp_name   = 'sp_deb_automatico',
       @w_moneda    = isnull(@i_moneda,0),
       --@w_fecha_hoy = convert(varchar,getdate(),101)
       @w_fecha_hoy = convert(varchar,@s_date,101)

/***********************************************************/

/* Chequeo de Transacciones en Ctas Ctes y Ctas Ahorros */
/********************************************************/
if @i_operacion = 'I'
begin
   begin tran

   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
   @w_codigo_externo out

   select 
   @w_cliente = cg_ente,
   @w_ciudad  = cu_ciudad_prenda,
   @w_oficial = cg_oficial,
   --@w_moneda  = cu_moneda,
   @w_oficina = cu_oficina
   from cu_custodia, cu_cliente_garantia
   where cu_codigo_externo = @w_codigo_externo
   and   cg_principal      = 'D'
   and   cg_codigo_externo = cu_codigo_externo 
   if @@rowcount = 0
   begin
      select @w_return = 1901003
      goto ERROR
   end

   if @i_tipo_cta_cli = 'CTE'
      if @i_moneda = 0
         select @w_fpago = 'NDCC'
      else
         select @w_fpago = 'NDCC'
   else
      if @i_moneda = 0
         select @w_fpago = 'NDCA'
      else
         select @w_fpago = 'NDCA'
   
     
   if @i_tipo_cta_insp = 'AHO'
      if @i_moneda = 0
         select @w_fdesembolso = 'NCCC'
      else
         select @w_fdesembolso = 'NCCC'
   else
      if @i_moneda = 0
         select @w_fdesembolso = 'NCCA'
      else
         select @w_fdesembolso = 'NCCA'

     /* if @i_moneda = 0
      begin
         select @w_fdesembolso = 'PEMN'
         select @w_fpago = 'PEMN'
      end
      else
      begin
         select @w_fdesembolso = 'PEMN'
         select @w_fpago = 'PEMN'
      end*/

   select @w_sector = 'C'

   select @w_toperacion = pa_char
   from cobis..cl_parametro
   where pa_producto = 'CCA'
   and   pa_nemonico = 'CCOB'
   set transaction isolation level read uncommitted
--pga 22may2001
/*
   exec @w_return       = cob_cartera..sp_cuentas_por_cobrar
   @s_ssn               = @s_ssn,
   @s_sesn              = @s_sesn,
   @s_date              = @s_date,
   @s_ofi               = @s_ofi,
   @s_user              = @s_user,
   @s_rol               = @s_rol,
   @s_term              = @s_term,
   @s_srv               = @s_srv,
   @s_lsrv              = @s_lsrv,
   @s_org               = 'N',
   @i_sector            = @w_sector,
   @i_toperacion        = @w_toperacion,
   @i_moneda            = @i_moneda,
   @i_monto             = @i_monto,
   @i_formato_fecha     = 101,
   @i_cliente           = @w_cliente,
   @i_oficial           = @w_oficial,
   @i_oficina           = @w_oficina,
   @i_comentario        = 'PAGO A AVALUADORES',
   @i_ciudad            =  @w_ciudad,
   @i_forma_pago        = @w_fpago,		--Deb a Cliente
   @i_cuenta_pago       = @i_cuenta_cliente,	--su cta
   @i_forma_desembolso  = @w_fdesembolso,	--Cred a Abg
   @i_cuenta_desembolso = @i_cuenta_insp	--su cta
   if @w_return <> 0
   begin
      goto ERROR
   end
*/
-- pga 22may2001

   if exists (select * from cu_control_inspector
                  where ci_inspector         = @i_inspector
                  and   ci_lote             = @i_lote
                  and ci_frecep_reporte    is not null
                  and ci_fecha_pago        is null)
   begin
      update cu_control_inspector
      set ci_fecha_pago        = @w_fecha_hoy
      where ci_inspector         = @i_inspector
      and   ci_lote             = @i_lote
      and ci_frecep_reporte    is not null
      and ci_fecha_pago        is null

      if @@error <> 0
      begin
         select @w_return = 1901029
         goto ERROR
      end
   end
   else
   begin
      select @w_fenv_carta = pi_fenvio_carta
      from   cu_por_inspeccionar
      where pi_filial      = @i_filial
      and pi_sucursal    = @i_sucursal
      and pi_tipo        = @i_tipo_cust  
      and pi_custodia    = @i_custodia
      and pi_lote        = @i_lote


      select @w_fecha_hoy = ci_fecha_pago --la fecha del primer pago 
      from cu_control_inspector
      where ci_lote  = @i_lote   
      and   ci_fenvio_carta = @w_fenv_carta
      if @@rowcount = 0
      begin
         select @w_return = 1901030
         goto ERROR
      end
   end 

   select @w_valor_pagado = isnull(ci_valor_pagado,0)
   from cu_control_inspector
   where ci_inspector    = @i_inspector
   and   ci_lote         = @i_lote
   and ci_fecha_pago   = @w_fecha_hoy  

   if @@rowcount = 0 
   begin
      select @w_return = 1901022
      goto ERROR
   end

   update cu_control_inspector
   set ci_valor_pagado = isnull(@w_valor_pagado + isnull(@i_monto,0),0)
   where ci_inspector    = @i_inspector
   and   ci_lote       = @i_lote
   and ci_fecha_pago   = @w_fecha_hoy 

   if @@error <> 0 
   begin
      select @w_return = 1905001
      goto ERROR
   end

   update cob_custodia..cu_inspeccion
   set in_estado_tramite = 'S'
   where in_filial      = @i_filial
   and in_sucursal    = @i_sucursal
   and in_tipo_cust   = @i_tipo_cust  
   and in_custodia    = @i_custodia
   and in_fecha_insp  = @i_fecha_insp 
   and in_lote        = @i_lote

   if @@error <> 0
   begin
      select @w_return = 1905001
      goto ERROR
   end
   commit tran
end
return 0
ERROR:
    exec cobis..sp_cerror 
    @t_from  = @w_sp_name,
    @i_num   = @w_return
    return 1
go