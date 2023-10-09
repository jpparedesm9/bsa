/************************************************************************/
/*      Archivo:                vigencia.sp                             */
/*      Stored procedure:       sp_vigencia                             */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               garantias                               */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Julio-2011                              */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                        PROPOSITO                                     */
/*      Este programa cambia de P a F las garantias.                    */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA            AUTOR            RAZON                         */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_vigencia')
    drop proc sp_vigencia
go
create proc sp_vigencia (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint  = null,
   @t_trn                smallint = null,
   @i_operacion          char(1)  = null,
   @i_estado_ini         char(1)  = null,
   @i_estado_fin         char(1)  = null,
   @i_codigo_externo     varchar(64) = null,
   @i_descripcion        varchar(64) = null
)
as

declare
   @w_today               datetime,
   @w_hora                varchar(8),
   @w_retorno             int,          /* valor que retorna           */
   @w_sp_name             varchar(32),  /* nombre stored proc          */
   @w_existe              tinyint,      /* existe el registro          */
   @w_perfil              catalogo,      /* perfil del cambio de estado */
   @w_contabiliza         char(1),      /* indica si se contabiliza    */
   @w_tran                catalogo,
   @w_error               int,
   @w_filial              tinyint,
   @w_sucursal            smallint,
   @w_contabilizar        char(1),
   @w_secuencial          int,
   @w_secuencial2         int,
   @w_secuenciald         int,
   @w_secuencial1         int,
   @w_tsuperior           varchar(64),
   @w_tipo                varchar(64),
   @w_custodia            int,
   @w_valor_actual        float,
   @w_codvalor            int,
   @w_valor_compartida    money,
   @w_valor               float,
   @w_oficina_contabiliza smallint,
   --@w_admisible         char(1),
   @w_clase_custodia      catalogo,
   @w_abierta_cerrada     char(1),
   @w_tipo_bien           char(1),
   @w_cuantia             char(1),
   @w_vlr_cuantia         money,
   @w_monetaria           char(1),
   @w_moneda              tinyint,
   @w_valor_respaldo      money,
   @w_clase_cartera       catalogo,
   @w_calificacion        char(1),
   @w_valor_contab        money,
   @w_codigo_externo_rev  varchar(24),
   @w_secuencial_rev      int,
   @w_valor_futuros       money,
   @w_sec_ini             int,
   @w_sec_fin             int

select @w_sp_name = 'sp_vigencia'
select @w_today = convert(varchar(10),@s_date,101)
select @w_hora = convert(varchar(8),getdate(),108)
select @w_codvalor = 0

/***********************************************************/
if @i_operacion = 'I'
begin
   if @i_estado_ini <> 'P'
   begin
      select @w_error = 1903013
      goto ERROR
   end
   select
   @w_filial = cu_filial,
   @w_sucursal = cu_sucursal,
   @w_tipo = cu_tipo,
   @w_custodia =cu_custodia,
   @w_valor_actual = isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0)),
   @w_valor_compartida = cu_valor_compartida,
   @w_oficina_contabiliza = cu_oficina_contabiliza,
   @w_abierta_cerrada     = cu_abierta_cerrada,
   @w_clase_custodia      = cu_clase_custodia,
   @w_cuantia             = cu_cuantia,
   @w_vlr_cuantia         = cu_vlr_cuantia,
   @w_moneda              = cu_moneda
   from cu_custodia
   where cu_codigo_externo = @i_codigo_externo
   
   if @@rowcount = 0
   begin
      select @w_error = 1905002
      goto ERROR
   end
   
   begin tran
   
   update cob_credito..cr_gar_propuesta
   set gp_est_garantia = @i_estado_fin
   where gp_garantia   = @i_codigo_externo
   if @@error <> 0
   begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905001
      return 1
   end

   update cu_custodia
   set cu_fecha_modif = @s_date,
       cu_estado      = @i_estado_fin
   where cu_codigo_externo = @i_codigo_externo

   if @@error <> 0
   begin
     /* Error en insercion de registro */
     exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1905001
     return 1
   end

   commit transaction
end
return 0

ERROR:
   if @w_error = 1 print "No se permite cambio de estado"
   else
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = @w_error
      return 1
   end
go


