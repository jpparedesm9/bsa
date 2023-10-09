/***********************************************************************************************************/
--Fecha                     : 06/Sep/2016 
--Descripción               : script para la Historia 83160
--Descripción de la Solución: Refactor depositos de ahorros
--Autor                     : Tania Baidal, Douglas Fu
/***********************************************************************************************************/

use cob_ahorros
go

--CtasCteAho/Ahorros/Backend/sql/ah_table.sql
if not exists ( select * from sysobjects, syscolumns
                   where sysobjects.id = syscolumns.id
                   and sysobjects.name = 'ah_transacciones_cm_tmp'
                   and syscolumns.name = 'tc_remesas')
   ALTER TABLE ah_transacciones_cm_tmp add tc_remesas char(1) null
go

if not exists ( select * from sysobjects, syscolumns
                   where sysobjects.id = syscolumns.id
                   and sysobjects.name = 'ah_transacciones_cm'
                   and syscolumns.name = 'tr_remesas')
   ALTER TABLE ah_transacciones_cm add tr_remesas char(1) null
go

--CtasCteAho/Ahorros/Backend/sql/ah_catlgo.sql
use cobis
go
/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_ori_remesas')
  and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ah_ori_remesas')
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('ah_ori_remesas')
go

declare @w_codigo smallint

select @w_codigo = max(codigo) + 1
from cl_tabla

print 'Tabla Origen de remesas'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_ori_remesas', 'Origen de remesas')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'L', 'LOCAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'E', 'EXTERIOR', 'V')

select @w_codigo = @w_codigo + 1

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'
go

--CtasCteAho/Ahorros/Backend/sql/ah_error.sql
delete cl_errores where numero in (357041,357042)
go

insert into cl_errores (numero, severidad, mensaje) values (357041, 0, 'ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO')
insert into cl_errores (numero, severidad, mensaje) values (357042, 0, 'ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO')
go

use cob_ahorros
go

--CtasCteAho/Ahorros/Backend/sql/ah_view.sql
print '--------------> vista ah_deposito'
go
if exists (select 1 from sysobjects where type='V' and name='ah_deposito')
    drop view ah_deposito
go

create view ah_deposito (
    secuencial,          ssn_branch,       tipo_tran,        oficina, 
    usuario,             terminal,         correccion,       sec_correccion, 
    reentry,             origen,           nodo,             fecha,               cta_banco, 
    efectivo,            propios,          locales,          ot_plazas,           remoto_ssn, 
    moneda,              saldo_lib,        control,          interes,             fecha_efec,       
    signo,               alterno,          saldocont,        saldodisp,           saldoint,         
    oficina_cta,         hora,             estado,                                                     
    prod_banc,           categoria,        tipocta_super,    turno,               
    canal,               cliente,          clase_clte,       origen_efectivo
) as                                                                              
select tm_secuencial,    tm_ssn_branch,    tm_tipo_tran,     tm_oficina,          
    tm_usuario,          tm_terminal,      tm_correccion,    tm_sec_correccion,   
    tm_reentry,          tm_origen,        tm_nodo,          tm_fecha,            tm_cta_banco, 
    tm_valor,            tm_chq_propios,   tm_chq_locales,   tm_chq_ot_plazas,    tm_remoto_ssn, 
    tm_moneda,           tm_saldo_lib,     tm_control,       tm_interes,          tm_fecha_efec,       
    tm_signo,            tm_cod_alterno,   tm_saldo_contable,tm_saldo_disponible, 
    tm_saldo_interes,    tm_oficina_cta,   tm_hora,          tm_estado,
    tm_prod_banc,        tm_categoria,     tm_tipocta_super, tm_turno,
    tm_canal,            tm_cliente,       tm_clase_clte,    tm_stand_in 
  from  ah_tran_monet
 where  tm_tipo_tran in (246, 248,251, 252, 254)
 go

--CtasCteAho/Dependencias/sql/cobex_table.sql
use cob_externos
go

if not exists ( select * from sysobjects, syscolumns
                   where sysobjects.id = syscolumns.id
                   and sysobjects.name = 'ex_dato_transaccion_det'
                   and syscolumns.name = 'dd_origen_efectivo')
   ALTER TABLE ex_dato_transaccion_det ADD	dd_origen_efectivo char(1) NULL
go



--$/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql/cbsup_table.sql
use cob_conta_super
go

if not exists ( select * from sysobjects, syscolumns
                   where sysobjects.id = syscolumns.id
                   and sysobjects.name = 'sb_dato_transaccion_det'
                   and syscolumns.name = 'dd_origen_efectivo')
    ALTER TABLE [sb_dato_transaccion_det] add dd_origen_efectivo char(1) NULL
go
