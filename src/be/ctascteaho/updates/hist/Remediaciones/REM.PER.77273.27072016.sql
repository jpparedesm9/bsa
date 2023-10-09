/******************************************************/
--Fecha Creación del Script: 2016/Jul/27               */
--Creacion de Producto Menor de Edad */
--Modulo :MIS CTA_AHO                                 */
/* pe_pro_final */
use cob_remesas
go

print 'ALTER TABLA ====> pe_pro_final'
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'pe_pro_final' and
        a.id = b.id and
        a.name = 'pf_depende')
begin
 alter table pe_pro_final add pf_depende  varchar(10) null
end

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'pe_pro_final' and
        a.id = b.id and
        a.name = 'pf_provisiona')
begin
 alter table pe_pro_final add pf_provisiona  char(1)     null
end

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'pe_pro_final' and
        a.id = b.id and
        a.name = 'pf_cod_rango_edad')
begin
 alter table pe_pro_final add pf_cod_rango_edad  tinyint     null
end
go

---CREACION PRODUCTO MENOR DE EDAD 
PRINT 'INSERCION PRODUCTO MENOR DE EDAD'
declare @w_return int,
        @w_codigo  int,
        @w_pro_final   int,
        @w_descripcion varchar(100),
        @w_filial      int,
        @w_sucursal    int,       
        @w_producto    int,                    
        @w_moneda      int,
        @w_tipop       char(1),        
        @w_categoria   char(1),
        @w_posteo      char(1),
        @w_contractual char(1),
        @w_tcapitalizacion  char(1),
        @w_tipo_rango       int,
        @w_ciclo            int,
        @w_mercado          int,
        @w_ser_per          int,
        @w_grupo_rango      int,
        @w_servicio_disponible int,
        @w_rubro               varchar(5),  
        @w_cambio_costo        int,
        @w_costo               int,
        @w_fecha_proceso         datetime,
        @w_maximo               int
    
if exists (SELECT 1 FROM cob_remesas..pe_servicio_dis WHERE sd_nemonico = 'MMAP')
begin
delete cob_remesas..pe_servicio_dis where sd_nemonico = 'MMAP'
delete cob_remesas..pe_var_servicio where vs_descripcion = 'MONTO MINIMO APERTURA CUENTA DE AHORROS'
end

select @w_maximo = max(sd_servicio_dis) + 1 from pe_servicio_dis
INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (@w_maximo, 'MONTO MINIMO APERTURA', 'MMAP', 'V', 0, 2, 'S')

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (@w_maximo, '39', 'MONTO MINIMO APERTURA CUENTA DE AHORROS', 'V', NULL, 'M')

update cobis..cl_seqnos set siguiente = @w_maximo
    where tabla='pe_servicio_dis'

if exists (SELECT 1 FROM cob_remesas..pe_servicio_dis WHERE sd_nemonico = 'SMC')
begin
delete cob_remesas..pe_servicio_dis where sd_nemonico = 'SMC'
delete cob_remesas..pe_var_servicio where vs_descripcion = 'SERVICIO SALDO MAXIMO DE LA CUENTA'
delete cob_remesas..pe_var_servicio where vs_descripcion = 'SERVICIO SALDO MINIMO DE LA CUENTA'
end
select @w_maximo = max(sd_servicio_dis) + 1 from pe_servicio_dis

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (@w_maximo, 'SALDO MINIMO', 'SMC ', 'V', 0, 1, 'S')

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (@w_maximo, 'SMA', 'SERVICIO SALDO MAXIMO DE LA CUENTA', 'V', '', 'M')

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (@w_maximo, 'SMI', 'SERVICIO SALDO MINIMO DE LA CUENTA', 'V', '', 'M')

update cobis..cl_seqnos set siguiente = @w_maximo
    where tabla='pe_servicio_dis'       
        
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso    

SELECT @w_pro_final = pf_pro_final FROM cob_remesas..pe_pro_final  WHERE pf_descripcion = 'PRODUCTO CUENTA AHORROS MENOR EDAD'
delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final                      
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_ciclo_profinal'
    end
delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_capitaliza_profinal'
    end
delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_categoria_profinal'
    end
delete cob_remesas..pe_pro_final WHERE pf_pro_final =  @w_pro_final
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_pro_final'
    end
delete cob_remesas..pe_pro_bancario WHERE pb_descripcion = 'CUENTA AHORROS MENOR EDAD'
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_pro_bancario'
    end
select @w_codigo = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAME' and pa_producto = 'AHO'
delete cobis..cl_parametro where pa_nemonico = 'PCAME' and pa_producto = 'AHO'
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en cl_parametro'
    end
delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_oficina_autorizada'
    end
delete cob_remesas..pe_mercado where me_pro_bancario = @w_codigo
if @@error != 0
    begin
      print 'Error en la eliminacion de registro en pe_mercado'
    end

      delete cob_remesas..pe_cambio_costo where cc_servicio_per in ( select sp_servicio_per
                from  cob_remesas..pe_servicio_per 
                where sp_pro_final = @w_pro_final)
      if @@error != 0
        begin
            print 'Error en la eliminacion de registro en pe_cambio_costo'
        end
      delete cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per
                from  cob_remesas..pe_servicio_per 
                where sp_pro_final = @w_pro_final)
      if @@error != 0
        begin
        print 'Error en la eliminacion de registro en pe_cambio_costo'
        end         
                
delete cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final
if @@error != 0
        begin
        print 'Error en la eliminacion de registro en pe_servicio_per'
        end

if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE')    
begin
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_pro_final',
      @o_siguiente = @w_tipo_rango out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_pro_final'
    end
    
    INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
    VALUES (@w_tipo_rango, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')    
    if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_tipo_rango'
        end
end
else
begin
select @w_tipo_rango = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'
end

if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango AND ra_desde = 0 AND ra_hasta = 99999999999999)
begin
select @w_grupo_rango = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
VALUES (@w_tipo_rango, @w_grupo_rango , 1, 0, 99999999999999, 'V')
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_rango'
        end
end
else
begin
select @w_grupo_rango = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = 1 AND ra_desde = 0 AND ra_hasta = 99999999999999
end

    select @w_descripcion = 'CUENTA AHORROS MENOR EDAD',
           @w_filial      = 1,
           @w_sucursal    = 1,           
           @w_producto    = 4,
           @w_moneda      = 0,
           @w_tipop       = 'R',           
           @w_categoria   = 'D',
           @w_posteo      = 'S',
           @w_contractual = 'N',
           @w_tcapitalizacion   = 'M',
           --@w_tipo_rango        = 1,
           @w_ciclo             = 1
           
    exec @w_return = cobis..sp_cseqnos
     
      @i_tabla     = 'pe_pro_bancario',
      @o_siguiente = @w_codigo out
    if @w_return != 0
    begin
      print 'Error en la obtencion de secuencial pe_pro_bancario'
    end
    
    insert into cob_remesas..pe_pro_bancario
                (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
    values      (@w_codigo,@w_descripcion,'V',@w_fecha_proceso)    
    if @@error != 0
    begin
      print 'Error en la inserccion de registro en pe_pro_bancario'
    end
            
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES (@w_descripcion, 'PCAME', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')

exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_mercado',
      @o_siguiente = @w_mercado out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_mercado'
    end
print  @w_codigo
INSERT INTO cob_remesas..pe_mercado (me_pro_bancario, me_tipo_ente, me_mercado, me_estado, me_fecha_estado)
VALUES (@w_codigo, 'P', @w_mercado, 'V', @w_fecha_proceso)

exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_pro_final',
      @o_siguiente = @w_pro_final out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_pro_final'
    end

select @w_descripcion = 'PRODUCTO CUENTA AHORROS MENOR EDAD'      
    /*Insertar un nuevo producto */
    insert into cob_remesas..pe_pro_final
                (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,
                 pf_moneda,pf_tipo,pf_descripcion,pf_cod_rango_edad)
    values      ( @w_pro_final,@w_filial,@w_sucursal,@w_mercado,@w_producto,
                  @w_moneda,@w_tipop,@w_descripcion,1)

    /*Ocurrio un error en la insercion de producto final*/
    if @@error <> 0
    begin
       print 'Error en la inserccion de registro en pe_pro_final'
    end    
    
    insert into cob_remesas..pe_categoria_profinal
                  (cp_profinal,cp_categoria,cp_posteo,cp_contractual)
      values      (@w_pro_final,@w_categoria,@w_posteo,@w_contractual)

      if @@error <> 0
      begin
        print 'Error en la inserccion de registro en pe_categoria_profinal'
      end
      
     insert into cob_remesas..pe_capitaliza_profinal
                  (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango)
      values      (@w_pro_final,@w_tcapitalizacion,@w_tipo_rango)

      if @@error <> 0
      begin
        print 'Error en la inserccion de registro en pe_capitaliza_profinal'
      end
      
    insert into cob_remesas..pe_ciclo_profinal
                  (cp_profinal,cp_ciclo)
      values      (@w_pro_final,@w_ciclo)

      if @@error != 0
      begin
         print 'Error en la inserccion de registro en pe_ciclo_profinal'
      end      

insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
else print 'Oficina Autorizada. ok!' 
    
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_servicio_per'
    end
    
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio WHERE vs_descripcion = 'MONTO MINIMO APERTURA CUENTA DE AHORROS' --vs_servicio_dis = @w_servicio_disponible and vs_rubro = '39'
SELECT @w_servicio_disponible = sd_servicio_dis FROM cob_remesas..pe_servicio_dis WHERE sd_nemonico = 'MMAP'

INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_servicio_per'
        end
/*
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_cambio_costo',
      @o_siguiente = @w_cambio_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_cambio_costo'
    end
    
INSERT INTO cob_remesas..pe_cambio_costo (cc_secuencial, cc_servicio_per, cc_categoria, cc_tipo_rango, cc_grupo_rango, cc_rango, cc_operacion, cc_tipo, cc_val_medio, cc_minimo, cc_maximo, cc_fecha_cambio, cc_fecha_vigencia, cc_en_linea, cc_confirmado)
VALUES (@w_cambio_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 'I', 'I', 0, 0, 0, @w_fecha_proceso, @w_fecha_proceso, 'N', NULL)
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_cambio_costo'
        end*/

exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_costo'
    end

INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_costo'
        end
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_servicio_per'
    end
    

select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio WHERE vs_descripcion = 'SERVICIO SALDO MINIMO DE LA CUENTA'--vs_servicio_dis = @w_servicio_disponible and vs_rubro = 'SMI'    
SELECT @w_servicio_disponible = sd_servicio_dis FROM cob_remesas..pe_servicio_dis WHERE sd_nemonico = 'SMC'

INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_servicio_per'
        end
/*
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_cambio_costo',
      @o_siguiente = @w_cambio_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_cambio_costo'
    end
    
INSERT INTO cob_remesas..pe_cambio_costo (cc_secuencial, cc_servicio_per, cc_categoria, cc_tipo_rango, cc_grupo_rango, cc_rango, cc_operacion, cc_tipo, cc_val_medio, cc_minimo, cc_maximo, cc_fecha_cambio, cc_fecha_vigencia, cc_en_linea, cc_confirmado)
VALUES (@w_cambio_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 'I', 'I', 0, 0, 0, @w_fecha_proceso, @w_fecha_proceso, 'N', NULL)
 if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_cambio_costo'
        end*/
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_costo'
    end

INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
  if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_costo'
        end
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_servicio_per'
    end
    
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio WHERE vs_descripcion = 'SERVICIO SALDO MAXIMO DE LA CUENTA' --vs_servicio_dis = @w_servicio_disponible and vs_rubro = 'SMA'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible,@w_rubro , @w_ser_per, @w_tipo_rango, @w_grupo_rango)
  if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_servicio_per'
        end
/*
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_cambio_costo',
      @o_siguiente = @w_cambio_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_cambio_costo'
    end
    
INSERT INTO cob_remesas..pe_cambio_costo (cc_secuencial, cc_servicio_per, cc_categoria, cc_tipo_rango, cc_grupo_rango, cc_rango, cc_operacion, cc_tipo, cc_val_medio, cc_minimo, cc_maximo, cc_fecha_cambio, cc_fecha_vigencia, cc_en_linea, cc_confirmado)
VALUES (@w_cambio_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 'I', 'I', 0, 0, 0, @w_fecha_proceso, @w_fecha_proceso, 'N', NULL)
  if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_cambio_costo'
        end*/
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
    if @w_return <> 0
    begin
     print 'Error en la obtencion de secuencial pe_cambio_costo'
    end

INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser')  
  if @@error != 0
        begin
        print 'Error en la inserccion de registro en pe_costo'
        end
go      
PRINT '=====> FIN PRODUCTO MENOR DE EDAD'

go
