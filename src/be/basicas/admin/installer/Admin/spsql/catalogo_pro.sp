/***********************************************************************/
/*    Archivo:            catalpro.sp                                  */
/*    Stored procedure:   sp_catalogo_pro                              */
/*    Base de datos:      cobis                                        */
/*    Producto:           Administrador                                */
/*    Disenado por:       Sandra Ortiz                                 */
/*    Fecha de escritura: 24-Ago-1993                                  */
/* *********************************************************************/
/*                        IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de    */
/*    'MACOSA', representantes exclusivos para el Ecuador de la        */
/*    'NCR CORPORATION'.                                               */
/*    Su uso no autorizado queda expresamente prohibido asi como       */
/*    cualquier alteracion o agregado hecho por alguno de sus          */
/*    usuarios sin el debido consentimiento por escrito de la          */
/*    Presidencia Ejecutiva de MACOSA o su representante.              */
/*                        PROPOSITO                                    */
/*    Este programa procesa las transacciones del stored procedure     */
/*    Insercion de catalogo_pro                                        */
/*    Actualizacion de catalogo_pro                                    */
/*    Borrado de catalogo_pro                                          */
/*    Busqueda de catalogo_pro                                         */
/*                     MODIFICACIONES                                  */
/*    FECHA        AUTOR           RAZON                               */
/*    24/Ago/1993  S. Estevez      Actualizacion tabla-catalogo_pro    */
/*    13/Dic/1993  R. Minga        Verificaciones de datos             */
/*    25/Abr/1994  F. Espinosa     Parametros tipo 'S' tr servicio     */
/*    07/Dic/2012  M. Ponce        Catalogos de recursos ocultos fe    */
/*    21/Jul/2015  B. Sanson       Ajustes FIE                         */
/*    11-04-2016   BBO             Migracion Sybase-Sqlserver FAL      */
/* *********************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_catalogo_pro')
   drop proc sp_catalogo_pro
go

create proc sp_catalogo_pro (
       @s_ssn                int           = null,
       @s_user               login         = null,
       @s_sesn               int           = null,
       @s_term               varchar(32)   = null,
       @s_date               datetime      = null,
       @s_srv                varchar(30)   = null,
       @s_lsrv               varchar(30)   = null, 
       @s_rol                smallint      = null,
       @s_ofi                smallint      = null,
       @s_org_err            char(1)       = null,
       @s_error              int           = null,
       @s_sev                tinyint       = null,
       @s_msg                descripcion   = null,
       @s_org                char(1)       = null,
       @t_debug              char(1)       = 'N',
       @t_file               varchar(14)   = null,
       @t_from               varchar(32)   = null,
       @t_trn                smallint      = null,
       @t_show_version       bit           = 0, 
       @i_operacion          varchar(2),
       @i_modo               tinyint       = null,
       @i_producto           varchar(3)    = null,
       @i_tabla              varchar(30)   = null,
       @i_central_transmit   varchar(1)    = null
)
as
declare @w_sp_name          varchar(30),
        @w_producto         char(3),
        @w_tabla            smallint,
        @w_cmdtransrv       descripcion,
        @w_server_logico    varchar(10),
        @w_num_nodos        smallint,    
        @w_contador         smallint,
        @w_clave            int,
        @w_return           smallint,
        @w_nt_nombre        varchar(40)

/*  Inicializa variables  */

select @w_sp_name = 'sp_catalogo_pro'

----------------------------
--VERSIONAMIENTO PROGRAMA---
----------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_catalogo_pro, Version 4.0.0.4'
    return 0
end


if (@i_operacion = 'I' and @t_trn != 586) or
   (@i_operacion = 'D' and @t_trn != 587) or
   (@i_operacion in ('S','V') and @t_trn != 1578) 
begin
     /*  'No corresponde codigo de transaccion' */
     exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151051
     return 1
end


---Insert---
if @i_operacion = 'I'
begin
     /* Verificar si existe el producto */
     if not exists (select *
                    from cl_producto 
                    where pd_abreviatura = @i_producto)
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 101032
          return 1
     end

     /* Verificar que exista la tabla */
		  
     select @w_tabla = codigo
     from cl_tabla
     where tabla = @i_tabla
		  
     if @@rowcount != 1
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 101003
          return 1
     end

     /* verificar que no exista la tabla previamente */
     if exists (select *
                from cl_catalogo_pro
                where cp_tabla = @w_tabla
                  and cp_producto = @i_producto)
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 101104
          return 1
     end

     begin tran

     insert into cobis..cl_catalogo_pro 
            (cp_producto, cp_tabla)
     values (@i_producto, @w_tabla)

     if @@error != 0
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 103060 
          return 1
     end

     /* transaccion de servicio */
     insert into ts_cat_prod 
            (secuencia,  tipo_transaccion, clase,      fecha,
             oficina_s,  usuario,          terminal_s, srv, 
             lsrv,       producto,         tabla)
     values (@s_ssn,     586,              'N',        @s_date,
             @s_ofi,     @s_user,          @s_term,    @s_srv, 
             @s_lsrv,    @i_producto,      @w_tabla)

     if @@error != 0
     begin
          exec sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 153023
          return 1
     end

     commit tran

     return 0
end



---Delete--
if @i_operacion = 'D'
begin
     select @w_producto  = cp_producto,
            @w_tabla     = cp_tabla
     from cl_catalogo_pro,
          cl_tabla
     where tabla = @i_tabla
       and cp_producto = @i_producto
       and cp_tabla    = codigo

     if @@rowcount != 1
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 101097
          return 1
     end

     begin tran

     delete cl_catalogo_pro
     where cp_producto = @i_producto 
       and cp_tabla    = @w_tabla

     if @@error != 0
     begin
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 107053
          return 1
     end

     /* transaccion de servicio */

     insert into ts_cat_prod 
            (secuencia, tipo_transaccion, clase,      fecha,
             oficina_s, usuario,          terminal_s, srv, 
             lsrv,      producto,         tabla)
     values (@s_ssn,    587,              'B',        @s_date,
             @s_ofi,    @s_user,          @s_term,    @s_srv, 
             @s_lsrv,   @i_producto,      @w_tabla)

     if @@error != 0
     begin
           exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 153023
           return 1
     end
  
     commit tran

     return 0
end


--Search---
if @i_operacion = 'S'
begin
     set rowcount 20

     select @i_tabla = case @i_modo 
                          when 0 then ''
                          else @i_tabla
                       end
                           
     select  'Descripcion' = substring(descripcion, 1, 64),  
             'Tabla'       = substring(tabla, 1, 50)
     from cobis..cl_catalogo_pro,
          cobis..cl_tabla
     where cp_producto = @i_producto 
       and codigo      = cp_tabla
       and convert(char(30),tabla) > @i_tabla
       and tabla not in ('cen_tipo_autoriza','cen_legal_repr')
     order by tabla
  
     set rowcount 0
     return 0
end


if @i_operacion = 'V'
begin
     set rowcount 20


     select @i_tabla = case @i_modo 
                          when 0 then ''
                          else @i_tabla
                       end

     select 'Descripcion' = substring(descripcion, 1, 64),  
            'Tabla'       = substring(tabla, 1, 50)
     from cobis..cl_catalogo_pro,
          cobis..cl_tabla
     where cp_producto = @i_producto 
       and codigo      = cp_tabla
       and convert(char(30),tabla) > @i_tabla
       and tabla not   in ('cen_tipo_autoriza','cen_legal_repr','cr_taccion','cl_tipo_ente','cen_adic_garante','cen_tipo_incluir','cl_calif_interna_riesgo',
                           'cl_tipo_capacidad','cl_categoria_riesgo','cl_clasif_riesgo','cl_codigo_actividad','cl_comportamiento_pago','cl_condicion_especial',
                           'cl_lugar_sucursal','cl_ecivil','cli_estado_excepcion','cl_estado_cic','cl_grupo_vinculado','cl_homologar_cat','cl_matriz_riesgo',
                           'cl_nat_cuenta','cl_nivel_riesgo','cen_vinculado','cl_prod_riesgo','cl_prod_riesgo','cl_prod_riesgo','cl_producto_ofrecer',
                           'cl_provincia','cl_puesto','cl_referidor_externo','cl_relacion_familiar','cl_sectores_productivos','cl_tipo_asignacion',
                           'cl_operacion_inter','cli_tipo_excepcion','cl_tipos_de_producto','cr_cat_deudor','cli_tipo_id_natural_ext','cl_tipo_producto',
                           'cl_transaccion_tipo_producto','cli_val_fecha_nac_const','cl_vinculacion_kyc','cl_indicar_vinculo','cl_zonpos')
     order by tabla

     set rowcount 0

     return 0
end

go

