/************************************************************************/
/*      Archivo:                renfpa.sp                               */
/*      Stored procedure:       sp_consulta_det_pago                    */
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
/*      de los detalles de pago de acuerdo al tipo                      */
/************************************************************************/
/*             Modificaciones                         */
/*  Fecha      Modificado por    Modificacion      */
/*  19/NOV/2005         Luis Im               Se aœade codigo banco ach */
/*  05/Dic/2016         A.Zuluaga  Desacople                            */
/************************************************************************/
use cob_pfijo
go

if exists (select * from sysobjects where name = 'sp_consulta_det_pago')
   drop proc sp_consulta_det_pago
go

create proc sp_consulta_det_pago (
      @s_ssn                  int = null,
      @s_user                 login = null,
      @s_sesn                    int = null,
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
      @i_activacion            char(1) = 'S',
      @i_tipo                  char(1),  
      @i_tipodp               catalogo, 
      @i_num_banco            cuenta,
      @i_tipo_renovacion      char(2) = null,
      @i_filial               int     = 1,   --LIM 19/NOV/2005
      @i_banco                varchar(24) = null
)
as
/*  Variables para pf_operacion  */
declare @w_sp_name              varchar(32),
        @w_codigo               int,
        @w_operacionpf          int,
        @w_fecha_ven            datetime,
        @w_banco_ach            descripcion,  --LIM 19/NOV/2005
        @w_vuelto               money,
        @w_return               int

select @i_banco = @i_num_banco

create table #re_banco_org_ach (
br_banco     varchar(24)   null,
br_filial    int           null
)

select @w_sp_name = 'sp_consulta_det_pago',    
       @w_vuelto = 0

if @t_trn != 14638 or @i_operacion != 'H'
begin
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141112
      /*  'Error en codigo de transaccion' */
      return 1
end

select   @w_operacionpf  = op_operacion,
   @w_fecha_ven = op_fecha_ven    
from pf_operacion
where op_num_banco = @i_num_banco
if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 141051
   return 1
end

select @w_vuelto = sum(mm_valor)
from pf_mov_monet
where mm_operacion = @w_operacionpf 
and mm_tran = 14901
and mm_tipo = 'C'

select @w_banco_ach = ''

--print @i_tipodp
if @i_operacion = 'H'
begin
    
   set rowcount 20
   if @i_tipo = 'V'
   begin
         select    
         fp_descripcion,
         dp_monto,
         dp_cuenta,
         dp_forma_pago,
         case fp_producto
              when 42 then
             (select mo_descripcion from cobis..cl_moneda where mo_moneda = A.dp_moneda_pago)  
         end,
         case fp_producto
              when 42 then
              of_nombre
         end
         from pf_det_pago A
         inner join pf_fpago on
            dp_forma_pago = fp_mnemonico
            left outer join cobis..cl_oficina on
               dp_oficina = of_oficina
         where dp_operacion = @w_operacionpf
         and fp_estado = 'A'
         and dp_estado_xren = 'N'
         and dp_tipo = @i_tipodp
         and dp_estado = 'I'                             
   end

   if @i_tipo = 'C'
   begin
   
      select @i_banco = dp_cod_banco_ach
      from pf_det_pago A
      inner join pf_fpago on
         dp_forma_pago = fp_mnemonico 
         left outer join cobis..cl_oficina on --GAR 18-mar-2005 DP00022
            dp_oficina = of_oficina
      where dp_operacion   = @w_operacionpf 
        and fp_estado      = 'A'
        and dp_tipo        = @i_tipodp
        and dp_estado_xren = 'N'
        and dp_estado      = 'I' 

      exec @w_return = cob_interfase..sp_iremesas
           @i_operacion = 'E',
           @i_banco     = @i_banco
   
      select fp_descripcion, 
             dp_descripcion,
         
             dp_monto,
             dp_cuenta,
             dp_porcentaje,
                                case dp_tipo_cliente  --SOLO DEBE DESPLEGAR SI ES CLIENTE MIS
                                     when 'M' then
                                          dp_ente          
                                end,
         dp_forma_pago,
         'moneda pago' = (select mo_descripcion from cobis..cl_moneda where mo_moneda = A.dp_moneda_pago),  
         fp_producto, --GAR 15-mar-2005 DP00008 DP00057
                        case fp_producto
         when 42 then     --CVA Set-7-05                     
                 of_nombre
                        end,
         1,
         dp_monto,
         isnull(dp_tipo_cliente, 'M'),
         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         dp_tipo_cuenta_ach,
                        --dp_banco_ach       --LIM 19/NOV/2005 Comentado
         dp_cod_banco_ach,    --LIM 19/NOV/2005
                        of_nombre,        --LIM 19/NOV/2005
         ''           --LIM 19/NOV/2005
      from pf_det_pago A
      inner join pf_fpago on
         dp_forma_pago = fp_mnemonico 
         left outer join cobis..cl_oficina on --GAR 18-mar-2005 DP00022
            dp_oficina = of_oficina
            left outer join #re_banco_org_ach on   -- BRON: 15/07/09  cob_remesas..re_banco_org_ach      --LIM 19/NOV/2005
               dp_cod_banco_ach  = br_banco and
               br_filial = @i_filial 
      where dp_operacion = @w_operacionpf 
      and fp_estado = 'A'
      and dp_tipo = @i_tipodp
      and dp_estado_xren = 'N'
      and dp_estado = 'I'                                
   end
   
   if @i_tipo = 'I'
   begin
      select i_banco = dp_cod_banco_ach    --LIM 19/NOV/2005
      from    pf_det_pago A
      inner join pf_fpago on
         dp_forma_pago = fp_mnemonico 
         left outer join cobis..cl_oficina on --GAR 18-mar-2005 DP00022
            dp_oficina = of_oficina
      where dp_operacion = @w_operacionpf 
      and fp_estado = 'A'
      and dp_tipo = @i_tipodp
      and dp_estado_xren = 'N'
      and dp_estado = 'I'              

      exec @w_return = cob_interfase..sp_iremesas
           @i_operacion = 'E',
           @i_banco     = @i_banco

      select   fp_descripcion, 
                         dp_descripcion , 
         dp_monto,
         dp_cuenta,
         dp_porcentaje,
                                case dp_tipo_cliente  --SOLO DEBE DESPLEGAR SI ES CLIENTE MIS
                                     when 'M' then
                                          dp_ente          
                                end,
         dp_forma_pago,
         dp_moneda_pago,
         fp_producto, --GAR 15-mar-2005 DP00008 DP00057
                        dp_oficina,
         1,
         dp_monto,
         isnull(dp_tipo_cliente, 'M'),
         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,
         dp_tipo_cuenta_ach,
         dp_cod_banco_ach,    --LIM 19/NOV/2005
         of_nombre,        
         ''  ,
         dp_benef_chq
      from    pf_det_pago A
      inner join pf_fpago on
         dp_forma_pago = fp_mnemonico 
         left outer join cobis..cl_oficina on --GAR 18-mar-2005 DP00022
            dp_oficina = of_oficina
            left outer join #re_banco_org_ach on -- BRON: 15/07/09   cob_remesas..re_banco_org_ach
               dp_cod_banco_ach  = br_banco
               and br_filial = @i_filial      --LIM 19/NOV/2005
      where dp_operacion = @w_operacionpf 
      and fp_estado = 'A'
      and dp_tipo = @i_tipodp
      and dp_estado_xren = 'N'
      and dp_estado = 'I'              
   end

   if @i_tipo = 'X' --CVA Ene-13-06 Criterio para vueltos 
   begin
      select @i_banco = mm_cod_banco_ach   
      from    pf_mov_monet A
      inner join pf_fpago on
         mm_producto   = fp_mnemonico 
         left outer join cobis..cl_oficina on
            mm_oficina     = of_oficina
      where    mm_operacion      = @w_operacionpf 
      and mm_tran             = 14901 --Aperturas
      and fp_estado      = 'A'
      and mm_tipo       = 'C'              

      exec @w_return = cob_interfase..sp_iremesas
           @i_operacion = 'E',
           @i_banco     = @i_banco

      select   fp_descripcion,
                     case mm_tipo_cliente   
                      when 'M' then (select case when isnull(en_nomlar,'')= '' 
                                                then p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre
                                          else en_nomlar
                                       end
                                      from cobis..cl_ente
                        where A.mm_beneficiario = en_ente)
            else (select isnull(ce_nombre, '') from pf_cliente_externo where A.mm_beneficiario = ce_secuencial)
         end,        
         mm_valor,
         mm_cuenta,
         round(mm_valor/@w_vuelto,2)*100,
                                case mm_tipo_cliente  
                                     when 'M' then
                                          mm_beneficiario
                                end,
         mm_producto,
         mm_moneda,
         fp_producto, 
                        mm_oficina_pago,
         1,
         mm_valor,
         isnull(mm_tipo_cliente, 'M'),
         case mm_tipo_cliente 
         when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.mm_beneficiario = ce_secuencial  )
         else '' 
         end,
         case mm_tipo_cliente 
         when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.mm_beneficiario = ce_secuencial  )
         else '' 
         end,
         mm_tipo_cuenta_ach,
         mm_cod_banco_ach,    
         of_nombre,        
         ''           
      from    pf_mov_monet A
      inner join pf_fpago on
         mm_producto   = fp_mnemonico 
         left outer join cobis..cl_oficina on
            mm_oficina     = of_oficina
            left outer join #re_banco_org_ach on -- BRON: 15/07/09   cob_remesas..re_banco_org_ach
               mm_cod_banco_ach   = br_banco 
               and br_filial      = @i_filial 
      where    mm_operacion      = @w_operacionpf 
      and mm_tran             = 14901 --Aperturas
      and fp_estado      = 'A'
      and mm_tipo       = 'C'              
   
   end

   if @i_tipo = 'R'
   begin
      set rowcount 0
      if @i_tipo_renovacion = 'IR'
      begin

         select  @i_banco = dp_cod_banco_ach --LIM 19/NOV/2005
         from    pf_det_pago A
         inner join pf_fpago on
            dp_forma_pago = fp_mnemonico
            left outer join cobis..cl_oficina on
               dp_oficina = of_oficina
         where dp_operacion = @w_operacionpf 
         and fp_estado = 'A'
         and dp_estado_xren = 'S'
         and dp_estado = 'I'

         exec @w_return = cob_interfase..sp_iremesas
              @i_operacion = 'E',
              @i_banco     = @i_banco
                
         select  fp_descripcion,
                        dp_descripcion ,
                     /*case dp_tipo_cliente   
                      when 'M' then (select case when isnull(en_nomlar,'')= '' 
                                                then p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre
                                          else en_nomlar
                                       end
                                      from cobis..cl_ente
                        where A.dp_ente = en_ente)
            else dp_descripcion 
         end,*/
         dp_monto,
         dp_cuenta,
         dp_porcentaje,
                                case dp_tipo_cliente  --SOLO DEBE DESPLEGAR SI ES CLIENTE MIS
                                     when 'M' then
                                          dp_ente          
                                end,
         dp_forma_pago,
         'moneda pago' = (select mo_descripcion from cobis..cl_moneda where mo_moneda = A.dp_moneda_pago),  
         fp_producto, 
                        case fp_producto
         when 42 then     
                 of_nombre
                        end,
         1,
         dp_monto,
         isnull(dp_tipo_cliente, 'M'),
         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,
         dp_tipo_cuenta_ach,
         --dp_banco_ach
         dp_cod_banco_ach, --LIM 19/NOV/2005
         of_nombre,     --LIM 19/NOV/2005
         ''        --LIM 19/NOV/2005
         from    pf_det_pago A
         inner join pf_fpago on
            dp_forma_pago = fp_mnemonico
            left outer join cobis..cl_oficina on
               dp_oficina = of_oficina
               left outer join #re_banco_org_ach on -- BRON: 15/07/09  cob_remesas..re_banco_org_ach     --LIM 19/NOV/2005
                  dp_cod_banco_ach  = br_banco and
                  br_filial = @i_filial
         where dp_operacion = @w_operacionpf 
         and fp_estado = 'A'
         and dp_estado_xren = 'S'
         and dp_estado = 'I'
              
   end
   else
   begin

      select   fp_descripcion, dp_descripcion,
                     /*case dp_tipo_cliente   
                      when 'M' then (select case when isnull(en_nomlar,'')= '' 
                                                then p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre
                                          else en_nomlar
                                       end
                                      from cobis..cl_ente
                        where A.dp_ente = en_ente)
            else dp_descripcion 
         end,*/
         
         dp_monto,
         dp_cuenta,
         dp_porcentaje,
                                case dp_tipo_cliente  --SOLO DEBE DESPLEGAR SI ES CLIENTE MIS
                                     when 'M' then
                                          dp_ente          
                                end,
         dp_forma_pago,
         'moneda pago' = (select mo_descripcion from cobis..cl_moneda where mo_moneda = A.dp_moneda_pago),  
         fp_producto, 
                        case fp_producto
         when 42 then     
                 of_nombre
                        end,
         1,
         dp_monto,
         isnull(dp_tipo_cliente, 'M'),
         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         case dp_tipo_cliente 
         when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.dp_ente = ce_secuencial  )
         else '' 
         end,

         dp_tipo_cuenta_ach,
         --dp_banco_ach    --LIM 19/NOV/2005 Comentado
                        dp_cod_banco_ach, --LIM 19/NOV/2005
                        of_nombre,     --LIM 19/NOV/2005
         '' --LIM 19/NOV/2005
      from pf_det_pago A
      inner join pf_fpago on
         dp_forma_pago = fp_mnemonico 
         left outer join cobis..cl_oficina on
            dp_oficina = of_oficina
            left outer join #re_banco_org_ach on -- BRON: 15/07/09  cob_remesas..re_banco_org_ach --LIM 19/NOV/2005
               dp_cod_banco_ach  = br_banco and
               br_filial = @i_filial 
      where dp_operacion = @w_operacionpf 
      and fp_estado = 'A'
         --and dp_tipo = @i_tipodp
      and dp_estado_xren = 'N'
      and dp_estado = 'I'              

      end
   end
end   

return 0   

go
