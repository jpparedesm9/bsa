/************************************************************************/
/*	Archivo: 	        bustran.sp                             */
/*	Stored procedure: 	sp_bus_transaccion	        	*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Monica Vidal                     	*/
/*	Fecha de escritura:     Junio-1998  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Permite realizar la busqueda de las transacciones de servicio   */
/*      y o contables (monetaria) realizadas en el sistema.             */ 
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Abril/1998      Monica Vidal    Emision Inicial		        */
/*	Junio/1998      Laura ALvarado  Modificaciones a Consulta Q     */
/*	Octubre/2016    Jorge Salazar   Migracion Cobis Cloud     */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_buscar_transaccion')
    drop proc sp_buscar_transaccion

go
create proc sp_buscar_transaccion (
   @t_trn                smallint    = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_formato_fecha      int         = null,  --PGA 16/06/2000
   @i_tabla              varchar(254)= null,
   @i_codigo             varchar(64) = null,
   @i_tipo               varchar(64) = null,
   @i_login              login       = null,
   @i_oficina            smallint    = null,
   @i_fecha_ingreso1     datetime    = null,
   @i_fecha_ingreso2     datetime    = null,
   @i_secuencial         int         = null,
   @i_cliente            int         = null,
   @i_siguiente          int         = 0
)
as


declare
   @w_return             int,
   @w_opcion	         int,
   @w_error              int,          
   @w_cadena             varchar(64),
   @w_sp_name            varchar(32),  
   @w_conexion           int
 

/*  Captura nombre de Stored Procedure  */
select @w_sp_name  = 'sp_buscar_transaccion',
       @w_conexion = @@spid * 100


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'Q'
begin
   if @i_tabla is null and @i_secuencial is null
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1
   end
end


if @i_operacion = 'S'
begin
   /* BUSCAR OPCION DE BUSQUEDA */
   select @w_opcion = 1000

   if @i_fecha_ingreso1  is not null
   or @i_fecha_ingreso2  is not null select @w_opcion = 6
   if @i_oficina         is not null select @w_opcion = 5
   if @i_login           is not null select @w_opcion = 4
   if @i_tipo            is not null 
   begin
      select @w_opcion = 3
      select @w_cadena = '%' + @i_tipo + '%'
   end
   if @i_cliente         is not null select @w_opcion = 2
   if @i_codigo          is not null select @w_opcion = 1

   select @w_error  = 0

   
   /***********************************************************/
   
   /* CREACION DE TABLA TEMPORAL PARA ALMACENAR DATOS DE BUSQUEDAS */

   delete cu_tmp_transaccion 
   where sesion = @w_conexion

   /* BUSQUEDAS DE GARANTIAS */

   if @w_opcion >4
      print 'Ingrese al menos un criterio de busqueda principal'

   if @w_opcion = 1 
   begin
 
      insert into cu_tmp_transaccion
      select
      'Servicio',ts_secuencial, ts_usuario, 
      ts_fecha,ts_terminal,   ts_oficina,
      ts_tabla,B.valor, ts_varchar18,
      cg_ente,@w_conexion
      from  cu_tran_servicio, cu_cliente_garantia, cobis..cl_tabla A,
      cobis..cl_catalogo B 
      where ts_varchar18 = @i_codigo
      and cg_principal = 'D'
      and ts_clase != 'P'
      and A.tabla = 'cu_servicio'
      and ts_clase = B.codigo
      and A.codigo = B.tabla
      and cg_codigo_externo = ts_varchar18
   end
     
   if @w_opcion = 2 
   begin

      insert into cu_tmp_transaccion
      select
      'Servicio', ts_secuencial, ts_usuario, 
      ts_fecha, ts_terminal,   ts_oficina,
      ts_tabla,B.valor, ts_varchar18,
      cg_ente,@w_conexion
      from  cu_tran_servicio, cu_cliente_garantia,cobis..cl_tabla A,
      cobis..cl_catalogo B 
      where cg_ente = @i_cliente
      and cg_principal = 'D'
      and ts_clase != 'P'
      and A.tabla = 'cu_servicio'
      and ts_clase = B.codigo
      and A.codigo = B.tabla
      and ts_varchar18 = cg_codigo_externo
      and ts_secuencial > 0
      and ts_tipo_transaccion > 0
   end
   
   if @w_opcion = 3 
   begin

      insert into cu_tmp_transaccion
      select
      'Servicio', ts_secuencial, ts_usuario, 
      ts_fecha, ts_terminal,   ts_oficina,
      ts_tabla,B.valor, ts_varchar18,
      cg_ente,@w_conexion
      from cu_tran_servicio, cu_cliente_garantia, cobis..cl_tabla A,
      cobis..cl_catalogo B --(index cl_catalogo_Key)
      where ts_descripcion1 = @i_tipo
      and cg_principal = 'D'
      and ts_clase != 'P'
      and A.tabla = 'cu_servicio'
      and ts_clase = B.codigo
      and A.codigo = B.tabla
      and ts_varchar18 = cg_codigo_externo
      and ts_secuencial > 0
      and ts_tipo_transaccion > 0
   end


   /***ENVIO DE DATOS AL FRONT END **/
--   print 'codigo %1! cadena %2! siguiente %3!', @i_codigo, @w_cadena, @i_siguiente

   set rowcount 20
   select --distinct   pga 7jun2001
   "TIPO DE TRANSACCION" = tipo,
   "SECUENCIAL"          = secuencial,
   "TRANSACCION"         = transaccion,
   "LOGIN"               = usuario, 
   "NOMBRE FUNCIONARIO"  = fu_nombre,
   "TERMINAL"            = terminal,
   "OFICINA"             = of_nombre,
   "FECHA"               = convert(char(10),fecha  ,@i_formato_fecha),
                           tabla,
                           codigo   -- pga 7jun2001
--   from cu_tmp_transaccion, cobis..cl_oficina, cobis..cl_funcionario
   from cu_tmp_transaccion left outer join cobis..cl_funcionario on usuario = fu_login,
        cobis..cl_oficina
   where (codigo = @i_codigo or @i_codigo is null)
   and   (cliente = @i_cliente or @i_cliente is null)
   and   (codigo like @w_cadena or @i_tipo is null)
   and   (usuario    = @i_login or @i_login is null)
   and   (oficina    = @i_oficina or @i_oficina is null)
   and   (fecha      >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null)
   and   (fecha      <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null)
   and   oficina    = of_oficina
   and   secuencial > @i_siguiente
   and sesion = @w_conexion
   order by codigo,secuencial

   if @@rowcount = 0
   begin
      select @w_error = 1
      goto ERROR
   end
end

if @i_operacion = 'Q' --detalle de la transaccion
begin
   select @w_return = 0
   if @i_tabla = 'cu_transaccion'
   begin
      select  
      "Secuencial   " = tr_secuencial,
      "Codigo       " = tr_codigo_externo,
      "Descripcion  " = tr_descripcion,
      "Transaccion  " = tr_tran,
      "Estado       " = substring(tr_estado,1,4),
      "Cod. Valor   " = dtr_codvalor,
      "Valor        " = convert(money,dtr_valor)
      from   cu_det_trn, cu_transaccion
      where  dtr_secuencial = @i_secuencial
      and    dtr_secuencial = tr_secuencial
      and    dtr_codigo_externo = @i_codigo
      and    dtr_codigo_externo = tr_codigo_externo
      group by tr_secuencial,tr_codigo_externo,tr_descripcion,
      tr_terminal,tr_tran, tr_estado,
      dtr_codvalor,dtr_valor
      order by tr_secuencial,tr_codigo_externo,tr_descripcion,
      tr_terminal,tr_tran,tr_estado,
      dtr_codvalor,dtr_valor 

      if @@rowcount = 0
         select @w_return = 1901003
      else 
         select @w_return = 0
   end
   if @i_tabla = 'cu_custodia'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Tipo"   = substring(tipo,1,20),
      "Codigo" = substring(cod_externo,1,20),
      "Estado" = (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y
                        where X.tabla = Y.codigo                            
               and  Y.tabla = 'cu_est_custodia'
               and ts_custodia.estado = X.codigo),
      "F. Ingreso" = convert(varchar(10),fecha_ingreso,103),
      "Valor Actual" = convert(money,valor_inicial),
      "Valor Aceptado" = convert(money,valor_actual),
      "Moneda" = moneda,
      "Instruccion" = substring(instruccion,1,35),
      "Descripcion" = substring(descripcion,1,35),
      "Inspeccionar" = inspeccionar,
      "Periodicidad" = periodicidad, 
      "Almacenera"   = al_nombre,
      "Direccion" = substring(direccion_prenda,1,64),
      "Ciudad"    = substring(ci_descripcion,1,20), --ciudad_prenda,
      "Telefono"  = substring(telefono_prenda,1,15),
      "Cambio de Estado" = convert(varchar(10),fecha_modif,103),
      "Constitucion" = convert(varchar(10),fecha_const,103),
      "Depositario"  = substring(depositario,1,64),
      "F. Modificacion" = convert(varchar(10),fecha_modificacion,103),
      "Usuario crea"    = substring(usuario_crea,1,15),
      "Usuario modifica" = substring(usuario_modifica,1,15),
      "F. Inspeccion" = convert(varchar(10),fecha_insp,103),
      "Oficina Cont"  = oficina_contabiliza,
      "Compartida "   = compartida,
      "Valor Comp " = convert(money,valor_compartida),
      "Valor Accion" = convert(money,valor_accion),
      "No. Acciones" = num_acciones,
      "Cuantia" = cu_cuantia,
      "Valor cuantia" = vlr_cuantia
      from ts_custodia, cobis..cl_ciudad, cu_almacenera, cu_custodia 
      where secuencial = @i_secuencial
      and  cod_externo = @i_codigo  --pga 7jun2001
      and  ciudad_prenda= ci_ciudad 
      and  almacenera = al_almacenera
      and  cu_tipo = tipo
      and  cu_custodia = custodia

      if @@rowcount = 0
         select @w_return = 1901003
   end 
   if @i_tabla = 'cu_almacenera'
   begin
      select
      "Fecha" = convert(varchar(10),fecha,103),
      "Almacenera" = almacenera,
      "Nombre" = substring(nombre,1,35),
      "Direccion" = substring(direccion,1,35),
      "Telefono" = substring(telefono,1,14),
      "Estado"  = estado,
      "Licencia" = substring(licencia,1,14)
      from ts_almacenera
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_control_inspector'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Inspector" = is_nombre,
      "F. envio carta" = convert(varchar(10),fenvio_carta,103),
      "F Recep. Reporte" = convert(varchar(10),frecep_reporte,103),
      "Valor Facturado" = convert(money,valor_facturado),
      "F Pagado" = convert(varchar(10),fecha_pago,103)
      from ts_control_inspector,cu_inspector
      where secuencial = @i_secuencial
      and   is_inspector = inspector
      and   is_tipo_inspector = 'A' --emg
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_cliente_garantia'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Tipo"   = tipo_cust,
      "Codigo" = substring(codigo_externo,1,20),
      "Cliente" = en_nomlar /*,
      "Principal" = principal*/
      from ts_cliente_garantia,cobis..cl_ente
      where secuencial = @i_secuencial
      and   ente   = en_ente
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_inspeccion'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Tipo" = tipo_cust,
      "Codigo" = codigo_externo,
      "Fecha Inspeccion" = convert(varchar(10),fecha_insp,103),
      "Inspector" = is_nombre,
      "Estado" = estado,
      "Factura" = factura,
      "Valor Factura" = convert(money,valor_fact),
      "Observaciones" = observaciones,
      "Instruccion" = instruccion,
      "Motivo" = motivo,
      "Valor Avaluo" = convert(money,valor_avaluo),
      "Estado Tramite" = estado_tramite
      from ts_inspeccion, cu_inspector
      where secuencial = @i_secuencial
      and is_inspector = inspector
      and is_tipo_inspector = 'A' --emg
      if @@rowcount = 0
         select @w_return  =1901003
   end
   if @i_tabla = 'cu_inspector'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Inspector" = inspector,
      "Cta. Inspector" = substring(cta_inspector,1,20),
      "Especialidad"   = B.valor,
      "Direccion"      = substring(direccion,1,35),
      "Telefono"       = substring(telefono,1,14),
      "Principal"      = substring(principal,1,20),
      "Cargo"          = substring(cargo,1,15),
      "Ciudad"         = substring(ci_descripcion,1,25),
      "Regional"       = regional
      from ts_inspector, cobis..cl_ciudad, cobis..cl_tabla A,
      cobis..cl_catalogo B
      where secuencial = @i_secuencial
      and   ciudad     = ci_ciudad
      and   especialidad = B.codigo
      and   A.tabla      = 'cu_esp_inspector'
      and   A.codigo     = B.tabla 
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_poliza'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Codigo"     = codigo_externo,
      "Aseguradora"= aseguradora,
      "Poliza"     = poliza,
      "Moneda"     = moneda,
      "Cobertura"  = cobertura,
      "Detalle"    = substring(detalle,1,35),
      "Monto Poliza" = monto_poliza,
      "F. V. Poliza Inicio" = convert(varchar(10),fecha_venc1,103),
      "F. V. Poliza Fin" = convert(varchar(10),fecha_venc2,103),
      "Monto Endoso" = monto_endozo,
      "F. Endoso Inicio" = convert(varchar(10),fecha_endozo,103),
      "F. Endoso Fin" = convert(varchar(10),fendozo_fin,103)
      from ts_poliza, cobis..cl_tabla A, cobis..cl_catalogo B,
      cobis..cl_tabla C, cobis..cl_catalogo D
      where secuencial = @i_secuencial
      and   aseguradora = B.codigo
      and   A.tabla     = 'cu_des_aseguradora'
      and   cobertura   = D.codigo
      and   C.tabla     = 'cu_cob_poliza'
      and   A.codigo    = B.tabla
      and   C.codigo    = D.tabla
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_item'
   begin
      select
      "Secuencial"        = secuencial,
      "Fecha"             = convert(varchar(10),fecha,103),
      "Tipo "             = tipo_custodia,
      "Item"              = item,
      "Nombre Item"       = substring(nombre,1,35),
      "Descripcion Item" = substring(detalle,1,35)
      from ts_item
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_item_custodia'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Tipo "      = tipo_cust,
      "Codigo"     = codigo_externo,
      "Item"       = item,
      "Descripcion Item" = substring(valor_item,1,35),
      "Secuencia"  = secuencia
      from ts_item_custodia
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_recuperacion'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Tipo "      = tipo_cust,
      "Codigo"     = substring(codigo_externo,1,20),
      "Vencimiento"= vencimiento,
      "Recuperacion"= recuperacion,
      "Valor" = convert(money,valor),
      "Fecha Recuperacion" = convert(varchar(10),fecha_rec,103)
      from ts_recuperacion
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_tipo_custodia'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Tipo Superior" = tipo_superior,
      "Tipo"       = tipo,
      "Descripcion"   = substring(descripcion,1,35),
      "Periodicidad"  = periodicidad,
      "Contabilizar"  = contabilizar,
      "Monetaria   "  = monetaria,
      "Tipo bien   "  = tipo_bien
      from ts_tipo_custodia
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_vencimiento'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Codigo" = substring(codigo_externo,1,20),
      "Tipo"  = substring(tipo_cust,1,30),
      "No. vencimiento" = vencimiento,
      "Fecha vencimiento" = convert(varchar(10),fecha_ven,103),
      "Valor Documento" = convert(money,valor),
      "Instruccion" = substring(instruccion,1,35)
      from ts_vencimiento
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_por_inspeccionar'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Tipo "      = substring(tipo_cust,1,20),
      "Custodia"   = custodia,
      "Estado"     = status,
      "Inspector"  = inspector_asignado,
      "Fecha Asig" = convert(varchar(10),fecha_asignacion,103),
      "Estado Ant" = estado_anterior,
      "Inspector Ant" = inspector_anterior,
      "Fecha Ant." = convert(varchar(10),fecha_anterior,103)
      from ts_por_inspeccionar
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_control_abogado'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Abogado" = abogado,
      "F. envio carta" = convert(varchar(10),fenvio_carta,103),
      "F Recep. Reporte" = convert(varchar(10),frecep_reporte,103),
      "Valor Facturado" = convert(money,valor_facturado),
      "Valor Pagado"    = convert(money,valor_pagado),
      "F Pagado" = convert(varchar(10),fecha_pago,103)
      from ts_control_abogado
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_resul_abg'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha"      = convert(varchar(10),fecha,103),
      "Codigo"     = substring(codigo_externo,1,20),
      "Tipo"       = substring(tipo_cust,1,20),
      "Abogado"    = abogado,
      "Tipo Asig"  = tipo_asig,
      "F. Envio Carta"= convert(varchar(10),fecha_envio,103),
      "F. Recepcion"= convert(varchar(10),fecha_recep,103),
      "F. Concepcion"= convert(varchar(10),fecha_concep,103),
      "F. Cobro"= convert(varchar(10),fecha_cobro,103),
      "Suficiencia Legal" = sufici_legal,
      "Cobro Juridico" = cobro_juridico,
      "Factura"           = factura,
      "Valor Factura"     = convert(money,valor_fact),
      "Observaciones"     = substring(observaciones,1,35),
      "Instruccion  "     = substring(instruccion,1,35)
      from ts_resul_abg
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end
   if @i_tabla = 'cu_gar_abogado'
   begin
      select
      "Secuencial" = secuencial,
      "Fecha" = convert(varchar(10),fecha,103),
      "Tipo"   = substring(tipo,1,20),
      "Codigo" = substring(codigo_externo,1,20),
      "Fecha Ant." = convert(varchar(10),fecha_ant,103),
      "Abogado Ant." = abogado_ant,
      "Fecha Asig." = convert(varchar(10),fecha_asig,103),
      "Abogado Asig." = abogado_asig,
      "F. Envio Carta" = convert(varchar(10),fenvio_carta,103),
      "Recepcion Reporte" = convert(varchar(10),frecep_reporte,103)
      from ts_gar_abogado
      where secuencial = @i_secuencial
      if @@rowcount = 0
         select @w_return = 1901003
   end

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num = @w_return
      return 1
   end
end

return 0
ERROR:

return 1 
go

