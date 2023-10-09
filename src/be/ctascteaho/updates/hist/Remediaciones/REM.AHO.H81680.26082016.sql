use cobis 
go

declare @w_codigo int,
        @w_cod_transac INT,
        @w_cod_transac_des INT
        

SELECT  @w_cod_transac    = 217
SELECT  @w_cod_transac_des = 218    


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


declare  @w_cod_transac INT,
         @w_cod_transac_des INT
        

SELECT  @w_cod_transac    = 217
SELECT @w_cod_transac_des = 218    

select @w_cod_transac = pa_int
from cobis..cl_parametro 
where pa_producto = 'AHO'
and pa_nemonico = 'TRCBLO' 

print '--> Catalogo: ah_causa_bloq_contb'

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb')
  and codigo = cp_tabla


delete cl_catalogo  from cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb')
   and cl_tabla.codigo = cl_catalogo.tabla


delete cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb')


declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'


select @w_codigo= @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_desbloq_contb','Causas de desbloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'DESBLOQUEO PIGNOCRACION DE CUENTA', 'V')


select @w_codigo = @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_bloq_contb','Causas de bloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'BLOQUEO PIGNOCRACION DE CUENTA', 'V')



update cl_seqnos
   set siguiente = @w_codigo where tabla = 'cl_tabla'


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
        @w_cod_transac INT,
         @w_cod_transac_des INT
        

SELECT  @w_cod_transac    = 217
SELECT @w_cod_transac_des = 218    


select @w_cod_transac = pa_int
from cobis..cl_parametro 
where pa_producto = 'AHO'
and pa_nemonico = 'TRCBLO'
 
select @w_cod_transac_des = pa_int
from cobis..cl_parametro 
where pa_producto = 'AHO'
and pa_nemonico = 'TRCBDB' 


    if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cc_trn_causa_contb')
    begin
        
        select @w_codigo = codigo from cobis..cl_tabla where tabla =  'cc_trn_causa_contb'
        
        DELETE FROM cobis..cl_catalogo WHERE tabla = @w_codigo  AND valor = 'ah_causa_desbloq_contb' 
                                             AND codigo = convert(VARCHAR(10),@w_cod_transac_des) 
       
    end	 
    
     INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
     VALUES (@w_codigo, @w_cod_transac_des, 'ah_causa_desbloq_contb', 'V')

go 

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_causa_bloqueo_val','ah_caulev_blqva')
  and codigo = cp_tabla


delete cl_catalogo from cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloqueo_val','ah_caulev_blqva')
   and cl_tabla.codigo = cl_catalogo.tabla


delete cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloqueo_val','ah_caulev_blqva')

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

select @w_codigo= @w_codigo + 1
print 'Causa de Bloqueo  de Valores AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_bloqueo_val', 'Causa de Bloqueo  de Valores AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '0','MIGRACION','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1','ENTIDAD JUDICIAL','B') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '10','PIGNORACION PRESTAMO PERSONAL','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '11','PIGNORACION PRESTAMO CORPORATIVO','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '12','DEPTO. COBROS','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '13','RESERVA PYME','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '14','RETENCION CONSUMO','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '15','DECISION DEL BANCO','V') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '16','ORDEN AUTORIDAD COMPETENTE','V') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2','ORDEN SUPERINTENDENCIA DE BANCOS','B') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3','CONGELAMIENTO DE FONDOS','B') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '4','SOLICITUD DE CLIENTE','V') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '5','PIGNORACION DE FONDOS','B') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '6','PIGNORACION LINEA DE CREDITO','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '7','PIGNORACION CARTA PROMESA DE PAGO/CARTA DE GARANTIA','C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '8','PIGNORACION CARTA DE CREDITO','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '9','PIGNORACION TARJETA CREDITO','C') 
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'PIGNOCRACION DE CUENTA', 'V')


select @w_codigo = @w_codigo + 1
print 'Causa lev blq valor AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_caulev_blqva', 'Causa lev blq valor AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '0', 'MIGRACION', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '1', 'POR CIERRE DE CUENTA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '10', 'DEPTO COBROS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '11', 'ORDEN SUPERINTENDENCIA DE BANCOS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '12', 'POR ORDEN DEL CLIENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '13', 'POR ORDEN DEL BANCO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '14', 'POR ORDEN DE AUTORIDAD COMPETENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '2', 'ENTIDAD JUDICIAL', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '3', 'CARTA PROMESA DE PAGO/CARTA DE GARANTIA', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '4', 'LINEA DE SOBREGIRO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '5', 'LINEA DE CREDITO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '6', 'TARJETA CREDITO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '7', 'PRESTAMO CORPORATIVO', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '8', 'PRESTAMO PERSONAL', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '9', 'SECUESTRO/EMBARGO JUDICIAL', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '18', 'LEVANTAMIENTO PIGNORACION DE CUENTA', 'V')

update cl_seqnos
   set siguiente = @w_codigo where tabla = 'cl_tabla'
 
go 

use cobis 
go

delete FROM cl_ttransaccion  WHERE tn_trn_code in (217,218) 
delete FROM ad_pro_transaccion WHERE pt_transaccion IN (217,218) and pt_producto = 4 and pt_moneda = 0 and pt_tipo = 'R'
delete FROM ad_tr_autorizada WHERE ta_transaccion  IN (217,218) and ta_producto = 4 and ta_tipo = 'R' and ta_moneda = 0 


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

