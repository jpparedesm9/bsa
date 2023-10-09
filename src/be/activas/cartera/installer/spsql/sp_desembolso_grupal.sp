/*************************************************************************/
/*   Archivo             :       sp_desembolso_grupal.sp                 */
/*   Stored procedure    :       sp_desembolso_grupal                    */
/*   Base de datos       :       cob_cartera                             */
/*   Producto            :       Cartera                                 */
/*   Disenado por        :       Fabian de la Torre                      */
/*   Fecha de escritura  :       Mar 2017                                */
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
/*************************************************************************/
/*                          MODIFICACIONES                               */
/*   Jorge Salazar            22/Mar/2017    CGS-H105594                 */
/*   Luis Ponce               12/Abr/2017    Cambios Santander CR.Grupal */
/*   Jorge Salazar            19/May/2017    CGS-S112643                 */
/*   LGU                      13/Jul/2017    Ejecutar en dos partes      */
/*                                           1) Crear OP                 */
/*                                           2) Crear DES y LIQ          */
/*   DCU                      26/11/2019     Validar producto habilitado */
/*   Dario Cumbal             29/04/2020     Caso. 138887                */
/*   Dario Cumbal             22/10/2020     Caso: 147552                */
/*   Sonia Rojas              17/09/2020     Req #140073                 */
/*   Dario Cumbal             12/10/2022     Req. #195239                */
/*   Dario Cumbal             12/11/2022     Req. #194284                */
/*************************************************************************/
USE cob_cartera
GO

IF OBJECT_ID ('dbo.sp_desembolso_grupal') IS NOT NULL
    DROP PROCEDURE dbo.sp_desembolso_grupal
GO

create proc sp_desembolso_grupal
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
@w_desplazamiento         int,
@w_param_oferta_producto  char(1),
@w_promocion              char(1),
@w_porcentaje_monto_grp   float,
@w_porcentaje_monto_ind   float,
@w_porcentaje_monto_ani   float,
@w_fecha_dispersion       datetime,
@w_dia_pago               datetime,
@w_periodo_int            int,
@w_fecha_ini_tmp          datetime,
@w_dia_inicio             int,
@w_ejecuta_dia_pago       char(1)
 
select @w_ejecuta_dia_pago = 'N'
-- VARIABLES INICIALES
select
@w_sp_name = 'sp_desembolso_grupal',
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

if @w_param_oferta_producto = 'S'  select @w_dias_desplazados = 7 * @w_desplazamiento --Semanal

-- Plazo en dias
select @w_dias_plazo = td_factor
from ca_tdividendo
where td_tdividendo = @w_tplazo

select @w_plazo_en_dias = isnull(@w_plazo * @w_dias_plazo,0)

-- Inicializar acumulador montos garantias
select
@w_monto_total          = 0

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
	END
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

            DELETE cob_credito..cr_tramite         WHERE tr_tramite   = @w_tramite      and @w_tramite      <> @i_tramite_grupal
            DELETE cob_cartera..ca_operacion       WHERE op_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_rubro_op        WHERE ro_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_dividendo       WHERE di_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_amortizacion    WHERE am_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_cuota_adicional WHERE ca_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_credito..cr_documento       WHERE do_tramite   = @w_tramite      and @w_tramite      <> @i_tramite_grupal

            DELETE cob_cartera..ca_valores           WHERE va_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_definicion_nomina WHERE dn_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
            DELETE cob_cartera..ca_relacion_ptmo     WHERE rp_pasiva    = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal
			DELETE cob_cartera..ca_otro_cargo        where oc_operacion = @w_tg_operacion and @w_tg_operacion <> @w_operacion_grupal

            select @w_tramite = 0
            UPDATE cob_credito..cr_documento      SET do_numero = 0 WHERE do_tramite   = @i_tramite_grupal

       END

	   IF @w_tg_monto > 0 -- CREAR LA OPERACION
	   BEGIN
	       -- Creacion de operaciones por socio
	       exec @w_error     = cob_cartera..sp_crear_prestamo
	       @s_srv            = @w_servidor,
	       @s_user           = @s_user,
	       @s_term           = @s_term,
	       @s_ofi            = @s_ofi,
	       @s_rol            = @s_rol,
	       @s_ssn            = @s_ssn,
	       @s_lsrv           = @w_servidor,
	       @s_date           = @s_date,
	       @s_sesn           = @s_sesn,
	       @i_tipo           = @w_tipo,
	       @i_tramite        = 0,
	       @i_cliente        = @w_tg_cliente,
	       @i_nombre         = @w_nombre,
	       @i_codeudor       = 0,
	       @i_sector         = @w_sector,
	       @i_toperacion     = @w_toperacion,
	       @i_oficina        = @w_op_oficina,
	       @i_moneda         = @w_moneda,
	       @i_comentario     = @w_grupo_comentario,
	       @i_oficial        = @w_oficial,
	       @i_fecha_ini      = @w_fecha_ini,
	       @i_monto          = @w_tg_monto,
	       @i_monto_aprobado = @w_tg_monto,
	       @i_destino        = @w_op_destino,
	       @i_ciudad         = @w_op_ciudad,
	       @i_cuenta         = @w_tg_cuenta, --LPO cuenta individual de la cual se haran los debitos (en los pagos)
	       @i_clase_cartera  = @w_clase_cartera,
	       @i_numero_reest   = 0,
	       @i_num_renovacion = 0,
	       @i_grupal         = @i_grupal,
	       @i_tasa           = @i_tasa,
	       @i_banca          = @w_banca,
	       @t_trn            = 77100,
	       @i_forma_pago     = @i_forma_pago,
	       @i_plazo             = @w_plazo ,
	       @i_dias_desplazados  = @w_dias_desplazados,
	       @i_desplazamiento = @w_desplazamiento,
	       @i_dia_inicio     = @w_dia_inicio,
	       @i_ejecuta_dia_pago = @w_ejecuta_dia_pago,
	       @o_operacion      = @w_operacion out,
	       @o_banco          = @w_banco out,
	       @o_tramite        = @w_tramite out
	
	       if @w_error <> 0 begin
	          select @w_sp_name = 'sp_desembolso_grupal'
	          PRINT '1.1.-x1'
	          goto ERROR
	       END
	       
	       IF @w_operacion IS NULL OR @w_banco IS NULL 
	       BEGIN
	          PRINT '1.1.- OP_BANCO NULO !!'
	          select @w_sp_name = 'sp_desembolso_grupal_1'
	          SELECT @w_error = 710568
	          goto ERROR
	       END
	       -- Actualizacion Operacion HIJA
	        update cob_credito..cr_tramite_grupal set
	            tg_operacion   = @w_operacion,
	            tg_prestamo    = @w_banco
	        where tg_tramite   = @i_tramite_grupal
	        and   tg_cliente   = @w_tg_cliente
	        and   tg_grupal    = 'S'
	
	        if @@error <> 0 begin
	           select @w_error = 710568
	           PRINT '1.2.-x1'
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
	           goto ERROR
	        END
			
        END -- IF @w_tg_monto > 0 -- CREAR LA OPERACION
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
	    
        select
            @w_tramite = op_tramite,
            @w_banco   = op_banco
        from ca_operacion
        where op_operacion = @w_operacion

        exec @w_error  = sp_borrar_tmp
        @s_sesn   = @s_sesn,
        @s_user   = @s_user,
        @s_term   = @s_term,
        @i_banco  = @w_banco

        if @w_error <> 0 begin
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
           select @w_sp_name = 'sp_borrar_tmp'
        PRINT '2.-x1'
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
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
           select @w_sp_name = 'sp_pasotmp'
        PRINT '3.-x1'
           goto ERROR
        end

        -- Montos de garantias individuales y garantia total
        select @w_monto_garantia = @w_tg_monto * @w_porc_garantia / 100

        
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
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
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
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
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
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
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
           --close cur_cr_tramite_grupal
           --deallocate cur_cr_tramite_grupal
           select @w_sp_name = 'sp_liquida'
        PRINT '7.-x1'
           goto ERROR
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
End
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

    update ca_operacion
    set op_estado             = @w_est_cancelado,  --CANCELADO-- COLOCAR VARIABLE DE ESTADO DE CARTERA
        op_margen_redescuento = @w_dias_mora  --MTA Actualizacion de la mora para operaciones a desembolsar
    where op_operacion  = @w_operacion_grupal

    if @@error <> 0 begin
       select @w_error = 705036
       PRINT '13.-x1'
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
       PRINT '14.-x1'
       goto ERROR
    end

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
@i_num     = @w_error

return @w_error


GO

