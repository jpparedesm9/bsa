/************************************************************************/
/*      Archivo:                sp_valida_ah_tran_monet.sp              */
/*      Stored procedure:       sp_valida_ah_tran_monet                 */
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

if exists (select * from sysobjects where name = 'sp_valida_ah_tran_monet')
    drop proc sp_valida_ah_tran_monet 
go

create proc sp_valida_ah_tran_monet(
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

select @w_sp_name         = 'sp_valida_ah_tran_monet_mig',
   @w_tabla           = 'ah_tran_monet_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


   
select @w_conteo = count(1)
from    ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0


-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'tm_cta_banco'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_cta_banco),
       289,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where a.tm_cta_banco = ca_cta_banco_mig) 

-- ---------------------------------------------------------------------
-- -Valida la Fecha del Valor en Suspenso
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'tm_fecha'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_fecha),
       167,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_fecha  <> @w_fecha_proceso

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'tm_codigo'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_secuencial),
       164,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_secuencial  = 0


-------------------------------------
--VALIDAR LA CUENTA
-------------------------------------
select @w_nomcolumna = 'tm_cta_banco'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_cta_banco),
       243,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.tm_cta_banco)= convert(varchar(24), b.ah_cta_banco))
where a.tm_codigo between @i_clave_i and @i_clave_f
and b.ah_cta_banco is null


-------------------------------------
--VALIDAR OFICINA
-------------------------------------
select @w_nomcolumna = 'tm_oficina'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_oficina),
       145,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and a.tm_oficina not in (select codigo from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla 
                                                                         WHERE tabla = 'cl_oficina' ) and codigo = a.tm_oficina ) 
-------------------------------------
--VALIDAR tm_usuario
-------------------------------------
select @w_nomcolumna = 'tm_user'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_usuario),
       245,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and a.tm_usuario not in (select fu_login from cobis..cl_funcionario where fu_login = a.tm_usuario)

--------------------------------------------------------                               
--Valida el Indicador de si la transacción es o no reversa 
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_correccion'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_correccion),
       228,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_correccion not in ('S','N')   

-------------------------------------
--VALIDAR PRODUCTO
-------------------------------------
select @w_nomcolumna = 'tm_origen'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_origen),
       70,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig 
where tm_codigo between @i_clave_i and @i_clave_f
and   tm_origen <> 'L' 

--------------------------------------------------------                               
--Valida el Indicador de si la transacción es o no reversa 
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_reentry'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_reentry),
       229,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_reentry not in ('S','N')  

--------------------------------------------------------                               
--Valida el Signo  de la cuenta
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_signo'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_signo),
       202,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_signo not in ('D','C')  

-------------------------------
--VALIDAR VALOR
------------------------------- 
select @w_nomcolumna = 'tm_valor'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_valor),
       140,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_valor < 0

select  tm_valor = sum(tm_valor + tm_chq_locales),tm_cta_banco,  tm_signo
   into #valores 
from  ah_tran_monet_mig
group by tm_signo, tm_cta_banco

insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_valor),
       287,
       ah_cuenta,
       tm_cta_banco
from #valores t, ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_cta_banco =t.tm_cta_banco
and tm_signo='C'
and tm_valor != ah_creditos_hoy


insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_valor),
       288,
       ah_cuenta,
       tm_cta_banco
from #valores t, ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_cta_banco =t.tm_cta_banco
and tm_signo='D'
and tm_valor != ah_debitos_hoy



-------------------------------------
--VALIDAR MONEDA
-------------------------------------
select @w_nomcolumna = 'tm_moneda'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_moneda),
       239,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and a.tm_moneda not in (select c.codigo from cobis..cl_tabla t, cobis..cl_catalogo c                    
                                    where t.tabla = 'cl_moneda' and t.codigo = c.tabla and c.codigo = a.tm_moneda ) 


--------------------------------------------------------                               
--Valida el Indicador de la cuenta 
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_indicador'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_indicador),
       203,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_indicador <> null
and tm_indicador not in (1,2,3,4)  

--------------------------------------------------------                               
--Valida el Estado de la Transacción
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_estado'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_estado),
       230,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_estado <> null
and tm_estado not in ('A','I','C','R')  

--------------------------------------------------------                               
--Valida la forma de Pago de la Transacción
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_forma_pag'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_forma_pg),
       256,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and tm_forma_pg <> null
and tm_forma_pg not in ('E')  

-------------------------------
--VALIDAR SALDO CONTABLE
------------------------------- 
select @w_nomcolumna = 'tm_saldo_contable'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_saldo_contable),
       260,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_saldo_contable < 0     

-------------------------------
--VALIDAR SALDO DISPONIBLE
------------------------------- 
select @w_nomcolumna = 'tm_saldo_disponible'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_saldo_disponible),
       26,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_saldo_disponible < 0                           

---------------------------------------------------------------------
--Valida la Oficina de la Cuenta que tienen valores en suspensos contra la tabla cl_oficina
---------------------------------------------------------------------
select @w_nomcolumna = 'tm_oficina_cta'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_oficina_cta),
       145,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a
where tm_codigo between @i_clave_i and @i_clave_f
and a.tm_oficina_cta not in (select of_oficina from cobis..cl_oficina 
						 where of_oficina = a.tm_oficina_cta)
                               
-------------------------------
--VALIDAR HORA DEL SUSPENSO
------------------------------- 
select @w_nomcolumna = 'tm_hora'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_hora),
       264,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and tm_hora is null         

-------------------------------------
--VALIDAR EL PRODUCTO BANCARIO
-------------------------------------
select @w_nomcolumna = 'tm_prod_banc'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_prod_banc),
       135,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.tm_prod_banc)= convert(varchar(24), b.ah_prod_banc))
where a.tm_codigo between @i_clave_i and @i_clave_f
and b.ah_prod_banc is null

-------------------------------------
--VALIDAR LA CATEGORIA
-------------------------------------
select @w_nomcolumna = 'tm_categoria'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_categoria),
       14,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.tm_categoria)= convert(varchar(24), b.ah_categoria))
where a.tm_codigo between @i_clave_i and @i_clave_f
and b.ah_categoria is null


-------------------------------------
select @w_nomcolumna = 'tm_categoria'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_categoria),
       293,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a , cob_externos..ah_cuenta_mig b
where a.tm_codigo between @i_clave_i and @i_clave_f
and ah_cta_banco = tm_cta_banco
and a.tm_categoria not in (select cp_categoria  from cob_remesas..pe_categoria_profinal, cob_remesas..pe_pro_final,cob_remesas..pe_mercado
   where cp_profinal = pf_pro_final   and    pf_mercado = me_mercado 
   and me_pro_bancario = b.ah_prod_banc)

-------------------------------------
--VALIDAR EL TIPO DE CUENTA SUPER
-------------------------------------
select @w_nomcolumna = 'tm_tipocta_super'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_tipocta_super),
       87,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.tm_tipocta_super)= convert(varchar(24), b.ah_tipocta_super))
where a.tm_codigo between @i_clave_i and @i_clave_f
and b.ah_tipocta_super is null


-------------------------------------
--VALIDAR LA CLASE DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'tm_clase_clte'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_clase_clte),
       226,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig 
where tm_codigo between @i_clave_i and @i_clave_f
and tm_clase_clte <> null
and tm_clase_clte not in ('P','O') 


-------------------------------------
--VALIDAR EL CLIENTE DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'tm_cliente'

insert into ah_log_mig
select convert(varchar, tm_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tm_cliente),
       53,
       tm_codigo,
       tm_cta_banco
from ah_tran_monet_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.tm_cliente)= convert(varchar(24), b.ah_cliente))
where a.tm_codigo between @i_clave_i and @i_clave_f
and b.ah_cliente is null


-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_tran_monet_mig set tm_estado_mig = 'VE'
where tm_codigo between @i_clave_i and @i_clave_f
and tm_codigo not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_tran_monet_mig'
                  group by lm_id_reg)
and tm_estado_mig is null

update ah_tran_monet_mig set tm_estado_mig = 'ER'
where tm_codigo between @i_clave_i and @i_clave_f
and tm_estado_mig is null
return  0
go 


                      