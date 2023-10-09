/************************************************************************/
/*      Archivo:                sp_valida_ah_cuenta.sp                  */
/*      Stored procedure:       sp_valida_ah_cuenta                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           MBA                                     */
/*      Fecha de escritura:     22-Jul-2015                             */
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
/*      Este programa realiza la migracion de apertura de cuenta        */
/*      de ahorros.                                                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR               RAZON                          */
/*  02/Mar/2016      Giovanny Cueva      Validacion Categorias          */
/************************************************************************/
use cob_externos
go

if exists (select * from sysobjects where name = 'sp_valida_ah_cuenta')
    drop proc sp_valida_ah_cuenta 
go

create proc sp_valida_ah_cuenta(
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
@w_fecha_proceso      datetime

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------

select @w_sp_name         = 'sp_valida_ah_cuenta_mig',
   @w_tabla           = 'ah_cuenta_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
   
select @w_conteo = count(1)
from    ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0

--- ---------------------------------------------------------------------------
-- - Validar las cuentas migradas 
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'ah_cuenta'
-- EL INDICE VALIDA ESTA QUE NO EXISTAN MÁS DE 1 ah_cuenta 
insert into ah_log_mig
select convert(varchar, ah_cuenta),
    @w_tabla,
    @w_sp_name,
    @w_nomcolumna,
    convert(varchar, ah_cuenta),
    289,
    ah_cuenta,
    ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where ah_cta_banco = ca_cta_banco_mig)


--- ---------------------------------------------------------------------------
-- - Validar si existen cuentas relacionadas
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'ah_cuenta'

insert into ah_log_mig
select convert(varchar, cm.ah_cuenta),
    @w_tabla,
    @w_sp_name,
    @w_nomcolumna,
    convert(varchar, cm.ah_cuenta),
    291,
    cm.ah_cuenta,
    cm.ah_cta_banco
from cob_externos..ah_cuenta_mig cm,  
      cobis..cl_parametro pa
where ah_cuenta between @i_clave_i and @i_clave_f
and  cm.ah_prod_banc = pa.pa_int
and   pa.pa_producto = 'AHO' and pa.pa_nemonico = 'PCAASA'
and   not exists (select 1 from cob_externos..ah_cuenta_mig b where b.ah_cta_banco = cm.ah_cta_banco_rel)


--- ---------------------------------------------------------------------------
-- - Validar que dentro de la tabla de cuentas no exista otra con igual código
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'ah_cuenta'
-- EL INDICE VALIDA ESTA QUE NO EXISTAN MÁS DE 1 ah_cuenta 
insert into ah_log_mig
select convert(varchar, ah_cuenta),
    @w_tabla,
    @w_sp_name,
    @w_nomcolumna,
    convert(varchar, ah_cuenta),
    210,
    ah_cuenta,
    ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
group by ah_cuenta, ah_cta_banco
having count(ah_cuenta) > 1

---------------------------- 
--VALIDAR ESTADO DE CUENTA
---------------------------- 

select @w_nomcolumna = 'ah_estado'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_estado),
   2,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_estado not in ( 'A', 'I', 'C')

---------------------------- 
--VALIDAR CONTROL
---------------------------- 
select @w_nomcolumna = 'ah_control'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_control),
   3,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_control != 0 

---------------------------- 
--VALIDAR FILIAL
---------------------------- 
select @w_nomcolumna = 'ah_filial'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_filial),
   4,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_filial != 1 

---------------------------
--VALIDAR OFICINA
---------------------------
select @w_nomcolumna = 'ah_oficina'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_oficina),
   5,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f 
and not exists (select 1 from cobis..cl_oficina ofi where ofi.of_oficina = a.ah_oficina ) 

------------------------------
--VALIDAR PRODUCTO BANCARIO
------------------------------ 


select @w_nomcolumna = 'ah_prod_banc'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_prod_banc),
   6,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and not exists (select 1 from cob_remesas..pe_pro_bancario pb  where pb.pb_pro_bancario=a.ah_prod_banc)

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_prod_banc),
   214,
   ah_cuenta,
   ah_cta_banco
   from  cob_remesas..pe_pro_final, cob_remesas..pe_mercado, cob_remesas..pe_pro_bancario, cob_externos..ah_cuenta_mig
   where pf_sucursal in (select of_oficina  from cobis..cl_oficina  where  of_filial  = 1 and of_subtipo = 'R') 
   and    pf_mercado = me_mercado 
   and me_pro_bancario = pb_pro_bancario
   and pb_pro_bancario = ah_prod_banc
   and ah_cuenta between @i_clave_i and @i_clave_f
   and me_tipo_ente not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='cc_tipo_banca') ) 


--- ---------------------------------------------------------------------------
-- - Validar si la categoria es E el cliente sea Tipo Extrangero
-- ----------------------------------------------------------------------------

select @w_nomcolumna = 'ah_cliente'
insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cliente),
   224,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and not exists (select 1 from cobis..cl_ente e  where en_ente = x.ah_cliente and p_ciudad_nac != 68 )

--- ---------------------------------------------------------------------------
-- - Validar si el cliente sea es Persona Juridica y Persona Natural
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'ah_cliente'
insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cliente),
   225,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and not exists (select 1 from cobis..cl_ente e   where en_ente = x.ah_cliente and en_subtipo in ('C','P'))

--- ---------------------------------------------------------------------------
-- - Validar si el cliente sea es Persona Natural
-- ----------------------------------------------------------------------------
/*select @w_nomcolumna = 'ah_cliente'
insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cliente),
   234,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and not exists (select 1 from cobis..cl_ente where en_ente = x.ah_cliente and en_subtipo = 'P')        */           

---------------------------- 
--VALIDAR TIPO
---------------------------- 
select @w_nomcolumna = 'ah_tipo'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipo),
   7,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipo != 'R' 

-----------------------------
--VALIDAR LA MONEDA
-----------------------------
select @w_nomcolumna = 'ah_moneda'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_moneda),
   8,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_moneda not in (0)

-------------------------------
--VALIDAR LA FECHA DE APERTURA
------------------------------- 
select @w_nomcolumna = 'ah_fecha_aper'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_aper),
   9,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_aper > @w_fecha_proceso

-----------------------------------------------------                         
--VALIDAR LA EXISTENCIA DEL OFICIAL DE CREDITO
-----------------------------------------------------  
select @w_nomcolumna = 'ah_oficial'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_oficial),
   10,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_oficial = 0

select @w_nomcolumna = 'ah_oficial'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_oficial),
   11,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f 
and not exists (select 1 from cobis..cc_oficial ofi  where oc_oficial = a.ah_oficial)                                                     
                         
-----------------------------
--VALIDAR LA CEDULA O RUC
-----------------------------
select @w_nomcolumna = 'ah_ced_ruc'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_ced_ruc),
   12,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f 
and exists (select 1 from cobis..cl_ente e  where a.ah_cliente = e.en_ente and a.ah_ced_ruc != e.en_ced_ruc ) 
                         

-----------------------------
--VALIDAR NOMBRE
-----------------------------
select @w_nomcolumna = 'ah_nombre'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_nombre),
   13,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_nombre = ''


-----------------------------
--VALIDAR LA CATEGORIA
-----------------------------
select @w_nomcolumna = 'ah_categoria'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_categoria),
   14,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_categoria not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='pe_categoria') ) 

--------------------------------------
select @w_nomcolumna = 'ah_categoria'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_categoria),
   293,
   ah_cuenta,
   ah_cta_banco
from cob_externos..ah_cuenta_mig a
   where ah_cuenta between @i_clave_i and @i_clave_f 
   and ah_categoria not in (select cp_categoria  from cob_remesas..pe_categoria_profinal, cob_remesas..pe_pro_final,cob_remesas..pe_mercado
   where cp_profinal =pf_pro_final   and    pf_mercado = me_mercado 
   and me_pro_bancario = a.ah_prod_banc)
                         
-----------------------------
--VALIDAR TIPO PROMEDIO
-----------------------------
select @w_nomcolumna = 'ah_tipo_promedio'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipo_promedio),
   15,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipo_promedio != 'M' 

-----------------------------
--VALIDAR LA CAPITALIZACION
-----------------------------
select @w_nomcolumna = 'ah_capitalizacion'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_capitalizacion),
   16,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_capitalizacion != 'M' 

-------------------------------------
--VALIDAR EL CICLO DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'ah_ciclo'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_ciclo),
   17,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_ciclo   not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='ah_ciclo')) 

---------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO EL NUM DE SUSPENSOS EN AH_VAL_SUSPENSO
---------------------------------------------------------------------
select @w_nomcolumna = 'ah_suspensos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_suspensos),
   18,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_suspensos <> 0

---------------------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO NUM DE BLOQUEOS DE MOVIMIENTOS EN AH_CTABLOQUEADA
---------------------------------------------------------------------------------
select @w_nomcolumna = 'ah_bloqueos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_bloqueos),
   19,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_bloqueos < 0

---------------------------------------------------
--VALIDA SI TIENE REGISTRADO CONDICIONES EN FIRMAS
---------------------------------------------------
select @w_nomcolumna = 'ah_condiciones'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_condiciones),
   20,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_condiciones < 0

---------------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO MONTO DE BLOQUEO DE VALORES EN AH_HIS_BLOQUEO
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_monto_bloq'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_monto_bloq),
   21,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_bloq < 0

---------------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO NUM DE BLOQUEOS DE VALORES EN AH_HIS_BLOQUEO
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_num_blqmonto'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_num_blqmonto),
   22,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_num_blqmonto < 0

-------------------------------------
--VALIDAR SI TIENE CREDITO  DE LA CUENTA
-------------------------------------
select @w_nomcolumna = 'ah_cred_24'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cred_24),
   262,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_cred_24 <> null
and ah_cred_24  != 'N' 
---------------------------------------------------------------------------
--VALIDA CREDITOS REMESAS
---------------------------------------------------------------------------

select @w_nomcolumna = 'ah_cred_rem'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cred_rem),
   23,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_cred_rem != 'N' 

---------------------------------
--VALIDA ROL DE ENTE TIPO DEF D , C
---------------------------------
select @w_nomcolumna = 'ah_tipo_def'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipo_def),
   24,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_tipo_def not in ('D','C')

---------------------------------
--VALIDA EL CODIGO DEL CLIENTE O CUENTA QUE ESTA PERSONALIZANDO 
---------------------------------
select @w_nomcolumna = 'ah_default'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_default),
   261,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f 
and ah_default != 0 

---------------------------------
--VALIDA ROL DE ENTE TIPO DEF 1
---------------------------------
select @w_nomcolumna = 'ah_rol_ente'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_rol_ente),
   25,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_rol_ente <> '1'


-------------------------------
--VALIDAR EL SALDO DE LA CUENTA
------------------------------- 
select @w_nomcolumna = 'ah_disponible'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_disponible),
   26,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_disponible < 0

select @w_nomcolumna = 'ah_disponible'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_disponible),
   251,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_disponible < (ah_monto_bloq+ah_monto_emb)

--------------------------------------------------
--VALIDAR 12H Valor de cheques propios depositados
--------------------------------------------------
select @w_nomcolumna = 'ah_12h'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_12h),
   27,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_12h < 0

------------------------------------------------------------
--VALIDAR 12H Valor de cheques propios depositados diferidos
------------------------------------------------------------
select @w_nomcolumna = 'ah_12h_dif'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_12h_dif),
   28,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_12h_dif < 0


---------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO CHQ LOCAL RETENIDO EN CIUDAD DEPOSITO
---------------------------------------------------------------------
select @w_nomcolumna = 'ah_24h'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_24h),
   29,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_24h < 0


--------------------------------------------------------
--VALIDAR 48H Valor de Cheques Otras Plazas depositados
--------------------------------------------------------
select @w_nomcolumna = 'ah_48h'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_48h),
   30,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_48h < 0


-------------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO CHQ DEL EXTERIOR EN  RE_CARTA, RE_DET_CARTA
-------------------------------------------------------------------------
select @w_nomcolumna = 'ah_remesas'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_remesas),
   31,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_remesas < 0

-------------------------------------------------------------------------
--VALIDA SI TIENE REGISTRADO CHQ DEL EXTERIOR EN  RE_CARTA, RE_DET_CARTA
-------------------------------------------------------------------------
select @w_nomcolumna = 'ah_rem_hoy'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_rem_hoy),
   32,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_rem_hoy < 0

--------------------------------------------------------
--VALIDAR campo ah_interes Interes
--------------------------------------------------------
select @w_nomcolumna = 'ah_interes'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_interes),
   33,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_interes < 0

--------------------------------------------------------
--VALIDAR campo ah_interes_ganado Interes provisionado
-------------------------------------------------------- 
select @w_nomcolumna = 'ah_interes_ganado'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_interes_ganado),
   34,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_interes_ganado < 0

------------------------------------------------------------------------------
--VALIDAR campo ah_saldo_libreta Saldo de Transacciones realizadas con libreta
------------------------------------------------------------------------------
select @w_nomcolumna = 'ah_saldo_libreta < 0'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_libreta),
   35,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_libreta < 0

--------------------------------------------
--VALIDA QUE NO HAYA SALDO_INTERES NEGATIVO
--------------------------------------------
select @w_nomcolumna = 'ah_saldo_interes'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_interes),
   36,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_interes < 0

--------------------------------------------------------
--VALIDAR campo ah_saldo_anterior Saldo Anterior
--------------------------------------------------------
select @w_nomcolumna = 'ah_saldo_anterior'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_anterior),
   37,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_anterior < 0

---------------------------------------------------------------
--VALIDAR campo ah_saldo_ult_corte Saldo Final del Ultimo Corte 
---------------------------------------------------------------
select @w_nomcolumna = 'ah_saldo_ult_corte'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_ult_corte),
   38,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_ult_corte < 0

----------------------------------------------------
--VALIDAR campo ah_saldo_ayer Saldo del Dia Anterior
----------------------------------------------------
select @w_nomcolumna = 'ah_saldo_ayer'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_ayer),
   39,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_ayer < 0

-----------------------------------------------------
--VALIDAR campo ah_creditos Total de Creditos del Mes
-----------------------------------------------------
select @w_nomcolumna = 'ah_creditos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos),
   40,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos < 0

-----------------------------------------------------
--VALIDAR campo ah_debitos Total de Debitos del Mes
-----------------------------------------------------
select @w_nomcolumna = 'ah_debitos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos),
   41,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos < 0

---------------------------------------------------------
--VALIDAR campo ah_creditos_hoy Total de Creditos del Mes
---------------------------------------------------------
select @w_nomcolumna = 'ah_creditos_hoy'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos_hoy),
   42,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos_hoy < 0

--------------------------------------------------------
--VALIDAR campo ah_interes Interes
--------------------------------------------------------
select @w_nomcolumna = 'ah_debitos_hoy'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos_hoy),
   43,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos_hoy < 0

-----------------------------------------------------
--VALIDAR ah_fecha_ult_mov Fecha de Ultimo Movimiento
-----------------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_mov'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_mov),
   44,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_mov > @w_fecha_proceso

---------------------------------------------------------
--VALIDAR ah_fecha_ult_mov_int Fecha de Ultimo Movimiento
---------------------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_mov_int'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_mov_int),
   45,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_mov_int > @w_fecha_proceso

-----------------------------------------------------
--VALIDAR ah_fecha_ult_upd Fecha de Ultimo Movimiento
-----------------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_upd'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_upd),
   46,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_upd > @w_fecha_proceso

-----------------------------------------------------
--VALIDAR ah_fecha_prx_corte
-----------------------------------------------------
select @w_nomcolumna = 'ah_fecha_prx_corte'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_prx_corte),
   47,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_prx_corte > @w_fecha_proceso

-----------------------------------------------------
--VALIDAR ah_fecha_ult_corte
-----------------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_corte'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_corte),
   48,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_corte > @w_fecha_proceso

----------------------------------------------------------
--VALIDAR ah_fecha_ult_capi Fecha de Ultima Capitalizacion
----------------------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_capi'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_capi),
   49,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_capi > @w_fecha_proceso

----------------------------------------------------------
--VALIDAR ah_fecha_prx_capita
----------------------------------------------------------
select @w_nomcolumna = 'ah_fecha_prx_capita'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_prx_capita),
   50,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_prx_capita < @w_fecha_proceso

----------------------------------------------------------
--VALIDAR ah_linea
----------------------------------------------------------
select @w_nomcolumna = 'ah_linea'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_linea),
   51,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_linea < 0

----------------------------------------------------------
--VALIDAR ah_ult_linea
----------------------------------------------------------
select @w_nomcolumna = 'ah_ult_linea'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_ult_linea),
   52,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_ult_linea <> 0

--------------------------------------------------------
--VALIDAR campo ah_interes Interes
--------------------------------------------------------
select @w_nomcolumna = 'ah_interes'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_interes),
   33,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_interes < 0

----------------------------------------------------------
--VALIDAR ah_cliente_ec
----------------------------------------------------------
select @w_nomcolumna = 'ah_cliente_ec'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cliente_ec),
   53,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_cliente_ec <> 0
and not exists (select 1 from cobis..cl_ente e   where en_ente = x.ah_cliente_ec and en_subtipo in ('C','P'))

----------------------------------------------------------
--VALIDAR ah_direccion_ec
----------------------------------------------------------
select @w_nomcolumna = 'ah_direccion_ec'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_direccion_ec),
   54,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_direccion_ec <> 0
and not exists (select 1 from cobis..cl_direccion e   where di_direccion = x.ah_direccion_ec )

----------------------------------------------------------
--VALIDAR ah_descripcion_ec
----------------------------------------------------------
select @w_nomcolumna = 'ah_descripcion_ec'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_descripcion_ec),
   55,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_descripcion_ec = ''

----------------------------------------------------------
--VALIDAR ah_tipo_dir
----------------------------------------------------------
select @w_nomcolumna = 'ah_tipo_dir'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipo_dir),
   56,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipo_dir not in (select codigo from cobis..cl_catalogo where tabla =(select codigo from cobis..cl_tabla where tabla ='cl_direccion_ec'))

/*----------------------------------------------------------
--VALIDAR w_ah_agen_ec
----------------------------------------------------------
select @w_nomcolumna = 'ah_agen_ec'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_agen_ec),
   57,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_agen_ec <> 0*/

----------------------------------------------------------
--VALIDAR ah_parroquia
----------------------------------------------------------
select @w_nomcolumna = 'ah_parroquia'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_parroquia),
   58,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_parroquia <> 0
and ah_tipo_dir ='D'
and ah_parroquia not in (select di_parroquia from cobis..cl_direccion where di_direccion = x.ah_direccion_ec)

----------------------------------------------------------
--VALIDAR ah_zona
----------------------------------------------------------
select @w_nomcolumna = 'ah_zona'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_zona),
   59,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_zona <> 0

----------------------------------------------------------
--VALIDAR ah_prom_disponible
----------------------------------------------------------
select @w_nomcolumna = 'ah_prom_disponible'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_prom_disponible),
   60,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_prom_disponible < 0

----------------------------------------------------------
--VALIDAR ah_promedio1
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio1'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio1),
   61,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio1 < 0

----------------------------------------------------------
--VALIDAR ah_promedio2
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio2'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio2),
   62,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio2 < 0

----------------------------------------------------------
--VALIDAR ah_promedio3
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio3'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio3),
   63,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio3 < 0

----------------------------------------------------------
--VALIDAR ah_promedio4
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio4'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio4),
   64,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio4 < 0


----------------------------------------------------------
--VALIDAR ah_promedio5
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio5'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio5),
   65,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio5 < 0

----------------------------------------------------------
--VALIDAR ah_promedio6
----------------------------------------------------------
select @w_nomcolumna = 'ah_promedio6'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promedio6),
   66,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promedio6 < 0

---------------------------------------------------------------------------
--VALIDA ah_personalizada
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_personalizada'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_personalizada),
   67,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_personalizada not in ('S','N')


----------------------------------------------------------
--VALIDAR ah_contador_trx
----------------------------------------------------------
select @w_nomcolumna = 'ah_contador_trx'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_contador_trx),
   68,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_contador_trx < 0

---------------------------------------------------------------------------
--VALIDA ah_cta_funcionario
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_cta_funcionario'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cta_funcionario),
   69,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_cta_funcionario not in ('S','N')



-------------------------------------
--VALIDAR EL ORIGEN DE CAPTACION
-------------------------------------
select @w_nomcolumna = 'ah_origen'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_origen),
   70,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f 
and not exists ( select 1 from cobis..cl_tabla t  inner join cobis..cl_catalogo c  on (t.tabla = 'ah_tipocta' and t.codigo = c.tabla) 
            where c.codigo = a.ah_origen )
                               
----------------------------------------------------------
--VALIDAR ah_numlib
----------------------------------------------------------
select @w_nomcolumna = 'ah_numlib'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_numlib),
   263,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_numlib < 0

----------------------------------------------------------
--VALIDAR ah_contador_firma
----------------------------------------------------------
select @w_nomcolumna = 'ah_dep_ini'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_dep_ini),
   71,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_dep_ini < 0 and ah_dep_ini > 1 

                                
----------------------------------------------------------
--VALIDAR ah_contador_firma
----------------------------------------------------------
select @w_nomcolumna = 'ah_contador_firma'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_contador_firma),
   72,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_contador_firma < 0

----------------------------------------------------------
--VALIDAR ah_telefono
----------------------------------------------------------
select @w_nomcolumna = 'ah_telefono'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_telefono),
   73,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_telefono is null

----------------------------------------------------------
--VALIDAR ah_int_hoy
----------------------------------------------------------
select @w_nomcolumna = 'ah_int_hoy'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_int_hoy),
   74,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_int_hoy < 0
----------------------------------------------------------
--VALIDAR ah_tasa_hoy
----------------------------------------------------------
select @w_nomcolumna = 'ah_tasa_hoy'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tasa_hoy),
   75,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tasa_hoy < 0

---------------------------------------------------------------------------
--VALIDA ah_tipocta
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_tipocta'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipocta),
   87,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipocta not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='cc_tipo_banca'))

---------------------------------------------------------------------------
--VALIDA ah_tipocta que exista en el mercado 
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_tipocta'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipocta),
   292,
   ah_cuenta,
   ah_cta_banco
from cob_externos..ah_cuenta_mig a
   where ah_cuenta between  @i_clave_i and @i_clave_f
   and ah_tipocta not in (select me_tipo_ente  from cob_remesas..pe_mercado where a.ah_prod_banc = me_pro_bancario)

----------------------------------------------------------
--VALIDAR ah_min_dispmes
----------------------------------------------------------
select @w_nomcolumna = 'ah_min_dispmes'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_min_dispmes),
   76,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_min_dispmes <> 0

-----------------------------------------------
--VALIDAR LA FECHA DE APERTURA ah_fecha_ult_ret
-----------------------------------------------
select @w_nomcolumna = 'ah_fecha_ult_ret'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_fecha_ult_ret),
   77,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_fecha_ult_ret > @w_fecha_proceso

--------------------------------------------
--VALIDAR EL CODIGO DE COTITULAR ah_cliente1
--------------------------------------------
select @w_nomcolumna = 'ah_cliente1'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cliente1),
   78,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and a.ah_cliente1 <> 0

----------------------------------------------------------
--VALIDAR ah_nombre1
----------------------------------------------------------
select @w_nomcolumna = 'ah_nombre1'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_nombre1),
   79,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_nombre1 <> ''

------------------------------------
--VALIDAR LA CEDULA O RUC ah_cedruc1
------------------------------------
select @w_nomcolumna = 'ah_cedruc1'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_cedruc1),
   80,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and a.ah_cedruc1 <> '0'

----------------------------------------------------------
--VALIDAR ah_sector
----------------------------------------------------------
select @w_nomcolumna = 'ah_sector'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_sector),
   81,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_sector < 0

----------------------------------------------------------
--VALIDAR ah_monto_imp
----------------------------------------------------------
select @w_nomcolumna = 'ah_monto_imp'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_monto_imp),
   82,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_imp <> 0

----------------------------------------------------------
--VALIDAR ah_monto_consumos
----------------------------------------------------------
select @w_nomcolumna = 'ah_monto_consumos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_monto_consumos),
   83,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_consumos <> 0

---------------------------------------------------------------------------
--VALIDA ah_ctitularidad
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_ctitularidad'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_ctitularidad),
   84,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_ctitularidad not in ('I','M','S')

----------------------------------------------------------
--VALIDAR ah_promotor
----------------------------------------------------------
select @w_nomcolumna = 'ah_promotor'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_promotor),
   85,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_promotor < 0

----------------------------------------------------------
--VALIDAR ah_int_mes
----------------------------------------------------------
select @w_nomcolumna = 'ah_int_mes'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_int_mes),
   86,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_int_mes < 0

---------------------------------------------------------------------------
--VALIDA ah_tipocta_super
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_tipocta_super'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipocta_super),
   87,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipocta_super not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='ah_cla_cliente'))

---------------------------------------------------------------------------
--VALIDA ah_direccion_dv
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_direccion_dv'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_direccion_dv),
   88,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig x
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_direccion_dv <> 0
and not exists (select 1 from cobis..cl_direccion e   where di_direccion = x.ah_direccion_dv )

---------------------------------------------------------------------------
--VALIDA ah_tipodir_dv
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_tipodir_dv'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tipodir_dv),
   89,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tipodir_dv not in ('C','D','R')

---------------------------------------------------------------------------
--VALIDA ah_parroquia_dv
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_parroquia_dv'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_parroquia_dv),
   90,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_parroquia_dv < 0

---------------------------------------------------------------------------
--VALIDA ah_zona_dv
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_zona_dv'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_zona_dv),
   91,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_zona_dv < 0

---------------------------------------------------------------------------
--VALIDA ah_agen_dv
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_agen_dv'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_agen_dv),
   92,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_agen_dv < 0

---------------------------------------------------------------------------
--VALIDA ah_monto_emb
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_monto_emb'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_monto_emb),
   93,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_emb < 0

---------------------------------------------------------------------------
--VALIDA ah_monto_ult_capi
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_monto_ult_capi'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_monto_ult_capi),
   94,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_ult_capi < 0

---------------------------------------------------------------------------
--VALIDA ah_saldo_mantval
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_saldo_mantval'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_saldo_mantval),
   95,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_saldo_mantval < 0

---------------------------------------------------------------------------
--VALIDA ah_creditos2
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_creditos2'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos2),
   96,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos2 < 0

---------------------------------------------------------------------------
--VALIDA ah_creditos3
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_creditos3'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos3),
   97,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos3 < 0

---------------------------------------------------------------------------
--VALIDA ah_creditos4
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_creditos4'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos4),
   98,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos4 < 0

---------------------------------------------------------------------------
--VALIDA ah_creditos5
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_creditos5'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos5),
   99,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos5 < 0

---------------------------------------------------------------------------
--VALIDA ah_creditos6
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_creditos6'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_creditos6),
   100,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_creditos6 < 0

---------------------------------------------------------------------------
--VALIDA ah_debitos2
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_debitos2'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos2),
   101,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos2 < 0

---------------------------------------------------------------------------
--VALIDA ah_debitos3
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_debitos3'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos3),
   102,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos3 < 0

---------------------------------------------------------------------------
--VALIDA ah_debitos4
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_debitos4'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos4),
   103,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos4 < 0

---------------------------------------------------------------------------
--VALIDA ah_debitos5
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_debitos5'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos5),
   104,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos5 < 0

---------------------------------------------------------------------------
--VALIDA ah_debitos6
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_debitos6'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_debitos6),
   105,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_debitos6 < 0

---------------------------------------------------------------------------
--VALIDA ah_tasa_ayer
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_tasa_ayer'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_tasa_ayer),
   106,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_tasa_ayer < 0

---------------------------------------------------------------------------
--VALIDA ah_estado_cuenta
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_estado_cuenta'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_estado_cuenta),
   107,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_estado_cuenta not in ('S','N')

---------------------------------------------------------------------------
--VALIDA ah_permite_sldcero
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_permite_sldcero'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_permite_sldcero),
   108,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_permite_sldcero not in ('S','N')

---------------------------------------------------------------------------
--VALIDA ah_rem_ayer
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_rem_ayer'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_rem_ayer),
   109,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_rem_ayer < 0

---------------------------------------------------------------------------
--VALIDA ah_numsol
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_numsol'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
   @w_tabla,
   @w_sp_name,
   @w_nomcolumna,
   convert(varchar, ah_numsol),
   110,
   ah_cuenta,
   ah_cta_banco
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_numsol < 0

--------------------------------------------------------                               
--Valida la Clase de la cuenta
---------------------------------------------------------------------
select @w_nomcolumna = 'ah_clase_clte'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_clase_clte),
       226,
       ah_cuenta,
       ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_clase_clte <> null
and ah_clase_clte not in ('P','O') 


---------------------------------------------------------------------------
--VALIDA ah_disponible > ah_prom_disponible
---------------------------------------------------------------------------
select @w_nomcolumna = 'ah_prom_disponible'

insert into ah_log_mig 
select 
    convert(varchar, ah_cuenta)         ,
    @w_tabla                            ,
    @w_sp_name                          ,
    @w_nomcolumna                       ,
    convert(varchar, ah_disponible) + convert(varchar, ah_prom_disponible) ,
    259                                 ,
    ah_cuenta,
    ah_cta_banco    
from ah_cuenta_mig
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_prom_disponible > ah_disponible

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_cuenta_mig set ah_estado_mig = 'VE'
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_cuenta not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_cuenta_mig'
                  group by lm_id_reg)
and ah_estado_mig is null

update ah_cuenta_mig set ah_estado_mig = 'ER'
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_estado_mig is null
return  0
go 


