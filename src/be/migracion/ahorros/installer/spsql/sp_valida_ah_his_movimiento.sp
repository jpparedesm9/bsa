/************************************************************************/
/*      Archivo:                sp_valida_ah_his_movimiento.sp          */
/*      Stored procedure:       sp_valida_ah_his_movimiento             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           RSA                                     */
/*      Fecha de escritura:     26-Ago-2016                             */
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
/*      Este programa realiza la migracion de los valores de suspenso   */
/*      de las cuentas de ahorros.                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR               RAZON                          */
/*  26/Ago/2016      Roxana Sánchez      Validacion Categorias          */
/************************************************************************/
use cob_externos
go

if exists (select * from sysobjects where name = 'sp_valida_ah_his_movimiento')
    drop proc sp_valida_ah_his_movimiento 
go

create proc sp_valida_ah_his_movimiento(
   @i_clave_i           int          = null,  
   @i_clave_f           int          = null
)
as 
set nocount on 

declare
@w_sp_name            varchar(30),
@w_tabla              varchar(30),
@w_nomcolumna         varchar(30),
@w_conteo             int,
@w_fecha_proceso      datetime,
@w_prod_banc          smallint,
@w_cod_ente           int,
@w_categoria          char(1)

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------

select @w_sp_name         = 'sp_valida_ah_his_movimiento_mig',
   @w_tabla           = 'ah_his_movimiento_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

   
select @w_conteo = count(1)
from    ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'hm_cta_banco'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_cta_banco),
       289,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where a.hm_cta_banco = ca_cta_banco_mig) 

-- ---------------------------------------------------------------------
-- -Valida la Fecha del Valor en Suspenso
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hm_fecha'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_fecha),
       167,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_fecha  > @w_fecha_proceso

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hm_secuencial'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_secuencial),
       164,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_secuencial  = 0


-------------------------------------
--VALIDAR LA CUENTA
-------------------------------------
select @w_nomcolumna = 'hm_cta_banco'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_cta_banco),
       243,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hm_cta_banco)= convert(varchar(24), b.ah_cta_banco))
where a.hm_codigo between @i_clave_i and @i_clave_f
and b.ah_cta_banco is null


-------------------------------------
--VALIDAR OFICINA
-------------------------------------
select @w_nomcolumna = 'hm_oficina'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_oficina),
       145,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and a.hm_oficina not in (select codigo from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla 
                                                                         WHERE tabla = 'cl_oficina' ) and codigo = a.hm_oficina ) 
-------------------------------------
--VALIDAR hm_usuario
-------------------------------------
select @w_nomcolumna = 'hm_user'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_usuario),
       245,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and a.hm_usuario not in (select fu_login from cobis..cl_funcionario where fu_login = a.hm_usuario)

--------------------------------------------------------                               
--Valida el Indicador de si la transacción es o no reversa 
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_correccion'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_correccion),
       228,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and hm_correccion not in ('S','N')   

-------------------------------------
--VALIDAR PRODUCTO
-------------------------------------
select @w_nomcolumna = 'hm_origen'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_origen),
       70,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig 
where hm_codigo between @i_clave_i and @i_clave_f
and   hm_origen <> 'L' 

--------------------------------------------------------                               
--Valida el S/N si la transacción ingreso por modulo Reentry  
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_reentry'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_reentry),
       229,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and hm_reentry not in ('S','N')  

--------------------------------------------------------                               
--Valida el Signo  de la cuenta
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_signo'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_signo),
       202,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and hm_signo not in ('D','C')  

-------------------------------
--VALIDAR VALOR
------------------------------- 
select @w_nomcolumna = 'hm_valor'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_valor),
       140,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_valor < 0

-------------------------------------
--VALIDAR MONEDA
-------------------------------------
select @w_nomcolumna = 'hm_moneda'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_moneda),
       239,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and a.hm_moneda not in (select c.codigo from cobis..cl_tabla t, cobis..cl_catalogo c                    
                                    where t.tabla = 'cl_moneda' and t.codigo = c.tabla and c.codigo = a.hm_moneda ) 


--------------------------------------------------------                               
--Valida el Indicador de la cuenta 
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_indicador'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_indicador),
       203,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and hm_indicador <> null
and hm_indicador not in (1,2,3,4)  

--------------------------------------------------------                               
--Valida el Estado de la Transacción
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_estado'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_estado),
       230,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and hm_estado <> null
and hm_estado not in ('A','I','C','R')  

-------------------------------
--VALIDAR SALDO CONTABLE
------------------------------- 
select @w_nomcolumna = 'hm_saldo_contable'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_saldo_contable),
       260,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_saldo_contable < 0     

-------------------------------
--VALIDAR SALDO DISPONIBLE
------------------------------- 
select @w_nomcolumna = 'hm_saldo_disponible'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_saldo_disponible),
       26,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_saldo_disponible < 0                           

---------------------------------------------------------------------
--Valida la Oficina de la Cuenta que tienen valores en suspensos contra la tabla cl_oficina
---------------------------------------------------------------------
select @w_nomcolumna = 'hm_oficina_cta'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_oficina_cta),
       145,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a
where hm_codigo between @i_clave_i and @i_clave_f
and a.hm_oficina_cta not in (select of_oficina from cobis..cl_oficina 
						 where of_oficina = a.hm_oficina_cta)
                               
-------------------------------
--VALIDAR HORA DEL SUSPENSO
------------------------------- 
select @w_nomcolumna = 'hm_hora'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_hora),
       264,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig
where hm_codigo between @i_clave_i and @i_clave_f
and hm_hora is null         

-------------------------------------
--VALIDAR EL PRODUCTO BANCARIO
-------------------------------------
select @w_nomcolumna = 'hm_prod_banc'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_prod_banc),
       135,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hm_prod_banc)= convert(varchar(24), b.ah_prod_banc))
where a.hm_codigo between @i_clave_i and @i_clave_f
and b.ah_prod_banc is null

-------------------------------------
--VALIDAR LA CATEGORIA
-------------------------------------
select @w_nomcolumna = 'hm_categoria'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_categoria),
       14,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hm_categoria)= convert(varchar(24), b.ah_categoria))
where a.hm_codigo between @i_clave_i and @i_clave_f
and b.ah_categoria is null


-------------------------------------
select @w_nomcolumna = 'hm_categoria'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_categoria),
       293,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a , cob_externos..ah_cuenta_mig b
where a.hm_codigo between @i_clave_i and @i_clave_f
and ah_cta_banco = hm_cta_banco
and a.hm_categoria not in (select cp_categoria  from cob_remesas..pe_categoria_profinal, cob_remesas..pe_pro_final,cob_remesas..pe_mercado
   where cp_profinal =pf_pro_final   and    pf_mercado = me_mercado 
   and me_pro_bancario = b.ah_prod_banc)

-------------------------------------
--VALIDAR EL TIPO DE CUENTA SUPER
-------------------------------------
select @w_nomcolumna = 'hm_tipocta_super'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_tipocta_super),
       87,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hm_tipocta_super)= convert(varchar(24), b.ah_tipocta_super))
where a.hm_codigo between @i_clave_i and @i_clave_f
and b.ah_tipocta_super is null


-------------------------------------
--VALIDAR LA CLASE DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'hm_clase_clte'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_clase_clte),
       226,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig 
where hm_codigo between @i_clave_i and @i_clave_f
and hm_clase_clte is null
and hm_clase_clte not in ('P','O') 


-------------------------------------
--VALIDAR EL CLIENTE DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'hm_cliente'

insert into ah_log_mig
select convert(varchar, hm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hm_cliente),
       53,
       hm_codigo,
       hm_cta_banco
from ah_his_movimiento_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hm_cliente)= convert(varchar(24), b.ah_cliente))
where a.hm_codigo between @i_clave_i and @i_clave_f
and b.ah_cliente is null


-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_his_movimiento_mig set hm_estado_mig = 'VE'
where hm_codigo between @i_clave_i and @i_clave_f
and hm_codigo not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_his_movimiento_mig'
                  group by lm_id_reg)
and hm_estado_mig is null

update ah_his_movimiento_mig set hm_estado_mig = 'ER'
where hm_codigo between @i_clave_i and @i_clave_f
and hm_estado_mig is null
return  0
go 

                      