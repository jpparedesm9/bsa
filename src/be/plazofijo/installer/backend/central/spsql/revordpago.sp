/************************************************************************/
/*      Archivo:                revordpago.sp                           */
/*      Stored procedure:       sp_revordpago                           */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 12/Mayo/2005                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/************************************************************************/
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/************************************************************************/
/*      Este procedimiento reversar las ordenes de pago emitidas.       */
/*                                                                      */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  20-ABR-2010     RICADO MARTINEZ Interfase de plazo fijo con ahorros */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_revordpago')
   drop proc sp_revordpago
go

create proc sp_revordpago (
   @s_ssn                  int           = NULL,
   @s_user                 login         = NULL,
   @s_sesn                 int           = NULL,
   @s_term                 varchar(30)   = NULL,
   @s_date                 datetime      = NULL,
   @s_srv                  varchar(30)   = NULL,
   @s_lsrv                 varchar(30)   = NULL,
   @s_ofi                  smallint      = NULL,
   @s_rol                  smallint      = NULL,
   @t_debug                char(1)       = 'N',
   @t_file                 varchar(10)   = NULL,
   @t_from                 varchar(32)   = NULL,
   @t_trn                  smallint,
   @i_num_banco            cuenta,
   @i_tipo                 char(1),
   @i_empresa              tinyint       = 1,
   @i_formato_fecha        int           = 101,
   @i_flag_crea            char(1)       = NULL,
   @i_transaccion          int           = NULL,
   @i_num_operacion        int           = NULL,
   @i_valor                money         = NULL,
   @i_producto             catalogo      = NULL,
   @i_cuenta               cuenta        = NULL,
   @i_moneda               smallint      = NULL,
   @i_secuencia            int           = NULL,
   @i_sub_secuencia        smallint      = NULL,
   @i_secuencial           int           = NULL,
   @i_tipo_cliente         char(1)       = NULL,
   @i_beneficiario         int           = NULL          
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_fecha_hoy            datetime,
        @w_error                int,
   
/* Variables para mov_monet_tmp */
        @w_mt_tran              int,
        @w_mt_secuencia         int,
        @w_mt_secuencial        int,
        @w_mt_sub_secuencia     tinyint,
        @w_mt_producto          catalogo,
        @w_mt_cuenta            cuenta,
        @w_mt_moneda            smallint,
        @w_mt_valor             money,
        @w_mt_tipo              char(1),
        @w_mt_beneficiario      int,
        @w_mt_oficina           int,
        @w_mt_tipo_cliente      char(1),
        @w_mt_fecha_crea        datetime,
        @w_mt_sec_emis_cheq     int,
        @w_mt_estado            char(1),
        @w_mt_num_cheque        int,
 
/* Variables para mov_monet */
        @w_mm_tran              int, 
        @w_mm_secuencia         int, 
        @w_mm_secuencial        int, 
        @w_mm_sub_secuencia     int, 
        @w_mm_producto          catalogo,
        @w_mm_cuenta            cuenta,
        @w_mm_moneda            smallint,
        @w_mm_valor             money,
        @w_mm_valor_ext         money,
        @w_mm_beneficiario      int,
        @w_mm_oficina           int,
        @w_mm_tipo_cliente      char(1),

/* Variables para det_pago */


/* Variables para pf_operacion */
        @w_operacionpf          int,
        @w_moneda_base          smallint,
        @w_producto             int,
        @w_return               int,
        @w_num_comprbt          smallint,
        @w_contador             smallint,
        @w_sec_historia         int,
        @w_codigo_alterno       int,
        @w_op_mon_sgte          int,
        @w_op_historia          int,
        @w_flag                 int,           --LIM 04/NOV/2005
        @w_mt_secuencial_lote   int,           -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
        @w_mt_subtipo_ins       int,           -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
        @w_instr_chqcom         tinyint,       -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_grupo1               varchar(30),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_mt_sec_mov		int
   
    
select @w_sp_name = 'sp_revordpago', 
       @w_mm_sub_secuencia = 0
select @w_fecha_hoy = convert(datetime, convert (varchar,@s_date,101)) 

------------------------------- 
-- Verificacion de Transaccion 
-------------------------------
if @t_trn <> 14767 
begin
   /* 'Error en codigo de transaccion' */
   exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 141018
   return 1
end
      
select @w_operacionpf  = op_operacion
from   pf_operacion
where  op_num_banco = @i_num_banco
         
if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 141051
   return 1
end

select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa = @i_empresa
                    
if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_debug=@t_debug,
   @t_file=@t_file,
   @t_from=@w_sp_name,
   @i_num = 601018
   return  1
end

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CHEQUES COMERCIALES - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'      

---------------------------------------
-- Lectura de secuenciales principales
---------------------------------------
select @w_op_mon_sgte = op_mon_sgte,
       @w_op_historia = op_historia
from   pf_operacion
where  op_operacion   = @w_operacionpf
   
-------------------------------------------------------------     
-- Proceso para tomar el registro a reversar emitido en la
-- pantalla de ordenes de pago.
-------------------------------------------------------------
if @i_tipo = 'C'
begin
   select 'NUM. DEPOSITO'   = substring(@i_num_banco,1,20),
          'FORMA PAGO'      = mm_producto,
          'VALOR'           = mm_valor,
          'CUENTA'          = mm_cuenta,   
          'MONEDA '         = mm_moneda, 
          'OPERACION'       = mm_operacion,
          'TRANSACCION'     = mm_tran,
          'SEC'             = mm_secuencia,
          'SUB SEC'         = mm_sub_secuencia,
          'SECUENCIAL'      = mm_secuencial,
          'TIPO CLIENTE'    = mm_tipo_cliente,
          'COD. BENEF'      = mm_beneficiario,
          'SEC EMIS CHEQUE' = mm_secuencia_emis_che,
          'ESTADO'          = mm_estado,
          'NUM. CHEQUE'     = mm_num_cheque,
          'SUBTIPO INST'    = mm_subtipo_ins,
          'SEC. LOTE'       = mm_secuencial_lote,
          'SUB SEC EC'	    = mm_sec_mov
    from   pf_mov_monet
    where  mm_operacion     = @w_operacionpf
      and  mm_fecha_crea    = @s_date
      and  mm_tipo          = 'C'
      and  mm_estado        = 'A' 
      and  mm_tran          = 14943
      
    if @@rowcount = 0
    begin
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143060
       return 1
    end
end 
  
if @i_tipo = 'R'      --Reversar orden de pago
begin

   /*LIM 23/ENE/2006 Creacion Tablas Temporales*/
   
   create table #ca_operacion_aux (
   op_operacion         int,
   op_banco             varchar(24), 
   op_toperacion        varchar(10),
   op_moneda            tinyint,
   op_oficina           int,
   op_fecha_ult_proceso datetime ,
   op_dias_anio         int,
   op_estado            int,
   op_sector            varchar(10),
   op_cliente           int,
   op_fecha_liq         datetime,
   op_fecha_ini         datetime ,
   op_cuota_menor       char(1),
   op_tipo              char(1),
   op_saldo             money,     -- LuisG 04.06.2001
   op_fecha_fin         datetime,   -- LuisG 04.06.2001
   op_base_calculo      char(1) , --lre version estandar 05/06/2001
   op_periodo_int       smallint, --lre version estandar 05/06/2001
   op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
   )
   
   
   
   create table #ca_abonos (
   ab_secuencial_ing    int,
   ab_dias_retencion    int         null,
   ab_estado            varchar(10) null,
   ab_cuota_completa    char(1)     null
   )
   
   /* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
   
   create table #interes_proyectado (
   concepto        varchar(10),
   valor           money
   )



   begin tran 
      
   select @w_sec_historia = max(hi_secuencial) + 1
   from   pf_historia
   where  hi_operacion = @w_operacionpf
        
   select @w_mt_sub_secuencia = 0,
          @w_codigo_alterno   = 0
   while 1 = 1
   begin
      ---------------------------------------
      -- Lectura de los registros a reversar 
      ---------------------------------------
      set rowcount 1           
      select @w_mt_tran            = mt_tran,
             @w_mt_secuencia       = mt_secuencia,
             @w_mt_secuencial      = mt_secuencial,
             @w_mt_sub_secuencia   = mt_sub_secuencia,
             @w_mt_producto        = mt_producto,
             @w_mt_cuenta          = mt_cuenta,
             @w_mt_moneda          = mt_moneda,
             @w_mt_valor           = mt_valor,
             @w_mt_tipo            = mt_tipo,
             @w_mt_beneficiario    = mt_beneficiario,
             @w_mt_oficina         = mt_oficina,
             @w_mt_tipo_cliente    = mt_tipo_cliente,
             @w_mt_fecha_crea      = mt_fecha_crea,
             @w_mt_sec_emis_cheq   = mt_sec_emis_cheq,
             @w_mt_estado          = mt_estado,
             @w_mt_num_cheque      = mt_num_cheque,
             @w_mt_secuencial_lote = mt_secuencial_lote,
             @w_mt_subtipo_ins     = mt_subtipo_ins,
             @w_mt_sec_mov	   = mt_sec_mov
      from   pf_mov_monet_tmp
      where  mt_operacion     = @w_operacionpf
        and  mt_usuario       = @s_user
        and  mt_sesion        = @s_sesn
        and  mt_fecha_crea    = @s_date
        and  mt_sub_secuencia > @w_mt_sub_secuencia
        
      if @@rowcount = 0
         break
  
  select @t_debug = 'N' 



   -- valido existencia de pagos en efectivo
    if exists 
    (select 1
    from   pf_emision_cheque x
    where  ec_operacion         = @w_operacionpf
    and    ec_tran              in(14905,14903,14904,14543,14168)
    and    ec_estado            = 'A'
    and    ec_fecha_emision is not null
    and    ec_caja 		  = 'S'
    and	   ec_fecha_caja is not null	
    and    exists( 
           select 1
      	   from   pf_emision_cheque y
           where  y.ec_operacion      = @w_operacionpf
           and    y.ec_tran           = 14943
           and    y.ec_estado         = 'A'
           and    y.ec_fecha_emision is not null
           and    y.ec_fpago          = 'EFEC'
           and    y.ec_numero         = x.ec_secuencial
           and    y.ec_secuencia      = @w_mt_secuencia
           and    y.ec_fecha_mov      = @s_date)) 
    begin
       print 'revordpago PAGOS EN EFECTIVO SIN REVERSAR EN BRANCH'
       select @w_error = 141254
       goto ERROR		
    end		

            
      set rowcount 0
            
      select @w_producto = fp_producto
      from   pf_fpago
      where  fp_mnemonico = @w_mt_producto
        and  fp_estado = 'A'  
                   
      if @w_producto in(3,4,7) --Cartera.
      begin
         if @w_flag <> 1
            select @w_flag = 0 

      ---------------------------------------
      -- Reversar valor acreditado a CTE/AHO
      ---------------------------------------
          exec @w_return         = sp_aplica_mov
               @s_ssn            = @s_ssn,
               @s_user           = @s_user,
               @s_ofi            = @s_ofi,
               @s_date           = @s_date,
               @s_srv            = @s_srv,
               @s_term           = @s_term,
               @t_file           = @t_file,
               @t_from           = @w_sp_name, 
               @t_debug          = @t_debug,
               @t_trn            = @w_mt_tran, 

               @i_operacionpf    = @w_operacionpf,
               @i_fecha_proceso  = @w_fecha_hoy ,
               @i_secuencia      = @w_mt_secuencia,
               @i_sub_secuencia  = @w_mt_sub_secuencia,
               @i_en_linea       = 'S',
               @i_tipo           = 'R'
            
          if @w_return <> 0
          begin
              print 'revordpago ERROR COB_CUENTAS'
              select @w_error = @w_return
              goto ERROR
          end 
      end --@w_producto
                     
      if @w_producto = 42
      begin
         select @w_flag = 1            --LIM 04/NOV/2005
          -------------------------------------------
          -- Reversar cheque si no fue emitido en SB
          -------------------------------------------
          select @w_codigo_alterno = @w_codigo_alterno + 1
          
          -- secuencial@estado@serielit@serienum@fautoriza@moneda@ TRAMA REQUERIDA
          select @w_grupo1 = cast(@w_mt_secuencial_lote as varchar) + '@' + 
                             'T'                                    + '@' + 
                             ''                                     + '@' + 
                             ''                                     + '@' + 
                             ''                                     + '@' + 
                             cast(@w_mt_moneda as varchar)          + '@'  
          

          exec  @w_return = cob_interfase..sp_isba_reversar_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_reversar_lotes
                @s_ssn              = @s_ssn,
                @s_date             = @s_date,
                @s_term             = @s_term,
                @s_sesn             = @s_sesn,
                @s_srv              = @s_srv,
                @s_lsrv             = @s_lsrv,
                @s_user             = @s_user,
                @s_ofi              = @s_ofi,
                @s_rol              = @s_rol,
                @t_debug            = 'N',
                @t_file             = @t_file,
                @t_trn              = 29301,
                @i_codigo_alterno   = @w_codigo_alterno,       -- SI SE LLAMA MAS DE UNA VEZ DESDE UN SP DEBE SUMARSE UNO A ESTE CAMPO PARA LA TRANSACCION DE SERVICIO
                @i_origen_ing       = '1',                     -- 1 INTERFASE 2 CARGA  3 MANUAL
                @i_secuencial       = @w_mt_secuencial_lote,   -- CODIGO GENERADO POR SBA DEL CHEQUE A REVERSAR - ANTES @w_mt_num_cheque
                @i_modulo           = 'PFI',                   -- MODULO QUE GENERO LA SOLICITUD DEL CHEQUE
                @i_moneda           = @w_mt_moneda,            -- MONEDA DEL INSTRUMENTO
                @i_func_aut         = @s_user,                 -- LOGIN DEL FUNCIONARIO QUE AUTORIZA EL REVERSO EN EL MODULO ORIGINAL
                @i_producto         = 4,                       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
                @i_instrumento      = @w_instr_chqcom,         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
                @i_subtipo_ins      = @w_mt_subtipo_ins,       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
                @i_causal_anul      = '99',                    -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
                @i_llamada_ext      = 'S',                     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                @i_grupo1           = @w_grupo1                -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
                
          if @w_return <> 0
          begin         
              print 'revordpago ERROR COB_SBANCARIOS'
              select @w_error = @w_return
              goto ERROR
          end
      end
       
             
       ----------------------------------------------------------------------
       -- Proceso para insertar en pf_historia el reverso de la orden de pago
       -----------------------------------------------------------------------
       insert pf_historia (hi_operacion  , hi_secuencial  ,   hi_fecha,
                           hi_trn_code   , hi_valor       ,   hi_funcionario,
                           hi_oficina    , hi_fecha_crea  ,   hi_fecha_mod,
                           hi_observacion)
                   values (@w_operacionpf, @w_sec_historia,     @s_date,
                           @w_mt_tran    , @w_mt_valor    ,     @s_user, 
                           @s_ofi        , @s_date        ,     @s_date,
                           'REVERSAR ORDEN DE PAGO')
       if @@error <> 0
       begin
           print 'revordpago ERROR INSERTAR PF_HISTORIA'
           select @w_error = 143006
           goto ERROR
       end
                
       select @w_sec_historia = @w_sec_historia + 1,
              @w_op_historia  = @w_op_historia + 1

       if @t_debug = 'S' print '@w_mt_sec_emis_cheq ' + cast (@w_mt_sec_emis_cheq as varchar)
       if @t_debug = 'S' print '@w_mt_tran ' + cast (@w_mt_tran as varchar)
       if @t_debug = 'S' print '@w_mt_secuencial ' + cast (@w_mt_secuencial as varchar)
       if @t_debug = 'S' print '@w_mt_secuencia ' + cast (@w_mt_secuencia as varchar)
       if @t_debug = 'S' print '@w_mt_sub_secuencia ' + cast (@w_mt_sub_secuencia as varchar)

   end  --while

   
   set rowcount 0

   if exists (select 1 from pf_emision_cheque where ec_secuencial = @w_mt_secuencial and ec_sub_secuencia = @w_mt_sub_secuencia and ec_estado = 'A') begin
      update pf_emision_cheque
      set    ec_estado        = 'R' --Reversado
      where  ec_secuencial    = @w_mt_secuencial
   end else begin
      print  'EMISION DE PAGO YA REVERSADA'
      select @w_error = 141087
      goto   ERROR
   end

   ---------------------------
   -- Actualizar pf_operacion
   ---------------------------
   update pf_operacion
   set    op_historia  = @w_op_historia,  
          op_mon_sgte  = @w_op_mon_sgte + 1  
   where  op_operacion = @w_operacionpf
     
   ------------------------------------------------------
   -- Proceso para actualizar el estado de los registros 
   -- reversados en la base de datos
   -------------------------------------------------------

if @t_debug = 'S' print '@w_mt_secuencial ' + cast (@w_mt_secuencial as varchar)

            
   update pf_mov_monet
   set    mm_estado = 'R'
   where  mm_operacion  = @w_operacionpf
   and    mm_secuencial = @w_mt_secuencial
                       
   if @@error <> 0
   begin
      print 'revordpago ERROR ACTUALIZAR PF_MOVMONET'
      select @w_error = 145020
      goto ERROR
   end

   /*
   update pf_det_pago
   set    dp_estado     = 'R' --Reversado
   where  dp_operacion  = @w_operacionpf
   and  dp_secuencial = @w_mt_secuencial
   and  dp_estado     = 'A' 
      
   if @@error <> 0
   begin
   print 'revordpago ERROR ACTUALIZAR PF_DET_PAGO'
   select @w_error = 147038
   goto ERROR
   end           
   */
   --------------------------------------------------------------------------
   -- Restaurar valores registro original para volver a emitir orden de pago
   --------------------------------------------------------------------------

if @t_debug = 'S' print '@w_operacionpf '  + cast (@w_operacionpf as varchar)
if @t_debug = 'S' print '@w_mt_sec_emis_cheq ' + cast (@w_mt_sec_emis_cheq as varchar)
if @t_debug = 'S' print '@w_mt_sub_secuencia ' + cast (@w_mt_sub_secuencia as varchar)


   update pf_emision_cheque
   set    ec_estado        = NULL,  
          ec_fecha_emision = NULL,
          ec_caja          = NULL,
          ec_fecha_caja    = NULL
   where  ec_operacion     = @w_operacionpf
   and    ec_secuencia     = @w_mt_sec_emis_cheq
   and    ec_estado        is not null
   and	  ec_fecha_emision is not null
   and    ec_sub_secuencia = @w_mt_sec_mov
   if @@rowcount = 0
   begin
       print 'revordpago ERROR ACTUALIZAR PF_EMISION_CHEQUE_2'
       select @w_error = 145031
       goto ERROR
   end
   /*
   update pf_det_pago
   set    dp_estado     = 'A' --Aplicado
   where  dp_operacion  = @w_operacionpf
   and    dp_secuencial = @w_mt_secuencial
   and    dp_estado     = 'E' 
    
   if @@error <> 0
   begin
      print 'revordpago ERROR ACTUALIZAR PF_DET_PAGO'
      select @w_error = 147038
      goto ERROR
   end
   */
   -------------------------------------------------
   -- Reversar los comprobantes contables generados
   -------------------------------------------------         


   exec @w_return = sp_aplica_conta
   @i_anulacion     = 'S',
   @i_operacionpf   = @w_operacionpf,
   @i_tipo_trn      = 'EOP',
   @i_fecha         = @s_date,
   @i_secuencia     = @w_mt_secuencia

   
   if @w_return <> 0 begin
      rollback tran
      exec cobis..sp_cerror
      @t_from          = @w_sp_name,
      @i_num           = @w_return
      
      return @w_return
   end   
   
   select @w_num_comprbt = count(*)
   from   pf_relacion_comp
   where  rc_num_banco  = @i_num_banco
   and    rc_cod_tran   = @w_mt_tran
   and    rc_tran       = 'PGINT'
   and    rc_fecha_tran = @s_date
      
   select @w_contador = 0
   
   while @w_contador <= @w_num_comprbt
   begin
      set rowcount 0
      update pf_relacion_comp 
      set    rc_estado = 'R'
      where  rc_num_banco = @i_num_banco
      and    rc_tran      = 'PGINT' 
      and    rc_estado    = 'N'
      
      if @@error  <> 0
      begin
         print 'revordpago ERROR ACTUALIZAR PF_RELACION_COMP'
         select @w_error = 143041
         goto ERROR
      end      
      select @w_contador = @w_contador + 1
            
   end
   commit tran              
end  -- @i_tipo = 'R'   

    
-------------------------
-- Borrar tabla temporal
-------------------------
set rowcount 0
delete pf_mov_monet_tmp
where  mt_usuario  = @s_user
and    mt_sesion   = @s_sesn
        
return 0
             
-------------------------------
-- Rutina para manejo de error
-------------------------------
ERROR:
   --print 'ENTRA ERROR'
   rollback tran
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error
   return @w_error
 
go
