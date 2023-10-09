/************************************************************************/
/*      Archivo:                cambest.sp                              */ 
/*      Stored procedure:       sp_cambios_estado                       */ 
/*      Base de datos:          cob_custodia                            */
/*      Producto:               garantias                               */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Abril-1997                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa realiza los cambios de estado de una garantia     */
/*      ya sean estos automaticos o manuales. Generando las respecti-   */
/*      transacciones contables.                                        */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      Mayo-1998       Laura Alvarado  Emision Inicial                 */      
/*      Dic-09-98       N.Velasco       Fecha de Constitucion de la Gtia*/
/*      Oct-22-99       X.Vega          Personalizacion                 */
/*      Feb-06-01       Zulma Reyes  ZR GAP: CD00064 TEQUENDAMA         */
/*      Nov-01-05      Martha Gil V.    Validar estado F en garantias   */
/*                                      diferente de Hipotecas y Prendas*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cambios_estado')
    drop proc sp_cambios_estado
go
create proc sp_cambios_estado (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_ofi                smallint    = null,
   @t_trn                smallint    = null,
   @i_operacion          char(1)     = null,
   @i_estado_ini         char(1)     = null,  
   @i_estado_fin         char(1)     = null,
   @i_codigo_externo     varchar(64) = null,
   @i_descripcion        varchar(64) = null,
   @i_banderafe          char(1)     = null,
   @i_tipo_tran          catalogo    = null,
   @i_tramite            int         = null,
   @i_reconoci           char(1)     = null,
   @i_viene_modvalor     char(1)     = null,
   @i_banderabe          char(1)     = null,
   @i_web                char(1)     = null
)
as
declare
   @w_today                datetime,
   @w_retorno              int,          
   @w_sp_name              varchar(32),  
   @w_perfil               catalogo,     
   @w_contabiliza          char(1),      
   @w_tran                 catalogo,
   @w_error                int,
   @w_var1                 varchar(60),
   @w_sector               char(1),
   @w_debcred              char(1),
   @w_riesgos              char(1),
   @w_descripcion          varchar(64),
   @w_contabilizar         char(1),
   @w_filial               tinyint,
   @w_sucursal             smallint,
   @w_secuencial           int,
   @w_secuenciald          int,
   @w_tsuperior            varchar(64),
   @w_tipo                 varchar(64),
   @w_custodia             int,
   @w_valor_actual         money,
   @w_valor_fut            money,
   @w_valor_hip            money,
   @w_valor_com            money,
   @w_valor_con            money,
   @w_valor_ajfut          money,
   @w_valor_ajvig          money,
   @w_acum_ajuste          money,
   @w_codvalor_ini         int,
   @w_codvalor_fin         int,
   @w_valor_compartida     money,
   @w_valor                money,
   @w_hora                 varchar(8),
   @w_cancelacion          char(1),
   @w_abierta_cerrada      char(1),
   @w_codvalor             int,
   @w_monetaria            char(1),
   @w_salida               char(1),
   @w_moneda               tinyint,
   @w_pargar               varchar(20),
   @w_valor_respaldo       money,
   @w_clase_cartera        catalogo,
   @w_calificacion         char(1),
   @w_valor_contab         money,
   @w_secuencial_rev       int,
   @w_codigo_externo_rev   varchar(64),
   @w_op_operacion         int,
   @w_op_moneda            int,
   @w_op_fecha_ult_proceso datetime,
   @w_saldo_oper           money,
   @w_estado               int,
   @w_estado_gar           char(1),
   @w_return               int,
   @w_num_dec              int,
   @w_monto_tram           money,
   @w_moneda_local         smallint,
   @w_saldo_operacion      money,
   @w_cot_mn               money ,
   @w_tipo_tramite         char(1),
   @w_estado_final         char(1),
   @w_perfil1              catalogo,
   @w_esp                  char(1),
   @w_fag                  catalogo,
   @w_sec_ini              int,           
   @w_sec_fin              int,
   @w_tipo_hip             varchar(30),    
   @w_tipo_pre             varchar(30),     
   @w_msg                  varchar(50),     -- JAR REQ 266
   @w_tipo_c               char(1),          -- JAR REQ 266
   @w_commit               char(1)
select 
@w_sp_name = 'sp_cambios_estado',
@w_today   = convert(varchar(10),@s_date,101),
@w_hora    = convert(varchar(8),getdate(),108),
@w_error   = 0

select @s_date = convert(varchar(10),fp_fecha, 101)
from   cobis..ba_fecha_proceso

if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end

if @i_operacion = 'I' begin

   select @w_estado_gar = cu_estado
   from   cu_custodia
   where  cu_codigo_externo = @i_codigo_externo

   if @w_estado_gar = @i_estado_fin
      return 0

   --*-- INI JAR REQ 266 --*--
   select @w_tipo_c = ce_tipo
   from cu_cambios_estado
   where ce_estado_ini = @w_estado_gar
   and   ce_estado_fin = @i_estado_fin

   if @w_tipo_c in ('M', 'A')
   begin   
      if @i_banderafe is null and (
         (@w_estado_gar = 'F' and @i_estado_fin = 'V') or
         (@w_estado_gar = 'V' and @i_estado_fin = 'F') or
         (@w_estado_gar = 'X' and @i_estado_fin = 'V') or
         (@w_estado_gar = 'V' and @i_estado_fin = 'X') or
         (@w_tipo_c     = 'A'))
      begin
         select @w_salida = 'N', @w_msg = 'El cambio de estado es automatico, no se permite desde Garantias'
         select @w_salida
         
         if @w_estado_gar = 'C' and exists (select 1 from cob_credito..cr_gar_propuesta with (nolock), cob_credito..cr_tramite with (nolock),
                                                          cob_cartera..ca_operacion with (nolock)
                                             where gp_garantia    = @i_codigo_externo
                                               and gp_tramite     = op_tramite
                                               and gp_tramite     = tr_tramite
                                               and tr_tramite     = op_tramite
                                               and tr_estado     <> 'Z'
                                               and op_estado not in (3,6))
         begin
            select @w_msg = 'Cliente tiene créditos vigentes, deben cancelarse primero'
            select @w_error = 1912123
            goto ERROR
            --*-- FIN JAR REQ 266 --*--
         end
      end

      update    cob_credito..cr_gar_propuesta
      set       gp_est_garantia         = @i_estado_fin
      where     gp_garantia             = @i_codigo_externo

      update    cu_custodia 
      set       cu_fecha_modif          = @s_date,
                cu_fecha_modificacion   = @s_date,
                cu_estado               = @i_estado_fin
      where     cu_codigo_externo       = @i_codigo_externo
      
      -- Crear transaccion para Contabilizar

          exec @w_error = cob_custodia..sp_transaccion
          @s_date           = @s_date,
          @s_user           = @s_user,
          @s_term           = @s_term,
          @i_codigo_externo = @i_codigo_externo,
          @i_estado_fin     = @i_estado_fin,
          @i_estado_gar     = @w_estado_gar,
          @i_tipo_tran      = 'EST',
          @i_banderabe      = @i_banderabe
 
          if @w_error <> 0 begin
             select @w_msg =  'Error en creacion de transaccion contable'
		     if @i_web <> 'S'
		     begin
		           select    @w_error = 1910001
		     end
		  
		     goto ERROR
          end

   end
   else
   begin
      select @w_msg =  'El cambio de estado no esta parametrizado'
      select    @w_error = 1912122
      goto ERROR
   end
end   
if @w_commit = 'S' begin
   commit tran
   select @w_commit = 'N'
end
return 0

ERROR:
if @i_web <> 'S'
    print @w_msg

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end
if @i_banderabe = 'S'
   return @w_error
else
begin
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = @w_error
   return @w_error
end

go