/************************************************************************/
/*      Archivo:                cons_trnser.sp                          */
/*      Stored procedure:       sp_cons_trnser                          */
/*      Base de datos:          cobis                                   */ 
/*      Producto:               Admin                                   */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Mayo-2005                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Consulta y Busqueda                                             */
/*      Transacciones de Servicio version Nucleo                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      MAYO/28/2012  Miguel Aldaz    Emision Iicial  ADM-0007          */
/*      Julio/20/2012 Miguel Aldaz   Cambio @i_login  varchar(14)=null, */
/*      Abril/10/2015 Juan Tagle     Se agrega verificación de Rol      */
/*      Febr/26/2016  J. Mateo       Se personaliza consulta de ts con	*/
/*				     				 cantidad de campos mayores a 80 por*/	
/*				    				 evitar warning exceed row size limit*/
/*      11-03-2016    BBO            Migracion Sybase-Sqlserver FAL     */
/************************************************************************/
use cobis
go
if exists (select * from sysobjects where name = 'sp_cons_trnser')
    drop proc sp_cons_trnser
go

create proc sp_cons_trnser (
   @s_sesn           int         = null,
   @s_ofi            smallint    = null,
   @s_rol            smallint    = null,
   @s_ssn            int         = null,
   @s_date           datetime    = null,
   @s_user           login       = null,
   @s_term           varchar(64) = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @t_show_version   bit = 0           , -- Mostrar la version del programa
   @s_srv            varchar(30) = null,
   @s_lsrv           varchar(30) = null,
   @t_trn            smallint    = null,
   @i_operacion      char(1),
   @i_tipo           char(1)     = null,
   @i_modo           tinyint     = null,
   @i_producto       tinyint   ,
   @i_vista          varchar(40) = null,
   @i_fecha_desde    datetime    = null,
   @i_fecha_hasta    datetime    = null,
   @i_tipo_tran      char(10)    = null,
   @i_login          varchar(14) = null,
   @i_terminal       varchar(64) = null,
   @i_monto          money       = null,
   @i_moneda         smallint    = null,
   @i_rol            int         = null, --FIE
   @i_secuencial     int         = null
  
)
as
declare
   @w_return              int,          /* valor que retorna */
   @w_sp_name             varchar(32),   /* nombre stored proc*/
   @w_producto            smallint    ,
   @w_base_datos          varchar(30) ,
   @w_tabla               varchar(40),
   @w_descripcion         varchar(64) ,
   @w_tipo                char(1)    ,
   @w_campo_fecha         char(40) ,
   @w_campo_secuencial    char(40) ,
   @w_campo_clase         char(40) ,
   @w_clase_ins           char(1)  ,
   @w_clase_upd_previo    char(1) ,
   @w_clase_upd_actual    char(1) ,
   @w_clase_del           char(1) ,
   @w_val_clase           char(1) ,
   @w_condicion_clase     char(64),
   @w_condicion_login     char(64), 
   @w_campo_login         char(40) ,
   @w_campo_terminal      char(40) ,
   @w_condicion_terminal  varchar(255),
   @w_condicion_monto     varchar(255),
   @w_condicion_moneda    varchar(255),
   @w_condicion_rol       varchar(255),  --FIE
   @w_condicion_orderby   varchar(255),
   @w_campo_monto         char(40) ,
   @w_campo_moneda        char(40),
   @w_campo_rol           char(40),    --FIE
   @w_cadena              varchar(255),
   @w_cadena1             varchar(255),
   @w_cadena2             varchar(255),
   @w_cadena3             varchar(255),
   @w_cadena4             varchar(255),
   @w_cadena5             varchar(255),
   @w_cadena6             varchar(255),
   @w_cadena7             varchar(255),
   @w_cadena8             varchar(255),
   @w_cadena9             varchar(255),
   @w_cadena10            varchar(255),
   @w_cadena11            varchar(255),
   @w_cadena12            varchar(255),
   @w_cadena13            varchar(255),
   @w_cadena14            varchar(255),
   @w_cadena15            varchar(255),
   @w_cadena16            varchar(255),
   @w_cadena17            varchar(255),
   @w_cadena18            varchar(255),
   @w_cadena19            varchar(255),
   @w_cadena20            varchar(255),
   @w_cadena21            varchar(255),
   @w_cadena22            varchar(255),
   @w_id_tabla           int,
   @w_campo               varchar(255), 
   @w_variable_campos    varchar(255),
   @w_coma               char(1)
select @w_sp_name = 'sp_cons_trnser'
  
   ---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_cons_trnser, Version 4.0.0.2'
    return 0
end
-------------------------------------

--HELP
if @i_operacion = 'H'
   begin
      if @t_trn = 15915
         begin
            set rowcount 20
               if @i_modo = 0
                  begin
                     select distinct 
                        vt_tabla,
                        vt_descripcion,
                        vt_clase = case isnull(vt_campo_clase ,'N') when 'N' then 'N' else 'S' end,
                        vt_monto = case isnull(vt_campo_monto ,'N') when 'N' then 'N' else 'S' end,
                        vt_moneda= case isnull(vt_campo_moneda,'N') when 'N' then 'N' else 'S' end
                     from   cobis.. ad_vistas_trnser 
                     where  vt_producto = @i_producto 
                     order  by  vt_tabla

                     if @@rowcount = 0 
                        begin
                           exec sp_cerror
                              @t_debug   = @t_debug,
                              @t_file      = @t_file,
                              @t_from      = @w_sp_name,
                              @i_num      = 151170         
                           --NO EXISTEN VISTAS PARA EL PRODUCTO*/ 
                           return 1
                        end
                  end

            if @i_modo = 1
               begin
                  select distinct 
                     vt_tabla,
                     vt_descripcion,
                     Vt_clase =case isnull(vt_campo_clase ,'N') when 'N' then 'N' else 'S' end,
                     vt_monto = case isnull(vt_campo_monto ,'N') when 'N' then 'N' else 'S' end,
                     vt_moneda= case isnull(vt_campo_moneda,'N') when 'N' then 'N' else 'S' end
                  from   cobis.. ad_vistas_trnser 
                  where  vt_producto = @i_producto 
                  and    vt_tabla > @i_vista
                  order  by  vt_tabla

                  if @@rowcount = 0 
                     begin
                        exec sp_cerror
                           @t_debug    = @t_debug,
                           @t_file       = @t_file,
                           @t_from       = @w_sp_name,
                           @i_num        = 151171
                        --NO EXISTEN MAS VISTAS PARA EL PRODUCTO
                        return 1
                     end
               end

               set rowcount 0
               return 0
         end
      else
         begin
            exec sp_cerror
               @t_debug    = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num    = 151007
            --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--DATOS
if @i_operacion = 'V' --DATOS DE UNA VISTA
   begin
      if @t_trn = 15916
         begin
            set rowcount 0
               select 
                  vt_descripcion,
                  Vt_clase = case isnull(vt_campo_clase ,'N') when 'N' then 'N' else 'S' end,
                  vt_monto = case isnull(vt_campo_monto ,'N') when 'N' then 'N' else 'S' end,
                  vt_moneda= case isnull(vt_campo_moneda,'N') when 'N' then 'N' else 'S' end
               from   cobis.. ad_vistas_trnser 
               where  vt_producto  = @i_producto 
               and    vt_tabla     = @i_vista

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num        = 151170
                  --NO EXISTEN VISTAS PARA EL PRODUCTO
                  return 1
               end
         end  
   end



if @i_operacion = 'S'    --> Consulta SEARCH DE VISTAS 
   begin
      if @t_trn = 15917
         begin
            --CAMPOS DEL PRODUCTO Y VISTA DADOS
            select
               @w_base_datos = vt_base_datos, 
               @w_tipo       = vt_tipo, 
               @w_campo_fecha= vt_campo_fecha, 
               @w_campo_clase= vt_campo_clase, 
               @w_val_clase =  case @i_tipo_tran 
                                 when 'N' then vt_clase_ins 
                                 when 'P' then vt_clase_upd_previo
                                 when 'A' then vt_clase_upd_actual
                                 when 'B' then vt_clase_del
                                 else 'S' end,
               @w_campo_secuencial   = vt_campo_secuencial, 
               @w_campo_login       = vt_campo_login, 
               @w_campo_terminal   = vt_campo_terminal, 
               @w_campo_monto      = vt_campo_monto, 
               @w_campo_moneda       = vt_campo_moneda,
               @w_campo_rol      = vt_campo_rol  --FIE
            from ad_vistas_trnser
            where vt_producto = @i_producto
            and   vt_tabla     = @i_vista

            if @@rowcount = 0 
               begin
                  exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file       = @t_file,
                     @t_from       = @w_sp_name,
                     @i_num        = 151170
                  --NO EXISTEN VISTAS PARA EL PRODUCTO
                  return 1
               end

            --print convert(varchar, @i_rol) + ',' + @w_campo_rol
            --CONDICIONES DE BUSQUEDA
            --if @i_tipo_tran <> null  and @w_campo_clase <> null
            if @i_tipo_tran is not null  and @w_campo_clase is not null
               select @w_condicion_clase = " and " + rtrim(ltrim(@w_campo_clase)) + " = '" + ltrim(@w_val_clase) + "'"
            else 
               select @w_condicion_clase =""

            --if @i_login <> null and @w_campo_login <> null  
            if @i_login is not null and @w_campo_login is not null  
               select @w_condicion_login = " and " + rtrim(ltrim(@w_campo_login)) + " = '" + rtrim(ltrim(@i_login)) + "'"
            else
               select @w_condicion_login =""   

            --if @i_terminal <> null and @w_campo_terminal <> null
            if @i_terminal is not null and @w_campo_terminal is not null
               select @w_condicion_terminal = " and " + rtrim(ltrim(@w_campo_terminal)) + " = '" + ltrim(@i_terminal) + "'"         
            else
               select @w_condicion_terminal = ""

            --if @w_campo_monto <> null and @i_monto <> null
            if @w_campo_monto is not null and @i_monto is not null
               --select @w_condicion_monto = " and " + rtrim(ltrim(@w_campo_monto)) + " = " + convert(varchar,@i_monto)         
			   select @w_condicion_monto = " and isnull(" + rtrim(ltrim(@w_campo_monto)) + ",0) = " + convert(varchar,@i_monto)         
            else
               select @w_condicion_monto = ""

            --if @w_campo_moneda <> null and  @i_moneda <> null
            if @w_campo_moneda is not null and  @i_moneda is not null
               select @w_condicion_moneda= " and " + rtrim(ltrim(@w_campo_moneda)) + " = " + convert(varchar,@i_moneda)
            else
               select @w_condicion_moneda= ""

            --if @w_campo_rol <> null and  @i_rol <> null
            if @w_campo_rol is not null and  @i_rol is not null
               select @w_condicion_rol = " and " + rtrim(ltrim(@w_campo_rol)) + " = " + convert(varchar,@i_rol)
            else
               select @w_condicion_rol= ""

            select @w_condicion_orderby  = " order by " + rtrim(ltrim(@w_campo_fecha)) + "," + ltrim(@w_campo_secuencial)         

            /*id de la tabla  o vista*/
            /*select @w_cadena = "select @w_id_tabla= id from " + @w_base_datos+ "..sysobjects where name ='" + @i_vista + "'"
            exec (@w_cadena)
            if @@rowcount = 0 begin
                  exec sp_cerror
                  @t_debug    = @t_debug,
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 151172
                  -- 'No existen vistas para el producto' 
                  return 1
            end

             --Creamos tabla temporal
            CREATE TABLE #advistacolumns (
             name        varchar(255)     NULL
            )  
      
            --Arma lista de campos de la vista
            
               select @w_cadena = insert into #advistacolumns select name  from  + @w_base_datos + ..syscolumns where id = + convert(varchar,@w_id_tabla)
               EXEC  (@w_cadena)
               
               
               
               select @w_coma=
               DECLARE cur_campos CURSOR FOR select name from advistacolumns
               OPEN cur_campos
               FETCH NEXT FROM cur_campos INTO @w_campo

              if (@@fetch_status = -1)  --sqlstatus: mig syb-sqls 11032016
              begin
                close cur_campos        --mig syb-sqls 11032016
                deallocate cur_campos   --mig syb-sqls 11032016
                
                -- Error en recuperacion de datos del cursor 
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 151172
                 return 1 
              end
               
               WHILE @@fetch_status = 0  --sqlstatus: mig syb-sqls 11032016
               begin

                  select @w_variable_campos= @w_variable_campos + @w_coma+@w_campo 
                  select @w_coma=','
               FETCH NEXT FROM cur_campos 
               INTO @w_campo
               end --while
          
               CLOSE cur_campos
            deallocate cur_campos

            drop table advistacolumns
            */
      
      
            set rowcount 0
            if @i_modo = 0
               begin
                  --CONSULTA DE LA TABLA  O VISTA
                  --select @w_cadena1 = "select id=identity(10),*  into #ad_vista from " + rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista)) --migacion syb-sql 
                  select @w_cadena1 = "select id=identity(int,1,1),*  into #ad_vista from " + rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))  --migacion syb-sql
                  select @w_cadena2 =  " where " + rtrim(ltrim(@w_campo_fecha)) + ">='" + convert(varchar(10),@i_fecha_desde,101) + " 00:00:00' and " + rtrim(ltrim(@w_campo_fecha)) + " <='" + convert(varchar(10),@i_fecha_hasta,101)+" 23:59:59'"
                  select @w_cadena3 = @w_condicion_clase
                  select @w_cadena4 = @w_condicion_login
                  select @w_cadena5 = @w_condicion_terminal
                  select @w_cadena6 = @w_condicion_monto
                  select @w_cadena7 = @w_condicion_moneda
                  select @w_cadena8 = @w_condicion_rol
                  select @w_cadena9 = @w_condicion_orderby+  char(13)

                  if @i_vista = 'ts_persona_cli' or @i_vista = 'ts_persona' or @i_vista = 'ts_referencia' 
                     select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
                  else
                     select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
				
				  select @w_cadena11 = "select * from #ad_vista "         
				  
				  if  @i_vista = 'ts_compania' 
					begin
							select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 "
							select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
							select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
							select @w_cadena12 = 'secuencial, tipo_transaccion, clase, fecha, usuario, terminal, srv, lsrv, compania, nombre, ruc, actividad, posicion, grupo, activo, pasivo, tipo, pais, filial, oficina, casilla_def, tipo_dp, retencion, comentario, es_grupo, '
							select @w_cadena13 = 'oficial, fecha_mod, tipo_nit, referido, sector, fecha_emision, lugar_doc, total_activos, num_empleados, sigla, doc_validado, rep_superban, tipo_vinculacion, vinculacion, exc_sipla, nivel_ing, nivel_egr, codsuper, tsecpublico, subspublico'
							select @w_cadena14 = 'nicho, segmento, promotor, subemp1, subemp2, subemp, cobertura, suplidores, categoria, referidor_ecu, nacionalidad, otros_ingresos, origen_ingresos, estado_ea, contrato_firmado, menor_edad, conocido_como, cliente_planilla, cod_risk, sector_eco, '
							select @w_cadena15 = 'actividad_ea, lin_neg, seg_neg, ejecutivo_con, suc_gestion, constitucion, remp_legal, apoderado_legal, fuente_ing, act_prin, detalle, act_dol, cat_aml, num_testimonio, indefinido, '
							select @w_cadena16 = 'fecha_vigencia, nombre_notaria, nombre_notario, hora, nombre_comercial, num_tributario, patrimonio_b, fecha_constitucion, cliente_preferencial, upd_usuario'
							--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena14+@w_cadena15+@w_cadena16+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +', '+@w_cadena14+@w_cadena15+@w_cadena16 +@w_cadena11)  ----migacion syb-sql
                            exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena14+@w_cadena15+@w_cadena16+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +', '+@w_cadena14+@w_cadena15+@w_cadena16 +@w_cadena11)  ----migacion syb-sql
							if @@rowcount = 0 
							 begin
								exec sp_cerror
								   @t_debug    = @t_debug,
								   @t_file       = @t_file,
								   @t_from       = @w_sp_name,
								   @i_num        = 151172
								--NO EXISTEN VISTAS PARA EL PRODUCTO
								return 1
							 end
					  end 
				  else
				    begin
						  if  @i_vista = 'ca_operacion_ts' 
						   begin
								select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 "
								select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
								select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
								select @w_cadena12 = 'ops_fecha_proceso_ts,ops_fecha_ts,ops_usuario_ts,ops_oficina_ts,ops_terminal_ts,ops_operacion,ops_banco,ops_anterior,ops_migrada,ops_tramite,ops_cliente,ops_nombre,ops_sector,ops_toperacion,ops_oficina,ops_moneda,ops_comentario,ops_oficial,'
								select @w_cadena13 = 'ops_fecha_ini,ops_fecha_fin,ops_fecha_ult_proceso,ops_fecha_liq,ops_fecha_reajuste,ops_monto,ops_monto_aprobado,ops_destino,ops_lin_credito,ops_ciudad,ops_estado,ops_periodo_reajuste,ops_reajuste_especial,ops_tipo,ops_forma_pago,ops_cuenta,'
								select @w_cadena14 = 'ops_dias_anio,ops_tipo_amortizacion,ops_cuota_completa,ops_tipo_cobro,ops_tipo_reduccion,ops_aceptar_anticipos,ops_precancelacion,ops_tipo_aplicacion,ops_tplazo,ops_plazo,ops_tdividendo,ops_periodo_cap,ops_periodo_int,ops_dist_gracia,ops_gracia_cap, '
								select @w_cadena15 = 'ops_gracia_int,ops_dia_fijo,ops_cuota,ops_evitar_feriados,ops_num_renovacion,ops_renovacion,ops_mes_gracia,ops_reajustable,ops_origen_fondo,ops_fondos_propios,ops_dias_desembolso,ops_fecha_ins_desembolso,ops_nro_bmi,ops_cupos_terceros '--primeta tabla temp
								select @w_cadena16 = 'ops_sector_contable,ops_clabas,ops_clabope,ops_plazo_contable,ops_fecha_ven_legal,ops_cuota_ballom,ops_cuota_menor,ops_tcertificado,ops_estado_manual,ops_prd_cobis,ops_sujeta_nego,ops_ref_exterior,ops_via_judicial,ops_reest_int,ops_garant_emi,'
								select @w_cadena17 = 'ops_oficial_cont,ops_premios,ops_saldo,ops_base_calculo,ops_ajuste_moneda,ops_moneda_ajuste,ops_product_group,ops_lin_comext,ops_tipo_prioridad,ops_promotor,ops_vendedor,ops_comision_pro,ops_cuota_incluye,ops_dias_prorroga,'
								select @w_cadena18 = 'ops_subsidio,ops_porcentaje_subsidio,ops_financia,ops_abono_ini,ops_opcion_compra,ops_beneficiario,ops_factura,ops_tpreferencial,ops_porcentaje_preferencial,ops_monto_preferencial,ops_comision_ven,ops_cuenta_vendedor,ops_agencia_venta,'
								select @w_cadena19 = 'ops_comision_agencia,ops_cuenta_agencia,ops_canal_venta,ops_iniciador,ops_entrevistador,ops_fecha_ult_mod,ops_usuario_mod,ops_referido,ops_num_reest,ops_num_prorroga,ops_fecha_cambio_est,ops_num_reajuste,ops_gracia_mora,ops_modo_reest,'
								select @w_cadena20 = 'ops_estado_deuda,ops_dividendo_vig,ops_fecha_ult_reest,ops_fecha_ult_pago,ops_fecha_ult_pago_cap,ops_fecha_ult_pago_int,ops_monto_ult_pago,ops_monto_ult_pago_cap,ops_monto_ult_pago_int,ops_sec_ult_pago,ops_efecto_pago,ops_fecha_ult_reaj,'
								select @w_cadena21 = 'ops_tasa_anterior,ops_monto_promocion,ops_saldo_promocion,ops_tipo_promocion,ops_cuota_promocion,ops_compra_operacion,ops_fecha_mora'
								--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+@w_cadena20+@w_cadena21+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena20 +@w_cadena21 +@w_cadena11)  --migracion syb-sql
                                exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+@w_cadena20+@w_cadena21+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena20 +@w_cadena21 +@w_cadena11)  --migracion syb-sql
								if @@rowcount = 0 
								 begin
									exec sp_cerror
									   @t_debug    = @t_debug,
									   @t_file       = @t_file,
									   @t_from       = @w_sp_name,
									   @i_num        = 151172
									--NO EXISTEN VISTAS PARA EL PRODUCTO
									return 1
								 end
						  end 
						  else
						  begin
								
								  if  @i_vista = 'ce_ts_operacion' 
								  begin
										select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 "
										select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
										select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
										select @w_cadena12 = 'v_to_secuencial,v_to_codigo_transaccion,v_to_oficina,v_to_clase,v_to_cod_alterno,v_to_fecha,v_to_usuario,v_to_terminal,v_to_reentry,v_to_origen,v_to_servidor_origen,v_to_servidor_local,v_to_operacion,v_to_ctacci,v_to_tipo_oper,v_to_etapa,'
										select @w_cadena13 = 'v_to_oficina_op,v_to_oficina_pertenece,v_to_filial,v_to_producto,v_to_tipo,v_to_oficial,v_to_usuario_op,v_to_fecha_op,v_to_irrevocable,v_to_confirmado,v_to_pre_aviso,v_to_fecha_prea,v_to_fecha_solic,v_to_fecha_emis,v_to_fecha_expir,v_to_ordenante,'
										select @w_cadena14 = 'v_to_direccion_ord,v_to_tipo_cuenta,v_to_cuenta,v_to_categoria,v_to_ced_ruc,v_to_beneficiario,v_to_direccion_ben,v_to_ciudad_ben,v_to_pais_ben,v_to_continente_ben,v_to_moneda,v_to_tolerancia_superior,v_to_tolerancia_inferior,v_to_importe,'
										select @w_cadena15 = 'v_to_importe_calc,v_to_termino,v_to_mensaje,v_to_prioridad,v_to_convenio,v_to_transporte,v_to_tcorreo,v_to_tipo_importe,v_to_transbordo,v_to_emb_parcial,v_to_nro_embarques,v_to_notificacion,v_to_flete,v_to_puerto_embarque,v_to_puerto_destino'--primeta tabla temp
										select @w_cadena16 = 'v_to_ult_fecha_embarque,v_to_documentos,v_to_plazo_pres_dtos,v_to_transaccion,v_to_mercancia,v_to_poliza,v_to_enmienda,v_to_letra,v_to_gastos_bancarios,v_to_financia,v_to_saldo,v_to_lugar_expir,v_to_transferible,v_to_fecha_neg,v_to_interes_gen,'
										select @w_cadena17 = 'v_to_fecha_etapa,v_to_nro_referencia,v_to_nro_ref_opc,v_to_tipo_ben,v_to_ult_ben,v_to_resp_operacion,v_to_fecha_cancelacion,v_to_por_cuenta_de,v_to_direccion_pcd,v_to_adelantada,v_to_nro_aprobacion,v_to_ref_nota_emision,v_to_abono,v_to_fecha_acuse,'
										select @w_cadena18 = 'v_to_tasa_interes_ext,v_to_fecha_apd,v_to_renovacion,v_to_tipo_aval,v_to_tipo_tasint,v_to_disponibilidad,v_to_disp_banco,v_to_disp_oficina,v_to_disp_continente,v_to_disp_pais,v_to_disp_ciudad,v_to_ced_ruc_ben,v_to_cod_ben,v_to_fpago,v_to_dir_cod_ben,'
										select @w_cadena19 = 'v_to_tasa_interes_clt,v_to_plazo_finan,v_to_tipo_tasa,v_to_signo,v_to_linea_credito,v_to_por_orden_de,v_to_direccion_pod,v_to_especifica,v_to_telefono,v_to_fax,v_to_email,v_to_fondeos,v_to_op_prov_ben'
										--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena11) --migracion syb-sql
                                        exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena11) --migracion syb-sql
										if @@rowcount = 0 
										 begin
											exec sp_cerror
											   @t_debug    = @t_debug,
											   @t_file       = @t_file,
											   @t_from       = @w_sp_name,
											   @i_num        = 151172
											--NO EXISTEN VISTAS PARA EL PRODUCTO
											return 1
										 end
								  end 
								  else
								  begin
										--print "%1! %2! %3! %4! %5! %6! %7! %8! %9! %10! %11!",@w_cadena1,@w_cadena2,@w_cadena3,@w_cadena4,@w_cadena5,@w_cadena6,@w_cadena7,@w_cadena8,@w_cadena9,@w_cadena10,@w_cadena11
										  exec (@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+@w_cadena11)

										  if @@rowcount = 0 
											 begin
												exec sp_cerror
												   @t_debug    = @t_debug,
												   @t_file       = @t_file,
												   @t_from       = @w_sp_name,
												   @i_num        = 151172
												--NO EXISTEN VISTAS PARA EL PRODUCTO
												return 1
											 end
								  end
						  end
				    end
            end
            else    --> MODO = 1
              begin
                  --CONSULTA DE LA TABLA  O VISTA
                  --select @w_cadena1 = "select id=identity(10),*  into #ad_vista from " + rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))           
                  select @w_cadena1 = "select id=identity(int,1,1),*  into #ad_vista from " + rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))            --migracion syb-sql
                  select @w_cadena2 =  " where " + rtrim(ltrim(@w_campo_fecha)) + ">='" + convert(varchar(10),@i_fecha_desde,101) + " 00:00:00' and " + rtrim(ltrim(@w_campo_fecha)) + " <='" + convert(varchar(10),@i_fecha_hasta,101)+" 23:59:59'"
                  select @w_cadena3 = @w_condicion_clase
                  select @w_cadena4 = @w_condicion_login
                  select @w_cadena5 = @w_condicion_terminal
                  select @w_cadena6 = @w_condicion_monto
                  select @w_cadena7 = @w_condicion_moneda
                  select @w_cadena8 = @w_condicion_rol
                  select @w_cadena9 = @w_condicion_orderby +  char(13)
                  select @w_cadena10 = char(13)
                  --select @w_cadena11 = "select * from #ad_vista "
                  --if  @i_secuencial <> null and @i_secuencial <> 0
                  if  @i_secuencial is not null and @i_secuencial <> 0
                     begin
						if  @i_vista = 'ts_referencia' 
							select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
						else
							select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
                        select @w_cadena11 ="select * from #ad_vista where id > "+ convert(varchar,@i_secuencial)
                     end   
                  else 
                     begin
                        select @w_cadena10 = ""
                        select @w_cadena11 =""
                     end

                  /*select @w_cadena8 = " and (  (" + rtrim(ltrim(@w_campo_secuencial)) +" =" + convert(varchar,@i_secuencial) 
                  if @w_campo_clase <> "" and  @w_val_clase <> "" 
                  begin
                     select @w_cadena9 = " and " + rtrim(ltrim(@w_campo_clase)) + " >" + rtrim(ltrim(@w_val_clase))+ ")"
                  end  
                  else 
                     select @w_cadena9= ")"
                     
                  select @w_cadena10 = "or (" + rtrim(ltrim(@w_campo_secuencial)) +" >" + convert(varchar,@i_secuencial) + "))"
                  select @w_cadena11 =@w_condicion_orderby*/
				  
				  if  @i_vista = 'ts_compania' 
				   begin
						select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 and  a.id > "+ convert(varchar,@i_secuencial)
						select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
						select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
						select @w_cadena12 = 'secuencial, tipo_transaccion, clase, fecha, usuario, terminal, srv, lsrv, compania, nombre, ruc, actividad, posicion, grupo, activo, pasivo, tipo, pais, filial, oficina, casilla_def, tipo_dp, retencion, comentario, es_grupo, '
						select @w_cadena13 = 'oficial, fecha_mod, tipo_nit, referido, sector, fecha_emision, lugar_doc, total_activos, num_empleados, sigla, doc_validado, rep_superban, tipo_vinculacion, vinculacion, exc_sipla, nivel_ing, nivel_egr, codsuper, tsecpublico, subspublico'
						select @w_cadena14 = 'nicho, segmento, promotor, subemp1, subemp2, subemp, cobertura, suplidores, categoria, referidor_ecu, nacionalidad, otros_ingresos, origen_ingresos, estado_ea, contrato_firmado, menor_edad, conocido_como, cliente_planilla, cod_risk, sector_eco, '
						select @w_cadena15 = 'actividad_ea, lin_neg, seg_neg, ejecutivo_con, suc_gestion, constitucion, remp_legal, apoderado_legal, fuente_ing, act_prin, detalle, act_dol, cat_aml, num_testimonio, indefinido, '
						select @w_cadena16 = 'fecha_vigencia, nombre_notaria, nombre_notario, hora, nombre_comercial, num_tributario, patrimonio_b, fecha_constitucion, cliente_preferencial, upd_usuario'
						--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena14+@w_cadena15+@w_cadena16+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +', '+@w_cadena14+@w_cadena15+@w_cadena16 +@w_cadena11)
                        exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena14+@w_cadena15+@w_cadena16+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +', '+@w_cadena14+@w_cadena15+@w_cadena16 +@w_cadena11)
						if @@rowcount = 0 
							 begin
								exec sp_cerror
								   @t_debug    = @t_debug,
								   @t_file       = @t_file,
								   @t_from       = @w_sp_name,
								   @i_num        = 151172
								--NO EXISTEN VISTAS PARA EL PRODUCTO
								return 1
							 end
  				   end 
				  else
					begin
					
					  if  @i_vista = 'ca_operacion_ts' 
						begin
								select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 and  a.id > "+ convert(varchar,@i_secuencial)
								select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
								select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
								select @w_cadena12 = 'ops_fecha_proceso_ts,ops_fecha_ts,ops_usuario_ts,ops_oficina_ts,ops_terminal_ts,ops_operacion,ops_banco,ops_anterior,ops_migrada,ops_tramite,ops_cliente,ops_nombre,ops_sector,ops_toperacion,ops_oficina,ops_moneda,ops_comentario,ops_oficial,'
								select @w_cadena13 = 'ops_fecha_ini,ops_fecha_fin,ops_fecha_ult_proceso,ops_fecha_liq,ops_fecha_reajuste,ops_monto,ops_monto_aprobado,ops_destino,ops_lin_credito,ops_ciudad,ops_estado,ops_periodo_reajuste,ops_reajuste_especial,ops_tipo,ops_forma_pago,ops_cuenta,'
								select @w_cadena14 = 'ops_dias_anio,ops_tipo_amortizacion,ops_cuota_completa,ops_tipo_cobro,ops_tipo_reduccion,ops_aceptar_anticipos,ops_precancelacion,ops_tipo_aplicacion,ops_tplazo,ops_plazo,ops_tdividendo,ops_periodo_cap,ops_periodo_int,ops_dist_gracia,ops_gracia_cap, '
								select @w_cadena15 = 'ops_gracia_int,ops_dia_fijo,ops_cuota,ops_evitar_feriados,ops_num_renovacion,ops_renovacion,ops_mes_gracia,ops_reajustable,ops_origen_fondo,ops_fondos_propios,ops_dias_desembolso,ops_fecha_ins_desembolso,ops_nro_bmi,ops_cupos_terceros '--primeta tabla temp
								select @w_cadena16 = 'ops_sector_contable,ops_clabas,ops_clabope,ops_plazo_contable,ops_fecha_ven_legal,ops_cuota_ballom,ops_cuota_menor,ops_tcertificado,ops_estado_manual,ops_prd_cobis,ops_sujeta_nego,ops_ref_exterior,ops_via_judicial,ops_reest_int,ops_garant_emi,'
								select @w_cadena17 = 'ops_oficial_cont,ops_premios,ops_saldo,ops_base_calculo,ops_ajuste_moneda,ops_moneda_ajuste,ops_product_group,ops_lin_comext,ops_tipo_prioridad,ops_promotor,ops_vendedor,ops_comision_pro,ops_cuota_incluye,ops_dias_prorroga,'
								select @w_cadena18 = 'ops_subsidio,ops_porcentaje_subsidio,ops_financia,ops_abono_ini,ops_opcion_compra,ops_beneficiario,ops_factura,ops_tpreferencial,ops_porcentaje_preferencial,ops_monto_preferencial,ops_comision_ven,ops_cuenta_vendedor,ops_agencia_venta,'
								select @w_cadena19 = 'ops_comision_agencia,ops_cuenta_agencia,ops_canal_venta,ops_iniciador,ops_entrevistador,ops_fecha_ult_mod,ops_usuario_mod,ops_referido,ops_num_reest,ops_num_prorroga,ops_fecha_cambio_est,ops_num_reajuste,ops_gracia_mora,ops_modo_reest,'
								select @w_cadena20 = 'ops_estado_deuda,ops_dividendo_vig,ops_fecha_ult_reest,ops_fecha_ult_pago,ops_fecha_ult_pago_cap,ops_fecha_ult_pago_int,ops_monto_ult_pago,ops_monto_ult_pago_cap,ops_monto_ult_pago_int,ops_sec_ult_pago,ops_efecto_pago,ops_fecha_ult_reaj,'
								select @w_cadena21 = 'ops_tasa_anterior,ops_monto_promocion,ops_saldo_promocion,ops_tipo_promocion,ops_cuota_promocion,ops_compra_operacion,ops_fecha_mora'
								--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+@w_cadena20+@w_cadena21+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena20 +@w_cadena21 +@w_cadena11)
                                exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+@w_cadena20+@w_cadena21+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena20 +@w_cadena21 +@w_cadena11) --migracion syb-sql
								if @@rowcount = 0 
								 begin
									exec sp_cerror
									   @t_debug    = @t_debug,
									   @t_file       = @t_file,
									   @t_from       = @w_sp_name,
									   @i_num        = 151172
									--NO EXISTEN VISTAS PARA EL PRODUCTO
									return 1
								 end
						end 
                      else
						begin
							  if  @i_vista = 'ce_ts_operacion' 
							    begin
									select @w_cadena11 =" from #ad_vista a , #ad_vista2 b where a.id = b.id2 and  a.id > "+ convert(varchar,@i_secuencial)
									select @w_cadena10 = char(13)+ "set rowcount 5"   +char(13)
									select @w_cadena1 =  rtrim(ltrim(@w_base_datos))+ ".." + rtrim(ltrim(@i_vista))
									select @w_cadena12 = 'v_to_secuencial,v_to_codigo_transaccion,v_to_oficina,v_to_clase,v_to_cod_alterno,v_to_fecha,v_to_usuario,v_to_terminal,v_to_reentry,v_to_origen,v_to_servidor_origen,v_to_servidor_local,v_to_operacion,v_to_ctacci,v_to_tipo_oper,v_to_etapa,'
									select @w_cadena13 = 'v_to_oficina_op,v_to_oficina_pertenece,v_to_filial,v_to_producto,v_to_tipo,v_to_oficial,v_to_usuario_op,v_to_fecha_op,v_to_irrevocable,v_to_confirmado,v_to_pre_aviso,v_to_fecha_prea,v_to_fecha_solic,v_to_fecha_emis,v_to_fecha_expir,v_to_ordenante,'
									select @w_cadena14 = 'v_to_direccion_ord,v_to_tipo_cuenta,v_to_cuenta,v_to_categoria,v_to_ced_ruc,v_to_beneficiario,v_to_direccion_ben,v_to_ciudad_ben,v_to_pais_ben,v_to_continente_ben,v_to_moneda,v_to_tolerancia_superior,v_to_tolerancia_inferior,v_to_importe,'
									select @w_cadena15 = 'v_to_importe_calc,v_to_termino,v_to_mensaje,v_to_prioridad,v_to_convenio,v_to_transporte,v_to_tcorreo,v_to_tipo_importe,v_to_transbordo,v_to_emb_parcial,v_to_nro_embarques,v_to_notificacion,v_to_flete,v_to_puerto_embarque,v_to_puerto_destino'--primeta tabla temp
									select @w_cadena16 = 'v_to_ult_fecha_embarque,v_to_documentos,v_to_plazo_pres_dtos,v_to_transaccion,v_to_mercancia,v_to_poliza,v_to_enmienda,v_to_letra,v_to_gastos_bancarios,v_to_financia,v_to_saldo,v_to_lugar_expir,v_to_transferible,v_to_fecha_neg,v_to_interes_gen,'
									select @w_cadena17 = 'v_to_fecha_etapa,v_to_nro_referencia,v_to_nro_ref_opc,v_to_tipo_ben,v_to_ult_ben,v_to_resp_operacion,v_to_fecha_cancelacion,v_to_por_cuenta_de,v_to_direccion_pcd,v_to_adelantada,v_to_nro_aprobacion,v_to_ref_nota_emision,v_to_abono,v_to_fecha_acuse,'
									select @w_cadena18 = 'v_to_tasa_interes_ext,v_to_fecha_apd,v_to_renovacion,v_to_tipo_aval,v_to_tipo_tasint,v_to_disponibilidad,v_to_disp_banco,v_to_disp_oficina,v_to_disp_continente,v_to_disp_pais,v_to_disp_ciudad,v_to_ced_ruc_ben,v_to_cod_ben,v_to_fpago,v_to_dir_cod_ben,'
									select @w_cadena19 = 'v_to_tasa_interes_clt,v_to_plazo_finan,v_to_tipo_tasa,v_to_signo,v_to_linea_credito,v_to_por_orden_de,v_to_direccion_pod,v_to_especifica,v_to_telefono,v_to_fax,v_to_email,v_to_fondeos,v_to_op_prov_ben'
									--exec ('select id=identity(10),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(10),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena11)
                                    exec ('select id=identity(int,1,1),'+@w_cadena12+@w_cadena13+@w_cadena14+@w_cadena15+'  into #ad_vista from '+@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9 + 'select id2=identity(int,1,1),' +@w_cadena16+@w_cadena17+@w_cadena18+@w_cadena19+' into #ad_vista2 from '+@w_cadena1 +@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+'select a.id,'+@w_cadena12 +@w_cadena13 +@w_cadena14+@w_cadena15+', '+@w_cadena16 +@w_cadena17 +@w_cadena18 +@w_cadena19 +@w_cadena11)  --migracion sybase-sql
									if @@rowcount = 0 
									 begin
										exec sp_cerror
										   @t_debug    = @t_debug,
										   @t_file       = @t_file,
										   @t_from       = @w_sp_name,
										   @i_num        = 151172
										--NO EXISTEN VISTAS PARA EL PRODUCTO
										return 1
									 end
								end 
                              else
								begin
									--print "%1! %2! %3! %4! %5! %6! %7! %8! %9! %10! %11!",@w_cadena1,@w_cadena2,@w_cadena3,@w_cadena4,@w_cadena5,@w_cadena6,@w_cadena7,@w_cadena8,@w_cadena9,@w_cadena10,@w_cadena11
									  exec (@w_cadena1+@w_cadena2+@w_cadena3+@w_cadena4+@w_cadena5+@w_cadena6+@w_cadena7+@w_cadena8+@w_cadena9+@w_cadena10+@w_cadena11)
									  if @@rowcount = 0 
										 begin
											exec sp_cerror
											   @t_debug    = @t_debug,
											   @t_file       = @t_file,
											   @t_from       = @w_sp_name,
											   @i_num        = 151173
											--NO EXISTEN VISTAS PARA EL PRODUCTO
											return 1
										 end
								end
							 end
					    end
                    end
              end
         set rowcount 0
         return 0
   end --> @i_operacion = S    --> Consulta
go


