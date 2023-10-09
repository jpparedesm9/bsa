/***********************************************************************/
/*      Archivo:                        cr_ricl.sp                     */
/*      Stored procedure:               sp_riesgo_icl                  */
/*      Base de Datos:                  cob_credito                    */
/*      Producto:                       Credito                        */
/*      Disenado por:                   Myriam Davila                  */
/*      Fecha de Documentacion:         27/Sep/95                      */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      'MACOSA',representantes exclusivos para el Ecuador de la       */
/*      AT&T                                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier autorizacion o agregado hecho por alguno de sus      */
/*      usuario sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante             */
/***********************************************************************/
/*                      PROPOSITO                                      */
/*      Este stored procedure permite realizar una consulta de         */
/*      los riesgos de un cliente si mandamos el parametro @i_cliente  */
/*      o el riesgo del grupo si mandamos el parametro @i_grupo y  el  */
/*      parametro  @i_cliente va en nulo                               */
/***********************************************************************/  
/*                      MODIFICACIONES                                 */
/*      FECHA           AUTOR                   RAZON                  */
/* 24/Ago/98       Tatiana Granda          Adaptaci�n Bco Estado       */
/* 14/oct/04       Luis Ponce              Optimizacion                */
/* 29/jul/05       Martha Gil V            Consultar parametro         */
/*                                         para incluir o no el        */
/*                                         riesgo indirecto,           */
/*                                         incluir avalista            */
/***********************************************************************/
use cob_credito
go
if exists (SELECT 1 FROM sysobjects WHERE name = 'sp_riesgo_icl')
   drop proc sp_riesgo_icl
go                               

create proc sp_riesgo_icl (
   @s_date              datetime    = null,
   @t_debug             char(1)     = 'N',
   @t_file              varchar(14) = null,
   @i_cliente           int         = null,
   @i_tramite           int         = null,
   @i_modo              tinyint     = null,
   @i_tipor             varchar(12) = null,
   @i_producto          catalogo    = null,
   @i_toperacion        catalogo    = null,
   @i_tramites          char(1)     = 'S', --ENVIAR INFORMACION DE TRAMITES
   @i_detalle           char(1)     = 'S',
   @i_aprobado          char(1)     = 'N', --ENVIAR SOLO TRAMITES APROBADOS O NO
   @i_indirecto         char(1)     = 'S', --ENVIAR RIESGO DIRECTO O INDIRECTO
   @i_ind_tr            char(1)     = 'S',
   @i_interes           char(1)     = 'S', --SUMAR INTERES AL RIESGO
   @i_tipo_ctz          char(1)     = 'B',  --C COTIZACION DE CREDITO, B CONTABILIDAD
   @i_grupo             int         = null,
   @i_rol               char(1)     = null,
   @i_tipo_op           char(1)     = null,
   @i_banco             varchar(24) = null
)
as
declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_return             int,          /* VALOR QUE RETORNA */
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_tipo               descripcion,
   @w_estado             varchar(30),
   @w_est_vencido        tinyint,
   @w_conexion           int,
   @w_garper             varchar(30),
   @w_rowcount           int
   
select @w_today    = @s_date
select @w_sp_name  = 'sp_riesgo_icl'
select @w_conexion = @@spid

delete from cr_cliente_ricl
where  cl_idconn = @w_conexion
delete from cr_ope_ricl
where  op_idconn = @w_conexion
delete from cr_previa_ricl
where  pr_idconn = @w_conexion

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_cliente is null and @i_grupo is null
begin
   /* CAMPOS NOT NULL CON VALORES NULOS */
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = 2101001
   return 1 
end

-- Consultar parametro para incluir o no el riesgo indirecto
-- MGV 29/jul/2005
select @i_indirecto  = pa_char
   FROM cobis..cl_parametro
   WHERE pa_nemonico  = 'RIESIN'    
   and   pa_producto  = 'CRE'
select @w_rowcount = @@rowcount
set transaction isolation level READ UNCOMMITTED
   
if @i_indirecto is null or @w_rowcount = 0
BEGIN
   /* Error, no existe valor de Parametro */
   SELECT @w_return = 2101084
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return,
        @i_msg   = 'Parametro RIESGO No Definido'
   return @w_return
END

/* LLENAR TABLA TEMPORAL DE CLIENTES */
if @i_cliente is not null
begin
   INSERT INTO cr_cliente_ricl (
   cl_idconn, cl_cliente, cl_tipo )
   values(
   @w_conexion,@i_cliente, 'C')
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name,
      @i_num    = 2103036
      return 1 
   end

   SELECT @i_grupo = en_grupo
   FROM cobis..cl_ente
   WHERE en_ente = @i_cliente
   set transaction isolation level read uncommitted
end

/* INSERTAR REGISTROS DE LOS MIEMBROS DEL GRUPO */
if @i_grupo is not null and @i_grupo > 0
begin
   INSERT INTO cr_cliente_ricl (
   cl_idconn, cl_cliente, cl_tipo )
   SELECT
   @w_conexion,en_ente, 'G'
   FROM cobis..cl_ente,cobis..cl_cliente_grupo
   WHERE cg_grupo = @i_grupo
   and   cg_ente  = en_ente
   and   cg_ente <> @i_cliente
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name,
      @i_num    = 2103036 
      return 1 
   end
end

/* INSERTAR REGISTROS DE RELACIONADOS */
INSERT INTO cr_cliente_ricl (
cl_idconn ,           cl_cliente,              cl_tipo )
SELECT 
distinct @w_conexion, convert(int,in_ente_d), 'R'
FROM cobis..cl_instancia
WHERE convert(char(10),in_relacion) in (SELECT c.codigo FROM cobis..cl_tabla t, cobis..cl_catalogo c
                                        WHERE t.tabla = 'cr_relaciones'
                                        and   c.estado = 'V'
                                        and   t.codigo = c.tabla)    
and   in_ente_i   = @i_cliente 
                              
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 2103036
   return 1 
end

/* ELIMINAR CLIENTES DUPLICADOS */
/* ELIMINAR R Y E QUE HAYAN SIDO INGRESADOS COMO CLIENTES Y MIEMBROS DE GRUPO*/
DELETE cr_cliente_ricl
WHERE cl_idconn = @w_conexion
and   cl_tipo in ('R','E')
and   cl_cliente in (SELECT cl_cliente
                     FROM cr_cliente_ricl
                     WHERE cl_idconn = @w_conexion
                     and   cl_tipo in ('G','C'))
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107015
   return 1             
end

/* ELIMINAR E QUE HAYAN SIDO INGRESADOS COMO RELACIONADOS CON EL CLIENTE */
DELETE cr_cliente_ricl
WHERE cl_idconn = @w_conexion
and   cl_tipo = 'E'
and   cl_cliente in (SELECT cl_cliente
                     FROM  cr_cliente_ricl
                     WHERE cl_idconn = @w_conexion
                     and   cl_tipo = 'R')
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107015  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMP DE CLIENTE */
   return 1             
end

/*  LLENAR LOS DATOS DE OPERACIONES DONDE LOS CLIENTES SON DEUDORES */
INSERT INTO cr_ope_ricl
( op_idconn,                 op_operacion,                                                           op_banco,                  op_toperacion,
  op_producto,               op_abreviatura,                                                         op_tipo_riesgo,            op_saldo_cap,              
  op_saldo_otr,              op_saldo_int,                                                           op_disponible,             op_estado,                 
  op_tramite,                op_estado_tr,                                                           op_tipo_cl,                op_rol_cl )
SELECT                                                                                               
  @w_conexion,               do_numero_operacion,                                                    do_numero_operacion_banco, do_tipo_operacion,
  do_codigo_producto,        null,                                                                   null,                      do_saldo_cap*cv_valor,       
  do_saldo_otros*cv_valor,   (isnull(do_saldo_int,0) + isnull(do_saldo_int_contingente,0))*cv_valor,  0,                        do_estado_contable,        
  'N',                       'A',                                                                     cl_tipo,                   'D'
FROM cr_cliente_ricl, cr_dato_operacion x,
     cob_conta..cb_vcotizacion
WHERE do_tipo_reg = 'D'
and   do_codigo_cliente = cl_cliente
and   do_estado_contable in (1,2)       
and   cl_idconn = @w_conexion
and   cv_moneda = do_moneda
and   cv_fecha = (SELECT max(cv_fecha)
                  FROM cob_conta..cb_vcotizacion
                  WHERE cv_fecha <= @s_date
                  and x.do_moneda = cv_moneda)
if @@error != 0
begin
   exec cobis..sp_cerror
     @t_from   = @w_sp_name, 
     @i_num    = 2103037  /* ERROR INSERTANDO DATOS EN TABLA TEMPORAL DE OPERACIONES */
   return 1             
end
   
/*  LLENAR LAS OPERACIONES DONDE LOS CLIENTES SON 'CODEUDORES' PARA PRODUCTOS COBIS */
INSERT INTO cr_ope_ricl (
  op_idconn,                           op_operacion,                                                          op_banco,                    op_toperacion,
  op_producto,                         op_abreviatura,                                                        op_tipo_riesgo,              op_saldo_cap, 
  op_saldo_otr,                        op_saldo_int,                                                          op_disponible,               op_estado, 
  op_tramite,                          op_estado_tr,                                                          op_tipo_cl,                  op_rol_cl )
SELECT                                                                                                        
  @w_conexion,                         do_numero_operacion,                                                   do_numero_operacion_banco,   do_tipo_operacion,
  do_codigo_producto,                  null,                                                                  null,                        do_saldo_cap*cv_valor,         
  do_saldo_otros*cv_valor,            (isnull(do_saldo_int,0) + isnull(do_saldo_int_contingente,0))*cv_valor, 0,                           do_estado_contable,          'N',
  'A',                                 cl_tipo,                                                               de_rol
FROM cr_cliente_ricl, 
     cr_tramite, cr_deudores, cr_dato_operacion x,
     cob_conta..cb_vcotizacion, cobis..cl_producto
WHERE de_cliente     = cl_cliente
  and   de_rol  in ( 'C', 'S', 'A')  -- CODEUDOR
  and   de_tramite   = tr_tramite
  and   tr_numero_op = do_numero_operacion
  and   tr_producto  = pd_abreviatura
  and   cl_idconn    = @w_conexion
  and   pd_producto  = do_codigo_producto
  and   do_tipo_reg  = 'D'
  and   do_estado_contable in (1,2)
  and   cv_moneda    = do_moneda
  and   cv_fecha     = (SELECT max(cv_fecha)
                        FROM cob_conta..cb_vcotizacion
                        WHERE cv_fecha   <= @s_date
                        and x.do_moneda = cv_moneda)

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2103037  /* ERROR INSERTANDO DATOS EN TABLA TEMPORAL DE OPERACIONES */
   return 1             
end


/* LLENAR LAS OPERACIONES DONDE LOS CLIENTES SON 'CODEUDORES' PARA PRODCUTOS NO COBIS */
INSERT INTO cr_ope_ricl (
  op_idconn ,                             op_operacion,                                                           op_banco,                  op_toperacion,
  op_producto,                            op_abreviatura,                                                         op_tipo_riesgo,            op_saldo_cap,                           
  op_saldo_otr,                           op_saldo_int,                                                           op_disponible,             op_estado,      
  op_tramite,                             op_estado_tr,                                                           op_tipo_cl,                op_rol_cl )
SELECT                                                                                                            
  @w_conexion,                            do_numero_operacion,                                                    do_numero_operacion_banco, do_tipo_operacion,
  do_codigo_producto,                     null,                                                                   null,                      do_saldo_cap*cv_valor,          
  do_saldo_otros*cv_valor,                (isnull(do_saldo_int,0) + isnull(do_saldo_int_contingente,0))*cv_valor, 0,                         do_estado_contable,        
  'N',                                    'A',                                                                    a.cl_tipo,                 'C'
FROM cr_cliente_ricl a, 
     cobis..cl_cliente_no_cobis b, 
     cobis..cl_det_producto_no_cobis,
     cr_dato_operacion x,          
     cob_conta..cb_vcotizacion
WHERE b.cl_cliente        = a.cl_cliente
and   b.cl_rol            = 'C'  -- CODEUDOR
and   dp_det_producto     = b.cl_det_producto
and   do_tipo_reg         = 'D'
and   cl_idconn           = @w_conexion
and   do_codigo_producto  = dp_codigo_producto
and   do_numero_operacion = dp_numero_operacion
and   do_estado_contable in (1,2)
and   cv_moneda = do_moneda
and   cv_fecha  = (SELECT max(cv_fecha)
                   FROM cob_conta..cb_vcotizacion
                   WHERE cv_fecha <= @s_date
                   and x.do_moneda = cv_moneda) 

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2103037  /* ERROR INSERTANDO DATOS EN TABLA TEMPORAL DE OPERACIONES */
   return 1   
end

/* LLENAR LA TABLA TEMPORAL CON LOS TRAMITES DE OPERACI0NES ESPECIFICAS */
/* EN PROCESO, DE LOS CLIENTES QUE ESTAN EN LA TABLA TEMPORAL cr_cliente_ricl */
INSERT INTO cr_ope_ricl (
  op_idconn,                            op_operacion,                      op_banco,                         op_toperacion,
  op_producto,                          op_abreviatura,                    op_tipo_riesgo,                   op_saldo_cap,  
  op_saldo_int,                         op_saldo_otr,                      op_disponible,                    op_estado, 
  op_tramite,                           op_estado_tr,                      op_tipo_cl,                       op_rol_cl )
SELECT
  @w_conexion,                          tr_tramite,                        convert(varchar(24),tr_tramite),  tr_toperacion,
  21,                                  'TRA',                              null,                             0,               
  0,                                    0,                                 (tr_monto * cv_valor),            1,                                
  'S',                                  tr_estado,                         cl_tipo,                          'D'
FROM cr_cliente_ricl, 
     cr_tramite x, 
     cob_cartera..ca_operacion,
     cob_conta..cb_vcotizacion
WHERE tr_cliente   = cl_cliente
and   tr_tipo      in('O','R')
and   tr_estado    not in ('Z','X','R','S')  -- NO HAN SIDO RECHAZADAS DEFINITIVAMENTE
and   op_estado    in (0,99)
and   tr_tramite   = op_tramite
and   op_naturaleza= 'A'
and   cl_idconn    = @w_conexion
and   cv_moneda    = tr_moneda
and   cv_fecha = (SELECT max(cv_fecha)
                 FROM   cob_conta..cb_vcotizacion
                 WHERE  cv_moneda = x.tr_moneda
                 and cv_fecha <= @s_date)
 
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2103037  /* ERROR INSERTANDO DATOS EN TABLA TEMPORAL DE OPERACIONES */
   return 1  
end

/* LLENAR LA TABLA TEMPORAL CON LOS TRAMITES DE OPERACI0NES ESPECIFICAS */
/* EN PROCESO, DE LOS CLIENTES QUE ESTAN EN LA TABLA TEMPORAL cr_cliente_ricl */
/* Y SON CODEUDORES                           */
INSERT INTO cr_ope_ricl (
op_idconn,                         op_operacion,                      op_banco,                          op_toperacion,
op_producto,                       op_abreviatura,                    op_tipo_riesgo,                    op_saldo_cap,  
op_saldo_int,                      op_saldo_otr,                      op_disponible,                     op_estado, 
op_tramite,                        op_estado_tr,                      op_tipo_cl,                        op_rol_cl )
SELECT                                                                                                   
@w_conexion,                       tr_tramite,                        convert(varchar(24),tr_tramite),   tr_toperacion,
21,                                'TRA',                             null,                              0,                 
0,                                 0,                                 (tr_monto * cv_valor),             1,                                  
'S',                               tr_estado,                          cl_tipo,                          de_rol
FROM    cr_cliente_ricl, 
        cr_tramite x, 
        cr_deudores,
        cob_cartera..ca_operacion,
        cob_conta..cb_vcotizacion
WHERE de_cliente  = cl_cliente  --SPO COrrecion de Informacion
and   tr_tipo     in('O','R')
and   tr_estado   not in ('Z','X','R','S')  -- NO HAN SIDO RECHAZADAS DEFINITIVAMENTE
and   tr_tramite   = op_tramite
and   op_naturaleza= 'A'
and   de_tramite   = op_tramite
and   de_tramite   = tr_tramite
and   op_estado   in (0,99)
and   cl_idconn    = @w_conexion
and   cv_moneda    = tr_moneda
and   de_rol      in ('C', 'S', 'A')
and   cv_fecha = (SELECT max(cv_fecha)
                 FROM   cob_conta..cb_vcotizacion
                 WHERE  cv_moneda = x.tr_moneda
                 and cv_fecha <= @s_date)

 
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2103037  /* ERROR INSERTANDO DATOS EN TABLA TEMPORAL DE OPERACIONES */
   return 1  
end

/* ELIMINAR OPERACIONES QUE SE HAN DUMPLICADO CON LAS DEL CLIENTE */
DELETE cr_ope_ricl
WHERE op_idconn = @w_conexion
and   op_tipo_cl in ('G','R','E')
and (op_banco + '-' + convert(varchar(3),op_producto)) in 
    (SELECT(op_banco + '-' + convert(varchar(3),op_producto))
     FROM cr_ope_ricl
     WHERE op_idconn = @w_conexion
     and   op_tipo_cl = 'C')

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1             
end

/* ELIMINAR OPERACIONES DE RELACIONADOS QUE SE HAN DUPLICADO CON LAS DE GRUPO */
DELETE cr_ope_ricl
WHERE op_idconn = @w_conexion
and   op_tipo_cl in ('R','E')
and (op_banco + '-' + convert(varchar(3),op_producto)) in 
    (SELECT(op_banco + '-' + convert(varchar(3),op_producto))
    FROM cr_ope_ricl
    WHERE op_idconn = @w_conexion
    and   op_tipo_cl = 'G')

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1    
end

/* ELIMINAR LAS OPERACIONES CON EL GRUPO QUE SE HAN DUPLICADO CON LAS DE RELACIONADOS */
/* CON EL CLIENTE */
DELETE cr_ope_ricl
WHERE op_idconn = @w_conexion
and   op_tipo_cl = 'E'
and (op_banco + '-' + convert(varchar(3),op_producto)) in 
    (SELECT(op_banco + '-' + convert(varchar(3),op_producto))
     FROM cr_ope_ricl
     WHERE op_idconn = @w_conexion
     and   op_tipo_cl = 'R')

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1    
end

/* ELIMINAR LAS OPERACIONES DEL GRUPO, QUE SE HAN DUPLICADO Y LO QUE CAMBIA ES */
/* EL ROL DEL CLIENTE */
DELETE cr_ope_ricl
WHERE op_idconn = @w_conexion
and   op_tipo_cl = 'G'
and   op_rol_cl  = 'C'
and (op_banco+'-'+convert(varchar(3),op_producto)) in 
    (SELECT(op_banco+'-'+convert(varchar(3),op_producto))
     FROM cr_ope_ricl
     WHERE op_idconn = @w_conexion
     and   op_tipo_cl = 'G'
     and   op_rol_cl  = 'D')

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1    
end

/* ELIMINAR LAS OPERACIONES DE RELACIONADOS, QUE SE HAN DUPLICADO Y LO QUE CAMBIA */
/* ES EL ROL DEL CLIENTE */
DELETE cr_ope_ricl
WHERE op_idconn  = @w_conexion
and   op_tipo_cl = 'R'
and   op_rol_cl  = 'C'
and (op_banco+'-'+convert(varchar(3),op_producto)) in 
    (SELECT(op_banco+'-'+convert(varchar(3),op_producto))
     FROM cr_ope_ricl
     WHERE op_idconn = @w_conexion
     and   op_tipo_cl = 'R'
     and   op_rol_cl  = 'D' )

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1    
end

/* ELIMINAR LAS OPERACIONES DE RELACIONADOS CON EL GRUPO, QUE SE HAN DUPLICADO Y */
/* LO QUE CAMBIA ES EL ROL DEL CLIENTE */
DELETE cr_ope_ricl
WHERE op_idconn  = @w_conexion
and   op_tipo_cl = 'E'
and   op_rol_cl  = 'C'
and (op_banco+'-'+convert(varchar(3),op_producto)) in 
    (SELECT(op_banco+'-'+convert(varchar(3),op_producto))
     FROM cr_ope_ricl
     WHERE op_idconn  = @w_conexion
     and   op_tipo_cl = 'E'
     and   op_rol_cl  = 'D')

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1   
end

   /* ELIMINAR LAS OPERACIONES DE RELACIONADOS CON EL GRUPO, QUE SE HAN DUPLICADO Y */
   /* LO QUE CAMBIA ES EL ROL DEL CLIENTE AVALISTA*/
   DELETE cr_ope_ricl
   WHERE op_idconn  = @w_conexion
   and   op_tipo_cl = 'G'
   and   op_rol_cl  = 'A'
   and (op_banco+'-'+convert(varchar(3),op_producto)) in 
       (SELECT(op_banco+'-'+convert(varchar(3),op_producto))
        FROM cr_ope_ricl
        WHERE op_idconn  = @w_conexion
        and   op_tipo_cl = 'G' 
        and   op_rol_cl  = 'D' )

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
      return 1   
   end
   /* ELIMINAR LAS OPERACIONES DE RELACIONADOS QUE SE HAN DUPLICADO Y */
   /* LO QUE CAMBIA ES EL ROL DEL CLIENTE AVALISTA*/
   DELETE cr_ope_ricl
   WHERE op_idconn  = @w_conexion
   and   op_tipo_cl = 'R'
   and   op_rol_cl  = 'A'
   and (op_banco+'-'+convert(varchar(3),op_producto)) in 
       (SELECT(op_banco+'-'+convert(varchar(3),op_producto))
        FROM cr_ope_ricl
        WHERE op_idconn  = @w_conexion
        and   op_tipo_cl = 'R'
        and   op_rol_cl  = 'D')

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2107016  /* ERROR ELIMINANDO DUPLICADOS EN LA TABLA TEMPORAL DE OPERACIONES */
      return 1   
   end
   --pga 18jul2001 fin

/* COMPLETAR EL CAMPO op_tipo_riesgo EN LA TABLA TEMPORAL cr_ope_ricl */
if @i_cliente is not null
-- ESTOY CONSULTANDO RIESGO DEL CLIENTE 
begin
   update cr_ope_ricl set
   op_tipo_riesgo = 'INDIRECTO'
   WHERE op_idconn = @w_conexion
   --and   op_tipo_cl in ('G', 'R','E')
   and   op_rol_cl = 'C'
      
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMP DE OPERACIONES */
      return 1    
   end

   update cr_ope_ricl set
   op_tipo_riesgo = 'DIRECTO'
   WHERE op_idconn  = @w_conexion
   --and   op_tipo_cl = 'C'
   and   op_rol_cl in ('D','S','A')
        
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMP DE OPERACIONES */
      return 1    
   end

/*
   -- pga 18jul2001 ini
   update cr_ope_ricl set
   op_tipo_riesgo = 'INDIRECTO'   --'DIRECTO'   SBU 09/ene/2002
   WHERE op_idconn = @w_conexion
   and   op_rol_cl = 'A'
        
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMP DE OPERACIONES */
      return 1    
   end
   -- pga 18jul2001 fin 
*/
end
else
begin
   update cr_ope_ricl set
   op_tipo_riesgo  = 'INDIRECTO'
   WHERE op_idconn = @w_conexion
   and   op_tipo_cl in ('R','E')
      
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMP DE OPERACIONES */
      return 1     
   end

   update cr_ope_ricl set
   op_tipo_riesgo  = 'DIRECTO'
   WHERE op_idconn = @w_conexion
   and   op_tipo_cl  = 'G'
          
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMP DE OPERACIONES */
      return 1    
   end
end

/* COMPLETAR EL CAMPO op_abreviatura en la tabla temporal cr_ope_ricl */
update cr_ope_ricl set
op_abreviatura = pd_abreviatura
FROM cr_ope_ricl, cobis..cl_producto
WHERE op_idconn   = @w_conexion
and   pd_producto = op_producto
and   op_producto <> 21
and   pd_abreviatura is not null
  
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2105035  /* ERROR, ACTUALIZANDO DATOS EN LA TABLA TEMPORAL DE OPERACIONES */
   return 1    
end
          
/* LLENAR TABLA PREVIA DE RESULTADOS */
if @i_indirecto = 'S'
-- INCLUIR RIESGO INDIRECTO EN LA CALCULO
begin
   --OPERACIONES ACTIVAS
   if @i_interes = 'S'
   -- INCLUIR CAPITAL, INTERES Y OTROS RIESGOS
   begin
      --INGRESAR LAS OPERACIONES EN ESTADO VIGENTE
      INSERT INTO cr_previa_ricl (
         pr_idconn,      pr_toperacion,  pr_abreviatura, pr_banco,       pr_por_vencer,  
         pr_vencido,     pr_disponible,  pr_tipo_riesgo, pr_tipo_cl,
         pr_rol_cl,      pr_tipo_op,     pr_operacion )
      SELECT 
         @w_conexion,    op_toperacion,  op_abreviatura,  op_banco,       op_saldo_cap+ op_saldo_int + op_saldo_otr, 
         0,              0,              op_tipo_riesgo,  op_tipo_cl,
         op_rol_cl,      'A',            op_operacion 
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'
      and   op_estado     = 1
      and   op_toperacion <> 'CUPO'

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR, INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1             
      end
           
      /* INGRESAR LAS OPERACIONES VENCIDAS */
      INSERT INTO cr_previa_ricl (
         pr_idconn,      pr_toperacion,  pr_abreviatura, pr_banco,
         pr_por_vencer,  pr_vencido,     pr_disponible,
         pr_tipo_riesgo, pr_tipo_cl,     pr_rol_cl,
         pr_tipo_op,     pr_operacion )
      SELECT
         @w_conexion,    op_toperacion,  op_abreviatura, op_banco, 
         0,              op_saldo_cap + op_saldo_int + op_saldo_otr,     0,
         op_tipo_riesgo, op_tipo_cl,     op_rol_cl,
         'A',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'     -- OPERACIONES ACTIVAS
      and   op_estado     = 2       -- ESTADO VENCIDAS
      and   op_toperacion <> 'CUPO' -- EXCLUIR CUPOS pga25jul2001

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR, INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1             
      end         
   end
   else
   -- INCLUIR SOLO EL CAPITAL EN EL RIESGO
   begin
      -- INGRESAR OPERACIONES EN ESTADO VIGENTE
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,  pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,     pr_disponible,   
      pr_tipo_riesgo, pr_tipo_cl,     pr_rol_cl,       
      pr_tipo_op,     pr_operacion )                   
      SELECT                                           
      @w_conexion,    op_toperacion,   op_abreviatura, op_banco,
      op_saldo_cap,   0,               0,
      op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
      'A',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'     -- OPERACIONES ACTIVAS
      and   op_estado     = 1       -- ESTADO VIGENTES
      and   op_toperacion <> 'CUPO' -- EXCLUIR CUPOS pga25jul2001

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR, INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1    
      end
            
      -- INGRESAR OPERACIONES VENCIDAS
      INSERT INTO cr_previa_ricl (
      pr_idconn,        pr_toperacion,  pr_abreviatura, pr_banco,
      pr_por_vencer,    pr_vencido,     pr_disponible,
      pr_tipo_riesgo,   pr_tipo_cl,     pr_rol_cl,
      pr_tipo_op,       pr_operacion )
      SELECT            
      @w_conexion,      op_toperacion,  op_abreviatura, op_banco,
      0,                op_saldo_cap,   0,
      op_tipo_riesgo,   op_tipo_cl,     op_rol_cl,
      'A' ,             op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'     -- OPERACIONES ACTIVAS
      and   op_estado     = 2       -- ESTADO VENCIDAS
      and   op_toperacion <> 'CUPO' -- EXCLUIR CUPOS pga25jul2001

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR, INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1    
      end
   end
         
   -- DISPONIBLE
   -- (1) DISPONIBLE EN CUPOS
   INSERT INTO cr_previa_ricl (
   pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
   pr_por_vencer,  pr_vencido,      pr_disponible,
   pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
   pr_tipo_op,     pr_operacion )
   SELECT
   @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
   0,              0,               op_disponible,
   op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
   'D',            op_operacion
   FROM cr_ope_ricl
   WHERE op_idconn     = @w_conexion
   and   op_tramite    = 'N'
   and   op_toperacion = 'CUPO'

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2103038  /*  ERROR, INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
      return 1
   end

   -- (2)TRAMITES APROBADOS
   INSERT INTO cr_previa_ricl (
   pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
   pr_por_vencer,  pr_vencido,      pr_disponible,
   pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
   pr_tipo_op,     pr_operacion )
   SELECT
   @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
   0,              0,               op_disponible,
   op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
   'T',            op_operacion
   FROM cr_ope_ricl
   WHERE op_idconn     = @w_conexion
   and   op_tramite    = 'S'
   and   op_estado_tr  = 'A'

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
      return 1
   end     

   -- TRAMITES EN PROCESO
   if @i_aprobado = 'N'
   begin
      if @i_indirecto = 'S'
      --INCLUIR TODOS LOS TRAMITES EN PROCESO
      begin
         INSERT INTO cr_previa_ricl (
         pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
         pr_por_vencer,  pr_vencido,      pr_disponible,
         pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
         pr_tipo_op,     pr_operacion )
         SELECT
         @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
         0,              0,               op_disponible,
         op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
         'T',            op_operacion
         FROM cr_ope_ricl
         WHERE op_idconn  = @w_conexion
         and   op_tramite = 'S'
         and   op_estado_tr <> 'A'

         if @@error != 0
         begin
            exec cobis..sp_cerror
            @t_from   = @w_sp_name, 
            @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
            return 1
         end
      end
      else
      -- EXCLUIR LOS TRAMITES EN PROCESOS INDIRECTOS
      begin
         INSERT INTO cr_previa_ricl (
         pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
         pr_por_vencer,  pr_vencido,      pr_disponible,
         pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
         pr_tipo_op,     pr_operacion )
         SELECT
         @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
         0,              0,               op_disponible,
         op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
         'T',            op_operacion
         FROM cr_ope_ricl
         WHERE op_idconn  = @w_conexion
         and   op_tramite = 'S'
         and   op_tipo_riesgo <> 'INDIRECTO'
         and   op_estado_tr <> 'A'

         if @@error != 0
         begin
            exec cobis..sp_cerror
            @t_from   = @w_sp_name, 
            @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
            return 1
         end
      end
   end
end
else
-- EXCLUIR RIESGO INDIRECTO EN EL CALCULO
begin
   -- OPERACIONES ACTIVAS
   if @i_interes = 'S'
   -- INCLUIR CAPITAL, INTERES Y OTROS EN EL RIESGO
   begin
      -- INGRESAR LAS OPERACIONES EN ESTADO VIGENTES
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,              pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,                 pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,                 pr_rol_cl,
      pr_tipo_op,     pr_operacion )              
      SELECT                                      
      @w_conexion,    op_toperacion,              op_abreviatura,   op_banco,
      op_saldo_cap + op_saldo_int + op_saldo_otr, 0,                0,
      op_tipo_riesgo, op_tipo_cl,                 op_rol_cl,
      'A',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'            -- OPERACIONES ACTIVAS
      and   op_estado     = 1              -- ESTADO VIGENTES
      and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO
      and   op_toperacion <> 'CUPO'        -- EXCLUIR LOS CUPOS

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end
             
      -- INGRESAR LAS OPERACIONES VENCIDAS
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,      pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
      pr_tipo_op,     pr_operacion )
      SELECT
      @w_conexion,    op_toperacion,  op_abreviatura,   op_banco,
      0,              op_saldo_cap + op_saldo_int + op_saldo_otr,  0,
      op_tipo_riesgo, op_tipo_cl,                                  op_rol_cl,
      'A',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'            -- OPERACIONES ACTIVAS
      and   op_estado     = 2              -- ESTADO VENCIDAS
      and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO
      and   op_toperacion <> 'CUPO'        -- EXCLUIR LOS CUPOS

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end
   end
   else
   -- INCLUIR SOLO CAPITAL EN EL RIESGO
   begin
      -- INGRESAR LAS OPERACIONES EN ESTADO VIGENTES
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,      pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
      pr_tipo_op,     pr_operacion )
      SELECT
      @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
      op_saldo_cap,     0,             0,
      op_tipo_riesgo,   op_tipo_cl,    op_rol_cl,
      'A',              op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'N'            -- OPERACIONES ACTIVAS
      and   op_estado     = 1              -- ESTADO VIGENTES
      and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO
      and   op_toperacion <> 'CUPO'        -- EXCLUIR LOS CUPOS

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end

      -- INGRESAR LAS OPERACIONES VENCIDAS
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,      pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
      pr_tipo_op,     pr_operacion )
      SELECT
      @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
      0,              op_saldo_cap,    0,
      op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
      'A',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn = @w_conexion
      and   op_tramite    = 'N'            -- OPERACIONES ACTIVAS
      and   op_estado     = 2              -- ESTADO VENCIDAS
      and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO
      and   op_toperacion <> 'CUPO'        -- EXCLUIR LOS CUPOS

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end
   end
   -- DISPONIBLE
   -- (1) DISPONIBLE EN CUPOS
   INSERT INTO cr_previa_ricl (
   pr_idconn ,     pr_toperacion,   pr_abreviatura,  pr_banco,
   pr_por_vencer,  pr_vencido,      pr_disponible,
   pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
   pr_tipo_op,     pr_operacion )
   SELECT
   @w_conexion,     op_toperacion,   op_abreviatura,  op_banco,
   0,               0,               op_disponible,
   op_tipo_riesgo,  op_tipo_cl,      op_rol_cl,
   'D',             op_operacion
   FROM cr_ope_ricl
   WHERE op_idconn     = @w_conexion
   and   op_tramite    = 'N'            -- OPERACIONES ACTIVAS
   and   op_toperacion = 'CUPO'        -- EXCLUIR LOS CUPOS
   and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
      return 1
   end     
                 
   -- (2) TRAMITES APROBADOS
   INSERT INTO cr_previa_ricl (
   pr_idconn,        pr_toperacion,   pr_abreviatura,  pr_banco,
   pr_por_vencer,    pr_vencido,      pr_disponible,
   pr_tipo_riesgo,   pr_tipo_cl,      pr_rol_cl,
   pr_tipo_op,       pr_operacion )
   SELECT
   @w_conexion,      op_toperacion,    op_abreviatura,  op_banco,
   0,                0,                op_disponible,
   op_tipo_riesgo,   op_tipo_cl,       op_rol_cl,
   'T',              op_operacion
   FROM cr_ope_ricl
   WHERE op_idconn     = @w_conexion
   and   op_tramite    = 'S'            -- OPERACIONES ACTIVAS
   and   op_estado_tr  = 'A'
   and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO

   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name, 
      @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
      return 1
   end
         
   -- TRAMITES EN PROCESO
   if @i_aprobado = 'N'
   begin
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,      pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
      pr_tipo_op,     pr_operacion )
      SELECT
      @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
      0,              0,               op_disponible,
      op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
      'T',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'S'            -- OPERACIONES ACTIVAS
      and   op_tipo_riesgo <> 'INDIRECTO'  -- ECLUIR INDIRECTO
      and   op_estado_tr  <> 'A'

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end
   end

   -- SI EL PARAMETRO @i_tramite ES NO NUL, INCLUIR EL TRAMITE SI NO EXISTE EN cr_previa_ricl
   if @i_tramite is not null and
      not exists (SELECT 1
                  FROM cr_previa_ricl
                  WHERE pr_idconn = @w_conexion
                  and   pr_banco  = convert(varchar(24), @i_tramite))
   begin
      INSERT INTO cr_previa_ricl (
      pr_idconn,      pr_toperacion,   pr_abreviatura,  pr_banco,
      pr_por_vencer,  pr_vencido,      pr_disponible,
      pr_tipo_riesgo, pr_tipo_cl,      pr_rol_cl,
      pr_tipo_op,     pr_operacion )
      SELECT
      @w_conexion,    op_toperacion,   op_abreviatura,  op_banco,
      0,              0,               op_disponible,
      op_tipo_riesgo, op_tipo_cl,      op_rol_cl,
      'T',            op_operacion
      FROM cr_ope_ricl
      WHERE op_idconn     = @w_conexion
      and   op_tramite    = 'S'            -- OPERACIONES ACTIVAS
      and   op_banco      = convert(varchar(24), @i_tramite)

      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name, 
         @i_num    = 2103038  /*  ERROR INSERTANDO DATOS EN TABLA PREVIA DE RESULTADOS */
         return 1
      end
   end
end

/* ACTUALIZACION ROL DE AVALISTA EN RIESGO INDIRECTO */
update cr_previa_ricl
set    pr_tipo_cl = 'A'
WHERE  pr_idconn = @w_conexion
and    pr_rol_cl = 'A'

if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name, 
   @i_num    = 2105035,
   @i_msg    = 'Error actualizando tabla previa de resultados'
   return 1    
end
              
if @i_cliente is not null
-- DATOS DE RIESGO DE UN CLIENTE
begin
   -- RIESGO AGRUPADO POR TIPO DE RIESGO
   if @i_modo = 0
   begin
      SELECT
         'TIPO RIESGO' = pr_tipo_riesgo,
         'VIGENTE'     = sum(pr_por_vencer),
         'VENCIDO'     = sum(pr_vencido),
         'DISPONIBLE'  = sum(pr_disponible),
         'TOTAL'       = sum(pr_por_vencer + pr_vencido + pr_disponible)
      FROM  cr_previa_ricl
      where pr_idconn = @w_conexion
      GROUP BY pr_tipo_riesgo
   end   -- FIN DEL MODO 0 DE CLIENTE

   -- AGRUPADO POR DEUDOR/CODEUDOR O GRUPO/RELACIONADO DE ACUERDO AL TIPO DE RIESGO.
   -- (DIRECTO/INDIRECTO)
   if @i_modo = 1
   begin
      if @i_tipor = 'DIRECTO'
         SELECT 
            'ROL'        = pr_rol_cl,
            'VIGENTE'    = sum(pr_por_vencer),
            'VENCIDO'    = sum(pr_vencido),
            'DISPONIBLE' = sum(pr_disponible),
            'TOTAL'      = sum(pr_por_vencer + pr_vencido + pr_disponible)
         FROM cr_previa_ricl
         WHERE pr_idconn = @w_conexion
         and   pr_tipo_riesgo = 'DIRECTO'
         GROUP BY pr_rol_cl
         ORDER BY pr_rol_cl desc

      if @i_tipor = 'INDIRECTO'
            SELECT 
            'ROL'        = pr_tipo_cl,
            'VIGENTE'    = sum(pr_por_vencer),
            'VENCIDO'    = sum(pr_vencido),
            'DISPONIBLE' = sum(pr_disponible),
            'TOTAL'      = sum(pr_por_vencer + pr_vencido + pr_disponible)
         FROM cr_previa_ricl
         WHERE pr_idconn = @w_conexion
         and   pr_tipo_riesgo = 'INDIRECTO'
     GROUP BY pr_tipo_cl
         --ORDER BY pr_tipo_cl desc
   end -- FIN DE MODO 1 DE CLIENTE

   -- AGRUPADO POR TIPO DE DEUDA (ACTUAL, DISPONIBLE, TRAMITES EN PROCESO)
   -- DE ACUERDO AL TIPO DE RIESGO (DIRECTO/INDIRECTO)
   if @i_modo = 2
   begin
      if @i_tipor = 'DIRECTO'
         SELECT 
            'TIPO DEUDA' = pr_tipo_op,
            'VIGENTE'    = sum(pr_por_vencer),
            'VENCIDO'    = sum(pr_vencido),
            'DISPONIBLE' = sum(pr_disponible),
            'TOTAL'      = sum(pr_por_vencer + pr_vencido + pr_disponible)
         FROM cr_previa_ricl
         WHERE pr_idconn      = @w_conexion
         and   pr_tipo_riesgo = 'DIRECTO'
         and   pr_rol_cl      = @i_rol
         GROUP BY pr_tipo_op

      if @i_tipor = 'INDIRECTO'
         SELECT 
            'TIPO DEUDA' = pr_tipo_op,
            'VIGENTE'    = sum(pr_por_vencer),
            'VENCIDO'    = sum(pr_vencido),
            'DISPONIBLE' = sum(pr_disponible),
            'TOTAL'      = sum(pr_por_vencer + pr_vencido + pr_disponible)
         FROM cr_previa_ricl
         WHERE pr_idconn       = @w_conexion
         and   pr_tipo_riesgo = 'INDIRECTO'
         and   pr_tipo_cl      = @i_rol
         GROUP BY pr_tipo_op
   end -- FIN DE MODO 2 DE CLIENTE

   -- DETALLE DE OPERACIONES DE ACUERDO AL TIPO DE DEUDA (ACTUAL, DISPONIBLE, TRAM EN PROCESO)
   -- Y AL TIPO DE RIESGO (DIRECTO/INDIRECTO)
   if @i_modo = 3
   begin
      -- INICIALIZAR PARAMETROS PARA
      SELECT @i_banco    = isnull(@i_banco, ' '),
             @i_producto = isnull(@i_producto, ' ')

      if @i_tipor = 'DIRECTO'
         SELECT
            'Numero'        = pr_banco,
            'Vigente'       = pr_por_vencer,
            'Vencido'       = pr_vencido,
            'Disponible'    = pr_disponible,
            'Total'         = pr_por_vencer + pr_vencido + pr_disponible,
            'Linea Credito' = pr_toperacion,
            'Producto'      = pr_abreviatura
         FROM cr_previa_ricl
         WHERE pr_idconn      = @w_conexion
         and   pr_tipo_riesgo = 'DIRECTO'
         and   pr_rol_cl      = @i_rol
         and   pr_tipo_op     = @i_tipo_op
         and   (( pr_abreviatura > @i_producto ) or
               ((pr_abreviatura = @i_producto) and (pr_banco > @i_banco)))
         ORDER BY pr_abreviatura, pr_banco

      if @i_tipor = 'INDIRECTO'
         SELECT
            'Numero'        = pr_banco,
            'Vigente'       = pr_por_vencer,
            'Vencido'       = pr_vencido,
            'Disponible'    = pr_disponible,
            'Total'         = pr_por_vencer + pr_vencido + pr_disponible,
            'Linea Credito' = pr_toperacion,
            'Producto'      = pr_abreviatura
         FROM cr_previa_ricl
         WHERE pr_idconn      = @w_conexion
         and   pr_tipo_riesgo = 'INDIRECTO'
         and   pr_tipo_op     = @i_tipo_op
         and   pr_tipo_cl     = @i_rol
         and   (( pr_abreviatura > @i_producto ) or
               ((pr_abreviatura = @i_producto) and (pr_banco > @i_banco)))
         ORDER BY pr_abreviatura, pr_banco
   end -- FIN MODO 3 DE CLIENTE
end    -- FIN DE RIESGO DEL CLIENTE
else
-- DATOS DE RIESGO DE UN GRUPO
begin
   -- RIESGO AGRUPADO POR TIPO DE RIESGO
   if @i_modo = 0
   begin
      SELECT
         'TIPO RIESGO'  = pr_tipo_riesgo,
         'VIGENTE'      = sum(pr_por_vencer),
         'VENCIDO'      = sum(pr_vencido),
         'DISPONIBLE'   = sum(pr_disponible),
         'TOTAL'        = sum(pr_por_vencer + pr_vencido + pr_disponible)
      FROM cr_previa_ricl
      where pr_idconn = @w_conexion
      GROUP BY pr_tipo_riesgo
   end -- FIN MODO 0 DE GRUPO

   -- AGRUPADO POR TIPO DE DEUDA (ACTUAL, DISPONIBLE, TRAMITES EN PROCESO) DE ACUERDO AL
   -- TIPO DE RIESGO (DIRECTO/INDIRECTO)
   if @i_modo = 1
   begin
      SELECT
         'TIPO DEUDA'  = pr_tipo_op,
         'VIGENTE'     = sum(pr_por_vencer),
         'VENCIDO'     = sum(pr_vencido),
        'DISPONIBLE'   = sum(pr_disponible),
         'TOTAL'       = sum(pr_por_vencer + pr_vencido + pr_disponible)
      FROM cr_previa_ricl
      WHERE pr_idconn = @w_conexion
      and   pr_tipo_riesgo = @i_tipor
      GROUP BY pr_tipo_op
   end -- FIN DE MODO 1 DE GRUPO

   -- DETALLE DE OPERACIONES DE ACUERDO AL TIPO DE DEUDA (ACTUAL, DISPONIBLE, TRAM PROCESO)
   -- Y AL TIPO DE RIESGO (DIRECTO/INDIRECTO)
   if @i_modo = 2
   begin
      -- INICIALIZAR PARAMETROS PARA
      SELECT @i_banco     = isnull(@i_banco, ' '),
             @i_producto  = isnull(@i_producto, ' ')

     --emg ene-12-02 Adicion nombre cliente para grupos
     if  @i_tipo_op   = 'A' --operaciones
     begin
        SELECT
          'Numero'         = pr_banco,
          'Vigente'        = pr_por_vencer,
          'Vencido'        = pr_vencido,
          'Disponible'     = pr_disponible,
          'Total'          = pr_por_vencer + pr_vencido + pr_disponible,
          'Linea Credito'  = pr_toperacion,
          'Producto'       = pr_abreviatura,
          'Cliente'        = dc_nombre
        FROM cr_previa_ricl, cr_dato_operacion, 
             cr_dato_cliente, cobis..cl_producto
        WHERE pr_idconn         = @w_conexion
          and pr_tipo_riesgo    = @i_tipor        
          and pr_abreviatura    = pd_abreviatura
          and pr_operacion      = do_numero_operacion
          and pd_producto       = do_codigo_producto
          and do_codigo_cliente = dc_cliente
          and do_tipo_reg       = 'D'
          and dc_tipo_reg       = 'D'
          and pr_tipo_op        = @i_tipo_op
          and ((pr_abreviatura > @i_producto) or
              ((pr_abreviatura = @i_producto) and (pr_banco > @i_banco)))
        ORDER BY pr_abreviatura, pr_banco
     end
     if  @i_tipo_op   = 'T' --tramites
     begin
        SELECT
           'Numero'        = pr_banco,
           'Vigente'       = pr_por_vencer,
           'Vencido'       = pr_vencido,
           'Disponible'    = pr_disponible,
           'Total'         = pr_por_vencer + pr_vencido + pr_disponible,
           'Linea Credito' = pr_toperacion,
           'Producto'      = pr_abreviatura,
           'Cliente'       = en_nomlar
        FROM cr_previa_ricl, cr_tramite, cobis..cl_ente
        WHERE pr_idconn      = @w_conexion
        and   pr_tipo_riesgo = @i_tipor
        and   tr_cliente     = en_ente
        and   pr_banco       = convert(varchar(24),tr_tramite)
        and   pr_tipo_op     = @i_tipo_op
        and   ((pr_abreviatura > @i_producto) or
              ((pr_abreviatura = @i_producto) and (pr_banco > @i_banco)))
        ORDER BY pr_abreviatura, pr_banco
     end
   end -- FIN MODO 2 DE GRUPO
end  -- FIN DE RIESGO DEL GRUPO


return 0
go