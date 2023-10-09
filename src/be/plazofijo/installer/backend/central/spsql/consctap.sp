/************************************************************************/
/*      Archivo:                consctap.sp                             */
/*      Stored procedure:       sp_parametro_cuenta                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Depositos a Plazo                       */
/*      Disenado por:           Miguel Viejo  M.                        */
/*      Fecha de escritura:     01-Ago-1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Construir la cuenta contable en base al detalle del asiento     */
/*      de un perfil contable dado.                                     */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR            RAZON                          */
/*      20/Nov/95       M.Viejo M.       Adaptacion para DPF            */
/*      22/Abr/99       D.Guerrero    Cambios por SQLSERVER 6.5, se     */
/*                                    reemplazo datalength x datalength*/
/*                                    Se cambio la eliminacion del sp   */
/*      17-Mar-2005     N. Silva      Correccion de Indentacion         */
/*      03-Jul-2009  Y. Martinez     NYM PF00013 IEECOLBM   */
/*      08-Jul-2009  Y. Martinez     NYM PF00014 ENAJENACION   */
/*      18-Jul-2009  Y. Martinez     NYM PF00015 ICA     */
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

/*DGU E007-04/22/1999 SQLSERVER65*/
if exists (select 1 from sysobjects where name = 'sp_parametro_cuenta')
   drop proc sp_parametro_cuenta
go

create proc sp_parametro_cuenta (
   @t_rty               char(1)     = null,
   @t_trn               int         = null,
   @t_debug             char(1)     = 'N',
   @t_file              varchar(14) = null,
   @t_from              varchar(30) = null,
   @i_empresa           tinyint,
   @i_toperacion        catalogo,
   @i_toperacion_orig   catalogo,  --para el caso de xxxD
   @i_cuenta            varchar(20),
   @i_forma_pago        catalogo,
   @i_plazo             catalogo, 
   @i_moneda            tinyint , 
   @i_oficina           int         = null, 
   @s_ssn               int         = null,
   @s_date              datetime    = null,
   @s_user              login       = null,
   @s_term              descripcion = null,
   @s_corr              char(1)     = null,
   @s_ssn_corr          int         = null,
   @s_ofi               int         = null,
   @i_tipo              char(1)     = 'S',
   @i_tipo_persona      catalogo    = null, -- Si es Local Normal (LN), etc.                                     
   @i_tipo_banca        catalogo    = null,
   @i_tipo_ente         catalogo    = null,  -- NYM CPF00016 CERTRET
   @o_param1            varchar(20) out,
   @o_param2            varchar(20) out,
   @o_param3            varchar(20) out,
   @o_param4            varchar(20) out,
   @o_param5            varchar(20) out,
   @o_param6            varchar(20) out,
   @o_param7            varchar(20) out,
   @o_param8            varchar(20) out,
   @o_param9            varchar(20) out,
   @o_param10           varchar(20) out,
   @o_area              int         out     -- Area de afectacion
)
with encryption
as
declare
   @w_return             int,            -- valor que retorna
   @w_sp_name            varchar(32),   -- nombre del stored procedure
   @w_spname             varchar(32),   -- nombre de stored procedure
   @w_estado             char(1),
   @w_plazo              catalogo, 
   @w_cuenta             varchar(20),
   @w_clave              varchar(20),
   @w_clave1             int,
   @w_clave2             int,
   @w_cont               tinyint,
   @w_paso               tinyint,
   @w_tran               int,
   @w_paramt             varchar(20),
   @w_string             varchar(20),
   @w_pos                tinyint,
   @w_segmnt             varchar(20),
   @w_stored             varchar(32),
   @w_trn                int,
   @w_param1             varchar(20) ,
   @w_param2             varchar(20) ,
   @w_param3             varchar(20),
   @w_param4             varchar(20) ,
   @w_param5             varchar(20) ,
   @w_param6             varchar(20)  ,
   @w_param7             varchar(20) ,
   @w_param8             varchar(20) ,
   @w_param9             varchar(20) ,
   @w_param10            varchar(20),
   @w_parametro_efectivo varchar(30), 
--INI NYM DPF00016 CERTRET
   @w_banco              varchar(10),
   @w_abr_pais           varchar(3),
   @w_nem_colombia       varchar(3)
   
select   @w_abr_pais = pa_char
from  cobis..cl_parametro 
where    pa_nemonico = 'ABPAIS'

select   @w_banco = pa_char
from  cobis..cl_parametro 
where    pa_nemonico = 'CLIENT'

-- FINI NYM DPF00016 CERTRET


select @w_sp_name = 'sp_parametro_cuenta'
select @w_paramt = null


--------------------------------------------------------------------------------------
-- Proceso de cuenta contable,en el caso de que la cuenta pueda ser solo un parametro 
--------------------------------------------------------------------------------------
select @w_cuenta = @i_cuenta

--print 'consctap.sp CUENTA %1! ' + cast( @i_cuenta as varchar) 

select @w_pos = charindex('.',@w_cuenta)
if @w_pos = 0 
   select @w_pos = datalength(@w_cuenta)+1 
else 
begin
   if ascii(@w_cuenta) > 47 and ascii(@w_cuenta) < 58 -- Es parte numerica 
      select @w_cuenta = stuff(@w_cuenta,1,@w_pos,null)
end

select @w_cont = 0

------------------------------------------------
-- control para constantes o valores numericos
------------------------------------------------
if ascii(@w_cuenta) <= 47 or ascii(@w_cuenta) >= 58 -- No es parte numerica 
begin
   while @w_cuenta is not null
   begin
      -------------------------------------------
      -- Extraer parametro variable de la cuenta
      -------------------------------------------
      select @w_pos = charindex('.',@w_cuenta)
      if @w_pos = 0 
         select @w_pos = datalength(@w_cuenta)+1 --DGU E006-SQL65 04/22/99 
    
      select @w_pos = @w_pos-1

      if @w_pos > 0
        select @w_paramt = substring(@w_cuenta,1,@w_pos),
               @w_cuenta = stuff(@w_cuenta,1,(@w_pos+1),null)
      else
        select @w_paramt = null
      
      if rtrim(ltrim(@w_cuenta)) = ''                       -- GAL 01/SEP/2009 - RVVUNICA
         select @w_cuenta = null

      ----------------------------------------
      -- Control cuando no es parte numerica
      ----------------------------------------
      if ascii(@w_paramt) <= 47 or ascii(@w_paramt) >= 58 
      begin
         select @w_clave = null
         select @w_paso = 0
 
         ----------------------------------------------------------
         -- Selecciona transaccion que le corresponde al parametro 
         ----------------------------------------------------------
        
         select @w_tran = pa_transaccion 
         from cob_conta..cb_parametro 
         where pa_parametro = @w_paramt

         if @@rowcount = 0 
         begin
            return 141009
         end 

   -- print 'CONSCTAP.sp @w_paramt %1! w_tran %2! ',@w_tran  , @w_paramt     

         --------------------------------------------------    
         -- Busqueda de area contable por tipo de deposito 
         --------------------------------------------------
         if @w_tran = 14934
         begin 
            if @i_cuenta = 'FPAZ' and @i_forma_pago = 'EFEC'
            begin
               select @o_area = isnull(td_area_contable, 0)
               from pf_tipo_deposito
               where (td_mnemonico = @i_toperacion) or (td_mnemonico = @i_toperacion_orig)
               
               if @@rowcount = 0
               begin
                  print 'consctap.sp area e-n cero para deposito'
                  return 141188  --CVA Set-8-05 Agregar return
               end
            end
            else
            begin  
               select @o_area = isnull(fp_area_contable, 0)
               from pf_fpago         
               where fp_mnemonico = @i_forma_pago 

               if @@rowcount = 0 or @o_area = 0
               begin
                  select @o_area = isnull(td_area_contable, 0)
                  from pf_tipo_deposito
                  where td_mnemonico = @i_toperacion 
                  
                  if @@rowcount = 0
                  begin
                     print '2. consctap.sp area en cero para deposito'
                     return 141188 --CVA Set-8-05 Agregar return
                  end
               end
            end
         end
         else 
         begin
            select @o_area = isnull(td_area_contable, 0)
            from pf_tipo_deposito
            where (td_mnemonico = @i_toperacion) or (td_mnemonico = @i_toperacion_orig)
       
            if @@rowcount = 0
            begin
               print 'consctap.sp area en cero para deposito'
               return 141188  --CVA Set-8-05 Agregar return
            end
         end

         ---------------------
         -- Parametro Gar/comi
         ---------------------
         if @w_tran = 14957
         begin                                           -- GAL 01/SEP/2009 - RVVUNICA
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_toperacion) + '.' + rtrim(convert(varchar(2),@i_moneda)) + '.' + rtrim(@i_tipo_ente)
            if @w_abr_pais = 'PA'
               select @w_clave = rtrim(@i_toperacion) + '.' + rtrim(convert(varchar(2),@i_moneda)) 
         end                                             -- GAL 01/SEP/2009 - RVVUNICA

         ----------------------------------------------------------------------------------------------------
         -- Parametro, ACUM,  PCAP (ACUM e INT usados ahora como tipo deposito Global)
         ----------------------------------------------------------------------------------------------------
         if @w_tran in (14969, 14933, 14983) 
         begin                                           -- GAL 01/SEP/2009 - RVVUNICA
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_toperacion)  + '.' + rtrim(convert(varchar(2),@i_moneda)) + '.' + rtrim(@i_tipo_ente)      
            if @w_abr_pais = 'PA'
               select @w_clave = rtrim(@i_toperacion)  + '.' + rtrim(convert(varchar(2),@i_moneda))       
         end                                             -- GAL 01/SEP/2009 - RVVUNICA
         
         --------------------------------         
         --  Parametro FPAG, FPAZ ..... 
         --------------------------------
         if @w_tran = 14934
         begin                                           -- GAL 01/SEP/2009 - RVVUNICA
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_forma_pago) + '.' + rtrim(convert(varchar(2),@i_moneda)) + '.' + rtrim(@i_tipo_ente)
            if @w_abr_pais = 'PA'
               select @w_clave = rtrim(@i_forma_pago) 
         end                                             -- GAL 01/SEP/2009 - RVVUNICA
            
         -----------------------------
         -- Parametro RETE, TRAN , ICA
         -----------------------------
         if @w_tran in (14941,14971)
         begin
            if @w_abr_pais = 'CO'
               select @w_clave =  rtrim(convert(varchar(2),@i_moneda)) + '.' + rtrim(@i_tipo_ente)
            if @w_abr_pais = 'PA'
               select @w_clave =  rtrim(convert(varchar(2),@i_moneda)) 

            select @o_area = 100
         end
         

         ------------------------------------
         -- Nuevo parametro de Global CAJERO
         ------------------------------------
         if @w_tran = 14985
         begin
            select @w_parametro_efectivo = pa_char
            from cobis..cl_parametro
            where pa_producto = 'PFI'
            and   pa_nemonico = 'NEFE'
 
            if @w_param1 = @w_parametro_efectivo   
            begin                                        -- GAL 01/SEP/2009 - RVVUNICA
               if @w_abr_pais = 'CO'
                  select @w_clave = rtrim(@s_user)
               if @w_abr_pais = 'PA'
                  select @w_clave = rtrim(@s_user)
            end                                          -- GAL 01/SEP/2009 - RVVUNICA
            else 
            begin                                        -- GAL 01/SEP/2009 - RVVUNICA
               if @w_abr_pais = 'CO'
                  select @w_clave = ''
               if @w_abr_pais = 'PA'
                  select @w_clave = ''
            end                                          -- GAL 01/SEP/2009 - RVVUNICA
         end 
         
         --------------------------------------------------------
         -- Parametro para armar en base a tipo de operacion PLZ
         --------------------------------------------------------
         if @w_tran = 14932
         begin                                           -- GAL 01/SEP/2009 - RVVUNICA
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_toperacion)  + '.' + rtrim(convert(varchar(2),@i_moneda)) + '.' + rtrim(@i_tipo_ente)
            if @w_abr_pais = 'PA'
               select @w_clave = rtrim(@i_toperacion)  + '.' + rtrim(convert(varchar(2),@i_moneda))
         end                                             -- GAL 01/SEP/2009 - RVVUNICA
         --------------------------------------------   
         -- Parametro para armar tipo de cliente TCL
         --------------------------------------------
         if @w_tran = 14970
            select @w_clave = rtrim(@i_tipo_persona)
             
          --------------------------------------------------------
         -- Parametro para armar en base a tipo de banca TBC
         --------------------------------------------------------
         if @w_tran = 14972
            select @w_clave = rtrim(@i_tipo_banca)
        
         -----------------------------
         -- Parametro (MONP) Moneda 
         -----------------------------
         if @w_tran = 14973
         begin
            select @w_clave =  rtrim(convert(varchar(3),@i_moneda)) 
            select @o_area = 100                                    
         end

         --NYM PF00013 IEECOLBM
         -------------------------------------------------
         -- Parametro (IEE) Impuesto Emergencia Economica
         -------------------------------------------------
         if @w_tran = 14998  
         begin
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_forma_pago) + '.' +  rtrim(convert(varchar(2),@i_moneda))  + '.' +  rtrim(@i_tipo_ente) 
            if @w_abr_pais = 'PA'
               select @w_clave = rtrim(@i_forma_pago) + '.' +  rtrim(convert(varchar(2),@i_moneda))   
         end
         
         --NYM PF00014 ENAJENACION
         -------------------------------------------------
         -- ENAJENACION, ICA, RETE
         -------------------------------------------------
   
         if @w_tran = 14168  
         begin
            if @w_abr_pais = 'CO'
               select @w_clave = rtrim(@i_toperacion) + '.' + rtrim(convert(varchar(2),@i_moneda)) + '.' +  rtrim(@i_tipo_ente)
         end

         --print 'CONSCTAP 2 @w_tran %1! , @w_clave %2! ',@w_tran, @w_clave 

         /* AQUI SE DEBERA ANIADIR OTRO PARAMETRO EN CASO DE QUE HUBIERE */
         /****************************************************************/

         if @w_clave is null 
         begin 
            if @w_paso = 0 return 141082  
         end
         else 
         begin 
            select @w_cont = @w_cont + 1
            if @w_cont = 1 select @w_param1 = @w_clave
            else
               if @w_cont = 2 select @w_param2 = @w_clave
               else
                  if @w_cont = 3 select @w_param3 = @w_clave
                  else
                     if @w_cont = 4 select @w_param4 = @w_clave
                     else
                        if @w_cont = 5 select @w_param5 = @w_clave
                        else 
                           if @w_cont = 6 select @w_param6 = @w_clave
                           else
                              if @w_cont = 7 select @w_param7 = @w_clave
                              else
                                 if @w_cont = 8 select @w_param8 = @w_clave
                                 else
                                    if @w_cont = 9 select @w_param9 = @w_clave
                                    else
                                       if @w_cont = 10 select @w_param10 = @w_clave
         
         end
      end   -- if ascii(@w_paramt) <= 47 or ascii(@w_paramt) >= 58
   end      -- While
   select @o_param1 = @w_param1, @o_param2  = @w_param2,
          @o_param3 = @w_param3, @o_param4  = @w_param4,
          @o_param5 = @w_param5, @o_param6  = @w_param6,
          @o_param7 = @w_param5, @o_param8  = @w_param8,
          @o_param9 = @w_param9, @o_param10 = @w_param10
end
return 0

go
