use cobis 
go

declare @w_codigo int,
        @w_cod_transac INT,
        @w_cod_transac_des INT
        

SELECT  @w_cod_transac    = 217
SELECT @w_cod_transac_des = 218    


if exists(select 1 from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'TRCBLO')
begin
      delete from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'TRCBLO'
end


if exists(select 1 from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'TRCBDB')
begin
      delete from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'TRCBDB'
END

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRANSACCION BLOQUEO CONTABILIZABLE', 'TRCBLO', 'I', NULL, NULL, NULL, @w_cod_transac , NULL, NULL, NULL, 'AHO')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRANSACCION DESBLOQUEO CONTABILIZABLE', 'TRCBDB', 'I', NULL, NULL, NULL, @w_cod_transac_des , NULL, NULL, NULL, 'AHO')

go

declare @w_codigo int,
        @w_cod_transac int

select @w_cod_transac = pa_int
from cobis..cl_parametro 
where pa_producto = 'AHO'
and pa_nemonico = 'TRCBLO' 

print '--> Catalogo: ah_causa_bloq_contb'

if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'ah_causa_bloq_contb')
begin

    select @w_codigo = codigo from cobis..cl_tabla where tabla = 'ah_causa_bloq_contb'
   
    delete from cobis..cl_catalogo where tabla = @w_codigo
   
    delete from cobis..cl_tabla where tabla = 'ah_causa_bloq_contb'

end

    select @w_codigo = siguiente from cobis..cl_seqnos where tabla = 'cl_tabla'
  
    INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
    VALUES (@w_codigo, 'ah_causa_bloq_contb', 'Causas de bloqueos Contabilizables')
 
    INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
    VALUES (@w_codigo, '1', 'BLOQUEO PIGNOCRACION DE CUENTA', 'V')

    update cobis..cl_seqnos
    set siguiente = @w_codigo + 1
    where tabla = 'cl_tabla'



    if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cc_trn_causa_contb')
    begin
        select @w_codigo = codigo from cobis..cl_tabla where tabla =  'cc_trn_causa_contb'
        
        DELETE FROM cobis..cl_catalogo WHERE tabla = @w_codigo 
                                             AND valor = 'ah_causa_bloq_contb' 
                                             AND codigo = convert(VARCHAR(10),@w_cod_transac) 
    
    end	 
    
    
     INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
     VALUES (@w_codigo, @w_cod_transac, 'ah_causa_bloq_contb', 'V')
   
go



declare @w_codigo int,
        @w_cod_transac int,
        @w_cod_transac_des int

 
select @w_cod_transac_des = pa_int
from cobis..cl_parametro 
where pa_producto = 'AHO'
and pa_nemonico = 'TRCBDB' 

print '--> Catalogo: ah_causa_desbloq_contb'
if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'ah_causa_desbloq_contb')
begin

    select @w_codigo = codigo from cobis..cl_tabla where tabla = 'ah_causa_desbloq_contb'
   
    delete from cobis..cl_catalogo where tabla = @w_codigo
   
    delete from cobis..cl_tabla where tabla = 'ah_causa_desbloq_contb'

end

    select @w_codigo = siguiente from cobis..cl_seqnos where tabla = 'cl_tabla'
  
    INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
    VALUES (@w_codigo, 'ah_causa_desbloq_contb', 'Causas de desbloqueos Contabilizables')
 
    INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
    VALUES (@w_codigo, '1', 'DESBLOQUEO PIGNOCRACION DE CUENTA', 'V')

   
    update cobis..cl_seqnos
    set siguiente = @w_codigo + 1
    where tabla = 'cl_tabla'
    


    if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cc_trn_causa_contb')
    begin
        
        select @w_codigo = codigo from cobis..cl_tabla where tabla =  'cc_trn_causa_contb'
        
        DELETE FROM cobis..cl_catalogo WHERE tabla = @w_codigo
                                             AND valor = 'ah_causa_desbloq_contb' 
                                             AND codigo = convert(VARCHAR(10),@w_cod_transac_des) 
       
    end	 
    
     INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
     VALUES (@w_codigo, @w_cod_transac_des, 'ah_causa_desbloq_contb', 'V')

go

SELECT * FROM cl_ttransaccion  WHERE tn_trn_code in (217,218) 
SELECT * FROM ad_pro_transaccion WHERE pt_transaccion IN (217,218) and pt_producto = 4 and pt_moneda = 0 and pt_tipo = 'R'
SELECT * FROM ad_tr_autorizada WHERE ta_transaccion  IN (217,218) and ta_producto = 4 and ta_tipo = 'R' and ta_moneda = 0 


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (217, 'TRANSACCION BLOQUEO PIGNORACION CONTAB', 'TRBPIG', 'ESTA TRANSACCION SE CONTABiLIZA LOS BLOQUEOS PIGNO')

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (218, 'TRANSACCION DESBLOQUEO PIGNORACION CONTAB', 'TRDBPI', 'ESTA TRANSACCION SE CONTAVBLIZA LOS DESBLOQUEOS PIGNO')

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 217, 'V', getdate(), 218, NULL)

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 218, 'V', getdate(), 218, NULL)

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 217, 3, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 218, 3, getdate(), 1, 'V', getdate())

go



