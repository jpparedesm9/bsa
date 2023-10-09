/*************************************************************************/
/*   Archivo:            sp_genera_xml_gar_liquida.sp                    */
/*   Stored procedure:   sp_genera_xml_gar_liquida                       */
/*   Base de datos:      cob_cartera                                     */
/*   Producto:           Cartera                                         */
/*   Disenado por:       SRojas                                          */
/*   Fecha de escritura: 09/08/2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Genera archivo xml con informacion para el pago de la garantia      */
/*   liquida                                                             */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*  FECHA          AUTOR                       RAZON                     */
/*  09-08-2017     SRojas    Emision Inicial                             */
/*  21-11-2018     SRojas    Referencias numéricas                       */
/*  06-11-2019     SRojas    Mejora 129659                               */
/*  14-10-2019     PXSG      Cobro de Seguros 124807                     */
/*  16/01/2019     DCU       Requerimiento Req. 126891                   */
/*  13/10/2020     JCA       valores de seguro usando                    */
/*                           nuevo campo de valores                      */
/*  09/Nov/2020    DCU       Mejoras                                     */
/*  03/Mar/2021    SRO       Req #147999                                 */
/*  23/Jun/2021    ACH       ERR #161271-join cr_tramite_grupal          */
/*  13/Jun/2022    ACH       REQ #185234-se agrega func para Individual  */
/*                           no se paga garantiquida pero si seguro      */
/*  10/May/2022    KVI       ERR #182864-agregado distinct en op.Q       */
/*  20/Jun/2023    KVI       Req.203379-OT plazos crédito individual 2023*/
/*************************************************************************/

use cob_cartera
go

if object_id ('sp_genera_xml_gar_liquida') is not null
   drop procedure sp_genera_xml_gar_liquida
go

create procedure sp_genera_xml_gar_liquida
(
   @i_tramite           int, --Tramite (desde tabla de notificaciones de garantías líquidas)
   @i_opcion            char(2) = 'I',
   @i_vista_previa      char(1) = 'S',
   @o_gar_pendiente     char(1) = 'S' output

)
as
declare 
@w_cliente_grupo            int,
@w_grupal                   char(1),
@w_monto_gar_liquida        money,
@w_porcentaje_monto         float,
@w_fecha_pro_orig           datetime,
@w_referencia               varchar(30),
@w_fecha_proceso            datetime,
@w_fecha_ini_credito        datetime,
@w_moneda                   tinyint,
@w_oficina                  smallint,
@w_ruta_xml                 varchar(255),
@w_error                    int,
@w_sql_bcp                  varchar(5000),
@w_sql                      varchar(5000),
@w_mensaje_bcp              varchar(150),
@w_param_ISSUER             varchar(30),
@w_sp_name                  varchar(30),
@w_nombre_grupo             varchar(64),
@w_corresponsal             varchar(20), 
@w_id_corresp               varchar(10),
@w_sp_corresponsal          varchar(50),
@w_descripcion_corresp      varchar(30),
@w_fail_tran                char(1),
@w_convenio                 varchar(30),
@w_tipo_tran                varchar(4),
@w_promocion                char(1),
@w_monto_total              money,
@w_monto_seguro             money,
@w_monto_seguro_basico      money,
@w_msg                      varchar(255), 
@w_asistencia_medica        money,
--Historico
@w_cliente                  int,
@w_monto                    money,
@w_tipo_seguro              varchar(20),
@w_monto_basico             money,
@w_nombre_cliente           varchar(255),
@w_max_secuencial           int,
@w_seguro_vida              money,
@w_seguro_medico            money,
@w_monto_garantia           money, 
@w_count_eta_gar            int,
@w_monto_pagado_ant         money,
@w_tipo_seguro_ant          varchar(20),
@w_monto_basico_ant         money,
@w_monto_ant                money,
@w_diff_montos              money,
@w_toperacion               varchar(10),
@w_max_secuencial2          int           -- Req.203379


declare @resultadobcp table (linea varchar(max))

select @w_sp_name   = 'sp_genera_xml_gar_liquida'

select 
@w_grupal            = tr_grupal,
@w_moneda            = tr_moneda,
@w_fecha_ini_credito = tr_fecha_apr,
@w_oficina           = tr_oficina,
@w_cliente_grupo     = tr_cliente, -- porCaso#185234 este puede ser un solo un cliente y no el grupo
@w_promocion         = tr_promocion,
@w_toperacion        = tr_toperacion,
@w_tipo_tran         = case when tr_toperacion = 'GRUPAL' then 'GL' else 'GI' end --#185234: GL: Garantia Liquida Grupal, GI: Garantia Liquida Individual
from cob_credito..cr_tramite
where tr_tramite     = @i_tramite

if (@@rowcount = 0)
begin
   select @w_error = 724637
   goto ERROR
end

select @w_asistencia_medica = se_valor
from cob_cartera..ca_param_seguro_externo
where se_paquete = 'EXTENDIDO' and se_producto = @w_toperacion

select @w_asistencia_medica = isnull(@w_asistencia_medica, 0)

--Nota: Si se agrega un campo de salida a alguna opción, realizarlo tambien para la opción asociada.
if (@w_toperacion != 'GRUPAL') begin
    select @i_opcion = case when @i_opcion in ('F') then 'FI'
                            when @i_opcion in ('Q') then 'QI'
							when @i_opcion in ('I') then 'II'
                            else @i_opcion end
end

IF(@i_opcion='F') begin

   select 
   grupo_id      = in_grupo_id, -- para operaciones diferentes a grupales es el cliente
   nombre_grupo  = in_nombre_grupo, -- para operaciones diferentes a grupales es el cliente
   fecha_proceso = in_fecha_proceso,
   fecha_liq     = in_fecha_liq,    
   fecha_venc    = in_fecha_venc,   
   moneda        = in_moneda,       
   num_pago      = in_num_pago,     
   monto         = in_monto,        
   dest_nombre1  = in_dest_nombre1, 
   dest_cargo1   = in_dest_cargo1 , 
   dest_email1   = in_dest_email1 , 
   dest_nombre2  = in_dest_nombre2, 
   dest_cargo2   = in_dest_cargo2 , 
   dest_email2   = in_dest_email2 , 
   dest_nombre3  = in_dest_nombre3, 
   dest_cargo3   = in_dest_cargo3 , 
   dest_email3   = in_dest_email3 , 
   of_nombre 
   from cob_cartera..ca_infogaragrupo, cobis..cl_oficina 
   where in_oficina_id = of_oficina 
   and in_tramite = @i_tramite
     
   select 
   isd_cliente,           
   isd_nombre_cliente,    
   isd_monto_seguro,      
   isd_monto_asist_medica,
   isd_monto_garantia,    
   isd_grupo,             
   isd_tramite           
   from cob_cartera..ca_infosegurogrupo_det a, cob_cartera..ca_infogaragrupo b
   where a.isd_tramite = @i_tramite
   and a.isd_tramite = b.in_tramite
   --where  a.isd_grupo    = b.in_grupo_id
   --and    b.in_tramite   = @i_tramite
        
   select 
   institucion    = ind_institucion, 
   referencia     = ind_referencia, 
   convenio       = ind_convenio, 
   grupo_id       = ind_grupo_id
   from cob_cartera..ca_infogaragrupo_det, cob_cartera..ca_infogaragrupo
   where  ind_grupo_id = in_grupo_id
   and in_tramite = @i_tramite
   and ind_tramite = in_tramite
   
   --delete ca_infogaragrupo_det  where  ind_grupo_id = @w_grupo
   --delete ca_infosegurogrupo_det where isd_grupo    = @w_grupo
   delete ca_infogaragrupo_det  where  ind_tramite = @i_tramite
   delete ca_infosegurogrupo_det where isd_tramite = @i_tramite
   delete ca_infogaragrupo where in_tramite =  @i_tramite  

   return 0
END

--porCaso#185234
IF( @i_opcion = 'FI') begin

    select 
    grupo_id      = in_cliente_id, -- para operaciones diferentes a grupales es el cliente
    nombre_grupo  = in_nombre_cliente, -- para operaciones diferentes a grupales es el cliente
    fecha_proceso = in_fecha_proceso,
    fecha_liq     = in_fecha_liq,    
    fecha_venc    = in_fecha_venc,   
    moneda        = in_moneda,       
    num_pago      = in_num_pago,     
    monto         = in_monto,        
    dest_nombre1  = in_dest_nombre1, 
    dest_cargo1   = in_dest_cargo1 , 
    dest_email1   = in_dest_email1 , 
    dest_nombre2  = in_dest_nombre2, 
    dest_cargo2   = in_dest_cargo2 , 
    dest_email2   = in_dest_email2 , 
    dest_nombre3  = in_dest_nombre3, 
    dest_cargo3   = in_dest_cargo3 , 
    dest_email3   = in_dest_email3 , 
    of_nombre 
    from cob_cartera..ca_infogaracliente, cobis..cl_oficina 
    where in_oficina_id = of_oficina 
    and in_tramite = @i_tramite
      
    select 
    isd_cliente,           
    isd_nombre_cliente,    
    isd_monto_seguro,      
    isd_monto_asist_medica,
    isd_monto_garantia,    
    isd_grupo,             
    isd_tramite           
    from cob_cartera..ca_infosegurocliente_det a, cob_cartera..ca_infogaracliente b
    where a.isd_tramite = @i_tramite
    and a.isd_tramite = b.in_tramite
    --where  a.isd_grupo    = b.in_grupo_id
    --and    b.in_tramite   = @i_tramite
         
    select 
    institucion    = ind_institucion, 
    referencia     = ind_referencia, 
    convenio       = ind_convenio, 
    grupo_id       = ind_cliente_id
    from cob_cartera..ca_infogaracliente_det, cob_cartera..ca_infogaracliente
    where  ind_cliente_id = in_cliente_id
    and in_tramite = @i_tramite
    and ind_tramite = in_tramite
    
    --delete ca_infogaragrupo_det  where  ind_grupo_id = @w_grupo
    --delete ca_infosegurogrupo_det where isd_grupo    = @w_grupo
    delete ca_infogaracliente_det  where  ind_tramite = @i_tramite
    delete ca_infosegurocliente_det where isd_tramite = @i_tramite
    delete ca_infogaracliente where in_tramite =  @i_tramite  
    
    return 0
END

--Parametro porcentaje para el calculo de la garantia
select @w_porcentaje_monto = pa_float
  from cobis..cl_parametro 
 where pa_nemonico = 'PGARGR' 
   and pa_producto = 'CCA'

--Parametro referencia del corresponsal
select @w_param_ISSUER = pa_char
  from cobis..cl_parametro 
 where pa_nemonico = 'ISSUER' 
   and pa_producto = 'CCA'

if (@@error != 0 or @@rowcount != 1)
begin
    select @w_error = 724629
    goto ERROR
end


--Ruta del archivo xml
select @w_ruta_xml = ba_path_destino
  from cobis..ba_batch 
 where ba_batch = 7076

if (@@error != 0 or @@rowcount != 1 or isnull(@w_ruta_xml, '') = '')
begin
    select @w_error = 724636
    goto ERROR
end


--Fecha proceso y cálculo de fecha de vencimiento del pago
select @w_fecha_proceso = fp_fecha
  from cobis..ba_fecha_proceso

select @w_fecha_proceso  = convert(datetime,convert(varchar(10), @w_fecha_proceso,101) + ' ' + convert(varchar(12),getdate(),114))
select @w_fecha_pro_orig = dateadd(hour,36,@w_fecha_proceso)

if (@w_toperacion = 'GRUPAL' and @w_grupal <> 'S')
begin
    select @w_error = 724672
	goto ERROR
end


--Encuentro el monto de los seguros


select @w_monto_seguro = sum(case when isnull(se_monto,0) <> 0 and isnull(se_monto,0) > isnull(se_monto_pagado,0) then
                                    isnull(se_monto,0)- isnull(se_monto_pagado,0)
                                    else 0 end)
from cob_cartera..ca_seguro_externo
where se_tramite = @i_tramite



select @w_monto_gar_liquida = sum(case when isnull(gl_monto_garantia, 0) > isnull(gl_pag_valor,0) then
                                  isnull(gl_monto_garantia, 0) - isnull(gl_pag_valor,0)
                                  else 0 end)
from cob_cartera..ca_garantia_liquida
where gl_tramite = @i_tramite
                                              

select @w_monto_total=isnull(@w_monto_seguro,0)
select @w_monto_total=isnull(@w_monto_total,0)+isnull(@w_monto_gar_liquida,0)


print '@w_monto_total'+convert(varchar(50),@w_monto_total)

--porCaso#185234
if (@w_toperacion = 'GRUPAL') begin
    delete ca_infogaragrupo_det  where  ind_tramite = @i_tramite
    delete ca_infosegurogrupo_det where isd_tramite = @i_tramite 
    --delete ca_infogaragrupo_det  where  ind_grupo_id = @w_grupo
    --delete ca_infosegurogrupo_det where isd_grupo = @w_grupo
    delete ca_infogaragrupo where in_tramite =  @i_tramite 
end else begin
    delete ca_infogaracliente_det  where  ind_tramite = @i_tramite
    delete ca_infosegurocliente_det where isd_tramite = @i_tramite
    delete ca_infogaracliente where in_tramite =  @i_tramite 
end

        
--porCaso#185234
create table #TablaRefGrupos (
    grupo  int,
    correo varchar(254),
    rol    varchar(10),
    ente   int,
    nombre varchar(254),
    cargo  varchar(64)
)

if (@w_toperacion = 'GRUPAL') begin
    --Obtiene y actualiza en la temporal los correos de presidente, tesorero y secretario 
    insert into #TablaRefGrupos
	select
    grupo  = cg_grupo, 
    correo = di_descripcion, 
    rol    = cg_rol, 
    ente   = di_ente, 
    nombre = en_nomlar, 
    cargo  = b.valor
    from cobis..cl_direccion, cobis..cl_cliente_grupo, cobis..cl_ente,
    cobis..cl_tabla a, cobis..cl_catalogo b
    where di_ente = cg_ente
    and di_ente   = en_ente
    and cg_grupo  = @w_cliente_grupo
    and di_tipo   = 'CE'
    and cg_rol   in ('P', 'T', 'S')
    and cg_rol    = b.codigo
    and a.codigo  = b.tabla
    and a.tabla   = 'cl_rol_grupo'
end else begin
    insert into #TablaRefGrupos
	select
    grupo  = en_ente, 
    correo = di_descripcion, 
    rol    = 'D',
    ente   = di_ente, 
    nombre = en_nomlar, 
    cargo  = 'DEUDOR'
    from cobis..cl_ente, cobis..cl_direccion
    where en_ente = @w_cliente_grupo
	and en_ente = di_ente
    and di_tipo   = 'CE'
end

if @w_monto_total > 0 begin
    
	if (@w_toperacion = 'GRUPAL') begin
        insert into ca_infogaragrupo 
        select 
        in_grupo_id      = @w_cliente_grupo,
        in_nombre_grupo  = convert(varchar(64),null),
        in_fecha_proceso = @w_fecha_proceso,
        in_fecha_liq     = @w_fecha_ini_credito,
        in_fecha_venc    = @w_fecha_pro_orig,
        in_moneda        = @w_moneda,
        in_oficina_id    = @w_oficina,
        in_num_pago      = convert(tinyint,1),
        in_monto         = @w_monto_total,--@w_monto_gar_liquida,
        in_dest_nombre1  = convert(varchar(64), ''),
        in_dest_cargo1   = convert(varchar(100), ''),
        in_dest_email1   = convert(varchar(255), ''),
        in_dest_nombre2  = convert(varchar(64), ''),
        in_dest_cargo2   = convert(varchar(100), ''),
        in_dest_email2   = convert(varchar(255), ''),
        in_dest_nombre3  = convert(varchar(64), ''),
        in_dest_cargo3   = convert(varchar(100), ''),
        in_dest_email3   = convert(varchar(255), ''),
        in_tramite       = @i_tramite
	end else begin
        insert into ca_infogaracliente
        select 
        in_grupo_id      = @w_cliente_grupo,
        in_nombre_grupo  = convert(varchar(64),null),
        in_fecha_proceso = @w_fecha_proceso,
        in_fecha_liq     = @w_fecha_ini_credito,
        in_fecha_venc    = @w_fecha_pro_orig,
        in_moneda        = @w_moneda,
        in_oficina_id    = @w_oficina,
        in_num_pago      = convert(tinyint,1),
        in_monto         = @w_monto_total,--@w_monto_gar_liquida,
        in_dest_nombre1  = convert(varchar(64), ''),
        in_dest_cargo1   = convert(varchar(100), ''),
        in_dest_email1   = convert(varchar(255), ''),
        in_dest_nombre2  = convert(varchar(64), ''),
        in_dest_cargo2   = convert(varchar(100), ''),
        in_dest_email2   = convert(varchar(255), ''),
        in_dest_nombre3  = convert(varchar(64), ''),
        in_dest_cargo3   = convert(varchar(100), ''),
        in_dest_email3   = convert(varchar(255), ''),
        in_tramite       = @i_tramite
	end
	
    --Inicio Generar referencia por corresponsal
    select @w_id_corresp = 0
   

    while 1 = 1 begin
      
        select top 1
        @w_id_corresp               = co_id,   
        @w_corresponsal             = co_nombre,
        @w_descripcion_corresp      = co_descripcion,
        @w_sp_corresponsal          = co_sp_generacion_ref,
        @w_convenio                 = ctr_convenio
        from  ca_corresponsal, 
        ca_corresponsal_tipo_ref
        where co_id                 = ctr_co_id 
        and   convert(int,co_id)    > convert(int,@w_id_corresp)
        and   co_estado             = 'A'
        and   ctr_tipo_cobis        = @w_tipo_tran   
        and   co_nombre             not in ('OBJETADO','QUEBRANTO') --Mejora 129659
        order by convert(INT,co_id) asc
	  
        if @@rowcount = 0 break
	    print '--->>>Va a generar:' + @w_sp_corresponsal +'--tipoTran: ' +  @w_tipo_tran + '--cliente: ' + convert(varchar,@w_cliente_grupo)
	    print '--->>>Va a w_monto_total:' + convert(varchar,@w_monto_total) + '--Fecha: '+ convert(varchar,@w_fecha_pro_orig)
        exec @w_error     = @w_sp_corresponsal
        @i_tipo_tran      = @w_tipo_tran,
        @i_id_referencia  = @w_cliente_grupo,
        @i_monto          = @w_monto_total,
        @i_monto_desde    = null,
        @i_monto_hasta    = null,
        @i_fecha_lim_pago = @w_fecha_pro_orig,	  
        @o_referencia     = @w_referencia out
        
        
        if @w_error <> 0 begin
           select @w_msg = mensaje from cobis..cl_errores where numero = @w_error
           print @w_msg + '. CLIENTE-GRUPO:'+ convert(VARCHAR, @w_cliente_grupo) + '-->tramite: ' + convert(VARCHAR, @i_tramite)
           continue
        end
        	 
	    if (@w_toperacion = 'GRUPAL') begin		 
            insert into ca_infogaragrupo_det 
            (ind_grupo_id, ind_corresponsal, ind_institucion,        ind_referencia, ind_convenio, ind_tramite)
            values
            (@w_cliente_grupo,     @w_corresponsal,  @w_descripcion_corresp, @w_referencia,  @w_convenio,  @i_tramite)
        end else begin
            insert into ca_infogaracliente_det 
            (ind_cliente_id, ind_corresponsal, ind_institucion,        ind_referencia, ind_convenio, ind_tramite)
            values
            (@w_cliente_grupo,     @w_corresponsal,  @w_descripcion_corresp, @w_referencia,  @w_convenio,  @i_tramite)
		end
    end --Fin Generar referencia por corresponsal

    --porCaso#185234
    if (@w_toperacion = 'GRUPAL')
        select @w_nombre_grupo = upper(gr_nombre) from cobis..cl_grupo where gr_grupo = @w_cliente_grupo
    else
        select @w_nombre_grupo = upper(en_nombre) + ' ' + upper(isnull(p_s_nombre,'')) + ' ' + upper(p_p_apellido) + ' ' + upper(isnull(p_s_apellido, '')) from cobis..cl_ente where en_ente = @w_cliente_grupo
    
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Á','A')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'É','E')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Í','I')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Ó','O')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Ú','U')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Ñ','N')
    select @w_nombre_grupo = replace(@w_nombre_grupo,'Ü','U')

    if (@w_toperacion = 'GRUPAL')
        update ca_infogaragrupo 
        set in_nombre_grupo = @w_nombre_grupo
        where in_grupo_id = @w_cliente_grupo
        and in_tramite = @i_tramite
    else
        update ca_infogaracliente
        set in_nombre_cliente = @w_nombre_grupo
        where in_cliente_id = @w_cliente_grupo
        and in_tramite = @i_tramite
		
   --print 'actualiza data xml grupo: ' + convert(varchar, @w_grupo) + ' tramite: ' + convert(varchar, @i_tramite) + ' referencia: ' + @w_referencia
    --porCaso#185234
    if (@w_toperacion = 'GRUPAL') begin
        update ca_infogaragrupo set 
        in_dest_nombre1 = b.nombre, 
        in_dest_cargo1  = b.cargo, 
        in_dest_email1  = b.correo 
        from #TablaRefGrupos b 
        where in_grupo_id = b.grupo
        and   b.rol       = 'P'
		and   in_tramite = @i_tramite
        
        update ca_infogaragrupo set
        in_dest_nombre2 = b.nombre, 
        in_dest_cargo2  = b.cargo, 
        in_dest_email2  = b.correo 
        from #TablaRefGrupos b 
        where in_grupo_id = b.grupo
        and b.rol    = 'T'
		and in_tramite = @i_tramite
        
        update ca_infogaragrupo set
        in_dest_nombre3 = b.nombre, 
        in_dest_cargo3  = b.cargo, 
        in_dest_email3  = b.correo 
        from #TablaRefGrupos b 
        where in_grupo_id = b.grupo
        and   b.rol       = 'S'
		and   in_tramite = @i_tramite
		
    end else begin
        update ca_infogaracliente set
        in_dest_nombre1 = b.nombre, 
        in_dest_cargo1  = b.cargo, 
        in_dest_email1  = b.correo 
        from #TablaRefGrupos b 
        where in_cliente_id = b.grupo
        and   b.rol       = 'D'
		and   in_tramite  = @i_tramite
	end
	
    select * into #seguro_externo_his
    from cob_cartera_his..ca_seguro_externo_his
    where seh_tramite = @i_tramite
    
    select @w_cliente = 0, @w_monto = 0, @w_tipo_seguro = '', @w_monto_basico = 0
    
    select @w_count_eta_gar = count(ia_id_inst_act)
    from cob_workflow..wf_inst_proceso, cob_workflow..wf_inst_actividad
    where io_id_inst_proc = ia_id_inst_proc
    and   io_campo_3      = @i_tramite
    and   io_estado       = 'EJE'
    and   ia_nombre_act   = 'ESPERA AUTOMATICA GAR LIQUIDA'
   
    --porCaso#185234
    create table #cliente_integrante(
        tramite int,
		cliente int,
        monto money,
        tipo_seguro varchar(16),
        monto_basico money		
    )
	
	--porCaso#185234
    if (@w_toperacion = 'GRUPAL') begin
        insert into #cliente_integrante
	    select se_tramite, 
	           se_cliente,
	           isnull(se_monto,0),
	           se_tipo_seguro,
	           isnull(se_monto_basico,0)
	    from cob_cartera..ca_seguro_externo, cob_credito..cr_tramite_grupal --caso161271
	    where se_tramite = @i_tramite
	    and se_tramite = tg_tramite
	    and se_cliente = tg_cliente
	    and tg_participa_ciclo = 'S'
	    and tg_monto > 0
        --and se_cliente > @w_cliente 
	    --order by se_cliente asc	
	end else begin
        insert into #cliente_integrante
	    select tr_tramite,
	           se_cliente,
	           isnull(se_monto,0),
	           se_tipo_seguro,
	           isnull(se_monto_basico,0)
	    from cob_cartera..ca_seguro_externo, cob_credito..cr_tramite --caso161271
	    where se_tramite = @i_tramite
	    and se_tramite = tr_tramite
	    and se_cliente = tr_cliente
	    and tr_monto > 0
	end
	
    while 1 = 1 begin
   
        select top 1 
	    @w_cliente       = cliente,
	    @w_monto         = monto,
	    @w_tipo_seguro   = tipo_seguro,
	    @w_monto_basico  = monto_basico
	    from #cliente_integrante
	    where tramite = @i_tramite
	    and cliente > @w_cliente 
	    order by cliente asc
	    
	    if @@rowcount = 0 break
	    
	    
	    if ( @w_count_eta_gar > 1 ) and exists ( select 1 from #seguro_externo_his where seh_cliente = @w_cliente ) begin
	  
	        select @w_max_secuencial = max(seh_secuencial) 
	        from #seguro_externo_his 
	        where seh_cliente   = @w_cliente
	        and   seh_operacion = 'D'
			
			select @w_max_secuencial2 = max(seh_secuencial) -- Req.203379
	        from #seguro_externo_his 
	        where seh_cliente   = @w_cliente
	        and   seh_operacion = 'D'
			and   seh_secuencial <> @w_max_secuencial
	        
	        select 
	        @w_monto_pagado_ant       = seh_monto_pagado,
	        @w_tipo_seguro_ant        = seh_tipo_seguro,
		    @w_monto_basico_ant       = seh_monto_basico,
		    @w_monto_ant              = seh_monto
	        from #seguro_externo_his
	        where seh_cliente     = @w_cliente
	        and   seh_secuencial  = @w_max_secuencial2		 
		    
		    select @w_monto_pagado_ant = isnull(@w_monto_pagado_ant,0)
		    select @w_monto_basico_ant = isnull(@w_monto_basico_ant,0)
            select @w_monto_ant = isnull(@w_monto_ant,0)
            
		    
		    select
            @w_seguro_vida   = @w_monto_basico - @w_monto_basico_ant,
		    @w_diff_montos   = @w_monto - @w_monto_ant
		 
		    select 
		    @w_seguro_vida = case when @w_seguro_vida < 0 then 0 else @w_seguro_vida end,
		    @w_diff_montos = case when @w_diff_montos < 0 then 0 else @w_diff_montos end
		    
            select @w_seguro_medico = @w_diff_montos - @w_seguro_vida
		 
	    end else begin
	        select 
		    @w_seguro_vida   = @w_monto_basico,
		    @w_seguro_medico = @w_monto - @w_monto_basico
	  
	    end
	  
	    select @w_nombre_cliente = isnull(en_nombre,'') +
        case when p_s_nombre   is null then '' else ' '+ p_s_nombre end +
   	    case when p_p_apellido is null then '' else ' '+ p_p_apellido end +
        case when p_s_apellido is null then '' else ' '+ p_s_apellido end
        from cobis..cl_ente
	    where en_ente = @w_cliente
	    
	    select @w_monto_garantia = case when isnull(gl_monto_garantia, 0) > isnull(gl_pag_valor,0) then isnull(gl_monto_garantia, 0) - isnull(gl_pag_valor,0)
        else 0 end
        from cob_cartera..ca_garantia_liquida
   	    where gl_tramite    = @i_tramite
        and   gl_cliente    = @w_cliente
	    select @w_monto_garantia = isnull(@w_monto_garantia, 0)
	      
	      
	    if (@w_toperacion = 'GRUPAL')
	        insert into ca_infosegurogrupo_det
            values (@w_cliente, @w_nombre_cliente, @w_seguro_vida, @w_seguro_medico, @w_monto_garantia,@w_cliente_grupo,  @i_tramite)
	    else
	        insert into ca_infosegurocliente_det
            values (@w_cliente, @w_nombre_cliente, @w_seguro_vida, @w_seguro_medico, @w_monto_garantia,@w_cliente_grupo,  @i_tramite)
    end
end

	  
if @i_opcion = 'Q'
begin
   --insertar en tabla temporal para consultar datos

   if @w_monto_total > 0
	  select @o_gar_pendiente = 'S'
   else 
   begin
	  select @o_gar_pendiente = 'N'
   end
	  
   if @i_vista_previa = 'S'
   begin
      if @w_monto_total <= 0
      begin
		   select @w_error = 70173
		   goto ERROR
	  end
	  else begin 
		  
         select distinct --Error #182864  
         grupo_id      = in_grupo_id, 
         nombre_grupo  = in_nombre_grupo, 
         fecha_proceso = in_fecha_proceso,
         fecha_liq     = in_fecha_liq,    
         fecha_venc    = in_fecha_venc,  
         moneda        = in_moneda,      
         num_pago      = in_num_pago,    
         monto         = in_monto,        
         dest_nombre1  = in_dest_nombre1,
         dest_cargo1   = in_dest_cargo1 , 
         dest_email1   = in_dest_email1 ,  
         dest_nombre2  = in_dest_nombre2,  
         dest_cargo2   = in_dest_cargo2 , 
         dest_email2   = in_dest_email2 ,
         dest_nombre3  = in_dest_nombre3, 
         dest_cargo3   = in_dest_cargo3 , 
         dest_email3   = in_dest_email3 ,  
         of_nombre
         from cob_cartera..ca_infogaragrupo, cobis..cl_oficina
         where in_oficina_id = of_oficina
         and in_tramite = @i_tramite
	
	    select distinct --Error #182864  
        institucion    = ind_institucion, 
        referencia     = ind_referencia, 
        convenio       = ind_convenio, 
        grupo_id       = ind_grupo_id
        from cob_cartera..ca_infogaragrupo_det, cob_cartera..ca_infogaragrupo
        where ind_grupo_id = in_grupo_id
        and in_tramite = @i_tramite
		and ind_tramite= in_tramite

		select distinct  --Error #182864     
		isd_nombre_cliente,    
		isd_monto_seguro,      
		isd_monto_asist_medica,
		isd_monto_garantia,    
		isd_grupo,             
		isd_tramite
		from cob_cartera..ca_infosegurogrupo_det a, cob_cartera..ca_infogaragrupo b
        where  a.isd_grupo  = b.in_grupo_id
        and    b.in_tramite = @i_tramite
		and    isd_tramite = in_tramite
             
	  
      end
	       
       
	end
	
    return 0
end

--porCaso#185234
if @i_opcion = 'QI' begin
   --insertar en tabla temporal para consultar datos

    if @w_monto_total > 0
        select @o_gar_pendiente = 'S'
    else begin
        select @o_gar_pendiente = 'N'
    end
	  
    if @i_vista_previa = 'S' begin
        if @w_monto_total <= 0
        begin
            select @w_error = 70173
            goto ERROR
        end
        else begin		  
            select
            grupo_id      = in_cliente_id, 
            nombre_grupo  = in_nombre_cliente, 
            fecha_proceso = in_fecha_proceso,
            fecha_liq     = in_fecha_liq,    
            fecha_venc    = in_fecha_venc,  
            moneda        = in_moneda,      
            num_pago      = in_num_pago,    
            monto         = in_monto,        
            dest_nombre1  = in_dest_nombre1,
            dest_cargo1   = in_dest_cargo1 , 
            dest_email1   = in_dest_email1 ,  
            dest_nombre2  = in_dest_nombre2,  
            dest_cargo2   = in_dest_cargo2 , 
            dest_email2   = in_dest_email2 ,
            dest_nombre3  = in_dest_nombre3, 
            dest_cargo3   = in_dest_cargo3 , 
            dest_email3   = in_dest_email3 ,  
            of_nombre
            from cob_cartera..ca_infogaracliente, cobis..cl_oficina
            where in_oficina_id = of_oficina
            and in_tramite = @i_tramite
	
	        select 
            institucion    = ind_institucion, 
            referencia     = ind_referencia, 
            convenio       = ind_convenio, 
            grupo_id       = ind_cliente_id
            from cob_cartera..ca_infogaracliente_det, cob_cartera..ca_infogaracliente
            where ind_cliente_id = in_cliente_id
            and in_tramite = @i_tramite
		    and ind_tramite= in_tramite

		    select        
		    isd_nombre_cliente,    
		    isd_monto_seguro,      
		    isd_monto_asist_medica,
		    isd_monto_garantia,    
		    isd_grupo,             
		    isd_tramite
		    from cob_cartera..ca_infosegurocliente_det a, cob_cartera..ca_infogaracliente b
            where  a.isd_grupo  = b.in_cliente_id
            and    b.in_tramite = @i_tramite
		    and    isd_tramite = in_tramite             	  
        end	             
	end
    return 0
end

if @i_opcion = 'I'
begin
    print'Ingresa I'
    if(@w_promocion='N') begin
     	if @w_monto_total <= 0
    	begin
            --porCaso#185234
            --delete ca_infogaragrupo_det  where  ind_grupo_id = @w_grupo
    		--delete ca_infosegurogrupo_det where isd_grupo = @w_grupo
            delete ca_infogaragrupo_det  where  ind_tramite = @i_tramite
            delete ca_infosegurogrupo_det where isd_tramite = @i_tramite 
            delete ca_infogaragrupo where in_tramite =  @i_tramite  
      
        end		   
    end
end

--porCaso#185234
if @i_opcion = 'II'
begin
    print'Ingresa II'     		
    if @w_monto_total <= 0
    begin            
         delete ca_infogaracliente_det  where  ind_tramite = @i_tramite
         delete ca_infosegurocliente_det where isd_tramite = @i_tramite 
         delete ca_infogaracliente where in_tramite =  @i_tramite      
     end
end

print'Ingresa 3'
return 0

ERROR:

exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error
return @w_error
GO
