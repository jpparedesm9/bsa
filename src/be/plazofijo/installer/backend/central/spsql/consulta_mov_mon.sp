/************************************************************************/
/*      Archivo:                renmovmo.sp                             */
/*      Stored procedure:       sp_consulta_mov_mon                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 07/Sep/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado realiza las consultas             */
/*      de los movimientos monetarios de una operacion                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      12-Nov-99  Marcelo Cartagena  Control de valores nulos          */
/*      18-Mar-05  Katty Tamayo       Operaci¢n H Tipo T aumento,       */
/*                                    cuenta, nombre de beneficiario    */
/*       7-Oct-05  Luis Im            Manejo correcto de siguientes     */      
/************************************************************************/
use cob_pfijo
go

if exists (select * from sysobjects where name = 'sp_consulta_mov_mon')
   drop proc sp_consulta_mov_mon 
go

create proc sp_consulta_mov_mon  (
   @s_ssn                  int = null,
   @s_user                 login = null,
   @s_sesn                 int = null,
   @s_term                 varchar(30) = null,
   @s_date                 datetime = null,
   @s_srv                  varchar(30) = null,
   @s_lsrv                 varchar(30) = null,
   @s_ofi                  smallint = null,
   @s_rol                  smallint = NULL,
   @t_debug                char(1) = 'N',
   @t_file                 varchar(10) = null,
   @t_from                 varchar(32) = null,
   @t_trn                  smallint,
   @i_operacion            char(1),
   @i_tipo                 char(1),
   @i_num_banco            cuenta,
   @i_secuencia            int =-1 ,
   @i_formato_fecha        int = 0,   /* GESCY2K B284 */
   @i_empresa              tinyint = 1
)
as
/*  Variables para pf_operacion  */
declare         
   @w_sp_name              varchar(32),
   @w_codigo               int,
   @w_operacionpf          int,
   @w_moneda               tinyint, 
   @w_moneda_base          tinyint


   select @w_sp_name = 'sp_consulta_mov_mon' 

   if @t_trn != 14639 and @i_operacion != 'H'
   begin
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141112
      /*  'Error en codigo de transaccion' */
      return 1
   end
 
   select @w_operacionpf  = op_operacion,
          @w_moneda       = op_moneda
   from   pf_operacion
   where  op_num_banco = @i_num_banco
 
 
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from = @w_sp_name,
      @i_num = 141051
      return 1
   end

   If @i_operacion = 'H'
   begin
      set rowcount 20
      if @i_tipo = 'C'  /* Consulta detallada */
      begin
         select mo_descripcion,  
                fp_descripcion,
                isnull(mm_valor,0)+isnull(mm_impuesto,0),  
                mm_cuenta,   
                isnull(mm_valor_ext,0)+isnull(mm_impuesto_capital_me,0), 
                mm_producto,
                mm_beneficiario
         from   pf_mov_monet,pf_fpago,cobis..cl_moneda            
         where  mm_operacion  = @w_operacionpf
           and  mm_secuencia  = 0        
      and  mm_tipo       = 'B'     --CVA Ene-13-06 para que no considere Vueltos
           and  mm_moneda     = mo_moneda
           and  mm_producto   = fp_mnemonico
           and  fp_estado     = 'A'
      end

      if @i_tipo = 'R'  /* Renovacion o Modificacion */
      begin
                
         select @w_moneda_base = em_moneda_base
         from cob_conta..cb_empresa
         where em_empresa = @i_empresa
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
              @t_debug=@t_debug,
              @t_file=@t_file,
              @t_from=@w_sp_name, 
              @i_num = 601018
            return  1
         end 
                
         /* GES 03/24/1999 Se incrementa el campo del impuesto y se 
            condiciona por moneda */
         if @w_moneda = @w_moneda_base      
            select mo_descripcion,
                   fp_descripcion,
                   isnull(mm_valor,0)+isnull(mm_impuesto,0), -- MCA 12-Nov-1999
                   mm_cuenta,   
                   mm_moneda,
                   mm_producto,
                   mm_beneficiario ,
                   mm_cotizacion,
                   isnull(mm_valor,0)+isnull(mm_impuesto,0), -- MCA 12-Nov-1999
                   fp_automatico,
                   mm_secuencia,
                   isnull(mm_valor,0),  -- MCA 12-Nov-1999
                   mm_impuesto,
                   mm_autorizado,
                   mm_ttransito
            from   pf_mov_monet,pf_fpago,cobis..cl_moneda            
            where  mm_operacion  = @w_operacionpf
              and  mm_secuencia  = 0            
              and  mm_moneda     = mo_moneda
              and  mm_producto      = fp_mnemonico
         and  mm_tipo              = 'B' --CVA Ene-13-06 para que no salga vuelto
              and  fp_estado     = 'A'
         else
            select mo_descripcion,
                   fp_descripcion,
                   isnull(mm_valor_ext,0)+isnull(mm_impuesto_capital_me,0), -- MCA 12-Nov-1999
                   mm_cuenta,   
                   mm_moneda,
                   mm_producto,
                   mm_beneficiario ,
                   mm_cotizacion,
                   isnull(mm_valor_ext,0)+isnull(mm_impuesto_capital_me,0), -- MCA 12-Nov-1999
                   fp_automatico,
                   mm_secuencia,
                   isnull(mm_valor_ext,0), -- MCA 12-Nov-1999
                   mm_impuesto_capital_me
            from   pf_mov_monet,pf_fpago,cobis..cl_moneda            
            where  mm_operacion = @w_operacionpf
              and  mm_secuencia = 0            
              and  mm_moneda  = mo_moneda
              and  mm_producto   = fp_mnemonico
         and  mm_tipo      = 'B' --CVA Ene-13-06 para que no salga vuelto
              and  fp_estado = 'A'
         end
      if @i_tipo= 'A'  /* Activacion  */
      begin
         select distinct mo_descripcion,
                fp_descripcion,
                isnull(mm_valor,0)+isnull(mm_impuesto,0),   -- MCA 12-Nov-1999
                mm_sub_secuencia
         from   pf_mov_monet,pf_fpago,cobis..cl_moneda            
         where  mm_operacion = @w_operacionpf
           and  mm_secuencia = 0            
           and  mm_producto = fp_mnemonico
           and  fp_automatico = 'C'
           and  mm_moneda = mo_moneda
           and  fp_estado = 'A'
      end

      if @i_tipo= 'T'  /* Todos los movimientos monetarios  */
      begin
        select distinct 
               convert(varchar(10), mm_fecha_crea, @i_formato_fecha),
               case mm_tran 
                  when 14904 then
                     case mm_tipo  
                        when 'C' then 'DISMINUCION/RENOVACION'                 
                        when 'B' then 'INCREMENTO/RENOVACION'                 
                     end
                  when 14952 then
                     case mm_tipo
                        when 'C' then
                           case substring(mm_producto,2,4) 
                              when 'FRA' then 'CANCELACION POR FRACCIONAMIENTO'
                              when 'FUS' then 'CANCELACION POR CONSOLIDACION'
                           end                  
                        when 'B' then
                           case  substring(mm_producto,2,4) 
                              when 'FRA' then 'APERTURA POR FRACCIONAMIENTO'
                              when 'FUS' then 'APERTURA POR CONSOLIDACION'
                           end
                     end                    
                  when 14901 then
                     case mm_tipo
                        when 'C' then 'APERTURA DE DEPOSITO - VUELTO'                                
                        else substring(tn_descripcion,1,30)
                     end
                  else     
                     substring(tn_descripcion,1,30)
               end,
               substring(fp_descripcion,1,30),
               mo_descripcion,
               isnull(mm_valor,0)+isnull(mm_impuesto,0), -- MCA 12-Nov-1999  
               isnull(mm_valor_ext,0)+isnull(mm_impuesto_capital_me,0),  -- MCA 12-Nov-1999 
               mm_estado,
               mm_secuencia,
               mm_cuenta,   --KTA GB-GAPDP00012
               'tipo_cliente' = case 
                                   when mm_tipo_cliente = 'E' then ce_nombre
                                   when mm_tipo_cliente = 'M' then en_nomlar
                                   else ''
                                end,
               'fecha_valor' = convert(varchar(10),mm_fecha_valor,@i_formato_fecha),
               mm_tran,
               mm_sub_secuencia
        from   pf_mov_monet
        inner join pf_fpago on
           mm_producto = fp_mnemonico
           inner join cobis..cl_moneda on
              mm_moneda = mo_moneda
              inner join cobis..cl_ttransaccion on
                 mm_tran   = tn_trn_code
                 left outer join cobis..cl_ente on
                    mm_beneficiario = en_ente
                    left outer join pf_cliente_externo on
                       mm_beneficiario = ce_secuencial
        where mm_operacion = @w_operacionpf
        and mm_tran  != 14995  --CVA Nov-05-05
        and convert(int,(convert(varchar(15),mm_secuencia) + convert(varchar(15),mm_sub_secuencia))) > @i_secuencia    
        and fp_estado = 'A'
        and (mm_estado = 'A' or mm_estado is null)
      order by mm_secuencia, mm_sub_secuencia    --LIM 08/NOV/2005      
   end

end

return 0   

go
