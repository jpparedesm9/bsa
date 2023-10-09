/*********************************************************************/
/*   Archivo:                conente.sp                              */
/*   Stored procedure:       sp_consulta_ente                        */
/*   Base de datos:          cob_pfijo                               */
/*   Producto:               Plazo_fijo                              */
/*   Disenado por:           Katty Tamayo                            */
/*   Fecha de documentacion: 16/Mar/05                               */
/*********************************************************************/
/*                           IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de   */
/*   'MACOSA', representantes exclusivos para el Ecuador de la       */
/*   'NCR CORPORATION'.                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como      */
/*   cualquier alteracion o agregado hecho por alguno de sus         */
/*   usuarios sin el debido consentimiento por escrito de la         */
/*   Presidencia Ejecutiva de MACOSA o su representante.             */
/*********************************************************************/
/*                           PROPOSITO                               */
/*   Este procedimiento almacenado realiza la consulta de los datos  */
/*   requeridos para la solicitud de apertura                        */
/*********************************************************************/
/*                           MODIFICACIONES                          */
/*   FECHA       AUTOR             RAZON                             */
/*   16/Mar/05   Katty Tamayo      Emision Inicial                   */
/*   27/Ago/05   Trosky Vinueza    Visualizar informacion para uno   */
/*                                 o mas clientes                    */
/*   29/Oct/05   Luis Im           Correccion de datos visualizacion */
/*                                 de registros duplicados           */ 
/*   19/NOV/05   Luis Im           Se obtiene nombre del banco ach   */
/*   17/Ago/16   Alex Montesdeoca  DPF-B81213                        */
/*********************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_ente')
   drop proc sp_consulta_ente
go

create proc sp_consulta_ente (
   @s_ssn            int         = null,
   @s_user           login       = null,
   @s_sesn           int         = null,
   @s_term           varchar(30) = null,
   @s_date           datetime    = null,
   @s_srv            varchar(30) = null,
   @s_lsrv           varchar(30) = null,
   @s_ofi            smallint    = null,
   @s_rol            smallint    = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = null,
   @t_from           varchar(32) = null,
   @t_trn            smallint,
   @i_id_operacion   int,
   @i_modo           smallint,
   @i_filial         int         = 1,   --LIM 19/NOV/2005   
   @i_formato_fecha  int         = 101
)
with encryption
as
declare @w_sp_name            varchar(32),
        @w_codigo             int,
        @w_ente               int,
        @w_nombre             varchar(60),
        @w_banco              varchar(20),
        @w_firma              varchar(20),
        @w_cliente            int , 
        @w_di_descripcion     varchar(254),
        @w_di_direccion       tinyint     ,
        @w_ci_descripcion     varchar(64) , 
        @w_te_valor           varchar(16) ,
        @w_email              varchar(254), 
        @w_celular            varchar(16) ,
        @w_fax                varchar(16) , 
        @w_telefax            varchar(16) , 
        @w_corregimiento      varchar(64) ,   --parroquia                     
        @w_barrio             varchar(40) ,
        @w_calle              varchar(20) ,
        @w_casa               varchar(20) , 
        @w_edificio           varchar(254),
        @w_pais               varchar(20),   
        @w_trabajo            int,      
        @w_ttrabajo           varchar(16),
        @w_banco_corto        char(64),
        @w_cod_dir_emp        varchar(30),
        @w_cod_dir_res        varchar(30),
        @w_cod_dir_elect      varchar(30),
        @w_tabla_act_ec       smallint,
        @w_tabla_tipo_per     smallint,
        @w_op_ente_corresp    int,
        @w_op_ente            int,
        @w_op_direccion       tinyint,
        @w_op_casilla         tinyint,
        @w_cs_valor           varchar(24),
        @w_cs_provincia       smallint,
        @w_pv_descripcion     descripcion,
        @w_pv_pais            smallint,
        @w_pa_descripcion     descripcion
        
        
-- Consulta del codigo de direccion de empresa
select @w_cod_dir_emp = pa_char
from cobis..cl_parametro
where pa_producto = 'MIS'
and   pa_nemonico = 'TDE'

-- Consulta del codigo de direccion de residencia
select @w_cod_dir_res = pa_char
from cobis..cl_parametro
where pa_producto = 'MIS'
and   pa_nemonico = 'TDR'

-- Consulta del codigo de direccion electronica (email)
select @w_cod_dir_elect = pa_char
from cobis..cl_parametro
where pa_producto = 'MIS'
and   pa_nemonico = 'TDW'

-----------------------------------
-- Obtener nombre corto del banco
-----------------------------------
select  @w_banco_corto = b.valor
  from cobis..cl_tabla a, cobis..cl_catalogo b
 where a.codigo = b.tabla
   and a.tabla = 'cl_nombre_banco'
   and b.codigo = '2'


-----------------------------
--Inicializacion de Variables
-----------------------------
select @w_sp_name = 'sp_consulta_ente',
       @w_banco   = @w_banco_corto

--------------------------
--Codigos de Transacciones
--------------------------
if (@t_trn <> 14550)
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141112  --Error en codigo de transaccion
   return 1
end


------------------------------------
--Condiciones sin Firmas Autorizadas
------------------------------------
select CONDICION   = be_condicion,
       NOMBRE      = en_nomlar,                        
       COD_CLIENTE = be_ente,
       SEC         = case 
                          when be_tipo = 'T' and be_rol = 'T' then 1
                          when be_tipo = 'T' and be_rol = 'A' then 2
                          when be_tipo = 'F' then 3
                          end
  into #temporal_condicion
  from pf_beneficiario,
       cobis..cl_ente 
  where be_operacion = @i_id_operacion
    and be_ente = en_ente 
    and be_estado_xren = 'N'
    and be_tipo = 'T'
  order by SEC

------------------------------------
--Condiciones con Firmas Autorizadas
------------------------------------
select CONDICION   = be_condicion,
       NOMBRE      = p_p_apellido +' '+ p_s_apellido +' '+ en_nombre,
       COD_CLIENTE = be_ente,
       SEC         = case 
                          when be_tipo = 'T' and be_rol = 'T' then 1
                          when be_tipo = 'T' and be_rol = 'A' then 2
                          when be_tipo = 'F' then 3
                          end
  into #temporal_firmas
  from pf_beneficiario,
       cobis..cl_ente 
  where be_operacion = @i_id_operacion
    and be_ente = en_ente 
    and be_estado_xren = 'N'
  order by SEC


---------------
--Beneficiarios
---------------

select 'ENTE'           = be_ente,
       'SEC'            = case 
                          when be_tipo = 'T' and be_rol = 'T' then 1
                          when be_tipo = 'T' and be_rol = 'A' then 2
                          when be_tipo = 'F' then 3
                          end,
       'OPERACION'      = be_operacion,
       'FIRMA'          = case be_tipo 
                          when 'T' then 'TITULAR' 
                          when 'F' then 'FIRMA AUTORIZADA'
                          end,
       'BE_TIPO'        = be_tipo
  into #temporal_beneficiarios
  from pf_operacion,
       pf_beneficiario
 where op_operacion = @i_id_operacion
   and be_operacion = op_operacion
   and be_estado    = 'I'
order by SEC

select @w_tabla_act_ec = codigo
from cobis..cl_tabla
where tabla = 'cl_actividad'

-----------------
--Datos Generales
-----------------
select en_ente, 
       p_p_apellido,
       p_s_apellido,
       en_nombre,
       p_s_nombre = '', 
       p_c_apellido = '',
       en_nomlar,
       p_sexo,
       'p_fecha_nac'=convert(varchar(10),p_fecha_nac,103),
       p_num_cargas,
       en_tipo_ced,
       en_ced_ruc,
       en_digito,
       p_estado_civil,
       p_tipo_vivienda,
       p_profesion,
       (select valor from cobis..cl_catalogo where tabla = @w_tabla_act_ec and codigo = E.en_actividad ) as ac_descripcion,
       en_pais 
  into #temporal_datos_generales
  from #temporal_beneficiarios,
       cobis..cl_ente E
 where ENTE = en_ente
 order by SEC 


--------------
--Estado Civil
--------------
select en_ente, 
       b.valor
  into #temporal_estado_civil
  from #temporal_beneficiarios,
       cobis..cl_ente,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where ENTE = en_ente
   and p_estado_civil = b.codigo
   and a.tabla        = 'cl_ecivil' 
   and a.codigo       = b.tabla   
 order by SEC


---------------
--Tipo Vivienda
---------------
select en_ente, 
       b.valor
  into #temporal_tipo_vivienda
  from #temporal_beneficiarios,
       cobis..cl_ente,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where ENTE = en_ente
   and p_tipo_vivienda = b.codigo
   and a.tabla         = 'cl_tipo_vivienda' 
   and a.codigo        =  b.tabla
 order by SEC


-----------
--Profesion
-----------
select en_ente, 
       b.valor
  into #temporal_profesion
  from #temporal_beneficiarios,
       cobis..cl_ente,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where ENTE = en_ente
   and p_profesion = b.codigo
   and a.tabla     = 'cl_profesion' 
   and a.codigo    =  b.tabla
 order by SEC



--------------
--Nacionalidad
--------------
select en_ente, 
       pa_nacionalidad,
       pa_descripcion
  into #temporal_nacionalidad
  from #temporal_beneficiarios,
       cobis..cl_ente,
       cobis..cl_pais
 where ENTE    = en_ente
   and en_pais = pa_pais
 order by SEC


------------------
--Direccion Empleo
------------------
select en_ente, 
       'direccionemp'= --case      
                       --   when tr_empresa>0 then  
                             isnull(di_descripcion, '') --direccion
                       --   else  
                       --      isnull(tr_direccion_emp, '')
                       --end
       ,di_direccion
  into #temporal_oficina
  from #temporal_beneficiarios,
       cobis..cl_ente,
       cobis..cl_direccion,
       cobis..cl_trabajo 
 where ENTE             = en_ente
   and tr_persona       = en_ente
   --and tr_vigencia      = 'S'
   and tr_fecha_salida is null
   and en_ente          = di_ente          
   and di_tipo          = @w_cod_dir_emp   -- EMPRESA
   --and di_vigencia      = 'S'
   -- and di_verificado    = 'S'
 order by SEC


----------------------------------------------------------------------------
--Datos Empleo Cursor para traera la informacion de todos los beneficiarios
----------------------------------------------------------------------------

create table #tmp_empleo
              (
               ente                    int,                           
               cargo                   varchar(150) null,
               nombre_empresa          varchar(150) null, 
               fecha_inicio_labores    varchar(10)  null,
               ingreso_mensual         varchar(50)  null,
               actividad_empresa       varchar(150) null, 
               direccion_empleo        varchar(150) null              
               )  

create table #temporal_domicilio_telef
              (
               en_ente            int,                           
               di_descripcion     char(64)  null,
               pv_descripcion     char(64)  null, 
               di_direccion       tinyint   null,
               ci_descripcion     char(64)  null,
               te_valor           char(16)  null, 
               pa_descripcion     char(20)  null,
               CORREGIMIENTO      char(64)  null,   --parroquia                     
               BARRIO             char(40)  null,
               CALLE              char(20)  null,
               CASA               char(20)  null, 
               EDIFICIO           char(64)  null,
               EMAIL              char(64)  null,                 
               CELULAR            char(16)  null,
               FAX                char(16)  null,
               TELEFAX            char(16)  null,
               te_trabajo         char(16)  null
               )


create table #referencias
              (
               re_ente            int,                           
               re_nombre          varchar(100) null,
               re_tipo            varchar(1)   null, 
               re_descripcion     varchar(100) null, 
               re_clase           varchar(64)  null,
               re_telefono        varchar(64)  null
               )


DECLARE empleos CURSOR FOR
       select 
            ENTE
       from #temporal_beneficiarios
	   order by ENTE    --AMH 17/Ago/2016 DPF-B81213

       OPEN empleos
       FETCH empleos INTO
         @w_cliente

       While @@fetch_status <> -1
       begin

      
       select @w_di_descripcion=''     
       select @w_pv_descripcion=''    
       select @w_di_direccion=0       
       select @w_ci_descripcion=''
       select @w_te_valor=''           
       select @w_corregimiento=''
       select @w_edificio=''
       select @w_barrio=''
       select @w_calle=''
       select @w_casa='' 
       select @w_email=''             
       select @w_celular=''            
       select @w_fax=''               
       select @w_telefax=''           
       select @w_pais='' 
       select @w_ttrabajo=''
  
	      set rowcount 1      

              select 
                   @w_di_descripcion = di_descripcion, --dir domicilio
                   @w_pv_descripcion = pv_descripcion, --provincia
                   @w_di_direccion   = di_direccion,
                   @w_ci_descripcion = ci_descripcion,
                   @w_corregimiento  = pq_descripcion,              
                   @w_barrio         = di_barrio,
                   @w_calle          = '',
                   @w_casa           = '',
                   @w_edificio       = di_descripcion,
                   @w_pais           = pa_descripcion
              from cobis..cl_ente,
                   cobis..cl_direccion,
                   cobis..cl_ciudad,
                   cobis..cl_provincia,
                   cobis..cl_parroquia, 
                   cobis..cl_pais
              where en_ente           = @w_cliente
              and   di_ente           = en_ente
              --and   di_tipo           = @w_cod_dir_res     -- residencia
	      and   di_principal = 'S'
              --and   di_vigencia       = 'S'
              and   pv_provincia      = di_provincia
              and   ci_ciudad         = di_ciudad
              and   pq_parroquia      = di_parroquia
              and   pa_pais           = pv_pais
              
              select @w_te_valor       = te_valor          -- telefono domicilio    
              from cobis..cl_telefono
              where te_ente          = @w_cliente
              and   te_direccion     = @w_di_direccion
              and   te_tipo_telefono = 'D'                -- Directo


              -----------------------
              --Direccion Electronica
              -----------------------
              select @w_email = di_descripcion  --dir electronica
              from cobis..cl_ente,
                   cobis..cl_direccion
              where en_ente     = di_ente
              and   di_tipo     = @w_cod_dir_elect        -- email
              --and   di_vigencia = 'S'
              and   en_ente     = @w_cliente
              

              ------------------------
              --Otros Medios - Celular
              ------------------------
              select @w_celular = rtrim(ltrim(isnull(te_prefijo, ''))) + rtrim(ltrim(isnull(te_valor, ''))) --celular
              from cobis..cl_ente,
                   cobis..cl_telefono
              where en_ente = te_ente
              and   te_tipo_telefono = 'C'              --Celular
              and   en_ente          = @w_cliente

              --------------------
              --Otros Medios - Fax
              --------------------
              select @w_fax = te_valor   --fax
              from cobis..cl_ente,
              cobis..cl_telefono
              where en_ente          = te_ente
              and   te_tipo_telefono = 'F'              --Fax
              and   en_ente          = @w_cliente
            
              --------------------
              --Otros Medios - Telefax
              --------------------
              
              select @w_telefax = te_valor              --PBX
              from cobis..cl_ente,
              cobis..cl_telefono
              where en_ente        = te_ente
              and te_tipo_telefono = 'X'                --PBX
              and en_ente          = @w_cliente
            

              --------------------
              --Telefono del Trabajo
              --------------------              
              /*select @w_trabajo = isnull(tr_empresa,-1)   --telefax
              from cobis..cl_trabajo
              where tr_persona = @w_cliente
                and tr_fecha_salida is null
              */
 
              --if @w_trabajo > 0   -- empresa cobis
              --begin
              select @w_ttrabajo = te_valor --telefono
              from cobis..cl_telefono,
                   #temporal_oficina
              where en_ente          = te_ente 
              and   te_ente          = @w_cliente
              and   di_direccion     = te_direccion
              and   te_tipo_telefono = 'D'             --Fijo
              --end  
              --else                -- empresa no cobis  
              --begin   
              --    select  @w_ttrabajo = tr_telefono 
              --    from cobis..cl_trabajo
              --    where tr_persona       = @w_cliente
              --      and tr_fecha_salida is null
              --end  

              insert into #temporal_domicilio_telef 
              values
              (
              @w_cliente,
              @w_di_descripcion,     
              @w_pv_descripcion,    
              @w_di_direccion,      
              @w_ci_descripcion,
              @w_te_valor,           
              @w_pais,
              @w_corregimiento,
              @w_barrio,
              @w_calle,
              @w_casa, 
              @w_edificio,
              @w_email,             
              @w_celular,            
              @w_fax,               
              @w_telefax,      
              @w_ttrabajo
              )


              insert into #tmp_empleo
              select 'ente'                 = c.en_ente, 
                     'cargo'                = tr_cargo,                                           -- cargo
                     'nombre_empresa'       = tr_empresa,
                                              --case 
                                              --   when tr_empresa > 0 then d.en_nomlar       
                                              --   else tr_nombre_emp                                                     
                                              --end,                                              -- nombre empresa 
                     'fecha_inicio_labores' = convert(varchar(10), tr_fecha_ingreso, 103),        -- fecha_inicio_labores, 
                     'ingreso_mensual'      = tr_sueldo,                                          -- ingreso_mensual
                     'actividad_empresa'    = '', 
                                              --case                                              -- actividad de la empresa 
                                              --   when tr_empresa > 0 then actividad
                                              --   else tr_objeto_emp
                                              --end,     
                     'direccion_empleo'     = (select min(direccionemp) from #temporal_oficina where en_ente = c.en_ente)
              from cobis..cl_ente c,
                   cobis..cl_trabajo
                   --,cobis..cl_ente d,
                   --cobis..cl_compania,
                   --cobis..cl_ocupacion 
              where tr_persona       = c.en_ente
              --and   tr_cargo         = oc_codigo 
              --and   d.en_ente       =* tr_empresa
              --and   compania        =* tr_empresa
              and   c.en_ente        = @w_cliente  
              and   tr_fecha_salida is null 


             if @i_modo=3
             begin
             ----------------------------------
             --Referencias de los Beneficiarios
             ----------------------------------
             set rowcount 1

             -- Inserta Referencias Bancarias 
             insert into #referencias
             select re_ente,                                                                      --Id Ente
                    (select ba_descripcion from cobis..cl_banco_rem where ba_banco = ec_banco ),  --Nombre de la Referencia
                    'ref'=re_tipo,                                                                --Tipo Referencia                          
                    re_sucursal,                                                                  --Persona/Contacto
                    b.valor,                                                                      --Tipo Cuenta
                    re_telefono                                                                   --Telefono     
             from cobis..cl_referencia,
                  cobis..cl_tabla a, 
                  cobis..cl_catalogo b
             where re_ente     = @w_cliente 
             and   re_tipo     = 'B'
             and   a.tabla     = 'cl_tipo_cuenta' 
             and   a.codigo    = b.tabla   
             and   ec_tipo_cta = b.codigo
             order by re_referencia


             insert into #referencias
             select re_ente,                                          --Id Ente
             co_institucion,                                          --Nombre de la Referencia
             'ref'=re_tipo,                                           --Tipo Referencia                          
             re_sucursal,                                                      --Persona/Contacto
             '',                                                      --Tipo Cuenta
             re_telefono                                              --Telefono     
             from cobis..cl_referencia
             where re_ente=@w_cliente 
             and re_tipo ='C'
             order by re_referencia


             insert into #referencias
             select rp_persona,                                            --Id Ente
             rp_nombre + ' ' + rp_p_apellido + ' ' + rp_s_apellido,  --Nombre de la Referencia
             'ref'='P',                                              --Tipo de Referencia
             '',                                                     --Persona/Contacto
             --REFERENCIAS NO SON CLIENTES PORQUE PIDE SI TIENE CUENTA?
             case
                 when (select count(cc_cta_banco) 
                       from cob_interfase..icte_cc_ctacte   -- BRON: 15/07/09  cob_cuentas..cc_ctacte
                             where cc_cliente = @w_cliente) > 0 
                        and 
                       (select count(ah_cta_banco) 
                        from cob_interfase..iaho_ah_cuenta  -- BRON: 15/07/09  cob_ahorros..ah_cuenta
                            where ah_cliente = @w_cliente) > 0 then 'Ahorros y Corriente'
                        when (select count(cc_cta_banco) 
                              from cob_interfase..icte_cc_ctacte   -- BRON: 15/07/09  cob_cuentas..cc_ctacte
                              where cc_cliente = @w_cliente) > 0 then 'Corriente'
                        when (select count(ah_cta_banco) 
                              from cob_interfase..iaho_ah_cuenta -- BRON: 15/07/09  cob_ahorros..ah_cuenta
                              where ah_cliente = @w_cliente) > 0 then 'Ahorros'
                         else ''
                        end,                                                     --Tipo Cuenta
             rp_telefono_d
       from cobis..cl_ref_personal
       where rp_persona = @w_cliente
       end  
       
           FETCH empleos INTO
           @w_cliente
       end

       CLOSE empleos 
       deallocate empleos
set rowcount 0  




----------------
--Rango Ingresos
----------------
select en_ente, 
       p_nivel_ing as valor --Rango de Ingresos 
  into #temporal_ingresos
  from #temporal_beneficiarios,
       cobis..cl_ente
 where ENTE     = en_ente
 order by BE_TIPO desc, SEC asc, ENTE asc



if @i_modo=1
begin
-------------
--Condiciones
-------------
select * from #temporal_condicion

----------------------------
--Datos de los beneficiarios
----------------------------
select a.en_ente,                                  --Id Ente           --0
       a.p_p_apellido,                             --Primer Apellido
       a.p_s_apellido,                             --Segundo Apellido
       a.en_nombre,                                --Primer Nombre
       a.p_s_nombre,                               --Segundo Nombre 
       a.p_c_apellido,                             --Nombre Casada     --5
       convert(varchar(128),a.en_nomlar),          --Nombre Largo
       a.p_sexo,                                   --'F' o 'M'
       a.p_estado_civil,   
       b.valor,                                    --Estado civil
       convert(char(10), a.p_fecha_nac, 101),      --Fecha Nacimiento  10
       a.en_pais, 
       f.pa_nacionalidad,                          --Nacionalidad
       a.p_tipo_vivienda,
       c.valor,                                    --Tipo Vivienda
       a.p_num_cargas,                             --Numero de Dependientes    --15
       '',                                         --g.di_descripcion                Dir domicilio
       a.en_tipo_ced,                              --Tipo de Documento           --17  
       a.en_ced_ruc,                               --Nro Identificacion 
       a.en_digito,                                --Digito Verificador          --19
       a.p_profesion,                                                         
       d.valor,                                    --Profesion 
       a.ac_descripcion,                           --Actividad                   --22
       n.te_trabajo,                               --Telefono                    --23
       o.valor,                                    --Rango de ingreso mensual    --24 
       t.SEC,                                      --T o F                       --25  
       case
          when (select count(1) 
                  from cob_interfase..icte_cc_ctacte,  -- BRON: 15/07/09  cob_cuentas..cc_ctacte,
                       #temporal_beneficiarios
                  where cc_cliente = ENTE) > 0 
                and 
                (select count(1) 
                   from cob_interfase..iaho_ah_cuenta,  -- BRON: 15/07/09  cob_ahorros..ah_cuenta
                        #temporal_beneficiarios
                  where ah_cliente = ENTE) > 0 then 'Ahorros y Corriente'
          when (select count(1) 
                  from cob_interfase..icte_cc_ctacte,  -- BRON: 15/07/09  cob_cuentas..cc_ctacte,
                       #temporal_beneficiarios
                 where cc_cliente = ENTE) > 0 then 'Corriente'
          when (select count(1) 
                  from cob_interfase..iaho_ah_cuenta,  -- BRON: 15/07/09  cob_ahorros..ah_cuenta
                       #temporal_beneficiarios
                 where ah_cliente = ENTE) > 0 then 'Ahorros'
          else ''
       end,                                        --Tipo Cuenta                 --26
       n.pa_descripcion,                                                         --27
       t.CONDICION                                                               --28 condicion
 from                 #temporal_beneficiarios 
      inner join      #temporal_datos_generales a on ENTE = a.en_ente
      left outer join #temporal_estado_civil b    on ENTE = b.en_ente
      left outer join #temporal_tipo_vivienda c   on ENTE = c.en_ente
      left outer join #temporal_profesion d       on ENTE = d.en_ente
      left outer join #temporal_nacionalidad f    on ENTE = f.en_ente
      left outer join #temporal_ingresos o        on ENTE = o.en_ente
      left outer join #temporal_domicilio_telef n on ENTE = n.en_ente
      left outer join #temporal_firmas t          on ENTE = t.COD_CLIENTE
 --order by 'SEC' asc,'BE_TIPO' desc 

end


if @i_modo=3
begin
-- Despliega Referencias: Bancaria,Comercial y Personal
select * from #referencias


--------------------------
--Otros Datos Direccion
--------------------------
select 
               en_ente ,                           
               CORREGIMIENTO      ,   --parroquia                     
               BARRIO             ,
               CALLE              ,
               CASA               , 
               EDIFICIO           ,
               EMAIL              ,                 
               CELULAR            ,
               FAX                ,
               TELEFAX            
from #temporal_domicilio_telef 
end





if @i_modo=2 

begin
---------------------------------
--Datos generales de la Operacion
---------------------------------
------------------
--Origen de Fondos
------------------
select op_operacion, 
       b.valor
  into #temporal_origen_fondos
  from pf_operacion,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where op_operacion = @i_id_operacion
   and op_origen_fondos = b.codigo
   --and a.tabla      = 'pf_origen_fondos' 
   and a.tabla      = 'cl_orig_fond'		--LIM 31/ENE/2006
   and a.codigo     =  b.tabla

------------------------
--Proposito de la Cuenta
------------------------
select op_operacion, 
       b.valor       
  into #temporal_cuenta
  from pf_operacion,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where op_operacion = @i_id_operacion
   and op_proposito_cuenta = b.codigo
   --and a.tabla      = 'pf_prop_cuenta' 
   and a.tabla      = 'cl_pro_cta' 		--LIM 31/ENE/2006
   and a.codigo     =  b.tabla

--------------------
--Producto Bancario1
--------------------
select op_operacion, 
       b.valor
  into #temporal_1banc
  from pf_operacion,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where op_operacion = @i_id_operacion
   and op_producto_bancario1 = b.codigo
   and a.tabla      = 'pf_otros_prod_bancarios' 
   and a.codigo     =  b.tabla

--------------------
--Producto Bancario2
--------------------
select op_operacion, 
       b.valor
  into #temporal_2banc
  from pf_operacion,
       cobis..cl_tabla a, 
       cobis..cl_catalogo b
 where op_operacion = @i_id_operacion
   and op_producto_bancario2 = b.codigo
   and a.tabla      = 'pf_otros_prod_bancarios' 
   and a.codigo     =  b.tabla

   
select @w_tabla_tipo_per = codigo
from cobis..cl_tabla
where tabla = 'pf_tipo_persona' 

select 
   @w_op_ente_corresp = op_ente_corresp,
   @w_op_ente         = op_ente,
   @w_op_direccion    = op_direccion,
   @w_op_casilla      = op_casilla
from pf_operacion
where op_operacion = @i_id_operacion


select 
   @w_cs_valor     = cs_valor,
   @w_cs_provincia = cs_provincia
from cobis..cl_casilla 
where cs_ente     = isnull(@w_op_ente_corresp, @w_op_ente)
and   cs_casilla  = @w_op_casilla
--and   cs_vigencia = 'S'

select 
   @w_pv_descripcion = pv_descripcion,
   @w_pv_pais        = pv_pais,
   @w_pa_descripcion = pa_descripcion
from cobis..cl_provincia, cobis..cl_pais
where pv_provincia = @w_cs_provincia
and   pa_pais      = pv_pais


select @w_di_descripcion = di_descripcion
from cobis..cl_direccion
where di_ente      = isnull(@w_op_ente_corresp, @w_op_ente)
and   di_direccion = @w_op_direccion


-----------
--Operacion
-----------
select op_num_banco,
       op_moneda,
       (select mo_descripcion from cobis..cl_moneda where mo_moneda = g.op_moneda),                            --Descripcion Moneda
       op_oficina, 
       (select of_nombre from cobis..cl_oficina where of_oficina = g.op_oficina),                              --Nombre de la Oficina   --5
       td_tipo_persona,                                                                                        --Tipo Cliente
       (select case when en_subtipo = 'P' then 'NATURAL' else 'JURIDICA' end from cobis..cl_ente where en_ente = g.op_ente),  --Descripcion Tipo Cliente 
       @w_cs_valor,                                                                                            --apartado,*
       '', --zp_codzona,                                  --zona, * departamento
       '', --zp_descripcion,                              --descripcion zona                   --10
       @w_cs_provincia,                                   --provincia, *
       @w_pv_descripcion,                                 --nombre ciudad
       @w_pv_pais,                                        --pais, *
       @w_pa_descripcion,                                 --descripcion pais, *
       op_tipo_plazo,                                     --plazo   --15
       convert(varchar(10), op_num_dias) + ' DIAS',       -- descripcion plazo
       op_tasa,                                           --tasa nominal *
       op_tasa_efectiva,
       op_ppago,                                          --periodo de pago
       pp_descripcion,                                    --frecuencia_pago_intereses           --20
       op_dia_pago,                                       --dia_pago_intereses
       convert(varchar(128), in_instruccion),             --instrucciones_especiales,*
       op_monto,                                          --monto_apertura
       case                                               --retener_sucursal
          when op_casilla is not null then 'C' 
          when op_direccion is not null then 'D'
          else 'R'
       end,
       op_origen_fondos,                                  --origen_de_fondos                     --25
       c.valor,                                           --descripcion origen_de_fondos
       op_proposito_cuenta,                               --proposito_cuenta
       d.valor,                                           --descripcion proposito_cuenta
       op_producto_bancario1,                             --producto cobis1
       e.valor,                                           --descripcion producto cobis1          --30
       op_producto_bancario2,                             --producto cobis2
       f.valor,                                           --descripcion producto cobis2
       op_tcapitalizacion,                                --capitalizacion intereses Si o No 
       @w_di_descripcion,                                 --direccion de correspondencia
       op_sucursal,                                                                              --35
       (select of_nombre from cobis..cl_oficina where of_oficina = g.op_sucursal),
       op_fideicomiso,
       convert(varchar(10), op_fecha_valor, @i_formato_fecha),
       convert(varchar(10), op_fecha_ven, @i_formato_fecha)
  from                 pf_operacion g
       inner join      pf_plazo                  on pl_mnemonico    = op_tipo_plazo and g.op_operacion = @i_id_operacion
       inner join      pf_tipo_deposito t        on td_mnemonico    = g.op_toperacion
       left outer join pf_ppago                  on op_ppago        = pp_codigo
       left outer join pf_instruccion            on op_operacion    = in_operacion
       left outer join #temporal_origen_fondos c on c.op_operacion  = g.op_operacion
       left outer join #temporal_cuenta d        on d.op_operacion  = g.op_operacion
       left outer join #temporal_1banc e         on e.op_operacion  = g.op_operacion
       left outer join #temporal_2banc f         on f.op_operacion  = g.op_operacion
   
---------------------------------------------
--Formas de Pago de Intereses de la Operacion
---------------------------------------------
select a.dp_forma_pago,  
       fp_descripcion,                           --Forma de Pago de Intereses
       a.dp_cuenta,                              --Numero de Cuenta
       case 
          when (a.dp_tipo_cliente='M' and a.dp_forma_pago in ('CHG','GIRO','ACHP','CTE','VISA','PTMO','AHO')) then
                (select en_nomlar
                from cobis..cl_ente
                where en_ente = a.dp_ente)
          
          when (a.dp_tipo_cliente='E' and a.dp_forma_pago in ('CHG','GIRO','ACHP','CTE','VISA','PTMO','AHO')) then
                (select ce_nombre from pf_cliente_externo         
                where ce_secuencial = a.dp_ente)
          else ''
       end,
       case 
          --when a.dp_forma_pago = 'ACHP' then dp_banco_ach
          when a.dp_forma_pago = 'ACHP' then (select min(br_desc)                         -- LIM 19/NOV/2005
                                              from cob_interfase..irem_re_banco_org_ach 
                                              where br_banco  = a.dp_cod_banco_ach 
                                              and   br_filial = @i_filial              )  -- BRON: 15/07/09  cob_remesas..re_banco_org_ach   
          when a.dp_forma_pago = 'CCTE' then @w_banco   --banco
          when a.dp_forma_pago = 'CAHO' then @w_banco
          else ''
       end, 
       case 
          when a.dp_forma_pago = 'ACHP' and dp_tipo_cuenta_ach='A' then 'Ahorros'
          when a.dp_forma_pago = 'ACHP' and dp_tipo_cuenta_ach='C' then 'Corriente'
          when a.dp_forma_pago = 'CCTE' then 'Corriente' --tipo_cuenta
          when a.dp_forma_pago = 'CAHO' then 'Ahorros'
          else ''
       end 
  from pf_det_pago a,
       pf_fpago
--       ,cob_interfase..icte_cc_ctacte,        -- BRON: 15/07/09  cob_cuentas..cc_ctacte
--       cob_interfase..iaho_ah_cuenta         -- BRON: 15/07/09 cob_ahorros..ah_cuenta
 where a.dp_operacion     = @i_id_operacion
   and (a.dp_tipo = 'INT' or a.dp_tipo = 'INTV')
   and a.dp_forma_pago    = fp_mnemonico
--   and a.dp_cuenta       *= cc_cta_banco  
--   and a.dp_cuenta       *= ah_cta_banco
   and fp_estado          = 'A'
   
-------------------------------------
--Formas de Recepcion de la Operacion
-------------------------------------
select mm_producto, 
       (select fp_descripcion from pf_fpago where mm_producto = fp_mnemonico and fp_estado = 'A'), --Forma de Recepcion
       
       --case fp_mnemonico
       
       --when 'CHQP' then ec_cuenta     --Numero Cuenta
       --else mm_cuenta                 --Numero Cuenta
       --end,
       mm_cuenta,					--LIM 31/OCT/2005 
       mm_valor							--LIM 07/DIC/2005
       --ec_valor						--LIM 31/OCT/2005
from pf_mov_monet M     
 where mm_operacion 	= @i_id_operacion
   and mm_tran 		= 14901
   and mm_tipo          = 'B'
   order by mm_sub_secuencia 

--------------------------
--Otros Datos Empleo / Domicilio - Telefono
--------------------------
select ENTE,
       g.pv_descripcion,                           --Provincia
       g.te_valor,                                 --Telefono
       k.cargo,                                    --Descripcion Cargo   
       k.nombre_empresa,                           --Nombre Empresa      --30
       convert(char(10), k.fecha_inicio_labores, 101), --Fecha inicio labores 
       k.direccion_empleo,                         --Dir Trabajo
       k.ingreso_mensual,                          --Ingreso_mensual
       SEC,                                        --T o F
       k.actividad_empresa,                        --Actividad Comercial de la Empresa
       g.ci_descripcion                            --Distrito,Ciudad                    
 from                  #temporal_beneficiarios 
       left outer join #temporal_domicilio_telef g on ENTE = g.en_ente
       left outer join #tmp_empleo k               on ENTE = k.ente
  order by SEC asc

end

return 0
go
