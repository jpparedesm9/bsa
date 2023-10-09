/************************************************************************/
/*	Archivo: 	        pagoabog.sp                             */
/*	Stored procedure:       sp_pago_abogado                         */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Milena Gonzalez                  	*/
/*	Fecha de escritura:     Diciembre-2000				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa permite realizar los pagos a los abogados         */
/*      cuentas por cobrar (cliente) y cuentas por pagar (abogado)      */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_pago_abogado')
    drop proc sp_pago_abogado
go
create proc sp_pago_abogado (
   @s_ssn                int          = null,
   @s_ssn_corr           int          = null,
   @s_date               datetime     = null,
   @s_user               login        = null,
   @s_term               varchar(64)  = null,
   @s_corr               char(1)      = null,
   @s_ofi                smallint     = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @t_rty                char(1)      = null,
   @t_from               varchar(30)  = null,
   @t_trn                smallint     = null,
   @t_debug              char(1)      = 'N',
   @t_file               varchar(14)  = NULL,
   @i_operacion          char(1)      = null,
   @i_modo               smallint     = null,
   @i_filial             tinyint      = null,
   @i_oficina            smallint     = null,
   @i_pago               char(1)      = null,
   @i_valor_facturado    money = null ,
   @i_codigo_externo     varchar(64) = null,  --boton ste
   @i_abogado            catalogo = null  --boton ste
)
as
declare
   @w_today              datetime,     
   @w_return             int,         
   @w_retorno            int,        
   @w_sp_name            varchar(32),
   @w_existe             tinyint,   
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_error              int,
   @w_abogado            catalogo,
   @w_fenvio_carta       datetime ,
   @w_frecep_reporte     datetime ,
   @w_valor_facturado    money,
   @w_valor_pagado       money,
   @w_fecha_pago         datetime,
   @w_fmaxrecep          datetime,
   @w_lote               tinyint ,
   @w_ente               int,
   @w_cliente            int,          --pga 14ago2001
   @w_area_custodia      smallint,     --pga 17ago2001
   @w_concepto           varchar(30),  --pga 17ago2001
   @w_tipo_referencia    varchar(30),  --pga 17ago2001
   @w_condicion          varchar(30),  --pga 17ago2001
   @w_producto           tinyint,      --pga 17ago2001 
   @w_ente_ins           int,
   @w_custodia           int,
   @w_codigo_externo     varchar(64),
   @w_secservicio        int, 
   @w_pagado             money,
   @w_facturado          money,
   @w_rowcount           int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_pago_abogado'


if (@t_trn <> 19914 and @i_operacion = 'S') or
   (@t_trn <> 19915 and @i_operacion = 'A') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,

    @i_num   = 1901006
    return 1 
end

select @w_secservicio = @@spid
--pga 17ago2001
/** SELECCION DEL AREA DE GARANTIAS**/
select @w_area_custodia = pa_smallint
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'ARG'
set transaction isolation level read uncommitted

/* PARAMETRO DEL CONCEPTO DE PAGO ABOGADOS*/
select @w_concepto = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PGAAB'
  and pa_producto = 'GAR'
 set transaction isolation level read uncommitted

/* CODIGO DEL PRODUCTO GARANTIAS */
select @w_producto = pd_producto
from cobis..cl_producto
where pd_abreviatura = 'GAR'

set transaction isolation level read uncommitted

/* CONDICION */
select @w_condicion = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PCONDI'
  and pa_producto = 'GAR'
set transaction isolation level read uncommitted

/* TIPO DE REFERENCIA */
select @w_tipo_referencia = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PTIRE'
  and pa_producto = 'GAR' 
set transaction isolation level read uncommitted 
--pga 17ago2001

if @i_operacion = 'S' or @i_operacion = 'A' 
begin
   if @i_filial is NULL or @i_oficina is NULL 
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select
       "ABOGADO"            = ca_abogado,
       "NOMBRE"             = ab_nombre,           
       "VALOR"              = ra_valor_fact,            
       "GARANTIA"           = ra_codigo_externo,            
       "FECHA DE PAGO"      = convert(char(10),ca_fecha_pago, 101),
       "PAGADA"             = ca_pago 
      from cu_control_abogado, cu_resul_abg, cob_credito..cr_abogado 
      where ra_abogado = ca_abogado
        and ab_abogado = ca_abogado
        and ca_lote = ra_lote
        and ra_pago = ca_pago --4jul2001
        and ra_pago = @i_pago -- parametro que indica si estan en Sidac o no            order by ca_abogado,ra_codigo_externo
        and ab_tipo = 'E'
     order by ra_abogado, ra_codigo_externo   
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
   end
   else 
   begin
      select
       "ABOGADO"          = ca_abogado,
       "NOMBRE"             = ab_nombre,           
       "VALOR"              = ra_valor_fact,            
       "GARANTIA"           = ra_codigo_externo,            
       "FECHA DE PAGO"      = convert(char(10),ca_fecha_pago, 101),
       "PAGADA"             = ca_pago 
      from cu_control_abogado, cu_resul_abg, cob_credito..cr_abogado 
      where ra_abogado = ca_abogado
        and ab_abogado  = ca_abogado
        and ca_lote = ra_lote
        and ca_abogado >= @i_abogado
        and ra_codigo_externo > @i_codigo_externo
        and ra_pago = ca_pago --4jul2001
        and ra_pago = @i_pago -- parametro que indica si estan en Sidac o no            order by ca_abogado,ra_codigo_externo
        and ab_tipo = 'E'
     order by ra_abogado, ra_codigo_externo   
     if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
   end
end

if @i_operacion = 'A' 
  begin
      Select  @w_abogado        = ca_abogado ,
             @w_fenvio_carta      = ca_fenvio_carta,
             @w_frecep_reporte    = ca_frecep_reporte, 
             @w_valor_facturado   = ra_valor_fact, 
             @w_valor_pagado      = ca_valor_pagado, 
             @w_fecha_pago        = ca_fecha_pago,
             --@w_fmaxrecep         = ci_fmaxrecep,
             @w_lote              = ca_lote,
             @w_ente_ins          = ab_cliente,
             @w_custodia          = ra_custodia,
             @w_codigo_externo   =  ra_codigo_externo
     from    cu_control_abogado, cu_resul_abg, cob_credito..cr_abogado 
     where   ra_abogado  = ca_abogado
       and   ab_abogado        = ca_abogado
       and   ra_valor_fact   = @i_valor_facturado 
       and   ca_lote              = ra_lote
       and   ra_codigo_externo    = @i_codigo_externo
     --  and   ca_pago            = @i_pago -- indica si estan en Sidac o no 
       and   ra_pago              = @i_pago
       and   ab_tipo = 'E'
       if @@rowcount = 0
        begin
        exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1
        end         

      select @w_ente = en_ente
      from   cobis..cl_ente
      where  en_ente = @w_ente_ins
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

      if @w_rowcount = 0 
        begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
         return 1
       end

      -- pga 14ago2001
      select @w_cliente = cg_ente
      from   cob_custodia..cu_cliente_garantia
      where cg_codigo_externo = @w_codigo_externo
        and ( cg_tipo_garante = 'J' or cg_tipo_garante = 'C' ) --emg ene-18-03
      if @@rowcount = 0 
        begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
         return 1
       end
      -- pga 14ago2001

   /*  exec cob_sidac.. sp_cuentaxcobrar	
       @s_ssn              = @s_ssn,
       @s_user             = @s_user,
       @s_date             = @s_date,
       @s_term             = @s_term,
       @s_ssn_corr         = @s_ssn_corr,
       @s_srv              = @s_srv,
       @s_ofi              = @s_ofi,
       @t_trn              = 32500,
       @i_operacion        = 'I',
       @i_empresa          = @i_filial,
       @i_fecha_rad        = @s_date,
       @i_modulo           = @w_producto,               -- producto garantias    	
       @i_fecha_ven        = @s_date,
       @i_moneda           = 0, 
       @i_valor            = @w_valor_facturado,
       @i_concepto         = @w_concepto,        -- concepto 
       @i_condicion        = @w_condicion,
       @i_tipo_referencia  = @w_tipo_referencia,                -- tipo de documento catalogo    	
       @i_formato_fecha    = 101,                -- ojo  formato de fecha    	
       @i_ente             = @w_cliente,         -- pga 14ago2001
       @i_referencia       = @w_codigo_externo,  -- garantia codigo    	
       @i_area             = @w_area_custodia,   -- de la garantia	
       @i_oficina          = @i_oficina,
       @i_estado           = 'V'

     exec cob_sidac.. sp_cuentaxpagar	
       @s_ssn               = @s_ssn,
       @s_user              = @s_user,
       @s_date              = @s_date,
       @s_term              = @s_term,
       @s_ssn_corr          = @s_ssn_corr,
       @s_srv               = @s_srv,
       @s_ofi               = @s_ofi,
       @t_trn               = 32550,
       @i_operacion         = 'I',
       @i_empresa           = @i_filial, -- filial   1
       @i_fecha_rad         = @s_date,   -- fecha proceso  
       @i_modulo            = @w_producto,        -- 19  numero de garantias    	
       @i_fecha_ven         = @s_date,   -- fecha proceso
       @i_moneda            = 0,               
       @i_valor             = @w_valor_facturado,
       @i_concepto          = @w_concepto, -- concepto 
       @i_condicion         = @w_condicion,       -- 1 es un caracter    
       @i_tipo_referencia   = @w_tipo_referencia,       --@w_custodia,
       @i_formato_fecha     = 101,       --  formato de fecha  
       @i_ente              = @w_ente,   -- codigo del modulo de clients que tenga el abog / aval    	
       @i_referencia        = @w_codigo_externo,  -- garantia codigo    	
       @i_area              = @w_area_custodia,   -- de la garantia	
       @i_oficina           = @i_oficina,
       @i_estado            = 'V'*/


     select @w_facturado = sum(ra_valor_fact)
     from   cu_resul_abg
     where  ra_abogado = @w_abogado
       and  ra_lote = @w_lote
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
     
     select @w_pagado = sum(ca_valor_pagado)
     from   cu_control_abogado
     where ca_abogado  = @w_abogado
       and ca_fenvio_carta = @w_fenvio_carta
       and ca_frecep_reporte = @w_frecep_reporte
       and ca_pago = 'N'
       and ca_lote = @w_lote
     if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end

     update cu_resul_abg set ra_pago = 'S',
            ra_fecha_pago = @w_today
     where  ra_abogado = @w_abogado
     and    ra_valor_fact = @i_valor_facturado
     and    ra_lote = @w_lote
     if @@error <> 0 
       begin
         /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
     end

     update cu_control_abogado
     set ca_fecha_pago = @w_today,
         ca_valor_pagado = isnull(ca_valor_pagado,0) + @i_valor_facturado
     where ca_abogado = @w_abogado      
     and ca_fenvio_carta = @w_fenvio_carta   
     and ca_frecep_reporte = @w_frecep_reporte 
     and ca_lote = @w_lote
     if @@error <> 0 
       begin
         /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end

      select @w_facturado = sum(ra_valor_fact)
      from   cu_resul_abg
      where  ra_abogado = @w_abogado
      and  ra_lote = @w_lote
      if @@rowcount = 0
       begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1901003 
          return 1 
       end

        select @w_pagado = sum(ca_valor_pagado)
        from   cu_control_abogado
        where ca_abogado  = @w_abogado
          and ca_fenvio_carta = @w_fenvio_carta
          and ca_frecep_reporte = @w_frecep_reporte
          and ca_pago = 'N'
          and ca_lote = @w_lote
        if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1901003 
            return 1 
         end

       if @w_pagado <> @w_facturado
       begin
          update cu_control_abogado
          set ca_pago = 'S'
          where ca_abogado = @w_abogado      
	  and ca_lote = @w_lote
          if @@error <> 0 
            begin
              /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1905001
               return 1 
            end
       end

       if @w_pagado = @w_facturado 
         begin
          update cu_control_abogado
          set ca_pago = 'S',ca_fecha_pago = @w_today
          where ca_abogado  = @w_abogado
            and ca_fenvio_carta = @w_fenvio_carta
            and ca_frecep_reporte = @w_frecep_reporte
	    and ca_lote = @w_lote           
            if @@error <> 0 
            begin
              /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1905001
               return 1 
            end
         end

       insert into ts_control_abogado
       values (@w_secservicio,@t_trn,'N',@s_date,@s_user,@s_term,
               @s_ofi,'cu_pago_abogado', @w_abogado, @w_fenvio_carta,
               @w_frecep_reporte, @w_valor_facturado, @w_valor_pagado,
               @w_fecha_pago)
       if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
      end

return 0
go
