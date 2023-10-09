/*cr_gar_p.sp***********************************************************/
/*  Archivo:                    cr_gar_p.sp                            */
/*  Stored procedure:           sp_gar_propuesta                       */
/*  Base de Datos:              cob_credito                            */
/*  Producto:                   Credito                                */
/*  Disenado por:               Myriam Davila                          */
/*  Fecha de Documentacion:     14/Ago/95                              */
/***********************************************************************/
/*          IMPORTANTE                                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de      */
/*  'MACOSA',representantes exclusivos para el Ecuador de la           */
/*  AT&T                                                               */
/*  Su uso no autorizado queda expresamente prohibido asi como         */
/*  cualquier autorizacion o agregado hecho por alguno de sus          */
/*  usuario sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante                 */
/***********************************************************************/
/*          PROPOSITO                                                  */
/*  Este stored procedure permite realizar operaciones DML             */
/*  Insert, Update, Delete, Search y Query en la tabla                 */
/*  cr_gar_propuesta                                                   */
/*                                                                     */
/***********************************************************************/
/*          MODIFICACIONES                                             */
/*  FECHA       AUTOR           RAZON                                  */
/*  14/Ago/95   Ivonne Ordonez      Emision Inicial                    */
/*  22/Ene/97   F. Arellano     aumento campos deudor                  */
/*                      clase y estado  de gar                         */
/*  06/Jun/97   M.Davila        Aumento de modo en 'S'                 */
/*                      para traer todos los                           */
/*                      datos                                          */
/*  10/Jun/97   F. Arellano     optimizacion                           */
/*  05/May/98   T. Granda        Inplementacion de sentencias          */
/*                               de manejo de cu_estado_credito        */
/*  11/May/98   Tatiana Granda   Nombre completo cliente               */
/*  12/Ago/98   Monica Vidal     Correccion Especifi.                  */
/*  09/Feb/99   S. Hernandez        Especif. CRE007                    */
/*  19/Ago/99   Dario Barco Leon    Personalizacion CORFINSURA         */
/*      05/Feb/01       Zulma Reyes  (ZR)   GD00064 TEQUENDAMA         */
/*  23/Dic/02   A. Núñez        Esp. CD00067                           */
/*      30/Ago/04       Luis Ponce              Optimizacion           */
/*      10/Feb/06       John Jairo Rendon       Optimizacion           */
/*      14/Mar/07       John Jairo Rendon       Optimizacion           */
/*      30/08/2012		Acelis					Alcance 272			   */
/*      19/12/2012      Nini Salazar            Req343                 */
/***********************************************************************/

use cob_credito
go


if exists (select * from sysobjects where name = 'sp_gar_propuesta')
   drop proc sp_gar_propuesta
go
---SEP.2014.117395

CREATE proc [dbo].[sp_gar_propuesta] (
    @s_ssn                   int      = null,
   @s_user                  login    = null,
   @s_sesn                  int    = null,
   @s_term                  descripcion = null,
   @s_date                  datetime = null,
   @s_srv                   varchar(30) = null,
   @s_lsrv                  varchar(30) = null,
   @s_rol                   smallint = null,
   @s_ofi                   smallint  = null,
   @s_org_err               char(1) = null,
   @s_error                 int = null,
   @s_sev                   tinyint = null,
   @s_msg                   descripcion = null,
   @s_org                   char(1) = null,
   @t_rty                   char(1)  = null,
   @t_trn                   smallint = null,
   @t_debug                 char(1)  = 'N',
   @t_file                  varchar(14) = null,
   @t_from                  varchar(30) = null,
   @i_operacion             char(1)  = null,
   @i_tramite               int  = null,
   @i_garantia              varchar(64)  = null,
   @i_clasificacion         char(1)  = 'a',
   @i_exceso                char(1) = 'N',
   @i_monto_exceso          money   = 0,
   @i_deudor                int = null,
   @i_clase                 char(1) = null,
   @i_estado                char(1) = null,
   @i_estado_credito        char(1) = null,
   @i_modo                  tinyint = 1,      --para traer todos los datos
   @i_porcentaje_resp       float = null,   --SBU: 06/abr/2000
   @i_valor_resp_garantia   money = null,
   @i_numero_operacion      cuenta = null,
   @i_finagro               char(1) = null,     --ANP
   @i_tipo_garantia         varchar(20) = 'AUTOMATICA',
   @i_previa		    char(1) = null,
   @i_colat_adic            char(1)  = 'N',    --req343
   @i_crea_ext              char(1)= null,
   @o_retorno               float   = null out 
)
as
declare
   @w_today              datetime,     /* fecha del dia */
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite            int,
   @w_garantia           varchar(64),
   @w_clasificacion      char(1),
   @w_exceso             char(1),
   @w_monto_exceso       money,
   @w_deudor             int ,
   @w_clase              char(1),
   @w_estado             char(1),
   @w_gargpe             descripcion,
   @w_inspector          smallint,
   @w_garanti            varchar(64),
   @w_nombre             varchar(30),
   @w_propiet            varchar(50),
   @w_ftramite           int,
   @w_fvalor             money,
   @w_ffecha             datetime,
   @w_fcontador          int,
   @w_fsuma              money,
   @w_porcentaje         float,
   @w_valor_cobertura    money,
   @w_valor_resp         money,
   @w_monto              money,
   @w_fecha_mod          datetime,
   @w_porcentaje_resp    float,
   @w_valor_resp_garantia money,
   @w_tipo_garantia      varchar(64),
   @w_valor              varchar(30),
   @w_bandera            int,
   @w_garesp             varchar(10),
   @w_tr_toperacion      cuenta,
   @w_cobertura          float,
   @w_clase_custodia     char(1),
   @w_fecha_imax         datetime,
   @w_spid               int,
   @w_tipo_gar           varchar(64),
   @w_control            char(1),
   @w_estado_obl         smallint,
   @w_cotizacion         float,
   @w_moneda_op          smallint,
   @w_monto_op           money,
   @w_monto_exeq         money,
   @w_monto_micro        money,
   @w_parametro_fng      catalogo,
   @w_cod_gar_fng        catalogo,
   @w_factor             float,
   @w_msg                descripcion,
   @w_error              int,
   @w_SMV                money,
   @w_monto_SMV          money,
   @w_tipo_cust          varchar(64),
   @w_dir_neg            varchar(10),
   @w_mensaje            varchar(250),
   @w_depto_neg          int,
   @w_ciudad_neg         int,
   @w_actividad          varchar(10),
   @w_parametro1         smallint,
   @w_parametro2         smallint,
   @w_valor_actual       money,
   @w_valor_disponible   money,
   @w_param_musaid       int,
   @w_param_fusaid       datetime,
   @w_usaid              int,
   @w_valor_reservado    money,
   @w_valor_desembolsado money,
   @w_tipo_tr            char(1),
   @w_fecha_proceso      datetime,
   @w_deudor_cus         int,
   @w_fecha_cotizacion   datetime,
   @w_valor_cotiz        money,
   @w_cod_gar_fag        varchar(30),
   @w_cod_gar_usaid      varchar(30),
   @w_tipo_gar_padre     varchar(64),
   @w_destino_tram       catalogo,
   @w_tipo_productor	 catalogo,
   @w_porc_desde		 float,
   @w_porc_hasta		 float,
   @w_colateral          varchar(255),
   @w_cod_colateral      catalogo,
   @w_es_colateral       char(1),
   @w_val_actual         money,
   @w_fag                varchar(10),
   @w_valor_monto        money,
   @w_cod_gar_fng_banca	 catalogo,
   @w_tipo_personal       catalogo,
   @o_valor_inf			 float,
   @o_valor_sup			 float,
   @w_valor_monto_tmp    float,
   @w_monto_tmp			 float,
   @w_monto_SMV_tmp      decimal (20,10) , --float,
   @w_valida_ok			 smallint, --req343
   @w_comparte_nue       char(1),  --req343
   @w_tipo_gar_ant       varchar(255),  --req343
   @w_comparte_ant       char(1),   --req343
   @w_si                 char(2)= 'Si',
   @w_no                 char(2)='No',
   @w_s                 char(1)= 'S',
   @w_n                 char(1)='N'

select @w_today        = @s_date
select @w_spid         = @@spid * 100
select @w_sp_name      = 'sp_gar_propuesta'
select @w_es_colateral = 'N'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso


-- Parametro FAG        
select @w_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CODFAG'        

select  @w_valor  = pa_char
from    cobis..cl_parametro
where   pa_producto = 'GAR'
and     pa_nemonico = 'FAG'
set transaction isolation level read uncommitted

select  @w_garesp = pa_char
from    cobis..cl_parametro
where   pa_producto = 'GAR'
and     pa_nemonico = 'GARESP'
set transaction isolation level read uncommitted

-- PARAMETRO PARA GARANTIAS FNG
select @w_parametro_fng = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'

/*CODIGO PADRE GARANTIA DE FNG*/
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'

--- CODIGO PADRE GARANTIA DE FAG 
select @w_cod_gar_fag = pa_char
  from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
   and pa_nemonico = 'CODFAG'
set transaction isolation level read uncommitted

/* CODIGO PADRE GARANTIA DE USAID */
select @w_cod_gar_usaid = pa_char
  from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
   and pa_nemonico = 'CODUSA'
set transaction isolation level read uncommitted


/*PARAMETRO SALARIO MINIMO VITAL VIGENTE*/
select @w_SMV      = pa_money 
from   cobis..cl_parametro with (nolock)
where  pa_producto  = 'ADM'
and    pa_nemonico  = 'SMV'

/*PARAMETRO DIRECCION TIPO NEGOCIO*/
select @w_dir_neg  = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto  = 'MIS'
and    pa_nemonico  = 'TDN'

-- Ubicar garantia BANCA NUEVAS OPORTUNIDADES 036
select @w_cod_gar_fng_banca = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODOPO'


select @w_tipo_personal = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'GPE' 

select tc_tipo as tipo into #calfng
from cob_custodia..cu_tipo_custodia
where  tc_tipo_superior  = @w_cod_gar_fng


select @w_tipo_tr = tr_tipo
from	cob_credito..cr_tramite
where   tr_tramite = @i_tramite


select @w_tipo_gar = cu_tipo from cob_custodia..cu_custodia
where cu_codigo_externo = @i_garantia 

if  @w_tipo_gar  = @w_cod_gar_fng_banca and @w_tipo_tr in (select codigo_sib from cob_credito..cr_corresp_sib where tabla = 'T147')
begin
  print ' Tipo de Ruta no permite la creacion de Garantia Automatica '
  exec cobis..sp_cerror
  @t_from  = @w_sp_name,
  @i_num   = 143051
  return     143051
end


delete cr_superior_gp where sesion = @w_spid
delete cr_superior_gp_esp where sesion = @w_spid
delete cr_tipo_actual_gp where sesion = @w_spid
delete cr_garantias_gp  where sesion = @w_spid
delete cr_garantia_gp where sesion = @w_spid
delete cr_tramites_gp where sesion = @w_spid

insert into cr_superior_gp
select   tc_tipo,
     @w_spid
from     cob_custodia..cu_tipo_custodia
where    tc_tipo_superior = @w_valor
order by tc_tipo

insert into cr_superior_gp_esp
select   tc_tipo,
     @w_spid
from     cob_custodia..cu_tipo_custodia
where    tc_tipo_superior = @w_garesp
order by tc_tipo

insert into cr_superior_gp_esp
select   A.tc_tipo,
     @w_spid
from     cob_custodia..cu_tipo_custodia A,
     cr_superior_gp_esp B
where    A.tc_tipo_superior = tipo
and  B.sesion       = @w_spid
order by A.tc_tipo

select @w_tipo_tr = tr_tipo, @w_deudor_cus = tr_cliente
from cob_credito..cr_tramite
where tr_tramite = @i_tramite

--TABLA PARA GARANTIAS FAG

delete cr_tmp_garfag
where tg_sesion = @w_spid

insert into cr_tmp_garfag
select tc_tipo,@w_spid
from cob_custodia..cu_tipo_custodia
where tc_tipo = @w_valor
union
select tc_tipo, @w_spid
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior = @w_valor
union
select tc_tipo ,@w_spid
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior in (select tc_tipo
                           from  cob_custodia..cu_tipo_custodia
                           where  tc_tipo_superior = @w_valor)                           

/* Codigos de Transacciones */
if (@t_trn <> 21028 and @i_operacion = 'I') or
   (@t_trn <> 21128 and @i_operacion = 'U') or
   (@t_trn <> 21228 and @i_operacion = 'D') or
   (@t_trn <> 21428 and @i_operacion = 'S') or
   (@t_trn <> 21528 and @i_operacion = 'Q') or
   (@t_trn <> 21048 and @i_operacion = 'C')
   begin
      /* tipo de transaccion no corresponde */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2101006
      return 1
   end

/*REQ 0212 BANCA RURAL*/
--Codigo de garantia que se esta anexando al tramite

select @w_tipo_gar = cu_tipo from cob_custodia..cu_custodia
where cu_codigo_externo = @i_garantia 

--Codigo PADRE de garantia que se esta anexando al tramite

select @w_tipo_gar_padre = tc_tipo_superior
from cob_custodia..cu_tipo_custodia
where tc_tipo = @w_tipo_gar 

select @w_comparte_nue = ca_comparte
from cob_custodia..cu_colat_adic
where ca_codigo_cust = @w_tipo_gar

-- Selecionar el codigo de destino economico del tramite y el tipo de productor
select @w_destino_tram = tr_destino, @w_tipo_productor = tr_tipo_productor
from cob_credito..cr_tramite
where tr_tramite = @i_tramite

if @w_tipo_gar_padre  = @w_cod_gar_fag
begin   
  select @w_es_colateral = 'S'
  if not exists(select 1 from cobis..cl_tabla a, cobis..cl_catalogo b
                where a.tabla = 'cr_destino_fag'
                and b.tabla = a.codigo
                and b.codigo = @w_destino_tram
                and b.estado = 'V')
    begin
    select @w_mensaje = 'El Destino Economico seleccionado no permite Utilización de FAG'
 
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_msg   = @w_mensaje,
      @i_num   = 2101001
 
      return 2101001
    end
end       
else
begin
if @w_tipo_gar_padre  = @w_cod_gar_usaid --or @w_tipo_gar_padre  = @w_cod_gar_fng
  begin    
  select @w_es_colateral = 'S'
  if exists(select 1 from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'cr_destino_fag'
            and b.tabla = a.codigo
            and b.codigo = @w_destino_tram
            and b.estado = 'V')
    begin
     select @w_mensaje = 'El Destino Economico Seleccionado no permite Utilización de colateral diferente a FAG'
 
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_msg   = @w_mensaje,
      @i_num   = 2101001
 
      return 2101001
    end
 end
end 
  
/*FIN REQ 0212*/

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin

   select
   @w_tramite         = gp_tramite,
   @w_garantia        = gp_garantia,
   @w_clasificacion   = gp_clasificacion,
   @w_exceso          = gp_exceso,
   @w_monto_exceso    = gp_monto_exceso,
   @w_deudor          = gp_deudor,
   @w_clase           = gp_abierta,
   @w_estado          = gp_est_garantia,
   @w_porcentaje      = gp_porcentaje,
   @w_valor_resp      = gp_valor_resp_garantia,
   @w_fecha_mod       = gp_fecha_mod
   from  cob_credito..cr_gar_propuesta
   where gp_tramite   = @i_tramite
   and   gp_garantia  = @i_garantia

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0

   if @i_numero_operacion is not null
   begin
      select  @i_tramite    = op_tramite,
              @w_estado_obl = op_estado,
              @w_moneda_op  = op_moneda
      from    cob_cartera..ca_operacion
      where   op_banco = @i_numero_operacion

      select @i_tramite = isnull(@i_tramite ,0)
   end

/* select   @w_monto_op     = case tr_moneda when  0 then tr_monto else  tr_montop end,
            @w_monto_exeq   = isnull((select se_val_total from cob_credito..cr_seguro_exequial where tr_tramite = se_tramite),0),
            @w_monto_micro  = isnull((select ms_valor from cob_credito..cr_micro_seguro where tr_tramite = ms_tramite),0)
   from cr_tramite x
   where    tr_tramite  = @i_tramite

   select @w_monto = @w_monto_op + @w_monto_exeq + @w_monto_micro --SRA: El monto total del credito monto + seguro exequial + microseguro
*/

  select @w_monto = case tr_moneda
              when   0 then tr_monto
              else   tr_montop
              end
   from     cr_tramite x
   where tr_tramite  = @i_tramite

   if @w_estado_obl not in (0,99)
   begin
      select @w_cotizacion = ct_valor
      from   cob_conta..cb_cotizacion
      where  ct_moneda = @w_moneda_op
      and   ct_fecha  between dateadd(dd,-15,@w_today) and @w_today
      order by ct_fecha asc

      select @w_monto  = case do_moneda when 0 then do_saldo_cap else do_saldo_cap * @w_cotizacion end
      from   cr_dato_operacion
      where  do_tipo_reg                 = 'D'
      and    do_codigo_producto          = 7
      and    do_numero_operacion_banco   = @i_numero_operacion
   end
   
   /*Salarios minimos con respecto al monto de la obligación*/
   
   select @w_monto_SMV = @w_monto / @w_SMV
   
end

   /**************************************************/
   /*Req 00212 - Validacion de cobertura comision FAG*/
   /**************************************************/

   select @w_tipo_productor = en_casilla_def
   from cobis..cl_ente
   where en_ente = @i_deudor

   select @w_tipo_cust = cu_tipo
   from cob_custodia..cu_custodia
   where cu_codigo_externo = @i_garantia

   select @w_porc_desde = pc_porc_desde, @w_porc_hasta = pc_porc_hasta
   from cob_credito..cr_param_cob_gar
   where pc_tipo_gar = @w_tipo_cust and pc_tipo_prod = @w_tipo_productor
   and @w_monto_SMV between pc_monto_desde and pc_monto_hasta     
   
   if @i_porcentaje_resp > @w_porc_hasta or @i_porcentaje_resp < @w_porc_desde 
    begin
      select @w_mensaje = 'Porcentaje de respaldo no permitido para el valor del credito '
 
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_msg   = @w_mensaje,
      @i_num   = 2101001
 
      return 2101001
    end
   
   /********************************************/
   /* FIN Validacion de cobertura comision FAG */
   /********************************************/
   
    
    

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin

   if @i_tramite is NULL
      or @i_garantia is NULL
      or @i_clasificacion is NULL
   begin
      /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2101001
      return 1
   end

   /***********************************************************************************************************************/
   /* LLS43246. Validacion para Adjuntar garantia especial segun el monto del tramite vs el parametro creado para tal fin */
   /***********************************************************************************************************************/
   select @w_valor_monto = pa_money
   from cobis..cl_parametro with (nolock)
   where pa_producto = 'CRE'
   and   pa_nemonico = 'SALMIN'

   if @w_valor_monto is null
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_msg   = 'El valor del monto para Validacion en el parametro <SALMIN> NO Existe. Favor Parametrizar ',
      @i_num   = 1912030
      return 1912030
   end

   if @w_monto <= @w_valor_monto  --Monto del tramite es inferior al monto del parametro
   begin

      if exists(select 1
                from cob_custodia..cu_custodia
                where cu_codigo_externo = @i_garantia
                and   cu_tipo           in (select codigo_sib from cob_credito..cr_corresp_sib where tabla = 'T65'))
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = 'El monto del tramite es inferior al parametro SALMIN y la garantia es Especial. NO Puede Adjuntar la Garantia ',
         @i_num   = 1912030
         return 1912030
      end
   end

/* validacion de los montos */

if exists (select 1 from #calfng where tipo = @w_tipo_gar) 
begin

    select @w_monto_tmp = @w_monto 
    select @w_valor_monto_tmp = @w_valor_monto
    select @w_monto_SMV_tmp = cast(@w_monto_tmp / @w_valor_monto_tmp as float)

	exec @w_error = cob_cartera..sp_matriz_valor
      @i_matriz    = 'VAL_FNG',
      @i_fecha_vig = @w_fecha_proceso,
      @i_eje1      = @w_tipo_gar,
      @i_eje2      = @w_monto_SMV_tmp,
      @i_eje3      = @w_destino_tram,
      @o_valor     = @w_valida_ok out,
      @o_msg       = @w_msg   out

      if @w_error <> 0
	  begin
        print 'Se presenta error en la parametrizacion de las matrices VAL_FNG'
		exec cobis..sp_cerror
		@t_debug  = @t_debug,
		@t_file   = @t_file,
		@t_from   = @w_sp_name,
		@i_num    = @w_error,
		@i_msg    = @w_msg
	  end


    --print ' valor es ' + cast(@w_valida_ok as varchar)
	if @w_valida_ok = 0
	begin
		 exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
		 @t_from  = @w_sp_name,
		 @i_msg   = 'Condiciones de Credito no permitidas para el tipo de Garantia.  Revise Monto o Destino Economico',
		 @i_num   = 1912030
		 return 1912030

	end
  end      
   /*************************************************************************/
   /* Validacion tramites de Reestructuracion: No se debe Agregar Garantias */
   /*************************************************************************/

   if @w_tipo_tr = 'E' and @i_operacion = 'I'
   begin
      
      select @w_mensaje = 'No se permite anadir garantias en reestructuraciones ' 

      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_msg   = @w_mensaje,
      @i_num   = 2101001
 
      return 2101001
   end
   
   if @i_deudor is null  
      select @i_deudor = @w_deudor_cus


   if exists(select 1
             from cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia, cob_custodia..cu_tipo_custodia x, cob_custodia..cu_tipo_custodia y
             where gp_tramite         = @i_tramite
             and   gp_garantia        = cu_codigo_externo
             and   cu_tipo            = x.tc_tipo
		     and   cu_estado          <> 'A'  --acelis mayo 29 2012
             and   x.tc_tipo_superior = y.tc_tipo
             and   y.tc_tipo_superior = '2000'
             and   cu_tipo not in (select ca_codigo_cust from cob_custodia..cu_colat_adic where ca_comparte = 'S'))--req343
             and   @i_operacion = 'I'
   begin

      --Buscar de que tipo es la garantia que anexo, si es de las 2000 no debe asociarse
      if exists(select 1
                from cob_custodia..cu_custodia, cob_custodia..cu_tipo_custodia x, cob_custodia..cu_tipo_custodia y
                where cu_codigo_externo  = @i_garantia
                and   cu_tipo            = x.tc_tipo
                and   x.tc_tipo_superior = y.tc_tipo
                and   y.tc_tipo_superior = '2000'
                and   cu_estado          in ('F', 'P', 'V', 'X'))   
      begin

         select @w_mensaje = 'No se permite anadir garantias colaterales porque ya tiene una colateral asociada al tramite '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end
   end   
   
   /**************************/
   /* INI Validaciones USAID */
   /**************************/

   select @w_fecha_cotizacion = max(ct_fecha)
   from cob_conta..cb_cotizacion, cob_custodia..cu_convenios_garantia
   where ct_moneda = cg_moneda
   and   cg_moneda <> 0
   and   cg_estado = 'V'

   select @w_valor_cotiz = ct_valor 
   from cob_conta..cb_cotizacion, cob_custodia..cu_convenios_garantia
   where ct_moneda = cg_moneda
   and   ct_fecha  = @w_fecha_cotizacion
   and   cg_moneda <> 0
   and   cg_estado = 'V'

   select @w_valor_actual = null, @w_valor_disponible = null
  
   select tipo = cg_tipo_garantia, disponible = cg_saldo_disponible * @w_valor_cotiz, moneda = cg_moneda
   into #temporal
   from cob_custodia..cu_convenios_garantia
   where cg_estado = 'V'

   select @w_usaid = 0

   select @w_usaid = 1
   from cob_custodia..cu_custodia, #temporal
   where cu_codigo_externo = @i_garantia
   and   cu_tipo           = tipo

   if @w_usaid = 1
   begin 

      select @w_valor_actual = cu_valor_actual, @w_valor_disponible = disponible
      from cob_custodia..cu_custodia, #temporal
      where cu_codigo_externo = @i_garantia
      and   cu_tipo           = tipo

      --Sumar las garantias de los tramites del dia
      select @w_valor_reservado = isnull(sum(cu_valor_actual),0)
      from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta,
           cob_custodia..cu_custodia
      where op_estado    in (99,0)
      and   op_tramite   = tr_tramite
      and   tr_estado    not in ('Z')
      and   op_tramite   = gp_tramite
      and   gp_garantia  = cu_codigo_externo
      and   gp_fecha_mod = @w_fecha_proceso
      and   cu_tipo      in (select tipo from #temporal)
      and   gp_procesado is null      

      if @w_valor_disponible is null or @w_valor_disponible <= 0
      begin
         select @w_mensaje = 'No Existe Valor Disponible para el Tipo Convenio. Revise la Parametrizacion por Tipo de Convenio '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end

      if @w_valor_actual is null or @w_valor_actual = 0
      begin
         select @w_mensaje = 'No Existe Valor Actual para la Garantia '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end

      if @w_valor_actual + @w_valor_reservado > @w_valor_disponible
      begin
         select @w_mensaje = 'El Valor Actual de la Garantia Excede el Valor Disponible para el Tipo Convenio '
  
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
   
         return 2101001
      end

      --Creditos desembolsados con garantias USAID del cliente
      select @w_valor_desembolsado = sum(isnull(op_monto,0))
      from cob_cartera..ca_operacion(nolock), cob_credito..cr_tramite(nolock), cob_credito..cr_gar_propuesta(nolock),
           cob_custodia..cu_custodia(nolock)
      where op_estado    <> 6
      and   op_cliente   = @i_deudor
      and   op_tramite   = tr_tramite
      and   tr_estado    not in ('Z')
      and   op_tramite   = gp_tramite
      and   gp_garantia  = cu_codigo_externo
      and   cu_tipo      in (select tipo from #temporal)

       --Se elimina este codigo porque el campo op_monto incluye el valor total de lo seguros:
      /*
      select @w_valor_desembolsado = isnull(@w_valor_desembolsado,0) + isnull(ms_valor,0)
      from cob_cartera..ca_operacion(nolock), cob_credito..cr_tramite(nolock), cob_credito..cr_gar_propuesta(nolock),
           cob_custodia..cu_custodia(nolock), cob_credito..cr_micro_seguro
      where op_estado    <> 6
      and   op_cliente   = @i_deudor
      and   op_tramite   = tr_tramite
      and   tr_estado    not in ('Z')
      and   op_tramite   = gp_tramite
      and   gp_garantia  = cu_codigo_externo
      and   cu_tipo      in (select tipo from #temporal)
      and   ms_tramite   = tr_tramite
      */

      select @w_param_musaid = pa_int
      from cobis..cl_parametro
      where pa_nemonico = 'MUSAID'
      and   pa_producto = 'GAR'

      if @w_param_musaid is null
      begin
         select @w_mensaje = 'El Parametro MUSAID (Numero de Salarios Minimos para USAID) NO Existe. Revise la Parametrizacion '

         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end
 
      if @w_valor_desembolsado > (@w_SMV * @w_param_musaid)
      begin
         select @w_mensaje = 'El valor actual de la garantia excede el  valor del parametro <MUSAID> para USAID '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end

      --Validacion Fecha Fin de Contrato USAID
      select @w_param_fusaid = pa_datetime
      from cobis..cl_parametro
      where pa_nemonico = 'FUSAID'
      and   pa_producto = 'GAR'

      if @w_param_fusaid is null
      begin
         select @w_mensaje = 'El Valor del Parametro <FUSAID> para USAID No Existe. Revise la Parametrizacion '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end

      if @w_fecha_proceso > @w_param_fusaid 
      begin
         select @w_mensaje = 'La Fecha desembolso del Credito Excede el Valor del Parametro <FUSAID> para USAID. Revise la Parametrizacion '

         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end
   end

   select @w_parametro1 = 0
   select @w_parametro2 = 0

   --Revision existencia de parametrizacion Municipios-Tipo_Garantia
   if exists(select 1 from cob_custodia..cu_gar_municipio, cob_custodia..cu_custodia where cu_codigo_externo = @i_garantia and cu_tipo = gm_tipo)
      select @w_parametro1 = 1

   --Revision existencia de parametrizacion Actividades-Tipo_Garantia
   if exists(select 1 from cob_custodia..cu_gar_actividad, cob_custodia..cu_custodia where cu_codigo_externo = @i_garantia and cu_tipo = ga_tipo)
      select @w_parametro2 = 1

   --Existe Parametrizacion Municipios-TipoGarantia
   if @w_parametro1 = 1 begin

      select @w_tipo_cust = cu_tipo
      from cob_custodia..cu_custodia
      where cu_codigo_externo = @i_garantia

      select 
      @w_depto_neg  = di_provincia,
      @w_ciudad_neg = di_ciudad
      from cobis..cl_direccion  
      where di_ente = @i_deudor
      and   di_tipo = @w_dir_neg

      if not exists (select 1 
      from cob_custodia..cu_gar_municipio
      where  gm_tipo   = @w_tipo_cust
      and    gm_depto  = @w_depto_neg
      and    gm_ciudad = @w_ciudad_neg)

      begin

         select @w_mensaje = 'La Ciudad de Negocio del Deudor No esta Parametrizada (Municipios-TipoGarantia) '
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001
 
         return 2101001
      end
   end

   --Existe Parametrizacion Actividades-TipoGarantia
   if @w_parametro2 = 1 begin

      select @w_tipo_cust = cu_tipo
      from cob_custodia..cu_custodia
      where cu_codigo_externo = @i_garantia

      select 
      @w_actividad = en_actividad
      from cobis..cl_ente
      where en_ente = @i_deudor

      if not exists (select 1 
      from cob_custodia..cu_gar_actividad
      where  ga_tipo       = @w_tipo_cust
      and    ga_actividad  = @w_actividad)

      begin

         select @w_mensaje = 'La actividad economica del deudor no corresponde al tipo de garantia asignado '

         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 2101001

         return 2101001
      end
   end

   /**************************/
   /* FIN Validaciones USAID */
   /**************************/

   --emg Jun-6-03
   --Validacion porcentaje de cobertura en caso de garantias Abiertas
   /*select @w_cobertura = cu_porcentaje_cobertura
   from   cob_custodia..cu_custodia
   where  cu_codigo_externo = @i_garantia
   and    cu_abierta_cerrada = 'A'

   if @w_cobertura = 0 begin

      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 1912010
      return 1
   end */
end

/* Insercion del registro */
/**************************/
if @i_operacion = 'I'
begin

   if @w_existe = 1
   begin
       /* Registro ya existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2101002
      return 1
    end

   --LPO REQ. 266 Paquete 2 INICIO
   if @i_clase = 'C' --Garantia Cerrada
   begin
      if exists (select 1
                 from cr_gar_propuesta with (nolock),
                      cob_custodia..cu_custodia with (nolock)
                 where cu_codigo_externo = gp_garantia
                   and gp_garantia       = @i_garantia
                   and cu_estado         not in ('C','E','Z')
                )
      begin
         print 'Tipo de Garantia Cerrada, por favor escoja otra garantia.'
         /* Error en insercion  de gar_propuesta */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 1912030
         return 1912030
      end
   end
   --Codigo padre de todas las Garantias Colaterales
   select  @w_cod_colateral = pa_char
   from    cobis..cl_parametro
   where   pa_producto = 'GAR'
   and     pa_nemonico = 'COFIAD'
   
   if  @w_cod_colateral is null     
   select @w_cod_colateral ='2000'
   
   select @w_colateral = null
   
   select @w_colateral = ltrim(rtrim(tc_descripcion)),
          @w_tipo_gar_ant = cu_tipo
   from cr_gar_propuesta with (nolock),
        cob_custodia..cu_custodia with (nolock),
        cob_custodia..cu_tipo_custodia with (nolock)
   where cu_codigo_externo = gp_garantia
     and cu_estado		   <> 'A' --acelis cc 272 mayo 2012
     and gp_tramite        = @i_tramite
     and tc_tipo           = cu_tipo
     and cu_tipo in (select tc_tipo
                     from cob_custodia..cu_tipo_custodia
                     where tc_tipo_superior in (select tc_tipo
                                                from cob_custodia..cu_tipo_custodia
                                                where tc_tipo_superior = @w_cod_colateral)
                     )
   
   select @w_comparte_ant = ca_comparte
   from cob_custodia..cu_colat_adic
   where ca_codigo_cust = @w_tipo_gar_ant

   --print 'cr_gar_p.sp ' +  @w_cod_colateral + 'colateral- ' + @w_colateral + ' ' + @w_tipo_gar_ant + 'tipo_gar_padre - ' + @w_tipo_gar_padre


   if @w_colateral is not null
   begin
      select tc_tipo as tipo_sub 
      into #colateral
      from cob_custodia..cu_tipo_custodia
      where tc_tipo_superior = @w_cod_colateral
      
      if exists (select 1 from #colateral where tipo_sub = @w_tipo_gar_padre)
      begin
         print 'Credito esta respaldado con garantia ' + @w_colateral + ' no se puede asignar esta garantia.'
         /* Error en insercion  de gar_propuesta */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 1912030
         return 1912030      
      end
   end

   
   --LPO REQ. 266 Paquete 2 FIN
   /* Se retira control
   --LPO REQ. 215 Paquete 2 INICIO      
   if @i_clase = 'A' --Garantia Abierta
   begin
      select @w_valor_resp = 0
      
      --Saldo de capital de las operaciones del cliente mas el monto del tramite actual
      select @w_valor_resp = @w_monto + isnull(sum(am_cuota - am_pagado + am_gracia),0)
      from cr_gar_propuesta with (nolock),
           cob_cartera..ca_operacion with (nolock),
           cob_cartera..ca_amortizacion with (nolock)
      where op_tramite = gp_tramite
        and op_operacion = am_operacion
        and am_concepto  = 'CAP'
        and op_estado    not in (3,6)
        and gp_garantia  = @i_garantia
        and op_tramite   <> @i_tramite
      
      select @w_valor_cobertura   = cu_valor_actual
      from cob_custodia..cu_custodia
      where cu_codigo_externo = @i_garantia
      
      if round(@w_valor_cobertura,0) < round(@w_valor_resp,0)
      begin
         print 'Credito supera el porcentaje de cobertura de la garantia.'
         /* Garantia no tiene disponible para cubrir el tramite */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 2101114
         return 2101114
      end
   end
   --LPO REQ. 215 Paquete 2 FIN
   */
   if not exists (select 1
                  from cob_custodia..cu_cliente_garantia with (nolock)
                  where cg_ente         = @i_deudor
                  and cg_codigo_externo = @i_garantia
                  and cg_tipo_garante   in ('A','J','C'))
   begin
      /* Cliente no es deudor o amparado */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2103052
      return 1
   end

   if exists (select 1
              from  cob_credito..cr_gar_propuesta with (nolock),
              cob_custodia..cu_custodia with (nolock),
              cob_credito..cr_tramite with (nolock)
              where gp_garantia       = @i_garantia
              and   cu_tipo           in (select tipo from cr_superior_gp_esp
                                          where sesion =  @w_spid)
              and   cu_codigo_externo = gp_garantia
              and   tr_tramite        = gp_tramite
              and   tr_estado         in ('A','T','D','P'))
   begin
     /* Error en insercion de registro */
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 2108030

     return 1
   end

   insert into cr_tipo_actual_gp
   select cu_tipo , @w_spid
   from    cob_credito..cr_gar_propuesta,
   cob_custodia..cu_custodia,
   cr_superior_gp_esp A
   where gp_garantia = cu_codigo_externo
   and   A.tipo      = cu_tipo
   and   A.sesion    = @w_spid
   and   gp_tramite  = @i_tramite
   and   (gp_est_garantia <> 'C' and gp_est_garantia <> 'A')
   and   cu_estado   not in ('A','C','X','K')

   if exists ( select  1
   from    cr_tipo_actual_gp
   where   sesion = @w_spid)
   begin
      if exists (select 1
      from    cob_custodia..cu_custodia
      where   cu_codigo_externo = @i_garantia
      and     cu_estado not in ('A','C','X','K')
      and     cu_tipo in (select tipoa from cr_tipo_actual_gp where sesion = @w_spid))
      begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 1912120
          return 1
     end
   end

   --emg May-24-01 No permitir asignar garantias a tramites si estado es X:vigente por Cancelar
   if @i_estado <> 'X'
   begin

/*

      select @w_tr_toperacion  = tr_toperacion
      from   cr_tramite
      where  tr_tramite  = @i_tramite

      select @i_finagro = 'S' from cr_corresp_sib
      where codigo = @w_tr_toperacion  --LPO
      and   tabla  = 'T17'
      and   codigo not like '%2'

      if @i_finagro <> 'S'   --Tramite No Finagro
      begin
         select @w_tipo_garantia = cu_tipo
         from cob_custodia..cu_custodia
         where cu_codigo_externo = @i_garantia

         if exists (select 1
                    from cr_superior_gp
                    where sesion = @w_spid --LPO
            and tipo = @w_tipo_garantia)
         begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 2108032

              --return 1 emg May-23-03
         end
      end

*/


     /* Fin Nueva Validacion*/

     --VALIDAR SI TIENE RUBRO COMISION FAG NO SE PUEDE ATAR TRAMITE
     select @w_control = 'S'
     select @w_tipo_gar = cu_tipo,
            @w_val_actual = cu_valor_actual
     from cob_custodia..cu_custodia
     where cu_codigo_externo = @i_garantia

     if exists (select tg_tipo from cr_tmp_garfag where tg_sesion = @w_spid and tg_tipo = @w_tipo_gar)
     begin
       if exists (select 1
                  from cr_tramite, cr_corresp_sib
                  where tr_tramite = @i_tramite
                  and codigo=tr_destino
                  and tabla = 'T13')
          select @w_control = 'N'
     end
     
     select tipo = tc_tipo
     into #fag
     from cob_custodia..cu_tipo_custodia
     where tc_tipo_superior = @w_fag
     
     if not exists (select 1 from #fag where tipo = @w_tipo_cust) begin
        select @i_porcentaje_resp = round(@w_val_actual * 100 / @w_monto,2)
        select @i_valor_resp_garantia = @w_val_actual
     end
     
     if @w_control = 'S'
     begin
        begin tran
        insert into cr_gar_propuesta(
        gp_tramite, gp_garantia, gp_clasificacion,
        gp_exceso, gp_monto_exceso, gp_abierta,
        gp_deudor, gp_est_garantia, gp_porcentaje,
        gp_valor_resp_garantia, gp_fecha_mod, gp_previa )
        values (
        @i_tramite, @i_garantia, @i_clasificacion,
        @i_exceso, @i_monto_exceso, @i_clase,
        @i_deudor, @i_estado, @i_porcentaje_resp,
        @i_valor_resp_garantia, @s_date, @i_previa )

        if @@error <> 0
        begin
           /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2103001
           return 1
        end

        /* Transaccion de Servicio */
        /***************************/

        insert into ts_gar_propuesta
        values (
        @s_ssn, @t_trn, 'N',
        @s_date, @s_user, @s_term,
        @s_ofi,'cr_gar_propuesta', @s_lsrv,
        @s_srv, @i_tramite, @i_garantia,
        @i_clasificacion, @i_exceso,@i_monto_exceso,
        @i_clase, @i_deudor,@i_estado, @i_porcentaje_resp,
        @i_valor_resp_garantia, @w_fecha_mod, null )

        if @@error <> 0
        begin
           /* Error en insercion de transaccion de servicio */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2103003
           return 1
        end
        commit tran
           
        --truncate table #gp_previa 
     end
     else
     begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 2108046
          return 1
     end

   end
   else --Estado diferente de X emg
       begin
       /* No se puede adjuntar garantias en estado X */
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 2103051
       return 1
   end

end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
      /* Registro a actualizar no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2105002
      return 1
   end

   begin tran

      if @i_modo = 0
      begin
        update cob_credito..cr_gar_propuesta  set
        gp_porcentaje = @i_porcentaje_resp, --SBU: 06/abr/2000
        gp_valor_resp_garantia = @i_valor_resp_garantia
        where  gp_tramite = @i_tramite
        and  gp_garantia = @i_garantia

        if @@error <> 0
        begin
           /* Error en actualizacion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2105001
           return 1
        end
      end
      else
      begin
        update cob_credito..cr_gar_propuesta  set
        gp_clasificacion = @i_clasificacion,
        gp_exceso = @i_exceso,
        gp_monto_exceso = @i_monto_exceso,
        gp_porcentaje = @i_porcentaje_resp,
        gp_valor_resp_garantia = @i_valor_resp_garantia,
        gp_fecha_mod = @w_fecha_mod
        where  gp_tramite = @i_tramite
        and  gp_garantia = @i_garantia

        if @@error <> 0
        begin
           /* Error en actualizacion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2105001
           return 1
        end
      end

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_gar_propuesta
      values (
      @s_ssn, @t_trn, 'P',
      @s_date, @s_user, @s_term,
      @s_ofi, 'cr_gar_propuesta',@s_lsrv,@s_srv,
      @w_tramite, @w_garantia, @w_clasificacion,
      @w_exceso, @w_monto_exceso, @w_clase,
      @w_deudor, @w_estado, @w_porcentaje,
      @w_valor_resp, @s_date, 'N' )


      if @@error <> 0
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 2103003
         return 1
      end

      /* Transaccion de Servicio */
      /***************************/

      if @i_modo = 0        --SBU: 11/may/2000
      begin
        insert into ts_gar_propuesta
        values (
        @s_ssn, @t_trn, 'A',
        @s_date, @s_user, @s_term,
        @s_ofi,'cr_gar_propuesta', @s_lsrv,
        @s_srv, @i_tramite, @i_garantia,
        @w_clasificacion, @w_exceso, @w_monto_exceso,
        @w_clase, @w_deudor,@w_estado, @i_porcentaje_resp,
        @i_valor_resp_garantia, @s_date, NULL )


        if @@error <> 0
        begin
           /* Error en insercion de transaccion de servicio */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2103003
           return 1
        end
      end
      else
      begin
        insert into ts_gar_propuesta
        values (
        @s_ssn, @t_trn, 'A',
        @s_date, @s_user, @s_term,
        @s_ofi,'cr_gar_propuesta', @s_lsrv,
        @s_srv, @i_tramite, @i_garantia,
        @i_clasificacion, @i_exceso, @i_monto_exceso,
        @w_clase, @w_deudor,@w_estado, @i_porcentaje_resp,
        @i_valor_resp_garantia, @s_date, NULL )


        if @@error <> 0
        begin
           /* Error en insercion de transaccion de servicio */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 2103003
           return 1
        end
      end

   commit tran
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
      /* Registro a eliminar no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2107002
      return 1
   end

   ---113499 VAlidar si es tipo de tramite de Reestructuracion para quenopermita ELiminar Garantias
   if @w_tipo_tr = 'E'
   begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1912121
           return 1
   end
   ---113499

   begin tran

   if @w_estado = 'F'
   begin
      exec @w_return = cob_custodia..sp_cambios_estado
      @s_user           = @s_user,
      @s_date           = @s_date,
      @s_term           = @s_term,
      @s_ofi            = @s_ofi,
      @i_operacion      = 'I',
      @i_estado_ini     = 'F',
      @i_estado_fin     = 'X',
      @i_codigo_externo = @i_garantia,
      @i_banderafe      = 'S',
      @i_tramite        = @i_tramite
      
      if @w_return <> 0
      begin
         rollback
         return @w_return
      end
   end

   delete cob_credito..cr_gar_propuesta
   where gp_tramite  = @i_tramite
   and   gp_garantia = @i_garantia
   
   delete cob_cartera..ca_rubro_colateral
   where ruc_tramite = @i_tramite
   and   (ruc_tipo_gar = @w_tipo_gar or ruc_tipo_gar is null)
   
   if @@error <> 0
   begin
      /*Error en eliminacion de registro */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2107001
      return 1
   end

   /* Transaccion de Servicio */
   /***************************/
   
   insert into ts_gar_propuesta
   values
   (@s_ssn,@t_trn,'B',         @s_date,          @s_user,   @s_term,        @s_ofi,   'cr_gar_propuesta', @s_lsrv,  @s_srv,
   @w_tramite,   @w_garantia, @w_clasificacion, @w_exceso, @w_monto_exceso,@w_clase, @w_deudor,          @w_estado,@w_porcentaje,
   @w_valor_resp,@w_fecha_mod,NULL)
   
   if @@error <> 0
   begin
      /* Error en insercion de transaccion de servicio */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2103003
      return 1
   end

   /*elimino de otros tramites si es abierta y propuesta*/

   if (@w_estado = 'P' and @w_clase = 'A') begin
      -- elimino todas las excepciones asociadas a esta garantÝa en este tramite
      delete cob_credito..cr_excepciones
      where ex_tramite = @i_tramite
      and   ex_garantia = @i_garantia
   end

   if @w_estado = 'F'
   begin
      exec @w_return = cob_custodia..sp_cambios_estado
      @s_user           = @s_user,
      @s_date           = @s_date,
      @s_term           = @s_term,
      @s_ofi            = @s_ofi,
      @i_operacion      = 'I',
      @i_estado_ini     = 'F',
      @i_estado_fin     = 'X',
      @i_codigo_externo = @i_garantia,
      @i_banderafe      = 'S',
      @i_tramite        = @i_tramite
      
      if @w_return <> 0
      begin
         rollback
         return @w_return
       end
    end
    commit tran
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin

   select @i_garantia = isnull(@i_garantia, ' ')

   if @i_modo = 0
   begin
      set rowcount 1
      SELECT
      'Tramite'         = gp_tramite,
      'Garantia'        = gp_garantia,
      'Clasificacion'   = gp_clasificacion,
      'Cubre Exceso'    = gp_exceso,
      'Monto Exceso'    = gp_monto_exceso,
      'Caracter'        = gp_abierta,
      'Estado'          = gp_est_garantia,
      'Avaluador'       = ' ',
      'Propietario'     = substring(convert(char(10), cg_ente) + cg_nombre, 1, 64),
      'Porcentaje'      = gp_porcentaje,
      'Valor respaldo'  = gp_valor_resp_garantia
      from cr_gar_propuesta G left outer join cob_custodia..cu_cliente_garantia 
      on    cg_codigo_externo = G.gp_garantia 
      and   cg_tipo_garante  in ('J','C')
      where gp_tramite        = @i_tramite
      and   gp_est_garantia not in ('A','C')
      
    set rowcount 0
   end
   if @i_modo = 1
   begin
      /*select 
      'Estado'          = c.cu_estado,
      'Est. Credito'    = c.cu_estado_credito,
      'Caracter'        = c.cu_abierta_cerrada,
      'Numero'          = c.cu_codigo_externo,
      'Descripcion'     = substring(c.cu_descripcion, 1, 64),
      'Cliente'         = substring(convert(varchar(10),a.en_ente) +  ' ' + a.en_nomlar, 1, 64),
      'Moneda'          = c.cu_moneda,
      'Valor inicial'   = isnull(c.cu_valor_refer_comis,c.cu_valor_inicial),
      'Valor Actual'    = isnull(c.cu_valor_refer_comis,c.cu_valor_actual),
      '% Cobertura'     = gp_porcentaje,
      'Valor Respaldo'  = gp_valor_resp_garantia,
      'Fecha Avaluo'    = convert(varchar(10),c.cu_fecha_insp,103),
      'Avaluador'       = ' ',
      'Propietario'     = substring(convert(char(10), cg_ente) + cg_nombre, 1, 64)
      from cr_gar_propuesta G left outer join cob_custodia..cu_cliente_garantia
      on    cg_codigo_externo   = G.gp_garantia 
      and   cg_tipo_garante    in ('J','C'), cob_custodia..cu_custodia c, cobis..cl_ente a
      where gp_tramite          = @i_tramite
      and   gp_garantia         > @i_garantia
      and   gp_garantia         = cu_codigo_externo
      and   a.en_ente           = gp_deudor
      and   c.cu_estado       not in ('A','C')
      order by gp_garantia*/
      
      select 
      'Estado'          = c.cu_estado,
      'Est. Credito'    = c.cu_estado_credito,
	 'Numero'          = c.cu_codigo_externo,
	 'Tipo'            = tc_tipo,
	 'Descripcion'     = tc_descripcion,
      'Clase'           = c.cu_abierta_cerrada,
      'Cliente'         = substring(convert(varchar(10),a.en_ente) +  ' ' + a.en_nomlar, 1, 64),
      'Valor Actual'    = isnull(c.cu_valor_refer_comis,c.cu_valor_actual),
	 'Moneda'          = convert(varchar(2),c.cu_moneda),
	 'MonedaValue'     = 0.00,
      'Valor inicial'   = isnull(c.cu_valor_refer_comis,c.cu_valor_inicial),
	 'mrc'             = 0.00,
	 'mrcValue'        = 0.00,
	 'LastInspeccion'  =convert(varchar(10),c.cu_fecha_insp,103),
	 'account'         =cu_plazo_fijo,
      'accountType'     ='',
      'depreciaPercent' =tc_porcentaje,
      'location'        ='',
      'identification'  =substring(convert(char(10), cg_ente) + cg_nombre, 1, 64),
      'policy'          =CASE c.cu_posee_poliza when 'S' then @w_si else @w_no end,
	 'Fecha Avaluo'    = c.cu_fecha_avaluo,
	 'DirecionPrenda'  = c.cu_direccion_prenda,
	 '95139'           = 0,
	 '95140'           = 0,
	 '15234'           = cu_descripcion,
	 '95141'           = cu_fecha_const,
	 '95142'           = (select cu_fecha_modificacion from cob_custodia..cu_custodia where cu_estado='C' and cu_codigo_externo=c.cu_codigo_externo),
	 '95143'           = 0,
      '95144'           = getdate(),
      '95145'           = case when tc_tipo=@w_tipo_personal then @w_s else @w_n end --INDICA SI ES GARANTIA PERSONAL
      from cob_credito..cr_gar_propuesta G left outer join cob_custodia..cu_cliente_garantia
      on    cg_codigo_externo   = G.gp_garantia 
      and   cg_tipo_garante    in ('J','C'), cob_custodia..cu_custodia c, cobis..cl_ente a,
	  cob_custodia..cu_tipo_custodia
      where gp_tramite          = @i_tramite
      and   gp_garantia         > @i_garantia
      and   gp_garantia         = cu_codigo_externo
      and   a.en_ente           = gp_deudor
	  and   cu_tipo     = tc_tipo
      and   c.cu_estado       not in ('A','C')
      order by gp_garantia
   end
   if @i_modo = 2
   begin
      select
      'Estado'         = c.cu_estado,
      'Est. Credito'   = c.cu_estado_credito,
      'Caracter'       = c.cu_abierta_cerrada,
      'Numero'         = c.cu_codigo_externo,
      'Descripcion'    = substring(c.cu_descripcion, 1, 64),
      'Cliente'        = substring(convert(varchar(10),a.en_ente) +  ' ' + a.en_nomlar, 1, 64),
      'Moneda'         = c.cu_moneda,
      'Valor inicial'  = isnull(c.cu_valor_refer_comis,c.cu_valor_inicial),
      'Valor Actual'   = isnull(c.cu_valor_refer_comis,c.cu_valor_actual),
      '% Cobertura'    = gp_porcentaje,
      'Valor Respaldo' = gp_valor_resp_garantia,
      'Fecha Avaluo'   = convert(varchar(10),c.cu_fecha_insp,103),
      'Avaluador'      = ' ',
      ' '              = ''
      from  cr_gar_propuesta G, cob_custodia..cu_custodia c, cobis..cl_ente a
      where gp_tramite  =  @i_tramite
      and   gp_garantia >  @i_garantia
      and   gp_garantia =  cu_codigo_externo
      and   a.en_ente   =  gp_deudor
      and   c.cu_estado not in ('A','C')
      order by gp_garantia
   end
   
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
         select
              @w_tramite,
              @w_garantia,
              @w_clasificacion,
              @w_exceso,
              @w_monto_exceso,
              @w_clase,
              @w_deudor,
              @w_estado,
              @w_porcentaje,
              @w_valor_resp

    else
       begin
          /*Registro no existe */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 2101005
          return 1
       end
end

/**** Control de cobertura ****/
/******************************/
if @i_operacion = 'C'
begin

 /*************************************************************************/
   /* Validacion tramites de Reestructuracion: No se debe Agregar Garantias */
   /*************************************************************************/

   select @w_tipo_tr = tr_tipo, @w_deudor_cus = tr_cliente
   from cob_credito..cr_tramite
   where tr_tramite = @i_tramite


   if @w_tipo_tr = 'E'
   begin
      
      select @w_mensaje = 'No se permite anadir garantias en reestructuraciones '
      
      if @i_crea_ext <> 'S'
      begin
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file  = @t_file,
		  @t_from  = @w_sp_name,
		  @i_msg   = @w_mensaje,
		  @i_num   = 2101001
		  
		  return 2101001
      end
      else
      return 2101001
   end

   exec @w_error = cob_cartera..sp_matriz_garantias
   @s_date				= @s_date,
   @i_tramite           = @i_tramite,
   --@i_garantia          = @i_garantia,
   @i_porcentaje_resp   = @i_porcentaje_resp,
   @i_tipo_periodo      = 'P',
   @i_tipo_garantia     = @i_tipo_garantia,
   @i_crea_ext          = @i_crea_ext,
   @o_valor				= @w_factor out,
   @o_msg			    = @w_msg out	
   
   if @w_error <> 0 begin
	 if @i_crea_ext <> 'S'
      begin
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file  = @t_file,
		  @t_from  = @w_sp_name,
		  @i_num   = @w_error
		  return 1      
      end
      else
		return @w_error
   end

   select @o_retorno = @w_factor

   insert into cr_tramites_gp
          (tramite, operacion, moneda,
           porcentaje_resp, valor_resp,sesion) --ZR
   select  tr_tramite,
           tr_numero_op_banco,
           tr_moneda,
           gp_porcentaje,
           isnull(gp_valor_resp_garantia,0),
           @w_spid
   from cr_tramite, cr_gar_propuesta
   where tr_tramite = gp_tramite
   and   tr_estado   in ('A','T','D','P','N')
   and   gp_garantia =  @i_garantia
   and   gp_tramite  <> @i_tramite
end

return 0

go

