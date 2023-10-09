/****************************************************************************/
/*     Archivo:            contrato_producto.sp                             */
/*     Stored procedure:   sp_contrato_producto                             */ 
/*     Base de datos:      cob_cuentas                                      */
/*     Producto:           Cuentas Corrientes                               */
/*     Disenado por:       N. Vite                                          */ 
/*     Fecha de escritura: 23-Jun-2012                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*     Este programa es parte de los paquetes bancarios propiedad de        */
/*     "MACOSA, representante exclusivos para el Ecuador de la              */
/*     "NCR CORPORATION".                                                   */
/*       Su uso no autorizado queda expresamente prohibido asi como         */
/*     cualquier alteracion o agregado hecho por alguno de sus usuarios     */
/*     sin el debido consentimiento por escrito de la Presidente Ejecutiva  */
/*     de MACOSA o su represente.                                           */ 
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este Programa asocia contratos a los productos bancarios             */
/****************************************************************************/  
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      23-Jun-2012     N. Vite       CTE-0061-1                            */
/*      22-Mar-2013     T. Cruz       Inci_19944                            */
/*      07-Ago-2016     J. Calderon   Proyecto COBISCLOUD                   */
/*      ABR-2017        T. Baidal     CL_ENTE_AUX POR CL_ENTE_ADICIONAL     */ 
/****************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_contrato_producto')
   drop proc sp_contrato_producto    
go

create proc sp_contrato_producto (
    @s_ssn                 int=null,
    @s_srv                 varchar(30) = null,
    @s_lsrv                 varchar(30) = null,
    @s_user                 varchar(30) = null, --
    @s_sesn                 int = null, --
    @s_term                 varchar(32)=null, --
    @s_date                 datetime=null,--
    @s_org                 char(1)=null,--
    @s_ofi                 smallint=null,--
    @s_rol                 smallint=null,--
    @s_org_err             char(1)=null,
    @s_error             int = null,
    @s_sev                 tinyint = null,
    @s_msg                 mensaje = null,
    @t_debug             char(1) = 'N',
    @t_file                 varchar(14) = null,
    @t_from                 varchar(32) = null,
    @t_rty                 char(1) = 'N',
    @t_trn                 smallint,
    @t_show_version      bit = 0, 
    @i_operacion          char(2),
    @i_formato_fecha      int = 101,
    @i_filial              tinyint = null,
    @i_producto             tinyint = null,
    @i_prod_banc         smallint = null,
    @i_estado            char(1) = null, 
    @i_plantilla         varchar(20)=' ',
    @i_tipo_persona      char(1) = null,
    @i_titularidad       char(1) = null,
    @i_es_especial       char(2) = null,
    @i_descripcion       varchar(60)=null,
    @i_cliente           int = null,
    @i_modo                 int = null
)
as

declare @w_sp_name  varchar(32),
        @w_today    datetime,
        @w_tTipo_Persona int,
        @w_tTitularidad  int,
        @w_matricula_com varchar(20),
        @w_nit varchar(20),
        @w_domicilio varchar(255),
        @w_actividad_emp varchar(200),
        @w_telefono      varchar(100),
        @w_id_direccion int,
        @w_id_telefono int,
        @w_ente_repleg int,
        @w_num_testim int,
        @w_fecha_vig varchar(15),
        @w_nombre_notaria varchar(100),
        @w_nombre_notario varchar(100),
        @w_ced_rep_leg varchar(30),
        @w_nom_rep_leg varchar(254),
        @w_c_activ_mark catalogo,
        @w_emp_cargo varchar(100),
        @v_tipo_persona_p char(1),
        @v_titularidad_p char(1),
        @v_estado_p char(1),
        @v_plantilla_p varchar(20),
        @v_descripcion_p varchar(60),
        @v_es_especial char(2)
        


if @t_show_version = 1
begin
    print 'Stored procedure sp_contrato_producto, Version 4.0.0.2'
    return 0
end

select  @w_sp_name = 'sp_contrato_producto',
        @w_today = @s_date

if @t_debug = 'S'
begin 
    exec cobis..sp_begin_debug @t_file=@t_file
      select '/**Store Procedure**/' = @w_sp_name,  
                s_ssn           = @s_ssn,
                s_srv           = @s_srv,
                s_lsrv          = @s_lsrv,
                s_user          = @s_user,
                s_sesn          = @s_sesn,
                s_term          = @s_term,
                s_date          = @s_date,
                s_ofi           = @s_ofi,
                s_rol           = @s_rol,
                s_org_err       = @s_org_err,
                s_error         = @s_error,
                s_sev           = @s_sev,
                s_msg           = @s_msg,
                t_debug         = @t_debug,
                t_file          = @t_file,
                t_from          = @t_from,
                t_rty           = @t_rty,
                t_trn           = @t_trn
    exec cobis..sp_end_debug
end
if @t_trn <> 2946
    begin
   /* No es correcto el código de la transacción */
     exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num = 101183
    return 1
   end   
           
--Operacacion 'I', insertar datos
if @i_operacion = 'I'
 begin
    if exists (select 1 from cob_remesas..re_contrato_producto 
        where cp_producto = @i_producto 
        and cp_prod_banc = @i_prod_banc
        and cp_plantilla = @i_plantilla)

          begin
           /* Datos se repiten */
             exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file = @t_file,
                 @t_from = @w_sp_name,
                 @i_num = 357529 --Datos no se deben repetir
             return 357529
          end      
        begin tran
            insert into cob_remesas..re_contrato_producto 
                        (cp_producto,cp_prod_banc,cp_tipo_persona,cp_titularidad,cp_estado,cp_plantilla,cp_descripcion,cp_es_especial) 
            values (@i_producto,@i_prod_banc,@i_tipo_persona,@i_titularidad,@i_estado,@i_plantilla,@i_descripcion,@i_es_especial)
        
            if @@error != 0
                begin
                /* Error en insertar datos */
                    exec cobis..sp_cerror
                            @t_debug      = @t_debug,
                            @t_file         = @t_file,
                            @t_from         = @w_sp_name,
                            @i_num          = 353504 -- Error al insertar producto bancario  -- codigo tempotral 
                    return 1
                end
            -- inserto la transaccion de servicio del insert    
            insert into cob_remesas..pe_ts_contrato_producto (fecha, secuencial, tipo_transaccion,oficina,usuario,
                        terminal, reentry, operacion, tipo_variacion, producto,
                        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion, hora,es_especial)
            values (@s_date, @s_ssn, @t_trn, @s_ofi, @s_user,
                    @s_term, 'N', @i_operacion, 'N', @i_producto,
                    @i_prod_banc, @i_tipo_persona, @i_titularidad, @i_estado, @i_plantilla, @i_descripcion, getdate(),@i_es_especial)        
            -- error al insertar transaccion de servicio
             if @@error != 0
                begin
                    /* 'Error en insercion de transaccion de servicio' */
                    exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num     = 3603016     -- Error al insertar transaccion de servicio
                    return 1
                end                 
       commit tran
     return 0 
    --end    
end                 
 --Operacion 'D', Eliminar Datos
 if @i_operacion = 'D'
     begin
       begin tran               
         delete from cob_remesas..re_contrato_producto 
                where cp_producto       = @i_producto   
                 and  cp_prod_banc      = @i_prod_banc  
                 and  cp_estado          = @i_estado    
                 and  cp_tipo_persona = @i_tipo_persona
                -- and  cp_titularidad  = @i_titularidad
                 and  cp_plantilla    = @i_plantilla  
                 and  cp_descripcion  = @i_descripcion
                 and  cp_es_especial  = @i_es_especial
                                 
         if @@error != 0
            begin
            /* Error en insertar datos */
                exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 357006 -- ERROR AL ELIMINAR REGISTRO 
                return 1
            end
        -- inserto la transaccion de servicio del delete    
        insert into cob_remesas..pe_ts_contrato_producto (fecha, secuencial, tipo_transaccion,oficina,usuario,
                        terminal, reentry, operacion, tipo_variacion, producto,
                        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion, hora, es_especial)
        values (@s_date, @s_ssn, @t_trn, @s_ofi, @s_user,
                @s_term, 'B', @i_operacion, 'N', @i_producto,
                @i_prod_banc, @i_tipo_persona, @i_titularidad, @i_estado, @i_plantilla, @i_descripcion, getdate(), @i_es_especial)    
                
        -- error al insertar transaccion de servicio del delete
         if @@error != 0
            begin
                /* 'Error en insercion de transaccion de servicio' */
                exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num     = 3603016     -- Error al insertar transaccion de servicio
                return 1
            end 
        commit tran    
    return 0
    --end     
 end
 
 /*  NO SE USA PARA COLOMBIA-MEXICO
 if @i_operacion = 'C'--Datos de cliente jurídico
 begin
 --print 'before resulset'

    select 
     @w_nit = ea_ced_ruc,
     @w_ente_repleg = ea_apoderado_legal,
     @w_num_testim = ea_num_testimonio,
     @w_fecha_vig = convert(varchar(10),ea_fecha_vigencia,@i_formato_fecha),
     @w_nombre_notaria = ea_nombre_notaria,
     @w_nombre_notario = ea_nombre_notario
    from cobis..cl_ente_adicional
    where ea_ente = @i_cliente
    
    select @w_matricula_com = il_no_patc 
    from cobis..cl_inf_legal 
    where il_ente = @i_cliente
   
    select @w_ced_rep_leg = en_ced_ruc,
           @w_nom_rep_leg = en_nomlar
    from cobis..cl_ente
    where en_ente = @w_ente_repleg
    
    select @w_c_activ_mark = ae_actividad from cobis..cl_actividad_economica 
    where ae_ente = @i_cliente
     and ae_estado = 'V'
     and ae_principal = 'S'

    select @w_actividad_emp = ac_descripcion -- actividad económica de la empresa
    from cobis..cl_actividad_ec
    where ac_codigo = @w_c_activ_mark
    
      select @w_emp_cargo = (select oc_descripcion
                       from cobis..cl_ocupacion
                       where oc_codigo = x.tr_cargo)
      from cobis..cl_trabajo x
      where tr_persona = @w_ente_repleg
        and tr_empresa = @i_cliente
        and tr_fecha_salida is null

    --print '@w_nit:%1! - @w_ente_repleg:%2! - @w_num_testim:%3! @w_fecha_vig:%4! @w_nombre_notaria:%5! @w_nombre_notario:%6!',@w_nit,@w_ente_repleg,@w_num_testim,@w_fecha_vig,@w_nombre_notaria,@w_nombre_notario
    --print '@w_matricula_com:%1!',@w_matricula_com
    
    SELECT * FROM cobis..cl_direccion
    
    select @w_domicilio = ltrim(a.di_barrio + ' ' + a.di_descripcion + ' ' + convert(varchar(100),a.di_descripcion) ),
           @w_id_direccion = di_direccion,
           @w_id_telefono  = di_telefono
     from cobis..cl_direccion a,  cobis..cl_catalogo c, cobis..cl_tabla d
     where  a.di_ente       = @i_cliente
       and  a.di_tipo       = c.codigo
       and  c.tabla         = d.codigo
       and  d.tabla         = 'cl_tdireccion'
       and di_principal = 'S'
       and c.codigo not in ('CE','SI') -- se excluye correo electronico  y sitios de internet

    select @w_telefono = te_valor 
    from cobis..cl_telefono
    where te_ente = @i_cliente
    and te_direccion = @w_id_direccion
    --and te_tipo_telefono = 'OF'
    and te_secuencial = @w_id_telefono
    
    
    select 
     @w_matricula_com,--1
     @w_nit,--2
     @w_nom_rep_leg,--3
     @w_ced_rep_leg,--4
     @w_num_testim,--5
     @w_fecha_vig,--6
     @w_nombre_notaria,--7
     @w_nombre_notario,--8
     @w_domicilio,--9
     @w_actividad_emp,--10
     @w_telefono,--11
     @w_ente_repleg,--12
     @w_emp_cargo -- 13

 end
*/
--Operacion 'S' consultar los contratos para pantalla de asociacion de contratos
if @i_operacion = 'S'
     begin

     select @w_tTipo_Persona = codigo from cobis..cl_tabla where tabla = 'cc_tipo_banca'
     select @w_tTitularidad  = codigo from cobis..cl_tabla where tabla = 're_titularidad'

      if @i_modo = 0
         begin
           set rowcount 20
                select      'SELECCION'          = '0',--1
                            'PRODUCTO COBIS'     = pd_descripcion,--2
                            'PRODUCTO BANCARIO'  = pb_descripcion,--3
                            'COD. TIPO PERSONA'  = cp_tipo_persona,--4
                            'COD. TITULARIDAD'   = cp_titularidad,--5
                            'DESC. TIPO PERSONA' = (select valor from cobis..cl_catalogo where tabla = @w_tTipo_Persona and codigo = cp.cp_tipo_persona),--6
                            'TITULARIDAD'        =  (select valor from cobis..cl_catalogo where tabla = @w_tTitularidad and codigo = cp.cp_titularidad),--7
                            'ESTADO'             = cp_estado,--8
                            'PLANTILLA'          = cp_plantilla,--9
                            'DESCRIPCION'        = cp_descripcion,--10
                            'COD. PROD. COBIS'   = cp_producto,--11
                            'COD. PROD. BANCARIO' = cp_prod_banc,--12
                            'ESPECIAL' = cp_es_especial
                from cob_remesas..re_contrato_producto cp,cob_remesas..pe_pro_bancario,cobis..cl_producto
                where cp_producto = pd_producto  
                and      cp_prod_banc = pb_pro_bancario  
                and      pb_estado = 'V' 
                and      pd_estado = 'V'
                and   cp_producto = isnull(@i_producto, cp_producto)
                and   cp_prod_banc = isnull(@i_prod_banc, cp_prod_banc)
                and (cp_estado = @i_estado or @i_estado is null)
                order by cp_prod_banc, cp_plantilla            

          end 
          if @i_modo = 1
         begin
           set rowcount 20
                select      'SELECCION'           = '0',
                            'PRODUCTO COBIS'      = pd_descripcion,
                            'PRODUCTO BANCARIO'   = pb_descripcion,                          
                            'COD. TIPO PERSONA'   = cp_tipo_persona,
                            'COD. TITULARIDAD'    = cp_titularidad,
                            'DESC. TIPO PERSONA'  = (select valor from cobis..cl_catalogo where tabla = @w_tTipo_Persona and codigo = cp.cp_tipo_persona),
                            'TITULARIDAD'         =  (select valor from cobis..cl_catalogo where tabla = @w_tTitularidad and codigo = cp.cp_titularidad),
                            'ESTADO'              = cp_estado,
                            'PLANTILLA'           = cp_plantilla,
                            'DESCRIPCION'         = cp_descripcion,
                            'COD. PROD. COBIS'    = cp_producto,
                            'COD. PROD. BANCARIO' = cp_prod_banc,
                            'ESPECIAL'            = cp_es_especial
                from cob_remesas..re_contrato_producto cp,cob_remesas..pe_pro_bancario,cobis..cl_producto
                where cp_producto = pd_producto  
                and      cp_prod_banc = pb_pro_bancario  
                and      pb_estado = 'V' 
                and      pd_estado = 'V'
                and   cp_producto = @i_producto
                and  (cp_prod_banc >  @i_prod_banc or (cp_prod_banc = @i_prod_banc and cp_plantilla >@i_plantilla))
                and (cp_estado = @i_estado or @i_estado is null)
                order by cp_prod_banc, cp_plantilla            

          end 
end 
 --Operacion 'P' consultar los contratos
 if @i_operacion = 'P'
 begin
 
     if @i_tipo_persona = 'C'
     begin
      select @i_titularidad = null
      select @i_es_especial = null
     end
 
     select 'SELECCION' = cp_producto,
            'PRODUCTO BANCARIO' = cp_prod_banc,
            'ESTADO' = cp_estado,
            'PLANTILLA' = cp_plantilla,
            'DESCRIPCION' = cp_descripcion 
     from cob_remesas..re_contrato_producto       
     where cp_producto = @i_producto
     and   cp_prod_banc = @i_prod_banc
     and ( cp_tipo_persona = @i_tipo_persona or @i_tipo_persona is null )
     and ( cp_titularidad = @i_titularidad or @i_titularidad is null )
     and ( cp_es_especial = @i_es_especial or @i_es_especial is null)
     and   cp_estado = 'V' 
     return 0
 end            
-- lleno el combo de productos bancarios    en pantalla de asociacion de contratos        
if @i_operacion = 'X'
  begin                
    select distinct pb_pro_bancario,  pb_descripcion 
    from cob_remesas..pe_mercado, cob_remesas..pe_pro_bancario, cob_remesas..pe_pro_final
    where me_pro_bancario = pb_pro_bancario
       and pf_mercado = me_mercado
       and pf_producto = @i_producto 
       and pb_estado = 'V'
    return 0                
  end  
             
 if @i_operacion = 'U'
 begin
    --if exists (select 1 from cob_remesas..re_contrato_producto 
    --    where cp_producto = @i_producto 
    --    and cp_prod_banc = @i_prod_banc
    --    and cp_plantilla = @i_plantilla
    --    and cp_estado = 'V')

    --      begin
           /* Datos se repiten */
    --         exec cobis..sp_cerror
    --             @t_debug = @t_debug,
    --             @t_file = @t_file,
    --             @t_from = @w_sp_name,
    --             @i_num = 357529 --Datos no se deben repetir
    --         return 357529
    --      end      
    select @v_estado_p       = cp_estado,
           @v_tipo_persona_p = cp_tipo_persona,
           @v_titularidad_p  = cp_titularidad,
           @v_es_especial    = cp_es_especial
           --@v_plantilla_p = cp_plantilla,
           --@v_descripcion_p = cp_descripcion
    from cob_remesas..re_contrato_producto
    where cp_producto = @i_producto
    and cp_prod_banc = @i_prod_banc 
    and cp_plantilla = @i_plantilla    
     
     
    if @v_estado_p = @i_estado and @v_tipo_persona_p = @i_tipo_persona and @v_titularidad_p = @i_titularidad and @v_es_especial = @i_es_especial
    begin
      --print 'Todos los datos son iguales. No se realiza modificacion '
      /* 'Error en insercion de transaccion de servicio' */
        exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num     = 351134     -- Error al insertar transaccion de servicio
        return 351134
    end
     
   begin tran
    update cob_remesas..re_contrato_producto
    set  cp_estado = @i_estado,
         cp_tipo_persona = @i_tipo_persona,
         cp_titularidad  = @i_titularidad,
         cp_es_especial  = @i_es_especial
         --cp_plantilla = @i_plantilla,
         --cp_descripcion = @i_descripcion
    where cp_producto = @i_producto
     and cp_prod_banc = @i_prod_banc 
     and cp_plantilla = @i_plantilla    

    if @@error != 0
        begin
        /* Error en insertar datos */
            exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 1645068 -- NO SE ACTUALIZARON LOS DATOS
            return 1
        end
        -- inserto la transaccion de servicio Previo    
        insert into cob_remesas..pe_ts_contrato_producto (fecha, secuencial, tipo_transaccion,oficina,usuario,
                        terminal, reentry, operacion, tipo_variacion, producto,
                        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion, hora, es_especial)
        values (@s_date, @s_ssn, @t_trn, @s_ofi, @s_user,
                @s_term, 'P', @i_operacion, 'N', @i_producto,
                @i_prod_banc, @v_tipo_persona_p, @v_titularidad_p, @v_estado_p, @v_plantilla_p, @v_descripcion_p, getdate(), @v_es_especial)    
                
        -- error al insertar transaccion de servicio del update
         if @@error != 0
            begin
                /* 'Error en insercion de transaccion de servicio' */
                exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num     = 3603016     -- Error al insertar transaccion de servicio
                return 1
            end 

                -- inserto la transaccion de servicio Actual
        insert into cob_remesas..pe_ts_contrato_producto (fecha, secuencial, tipo_transaccion,oficina,usuario,
                        terminal, reentry, operacion, tipo_variacion, producto,
                        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion, hora, es_especial)
        values (@s_date, @s_ssn, @t_trn, @s_ofi, @s_user,
                @s_term, 'A', @i_operacion, 'N', @i_producto,
                @i_prod_banc, @i_tipo_persona, @i_titularidad, @i_estado, @i_plantilla, @i_descripcion, getdate(), @i_es_especial)    
                
        -- error al insertar transaccion de servicio del update
         if @@error != 0
            begin
                /* 'Error en insercion de transaccion de servicio' */
                exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num     = 3603016     -- Error al insertar transaccion de servicio
                return 1
            end 
            
        commit tran    
    return 0                                                              
end               

go

