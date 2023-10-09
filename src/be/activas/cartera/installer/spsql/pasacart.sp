/**************************************************************************/
/*    Archivo:                pasacart.sp                                 */
/*    Stored procedure:       sp_pasa_cartera                             */
/*    Base de datos:          cob_cartera                                 */
/*    Producto:               Cartera                                     */
/*    Disenado por:           Fabian de la Torre                          */
/*    Fecha de escritura:     07-19-1996 / Ene 98                         */
/**************************************************************************/
/*                             IMPORTANTE                                 */
/*    Este programa es parte de los paquetes bancarios propiedad de       */
/*    'MACOSA'.                                                           */
/*    Su uso no autorizado queda expresamente prohibido asi como          */
/*    cualquier alteracion o agregado hecho por alguno de sus             */
/*    usuarios sin el debido consentimiento por escrito de la             */
/*    Presidencia Ejecutiva de MACOSA o su representante.                 */
/**************************************************************************/  
/*                                PROPOSITO                               */
/*        Pasar a cartera el tramite de credito                           */
/**************************************************************************/
/*                     MODIFICACIONES                                     */
/*   FECHA        AUTOR                    RAZON                          */
/* 01/00/0000    DESC            Emision Inicial                          */
/* 07/08/2017    ACH      Bandera 'N' por error al desembolsar caso#162288*/
/**************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_pasa_cartera')
    drop proc sp_pasa_cartera
go

---NR.499 Normalizacion Cartera

create proc sp_pasa_cartera (
@s_ofi                  smallint,
@s_user                 login,
@s_date                 datetime,
@s_term                 descripcion,
@s_ssn                  int,
@i_tramite              int,
@i_forma_desembolso           catalogo
)
as declare
@w_sp_name              varchar(30),
@w_return               int,
@w_operacion            int,
@w_banco                cuenta,
@w_monto                money, 
@w_moneda               tinyint, 
@w_fecha_ini            datetime,
@w_fecha_fin            datetime,
@w_fecha_liq            datetime,
@w_tipo                 char(1) ,
@w_oficina              smallint,
@w_siguiente            int,
@w_est_novigente        smallint,
@w_estado               smallint,
@w_dias                 int,
@w_num_oficial          smallint,
@w_filial               tinyint,
@w_cliente              int, 
@w_direccion            int,
@w_operacionca          int,
@w_reestructuracion     char(1),     -- RRB: 02-21-2002 Circular 50
@w_num_reest            int,      -- RRB: 02-21-2002 Circular 50
@w_op_direccion         tinyint,
@w_rowcount             int,
@w_lin_credito          cuenta,
@w_tramite_cupo         int,
@w_fecha_aprob          datetime,
@w_valor_seguros        money,
@w_monto_cre            money,
@w_tipo_tramite         char(1),
@w_periodo_cap          int,
@w_dist_gracia          char(1),
@w_gracia_cap           int,
@w_secuencial           int,
@w_tipo_amortizacion    catalogo,
@w_beneficiario         varchar(64)




---  VARIABLES DE TRABAJO  
select  
@w_sp_name       = 'sp_pasa_cartera',
@w_est_novigente = 0

-- individual no usa lineas de credito
update ca_operacion set op_lin_credito = null where  op_tramite = @i_tramite


select 
@w_operacionca = op_operacion,
@w_fecha_liq   = op_fecha_liq,
@w_monto       = op_monto,
@w_moneda      = op_moneda,
@w_fecha_ini   = op_fecha_ini,
@w_fecha_fin   = op_fecha_fin,
@w_oficina     = op_oficina,
@w_banco       = op_banco,  
@w_cliente     = op_cliente,
@w_estado      = op_estado,
@w_op_direccion = op_direccion,
@w_lin_credito   = op_lin_credito,
@w_tipo_amortizacion = op_tipo_amortizacion,
@w_beneficiario = op_nombre
from  ca_operacion
where op_tramite = @i_tramite

select @w_tipo_tramite = tr_tipo
from cob_credito..cr_tramite
where tr_tramite = @i_tramite

---NR.499 NORMALIZACION ESPECIAL GRACIA
if @w_tipo_tramite = 'M'
begin
 ---EXISTE UN TRAMITE DE NORMALIZACION
 if exists (select 1 
            from cob_credito..cr_gracia_normalizaciones
            where gn_tramite = @i_tramite
            and   gn_gracia_aceptada = 'S'
            and   gn_periodos_gracia_cap > 0)
  begin
     ---HAY  UNA GRACIA NEGOCIADA Y SE DEBE HACER EFECTIVA
     --- BORAR TEMPORALES  POR SI EXISTEN CON DATOS DIFERENTES
    exec @w_secuencial = sp_gen_sec 
         @i_operacion  = @w_operacionca     
     
   select 
   @w_gracia_cap  = isnull(gn_periodos_gracia_cap,0),
   @w_dist_gracia = isnull(gn_dist_gracia,'N')
   from cob_credito..cr_gracia_normalizaciones
   where gn_tramite = @i_tramite
   and   gn_gracia_aceptada = 'S'

   update cob_cartera..ca_operacion
   set  op_dist_gracia = @w_dist_gracia,
        op_gracia_cap  = @w_gracia_cap
   where op_tramite = 	@i_tramite  
   
      exec @w_return = sp_borrar_tmp
      @i_banco  = @w_banco,      
      @s_user   = @s_user,
      @s_term   = @s_term
      
      if @w_return <> 0 goto ERROR
        
         
     ---PASAR A TEMPRALES CON LOS ULTIMOS DATOS    
      exec @w_return      = sp_pasotmp
      @s_term             = @s_term,
      @s_user             = @s_user,
      @i_banco            = @w_banco,
      @i_operacionca      = 'S',
      @i_dividendo        = 'S',
      @i_amortizacion     = 'S',
      @i_cuota_adicional  = 'S',
      @i_rubro_op         = 'S',
      @i_nomina           = 'S'   
      if @w_return <> 0 goto ERROR

      exec @w_return = sp_modificar_operacion_int
      @s_user              = @s_user,
      @s_sesn              = @w_secuencial,
      @s_date              = @s_date,
      @s_ofi               = @s_ofi,
      @s_term              = @s_term,
      @i_tipo_amortizacion = @w_tipo_amortizacion,
      @i_calcular_tabla    = 'S', 
      @i_tabla_nueva       = 'S', 
      @i_salida            = 'N',
      @i_operacionca       = @w_operacionca,
      @i_banco             = @w_banco,
      @i_cuota             = 0
      if @w_return <> 0 goto ERROR
         
      exec @w_return = sp_pasodef
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
      if @w_return <> 0 goto ERROR

      exec @w_return = sp_borrar_tmp
      @i_banco  = @w_banco,      
      @s_user   = @s_user,
      @s_term   = @s_term
      
      if @w_return <> 0 goto ERROR
      
     ---FIN HAY UNA GRACIA NEGOCIADA
  end          
end ---EXISTE UN TRAMITE DE NORMALIZACION

---INC. 117110
---CUANDO UN TRAMITE SE HA DILIGENCIADO CON SEGURO VOLUNTARIO
---HAY CAMPOS DEL TRAMTIE QUE DEBEN SER IGUALES ANTES DE PASAR A CARTERA AL DESEMBOLSO
---POR QUE PRECISAMENTE EN ESTE PUNTO ES DONDE SE ACTAULIZA EL CAMPO FINAL DEL MONTO
---DE LA OPERACION, ESTE CAMPO NO DEBE SER DIFERENTE

---VALOR DE LOS SEGUROS
select @w_valor_seguros = 0
select @w_valor_seguros = isnull(sum(isnull(ps_valor_mensual,0) * isnull(datediff(mm,as_fecha_ini_cobertura,as_fecha_fin_cobertura),0)),0)
from cob_credito..cr_seguros_tramite with (nolock),
     cob_credito..cr_asegurados      with (nolock),
     cob_credito..cr_plan_seguros_vs
where st_tramite           = @i_tramite
and   st_secuencial_seguro = as_secuencial_seguro
and   as_plan              = ps_codigo_plan
and   st_tipo_seguro       = ps_tipo_seguro
and   ps_estado            = 'V'      
and   as_tipo_aseg         = (case when ps_tipo_seguro in(2,3,4) then 1 else as_tipo_aseg end)          

if @w_valor_seguros > 0
begin
   select @w_monto_cre = 0
   select @w_monto_cre = isnull(tr_monto_solicitado,0)  --tr_monto contiene el valor con seguros
   from cob_credito..cr_tramite with (nolock)
   where tr_tramite = @i_tramite
   
   if @w_monto <> @w_monto_cre
   begin
     PRINT 'Diferencias tr_monto_solititado ' +  cast (@w_monto_cre as varchar) + 'op_monto: ' + cast(@w_monto as varchar) + ' Valor Seguros: ' + cast(@w_valor_seguros as varchar)
     select @w_return = 2101231
	 goto ERROR
   end
end
---INC54396  SI LA OBLIGACION POR ALGUN MOTIVO SE PASO YA A ESTADO VIGENTE
---          NO SE PUEDE PASAR POR ESTE PROGRAMA POR QUE SE DANA
if @w_estado = 1
begin
   PRINT 'LA OPERACIONYA SE DESEMBOLSO, NO SE PUEDE PASAR A CARTERA'
   select @w_return = 708152
   goto ERROR
end

if @w_lin_credito is not null
begin
    select @w_tramite_cupo = li_tramite,
           @w_fecha_aprob  = li_fecha_aprob
    from cob_credito..cr_linea
    where li_num_banco = @w_lin_credito
    
    if @w_fecha_aprob is null
    begin
        ---print 'pasacart.sp entro a poner la fecha : ' + cast (@w_tramite_cupo as varchar)
       update cob_credito..cr_linea     
       set li_fecha_aprob = tr_fecha_apr
       from cob_credito..cr_tramite with (nolock),
            cob_credito..cr_linea with (nolock)
       where tr_tramite =  @w_tramite_cupo
       and   tr_tramite = li_tramite
       and   tr_estado = 'A'
       and   tr_tipo   = 'C'
    end
    
end

select @w_direccion = di_direccion
from cobis..cl_direccion
where di_ente = @w_cliente
and di_direccion = @w_op_direccion 

select @w_tipo = pd_tipo 
from cobis..cl_producto
where pd_producto = 7  

/*if not exists (select  1 from   ca_transaccion
                where  tr_operacion = @w_operacionca
                  and  tr_estado    <> 'NCO')
   select @w_banco = convert(varchar(24),@w_operacionca)*/
   

update ca_operacion set 
op_estado = @w_est_novigente,
op_banco  = @w_banco  --- EL NUEVO NUMERO BANCO SE GENERARA EN LA LIQUIDACION
where op_tramite = @i_tramite

if @@error <> 0 
begin
	select @w_return = 710002
	goto ERROR
end

select @w_num_oficial = fu_funcionario
from   cobis..cl_funcionario
where  fu_login = @s_user 
select @w_rowcount = @@rowcount

if @w_rowcount <> 1
begin
	select @w_return = 701051
	goto ERROR
end

---  Creacion de Registro en cl_det_producto  
select @w_dias = datediff(dd, @w_fecha_ini, @w_fecha_fin)
    
exec cobis..sp_cseqnos
@t_from      = @w_sp_name,
@i_tabla     = 'cl_det_producto',
@o_siguiente = @w_siguiente out

delete from cobis..cl_det_producto 
where  dp_cuenta   = @w_banco
and    dp_producto = 7 

if @@error <> 0 
begin
	select @w_return = 710003
	goto ERROR
end

select @w_filial = of_filial
from cobis..cl_oficina
where of_oficina = @w_oficina 

insert into cobis..cl_det_producto (
dp_det_producto, dp_oficina,       dp_producto,
dp_tipo,         dp_moneda,        dp_fecha, 
dp_comentario,   dp_monto,         dp_cuenta,
dp_estado_ser,   dp_autorizante,   dp_oficial_cta, 
dp_tiempo,       dp_valor_inicial, dp_tipo_producto,
dp_tprestamo,    dp_valor_promedio,dp_rol_cliente,
dp_filial,       dp_cliente_ec,    dp_direccion_ec)
values (
@w_siguiente,    @s_ofi,         7, 
@w_tipo,         @w_moneda,      @w_fecha_ini, 
'OP. CREDITO APROBADA',   @w_monto,       @w_banco,
'V',             @w_num_oficial, @w_num_oficial,
@w_dias,         0,              '0',
0,               0,              'T',
@w_filial,       @w_cliente,     @w_direccion)

if @@error <> 0 
begin
	select @w_return = 710001
	goto ERROR
end
    
---  Creacion de Registros de Clientes  
insert into cobis..cl_cliente (
cl_cliente,  cl_det_producto, cl_rol,  cl_ced_ruc,  cl_fecha)
select   
de_cliente,  @w_siguiente,    de_rol,  de_ced_ruc,  @s_date
from    cob_credito..cr_deudores
where   de_tramite   = @i_tramite

if @@error <> 0 
begin
	select @w_return = 710001
	goto ERROR
end

--DESEMBOLSO AUTOMATICO PARA INDIVIDUAL
exec @w_return = sp_borrar_tmp  -- BORAR TEMPORALES
@i_banco  = @w_banco,
--@s_date   = @s_date,
@s_user   = @s_user,
@s_term   = @s_term

if @w_return <> 0  goto ERROR

exec @w_return          = sp_pasotmp
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

if @w_return <> 0  goto ERROR

exec @w_return         = sp_desembolso
     @s_ofi            = @s_ofi,
     @s_term           = @s_term,
     @s_user           = @s_user,
     @s_date           = @w_fecha_liq,
     @i_nom_producto   = 'CCA',
     @i_producto       = @i_forma_desembolso,
     @i_beneficiario   = @w_beneficiario,
     @i_ente_benef     = @w_cliente,
     @i_oficina_chg    = 1,
     @i_banco_ficticio = @w_operacionca,
     @i_banco_real     = @w_banco,
     @i_fecha_liq      = @w_fecha_liq,
     @i_monto_ds       = @w_monto,
     @i_moneda_ds      = 0,
     @i_tcotiz_ds      = 'COT',
     @i_cotiz_ds       = 1.0,
     @i_cotiz_op       = 1.0,
     @i_tcotiz_op      = 'COT',
     @i_moneda_op      = 0,
     @i_operacion      = 'I',
     @i_externo        = 'N'

if @w_return <> 0  goto ERROR


exec @w_return = sp_borrar_tmp
     @s_sesn   = @s_ssn,
     @s_user   = @s_user,
     @s_term   = @s_term,
     @i_banco  = @w_banco
     
if @w_return <> 0  goto ERROR
  
---  LIQUIDACION AUTOMATICA 

if exists(select 1 from cob_cartera..ca_desembolso
   where dm_operacion = @w_operacionca
   and   dm_secuencial > 0
   and   dm_desembolso > 0) 
   and   @w_estado =  @w_est_novigente begin
   
   print '--->Liquidacion'
   print '--->@w_banco: '+ convert(varchar,@w_banco)
  
   exec @w_return      = sp_pasotmp
   @s_term             = @s_term,
   @s_user             = @s_user,
   @i_banco            = @w_banco,
   @i_operacionca      = 'S',
   @i_dividendo        = 'S',
   @i_amortizacion     = 'S',
   @i_cuota_adicional  = 'S',
   @i_rubro_op         = 'S',
   @i_nomina           = 'S'   
   
   if @w_return <> 0  goto ERROR

   
   exec @w_return = sp_liquida
   @s_date           = @s_date,
   @s_ofi            = @s_ofi,
   @s_term           = @s_term,
   @s_user           = @s_user,
   @i_banco_ficticio = @w_operacionca,
   @i_banco_real     = @w_banco,
   @i_fecha_liq      = @w_fecha_liq,
   @i_externo        = 'N'--Caso#162288
   
   if @w_return <> 0  goto ERROR
   
 

   --- Validar si viene reestructurado de cr‚dito y colocar N?mero de reestructuraciones en 0  

   if exists (select 1 from cob_credito..cr_tramite
      where tr_tramite = @i_tramite
      and tr_reestructuracion = 'S')

           update ca_operacion
           set op_reestructuracion = 'S',
               op_numero_reest = 0
           where op_tramite = @i_tramite
   else
           update ca_operacion
           set op_reestructuracion = 'N',
               op_numero_reest = 0
           where op_tramite = @i_tramite


   --- BORAR TEMPORALES  
   exec @w_return = sp_borrar_tmp
   @i_banco  = @w_banco,
   --@s_date   = @s_date,
   @s_user   = @s_user,
   @s_term   = @s_term
   
   if @w_return <> 0  goto ERROR
	 


end

--Actualiza cuenta de la operacion
update cob_cartera..ca_operacion
set op_cuenta = ea_cta_banco
from cobis..cl_ente_aux
where op_operacion = @w_operacionca
and ea_ente = @w_cliente

if @@error <> 0   goto ERROR


-- actualiza el numero de ciclo del cliente
-- LGU-INI 13-oct-2017 actualizar tabla de tramites grupales
update cobis..cl_ente set en_nro_ciclo = isnull(en_nro_ciclo, 0) + 1
where en_ente = @w_cliente

if @@error <> 0   goto ERROR
-- LGU-FIN 13-oct-2017 actualizar tabla de tramites grupales

return 0

ERROR:
return @w_return
GO
