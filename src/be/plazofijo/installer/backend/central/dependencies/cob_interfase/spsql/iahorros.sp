/*  Archivo               : iahorros.sp                                 */
/*  Stored procedure      : sp_iahorros                                 */
/*  Base de datos         : cob_interfase                               */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Alfredo Zuluaga                             */
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
/*  Este programa busca desacoplar el modulo de Ahorros con el modulo   */
/*  de plazo fijo                                                       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Alfredo Zuluaga    Emision Inicial DPF-H91368        */
/************************************************************************/
use cob_interfase
go

if exists (select 1 from sysobjects where  name = 'sp_iahorros')
   drop proc sp_iahorros
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

create proc sp_iahorros (
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
       @s_ssn_branch        int             = NULL,
       @t_debug             char(1)         = NULL,
       @t_file              varchar(14)     = NULL,
       @t_trn               smallint        = NULL,
       @t_corr              char(1)         = 'N', 
       @t_ssn_corr          int             = NULL, 
       @i_operacion         varchar(2)      = NULL,
       @i_cuenta_banco      varchar(24)     = NULL,
       @i_cuenta            int             = NULL,
       @i_fecha             datetime        = NULL,
       @i_cliente           int             = NULL,
       @i_moneda            int             = NULL,
       @i_modo              int             = NULL,
       @i_prod_banc         int             = NULL,
       @i_val               money           = NULL,
       @i_cta_banco         varchar(64)     = NULL,
       @i_cta               varchar(64)     = NULL,
       @i_cau               varchar(3)      = NULL,
       @i_alt               tinyint         = NULL,
       @i_enlinea           char(1)         = NULL,
       @i_pit               char(1)         = NULL,
       @i_ctaint            int             = NULL,
       @i_num_cta_ahorro    varchar(16)     = NULL,
       @i_nomtrn            varchar(20)     = NULL,
       @i_canal             tinyint         = NULL,
       @i_concepto          varchar(255)    = NULL,
       @i_inmovi            varchar(2)      = NULL,
       @i_activar_cta       varchar(2)      = NULL,
       @i_fecha_valor_a     datetime        = NULL,
       @i_titularidad_prods char(1)         = NULL,
       @i_titular_prods     int             = NULL,
       @o_cuenta_ah         varchar(24)     = NULL OUT,
       @o_cuenta            int             = NULL OUT,
       @o_estado_cuenta     varchar(10)     = NULL OUT,
       @o_tipo_bloqueo      varchar(3)      = NULL OUT,
       @o_saldo_girar       money           = NULL OUT,
       @o_saldo_cont        money           = NULL OUT,
       @o_cliente           int             = NULL OUT,
       @o_num_cuentas       int             = NULL OUT,
       @o_existe_cca        int             = NULL OUT,
       @o_existe_cca_ac     int             = NULL OUT,
       @o_total_gmf         money           = NULL OUT,
       @o_acumu_deb         money           = NULL OUT,
       @o_base_gmf          money           = NULL OUT,
       @o_actualiza         char(1)         = NULL OUT,
       @o_prod_banc         int             = NULL OUT,
       @o_valnxmil          money           = NULL OUT,
       @o_ctaint            int             = NULL OUT,
       @o_titularidad       varchar(30)     = NULL OUT,
       @o_saldo_para_girar  money           = NULL OUT,
       @o_saldo_contable    money           = NULL OUT,
       @o_existe_cta        int             = NULL OUT,
       @o_monto_imp         money           = NULL OUT,
       @o_categoria         char(1)         = NULL OUT,
       @o_tipocta           char(1)         = NULL OUT,
       @o_rolente           char(1)         = NULL OUT,
       @o_tipo_def          char(1)         = NULL OUT,
       @o_producto          int             = NULL OUT,
       @o_moneda            int             = NULL OUT,
       @o_estado            char(1)         = NULL OUT   
) 
with encryption   
as

declare @w_error           int,
        @w_mensaje         varchar(255), 
        @w_producto        smallint,
        @w_total_gmf       money,
        @w_acumu_deb       money,
        @w_base_gmf        money,
        @w_sp_name         varchar(50),
        @w_actualiza       varchar(10),
        @w_val_3xmil       money,
        @w_titularidad     varchar(30),
        @w_saldo_d         money ,
        @w_saldo_c         money,
        @w_monto_imp       money   

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 4
  and pd_estado   = 'V'

if @w_producto = 0
begin
  /* MAPEO DE VARIBALES */
  select @o_cuenta           = 0
  select @o_estado_cuenta    = 'V'
  select @o_tipo_bloqueo     = ''
  select @o_saldo_girar      = 0
  select @o_saldo_cont       = 0
  select @o_cliente          = 0
  select @o_num_cuentas      = 0
  select @o_existe_cca       = 0
  select @o_existe_cca_ac    = 0
  select @o_total_gmf        = 0
  select @o_acumu_deb        = 0
  select @o_base_gmf         = 0
  select @o_actualiza        = ''
  select @o_cuenta_ah        = ''
  select @o_prod_banc        = 0
  select @o_valnxmil         = 0
  select @o_ctaint           = 1
  select @o_saldo_para_girar = 0
  select @o_saldo_contable   = 0
  select @o_titularidad      = 'titular'
  select @o_existe_cta       = 1
  select @o_monto_imp        = 0
  select @o_categoria        = ''
  select @o_tipocta          = ''
  select @o_rolente          = ''
  select @o_tipo_def         = ''
  select @o_producto         = 4
  select @o_moneda           = 0
  select @o_estado           = ''  
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */

/*

if @w_producto > 0 
begin 
   if @i_operacion = 'A'
   begin
      select @o_cuenta        = ah_cuenta,
             @o_estado_cuenta = ah_estado,
             @o_cliente       = ah_cliente,
             @o_prod_banc     = ah_prod_banc,
             @o_categoria     = ah_categoria,
             @o_tipocta       = ah_tipocta,
             @o_rolente       = ah_rol_ente,
             @o_tipo_def      = ah_tipo_def,
             @o_producto      = ah_producto,
             @o_moneda        = ah_moneda,
             @o_estado        = ah_estado 
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cuenta_banco
   
      select @o_tipo_bloqueo = cb_tipo_bloqueo 
      from cob_ahorros..ah_ctabloqueada
      where cb_cuenta = @i_cuenta
        and cb_estado = 'V'
        and (cb_tipo_bloqueo = '2'
         or  cb_tipo_bloqueo = '3')
         
      select @o_cuenta_ah = ah_cta_banco
      from cob_ahorros..ah_cuenta
      where ah_estado     in ('A','I')
        and ah_cta_banco  = @i_cuenta_banco
        and ah_cliente    = @i_cliente
        and ah_ctitularidad not in ('M','S')         
   end

   if @i_operacion = 'B'
   begin
      select @o_num_cuentas = count(1)
      from cob_ahorros..ah_cuenta
      where ah_cliente = @i_cliente
   end
    
   if @i_operacion = 'S'
   begin
      exec @w_error = cob_ahorros..sp_ahcalcula_saldo
           @i_cuenta_banco      = @i_cuenta_banco,
           @i_fecha             = @i_fecha,
           @i_cuenta            = @i_cuenta,
           @o_saldo_contable    = @o_saldo_cont  out,
           @o_saldo_para_girar  = @o_saldo_girar out
           
      if @w_error <> 0
      begin
         goto ERROR
      end      
   end
   
   if @i_operacion = 'C'
   begin
      select top 20
      'Cuenta'        = ah_cta_banco,
      'Producto'      = 'AHO'
      from   cobis..cl_det_producto,
             cobis..cl_cliente,
             cob_ahorros..ah_cuenta
      where  ah_cta_banco    = dp_cuenta
        and  dp_det_producto = cl_det_producto 
        and  dp_producto     = 4
        and  cl_cliente      = @i_cliente
        and  dp_cuenta       > @i_cuenta
        and  ah_cta_banco    > @i_cuenta
        and  cl_rol          in ('T', 'C')
        and  ah_estado       in ('A', 'I')
        and  ah_prod_banc not in (select pa_int from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'PAHCT')
      order  by ah_cta_banco
   end
   
   if @i_operacion = 'X'
   begin
      set rowcount 20
      if @i_modo = 0
      begin
         set rowcount 20
         select 
         'CUENTA'      = ah_cta_banco,
         'COD CLIENTE' = ah_cliente,
         'NOM CLIENTE' = ah_nombre
         from cobis..cl_det_producto, cobis..cl_cliente, cob_ahorros..ah_cuenta
         where dp_producto     = 4
           and dp_moneda       = @i_moneda    
           and dp_det_producto = cl_det_producto
           and cl_rol          = 'T'
           and ah_cta_banco    = dp_cuenta
           and ah_estado       in ('G', 'A')
           and dp_cuenta       = @i_cuenta            
           and ah_cta_banco    not in (select cc_cta_banco 
                                       from cob_remesas..re_cuenta_contractual 
                                       where cc_estado = 'A')
           and (cl_cliente = @i_cliente or @i_cliente is null)
           order by dp_cuenta   
      end
      
      if @i_modo = 1
      begin
         set rowcount 20
         select 
         'CUENTA'      = ah_cta_banco,
         'COD CLIENTE' = ah_cliente,
         'NOM CLIENTE' = ah_nombre
         from  cobis..cl_det_producto, cobis..cl_cliente, cob_ahorros..ah_cuenta
         where  dp_producto     = 4
           and  dp_moneda       = @i_moneda    
           and  dp_det_producto = cl_det_producto
           and  cl_rol          = 'T'
           and  ah_cta_banco    = dp_cuenta
           and  ah_estado       in ('G', 'A')
           and  dp_cuenta       > @i_cuenta            
           and  ah_cta_banco    not in (select cc_cta_banco from cob_remesas..re_cuenta_contractual where cc_estado = 'A')
           and (cl_cliente      = @i_cliente or @i_cliente is null)
         order by dp_cuenta   
      end
      set rowcount 0
   end         

   if @i_operacion = 'Y'
   begin
      select @o_existe_cca = count(1)
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cuenta_banco
        and ah_prod_banc = @i_prod_banc
      
      select @o_existe_cca_ac = count(1)
      from cob_ahorros..ah_cuenta
      where ah_cta_banco   = @i_cuenta_banco
        and ah_estado      = 'A'
        and ah_moneda      = @i_moneda
   end
   
   if @i_operacion = 'Z'
   begin  

      exec @w_error = cob_ahorros..sp_calcula_gmf
      @s_date   = @i_fecha,
      @i_cuenta = @i_cuenta,
      @i_operacion = 'Q',
      @i_producto  = 4,
      @i_val       = @i_val,
      @o_total_gmf = @w_total_gmf out,
      @o_acumu_deb = @w_acumu_deb out,
      @o_base_gmf  = @w_base_gmf  out,
      @o_actualiza = @w_actualiza out      

      if @w_error <> 0
      begin
         goto ERROR
      end      

      select @o_total_gmf = @w_total_gmf
      select @o_base_gmf  = @w_base_gmf
      select @o_acumu_deb = @w_acumu_deb
      select @o_actualiza = @w_actualiza
   end
   
   if @i_operacion = 'D'
    begin
      exec @w_error = cob_ahorros..sp_ctah_vigente
           @s_srv            = @s_srv,   
           @s_ofi            = @s_ofi,   
           @i_ver_nodo       = 'S',      
           @i_val            = @i_val,   
           @i_cta_banco      = @i_cta_banco,  
           @i_moneda         = @i_moneda
            
      if @w_error <> 0
      begin
         goto ERROR
      end             
    end
    
    if @i_operacion = 'F'
    begin
       exec @w_error = cob_ahorros..sp_ahndc_automatica
            @s_srv         = @s_srv,
            @s_ofi         = @s_ofi,   
            @s_ssn         = @s_ssn,
            @s_ssn_branch  = @s_ssn_branch,
            @s_user        = @s_user,
            @s_term        = @s_term,
            @t_trn         = @t_trn, 
            @t_corr        = @t_corr,
            @t_ssn_corr    = @t_ssn_corr,
            @i_cta         = @i_cta,
            @i_nomtrn      = @i_nomtrn,
            @i_val         = @i_val,
            @i_cau         = @i_cau, 
            @i_mon         = @i_moneda,
            @i_fecha       = @i_fecha,
            @i_alt         = @i_alt, 
            @i_enlinea     = @i_enlinea,  
            @i_pit         = @i_pit, 
            @i_concepto    = @i_concepto,
            @i_canal       = @i_canal,
            @i_is_batch    = @i_enlinea,
            @i_inmovi      = @i_inmovi,
            @i_fecha_valor_a = @i_fecha_valor_a,
            @i_activar_cta = @i_activar_cta,
            @i_titular_prods = @i_titular_prods,
            @i_titularidad_prods = @i_titularidad_prods
			
       if @w_error <> 0
       begin
          goto ERROR
       end      

       select @o_valnxmil = @w_val_3xmil
       select @o_monto_imp = @w_monto_imp
    end
  
    if @i_operacion = 'G'
    begin
        select  @o_ctaint = ah_cuenta,
                @o_prod_banc = ah_prod_banc
        from    cob_ahorros..ah_cuenta
        where   ah_cta_banco = @i_cuenta
    end
    
    if @i_operacion = 'H'
    begin
        exec @w_error = cob_ahorros..sp_tr_query_nom_ctahorro
             @s_srv         = @s_srv,
             @s_lsrv        = @s_lsrv,
             @i_cta         = @i_cuenta,
             @i_mon         = @i_moneda,
             @o_titularidad = @w_titularidad out

      if @w_error <> 0
      begin
         goto ERROR
      end      
          
      select @o_titularidad = @w_titularidad
      
    end
    
    if @i_operacion = 'I'
    begin
       exec @w_error = cob_ahorros..sp_ahcalcula_saldo
            @i_cuenta           = @i_ctaint,
            @i_fecha            = @s_date,
            @o_saldo_para_girar = @w_saldo_d out,
            @o_saldo_contable   = @w_saldo_c out
          
      if @w_error <> 0
      begin
         goto ERROR
      end      
          
      select @o_saldo_para_girar = @w_saldo_d ,
             @o_saldo_contable   = @w_saldo_c
    end
    
    if @i_operacion = 'J'
    begin
        exec @w_error = cob_ahorros..sp_ctah_vigente
             @i_cta_banco    = @i_cta_banco,   
             @i_moneda       = @i_moneda        
  
        if @w_error <> 0
        begin
           goto ERROR
        end
    end
    
    if @i_operacion = 'K'
    begin
        if exists(select 1 from cob_ahorros..ah_cuenta
                  where ah_cta_banco = ltrim(rtrim(@i_num_cta_ahorro)))
            select @o_existe_cta = 1
        else
            select @o_existe_cta = 0
    end    
end

*/

return 0


ERROR:
   /*no se pudo anular operacion*/
   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error

go