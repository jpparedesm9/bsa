/************************************************************************/
/*	Archivo: 	        maegar.sp                               */
/*	Stored procedure:       sp_maegar                               */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           jennifer Velandia            	      	*/
/*			                                         	*/
/*	Fecha de escritura:     Diciembre-2002  			*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa genera tabla  de maestro de garantias		*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	01/JUN/2005	PABLO GAIBOR	PARALELISMO			*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_maegar')
   drop proc sp_maegar
go

create procedure sp_maegar(
   @i_fecha        datetime,
   @i_proceso      int 		= null,
   @i_modo         tinyint
)
as
declare
@w_sp_name            	varchar(32),
@w_error             	int,
@w_polizas           	tinyint,
@w_notaria           	descripcion,
@w_escritura         	descripcion,
@w_cerlib            	descripcion,
@w_matricula         	descripcion,
@w_avaluo            	descripcion,
@w_valcons           	descripcion,
@w_valterreno        	descripcion,
@w_valinv            	descripcion,
@w_fampli            	descripcion,
@w_en_nomlar         	varchar(100),
@w_tipo	             	descripcion,
@w_custodia	     	int,
@w_estado	     	catalogo,
@w_desc_estado       	varchar(20),
@w_fecha_ingreso	datetime,
@w_valor_inicial	float,
@w_valor_actual		float,
@w_moneda		tinyint,
@w_instruccion		varchar(100),
@w_descripcion		varchar(100),
@w_motivo_noinsp        catalogo,
@w_inspeccionar         char(1),
@w_fuente_valor		catalogo,
@w_almacenera		smallint,
@w_direccion_prenda	varchar(100),
@w_ciudad_prenda	int     ,
@w_telefono_prenda	varchar(20),
@w_fecha_modif		datetime,
@w_fecha_const		datetime,
@w_periodicidad         catalogo,
@w_desc_periodicidad    varchar(20),
@w_nro_inspecciones	tinyint,
@w_usuario_crea         descripcion,
@w_usuario_modifica     descripcion,
@w_codigo_externo       varchar(64),
@w_fecha_avaluo           datetime,
@w_abierta_cerrada      char(1),
@w_clase_custodia       char(1),
@w_oficina              smallint,
@w_oficina_contabiliza  smallint,
@w_compartida           char(1),
@w_valor_compartida     money,
@w_num_acciones		int,
@w_valor_accion		money,
@w_porcentaje_comp      float,
@w_ubicacion		catalogo,
@w_desc_ubicacion       varchar(20),
@w_estado_credito	catalogo,
@w_desc_estado_credito  varchar(20),
@w_cuantia		char(1),
@w_vlr_cuantia		money,
@w_clase_cartera        char(1),
@w_fecha_vencimiento    datetime,
@w_porcentaje_cobertura float,
@w_entidad_emisora      int,
@w_fuente_valor_accion  catalogo,
@w_fecha_accion         datetime,
@w_grado_gar		catalogo,
@w_desc_grado_gar       varchar(20),
@w_provisiona		char(1),
@w_disponible           float,
@w_siniestro            char(1),
@w_castigo              char(1),
@w_agotada              char(1),
@wpo_aseguradora        varchar(20),
@wpo_fendozo_fin        datetime,
@w_fecha_reg            datetime,
@w_po_aseguradora       varchar(20),
@w_po_fendozo_fin       datetime,
@w_num_dcto             varchar(13),
@wma_principal         	varchar(100),
@w_tipo_g               smallint,
@w_noins                smallint,
@w_ubica                smallint,
@mcu_motivo_noinsp      descripcion,
@wmcg_tipo_garante      catalogo,
@mcg_tipo_garante       descripcion,
@w_encedruc             varchar(30),
@w_ennomlar             varchar(100),
@w_encasilladef         varchar(24),
@w_enbanca              catalogo,
@w_desc_enbanca         varchar(20),
@w_gp_tramite           int,
@wop_operacion          int,
@wop_banco              cuenta,
@wop_fecha_liq          datetime,
@wop_fecha_fin          datetime,
@w_saldo                  money,
@w_nomnotaria           varchar(30),
@w_nomescritura         varchar(30),
@w_nommatricula         varchar(30),
@w_num_anterior         varchar(30),
@w_nomvalcons           varchar(30),
@w_nomvalterreno        varchar(30),
@w_nomvalinv            varchar(30),
@w_nomcerlib            varchar(30),
@w_nomfampli            varchar(30),
@w_estadocon            char(1),
@w_max_fecha            datetime,
@w_tr_estado            char(1),
@w_fecha_sol_exp        datetime,
@w_fecha_sol_ren        datetime,
@w_fecha_sol_rec        datetime,
@w_minfecha_reg         datetime,
@w_dg_ubicagar          catalogo,
@w_mon_ubica            descripcion,
@w_seguro               char(1),
@w_aseguradora          varchar(20),
@w_fendozo_fin          datetime,
@w_max_fendozo          datetime,
@w_acciones             char(2),
@w_accio                varchar(64),
@w_tramites             tinyint,
@w_entidad              char(1),
@w_val_avajud           money,
@w_subtipo_mo           catalogo,
@w_desmerob            	descripcion,
@w_codigo               catalogo,
@w_ente                 int,
@w_objetivo             catalogo,
@w_finstr               descripcion,
@w_nomfinstr            varchar(30),
@w_cr_estado_garantia   smallint,
@w_cu_grado_gtia        smallint,
@w_cu_motivo_noinspeccion smallint,
@w_cu_est_custodia      smallint,
@w_cu_tipo_garante 	smallint,
@w_cu_ubicacion_doc     smallint,
@w_op_moneda            tinyint,
@w_num_dec		int,
@w_calificacion         char(1),
@w_nro_particiones	tinyint,
@w_num_regs             int,
@w_particion            int,
@w_proceso              tinyint,
@w_op_banco_desde       cuenta,
@w_op_banco_hasta       cuenta,
@w_regional 		smallint

select @w_sp_name = 'sp_maegar'

/* Dividir Tabla en grupo de "N" registros para procesos en paralelo */
/*********************************************************************/
if @i_modo = 0
begin
   SELECT @w_nro_particiones = pa_int
     FROM cobis..cl_parametro
    WHERE pa_producto	     = 'CRE'
      and pa_nemonico	     = 'PART' -- PROCESOS PARALELISMO
   set transaction isolation level READ UNCOMMITTED

   if @w_nro_particiones is null
   BEGIN
       exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 2101084,
            @i_msg   = 'Parametro PART No Definido'
       return 2101084
    END

   SELECT @w_num_regs   = count(1)
   FROM   cob_custodia..cu_custodia

   if @@rowcount = 0
   BEGIN
       exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 2101005,
            @i_msg   = 'No existen datos en cr_tmp_datooper'
       return 2101005
    END


   DELETE cob_credito..cr_procesos_paralelo
   WHERE  pr_programa = @w_sp_name

   if @@error <> 0
   BEGIN
       exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 2107001
       return 2107001
   END

   SELECT @w_proceso        = 1,
          @w_op_banco_desde = '0',
          @w_particion   = round(@w_num_regs / @w_nro_particiones, 0) + 5

   set rowcount @w_particion

   WHILE @w_proceso <= @w_nro_particiones
     and @w_num_regs > 0               -- Verificar existan registros a procesar
   BEGIN

      select @w_op_banco_hasta = cu_codigo_externo
      from   cob_custodia..cu_custodia
      where  cu_codigo_externo > @w_op_banco_desde
      order by cu_codigo_externo

      if @@rowcount > 0
      BEGIN
         INSERT INTO cob_credito..cr_procesos_paralelo
                (pr_programa, pr_proceso, pr_estado, pr_char_desde,     pr_char_hasta,     pr_inicio)
         VALUES (@w_sp_name,  @w_proceso, 'C',       @w_op_banco_desde, @w_op_banco_hasta, getdate())

         if @@error <> 0
         BEGIN
             exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 2103001
            return 2103001
         END
      END

      SELECT @w_proceso        = @w_proceso + 1,
             @w_op_banco_desde = @w_op_banco_hasta

   END -- WHILE

   set rowcount 0
end
else
begin

UPDATE 	cob_credito..cr_procesos_paralelo
SET 	pr_estado 	= 'P',
	pr_fin    	= getdate()
WHERE  	pr_programa 	= @w_sp_name
and  	pr_proceso  	= @i_proceso

select 	@w_cu_ubicacion_doc 	= codigo
from 	cobis..cl_tabla
where	tabla 		    	= 'cu_ubicacion_doc'
set transaction isolation level read uncommitted

select 	@w_cr_estado_garantia 	= codigo
from 	cobis..cl_tabla
where 	tabla			= 'cr_estado_garantia'
set transaction isolation level read uncommitted

select 	@w_cu_grado_gtia 	= codigo
from 	cobis..cl_tabla
where 	tabla 			= 'cu_grado_gtia'
set transaction isolation level read uncommitted

select	@w_cu_motivo_noinspeccion = codigo
from 	cobis..cl_tabla
where 	tabla 			= 'cu_motivo_noinspeccion'
set transaction isolation level read uncommitted

select 	@w_cu_est_custodia 	= codigo
from 	cobis..cl_tabla
where 	tabla 			= 'cu_est_custodia'
set transaction isolation level read uncommitted

select 	@w_cu_tipo_garante 	= codigo
from 	cobis..cl_tabla
where 	tabla 			= 'cu_tipo_garante'
set transaction isolation level read uncommitted

select 	@w_notaria 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'NOTARI'
set transaction isolation level read uncommitted

select 	@w_escritura 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'ESCRI'
set transaction isolation level read uncommitted

select 	@w_cerlib 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'CERTRA'
set transaction isolation level read uncommitted

select 	@w_matricula 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'MAINM'
set transaction isolation level read uncommitted

select 	@w_valcons 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'VCONS'
set transaction isolation level read uncommitted

select 	@w_valterreno 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'VTERR'
set transaction isolation level read uncommitted

select 	@w_valinv 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'VINV'
set transaction isolation level read uncommitted

select 	@w_fampli 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'FAMP'
set transaction isolation level read uncommitted

select 	@w_finstr 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'FINSTR'
set transaction isolation level read uncommitted

select 	@w_accio 		= pa_char
from 	cobis..cl_parametro
where 	pa_producto 		= 'GAR'
and 	pa_nemonico 		= 'VCUACC'
set transaction isolation level read uncommitted



declare cursor_garantia cursor for
select
cu_tipo,		cu_custodia,		cu_estado,		isnull(cu_fecha_ingreso,cu_fecha_reg),
cu_valor_inicial,       cu_valor_actual,	cu_moneda,          	cu_instruccion,
cu_descripcion,         cu_motivo_noinsp, 	cu_inspeccionar,     	cu_fuente_valor,
cu_almacenera,		cu_direccion_prenda, 	cu_ciudad_prenda,       cu_telefono_prenda,
cu_fecha_modif,      	cu_fecha_const,        	cu_periodicidad,        cu_nro_inspecciones,
cu_usuario_crea,        cu_usuario_modifica,   	cu_codigo_externo,   	cu_fecha_insp,
cu_abierta_cerrada, 	cu_clase_custodia,  	cu_sucursal,           	cu_oficina_contabiliza,
cu_compartida,       	cu_valor_compartida,    cu_num_acciones,	cu_valor_accion,
cu_porcentaje_comp,     cu_ubicacion,		cu_estado_credito,   	cu_cuantia,
cu_vlr_cuantia,		'',                  	cu_fecha_vencimiento,   cu_porcentaje_cobertura,
cu_fecha_avaluo,     	cu_entidad_emisora,     cu_fuente_valor_accion, cu_fecha_accion,
cu_grado_gar,           cu_provisiona,		cu_acum_ajuste,      	cu_siniestro,
cu_castigo,    		cu_agotada,		cu_fecha_reg, 		cu_num_dcto,
cu_fecha_sol_exp,       cu_fecha_sol_ren,      	cu_fecha_sol_rec
from 	cu_custodia,
	cob_credito..cr_procesos_paralelo
where 	pr_proceso 		= @i_proceso
and  	cu_codigo_externo	>  pr_char_desde
and   	cu_codigo_externo	<= pr_char_hasta
and 	pr_programa 		= 'sp_maegar'
and 	pr_estado 		<> 'T'
order by cu_oficina
for read only

open cursor_garantia
fetch cursor_garantia into
@w_tipo,             	@w_custodia,    	@w_estado,		@w_fecha_ingreso,
@w_valor_inicial,       @w_valor_actual,	@w_moneda,          	@w_instruccion,
@w_descripcion,         @w_motivo_noinsp, 	@w_inspeccionar,     	@w_fuente_valor,
@w_almacenera,		@w_direccion_prenda, 	@w_ciudad_prenda,       @w_telefono_prenda,
@w_fecha_modif,      	@w_fecha_const,        	@w_periodicidad,      	@w_nro_inspecciones,
@w_usuario_crea,        @w_usuario_modifica,   	@w_codigo_externo,   	@w_fecha_avaluo,
@w_abierta_cerrada,     @w_clase_custodia,  	@w_oficina,             @w_oficina_contabiliza,
@w_compartida,       	@w_valor_compartida,    @w_num_acciones,	@w_valor_accion,
@w_porcentaje_comp,     @w_ubicacion,		@w_estado_credito,   	@w_cuantia,
@w_vlr_cuantia,		@w_clase_cartera,    	@w_fecha_vencimiento,   @w_porcentaje_cobertura,
@w_fecha_avaluo,     	@w_entidad_emisora,     @w_fuente_valor_accion, @w_fecha_accion,
@w_grado_gar,           @w_provisiona,		@w_disponible,       	@w_siniestro,
@w_castigo,    		@w_agotada,		@w_fecha_reg,           @w_num_dcto,
@w_fecha_sol_exp,       @w_fecha_sol_ren,	@w_fecha_sol_rec
while @@fetch_status = 0
begin
   if @@fetch_status = -1
   begin
      update 	cob_credito..cr_procesos_paralelo
      set	pr_estado 	= 'E',
               	pr_fin    	= getdate()
      where	pr_programa 	= @w_sp_name
      and	pr_proceso  	= @i_proceso

      insert into cu_maestro_error (err_garantia,err_fecha) values (@w_codigo_externo,@i_fecha)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1
      end
   end

   delete cu_item_custodia_tpm
   where  proceso = @i_proceso

   insert into cu_item_custodia_tpm
   select ic_valor_item,
	  it_item,
	  it_nombre,
	  ic_codigo_externo,
	  ic_tipo_cust,
	  @i_proceso
   from   cu_item_custodia,
	  cu_item
   where  ic_codigo_externo = @w_codigo_externo
   and    ic_item 	    = it_item
   and    it_tipo_custodia  = ic_tipo_cust

   select
   @w_nomnotaria      = null,
   @w_nomescritura    = null,
   @w_nomcerlib       = null,
   @w_nommatricula    = null,
   @w_num_anterior    = null,
   @w_nomvalcons      = null,
   @w_nomvalterreno   = null,
   @w_nomvalinv       = null,
   @w_nomfampli       = null,
   @w_nomfinstr       = null,
   @w_gp_tramite      = null,
   @mcu_motivo_noinsp = null,
   @mcg_tipo_garante  = null,
   @wop_operacion     = 0,
   @wop_banco         = null,
   @w_calificacion    = null,
   @wop_fecha_liq     = null,
   @wop_fecha_fin     = null,
   @w_saldo             = 0,
   @w_polizas         = 0,
   @w_po_aseguradora  = null,
   @w_po_fendozo_fin  = null,
   @wpo_aseguradora   = null,
   @wpo_fendozo_fin   = null,
   @w_po_aseguradora  = null,
   @w_po_fendozo_fin  = null,
   @wma_principal     = null,
   @mcu_motivo_noinsp = null,
   @wmcg_tipo_garante = null,
   @mcg_tipo_garante  = null,
   @w_encedruc        = null,
   @w_ennomlar        = null,
   @w_encasilladef    = null,
   @w_enbanca         = null,
   @w_estadocon       = null,
   @w_dg_ubicagar     = null,
   @w_mon_ubica       = null,
   @w_seguro          = 'N',
   @w_aseguradora     = null,
   @w_fendozo_fin     = null,
   @w_acciones        = 'N0',
   @w_tramites        = 0,
   @w_desc_estado     = null,
   @w_desc_periodicidad   = null,
   @w_desc_ubicacion      = null,
   @w_desc_estado_credito = null,
   @w_desc_grado_gar      = null,
   @w_desc_enbanca        = null,
   @w_val_avajud  	  = 0,
   @w_subtipo_mo 	  = null,
   @w_objetivo   	  = null,
   @w_entidad 		  = ' ',
   @w_val_avajud 	  = @w_valor_actual,
   @w_max_fendozo 	  = null,
   @w_fecha_avaluo 	  = null



   select	@w_fecha_avaluo = max(in_fecha_insp)
   from  	cob_custodia..cu_inspeccion
   where 	in_codigo_externo = @w_codigo_externo


   if @w_tipo = @w_accio
      select @w_acciones = 'SI'

   select 	@w_ente 		= cg_ente,
		@wma_principal    	= convert(varchar(20),cg_ente),
		@wmcg_tipo_garante 	= cg_tipo_garante
   from   	cu_cliente_garantia
   where  	cg_codigo_externo 	= @w_codigo_externo
   and    	cg_principal      	= 'D'
   and    	cg_tipo_garante  	in ('C','J')

   select 	@w_ennomlar       	= en_nomlar,
          	@w_encedruc       	= en_ced_ruc,
          	@w_encasilladef   	= en_casilla_def,
          	@w_enbanca        	= en_banca,
          	@w_ente           	= en_ente
   from		cobis..cl_ente
   where  	en_ente 		= @w_ente
   set transaction isolation level read uncommitted

   select  	@w_subtipo_mo 		= mo_subtipo_mo,
           	@w_objetivo   		= mo_mercado_objetivo
   from 	cobis..cl_mercado_objetivo_cliente
   where 	mo_ente 		= @w_ente
   set transaction isolation level read uncommitted

   select 	@w_desmerob 	= b.valor
   from 	cobis..cl_tabla a,
		cobis..cl_catalogo b
   where 	a.tabla 	= 'cl_mercado_objetivo'
   and 		a.codigo	= b.tabla
   and 		b.codigo 	= @w_objetivo
   set transaction isolation level read uncommitted

   select	@w_max_fendozo 		=  max(isnull(po_fecha_endozo,'01/01/1800'))
   from 	cu_poliza
   where 	po_codigo_externo   	= @w_codigo_externo
   and 		po_estado_poliza 	= 'VIG'

   if  @w_max_fendozo <> '01/01/1800'
   begin
      select 	@w_seguro 	= 'S'
      select 	@w_aseguradora 	= po_aseguradora,
             	@w_fendozo_fin 	= po_fvigencia_fin
      from 	cu_poliza
      where 	po_codigo_externo   = @w_codigo_externo
      and 	po_estado_poliza    = 'VIG'
      and 	po_fecha_endozo     = @w_max_fendozo
   end

   select 	@w_desc_periodicidad 	= td_descripcion
   from   	cob_cartera..ca_tdividendo
   where  	td_tdividendo 		= @w_periodicidad

   select 	@w_desc_ubicacion 	= valor
   from 	cobis..cl_catalogo
   where 	tabla 	= @w_cu_ubicacion_doc
   and   	codigo 	= @w_ubicacion
   set transaction isolation level read uncommitted

   select 	@w_desc_estado_credito 	= valor
   from 	cobis..cl_catalogo
   where 	tabla 	= @w_cr_estado_garantia
   and   	codigo 	= @w_estado_credito
   set transaction isolation level read uncommitted

   select 	@w_desc_grado_gar = valor
   from 	cobis..cl_catalogo
   where 	tabla 	= @w_cu_grado_gtia
   and   	codigo 	= @w_grado_gar
   set transaction isolation level read uncommitted

   if @w_inspeccionar = 'N'
   begin
      select 	@mcu_motivo_noinsp = valor
      from 	cobis..cl_catalogo
      where 	tabla 	= @w_cu_motivo_noinspeccion
      and   	codigo 	= @w_motivo_noinsp
      set transaction isolation level read uncommitted
   end

   select 	@w_desc_estado 	  = valor
   from 	cobis..cl_catalogo
   where 	tabla 	= @w_cu_est_custodia
   and   	codigo	= @w_estado
   set transaction isolation level read uncommitted

   select	@mcg_tipo_garante = valor
   from 	cobis..cl_catalogo
   where 	tabla 	= @w_cu_tipo_garante
   and   	codigo 	= @wmcg_tipo_garante
   set transaction isolation level read uncommitted

   select 	@w_nomnotaria 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_notaria
   and    	codigo_externo 	= @w_codigo_externo
   and 		proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select 	@w_nomescritura = valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 	  	= @w_escritura
   and    	codigo_externo  = @w_codigo_externo
   and	  	proceso		= @i_proceso
   set transaction isolation level read uncommitted

   select 	@w_nomcerlib 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_cerlib
   and    	codigo_externo 	= @w_codigo_externo
   and 		proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select   	@w_nommatricula = valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_matricula
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select 	@w_num_anterior = valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= 'NUMERO ANTERIOR'
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select  	@w_nomvalcons 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_valcons
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select  	@w_nomvalterreno = valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_valterreno
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select  	@w_nomvalinv 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_valinv
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select  	@w_nomfampli 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_fampli
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select  	@w_nomfinstr 	= valor_item
   from   	cu_item_custodia_tpm
   where  	nombre 		= @w_finstr
   and    	codigo_externo 	= @w_codigo_externo
   and    	proceso 	= @i_proceso
   set transaction isolation level read uncommitted

   select	@w_estadocon 	= tc_contabilizar
   from 	cu_tipo_custodia
   where 	tc_tipo  	= @w_tipo


   select 	@w_dg_ubicagar 	  = gc_dependencia,
   		@w_mon_ubica  	  = (select de_descripcion from cu_dependencias where de_codigo = cu_garantias_custodia.gc_dependencia)
   from 	cu_garantias_custodia
   where 	gc_codigo_externo = @w_codigo_externo

   select @w_regional = convert(smallint,codigo_sib)
   from   cob_credito..cr_corresp_sib
   where  tabla       = 'T21'
   and    codigo      = (select convert(varchar,of_regional)
                               from   cobis..cl_oficina
                               where  of_oficina = @w_oficina )

   if exists (  
   select  	1
   from 	cob_credito..cr_gar_propuesta,
		cob_credito..cr_tramite,
		cob_cartera..ca_operacion
   where  	gp_garantia 	= @w_codigo_externo
   and		tr_tramite	= gp_tramite
   and		tr_estado	<> 'Z'
   and		tr_tipo		in ('R','O','M')  --  Tipo de Tramite Normalizacion
   and		op_tramite	= tr_tramite
   and		gp_tramite      = op_tramite
   and		op_estado	<> 3
   )
   begin

   declare cursor_cartera cursor for
   select       gp_tramite,
                op_operacion,
                op_banco,
                op_fecha_fin,
                op_fecha_liq,
                op_clase
   from 	cob_credito..cr_gar_propuesta,
		cob_credito..cr_tramite,
		cob_cartera..ca_operacion
   where  	gp_garantia 	= @w_codigo_externo
   and		tr_tramite	= gp_tramite
   and		tr_estado	<> 'Z'
   and		tr_tipo		in ('R','O','M')  -- Tipo de Tramite Normalizacion
   and		op_tramite	= tr_tramite
   and		gp_tramite      = op_tramite
   and		op_estado	<> 3
   order by gp_garantia
   for read only
   open cursor_cartera
   fetch cursor_cartera into @w_gp_tramite,
		             @wop_operacion,
          	             @wop_banco,
          	             @wop_fecha_fin,
	  	             @wop_fecha_liq,
          	             @w_clase_cartera

   while @@fetch_status = 0
   begin
      if @@fetch_status = -1
      begin
         select @w_error = 1909001
         close cursor_cartera
         deallocate cursor_cartera
         goto ERROR
      end


      select 	@w_calificacion = co_calif_final
      from	cob_credito..cr_calificacion_op
      where  	co_producto 	= 7
      and       co_num_op_banco	=@wop_banco


      if @w_estado <> 'V'
         select @w_clase_cartera = null

      select @w_saldo	= @w_valor_inicial


      insert into cu_maestro
      (
      ma_tipo,			ma_custodia,			ma_estado,			ma_fecha_ingreso,
      ma_valor_inicial,       	ma_valor_actual,	        ma_moneda,           		ma_principal,
      ma_instruccion,      	ma_descripcion,         	ma_motivo_noinsp, 		ma_inspeccionar,
      ma_fuente_valor,        	ma_almacenera,			ma_direccion_prenda, 		ma_ciudad_prenda,
      ma_telefono_prenda,	ma_fecha_modif,      		ma_fecha_const,         	ma_periodicidad,
      ma_nro_inspecciones, 	ma_usuario_crea,        	ma_usuario_modifica,     	ma_codigo_externo,
      ma_fecha_insp,          	ma_abierta_cerrada, 	        ma_clase_custodia,  		ma_oficina,
      ma_oficina_contabiliza, 	ma_compartida,       		ma_valor_compartida,    	ma_num_acciones,
      ma_valor_accion,     	ma_porcentaje_comp,     	ma_ubicacion,			ma_estado_credito,
      ma_cuantia,             	ma_vlr_cuantia,			ma_clase_cartera,    		ma_fecha_vencimiento,
      ma_porcentaje_cobertura,	ma_fecha_avaluo,     		ma_entidad_emisora,     	ma_fuente_valor_accion,
      ma_fecha_accion,     	ma_grado_gar,           	ma_provisiona,			ma_disponible,
      ma_siniestro,           	ma_castigo,    			ma_agotada,         		ma_tipo_g,
      ma_ced_ruc,		ma_nomlar,           		ma_casilla_def,       		ma_mercado,
      ma_banca,			ma_gp_tramite,       		ma_banco,               	ma_fecha_liq,
      ma_fecha_fin,        	ma_saldo,               	ma_entidad,			ma_val_avajud,
      ma_contabiliza,		ma_notaria,          		ma_escritura,           	ma_certifilib,
      ma_matricula,       	ma_avaluo,              	ma_val_cons,			ma_val_terr,
      ma_valor_inv,           	ma_ubica_gar,		        ma_fecha_reg,        		ma_fecha_ampliacion,
      ma_seguro,              	ma_aseguradora,          	ma_fendozo_fin,      		ma_acciones,
      ma_fecha_accioncon,    	ma_num_dcto,  			ma_fecha_sol_exp,     		ma_fecha_sol_ren,
      ma_fecha_sol_rec,		ma_calificacion,		ma_regional)
      values(
      @w_tipo,             	@w_custodia,           			@w_desc_estado,				convert(varchar(10),@w_fecha_ingreso,101),
      @w_valor_inicial,      	@w_valor_actual,			@w_moneda,           			@wma_principal,
      @w_instruccion,      	@w_descripcion,         		@mcu_motivo_noinsp, 			@w_inspeccionar,
      @w_fuente_valor,     	@w_almacenera,         			@w_direccion_prenda, 			convert(varchar(20),@w_ciudad_prenda),
      @w_telefono_prenda,	convert(varchar(10),@w_fecha_modif,101),convert(varchar(10),@w_fecha_const,101),@w_desc_periodicidad,
      @w_nro_inspecciones, 	@w_usuario_crea,        		@w_usuario_modifica,     		@w_codigo_externo,
      convert(varchar(10),@w_fecha_avaluo,101),@w_abierta_cerrada, 	@w_clase_custodia,  			convert(varchar(20),@w_oficina),
      convert(varchar(20),@w_oficina_contabiliza),@w_compartida,       	@w_valor_compartida,    		@w_num_acciones,
      @w_valor_accion,     	@w_porcentaje_comp,     		@w_desc_ubicacion,			@w_desc_estado_credito,
      @w_cuantia,        	@w_vlr_cuantia,				@w_clase_cartera,    			convert(varchar(10),@w_fecha_vencimiento,101),
      @w_porcentaje_cobertura,	convert(varchar(10),@w_fecha_avaluo,101),@w_entidad_emisora,     		@w_fuente_valor_accion,
      convert(varchar(10),@w_fecha_accion,101),@w_desc_grado_gar,      	@w_provisiona,				@w_disponible,
      @w_siniestro,           	@w_castigo,    				@w_agotada,         			@mcg_tipo_garante,
      @w_encedruc,		@w_ennomlar,         			@w_encasilladef,      			@w_desmerob,
      @w_enbanca,		@w_gp_tramite,       			@wop_banco,            			convert(varchar(10),@wop_fecha_liq,101),
      convert(varchar(10),@wop_fecha_fin,101),@w_saldo,                 	@w_entidad,				@w_val_avajud,
      @w_estadocon,		@w_nomnotaria,       			@w_nomescritura,        		@w_nomcerlib,
      @w_nommatricula,     	@w_num_anterior,           		@w_nomvalcons,				@w_nomvalterreno,
      @w_nomvalinv,           	@w_mon_ubica,    			@w_nomfinstr,           		@w_nomfampli,
      @w_seguro, 		@w_aseguradora,      			convert(varchar(10),@w_fendozo_fin,101),@w_acciones,
      convert(varchar(10),@w_fecha_accion,101),@w_num_dcto,             convert(varchar(10),@w_fecha_sol_exp,101),convert(varchar(10),@w_fecha_sol_ren,101),
      convert(varchar(10),@w_fecha_sol_rec,101),@w_calificacion,	@w_regional)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
	 @t_from  = @w_sp_name,
	 @i_num   = 1903001
	 return 1
      end


   select                    @w_gp_tramite    = null,
		             @wop_operacion   = null,
          	             @wop_banco       = null,
          	             @wop_fecha_fin   = null,
	  	             @wop_fecha_liq   = null,
          	             @w_clase_cartera = null,
                             @w_calificacion  = null

   fetch cursor_cartera into @w_gp_tramite,
		             @wop_operacion,
          	             @wop_banco,
          	             @wop_fecha_fin,
	  	             @wop_fecha_liq,
          	             @w_clase_cartera
   end
   close cursor_cartera
   deallocate cursor_cartera
   end
   else
   begin     
      select 	@wop_operacion 	= null,
          	@wop_banco     	= null,
          	@wop_fecha_fin 	= null,
	  	@wop_fecha_liq 	= null,
          	@w_clase_cartera= null,
          	@w_calificacion = 'N',
		@w_gp_tramite	= null,
                @w_seguro 	= 'N'


      insert into cu_maestro
      (
      ma_tipo,			ma_custodia,			ma_estado,			ma_fecha_ingreso,
      ma_valor_inicial,       	ma_valor_actual,	        ma_moneda,           		ma_principal,
      ma_instruccion,      	ma_descripcion,         	ma_motivo_noinsp, 		ma_inspeccionar,
      ma_fuente_valor,        	ma_almacenera,			ma_direccion_prenda, 		ma_ciudad_prenda,
      ma_telefono_prenda,	ma_fecha_modif,      		ma_fecha_const,         	ma_periodicidad,
      ma_nro_inspecciones, 	ma_usuario_crea,        	ma_usuario_modifica,     	ma_codigo_externo,
      ma_fecha_insp,          	ma_abierta_cerrada, 	        ma_clase_custodia,  		ma_oficina,
      ma_oficina_contabiliza, 	ma_compartida,       		ma_valor_compartida,    	ma_num_acciones,
      ma_valor_accion,     	ma_porcentaje_comp,     	ma_ubicacion,			ma_estado_credito,
      ma_cuantia,             	ma_vlr_cuantia,			ma_clase_cartera,    		ma_fecha_vencimiento,
      ma_porcentaje_cobertura,	ma_fecha_avaluo,     		ma_entidad_emisora,     	ma_fuente_valor_accion,
      ma_fecha_accion,     	ma_grado_gar,           	ma_provisiona,			ma_disponible,
      ma_siniestro,           	ma_castigo,    			ma_agotada,         		ma_tipo_g,
      ma_ced_ruc,		ma_nomlar,           		ma_casilla_def,       		ma_mercado,
      ma_banca,			ma_gp_tramite,       		ma_banco,               	ma_fecha_liq,
      ma_fecha_fin,        	ma_saldo,               	ma_entidad,			ma_val_avajud,
      ma_contabiliza,		ma_notaria,          		ma_escritura,           	ma_certifilib,
      ma_matricula,       	ma_avaluo,              	ma_val_cons,			ma_val_terr,
      ma_valor_inv,           	ma_ubica_gar,		        ma_fecha_reg,        		ma_fecha_ampliacion,
      ma_seguro,              	ma_aseguradora,          	ma_fendozo_fin,      		ma_acciones,
      ma_fecha_accioncon,    	ma_num_dcto,  			ma_fecha_sol_exp,     		ma_fecha_sol_ren,
      ma_fecha_sol_rec,		ma_calificacion,                ma_regional)
      values(
      @w_tipo,             	@w_custodia,           			@w_desc_estado,				convert(varchar(10),@w_fecha_ingreso,101),
      @w_valor_inicial,      	@w_valor_actual,			@w_moneda,           			@wma_principal,
      @w_instruccion,      	@w_descripcion,         		@mcu_motivo_noinsp, 			@w_inspeccionar,
      @w_fuente_valor,     	@w_almacenera,         			@w_direccion_prenda, 			convert(varchar(20),@w_ciudad_prenda),
      @w_telefono_prenda,	convert(varchar(10),@w_fecha_modif,101),convert(varchar(10),@w_fecha_const,101),@w_desc_periodicidad,
      @w_nro_inspecciones, 	@w_usuario_crea,        		@w_usuario_modifica,     		@w_codigo_externo,
      convert(varchar(10),@w_fecha_avaluo,101),@w_abierta_cerrada, 	@w_clase_custodia,  			convert(varchar(20),@w_oficina),
      convert(varchar(20),@w_oficina_contabiliza),@w_compartida,       	@w_valor_compartida,    		@w_num_acciones,
      @w_valor_accion,     	@w_porcentaje_comp,     		@w_desc_ubicacion,			@w_desc_estado_credito,
      @w_cuantia,        	@w_vlr_cuantia,				@w_clase_cartera,    			convert(varchar(10),@w_fecha_vencimiento,101),
      @w_porcentaje_cobertura,	convert(varchar(10),@w_fecha_avaluo,101),@w_entidad_emisora,     		@w_fuente_valor_accion,
      convert(varchar(10),@w_fecha_accion,101),@w_desc_grado_gar,      	@w_provisiona,				@w_disponible,
      @w_siniestro,           	@w_castigo,    				@w_agotada,         			@mcg_tipo_garante,
      @w_encedruc,		@w_ennomlar,         			@w_encasilladef,      			@w_desmerob,
      @w_enbanca,		@w_gp_tramite,       			@wop_banco,            			convert(varchar(10),@wop_fecha_liq,101),
      convert(varchar(10),@wop_fecha_fin,101),@w_saldo,                 	@w_entidad,				@w_val_avajud,
      @w_estadocon,		@w_nomnotaria,       			@w_nomescritura,        		@w_nomcerlib,
      @w_nommatricula,     	@w_num_anterior,           		@w_nomvalcons,				@w_nomvalterreno,
      @w_nomvalinv,           	@w_mon_ubica,    			@w_nomfinstr,           		@w_nomfampli,
      @w_seguro, 		@w_aseguradora,      			convert(varchar(10),@w_fendozo_fin,101),@w_acciones,
      convert(varchar(10),@w_fecha_accion,101),@w_num_dcto,             convert(varchar(10),@w_fecha_sol_exp,101),convert(varchar(10),@w_fecha_sol_ren,101),
      convert(varchar(10),@w_fecha_sol_rec,101),@w_calificacion		,@w_regional)

      if @@error <> 0 
      begin
        /* Error en insercion de registro */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1903001
        return 1 
      end

       select 	@wop_banco      =  null,
	     	@wop_fecha_liq  =  null,
             	@w_seguro       = 'N',
             	@w_subtipo_mo 	= null,
             	@w_objetivo   	= null,
             	@w_gp_tramite 	= null,
             	@w_calificacion = null
   end      



fetch cursor_garantia into
@w_tipo,             	@w_custodia,    	@w_estado,		@w_fecha_ingreso,
@w_valor_inicial,       @w_valor_actual,	@w_moneda,          	@w_instruccion,
@w_descripcion,         @w_motivo_noinsp, 	@w_inspeccionar,     	@w_fuente_valor,
@w_almacenera,		@w_direccion_prenda, 	@w_ciudad_prenda,       @w_telefono_prenda,
@w_fecha_modif,      	@w_fecha_const,        	@w_periodicidad,      	@w_nro_inspecciones,
@w_usuario_crea,        @w_usuario_modifica,   	@w_codigo_externo,   	@w_fecha_avaluo,
@w_abierta_cerrada,     @w_clase_custodia,  	@w_oficina,             @w_oficina_contabiliza,
@w_compartida,       	@w_valor_compartida,    @w_num_acciones,	@w_valor_accion,
@w_porcentaje_comp,     @w_ubicacion,		@w_estado_credito,   	@w_cuantia,
@w_vlr_cuantia,		@w_clase_cartera,    	@w_fecha_vencimiento,   @w_porcentaje_cobertura,
@w_fecha_avaluo,     	@w_entidad_emisora,     @w_fuente_valor_accion, @w_fecha_accion,
@w_grado_gar,           @w_provisiona,		@w_disponible,       	@w_siniestro,
@w_castigo,    		@w_agotada,		@w_fecha_reg,           @w_num_dcto,
@w_fecha_sol_exp,       @w_fecha_sol_ren,	@w_fecha_sol_rec
end
close cursor_garantia
deallocate cursor_garantia

UPDATE 	cob_credito..cr_procesos_paralelo
SET 	pr_estado 	= 'T',
	pr_fin    	= getdate()
WHERE  	pr_programa 	= @w_sp_name
and  	pr_proceso  	= @i_proceso

end

return 0
ERROR:    /* RUTINA QUE DISPARA sp_cerror DADO EL CODIGO DEL ERROR */
exec cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error
return 1

                                                                                                                                                                                                                                          
                                                                                                                                      
                                                                      
go
