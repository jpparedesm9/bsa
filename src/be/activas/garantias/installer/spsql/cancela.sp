/************************************************************************/
/* Archivo:                cancela.sp                                   */
/* Stored procedure:       sp_cancela                                   */
/* Base de datos:          cob_custodia                                 */
/* Producto:               garantias                                    */
/* Disenado por:           Rodrigo Garces                               */
/*                         Luis Alfredo Castellanos                     */
/* Fecha de escritura:     Junio-1995                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "MACOSA", representantes exclusivos para el Ecuador de la            */
/* "NCR CORPORATION".                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de MACOSA o su representante.                  */
/*                            PROPOSITO                                 */
/* Este programa realiza la cancelacion de Garantias                    */
/*                         MODIFICACIONES                               */
/* FECHA       AUTOR              RAZON                                 */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cancela')
    drop proc sp_cancela
go
create proc sp_cancela  (
@s_date                 datetime    = null,
@s_ofi                  smallint    = null,
@s_user                 login       = null,
@s_term                 varchar(64) = null,
@i_producto             char(64)    = null,
@i_modo                 smallint    = null,
@i_cliente              int         = null,
@i_ente                 int         = null,
@i_filial               tinyint     = null,
@i_sucursal             smallint    = null,
@i_tipo_cust            varchar(64) = null,
@i_custodia             int         = null,
@i_moneda               tinyint     = null,
@i_garante              int         = null,
@i_opcion               tinyint     = null,
@i_codigo_externo       varchar(64) = null,
@i_operacion            cuenta      = null,
@i_formato_fecha        int         = null,
@i_gasto_adm            smallint    = null,
@i_pasar                char(1)     = null,
@i_consulta             char(1)     = null,
@i_riesgos              char(1)     = null,
@i_login                varchar(30) = null,
@i_clave                varchar(30) = null,
@i_cancelacion_credito  char(1)     = null,
@i_num_banco            varchar(64) = null,
@i_cuenta               cuenta      = null,
@i_valor                money       = NULL,
@i_tasa                 float       = NULL,
@i_spread               float       = 0,
@i_descripcion          descripcion = NULL,
@i_observacion          descripcion = NULL,
@i_web                  char(1)     = NULL

)
as

declare
@w_today                   datetime,     /* fecha del dia */
@w_hora                    varchar(8),   /* fecha del dia */
@w_return                  int,          /* valor que retorna */
@w_retorno                 int,          /* valor que retorna */
@w_sp_name                 varchar(32),  /* nombre stored proc*/
@w_existe                  tinyint,      /* existe el registro*/
@w_error                   int,
@w_status                  int,
@w_contador                tinyint,
@w_riesgos                 char(1),
@w_contabiliza             char(1),
@w_abierta_cerrada         char(1),
@w_codigo_externo          varchar(64),
@w_des_est_custodia        varchar(64),
@w_des_abcerrada           varchar(64),
@w_estado                  catalogo,
@w_moneda                  tinyint,
@w_valor_actual            money,
@w_codvalor                int,
@w_valor_compartida        money,
@w_oficina                 smallint, --PGA 10may2001
@w_ente                    int,
@w_cliente                 descripcion,
@w_ofi_contabiliza         smallint,
@w_contabilizar            char(1),
@w_tsuperior               varchar(64),
@w_tipo                    varchar(64),
@w_secuencial              int,
@w_sector                  char(1),
@w_perfil                  catalogo,
@w_tran                    catalogo,
@w_valor                   money,
@w_acum_ajuste             money,
@w_oficina_contabiliza     smallint,
@w_clase_custodia          char(1),
@w_castigo                 char(1),
@w_avales                  varchar(30),
@w_valor_respaldo          money,
@w_clase_cartera           catalogo,
@w_calificacion            char(1),
@w_signo                   smallint,
@w_valor_contab            money,
@w_entra                   tinyint,
@w_valor_futuros           money,
@w_codigo_externo_rev      varchar(24),
@w_secuencial_rev          int,
@w_sec_ini                 int,
@w_sec_fin                 int,
@w_rowcount                int



select @w_today = convert(varchar(10),@s_date,101)
select @w_hora  = convert(varchar(8),getdate(),108)
select @w_sp_name = 'sp_cancela'

/***********************************************************/
/* Codigos de Transacciones                                */

if @i_operacion = 'S' and @i_cancelacion_credito is null
begin
   -- CODIGO EXTERNO
   
	
   if @i_codigo_externo is null
   begin
       exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                   @w_codigo_externo out
   end
   else
   begin
       select @w_codigo_externo = @i_codigo_externo
   end
   
   select
   @w_estado = cu_estado,
   @w_moneda = cu_moneda,
   @w_valor_actual = isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0)),
   @w_valor_compartida = cu_valor_compartida,
   @w_abierta_cerrada = cu_abierta_cerrada,
   @w_acum_ajuste = cu_acum_ajuste,
   @w_oficina = cu_oficina,
   @w_ente    = cg_ente,
   @w_cliente = cg_nombre,
   @w_ofi_contabiliza = cu_oficina_contabiliza,
   @w_clase_custodia = cu_clase_custodia,
   @w_castigo   = cu_castigo
   from cu_custodia,cu_cliente_garantia
   where cu_codigo_externo = @w_codigo_externo
   and   cu_codigo_externo = cg_codigo_externo
   and cg_principal = 'D'
   
   if (@i_web = 'S' and @@rowcount = 0)
   begin 
       select @w_error = 1912124
	   goto ERROR
   end
   
   
   if @i_consulta = 'S'
   begin
      exec @w_return = sp_tipo_custodia
      @i_tipo = @i_tipo_cust,
      @t_trn  = 19123,
      @i_operacion = 'V',
      @i_modo = 0

      if @w_return <> 0
      begin
         return 1
      end

      exec @w_return = sp_custopv
      @i_filial     = @i_filial,
      @i_sucursal   = @i_sucursal,
      @i_tipo       = @i_tipo_cust,
      @i_custodia   = @i_custodia,
      @t_trn        = 19565,
      @i_operacion  = 'B',
      @i_modo       = 0

      if @w_return <> 0
      begin
         return 1
      end

      if @w_abierta_cerrada = 'A'
         select @w_des_abcerrada = 'ABIERTA'
      else
         select @w_des_abcerrada = 'CERRADA'

      select @w_des_est_custodia = eg_descripcion
      from cu_estados_garantia
      where eg_estado = @w_estado

      select
      @w_estado,
      @w_des_est_custodia,
      @w_des_abcerrada,
      @w_valor_actual, --MVI 07/10/96 para los nuevos datos en frontend
      @w_moneda,
      @w_ente,
      @w_cliente
      
      select @w_riesgos = 'N'
      select @w_riesgos
      
   end  -- Fin de la Consulta
   else -- Se realiza la Cancelacion
   begin
      if @w_estado <> 'C'
      begin
         if @w_estado = 'P'  -- ESTADO PROPUESTO
         begin
            /* No se puede cancelar una garantia con un estado de Propuesta */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905007
            return 1
         end
         
         if exists (select * from cu_por_inspeccionar
                    where pi_codigo_externo = @w_codigo_externo)
               
            delete cu_por_inspeccionar
            where pi_codigo_externo = @w_codigo_externo
         
         delete cu_inspeccion
         where in_codigo_externo = @w_codigo_externo
         
         select @w_valor = @w_valor_actual
         
         begin tran
         
         exec @w_return = cob_custodia..sp_cambios_estado
         @s_user           = @s_user,
         @s_date           = @s_date,
         @s_term           = @s_term,
         @s_ofi            = @s_ofi,
         @i_operacion      = 'I',
         @i_tipo_tran      = 'EST',
         @i_estado_ini     = 'X',
         @i_estado_fin     = 'C',
         @i_codigo_externo = @w_codigo_externo,
		 @i_banderabe      = @i_web,
		 @i_web            = @i_web
         
         if @w_return <> 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_return
            return @w_return
         end
         
         commit tran
              
         select @w_estado = cu_estado
         from cu_custodia
         where cu_codigo_externo = @w_codigo_externo
                            
         select @w_des_est_custodia = A.valor
         from cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
           and B.tabla  = 'cu_est_custodia'
           and A.codigo = @w_estado
         set transaction isolation level read uncommitted
              
         select @w_estado, @w_des_est_custodia
      
      end  -- @w_estado <> 'C'
	  else if (@i_web = 'S' and @w_estado = 'C')
	  begin
	     select @w_error = 1905008
		 goto ERROR
	  end
   end  -- Cancelacion
end

return 0
ERROR:
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = @w_error
      return 1
go
