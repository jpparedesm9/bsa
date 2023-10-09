/************************************************************************/
/*  Archivo               : limite.sp                                   */
/*  Stored procedure      : sp_limite                                   */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Carolina Alvarado                           */
/*  Fecha de documentacion: 14/Ago/95                                   */
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
/*  Este programa procesa el mantenimiento de la tabla                  */
/*  con los limites de negociaciones por oficina o funcionario          */
/*  Insercion de pf_limite                                              */
/*  Actualizacion de pf_limite                                          */
/*  Eliminacion de pf_limite                                            */
/*  Search de la tabla pf_limite                                        */
/*  Query sobre pf_limite                                               */
/*  Help a la tabla pf_limite                                           */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA      AUTOR              RAZON                                 */
/*  06-Abr-00    X. Cartagena     Modificado para soportar ren aut      */
/*  19-May-2015  N. Silva         Lfmites por rol de funcionario FIE    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_limite')
   drop proc sp_limite       
go

create proc sp_limite (         
       @s_ssn                  int         = null,
       @s_user                 login       = null,
       @s_term                 varchar(30) = null,
       @s_date                 datetime    = null,
       @s_srv                  varchar(30) = null,
       @s_lsrv                 varchar(30) = null,
       @s_ofi                  smallint    = null,
       @s_rol                  smallint    = null,
       @t_debug                char(1)     = 'N',
       @t_file                 varchar(10) = null,
       @t_from                 varchar(32) = null,
       @t_trn                  smallint    = null,
       @i_operacion            char(1),
       @i_tipo                 char(1)     = null,
       @i_secuencial           smallint    = null,
       @i_plazo                int         = null,
       @i_monto                money       = null,
       @i_mnemonico            catalogo    = null,
       @i_moneda               smallint    = null,
       @i_tipo_reg             varchar(3)  = null,
       @i_valor                catalogo    = null,       
       @i_lim_max              float       = null,             
       @i_lim_min              float       = null,       
       @i_tasa                 float       = null,       
       @i_usa_lim              char(1)     = 'S',
       @i_oficina              varchar(6)  = null,
       @i_funcionario          varchar(10) = null,
       @i_modo                 smallint    = 0,
       @i_tasa_var             char(1)     = 'N',     -- tasa variable
       @i_mnemonico_tasavar    catalogo    = null,    -- tasa variable
       @i_flag_renovaut        char(1)     = 'N',     -- xca para renovaut.sp
       @i_fecha_valor          datetime    = null,    -- Gap DP00008 28-Feb-2005
       @i_formato_fecha        int         = 0,       -- Gap DP00008 28-Feb-2005
       @i_flag_tipo_deposito   char(1)     = 'N',     -- ccr manejo de verificacion de estado de tipo de deposito
       @i_tipo_tasa            char(1)     = 'N',     -- tipo de tasa (N)ormal, (P)recancelacion solo aplica para tasas fijas --Promerica--
       @i_tipo_pago            varchar(10) = null,
       @o_tasa_vigente         float       = 0   out, -- 06-Abr-2000 xca para renovaut.sp
       @o_limite_max           float       = 0   out, 
       @o_limite_min           float       = 0   out, 
       @o_monto_max            money       = 0   out, 
       @o_usa_lim              char(1)     = 'N' out  

)
with encryption
as
declare @w_sp_name             varchar(32),
        @w_return              int,
        @w_numdeci             tinyint,
        @w_usadeci             char(1),
        @w_secuencial          smallint,
        @w_tipo_deposito       tinyint,
        @w_fpago               catalogo,
        @w_tipo_reg            varchar(3),
        @w_tipo_plazo          varchar(15),
        @w_tipo_monto          varchar(15),
        @w_valor               catalogo,
        @w_moneda              smallint,
        @w_lim_max             float,    
        @w_lim_min             float,   
        @w_limite_max          float,             
        @w_limite_min          float,          
        @w_tasa_vigente        float,          
        @w_usa_lim             char(1),    
        @w_fecha_crea          datetime,
        @w_fecha_mod           datetime,
        @w_codigo              char(1),
        @v_fecha_crea          datetime,
        @v_fecha_mod           datetime,
        @v_secuencial          smallint,
        @v_tipo_reg            varchar(3),
        @v_valor               catalogo,
        @v_lim_max             float ,
        @v_lim_min             float,
        @v_usa_lim             char(1),
        @w_monto               money,
        @w_mantiene_stock      char(1),
        @w_monto_max           money,   -- 06-Abr-2000 xca para renovaut.sp
        @w_spread_vig          float,   -- 12-Abr-2000 tasa variable xca 
        @w_fecha_cierre_fiscal datetime,
        @w_fecha_temp          datetime,
        @w_rowcount            int,
        @w_error               int

select @w_sp_name   = 'sp_limite',
       @w_monto     = 0,
       @w_monto_max = 0 -- 06-Abr-2000 xca para renovaut.sp

select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @i_moneda
    
if @w_usadeci = 'S'
begin
     select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
     where pa_nemonico = 'DCI'
       and pa_producto = 'PFI'

     if @@rowcount = 0
     begin
        select @w_error =   141140
        GOTO ERROR
     end
end
else
     select @w_numdeci = 0

      
if (@t_trn <> 14135 or @i_operacion <> 'I') and
   (@t_trn <> 14235 or @i_operacion <> 'U') and
   (@t_trn <> 14335 or @i_operacion <> 'D') and
   (@t_trn <> 14435 or @i_operacion <> 'C') and
   (@t_trn <> 14635 or @i_operacion <> 'H') and
   (@t_trn <> 14766 or @i_operacion <> 'E')        --Gap DP00008 Fecha Valor no mayor 12 meses
begin
   select @w_error =   141112
   GOTO ERROR
end


if @i_mnemonico is not null  
begin
     select @w_tipo_deposito = td_tipo_deposito 
     from pf_tipo_deposito 
     where td_mnemonico = @i_mnemonico 
       and ((td_estado = 'A' and @i_flag_tipo_deposito = 'S') or @i_flag_tipo_deposito = 'N')
    
     if @@rowcount = 0
     begin
        select @w_error =   141115
        GOTO ERROR
     end
end

-- Insert --
if @i_operacion = 'I'
begin
     if exists (select * from pf_limite       
               where li_tipo_reg = @i_tipo_reg and li_valor = @i_valor
                 and li_tipo_deposito = @w_tipo_deposito
                 and li_moneda = @i_moneda)
     begin
        select @w_error =   141118
        GOTO ERROR
     end

     begin tran

     exec @w_return = cobis..sp_cseqnos
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'pf_limite',
          @o_siguiente = @w_secuencial out

     if @w_return <> 0
        return @w_return

     insert into pf_limite 
           (li_secuencial,  li_tipo_deposito,  li_moneda,      li_tipo_reg,     
            li_valor,       li_limite_max,     li_limite_min,  li_usa_limites,  
            li_fecha_crea,  li_fecha_elim)
     values(@w_secuencial,  @w_tipo_deposito,  @i_moneda,      @i_tipo_reg, 
            @i_valor,       @i_lim_max,        @i_lim_min,     @i_usa_lim,     
            @s_date,        @s_date)
     if @@error <> 0
     begin
        select @w_error =   143005
        GOTO ERROR
     end

     -- Transaccion de servicio  --
     insert into ts_limite 
            (secuencial,     tipo_transaccion,    clase,       fecha,
             usuario,        terminal,            srv,         lsrv,
             limite,         tipo_deposito,       moneda,      tipo,
			 valor,          limite_max,          limite_min,  usa_limites,
             fecha_crea,     fecha_elim)
     values (@s_ssn,         @t_trn,              'N',         @s_date,
             @s_user,        @s_term,             @s_srv,      @s_lsrv,
             @w_secuencial,  @w_tipo_deposito,    @i_moneda,   @i_tipo_reg,
             @i_valor,       @i_lim_max,          @i_lim_min,  @i_usa_lim,
			 @s_date,        @s_date)
     if @@error <> 0
     begin
        select @w_error =   143005
        GOTO ERROR
     end
     commit tran
  
     return 0
end


-- Update --
if @i_operacion = 'U'
begin
     select @w_lim_max   = li_limite_max, 
            @w_lim_min   = li_limite_min, 
            @w_usa_lim   = li_usa_limites,
            @w_fecha_mod = li_fecha_elim      
     from pf_limite       
     where  li_secuencial = @i_secuencial                          
    
     if @@rowcount = 0
     begin
        select @w_error =   141119
        GOTO ERROR
     end
      
     select @v_lim_max   = @w_lim_max,          
            @v_lim_min   = @w_lim_min, 
            @v_usa_lim   = @w_usa_lim,        
            @v_fecha_mod = @w_fecha_mod

     if @w_lim_max = @i_lim_max         
        select @w_lim_max = null, 
		       @v_lim_max = null         
     else
        select @w_lim_max = @i_lim_max        
                
     if @w_lim_min = @i_lim_min         
        select @w_lim_min = null, 
		       @v_lim_min = null         
     else
        select @w_lim_min = @i_lim_min        

     if @w_usa_lim = @i_usa_lim                  
        select @w_usa_lim = null, 
		       @v_usa_lim = null               
     else
        select @w_usa_lim = @i_usa_lim               
     
     if @w_fecha_mod = @s_date
        select @w_fecha_mod = null, @v_fecha_mod = null
     else
        select @w_fecha_mod = @s_date 

      
     begin tran

     update pf_limite         
     set li_limite_max  = @i_lim_max,    
         li_limite_min  = @i_lim_min,   
         li_usa_limites = @i_usa_lim,          
         li_fecha_elim  = @s_date
     where li_secuencial = @i_secuencial      
     
     if @@error <> 0 
     begin
        select @w_error =   145035
        GOTO ERROR
     end 
   
     insert into ts_limite 
            (secuencial,    tipo_transaccion,  clase,       fecha,
             usuario,       terminal,          srv,         lsrv,
             limite,        tipo_deposito,     moneda,      tipo,  
             valor,         limite_max,        limite_min,  usa_limites,
             fecha_crea,    fecha_elim)
     values (@s_ssn,        @t_trn,            'P',         @s_date,
             @s_user,       @s_term,           @s_srv,      @s_lsrv,
             @i_secuencial, null,              null,        null,
             null,          @v_lim_max,        @v_lim_min,  @v_usa_lim,
             null,          @s_date)
     if @@error <> 0 
     begin
        select @w_error =   143005
        GOTO ERROR
     end 


     insert into ts_limite 
            (secuencial,    tipo_transaccion,  clase,       fecha,
             usuario,       terminal,          srv,         lsrv,
             limite,        tipo_deposito,     moneda,      tipo,  
             valor,         limite_max,        limite_min,  usa_limites,
             fecha_crea,    fecha_elim)
     values (@s_ssn,        @t_trn,            'A',         @s_date,
             @s_user,       @s_term,           @s_srv,      @s_lsrv,
             @i_secuencial, null,              null,        null,
             null,          @w_lim_max,        @w_lim_min,  @w_usa_lim,
             null,          @s_date)
     if @@error <> 0 
     begin
        select @w_error =   143005
        GOTO ERROR
     end 
     commit tran
	 
     return 0
  
end /* fin de if @i_operacion = U */   


--- Delete ---
if @i_operacion = 'D'
begin
     select  @w_tipo_deposito = li_tipo_deposito,
             @w_moneda        = li_moneda,
             @w_tipo_reg      = li_tipo_reg,      
             @w_valor         = li_valor,    
             @w_lim_max       = li_limite_max, 
             @w_usa_lim       = li_usa_limites,     
             @w_fecha_mod     = li_fecha_elim,
             @w_fecha_crea    = li_fecha_crea
     from pf_limite         
     where li_secuencial = @i_secuencial   

     if @@rowcount = 0
     begin
        select @w_error =   141119
        GOTO ERROR
     end
  
     begin tran

     delete pf_limite                          
     where li_secuencial = @i_secuencial    
    
     if @@error <> 0
     begin
        select @w_error =   147035
        GOTO ERROR
     end 
   
     insert into ts_limite 
            (secuencial,    tipo_transaccion,  clase,       fecha,
             usuario,       terminal,          srv,         lsrv,
             limite,        tipo_deposito,     moneda,      tipo,valor,
             limite_max,    limite_min,        usa_limites, fecha_crea,
             fecha_elim)
      values(@s_ssn,        @t_trn,            'B',         @s_date,
             @s_user,       @s_term,           @s_srv,      @s_lsrv,
             @i_secuencial, @w_tipo_deposito,  @w_moneda,   @w_tipo_reg,
             @w_valor,      @w_lim_max,        @w_lim_min,  @w_usa_lim,
             @w_fecha_crea, @w_fecha_mod)
			 

	 if @@error <> 0
     begin
        select @w_error =   143005
        GOTO ERROR
     end 
     commit tran
	 
     return 0

end /* end de if operacion = D */


--- Help ---

if @i_operacion = 'H'
begin
     if @i_tipo = 'A'
     begin
           set rowcount 20
           select @i_secuencial = case @i_modo  
                                    when 0 then 0
                                    when 1 then @i_secuencial
                                  end
           select 'MONEDA'      = substring(mo_descripcion,1,30),
                  'VALOR'       = li_valor,
                  'LIM. MAXIMO' = li_limite_max,
                  'LIM. MINIMO' = li_limite_min,
                  'USA LIMITE'  = li_usa_limites,
                  'COD.MONEDA'  = li_moneda,    
                  'COD.'        = li_secuencial
           from pf_limite,
                cobis..cl_moneda
           where li_tipo_reg      = @i_tipo_reg
             and li_tipo_deposito = @w_tipo_deposito
             and li_moneda        = mo_moneda
             and li_secuencial    > @i_secuencial
           order by li_secuencial 

           set rowcount 0 
           return 0   
     end
   
     if @i_tipo = 'V'
     begin
           select li_tipo_deposito,
                  substring(mo_descripcion,1,30),
                  li_tipo_reg,
                  li_valor,
                  li_limite_max,
                  li_limite_min,
                  li_usa_limites,
                  li_moneda     
           from pf_limite, 
           cobis..cl_moneda
           where li_secuencial = @i_secuencial 
             and li_moneda     = mo_moneda    
   
           if @@rowcount = 0
           begin
              select @w_error =   141119
              GOTO ERROR
          end
          return 0
     end
end

if @i_operacion = 'C' begin
   select
   @w_tipo_deposito  = td_tipo_deposito,
   @w_fpago          = td_forma_pago,
   @w_mantiene_stock = td_mantiene_stock
   from  pf_tipo_deposito
   where td_mnemonico = @i_mnemonico
   
   if @@rowcount = 0 begin
      select @w_error = 141115
      goto ERROR
   end
   
   select @w_tipo_plazo = pl_mnemonico 
   from   pf_plazo, pf_auxiliar_tip
   where  @i_plazo between pl_plazo_min and pl_plazo_max 
   and    pl_mnemonico     = at_valor 
   and    at_tipo          = 'PLA' 
   and    at_tipo_deposito = @w_tipo_deposito 
   and    at_moneda        = @i_moneda 
   and    at_estado        = 'A'
   
   if @@rowcount = 0 begin
      select @w_error =   141054
      goto ERROR
   end
   
   select
   @w_monto     = case @w_mantiene_stock when 'S' then mo_monto_max else @w_monto end,    
   @w_monto_max = case @w_mantiene_stock when 'S' then mo_monto_max else @w_monto_max end    
   from  pf_monto, pf_auxiliar_tip        
   where mo_mnemonico     = at_valor 
   and   at_tipo          = 'MOT' 
   and   at_tipo_deposito = @w_tipo_deposito 
   and   at_moneda        = @i_moneda 
   and   at_estado        = 'A'
   
   select @w_rowcount = @@rowcount
   
   if @w_rowcount = 0 begin
      select @w_error =   141053
      goto ERROR
   end
   else 
   begin
      select @w_tipo_monto = mo_mnemonico
	  from   pf_monto, pf_auxiliar_tip
      where  @i_monto between mo_monto_min and mo_monto_max
      and    mo_mnemonico     = at_valor 
      and    at_tipo          = 'MOT' 
      and    at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_estado        = 'A'
      
   end
   
   if @i_tasa_var = 'S' begin              
      select
	  @w_spread_vig           = tv_spread_vigente,
      @w_limite_max           = tv_spread_max,
      @w_limite_min           = tv_spread_min
      from  pf_tasa_variable
      where tv_mnemonico_prod = @i_mnemonico
      and   tv_mnemonico_tasa = @i_mnemonico_tasavar
      and   tv_moneda         = @i_moneda
      and   tv_tipo_monto     = @w_tipo_monto
      and   tv_tipo_plazo     = @w_tipo_plazo
      and  (tv_tipo_pago      = @i_tipo_pago or @i_tipo_pago is null)
   end  
   else begin           
      select
	  @w_tasa_vigente        = ta_vigente,
      @w_limite_max          = ta_tasa_max,
      @w_limite_min          = ta_tasa_min
      from  pf_tasa
      where ta_tipo_deposito = @i_mnemonico 
      and   ta_moneda        = @i_moneda 
      and   ta_tipo_plazo    = @w_tipo_plazo 
      and   ta_tipo_monto    = @w_tipo_monto
      and   ta_tipo          = @i_tipo_tasa
      and  (ta_tipo_pago     = @i_tipo_pago or @i_tipo_pago is null)
   end
   
   if @@rowcount = 0 begin
      select @w_error = 141055
      goto ERROR
   end

   select
   @w_lim_max = li_limite_max,
   @w_lim_min = li_limite_min,
   @w_usa_lim = li_usa_limites
   from  pf_limite        
   where li_tipo_deposito = @w_tipo_deposito 
   and   li_moneda        = @i_moneda 
   and   li_tipo_reg      = 'FUN' 
   and   li_valor         = @i_funcionario 

   if @@rowcount = 0 begin
      select
	  @w_lim_max = li_limite_max,
      @w_lim_min = li_limite_min,
      @w_usa_lim = li_usa_limites
      from  pf_limite        
      where li_tipo_deposito = @w_tipo_deposito 
      and   li_moneda        = @i_moneda 
      and   li_tipo_reg      = 'OFI' 
      and   li_valor         = @i_oficina 
         
      if @@rowcount = 0 begin
         select
		 @w_lim_max = li_limite_max,
         @w_lim_min = li_limite_min,
         @w_usa_lim = li_usa_limites
         from  pf_limite        
         where li_tipo_deposito = @w_tipo_deposito 
         and   li_moneda        = @i_moneda 
         and   li_tipo_reg      = 'ROL' 
         and   li_valor         = convert(varchar,@s_rol)
   
         if @@rowcount <> 0
            select
			@w_limite_max = @w_limite_max + @w_lim_max,
            @w_limite_min = @w_limite_min - @w_lim_min
         
      end
      else begin
         if @@rowcount <> 0
            select
			@w_limite_max = @w_limite_max + @w_lim_max,
            @w_limite_min = @w_limite_min - @w_lim_min
      end
   end
   else
      select
	  @w_limite_max = @w_limite_max + @w_lim_max,
      @w_limite_min = @w_limite_min - @w_lim_min

 
   if @i_flag_renovaut = 'S' begin
      select
	  @o_tasa_vigente = @w_tasa_vigente, 
      @o_limite_max   = @w_limite_max,   
      @o_limite_min   = @w_limite_min,   
      @o_monto_max    = @w_monto_max,   
      @o_usa_lim      = @w_usa_lim      
   end
   else begin
      select
	  @w_tasa_vigente, 
      @w_limite_max, 
      @w_limite_min, 
      @w_monto, 
      @w_usa_lim 
      return 0
   end
end  



/* GAP DP00008 Control Fecha Valor no Mayor a 12 Meses y Anio Fiscal 28-Feb-2005 */
if @i_operacion = 'E' --Consulta Especifica
begin
     --Verificar si fecha valor esta dentro periodo fiscal 
     select @w_fecha_cierre_fiscal = max(pe_fecha_fin)
     from cob_conta..cb_periodo
     where pe_empresa = 1
       and pe_estado  = 'C'
    
     if datediff(dd,@w_fecha_cierre_fiscal,@i_fecha_valor) <= 0
     begin
        select @w_error =   141175
        GOTO ERROR
     end 
     return 0
end

ERROR:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error
   return @w_error
   
go

