/************************************************************************/
/*  Archivo:            remaahco.sp                                     */
/*  Stored procedure:   sp_mto_aho_contractual                          */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Remesas                                         */
/*  Disenado por:       Saira Molano                                    */
/*  Fecha de escritura: 31-Mar-2011                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa Realiza el Mantenimiento de la marca de servicios     */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  31/Mar/2011 S Molano    Emision inicial                             */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_mto_aho_contractual')
    drop proc sp_mto_aho_contractual

go

create proc sp_mto_aho_contractual (
    @s_ssn          int = null,
    @s_ssn_branch   int = null,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         varchar(30) = 'sa',
    @s_term         varchar(10) = 'consola',
    @s_date         datetime    = null,
    @s_ofi          smallint    = null,
    @s_org_err      char(1)     = null, /* Origen de error: [A], [S] */
    @s_error        int         = null,
    @s_sev          tinyint     = null,
    @s_msg          mensaje     = null,
    @s_org          char(1)     = 'U',
    @t_corr         char(1)     = 'N',
    @t_ssn_corr     int         = null, /* Trans a ser reversada */
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1)     = 'N',
    @t_trn          smallint    = null,
    @i_oficina      int         = null,
    @i_prodban      smallint    = null,
    @i_tipoente     catalogo    = null,
    @i_categoria    char(3)     = null,
    @i_operacion    char(1),
    @i_plazo        int         = null,
    @i_puntos       float       = null,
    @i_deposito     money       = null,
    @i_monto_final  money       = null,
    @i_modulo       smallint    = null,
    @i_cta_banco    varchar(16) = null,
    @i_cuota        money       = null,
    @i_periodicidad varchar(10) = null,
    --@i_dias_mora    smallint  = null,
    @i_estado       char(1)     = null,
    @i_cta          cuenta      = null,
    @i_profinal     tinyint     = null
 )
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_mensaje      varchar(120),
    @w_sucursal     int,
    @w_mercado      smallint,
    @w_fecha        datetime,
    @w_profin       smallint,
    @w_marca        char(1),
    @w_parametriza  smallint,
    @w_activa       char(1),
    @w_profinal     tinyint,
    @w_descripcion  descripcion,
    @w_codcateg     char(1),
    @w_categoria    descripcion,
    @w_plazo        tinyint, 
    @w_cuota        money,
    @w_codperiod    catalogo,
    @w_periodicidad descripcion,
    @w_monto_final  money,
    @w_puntos       float,
    @w_periincum    tinyint,
    @w_plazoacum    tinyint,
    @w_imprime      char(1),
    @w_prodbanc     smallint,
    @w_param_cat    char(1),
    @w_param_cont   tinyint


-- Captura nombre de Stored Procedure 
select  @w_sp_name = 'sp_mto_aho_contractual'

select @w_fecha = @s_date

begin tran
-- Consulta Servicio
if @i_operacion = 'S'
begin
   select @w_sucursal = of_regional
   from   cobis..cl_oficina 
   where  of_oficina = @i_oficina

   select @w_mercado = me_mercado
   from   cob_remesas..pe_mercado
   where  me_pro_bancario = @i_prodban 
   and    me_tipo_ente = @i_tipoente 

   select @w_profin = pf_pro_final 
   from   cob_remesas..pe_pro_final
   where  pf_sucursal = @w_sucursal
   and    pf_mercado = @w_mercado

   select @w_param_cat = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'CAMCAT'
   and   pa_producto = 'AHO'
   
   select @w_param_cont = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'PAHCT'
   and   pa_producto = 'AHO'

   if @w_param_cat = @i_categoria and @w_param_cont = @i_prodban
      select @w_marca = 'S'
   else
   begin   
      select @w_marca = cp_contractual
      from cob_remesas..pe_categoria_profinal
      where cp_profinal = @w_profin
      and   cp_categoria  = @i_categoria
         
      if (@@rowcount = 0) 
      begin
         exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 357513
         return 357513
      end   
   end 

   select @w_parametriza = count(1)
   from cob_remesas..pe_pro_final,
        cob_remesas..pe_producto_contractual,
        cobis..cl_tabla a1, cobis..cl_catalogo b1,
        cobis..cl_tabla a2, cobis..cl_catalogo b2
   where pc_profinal  = @w_profin
    and  pc_profinal  = pf_pro_final
    and  pc_categoria = @i_categoria
    and  a1.tabla    = 'pe_categoria'
    and  a1.codigo   = b1.tabla
    and  b1.codigo   = pc_categoria
   
    and   a2.tabla    = 'ah_capitalizacion'
    and   a2.codigo   = b2.tabla
    and   b2.codigo   = pc_periodicidad
    and   pc_estado = 'V'
        
    If @@rowcount = 0
    begin
      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 351570 
      -- 'No existe registro Producto Contractual'
      return 351570 
    end
    
   --Para verificar cuenta contractual
   if exists (select 1 
              from cob_remesas..re_cuenta_contractual
              where cc_cta_banco = @i_cta
                and cc_estado  = 'A')

      select @w_activa = 'S'
    else 
      select @w_activa = 'N'

   select  @w_marca
   select  @w_profin
   select  @w_parametriza
   select  @w_activa
end   

if @i_operacion = 'I'
begin
  insert into cob_remesas..re_cuenta_contractual
    (cc_modulo,             cc_profinal,     cc_cta_banco,
     cc_plazo,              cc_cuota,        cc_periodicidad,
     cc_monto_final,        cc_intereses,    cc_ptos_premio, 
     cc_estado,             cc_categoria,    cc_fecha_crea,  
     cc_periodos_incump,    cc_prodbanc)
  values
    (@i_modulo,             @i_profinal,     @i_cta_banco,
     @i_plazo,              @i_cuota,        @i_periodicidad,
     @i_monto_final,        '0.00',          @i_puntos,              
     @i_estado,             @i_categoria,    getdate(),    
     0,                     @i_prodban)   
              
  if @@error <> 0
  begin
    exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 357508
     return 357508
  end
  --Creacion de Transaccion de Servicio
  --print '@i_estado ' +  @i_estado
  insert into cob_cuentas..cc_tran_servicio
    (
     ts_secuencial,    ts_tipo_transaccion, ts_tsfecha, 
     ts_usuario,       ts_terminal,         ts_oficina, 
     ts_hora,          ts_producto,         ts_cta_banco,
     ts_indicador,     ts_cod_banco,        ts_monto,
     ts_saldo,         ts_prod_banc,        ts_vale, 
     ts_estado,        ts_categoria)
  values 
    (
     @s_ssn,           @t_trn,              @s_date, 
     @s_user,          @s_term,             @s_ofi, 
     getdate(),        @i_modulo,           @i_cta_banco,
     @i_plazo,         @i_periodicidad,     @i_cuota,
     @i_monto_final,   @i_prodban,          convert(varchar, @i_puntos),        
     @i_estado,           @i_categoria) 

  -- Error en creacion de transaccion de servicio 
  if @@error <> 0
  begin
    exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num  = 353515
  end
end

if @i_operacion = 'Q'  
begin  
  select   
    @w_prodbanc      = cc_prodbanc,                   -- 1  
    @w_descripcion   = pb_descripcion,                -- 2  
    @w_codcateg      = cc_categoria ,                 -- 3  
    @w_categoria     = b1.valor,                      -- 4  
    @w_plazo         = cc_plazo,                      -- 5  
    @w_cuota         = cc_cuota,                      -- 6  
    @w_codperiod     = cc_periodicidad,               -- 7  
    @w_periodicidad  = b2.valor,                      -- 8  
    @w_monto_final   = cc_monto_final,                -- 9  
    @w_puntos        = cc_ptos_premio,                -- 11  
    @w_periincum     = isnull(cc_periodos_incump,0),  -- 12 --pendiente ver como se va a calcular.
    @w_plazoacum      = datediff(mm, cc_fecha_crea, getdate()),    -- 13  
    @w_profinal      = cc_profinal                    -- 14      
  from cob_remesas..pe_pro_bancario,  
       cob_remesas..pe_pro_final,  
       cob_remesas..re_cuenta_contractual,  
       cobis..cl_tabla a1, cobis..cl_catalogo b1,  
       cobis..cl_tabla a2, cobis..cl_catalogo b2  
  where   cc_profinal  = pf_pro_final
    and   cc_prodbanc  = pb_pro_bancario  
    and   a1.tabla    = 'pe_categoria'  
    and   a1.codigo   = b1.tabla  
    and   b1.codigo   = cc_categoria  
               
    and   a2.tabla    = 'ah_capitalizacion'  
    and   a2.codigo   = b2.tabla  
    and   b2.codigo   = cc_periodicidad  
    and   cc_cta_banco = @i_cta_banco
                            
  If @@rowcount = 0  
  begin  
    exec cobis..sp_cerror  
       @t_debug    = @t_debug,  
       @t_file     = @t_file,  
       @t_from     = @w_sp_name,  
       @i_num      = 351570   
       --'No existe registro Producto Contractual'
       return 351570   
  end  

  select @w_imprime = pc_plan_pago
   from cob_remesas..pe_producto_contractual
  where pc_profinal =  @w_profinal
    and pc_categoria = @w_codcateg

  --Devuelve al frontend
    select @w_prodbanc,  -- 1  
    @w_descripcion,      -- 2  
    @w_codcateg,         -- 3  
    @w_categoria,        -- 4  
    @w_plazo,            -- 5  
    @w_cuota,            -- 6  
    @w_codperiod,        -- 7  
    @w_periodicidad,     -- 8  
    @w_monto_final,      -- 9  
    @w_puntos,           -- 11  
    @w_periincum,        -- 12 --pendiente ver como se va a calcular.
    @w_plazoacum,        -- 13
    @w_imprime,          -- 14
    @w_profinal          -- 15
end

commit tran
return 0