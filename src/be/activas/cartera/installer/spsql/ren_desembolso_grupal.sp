
/*************************************************************************/
/*   Archivo             :       sp_desembolso_ren_grupal.sp             */
/*   Stored procedure    :       sp_desembolso_ren_grupal                */
/*   Base de datos       :       cob_cartera                             */
/*   Producto            :       Cartera                                 */
/*   Disenado por        :       Andy Gonzalez                           */
/*   Fecha de escritura  :       Mar 2021                                */
/*************************************************************************/
/*                                IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                             PROPOSITO                                 */
/*   Este programa genera la creacion de operaciones grupal              */
/*                            MODIFICACIONES                             */
/*   12-01-2021    A. Gonzalez    Emisión Inicial                        */
/*   26-01-2021    S. Rojas       Merge Oferta Producto                  */
/*   07-06-2021    A. Gonzalez    Mostrar Saldo Anterior en etapa        */
/*                                IMP Desembolsos sin OP anterior        */
/*   13-12-2021    ACH            ERR#169730,desembolso cliente reingreso*/
/*                                y nuevos                               */
/*   12/10/2022    D. Cumbal      Req. #195239                           */
/*   01/12/2022    ACH/DCU        Req. #194284 Dia de Pago               */
/*************************************************************************/
USE cob_cartera
GO

IF OBJECT_ID ('dbo.sp_desembolso_ren_grupal') IS NOT NULL
    DROP PROCEDURE dbo.sp_desembolso_ren_grupal
GO

create proc sp_desembolso_ren_grupal
   @s_ssn              int          = null,
   @s_user             login,
   @s_rol              tinyint      = 3,
   @s_term             varchar(30),
   @s_date             datetime,
   @s_sesn             int          = null,
   @s_ofi              smallint,
   ---------------------------------------
   @i_anterior         cuenta       = null,
   @i_migrada          cuenta       = null,
   @i_tramite_grupal   int          = null,
   @i_oficina          smallint     = null,
   @i_reestructuracion varchar(1)   = null,
   @i_numero_reest     int          = null,
   @i_num_renovacion   int          = 0,
   @i_grupal           varchar(1)   = null,
   @i_tasa             float        = null,
   @i_en_linea         varchar(1)   = 'S',
   @i_externo          varchar(1)   = 'S',
   @i_desde_web        varchar(1)   = 'S',
   @i_salida           varchar(1)   = 'N',
   @i_fecha_ini        datetime     = null,
   @i_forma_pago       catalogo     = null,
   @i_forma_desembolso catalogo     = null,
   @i_formato_fecha    int          = 101,
   @i_etapa_flujo      varchar(10)  = 'FIN' -- LGU 2017-07-13: para ver en que momento se ccrea el DES y LIQ del prestamo
                                            -- (1) IMP: impresion: solo crear OP hijas
                                            -- (2) FIN: al final del flujo: crea DES y LIQ de OP hijas
   ---------------------------------------
as

declare
@w_sp_name                varchar(64),
@w_error                  int,
@w_operacion              int,
@w_tg_cuenta              cuenta,
@w_nombre                 varchar(60),
@w_tramite                int,
@w_porc_garantia          float,
@w_monto_garantia         money,
@w_monto_total            money,
@w_tg_grupo               int,
@w_tg_cliente             int,
@w_tg_monto               money,
@w_tg_operacion           int,  -- LGU separcion del sp en dos partes: IMP y FIN
@w_banco_generado         cuenta,
@w_cta_grupal             cuenta,
@w_tipo                   varchar(1),
@w_toperacion             catalogo,
@w_clase_cartera          catalogo,
@w_sector                 catalogo,
@w_moneda                 tinyint,
@w_oficial                smallint,
@w_banca                  catalogo,
@w_filial                 tinyint,
@w_servidor               varchar(30),
@w_banco                  cuenta,
@w_codigo_externo         varchar(64),
@w_plazo                  smallint,
@w_tplazo                 catalogo,
@w_dias_plazo             smallint,
@w_plazo_en_dias          smallint,
@w_grupo_comentario       varchar(10),
@w_operacion_grupal       int,
@w_fecha_ini              datetime,
@w_op_oficina             smallint,
@w_op_destino             catalogo,
@w_op_ciudad              int,
--@w_forma_desembolso       catalogo,
@w_op_banco_grupal        cuenta,
@w_commit                 char(1),
@w_fecha_proceso          datetime,
@w_est_cancelado          int,
@w_tgarantia_liquida      descripcion,
@w_tg_prestamo            varchar(32),
@w_tg_ref_grupal          varchar(32),
@w_dias_mora              FLOAT,
@w_desplazamiento_cuota   char(1),
@w_dias_desplazados       int = 0,
@w_int_espera             varchar(10),
@w_num_div                int,
@w_monto_int_desp         money,
@w_secuencial             int,
@w_div_vigente_desp       int,
@w_max_ciclo              int,
@w_banco_ant              cuenta,
@w_operacionca_ant        int,
@w_num_renovacion         int ,
@w_msg                    varchar(255),
@w_operacion_ant          int,
@w_fecha_ult_proceso_ant  datetime  ,
@w_oficina                int,
@w_saldo_ant              money,
@w_monto_des_ren          money,
@w_secuencial_des         int ,
@w_sum_total_saldo        money,
@w_desplazamiento         int,
@w_param_oferta_producto  char(1),
@w_factor                 int,
@w_tiene_operacion_anterior  char(1),
@w_promocion              char(1),
@w_porcentaje_monto_grp   float,
@w_porcentaje_monto_ind   float,
@w_porcentaje_monto_ani   float,
@w_periodo_int            smallint,
@w_dia_pago               datetime,
@w_fecha_ini_tmp          datetime,
@w_dia_inicio             int,
@w_fecha_dispersion       datetime,
@w_ejecuta_dia_pago       char(1)

-- VARIABLES INICIALES
select
@w_sp_name = 'sp_desembolso_ren_grupal',
@w_commit  = 'N'

-- VALIDAR QUE EL PRODUCTO ESTE HABILITADO 

if exists (select 1
from   cobis..cl_pro_moneda,  cobis..cl_producto
where  pm_producto = pd_producto 
and    pd_abreviatura = 'CCA'
and    pm_moneda      = 0
and    pm_tipo        = 'R'
and    pm_estado <> 'V') begin 

   exec cobis..sp_cerror
        @t_debug  = 'N',    
        @t_file   =  null,
        @t_from   =  @w_sp_name,   
        @i_num    =  6900070,
        @i_msg 	 =  'No se pudo establecer el producto bancario seleccionado como disponible a la venta'
   return @w_error    
end
--fin VALIDAR

--MTA Inicio Actualizacion de la mora para operaciones a desembolsar
SELECT @w_dias_mora = dt_porcen_colateral
FROM ca_default_toperacion
WHERE dt_toperacion = 'GRUPAL'
--MTA Fin Actualizacion de la mora para operaciones a desembolsar         

-- PARAMETRO GARANTIA LIQUIDA
select @w_tgarantia_liquida = pa_char
from cobis..cl_parametro
where pa_nemonico = 'GARLIQ'
and pa_producto = 'GAR'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

--Datos iniciales		
select 
@w_toperacion        = tr_toperacion,
@w_promocion         = isnull(tr_promocion,'N')
from cob_credito..cr_tramite
where tr_tramite = @i_tramite_grupal

-- PARAMETRO PORCENTAJE GARANTIA GRUPAL
select @w_porc_garantia = pa_float
from cobis..cl_parametro
where pa_nemonico = 'PGARGR'
and pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

------------------------------------------------------------------
--Parametro porcentaje para el calculo de la garantia
------------------------------------------------------------------
select @w_porcentaje_monto_grp = pa_float
from cobis..cl_parametro 
where pa_nemonico = 'PGARGR' 
and pa_producto = 'CCA'

select @w_porcentaje_monto_ind = pa_float
from cobis..cl_parametro 
where pa_nemonico = 'PGAIND' 
and pa_producto = 'CCA'

select @w_porcentaje_monto_ani = pa_float
from cobis..cl_parametro 
where pa_nemonico = 'PGARAN' 
and pa_producto = 'CCA'

if @w_toperacion = 'INDIVIDUAL'
   select @w_porc_garantia = @w_porcentaje_monto_ind

if @w_toperacion = 'GRUPAL' and @w_promocion = 'N'
   select @w_porc_garantia = @w_porcentaje_monto_grp

if @w_toperacion = 'GRUPAL' and @w_promocion = 'S'
   select @w_porc_garantia = @w_porcentaje_monto_ani
------------------------------------------------------------------
------------------------------------------------------------------
-- PARAMETRO NOMBRE DE SERVIDOR
select @w_servidor = pa_char
from cobis..cl_parametro
where pa_nemonico = 'SRVCFP' -- NOMBRE DE SERVIDOR CTS PARA CAMBIO FECHA PROCESO
and pa_producto = 'BAT'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR
end

-- Obtener op_operacion prestamo grupal
select
@w_operacion_grupal = op_operacion,
@w_op_banco_grupal  = op_banco,
@w_fecha_ini        = op_fecha_ini,
@w_sector           = isnull(op_sector,'1'),
@w_clase_cartera    = isnull(op_clase,'1'),
@w_moneda           = isnull(op_moneda,0),
@w_plazo            = op_plazo,
@w_tplazo           = op_tplazo,
@w_toperacion       = op_toperacion,
@w_op_oficina       = op_oficina,
@w_op_destino       = op_destino,
@w_op_ciudad        = op_ciudad,
@w_cta_grupal       = op_cuenta, -- LPO Cuenta Grupal
@w_desplazamiento   = op_desplazamiento,  -- SRO 140073
@w_periodo_int      = op_periodo_int
from ca_operacion
where op_tramite = @i_tramite_grupal
   
select @w_param_oferta_producto = isnull(pa_char, 'N')
from cobis..cl_parametro 
where pa_nemonico = 'OFEPRO'

select @w_factor     = td_factor 
from   cob_cartera..ca_tdividendo
where  td_tdividendo = @w_tplazo
and    td_estado     = 'V'

select @w_factor  = isnull(@w_factor, 7)

if @w_param_oferta_producto = 'S'  select @w_dias_desplazados = 7 * @w_desplazamiento --Semanal

-- Plazo en dias
select @w_dias_plazo = td_factor
from ca_tdividendo
where td_tdividendo = @w_tplazo

select @w_plazo_en_dias = isnull(@w_plazo * @w_dias_plazo,0)

-- Inicializar acumulador montos garantias
select
@w_monto_total          = 0


exec @w_error = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out

-- Fecha Proceso de Cartera
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7 -- CARTERA

-- Obtener el Monto total del prestamo grupal
select
@w_tg_grupo    = tg_grupo,
@w_monto_total = sum(isnull(tg_monto_aprobado,0))
from cob_credito..cr_tramite_grupal
where tg_tramite = @i_tramite_grupal
and   tg_grupal  = 'S'
group by tg_grupo


select @w_fecha_ini = isnull(@i_fecha_ini, convert(varchar(10),@w_fecha_proceso,@i_formato_fecha))

--Habilitar LPO
/*select @w_forma_desembolso = dm_producto --Si no existe desembolso grupal la variable no se afectara
from cob_cartera..ca_desembolso
where dm_operacion = @w_operacion_grupal

if @@rowcount <= 0 select @w_forma_desembolso = @i_forma_pago
*/

--------------------------------------------------
-- Ejecucion dia de pago 
--------------------------------------------------
select 
@w_fecha_dispersion = dp_fecha_dispercion,
@w_dia_pago         = dp_fecha_dia_pag
from cob_cartera..ca_dia_pago
where dp_banco = @w_op_banco_grupal

if (@w_fecha_dispersion <> @w_fecha_ini or @w_fecha_ini <> @w_fecha_proceso) or (@i_etapa_flujo = 'IMP')
begin
   select @w_fecha_dispersion = @w_fecha_ini
   
   exec cob_cartera..sp_valida_diapago
        @i_banco            = @w_op_banco_grupal ,
        @i_fecha_dispersion = @w_fecha_dispersion,
        @i_dia_pago         = @w_dia_pago        ,
        @i_periodo_int      = @w_periodo_int     ,
        @i_tplazo           = @w_tplazo          ,
        @o_fecha_inicio     = @w_fecha_ini_tmp out,
        @o_dia_inicio       = @w_dia_inicio    out,
        @o_error            = @w_error         out		
   if @w_error <> 0 begin
      goto   ERROR
   end
   
   
   if @w_fecha_ini_tmp is not null and @w_fecha_ini_tmp >= @w_fecha_proceso 
      select @w_fecha_ini = @w_fecha_ini_tmp
   
   select @w_ejecuta_dia_pago= 'S'
end

print '@w_fecha_ini_tmp modifica: ' + convert(varchar, @w_fecha_ini_tmp) 
--------------------------------------------------

-- Atomicidad en la transaccion
if @@trancount = 0 begin
   select @w_commit = 'S'
   begin tran
end

--Por caso #169730
select * 
into #cr_op_renovar
from cob_credito..cr_op_renovar
where 1 = 2

-- Cursor Tramite Grupal
select @w_tg_cliente = 0
while 1=1
begin

    if @i_etapa_flujo = 'IMP'
    begin

	    select top 1
	        @w_tg_grupo     = tg_grupo,
	        @w_tg_cliente   = tg_cliente,
	        @w_tg_monto     = tg_monto,    -- aqui esta el monto autorizado por la entidad
	        @w_tg_cuenta    = tg_cuenta,
	        @w_tg_operacion = tg_operacion, -- LGU: ejecutar sp en 2 partes: IMPRESION  DOC y FINAL
	        @w_tg_prestamo  = tg_prestamo,
	        @w_tg_ref_grupal= tg_referencia_grupal
	    from cob_credito..cr_tramite_grupal
	    where tg_tramite = @i_tramite_grupal
	    ---and   tg_monto   > 0  tomo todas pues pueden haber modificado el monto luego de crear la op y dejarlo en cero
	    and   tg_grupal  = 'S'
	    and   tg_cliente > @w_tg_cliente
	    order by tg_cliente
	
	    if @@rowcount = 0
	    begin
	        break
	    end
	end
	ELSE
	BEGIN	
	    select top 1
	        @w_tg_grupo     = tg_grupo,
	        @w_tg_cliente   = tg_cliente,
	        @w_tg_monto     = tg_monto,    -- aqui esta el monto autorizado por la entidad
	        @w_tg_cuenta    = tg_cuenta,
	        @w_tg_operacion = tg_operacion, -- LGU: ejecutar sp en 2 partes: IMPRESION  DOC y FINAL
	        @w_tg_prestamo  = tg_prestamo,
	        @w_tg_ref_grupal= tg_referencia_grupal
	    from cob_credito..cr_tramite_grupal
	    where tg_tramite = @i_tramite_grupal
	    and   tg_monto   > 0
	    and   tg_grupal  = 'S'
	    and   tg_cliente > @w_tg_cliente
	    order by tg_cliente
	
	    if @@rowcount = 0
	    begin
	        break
	    end
	end
	

   if (@w_tg_cuenta is null) select @w_tg_cuenta = ea_cta_banco from cobis..cl_ente_aux where ea_ente = @w_tg_cliente
   
   /* SACAR SECUENCIALES SESIONES */
   exec @s_ssn = sp_gen_sec
   @i_operacion  = -1

   exec @s_sesn = sp_gen_sec
   @i_operacion  = -1

   select
       @w_nombre  = rtrim(p_p_apellido)+' '+rtrim(p_s_apellido)+' '+rtrim(en_nombre),
       @w_oficial = isnull(en_oficial,1),
       @w_banca   = isnull(en_banca,'1'),
       @w_filial  = isnull(en_filial,1)
   from cobis..cl_ente
   where en_ente = @w_tg_cliente
   --set transaction isolation level read uncommitted

   select @w_grupo_comentario = cast(@w_tg_grupo as varchar)

   select @w_operacion = null, @w_banco = null, @w_tramite = null

   set rowcount 0

    -- LGU: ejecutar sp en 2 partes: IMP y FIN
    if @i_etapa_flujo = 'IMP'
    begin
       -- si son diferentes, se entiende que ya esta creada laoperacion hija
       if (@w_tg_ref_grupal <>  @w_tg_prestamo)  -- YA SE CREO OP HIJA, BORRAR
       BEGIN
            select @w_tramite = op_tramite from cob_cartera..ca_operacion WHERE op_operacion = @w_tg_operacion

            delete cob_credito..cr_tramite           where tr_tramite   = @w_tramite      and @w_tramite      <> @i_tramite_grupal
            delete cob_cartera..ca_operacion         where op_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_rubro_op          where ro_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_dividendo         where di_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_amortizacion      where am_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_cuota_adicional   where ca_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_credito..cr_documento         where do_tramite   = @w_tramite      and @w_tramite      <> @i_tramite_grupal

            delete cob_cartera..ca_valores           where va_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_definicion_nomina where dn_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            delete cob_cartera..ca_relacion_ptmo     where rp_pasiva    = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
			delete cob_cartera..ca_otro_cargo        where oc_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal

            select @w_tramite = 0
            update cob_credito..cr_documento      set do_numero = 0 where do_tramite   = @i_tramite_grupal

       end

	   IF @w_tg_monto > 0 -- CREAR LA OPERACION
	   BEGIN
	       -- Creacion de operaciones por socio
	       exec @w_error        = cob_cartera..sp_crear_prestamo
	       @s_srv               = @w_servidor,
	       @s_user              = @s_user,
	       @s_term              = @s_term,
	       @s_ofi               = @s_ofi,
	       @s_rol               = @s_rol,
	       @s_ssn               = @s_ssn,
	       @s_lsrv              = @w_servidor,
	       @s_date              = @s_date,
	       @s_sesn              = @s_sesn,
	       @i_tipo              = @w_tipo,
	       @i_tramite           = 0,
	       @i_cliente           = @w_tg_cliente,
	       @i_nombre            = @w_nombre,
	       @i_codeudor          = 0,
	       @i_sector            = @w_sector,
	       @i_toperacion        = @w_toperacion,
	       @i_oficina           = @w_op_oficina,
	       @i_moneda            = @w_moneda,
	       @i_comentario        = @w_grupo_comentario,
	       @i_oficial           = @w_oficial,
	       @i_fecha_ini         = @w_fecha_ini,
	       @i_monto             = @w_tg_monto,
	       @i_monto_aprobado    = @w_tg_monto,
	       @i_destino           = @w_op_destino,
	       @i_ciudad            = @w_op_ciudad,
	       @i_cuenta            = @w_tg_cuenta, --LPO cuenta individual de la cual se haran los debitos (en los pagos)
	       @i_clase_cartera     = @w_clase_cartera,
	       @i_numero_reest      = 0,
	       @i_num_renovacion    = 0,
	       @i_grupal            = @i_grupal,
	       @i_tasa              = @i_tasa,
	       @i_banca             = @w_banca,
	       @t_trn               = 77100,
	       @i_forma_pago        = @i_forma_pago,
	       @i_plazo             = @w_plazo ,
	       @i_dias_desplazados  = @w_dias_desplazados,
	       @i_desplazamiento    = @w_desplazamiento,
	       @i_dia_inicio        = @w_dia_inicio,
	       @i_ejecuta_dia_pago  = @w_ejecuta_dia_pago,
	       @o_operacion         = @w_operacion out,
	       @o_banco             = @w_banco     out,
	       @o_tramite           = @w_tramite   out
	
	       if @w_error <> 0 begin
	          select @w_sp_name = 'sp_desembolso_grupal'
	          PRINT '1.1.-x1'
	          goto ERROR
	       end
	       
	       IF @w_operacion IS NULL OR @w_banco IS NULL 
	       BEGIN
	          PRINT '1.1.- OP_BANCO NULO !!'
	          select @w_sp_name = 'sp_desembolso_grupal_1'
	          SELECT @w_error = 710568
			  print '710568: Error en la Actualizacion del registro!!! '
	          goto ERROR
	       end
	       -- Actualizacion Operacion HIJA
	        update cob_credito..cr_tramite_grupal set
	            tg_operacion   = @w_operacion,
	            tg_prestamo    = @w_banco
	        where tg_tramite   = @i_tramite_grupal
	        and   tg_cliente   = @w_tg_cliente
	        and   tg_grupal    = 'S'
	
	        if @@error <> 0 begin
	           select @w_error = 710568
	           print '710568: Error en la Actualizacion del registro!!! '
	           goto ERROR
	        end
	
	        update cob_cartera..ca_operacion set
	            op_cuenta = ea_cta_banco
	        from cobis..cl_ente_aux
	        where op_operacion = @w_operacion
	        and ea_ente = @w_tg_cliente
	
	        if @@error <> 0
	        begin
	           select @w_error = 710568
			   print '710568: Error en la Actualizacion del registro!!! '
	           goto ERROR
	        end
			
			
			-----BLOQUE DE ACTUALIZACION DE LA OPERACION ANTERIOR 
					
            ---MAXIMO VIGENTE ANTERIOR 
            select  
            @w_max_ciclo = isnull(max(dc_ciclo_grupo),0)
            from cob_cartera..ca_det_ciclo 
            where dc_grupo  = @w_tg_grupo 
            
            if @@rowcount = 0  or @w_max_ciclo = 0 begin 
               select 
               @w_error = 70006,
               @w_msg   = 'ERROR: NO TIENE OPERACIONES ANTERIORES'
			   print 'ERROR: NO TIENE OPERACIONES ANTERIORES'
               GOTO ERROR
            end 
			
			
			select @w_tiene_operacion_anterior = 'S' 
			
            select distinct @w_operacion_ant =  isnull(dc_operacion,0)
            from ca_det_ciclo, cob_credito..cr_tramite_grupal -- Por caso #169730
            where dc_grupo     = @w_tg_grupo  
            and dc_ciclo_grupo = @w_max_ciclo
			and dc_cliente     = @w_tg_cliente
            and dc_grupo = tg_grupo
            and dc_referencia_grupal = tg_referencia_grupal
            and tg_prestamo <> tg_referencia_grupal
            and dc_operacion = tg_operacion
            and dc_cliente = tg_cliente
            and tg_monto > 0
            and tg_participa_ciclo = 'S'

			--EN CASO DE SER -9998 SE TRATA DEL INGRESO DE UN CLIENTE NUEVO
			--SE LO CONSIDERA PARA PODER TENER UNA BANDERA PARA PODER IDENTIFICAR ESTOS CLIENTES
			if  @w_operacion_ant  = 0 or @@rowcount = 0 select @w_tiene_operacion_anterior = 'N'
            			
			if exists (select 1 from ca_operacion where op_operacion = @w_operacion_ant and op_estado = @w_est_cancelado) 
			      and @w_tiene_operacion_anterior = 'S' begin 			
			   select 
               @w_error = 700999,
               @w_msg   = 'ERROR: LA OPERACION ANTERIOR SE ENCUENTRA CANCELADA'
			   print 'ERROR: LA OPERACION ANTERIOR SE ENCUENTRA CANCELADA'
               GOTO ERROR
			end 
			
			
			if exists (select 1 from ca_operacion where op_banco = @w_banco_ant and op_anterior <> null) and @w_tiene_operacion_anterior = 'S' begin 
			   select 
               @w_error = 700999,
               @w_msg   = 'ERROR: LA OPERACION ANTERIOR SE ENCUENTRA RENOVADA'
			   print 'ERROR: LA OPERACION ANTERIOR SE ENCUENTRA RENOVADA'
               GOTO ERROR
			end 
			

           select @w_banco_ant = op_banco 
           from ca_operacion 
           where op_operacion = @w_operacion_ant
           and @w_tiene_operacion_anterior = 'S'
           
           update ca_operacion set 
           op_renovacion = 'S'
           where op_operacion = @w_operacion_ant
		   and @w_tiene_operacion_anterior = 'S'
           
           update ca_operacion set 
           op_anterior = @w_banco_ant 
           where op_operacion = @w_operacion
           and @w_tiene_operacion_anterior = 'S'

			---ACTUALIZACION CON NUMERO RENOVACION NUEVO 
           select @w_num_renovacion = isnull(op_num_renovacion,0)
           from ca_operacion 
           where op_banco           = @w_banco 
		   and @w_tiene_operacion_anterior = 'S'
		   
		   update ca_operacion set op_num_renovacion =  @w_num_renovacion  +1 
		   where op_banco    =  @w_banco
           and @w_tiene_operacion_anterior = 'S'		   
		      
            if @@error <> 0 begin 
               select 
               @w_error = 70006,
               @w_msg   = 'ERROR: AL ACTUALIZAR NUMERO DE RENOVACION'
               print 'ERROR: AL ACTUALIZAR NUMERO DE RENOVACION'
               GOTO ERROR
            end 
		   		   
			-------------------------------------------------------
			--CREACION DE LAS RENOVACIONES --ESTO SERVIRA PARA LA CREACION DE LOS MULTIPLES DESEMBOLSOS
			 select @w_saldo_ant = 0
			 ------SALDO ANTERIOR----
			 select @w_saldo_ant = isnull(sum(am_acumulado-am_pagado),0) 
			 from  ca_amortizacion         
			 where am_operacion = @w_operacion_ant
			 and   am_estado    <> @w_est_cancelado
			 and  @w_tiene_operacion_anterior = 'S'
			
			if @w_tiene_operacion_anterior = 'N' select @w_saldo_ant =0 
			
             insert into cob_credito..cr_op_renovar(
             or_tramite        ,or_num_operacion      ,or_monto_original,  
             or_saldo_original ,or_toperacion         ,or_login,
             or_producto       ,or_finalizo_renovacion,or_operacion_original,
             or_monto_inicial  ,or_referencia_grupal  ,
             or_ciclo_original , or_grupo , or_aplicar) -- monto, solicitado y si tiene padre o no 
             values(
             @w_tramite       ,isnull(@w_banco_ant, @w_banco)  ,@w_tg_monto ,
             @w_saldo_ant     ,@w_toperacion                   ,@s_user,
             'CARTERA'        ,'N'                             ,@w_operacion,
             null             ,@w_tg_ref_grupal                ,
             @w_max_ciclo     ,@w_tg_grupo, @w_tiene_operacion_anterior)
			 
			 
            if @@error <> 0 begin 
               print 'ERROR EN EL REGISTRO DE REN'
               GOTO ERROR
            end 

        end -- IF @w_tg_monto > 0 -- CREAR LA OPERACION
    end     -- if @i_etapa_flujo = 'IMP'

    --///////////////////////////////////////////////////////////////////////////
    -- LGU: se ejecuta el DES y LIQ en la ultima etapa
    if @i_etapa_flujo = 'FIN' AND (@w_tg_ref_grupal <>  @w_tg_prestamo)
    begin
        -- recupero operacion, banco y tramite de la OP HIJA creada en la primera parte
        select  @w_operacion = @w_tg_operacion	
		
	
         --MTA Inicio Actualizacion de la mora para operaciones a desembolsar
        
         UPDATE cob_cartera..ca_operacion 
         SET    op_margen_redescuento = @w_dias_mora 
	     WHERE op_operacion = @w_operacion    
	
	    --MTA Fin Actualizacion de la mora para operaciones a desembolsar
		
		-- caso#169730
	    print 'INICIA OPERACION: ' + convert(varchar(30), @w_operacion)
		select @w_tramite = 0, 
		       @w_banco = null, 
		       @w_banco_ant = null,
	           @w_fecha_ult_proceso_ant = null,
		       @w_operacionca_ant = null
		
        select
        @w_tramite  = op_tramite,
        @w_banco    = op_banco,
        @w_banco_ant = op_anterior			
        from ca_operacion
        where op_operacion = @w_operacion
		
		if (@w_banco_ant is null ) begin -- caso#169730
          print 'LA OPERACION: ' + convert(varchar(30), @w_operacion) + ' NO TIENE OPERACION ANTERIOR A RENOVAR, CONTINUAR'
		  --goto ERROR
		end else begin
		  print 'LA OPERACION: ' + convert(varchar(30), @w_operacion) + ' SI TIENE OPERACION ANTERIOR A RENOVAR, CONTINUAR'
		end 
			 
		select 
		@w_fecha_ult_proceso_ant = op_fecha_ult_proceso,
        @w_operacionca_ant 		 = op_operacion
        from ca_operacion 
        where op_banco  = @w_banco_ant
      	
		-- caso#169730
		print 'aa-w_operacionca_ant: '+ convert(varchar(256), isnull(@w_operacionca_ant, 0 ))		
		if exists (select 1 from ca_transaccion where tr_operacion = @w_operacionca_ant and tr_tran = 'REN') and @w_operacionca_ant is not null
		begin
		   print 'Va a saltar al siguiente aa-w_operacionca_ant: '+ convert(varchar(256), isnull(@w_operacionca_ant, 0 ))
		   goto SIGUIENTE_REN     
		end
		
		-- caso#169730
		select @w_saldo_ant = 0
		---EJECUCION DE FECHA VALOR DEL PRESTAMO ANTERIOR EN QUE CASO DE QUE LA FECHA PROCESO SEA DIFERENTE---------
		if not exists (select 1 from ca_transaccion where tr_operacion = @w_operacionca_ant and tr_tran = 'REN') and @w_operacionca_ant is not null           
		begin		
		    print 'Ingreso a renovacion: ' + convert(varchar(256), @w_operacionca_ant)
            -- Montos de garantias individuales y garantia total
            select @w_monto_garantia = @w_tg_monto * @w_porc_garantia / 100
		    
			if (@w_fecha_ult_proceso_ant is not null and (@w_fecha_ult_proceso_ant <> @w_fecha_proceso)) 	begin 
		    		
               exec @w_error  = sp_fecha_valor 
               @s_date        = @w_fecha_proceso,
               @s_user        = 'usrren',
               @s_term        = 'reno',
               @t_trn         = 7049,
               @i_fecha_mov   = @w_fecha_proceso,
               @i_fecha_valor = @w_fecha_proceso,
               @i_banco       = @w_banco_ant,
               @i_secuencial  = 1,
               @s_ofi         = @w_oficina,
               @i_en_linea       = 'N',
               @i_operacion   = 'F'
               
               if @w_error <> 0 begin    
                  GOTO ERROR
               end 
		    
		    end 
		
		    ---calculo del saldo de la operacion anterior ----
		    select @w_saldo_ant = 0 ,@w_monto_des_ren =0,@w_secuencial_des = 0
		    		    
	        select @w_saldo_ant = isnull(sum(am_acumulado-am_pagado),0) 
	        from  ca_amortizacion         
	        where am_operacion = @w_operacionca_ant
	        and   am_estado    <> @w_est_cancelado
	    
		end
		 
			 
		select @w_monto_des_ren = @w_tg_monto - isnull(@w_saldo_ant , 0)
		 
		
        print ' bb NUEVO: '+ convert(varchar(256), isnull(@w_banco, 'NO HAY BANCO')) + 
		      ' bb ANTERIOR: '+ convert(varchar(256),isnull(@w_banco_ant, 'NO HAY BANCO ANT')) + 
		      ' mn ANTERIOR: ' + convert(varchar(256), isnull(@w_saldo_ant, 0)) + 
			  ' mn SOLICITADO: ' + convert(varchar(256), isnull(@w_tg_monto, 0))
		
		if @w_saldo_ant > 0
		begin
		    print 'w_saldo_ant mayor a 0 --Ingreso el tramite: '+ convert(varchar(30), @w_tramite)+ ' Banco: ' +  convert(varchar(64), @w_banco)
			
       	    --FINALIZA Y ACTUALIZA RENOVACION 
            update cob_credito..cr_op_renovar set 
            or_saldo_original = @w_saldo_ant ,
            or_monto_original = @w_tg_monto,
            or_finalizo_renovacion = 'S'
            where or_tramite  = @w_tramite
            
            if @@error <> 0 begin 
               select @w_error = 70008803
                PRINT '10.-x1 ERROR ACTUALIZANDO CR RENOVAR'
                goto ERROR
            end 
		    
            exec @w_error        = cob_cartera..sp_renovacion
            @s_ssn               = @s_ssn,
            @s_sesn              = @s_sesn,   
            @s_date              = @s_date,          
            @s_user              = @s_user,            
            @s_term              = @s_term,             
            @s_ofi               = @s_ofi,             
            @i_banco             = @w_banco,       
            @i_valor_renovar     = @w_tg_monto,  
            @i_forma_pago        = @i_forma_pago,   
            @i_cuenta_banco      = @w_tg_cuenta 		
            
            if @w_error <> 0 begin 
            
                print 'ERROR EN LA RENOVACION: '+convert(varchar,@w_error)
                GOTO ERROR 
            
            end 		
            
            exec @w_error = sp_borrar_tmp
            @s_sesn   = @s_sesn,
            @s_user   = @s_user,
            @s_term   = @s_term,
            @i_banco  = @w_banco
            
            if @w_error <> 0 begin
               --close cur_cr_tramite_grupal
               --deallocate cur_cr_tramite_grupal
               select @w_sp_name = 'sp_borrar_tmp'
            PRINT '5.-x1'
               goto ERROR
            end
            
            --CREA LOS REGISTROS DE DESEMBOLSO 
            --LOQUIDA LA NUEVA OBLIGACION 
            --CANCELA LA OPERACION ANTERIOR 
            
            exec @w_error      = sp_pasotmp
            @s_user            = @s_user,
            @s_term            = @s_term,
            @i_banco           = @w_banco,
            @i_operacionca     = 'S',
            @i_dividendo       = 'S',
            @i_amortizacion    = 'S',
            @i_cuota_adicional = 'S',
            @i_rubro_op        = 'S',
            @i_relacion_ptmo   = 'S',
            @i_nomina          = 'S',
            @i_acciones        = 'S',
            @i_valores         = 'S'
            
            if @w_error <> 0 begin
               --close cur_cr_tramite_grupal
               --deallocate cur_cr_tramite_grupal
               select @w_sp_name = 'sp_pasotmp'
            PRINT '6.-x1'
               goto ERROR
            end
            
            exec @w_error          = sp_liquida
            @s_ssn                 = @s_ssn,
            @s_sesn                = @s_sesn,
            @s_user                = @s_user,
            @s_date                = @s_date,
            @s_ofi                 = @s_ofi,
            @s_rol                 = @s_rol,
            @s_term                = @s_term,
            @i_banco_ficticio      = @w_operacion,
            @i_banco_real          = @w_banco,
            @i_fecha_liq           = @w_fecha_ini,
            @i_externo             = 'N',
            @i_tasa                = @i_tasa,        --SRO Santander
            @i_dias_desplazados    = @w_dias_desplazados,
            @i_cuotas_a_desplazar  = @w_desplazamiento,
            @o_banco_generado      = @w_banco_generado out
            
            if @w_error <> 0 begin
               --close cur_cr_tramite_grupal
               --deallocate cur_cr_tramite_grupal
               select @w_sp_name = 'sp_liquida'
                PRINT '7.-x1'
               goto ERROR
            end
            	    
            exec @w_error  = sp_borrar_tmp
            @s_sesn   = @s_sesn,
            @s_user   = @s_user,
            @s_term   = @s_term,
            @i_banco  = @w_banco
            
            if @w_error <> 0 begin
               --close cur_cr_tramite_grupal
               --deallocate cur_cr_tramite_grupal
               select @w_sp_name = 'sp_borrar_tmp'
               PRINT '8.-x1'
               goto ERROR
            end		    
		    
            ---FINALIZA Y ACTUALIZA RENOVACION 
            update cob_credito..cr_op_renovar set 
            or_saldo_original = @w_saldo_ant ,
            or_monto_original = @w_tg_monto,
            or_finalizo_renovacion = 'S'
            where or_tramite  = @w_tramite
            
            if @@error <> 0 begin 
               select @w_error = 70008803
                PRINT '10.-x1 ERROR ACTUALIZANDO CR RENOVAR'
                goto ERROR
            end 	
		end
		else -- caso#169730
		begin
            print 'w_saldo_ant menor a 0 --Ingreso el tramite: '+ convert(varchar(30), @w_tramite) + ' Banco: ' +  convert(varchar(64), @w_banco)
			insert into #cr_op_renovar
            select * 
            from cob_credito..cr_op_renovar
            where or_tramite  = @w_tramite
            
            delete cob_credito..cr_op_renovar
            where or_tramite  = @w_tramite
		    
            exec @w_error  = sp_borrar_tmp
            @s_sesn   = @s_sesn,
            @s_user   = @s_user,
            @s_term   = @s_term,
            @i_banco  = @w_banco
            
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_borrar_tmp'
               print '2.-x1'               
               goto ERROR
            end
                        
            exec @w_error      = sp_pasotmp
            @s_user            = @s_user,
            @s_term            = @s_term,
            @i_banco           = @w_banco,
            @i_operacionca     = 'S',
            @i_dividendo       = 'S',
            @i_amortizacion    = 'S',
            @i_cuota_adicional = 'S',
	        @i_rubro_op        = 'S',
            @i_relacion_ptmo   = 'S',
            @i_nomina          = 'S',
            @i_acciones        = 'S',
            @i_valores         = 'S'
            
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_pasotmp'			   
               PRINT '3.-x1'
			   goto ERROR
            end
		    
            -- Montos de garantias individuales y garantia total
            select @w_monto_garantia = @w_tg_monto * @w_porc_garantia / 100
            
            select @i_forma_desembolso = pa_char
            from cobis..cl_parametro
            where pa_nemonico = 'NCRAHO' --NOTA DE CREDITO AHORRO
            and   pa_producto = 'CCA'
		    
            exec @w_error     = sp_desembolso
            @s_ofi            = @s_ofi,
            @s_term           = @s_term,
            @s_user           = @s_user,
            @s_date           = @s_date,
            @i_nom_producto   = 'CCA',
            @i_producto       = @i_forma_desembolso, --LPO Se hereda a las operaciones hijas la Forma de desembolso del Prestamo Grupal
            @i_cuenta         = @w_tg_cuenta, --LPO Cuenta Individual en la cual se hara el desembolso de cada operacion
            @i_beneficiario   = @w_nombre,
            @i_ente_benef     = @w_tg_cliente,
            @i_oficina_chg    = @s_ofi,
            @i_banco_ficticio = @w_operacion,
            @i_banco_real     = @w_banco,
            @i_fecha_liq      = @w_fecha_ini,
            @i_monto_ds       = @w_tg_monto,
            @i_moneda_ds      = @w_moneda,
            @i_tcotiz_ds      = 'COT',
            @i_cotiz_ds       = 1.0,
            @i_cotiz_op       = 1.0,
            @i_tcotiz_op      = 'COT',
            @i_moneda_op      = @w_moneda,
            @i_operacion      = 'I',
            @i_externo        = 'N'
            
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_desembolso'
               PRINT '4.-x1'
               goto ERROR			   
            end
            
            exec @w_error = sp_borrar_tmp
            @s_sesn   = @s_sesn,
            @s_user   = @s_user,
            @s_term   = @s_term,
            @i_banco  = @w_banco
		    
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_borrar_tmp'
               PRINT '5.-x1'
               goto ERROR			   
            end
		    
            exec @w_error      = sp_pasotmp
            @s_user            = @s_user,
            @s_term            = @s_term,
            @i_banco           = @w_banco,
            @i_operacionca     = 'S',
            @i_dividendo       = 'S',
            @i_amortizacion    = 'S',
            @i_cuota_adicional = 'S',
            @i_rubro_op        = 'S',
            @i_relacion_ptmo   = 'S',
            @i_nomina          = 'S',
            @i_acciones        = 'S',
            @i_valores         = 'S'
		    
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_pasotmp'
               PRINT '6.-x1'
			   goto ERROR
            end
		    
            exec @w_error     = sp_liquida 
            @s_ssn            = @s_ssn,
            @s_sesn           = @s_sesn,
            @s_user           = @s_user,
            @s_date           = @s_date,
            @s_ofi            = @s_ofi,
            @s_rol            = @s_rol,
            @s_term           = @s_term,
            @i_banco_ficticio = @w_operacion,
            @i_banco_real     = @w_banco,
            @i_fecha_liq      = @w_fecha_ini,
            @i_externo        = 'N',
            @i_tasa           = @i_tasa,        --SRO Santander
            @i_dias_desplazados  = @w_dias_desplazados,
	        @i_cuotas_a_desplazar= @w_desplazamiento,
            @i_ejecuta_dia_pago  = @w_ejecuta_dia_pago,
            @i_dia_inicio        = @w_dia_inicio,
            @o_banco_generado = @w_banco_generado out
		    
            if @w_error <> 0 begin
               select @w_sp_name = 'sp_liquida'
               PRINT '7.-x1'
			   goto ERROR
            end
            
            insert into cob_credito..cr_op_renovar
            select * 
            from #cr_op_renovar
            where or_tramite  = @w_tramite
            
            update cob_credito..cr_op_renovar set 
            or_saldo_original = @w_saldo_ant ,
            or_monto_original = @w_tg_monto,
            or_finalizo_renovacion = 'S'
            where or_tramite  = @w_tramite
            
            delete from #cr_op_renovar
	
		end
		
		
		--SRO. DESPLAZAMIENTO		
		if @w_desplazamiento_cuota = 'S' and exists( select 1 from ca_amortizacion where am_operacion = @w_operacion
		and   am_concepto  like '%ESPERA%') begin    
		  
           select @w_div_vigente_desp = di_dividendo 
           from ca_dividendo
           where di_operacion = @w_operacion
           and   di_estado    = 1
           
           update ca_amortizacion set
           am_estado = 0
           where am_operacion = @w_operacion
           and   am_concepto  like '%ESPERA%'
           and   am_dividendo > @w_div_vigente_desp
           
           select @w_secuencial = max(oph_secuencial)
           from ca_operacion_his
           where oph_operacion = @w_operacion
             
           delete ca_amortizacion_his
           where amh_operacion  = @w_operacion
           and   amh_secuencial = @w_secuencial
           and   amh_concepto  like '%ESPERA%'
           
           insert into cob_cartera..ca_amortizacion_his
           select @w_secuencial, *
           from ca_amortizacion
           where am_operacion = @w_operacion
           and   am_concepto  like '%ESPERA%'    	   
		   		   
        end      


        --Actualizar el numero de ciclo del cliente --LPO
        update cobis..cl_ente
        set en_nro_ciclo = isnull(en_nro_ciclo,0) + 1
        where en_ente = @w_tg_cliente

        if @@error <> 0 begin
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
           select @w_error = 70008003
        PRINT '10.-x1'
           goto ERROR
        end

        select @w_monto_garantia = isnull(gl_pag_valor, 0)
        from cob_cartera..ca_garantia_liquida
        where gl_tramite = @i_tramite_grupal
        and   gl_cliente = @w_tg_cliente
        select @w_monto_garantia = isnull(@w_monto_garantia,0)
        
        --Creacion de la garantia liquida
        exec @w_error     = cob_custodia..sp_custodia_automatica
        @s_ssn            = @s_ssn,
        @s_date           = @s_date,
        @s_user           = @s_user,
        @s_term           = @s_term,
        @s_ofi            = @s_ofi,
        @t_trn            = 19090,
        @t_debug          = 'N',
        @i_operacion      = 'L',
        @i_tipo_custodia  = @w_tgarantia_liquida,
        @i_tramite        = @w_tramite,
        @i_valor_inicial  = @w_monto_garantia,
        @i_moneda         = @w_moneda,
        @i_garante        = @w_tg_cliente,
        @i_fecha_ing      = @s_date,
        @i_cliente        = @w_tg_cliente,
        @i_clase          = 'C',
        @i_filial         = @w_filial,
        @i_oficina        = @s_ofi,
        @i_ubicacion      = 'DEFAULT',
        @o_codigo_externo = @w_codigo_externo out

        if @w_error <> 0 begin
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
           select @w_sp_name = 'sp_custodia_automatica'
        PRINT '11.-x1'
           goto ERROR
        end

        if not exists (select 1 from ca_en_fecha_valor where bi_operacion = @w_operacion)
        begin
           insert into ca_en_fecha_valor
           (bi_operacion, bi_banco, bi_fecha_valor, bi_user)
           values
           (@w_operacion, @w_banco, @w_fecha_ini,   @s_user)

           if @@error <> 0
           begin
              select @w_error = 710002
              goto ERROR
           end
        end

        PRINT '11.-x1 - '+ convert(VARCHAR, @w_tg_cliente)
    end -- if @i_etapa_flujo = 'FIN'
	
   SIGUIENTE_REN:
end -- while

/**********SE TOMA DE LO ENTEGADO EN DEV2, VALIDAR SI ES PARTE DEL CASO DE DIAS DE GRACIA**********/
if @i_etapa_flujo = 'IMP'
BEGIN
    --Llamado al sp que actualiza los datos del Prestamo Grupal sumando la informacion de las Operaciones Individuales
    exec @w_error     = cob_cartera..sp_actualiza_grupal
         @i_banco     = @w_op_banco_grupal,
         @i_desde_cca = 'N' -- N = tablas definitivas

    if @w_error <> 0
    begin
       select @w_sp_name = 'sp_actualiza_grupal'
       PRINT '15.-x1'
       goto ERROR
    end
end
/*******************************/

if @i_etapa_flujo = 'FIN'
begin
    --- ESTADOS DE CARTERA
    exec @w_error     = sp_estados_cca
    @o_est_cancelado  = @w_est_cancelado out

    if @w_error <> 0 begin
       select @w_sp_name = 'sp_estados_cca'
       PRINT '12.-x1'
       goto ERROR
    end
	
	
	select @w_sum_total_saldo = isnull(sum(or_saldo_original),0)
	from cob_credito..cr_op_renovar
	where or_referencia_grupal =@w_op_banco_grupal
	
	update cob_credito..cr_op_renovar set 
	or_saldo_original = @w_sum_total_saldo
	where or_tramite = @i_tramite_grupal
	and or_num_operacion = @w_op_banco_grupal
	
	 if @@error <> 0 begin
       select @w_error = 705036
       PRINT '13.-x1'
       goto ERROR
    end


    update ca_operacion set 
	op_estado             = @w_est_cancelado,  --CANCELADO-- COLOCAR VARIABLE DE ESTADO DE CARTERA
    op_margen_redescuento = @w_dias_mora  --MTA Actualizacion de la mora para operaciones a desembolsar
    where op_operacion  = @w_operacion_grupal

    if @@error <> 0 begin
       select @w_error = 705036
       PRINT '14.-x1'
       goto ERROR
    end


    -- LPO Mantenimiento de Ciclos
    exec @w_error        = cob_cartera..sp_man_ciclo
    @i_modo              = 'I',
    @i_grupal            = 'S',
    @i_tramite_grupal    = @i_tramite_grupal,
    @i_grupo             = @w_tg_grupo,
    @i_cuenta_aho_grupal = @w_cta_grupal --Cuenta Grupal

    if @w_error <> 0 begin
       select @w_sp_name = 'sp_man_ciclo'
       PRINT '15.-x1'
       goto ERROR
    end

    --Llamado al sp que actualiza los datos del Prestamo Grupal sumando la informacion de las Operaciones Individuales
    exec @w_error     = cob_cartera..sp_actualiza_grupal
         @i_banco     = @w_op_banco_grupal,
         @i_desde_cca = 'N' -- N = tablas definitivas

    if @w_error <> 0
    begin
       select @w_sp_name = 'sp_actualiza_grupal'
       PRINT '16.-x1'
       goto ERROR
    end
	
	
				
   --ACTUALIZAR FECHA FIN  -1 ( PARA QUE NO SALGA EN LAS BUSQUEDAS )  OPERACION VIEJA
   update ca_operacion set 
   op_fecha_fin = dateadd(dd,-1,@w_fecha_proceso)
   where op_banco  = @w_banco_ant
   
   if @@error <> 0 begin 
   select 
   @w_error = 70006,
   @w_msg   = 'ERROR: AL ACTUALIZAR FECHA FIN DE LA OP ANTERIOR '
   GOTO ERROR
   end  

			
end --if @i_etapa_flujo = 'FIN'

    
if @w_commit = 'S' begin
   commit tran  -- Fin atomicidad de la transaccion
   select @w_commit = 'N'
end

return 0

ERROR:
if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

exec cobis..sp_cerror
@t_debug   = 'N',
@t_file    = null,
@t_from    = @w_sp_name,
@i_num     = @w_error,
@i_msg     = @w_msg

return @w_error


GO
