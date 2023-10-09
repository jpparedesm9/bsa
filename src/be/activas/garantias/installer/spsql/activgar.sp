/************************************************************************/
/*   Archivo:               activgar.sp                                 */ 
/*   Stored procedure:      sp_activar_garantia                         */ 
/*   Base de datos:         cob_custodia                                */
/*   Producto:              garantias                                   */
/*   Disenado por:          MVI                                         */
/*   Programado por:        XTA                                         */
/*   Fecha de escritura:    Agosto 1999                                 */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                      PROPOSITO                                       */
/*   Este programa se encargara  insertar en las tablas utilizadas      */
/*      para la contabilizacion                                         */
/*                  MODIFICACIONES                                      */
/*     18/AGO/1999   Xavier Tapia           Emision Inicial             */
/*     18/Feb/2000   Milena Gonzalez Adicion clase para contabilizacion */
/*     07/OCT/2002   Gonzalo Solanilla    Comentarios cob_comext banco  */
/*                 agrario                                              */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_activar_garantia')
    drop proc sp_activar_garantia
go
create proc sp_activar_garantia
(
   @s_date              datetime    = null,
   @s_user              login       = null,
   @s_ofi               smallint    = null,
   @s_term              login       = null,
   @t_debug             char(1)     = 'N',    
   @t_file              varchar(14) = null,
   @i_usuario           login       = null,
   @i_terminal          login       = null,
   @i_tramite           int         = null,
   @i_operacion         char(1)     = null,
   @i_filial            tinyint     = null,
   @i_sucursal          smallint    = null,
   @i_tipo_cust         varchar(64) = null,
   @i_custodia          int         = null,
   @i_modo              smallint    = null,
   @i_opcion            char(1)     = null,
   @i_codigo_externo    varchar(64) = null,
   @i_banderafe         char(1)     = 'S' ,
   @i_reconocimiento    char(1)     = null,
   @i_viene_modvalor    char(1)     = null,
   @i_bandera_be        char(1)     = null
)
as
declare
   @w_sp_name           varchar(32), 
   @w_error             int,
   @w_return            int,
   @w_filial            tinyint,
   @w_sucursal          smallint,
   @w_tramite           int,
   @w_abierta_cerrada   catalogo,
   @w_codigo_externo    varchar(64),
   @w_opcion            char(1),
   @w_agotada           char(1), 
   @w_estado            catalogo,
   @w_estado_gar        catalogo,
   @w_tipo              catalogo,
   @w_custodia          int,
   @w_nuevo_comercial   money,
   @w_clase             char(1), 
   @w_cu_agotada        char(1),
   @w_spid_si2          int,
   @w_bandera_ex        int,
   @w_operacionca       int,
   @w_saldo_cap_gar     money,
   @w_estado_fin        char(1),
   @w_cod_gar_fng       catalogo,
   @w_tran              catalogo,             -- PAQUETE 2: REQ 266 ANEXO GARANTIA - 14/JUL/2011 - GAL
   @w_ente              int,
   @w_grupo             int

select  @w_sp_name  = 'sp_activar_garantia'
select  @w_spid_si2     = @@spid * 100

delete  cu_tmp_operaciones 
where   to_sesion = @w_spid_si2

delete  cu_tmp_garantia 
where   tg_sesion = @w_spid_si2


select @w_cod_gar_fng = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'



if @i_tramite is not null
begin

   select  @w_operacionca  = op_operacion
   from    cob_cartera..ca_operacion
   where   op_tramite      = @i_tramite

   select @w_saldo_cap_gar = (sum(am_cuota + am_gracia - am_pagado))
   from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
   where  ro_operacion  = @w_operacionca
   and    ro_tipo_rubro = 'C'
   and    am_operacion  = @w_operacionca
   and    am_estado     <> 3
   and    am_concepto   = ro_concepto

   SELECT @w_saldo_cap_gar = ISNULL(@w_saldo_cap_gar,0)
    
   
   if @i_operacion = 'I'
   begin
      if exists(SELECT 1 
        FROM    cob_credito..cr_gar_propuesta,
                    cob_credito..cr_tramite,
                        cob_custodia..cu_custodia
                WHERE   gp_tramite      = @i_tramite
                and     tr_tramite      = gp_tramite
                and     gp_garantia     = cu_codigo_externo
                and     tr_tipo         in ('R','O', 'U', 'T')
                and     cu_estado   in('P','F','V','X'))  -- JAR REQ 266
      begin
         select @w_bandera_ex = 1
      end
      else
      begin
         return 0   
      end
         
      if @i_modo = 1
      begin
         if exists (select 1 from cob_credito..cr_gar_propuesta with (nolock), cob_custodia..cu_custodia with (nolock)
                     where gp_tramite  = @i_tramite
                       and gp_garantia = cu_codigo_externo
                       and cu_estado in ('P', 'C', 'E', 'Z'))
         begin
            -- Garantía no se encuentra constituida, por favor informar al área de garantías
            return 2101185  
         end
         declare cursor_garantia1 
         cursor  for 
         SELECT  gp_tramite,                       cu_estado,                cu_codigo_externo,
                 cu_abierta_cerrada,               cu_agotada
         FROM    cob_custodia..cu_custodia, 
                 cob_credito..cr_gar_propuesta,
                 cob_credito..cr_tramite
         WHERE   gp_tramite = @i_tramite
         and     gp_garantia    = cu_codigo_externo 
         and     cu_estado  in('P','F','V','X') -- JAR REQ 266
         and     tr_tramite     = gp_tramite
         and     tr_tipo    in ('R','O', 'U', 'T')
         for read only
         open cursor_garantia1
         
         fetch cursor_garantia1
         into  @w_tramite,      @w_estado_gar,  @w_codigo_externo,
               @w_abierta_cerrada,  @w_cu_agotada
        
         while @@fetch_status = 0
         begin
            if @i_opcion = 'L' and (@w_estado_gar ='F')
            begin
               -- INI - PAQUETE 2: REQ 266 - ANEXO GARANTIAS - 14/JUL/2011
               select @w_tran = null
               
               select @w_tran = ce_tran
               from cu_cambios_estado
               where ce_tipo       = 'A'
               and   ce_estado_ini = @w_estado_gar
               and   ce_estado_fin = 'V'
               
               if @w_tran is null
               begin
                  if @i_bandera_be = 'S'
                     return 1912116
                  else
                  begin
                     exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file, 
                     @t_from  = @w_sp_name,
                     @i_num   = 1912116
                     return 1
                  end
               end
               -- FIN - PAQUETE 2: REQ 266 - ANEXO GARANTIAS
            
               exec @w_return = cob_custodia..sp_cambios_estado
               @s_user             = @s_user,
               @s_date             = @s_date,
               @s_term             = @s_term,
               @s_ofi              = @s_ofi,
               @i_operacion        = 'I',
               @i_tipo_tran        = @w_tran,               -- PAQUETE 2: REQ 266 ANEXO GARANTIA - 14/JUL/2011 - GAL
               @i_estado_ini       = @w_estado_gar,
               @i_estado_fin       = 'V',
               @i_codigo_externo   = @w_codigo_externo,
               @i_banderafe        = 'S', 
               @i_banderabe        = @i_bandera_be
               
               if @w_return !=0 
               begin
                  close cursor_garantia1
                  deallocate cursor_garantia1
                  if @i_bandera_be = 'S'
                     return 1910002
                  else
                  begin
                     exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file, 
                     @t_from  = @w_sp_name,
                     @i_num   = 1910002
                     return 1910002
                  end
               end

               select   @w_clase    = op_clase
               from     cob_cartera..ca_operacion
               where    op_tramite  = @i_tramite
               
               update   cob_custodia..cu_custodia
               set      cu_clase_cartera    = @w_clase
               where    cu_codigo_externo   = @w_codigo_externo
            end
            else
            begin
               if @i_opcion = 'L' and @w_estado_gar = 'P'
               begin
                  close cursor_garantia1
                  deallocate cursor_garantia1
                  print  'Error, no se puede desembolsar una operacion con garantias propuestas'
                  return 710088  -- JAR REQ 266   
               end
            end
            
            if @i_opcion = 'R' and @w_estado_gar = 'V' 
            begin
               if exists(select 1 from  cob_credito..cr_tramite,  cob_credito..cr_gar_propuesta, 
                                        cob_cartera..ca_operacion
                         where  gp_tramite  = tr_tramite
                         and    op_tramite  = tr_tramite
                         and    op_estado   not in (99,0,5,6,3)
                         and    tr_tramite  <>@i_tramite
                         and    gp_garantia = @w_codigo_externo
                         and    tr_tipo     in ('R','O', 'U', 'T') )
               begin  
                  select   @w_bandera_ex = 1
               end 
               else
               begin
               
                  -- INI - PAQUETE 2: REQ 266 - ANEXO GARANTIAS - 14/JUL/2011
                  select @w_tran = null
                  
                  select @w_tran = ce_tran
                  from cu_cambios_estado
                  where ce_tipo       = 'A'
                  and   ce_estado_ini = @w_estado_gar
                  and   ce_estado_fin = 'F'
                  
                  if @w_tran is null
                  begin
                     if @i_bandera_be = 'S'
                        return 1912116
                     else
                     begin
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file, 
                        @t_from  = @w_sp_name,
                        @i_num   = 1912116
                        return 1
                     end
                  end
                  -- FIN - PAQUETE 2: REQ 266 - ANEXO GARANTIAS
               
                  exec @w_return = cob_custodia..sp_cambios_estado
                  @s_user           = @s_user,
                  @s_date           = @s_date,
                  @s_term           = @s_term,
                  @s_ofi            = @s_ofi,
                  @i_operacion      = 'I',
                  @i_tipo_tran      = @w_tran,               -- PAQUETE 2: REQ 266 ANEXO GARANTIA - 14/JUL/2011 - GAL
                  @i_estado_ini     = @w_estado_gar,
                  @i_estado_fin     = 'F',
                  @i_codigo_externo = @w_codigo_externo,
                  @i_banderafe      = 'S', 
                  @i_banderabe      = @i_bandera_be
               
                  if @w_return !=0 
                  begin
                     close cursor_garantia1
                     deallocate cursor_garantia1
                     if @i_bandera_be = 'S'
                        return 1910003
                     else
                     begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 1910003
                         return 1910003
                     end
                  end
               end
            end
            fetch cursor_garantia1
            into  @w_tramite,           @w_estado_gar,  @w_codigo_externo,
                  @w_abierta_cerrada,   @w_cu_agotada
         end  
         close cursor_garantia1
         deallocate cursor_garantia1
      end

      if @i_modo = 2   
      begin 
         declare cursor_garantia1 
         cursor  for 
         SELECT  gp_tramite,
                 cu_estado,
                 cu_codigo_externo,
                 cu_abierta_cerrada,          
                 cu_agotada
         FROM    cob_custodia..cu_custodia, 
                 cob_credito..cr_gar_propuesta,
                 cob_credito..cr_tramite
         WHERE   gp_tramite     = @i_tramite
         and     gp_garantia    = cu_codigo_externo 
         and     cu_estado      in('P','F','V','X','C') -- JAR REQ 266
         and     tr_tramite     = gp_tramite
         and     tr_tipo       in ('R','O', 'U', 'T')
         for read only
         open cursor_garantia1
         
         fetch cursor_garantia1
         into  @w_tramite,      @w_estado_gar,  @w_codigo_externo,
               @w_abierta_cerrada,  @w_cu_agotada
        
         while @@fetch_status = 0
         begin
            if @i_opcion in('P','C') and @w_saldo_cap_gar <> 0
            begin
               close cursor_garantia1
               deallocate cursor_garantia1
               return 0
            end
            
            if @i_opcion = 'D' and (@w_estado_gar ='X' or @w_estado_gar = 'F' or @w_estado_gar = 'C') -- JAR REQ 266
            begin
               -- INI - PAQUETE 2: REQ 266 - ANEXO GARANTIAS - 14/JUL/2011
               select @w_tran = null
               
               select @w_tran = ce_tran
               from cu_cambios_estado
               where ce_tipo       = 'A'
               and   ce_estado_ini = @w_estado_gar
               and   ce_estado_fin = 'V'
               
               if @w_tran is null
               begin
                  if @i_bandera_be = 'S'
                     return 1912116
                  else
                  begin
                     exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file, 
                     @t_from  = @w_sp_name,
                     @i_num   = 1912116
                     return 1
                  end
               end
               -- FIN - PAQUETE 2: REQ 266 - ANEXO GARANTIAS
            
               exec @w_return = cob_custodia..sp_cambios_estado
               @s_user           = @s_user,
               @s_date           = @s_date,
               @s_term           = @s_term,
               @s_ofi            = @s_ofi,
               @i_operacion      = 'I',
               @i_tipo_tran      = @w_tran,               -- PAQUETE 2: REQ 266 ANEXO GARANTIA - 14/JUL/2011 - GAL
               @i_estado_ini     = @w_estado_gar,
               @i_estado_fin     = 'V',
               @i_codigo_externo = @w_codigo_externo,
               @i_banderafe      = 'S', 
               @i_banderabe      = @i_bandera_be
               
               if @w_return !=0 
               begin
                  close cursor_garantia1
                  deallocate cursor_garantia1
                  if @i_bandera_be = 'S'
                     return 1910002
                  else
                  begin
                     exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file, 
                       @t_from  = @w_sp_name,
                       @i_num   = 1910002
                       return 1910002
                  end
               end
            
               select   @w_clase    = op_clase
               from     cob_cartera..ca_operacion
               where    op_tramite  = @i_tramite
               
               update   cob_custodia..cu_custodia
               set      cu_clase_cartera    = @w_clase
               where    cu_codigo_externo   = @w_codigo_externo
            end
            
            if @i_opcion in('P','C') and @w_estado_gar = 'V' 
            begin
               if exists(select 1 from   cob_credito..cr_tramite,
                         cob_credito..cr_gar_propuesta,
                         cob_cartera..ca_operacion
                         where  gp_tramite  = tr_tramite
                           and  op_tramite  = tr_tramite
                           and  op_estado   not in (99,0,5,6,3)
                           and  tr_tramite  <>@i_tramite
                           and  gp_garantia = @w_codigo_externo
                           and  tr_tipo         in('R','O', 'U', 'T') )
               begin  
                  select   @w_bandera_ex = 1
               end 
               else
               begin
                  if exists(select 1 from  cob_custodia..cu_custodia, cob_custodia..cu_tipo_custodia where cu_tipo = tc_tipo  and tc_tipo_superior = 'LIQ' and cu_codigo_externo = @w_codigo_externo)
                  begin
                     select   
                     @w_ente     = op_cliente,
                     @w_operacionca = op_operacion
                     from     cob_cartera..ca_operacion
                     where    op_tramite  = @i_tramite
                     
                     select 
                     @w_grupo = dc_grupo,
                     @w_tramite = ci_tramite
                     from cob_cartera..ca_ciclo,cob_cartera..ca_det_ciclo 
                     where ci_ciclo = dc_ciclo 
                     and ci_grupo = dc_grupo
                     and dc_operacion = @w_operacionca
                     and dc_cliente = @w_ente
                                                               
                     select @w_estado_fin  = 'C'
                     exec @w_return          = cob_custodia..sp_contabiliza_garantia
                          @s_date            = @s_date,
                          @s_user            = @s_user,
                          @s_ofi             = @s_ofi ,
                          @s_term            = @s_term,
                          @i_operacion       = 'PD',
                          @i_tramite         = @w_tramite,
                          @i_ente            = @w_ente,
                          @i_grupo           =@w_grupo
                          
                     if @w_return !=0  begin
   
						close cursor_garantia1
						deallocate cursor_garantia1
   
						if @i_bandera_be = 'S' 
						return 1901020
						else begin
                            exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file, 
                            @t_from  = @w_sp_name,
                            @i_num   = 1901020
                            return 1
                       end	
                   end 
                  end
                  else
                  begin
                     select @w_estado_fin  = 'X'
                  end

                  -- INI - PAQUETE 2: REQ 266 - ANEXO GARANTIAS - 14/JUL/2011 - GAL
                  select @w_tran = null
                  
                  select @w_tran = ce_tran
                  from cu_cambios_estado
                  where ce_tipo       = 'A'
                  and   ce_estado_ini = @w_estado_gar
                  and   ce_estado_fin = @w_estado_fin
                  
                  if @w_tran is null
                  BEGIN
                  	close cursor_garantia1
                    deallocate cursor_garantia1
                     if @i_bandera_be = 'S'
                        return 1912116
                     else
                     begin
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file, 
                        @t_from  = @w_sp_name,
                        @i_num   = 1912116
                        return 1
                     end
                  end
                  -- FIN - PAQUETE 2: REQ 266 - ANEXO GARANTIAS
               
                  exec @w_return = cob_custodia..sp_cambios_estado
                  @s_user           = @s_user,
                  @s_date           = @s_date,
                  @s_term           = @s_term,
                  @s_ofi            = @s_ofi,
                  @i_operacion      = 'I',
                  @i_tipo_tran      = @w_tran,               -- PAQUETE 2: REQ 266 ANEXO GARANTIA - 14/JUL/2011 - GAL
                  @i_estado_ini     = @w_estado_gar,
                  @i_estado_fin     = @w_estado_fin,
                  @i_codigo_externo = @w_codigo_externo,
                  @i_banderafe      = 'S', 
                  @i_banderabe      = @i_bandera_be
                  
                  if @w_return !=0 
                  begin
                     close cursor_garantia1
                     deallocate cursor_garantia1
                     if @i_bandera_be = 'S'
                        return 1910003
                     else
                     begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 1910003
                         return 1910003
                     end
                  end
               end
            end
            fetch cursor_garantia1
            into  @w_tramite,       @w_estado_gar,  @w_codigo_externo,
                     @w_abierta_cerrada,   @w_cu_agotada
         end 
      close cursor_garantia1
      deallocate cursor_garantia1
      end
   end  
end

return 0
go