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
select @w_maxtabla = max(codigo) 
from cl_tabla


declare @w_codigo smallint
select @w_codigo = siguiente 
  from cl_seqnos
 where tabla = 'cl_tabla'


select @w_codigo = @w_maxtabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_desbloq_contb','Causas de desbloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'DESBLOQUEO PIGNOCRACION DE CUENTA', 'V')


select @w_codigo = @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_bloq_contb','Causas de bloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'BLOQUEO PIGNOCRACION DE CUENTA', 'V')


    if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cc_trn_causa_contb')
    begin
        select @w_codigo = codigo from cobis..cl_tabla where tabla =  'cc_trn_causa_contb'
            
        if exists(SELECT 1 FROM cobis..cl_catalogo WHERE tabla = @w_codigo and codigo = @w_cod_transac  and valor = 'ah_causa_bloq_contb')
        begin
             delete from cobis..cl_catalogo WHERE tabla = @w_codigo and codigo = @w_cod_transac  and valor = 'ah_causa_bloq_contb'
        end
        
           PRINT 'ah_causa_bloq_contb'
           INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
           VALUES (@w_codigo, @w_cod_transac , 'ah_causa_bloq_contb', 'V')
        
    end     
    
    
    if exists(SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cc_trn_causa_contb')
    begin
    
        select @w_codigo = codigo from cobis..cl_tabla where tabla =  'cc_trn_causa_contb'
                if exists(SELECT 1 FROM cobis..cl_catalogo WHERE tabla = @w_codigo and codigo = @w_cod_transac_des and valor = 'ah_causa_desbloq_contb')
        begin
             delete from cobis..cl_catalogo WHERE tabla = @w_codigo and codigo = @w_cod_transac_des and valor = 'ah_causa_desbloq_contb'
            
        end
        
           PRINT 'ah_causa_desbloq_contb'
           INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
           VALUES (@w_codigo, @w_cod_transac_des, 'ah_causa_desbloq_contb', 'V')
        
    end     
  
  
update cl_seqnos
set siguiente = @w_codigo + 1
where tabla = 'cl_tabla' 

go

use cob_remesas
go


UPDATE cob_remesas..re_concepto_contable 
SET cc_causa = 18 
WHERE cc_producto = 4 
AND cc_tipo_tran IN (217, 218)

go
