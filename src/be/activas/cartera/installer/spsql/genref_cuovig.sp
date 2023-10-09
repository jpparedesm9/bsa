/************************************************************************/
/*   Archivo:              genref_cuovig.sp                             */
/*   Stored procedure:     sp_gen_ref_cuota_vigente                     */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Raúl Altamirano Mendez                       */
/*   Fecha de escritura:   Febrero 2018                                 */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  ebaez      24-20-2018     correccio caso 107918                     */
/*  srojas     10-10-2018     Correccion caso 107289                    */
/*  srojas     21-11-2018     Referencias numéricas                     */
/*  portiz     22-04-2019     Caso Rol  de Operaciones                  */
/*  SMO        05-06-2019     REQ 113305                                */
/*  portiz     01-07-2019     Agregar correo 5                          */
/*  SRO        06-11-2019     Mejora 129659                             */
/*  ACH        30-05-2022     Err#184839-se agrega el estado 12         */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_gen_ref_cuota_vigente')
   drop proc sp_gen_ref_cuota_vigente
go

create proc sp_gen_ref_cuota_vigente
(
    @i_param1        datetime	 = null,
	@i_param2        int     	 = null,
	@i_param3        char(1)     = null, -- opcion
	@i_param4        cuenta      = null, -- banco
	@i_param5        int         = 2 -- sendMail  2 envia mail
)
as 

declare
@w_error                 int,
@w_return                int,
@w_fecha_proceso         datetime,
@w_fecha_vencimiento     datetime,
@w_banco                 cuenta,
@w_est_vigente           tinyint,
@w_est_vencida           tinyint,
@w_lon_operacion         tinyint,
@w_sp_name               varchar(30),
@w_msg                   varchar(255),
@w_param_convgar         varchar(30),
@w_institucion1          varchar(20),
@w_institucion2          varchar(20),
@w_grupo                 int, 
@w_grupo_tramite         int,
@w_fecha                 datetime, 
@w_corresponsal          varchar(20), 
@w_fecha_venci           datetime, 
@w_monto_pago            money, 
@w_referencia            varchar(40),
@w_ref_santander         varchar(40),
@w_fecha_ini             datetime,
@w_fecha_fin             datetime,
@w_ciudad_nacional       int,
@w_mensaje               varchar(150),
@w_batch                 int,
@w_formato_fecha         int,
@w_tramite               int,
@w_actividad             int, 
@w_operacion             int,
@w_nombre_grupo          varchar(64),
@w_id_corresp            varchar(10),
@w_sp_corresponsal       varchar(50),
@w_descripcion_corresp   varchar(30),
@w_fail_tran             char(1),
@w_convenio              varchar(30),
@w_funcionario           int,
@w_oficina               int,
@w_login                 login,
@w_nombre                varchar(255),
@w_correo                varchar(255),
@w_rol                   int,
@w_desc_rol              varchar(255),
@w_mail_default          varchar(30),
@w_tipo_tran             varchar(4),
@w_opcion                varchar(4),
@w_estado                char(1),
@w_send_mail             char(1),
@w_est_etapa2            tinyint, -- 12
@w_est_castigado         tinyint -- 4



select 
@w_sp_name       = 'sp_gen_ref_cuota_vigente',
@w_batch         = 7071, 
@w_formato_fecha = 111,
@w_tipo_tran     = 'PG'

if @i_param2 = 0 SELECT @i_param2 = NULL

--CORREO DEFECTO
select @w_mail_default = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'CPDSAN'
and pa_producto = 'CLI'

if (@@error != 0 or @@rowcount != 1)
begin
   select @w_error = 70188
	goto ERROR_PROCESO
end

select 
@w_fecha_vencimiento = @i_param1,
@w_grupo_tramite     = @i_param2,
@w_opcion            = @i_param3,
@w_banco             = @i_param4,
@w_send_mail         = @i_param5

if @w_send_mail = 1   select @w_estado = 'X'
else select @w_estado = 'P'
       

/*DETERMINAR FECHA DE PROCESO*/
select 
@w_fecha_proceso = isnull(@w_fecha_vencimiento, fp_fecha)
from cobis..ba_fecha_proceso 

declare @TablaRefGrupos as table (
grupo        int, 
correo       varchar(255), 
rol          varchar(30), 
ente         int, 
nombre       varchar(60), 
cargo        varchar(100))

declare @TablaInfoPresGroup as table (
grupo            int, 
cliente          int, 
operacion        int, 
tramite          int,
ope_grupal       cuenta, 
dividendo        int, 
fecha_ven        datetime, 
fecha_ult_pro    DATETIME,
grp_nombre       VARCHAR(64),   
opg_fecha_liq    DATETIME NULL, 
opg_moneda       SMALLINT NULL, 
opg_oficina      SMALLINT NULL, 
opg_operacion    INT NULL, 
oficial          int)

create table #universo_reporte_grupo (
 	grupo              int,
    cliente            int,
    tramite            int,
    referencia_grupal  varchar(15),
    operacion          int,
    fecha_ult_proceso  datetime,
    oficial            int
)
  
exec @w_error        = sp_estados_cca
@o_est_vigente  = @w_est_vigente out,
@o_est_vencido  = @w_est_vencida out,
@o_est_etapa2   = @w_est_etapa2 out,
@o_est_castigado = @w_est_castigado out


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'



delete from ca_gen_ref_cuota_vigente_det
delete from ca_gen_ref_cuota_vigente


if isnull(@w_grupo_tramite, 0) = 0 and @w_banco is null begin  -- MASIVO


   select 
   @w_fecha_fin = dateadd(dd,1,@w_fecha_proceso),
   @w_fecha_ini = dateadd(dd,1,@w_fecha_proceso)  --este es un proceso de inicio de dia

   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_fin) 
   BEGIN
      select @w_fecha_fin = dateadd(dd, 1, @w_fecha_fin)  -- ayer fue feriado, retrocedo un día hasta encontrar el dia habil.
   END 


   /* CONSIDERAR QUE EL UNIVERSO DE OPERACIONES A REPORTAR ES SOLO LAS QUE TIENEN VENCIMIENTO EN EL RANGO DE FECHAS */
   select distinct
   grupo             = tg_grupo,
   cliente           = op_cliente,
   tramite           = tg_tramite,
   referencia_grupal = tg_referencia_grupal,
   operacion         = op_operacion,
   fecha_ult_proceso = op_fecha_ult_proceso,
   oficial           = op_oficial
   into #universo_reporte
   from cob_credito..cr_tramite_grupal, ca_operacion, ca_dividendo (nolock)
   where op_cliente	= tg_cliente
   and   op_operacion	= tg_operacion
   and   op_operacion	= di_operacion 
   and   di_estado	= @w_est_vigente
   and   op_estado	in (@w_est_vigente, @w_est_vencida, @w_est_etapa2, @w_est_castigado) --caso#184839
   and   di_fecha_ven   between @w_fecha_ini and @w_fecha_fin

   /* SE REPORTA TOODO LO EXIGIBLE DE LOS PRESTAMOS SELECCIONADOS */
   insert into @TablaInfoPresGroup (
   grupo,         cliente,               operacion, 
   tramite,       ope_grupal,            dividendo, 
   fecha_ven,     fecha_ult_pro,         oficial)
   select 
   grupo,         cliente,                operacion, 
   tramite,       referencia_grupal,      di_dividendo, 
   di_fecha_ven,  fecha_ult_proceso,      oficial
   from #universo_reporte, ca_dividendo (nolock)
   where operacion	= di_operacion 
   and   di_estado	in (@w_est_vigente, @w_est_vencida)
   and   di_fecha_ven	<= @w_fecha_fin

   if @@error != 0 begin
   select @w_error = 724631
   goto ERROR_PROCESO
   end

end else begin  -- EN LINEA, UN GRUPO EN PARTICULAR

   select 
   @w_fecha_fin = @w_fecha_proceso,
   @w_fecha_ini = @w_fecha_proceso


   if @w_banco is null begin
   /* EL UNIVERSO A REPORTAR SE REDUCE A SOLO LAS OPERACIONES DE ESTE GRUPO EN PARTICULAR */
   	  insert into  #universo_reporte_grupo
   select distinct
   grupo             = tg_grupo,
   cliente           = op_cliente,
   tramite           = tg_tramite,
   referencia_grupal = tg_referencia_grupal,
   operacion         = op_operacion,
   fecha_ult_proceso = op_fecha_ult_proceso,
   oficial           = op_oficial
   --into #universo_reporte_grupo
   from cob_credito..cr_tramite_grupal, ca_operacion
   where tg_grupo       = @w_grupo_tramite
   and   op_cliente	= tg_cliente
   and op_operacion     = tg_operacion
   and op_estado        in (@w_est_vigente, @w_est_vencida, @w_est_etapa2, @w_est_castigado) --caso#184839


   
   end
   else begin
      /* EL UNIVERSO A REPORTAR SE REDUCE A SOLO LA OPERACION DEL BANCO QUE LLEGA COMO PARAMETRO */
      insert into  #universo_reporte_grupo
      select distinct
      grupo             = tg_grupo,
      cliente           = op_cliente,
      tramite           = tg_tramite,
      referencia_grupal = tg_referencia_grupal,
      operacion         = op_operacion,
      fecha_ult_proceso = op_fecha_ult_proceso,
      oficial           = op_oficial
    -- into #universo_reporte_grupo
      from cob_credito..cr_tramite_grupal, ca_operacion
      where op_cliente	= tg_cliente
      and op_operacion     = tg_operacion
      and tg_referencia_grupal  = @w_banco
      and op_estado        in (@w_est_vigente, @w_est_vencida, @w_est_etapa2, @w_est_castigado) --caso#184839
      
         /**para enviar el mail***/
      
      if exists (select 1 from cob_cartera..ca_ns_corresponsal_pago 
   		 where ncp_banco =  @w_banco) begin
   
     update cob_cartera..ca_ns_corresponsal_pago set
     	ncp_estado = @w_estado
    	where ncp_banco =  @w_banco
   
      end
      else
        insert into cob_cartera..ca_ns_corresponsal_pago (ncp_banco, ncp_estado)
        values(@w_banco, @w_estado)	
    
   end

   
   /* INTENTA AL INICIO REPORTAR LO VENCIDO O LO QUE VENCE HOY */
    insert into @TablaInfoPresGroup (
    	grupo,       cliente,    operacion, 
    	tramite,     ope_grupal, dividendo, 
    	fecha_ven,   fecha_ult_pro, oficial)
    select 
   grupo,         cliente,                operacion, 
   tramite,       referencia_grupal,      di_dividendo, 
   di_fecha_ven,  fecha_ult_proceso,      oficial
   from #universo_reporte_grupo, ca_dividendo (nolock)
   where operacion	 = di_operacion 
   and   di_estado	in (@w_est_vigente, @w_est_vencida)
   and   di_fecha_ven   <= @w_fecha_fin


   /* SI NO ENCONTRAMOS NADA QUE REPORTAR, AL MENOS REPORTAMOS LO VIGENTE SIN FECHA DE VENCIMIENTO*/ 
   if @@rowcount = 0 begin

      insert into @TablaInfoPresGroup (
      grupo,         cliente,               operacion, 
      tramite,       ope_grupal,            dividendo, 
      fecha_ven,     fecha_ult_pro,         oficial)
      select 
      grupo,         cliente,                operacion, 
      tramite,       referencia_grupal,      di_dividendo, 
      di_fecha_ven,  fecha_ult_proceso,      oficial
      from #universo_reporte_grupo, ca_dividendo (nolock)
      where operacion	 = di_operacion 
      and   di_estado	in (@w_est_vigente, @w_est_vencida)

	end

end -- si el reporte es en linea o es masivo


UPDATE @TablaInfoPresGroup SET
grp_nombre    = cob_conta_super.dbo.fn_formatea_ascii_ext(gr_nombre, 'AN')
FROM cobis..cl_grupo
WHERE grupo = gr_grupo


UPDATE @TablaInfoPresGroup SET
opg_fecha_liq = op_fecha_liq,
opg_moneda    = op_moneda,
opg_oficina   = op_oficina,
opg_operacion = op_operacion,
oficial       = op_oficial
FROM ca_operacion
WHERE ope_grupal = op_banco


insert into ca_gen_ref_cuota_vigente (
grv_grupo_id,                          grv_fecha_proceso, grv_grupo_name, 
grv_tramite,                           grv_op_fecha_liq,  grv_op_moneda, 
grv_op_oficina,                        grv_di_fecha_vig,  grv_di_dividendo, 
grv_di_monto)
select	
grupo,                                 @w_fecha_proceso,  grp_nombre,
tramite,		                       opg_fecha_liq, 	opg_moneda, 
opg_oficina,                           max(fecha_ven),    max(dividendo), 
sum(am_cuota + am_gracia - am_pagado)		
from  @TablaInfoPresGroup,  ca_amortizacion (nolock) 
where operacion		= am_operacion
and   dividendo	    = am_dividendo
group by grupo, tramite, ope_grupal, grp_nombre, opg_fecha_liq, opg_moneda, opg_oficina, opg_operacion
order by grupo, tramite, ope_grupal, grp_nombre, opg_fecha_liq, opg_moneda, opg_oficina, opg_operacion

if @@error != 0 begin
	select @w_error = 724632
	goto ERROR_PROCESO
end

select @w_grupo_tramite = 0


while (1=1) begin 
		  
   select top 1 
   @w_grupo_tramite = grv_grupo_id 
   from ca_gen_ref_cuota_vigente
   where grv_grupo_id  > isnull(@w_grupo_tramite,0)
   order by grv_grupo_id asc
   
   if @@rowcount=0 begin
      break     
   end
   
   select @w_id_corresp = 0
	  
	 
   while (1=1) begin
	  
      select top 1
      @w_id_corresp          = co_id,   
      @w_corresponsal        = co_nombre,
      @w_descripcion_corresp = co_descripcion,
      @w_sp_corresponsal     = co_sp_generacion_ref,
      @w_convenio            = ctr_convenio
      from  ca_corresponsal, 
      ca_corresponsal_tipo_ref   
      where co_id                 = ctr_co_id       
      and   convert(int,co_id)    > convert(int,@w_id_corresp)
      and   co_estado             = 'A'
      and   ctr_tipo_cobis        = @w_tipo_tran      
      and   co_nombre             not in ('OBJETADO','QUEBRANTO') --Mejora 129659
      order by convert(INT,co_id) asc
	  
	  if @@rowcount = 0 break 
	  
      exec @w_error     = @w_sp_corresponsal
      @i_tipo_tran      = @w_tipo_tran,
      @i_id_referencia  = @w_grupo_tramite ,
      @i_monto          = null,
      @i_monto_desde    = null,
      @i_monto_hasta    = null,
      @i_fecha_lim_pago = null,	  
      @o_referencia     = @w_referencia out
      
      
      if @w_error <> 0 begin
         select @w_msg = mensaje from cobis..cl_errores where numero = @w_error
		 print @w_msg + '. GRUPO:'+ convert(VARCHAR, @w_grupo_tramite)
         continue		 
      end
   
      insert into ca_gen_ref_cuota_vigente_det (
      grvd_grupo_id,        grvd_fecha_proceso,   grvd_corresponsal, grvd_institucion,      grvd_referencia,  grvd_convenio)
      values(
      @w_grupo_tramite,      @w_fecha_proceso,    @w_corresponsal,   @w_descripcion_corresp, @w_referencia,   @w_convenio)
	  
   end
end


/* CORREO ANALISTA ADMINISTRATIVO */
select @w_desc_rol = 'ANALISTA ADMINISTRATIVO'
select @w_rol = ro_id_rol 
from cob_workflow..wf_rol 
where ro_nombre_rol = @w_desc_rol

select distinct 
oficina = grv_op_oficina
into  #oficinas
from  ca_gen_ref_cuota_vigente

select @w_oficina = 0
while (1=1) begin

   select top 1
   @w_oficina     = oficina
   from   #oficinas
   where oficina >   @w_oficina
   order by oficina asc
   
   if @@rowcount = 0 break
   
   select top 1 
         @w_funcionario = fu_funcionario,
         @w_login       = fu_login,
         @w_nombre      = fu_nombre,
         @w_correo      = mf_descripcion
   from cob_workflow..wf_usuario a
   inner join cob_workflow..wf_usuario_rol b
   on us_id_usuario = ur_id_usuario
   inner join cobis..cl_funcionario
   on us_login = fu_login
   inner join cobis..cl_medios_funcio
   on fu_funcionario = mf_funcionario
   where ur_id_rol      = @w_rol
   and   fu_oficina     = @w_oficina
   and   mf_tipo        = '0'
   and   fu_estado      = 'V'

   if @@rowcount = 0 continue

   update ca_gen_ref_cuota_vigente set 
   grv_dest_nombre4 = cob_conta_super.dbo.fn_formatea_ascii_ext(@w_nombre, 'AN'), 
   grv_dest_cargo4  = @w_desc_rol, 
   grv_dest_email4  = @w_correo
   where grv_op_oficina = @w_oficina

   if (@@error != 0) begin
      select @w_error = 724633
      goto ERROR_PROCESO
   end
end



/* CORREO ASESOR */
select @w_desc_rol = 'ASESOR'

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = @w_desc_rol

select distinct 
	tramite = tramite,
	oficial = oficial,
	nombre  = fu_nombre,
	correo  = (select top 1 mf_descripcion from cobis..cl_medios_funcio where mf_funcionario = fu_funcionario and mf_tipo = '0'),
	cargo   = @w_desc_rol
into #oficiales
from @TablaInfoPresGroup, ca_gen_ref_cuota_vigente, cobis..cc_oficial, cobis..cl_funcionario
where grv_tramite = tramite
and oficial = oc_oficial
and oc_funcionario = fu_funcionario
and fu_estado      = 'V'

update ca_gen_ref_cuota_vigente set 
grv_dest_nombre5 = cob_conta_super.dbo.fn_formatea_ascii_ext(nombre, 'AN'), 
grv_dest_cargo5  = cargo, 
grv_dest_email5  = isnull(correo, @w_mail_default)
from #oficiales
where grv_tramite = tramite

-------------------------------------------------------------------------------------------

/* CORREOS DE LOS DIRECTIVOS DE GRUPO: PRESIDENTE, TESORERO Y SECRETARIO */

insert into @TablaRefGrupos (grupo, correo, rol, ente, nombre, cargo)
select cg_grupo, di_descripcion, cg_rol, di_ente, en_nomlar, b.valor
from cobis..cl_direccion, cobis..cl_cliente_grupo, cobis..cl_ente, cobis..cl_tabla a, cobis..cl_catalogo b
where di_ente = cg_ente
and   di_ente = en_ente
and   cg_grupo in (select grv_grupo_id from ca_gen_ref_cuota_vigente)
and   di_tipo in ('CE')
and   cg_rol in ('P', 'T', 'S')
and   cg_rol = b.codigo
and   a.codigo = b.tabla
and   a.tabla = 'cl_rol_grupo'

if (@@error != 0) begin
   select @w_error = 724631
   goto ERROR_PROCESO
end

 
update ca_gen_ref_cuota_vigente set 
grv_dest_nombre1 = cob_conta_super.dbo.fn_formatea_ascii_ext(b.nombre, 'AN'), 
grv_dest_cargo1  = cob_conta_super.dbo.fn_formatea_ascii_ext(b.cargo, 'AN'), 
grv_dest_email1	 = b.correo 
from @TablaRefGrupos b 
where grv_grupo_id   = b.grupo
and b.rol            = 'P'
and grv_fecha_proceso= @w_fecha_proceso

if (@@error != 0)
begin
	select @w_error = 724633
	goto ERROR_PROCESO
end

update ca_gen_ref_cuota_vigente set 
grv_dest_nombre2 = cob_conta_super.dbo.fn_formatea_ascii_ext(b.nombre, 'AN'), 
grv_dest_cargo2  = cob_conta_super.dbo.fn_formatea_ascii_ext(b.cargo, 'AN'), 
grv_dest_email2	 = b.correo
from @TablaRefGrupos b 
where grv_grupo_id   = b.grupo
and b.rol            = 'T'
and grv_fecha_proceso= @w_fecha_proceso

if (@@error != 0) begin
	select @w_error = 724633
	goto ERROR_PROCESO
end

update ca_gen_ref_cuota_vigente set 
grv_dest_nombre3 = cob_conta_super.dbo.fn_formatea_ascii_ext(b.nombre, 'AN'), 
grv_dest_cargo3  = cob_conta_super.dbo.fn_formatea_ascii_ext(b.cargo, 'AN'), 
grv_dest_email3	= b.correo
from @TablaRefGrupos b 
where grv_grupo_id = b.grupo
and b.rol          = 'S'
and grv_fecha_proceso= @w_fecha_proceso

if (@@error != 0) begin
	select @w_error = 724633
	goto ERROR_PROCESO
end

if @w_opcion ='Q' begin
   select 
       'fecha_inicio'    = grv_op_fecha_liq, 
       'nombre_cliente'  = grv_grupo_name,
       'fecha_vigencia'  = grv_di_fecha_vig, 
       'nro_pago'        = grv_di_dividendo,
       'monto'           = grv_di_monto,
       'sucursal'        = of_nombre,
       'mail1'           = grv_dest_email1, 
       'mail2'           = grv_dest_email2,
       'mail3'           = grv_dest_email3
       from
       ca_gen_ref_cuota_vigente,cobis..cl_oficina
       where grv_op_oficina = of_oficina

   select 
      'institucion' = grvd_institucion,
      'referencia'  = grvd_referencia,
      'convenio'    = grvd_convenio
   from ca_gen_ref_cuota_vigente_det
   
   return 0
end


exec @w_return = cob_cartera..sp_generador_xml 
@i_fecha = @w_fecha_proceso,
@i_batch = @w_batch,
@i_param = 'PFPCV'

if @w_return != 0 begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

return 0

   
ERROR_PROCESO:
select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error

set transaction isolation level read uncommitted
	  
select 
@w_banco = isnull(convert(varchar,@w_grupo_tramite), ''), 
@w_msg   = isnull(@w_msg,   '')
	  
select @w_msg = @w_msg + ' cuenta: ' + @w_banco
	  
return @w_error
GO

