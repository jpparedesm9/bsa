/************************************************************************/
/*      Archivo:                sp_valida_re_cuenta_contractual.sp      */
/*      Stored procedure:       sp_valida_re_cuenta_contractual         */
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

if exists (select * from sysobjects where name = 'sp_valida_re_cuenta_contractual')
    drop proc sp_valida_re_cuenta_contractual 
go

create proc sp_valida_re_cuenta_contractual(
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

select @w_sp_name         = 'sp_valida_re_cuenta_contractual_mig',
   @w_tabla           = 're_cuenta_contractual_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
   
select @w_conteo = count(1)
from    re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'cc_cta_banco'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_cta_banco),
       289,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where a.cc_cta_banco = ca_cta_banco_mig)

-- ---------------------------------------------------------------------
-- - Valida el Producto de Ahorros
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cc_modulo'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_modulo),
       211,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_modulo  <> 4

---------------------------------------------------------------------
--Valida el producto final 
---------------------------------------------------------------------
select @w_nomcolumna = 'cc_profinal'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_profinal),
       274,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and a.cc_profinal not in (select pf_pro_final from cob_remesas..pe_pro_final
						 where  pf_pro_final = a.cc_profinal)
                               
                               
---------------------------------------------------------------------
--Valida la cuenta de ahorro programado 
---------------------------------------------------------------------
select @w_nomcolumna = 'cc_cta_banco'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_cta_banco),
       191,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and a.cc_cta_banco not in (select ah_cta_banco from cob_externos..ah_cuenta_mig
						 where  ah_cta_banco = a.cc_cta_banco)

                               
-- ---------------------------------------------------------------------
-- - Valida el plazo del ahorro
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cc_plazo'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_plazo),
       182,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_plazo  is null                               
                               
-------------------------------
--VALIDAR la Cuota del ahorro
------------------------------- 
select @w_nomcolumna = 'cc_cuota'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_cuota),
       275,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_cuota < 0  

---------------------------- 
--VALIDAR Periodicidad del ahorro contractual
---------------------------- 

select @w_nomcolumna = 'cc_periodicidad'

insert into ah_log_mig
select convert(varchar, cc_profinal),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, cc_periodicidad),
   276,
   cc_profinal,
   cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_periodicidad  != 'M'

-------------------------------
--VALIDAR el resultado del valor de la cuota multiplicado por el plazo
------------------------------- 
select @w_nomcolumna = 'cc_monto_final'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_monto_final),
       277,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and  cc_monto_final != (cc_plazo * cc_cuota)

-------------------------------
--VALIDAR la interes del ahorro
------------------------------- 
select @w_nomcolumna = 'cc_intereses'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_intereses),
       36,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_intereses < 0  

-------------------------------
--VALIDAR el interes del ahorro
------------------------------- 
select @w_nomcolumna = 'cc_ptos_premio'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_ptos_premio),
       9,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_ptos_premio < 0  

---------------------------- 
--VALIDAR el Estado del ahorro contractual
---------------------------- 

select @w_nomcolumna = 'cc_estado'

insert into ah_log_mig
select convert(varchar, cc_profinal),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, cc_estado),
   278,
   cc_profinal,
   cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_estado not in ('A','I')

---------------------------------------------------------------------
--Valida la categoria de ahorro programado 
---------------------------------------------------------------------
select @w_nomcolumna = 'cc_categoria'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_categoria),
       14,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and a.cc_categoria not in (select ah_categoria from cob_externos..ah_cuenta_mig
						 where  ah_categoria = a.cc_categoria)
                               
-----------------------------------------------------
--VALIDAR la Fecha de creación
-----------------------------------------------------
select @w_nomcolumna = 'cc_fecha_crea'

insert into ah_log_mig
select convert(varchar, cc_profinal),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, cc_fecha_crea),
   44,
   cc_profinal,
   cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_fecha_crea > @w_fecha_proceso
              
--------------------------------------------------
--VALIDAR el Periodos de incumplimiento del ahorro
-------------------------------------------------- 
select @w_nomcolumna = 'cc_periodos_incump'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_periodos_incump),
       279,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and cc_periodos_incump < 0 

              
---------------------------------------------------------------------
--Valida el producto bancario de ahorro programado 
---------------------------------------------------------------------
select @w_nomcolumna = 'cc_prodbanc'

insert into ah_log_mig
select convert(varchar, cc_profinal),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cc_prodbanc),
       135,
       cc_profinal,
       cc_cta_banco
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and a.cc_prodbanc in(select pa_int from cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico = 'PAHCT')
and a.cc_prodbanc not in (select ah_prod_banc from cob_externos..ah_cuenta_mig
						 where  ah_prod_banc = a.cc_prodbanc)


insert into ah_log_mig
select convert(varchar, cc_profinal),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, cc_prodbanc),
   6,
   cc_profinal,
   cc_cta_banco   
from re_cuenta_contractual_mig a
where cc_profinal between @i_clave_i and @i_clave_f
and not exists (select 1 from cob_remesas..pe_pro_bancario pb  where pb.pb_pro_bancario=a.cc_prodbanc)
                               
 insert into ah_log_mig
select convert(varchar, cc_profinal),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, cc_prodbanc),
   214,
   cc_profinal,
   cc_cta_banco
from  cob_remesas..pe_pro_final, cob_remesas..pe_mercado, cob_remesas..pe_pro_bancario, cob_externos..ah_cuenta_mig, cob_externos..re_cuenta_contractual_mig 
where pf_sucursal in (select of_oficina  from cobis..cl_oficina  where  of_filial  = 1 and of_subtipo = 'R') 
and    pf_mercado = me_mercado 
and  cc_profinal = pf_pro_final
and me_pro_bancario = pb_pro_bancario
and pb_pro_bancario = ah_prod_banc
and ah_cuenta between @i_clave_i and @i_clave_f
and me_tipo_ente not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='cc_tipo_banca') ) 
   
-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update re_cuenta_contractual_mig set cc_estado_mig = 'VE'
where cc_profinal between @i_clave_i and @i_clave_f
and cc_profinal not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 're_cuenta_contractual_mig'
                  group by lm_id_reg)
and cc_estado_mig is null

update re_cuenta_contractual_mig set cc_estado_mig = 'ER'
where cc_profinal between @i_clave_i and @i_clave_f
and cc_estado_mig is null
return  0
go                               

                               