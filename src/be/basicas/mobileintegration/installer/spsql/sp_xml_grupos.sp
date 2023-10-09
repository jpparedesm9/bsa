/************************************************************************/
/*   Archivo:              sp_xml_grupos.sp                             */
/*   Stored procedure:     sp_xml_grupos                                */
/*   Base de datos:        cobis                                        */
/*   Producto:             Móvil                                        */
/*   Disenado por:         PXSG                                         */
/*   Fecha de escritura:   02/08/2017                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera informacion requerida para mostrar en reporte de Solicitud  */
/*   Individual Complementaria                                          */
/*                              CAMBIOS                                 */
/*      FECHA          AUTOR            CAMBIO                          */
/*      01/08/2017     PXSG             Emision Inicial                 */
/*      15/03/2019     SRO              Corrección Esquema secuenciales */
/*                                      en si_sincroniza                */
/*      30/06/2021     SRO              Error #161777                   */
/*      13/06/2023     ACH              209581-Ajustes nueva prospecciOn*/
/************************************************************************/

use cobis
GO

IF EXISTS (select * from sys.objects where name = 'sp_xml_grupos' and [type] = 'P')
  drop proc sp_xml_grupos
go

CREATE proc sp_xml_grupos (
    @i_operacion         char(1) = 'E', -- T = todos // P = parcial, actualizar segun fecha // E = especifico
    @i_fecha_proceso     datetime = null,
    @i_grupo             INT = null,
    @s_user              varchar(20),
    @i_accion            varchar(255) = 'INGRESAR',
    @i_observacion       varchar(255) = 'GRUPO',
    @i_oficial           int          = null
)
as
declare
@w_secuencial          INT,
@w_return              int,
@w_str                 nVARCHAR(max),
@w_str1                nVARCHAR(max),
@w_str2                nVARCHAR(max),
@w_cod_entidad         varchar(10),
@w_codigo              INT,
@w_fecha_proceso       DATETIME,
@w_des_entidad         varchar(64),
@w_error               INT,
@w_parametro_meses_v   INT,
@w_sp_name             varchar(32),
@w_msg                 varchar(100),
@w_num_reg             int,
@w_oficial             int,
@w_fecha_actualizacion datetime,
@w_cliente             INT,
@w_validated           INT,
@w_validated_str           varchar(5)


SET ROWCOUNT 0

create table #tmp_grupo (grupo  int, oficial int)  -- tabla temporal para los grupos a procesar

--Fecha de Proceso
if @i_fecha_proceso is null
    select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
    select @w_fecha_proceso = @i_fecha_proceso

select @w_cod_entidad = 2    --Datos de la Entidad -- GRUPPO

select @w_des_entidad = valor
from cobis..cl_catalogo
where tabla = ( select codigo  from cobis..cl_tabla
                where tabla = 'si_sincroniza') and codigo = @w_cod_entidad

--Obtiene los meses vigentes de información
select @w_parametro_meses_v = pa_int
  from cobis..cl_parametro
 where pa_producto = 'CLI'
   and pa_nemonico = 'MV'
   and pa_parametro = 'MESES VIGENTES INFORMACION'
if @@rowcount = 0
begin
    select @w_error = 71412 -- 'No existe el parametro especificado - moneda local
    select @w_msg = 'NO EXISTE MESES VIGENCIA INFORMACION'
    goto ERROR2
end

select @w_fecha_actualizacion = dateadd(m, -1*@w_parametro_meses_v, @w_fecha_proceso)

if @i_operacion = 'T' -- sincronizar todos los grupos
begin
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo where gr_estado = 'V'
end
if @i_operacion = 'P' --- sincronizar parcialmente, solo los desactuailzados
begin
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo where gr_estado = 'V' and gr_fecha_modificacion < @w_fecha_actualizacion
end
if @i_operacion = 'E' -- sincronizar un grupo especifico
begin
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo where gr_estado = 'V' and gr_grupo = @i_grupo
end
if @i_operacion = 'O' -- sincronizar todos los grupos de un oficial
begin
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo where gr_estado = 'V' and gr_oficial = @i_oficial
end
if @i_operacion = 'F' -- sincronizar por fecha
begin
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo 
	where gr_estado = 'V' 
	and gr_oficial = @i_oficial
        and gr_fecha_modificacion >= @w_fecha_actualizacion 

    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo, cobis..cl_cliente_grupo 
    where gr_grupo = cg_grupo
    and gr_oficial = @i_oficial
    and cg_fecha_desasociacion >= @w_fecha_actualizacion
	and not exists(select 1 from #tmp_grupo where grupo =  gr_grupo)
	
    insert into #tmp_grupo
    select gr_grupo, gr_oficial from cobis..cl_grupo, cobis..cl_cliente_grupo 
    where gr_grupo = cg_grupo
    and gr_oficial = @i_oficial	
    and cg_fecha_reg >= @w_fecha_actualizacion
	and not exists(select 1 from #tmp_grupo where grupo =  gr_grupo)
	
end
-- saco los oficiales a sincronizar
select distinct oficial as oficial into #tmp_grupo_oficial
from #tmp_grupo

--validar el numero de registros



select @w_oficial = 0
--///////////////////////////////////////////////////////////////
while 1=1 -- procesar por oficial
begin
    select top 1
        @w_oficial = oficial
    from #tmp_grupo_oficial
    where oficial > @w_oficial
    order by oficial
    if @@rowcount = 0 break

    select @s_user = fu_login
    from cobis..cc_oficial   ,    cobis..cl_funcionario
    where oc_oficial = @w_oficial
    and oc_funcionario = fu_funcionario

    select @i_grupo = 0
    select @w_num_reg = 0
  
   exec 
   @w_error     = cobis..sp_cseqnos
   @t_debug     = 'N',
   @t_file      = null,
   @t_from      = @w_sp_name,
   @i_tabla     = 'si_sincroniza',
   @o_siguiente = @w_codigo out

   if @w_error <> 0 begin
      goto ERROR2
   end
   
   if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
      -- Insert en si_sincroniza
      INSERT INTO cob_sincroniza..si_sincroniza 
      (si_secuencial,   si_cod_entidad, si_des_entidad,
       si_usuario,               si_estado,      si_fecha_ing,
       si_fecha_sin,             si_num_reg)
      VALUES                             
      (@w_codigo,      @w_cod_entidad, @w_des_entidad,
      @s_user,                  'P',            GETDATE(),
      NULL,                     @w_num_reg)

      --Secuencial
      if @@error <> 0
      begin
          select @w_error = 150000 -- ERROR EN INSERCION
          select @w_msg = 'Insertar en si_sincroniza'
          goto ERROR
      end
   end else begin
      select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
      print @w_msg
      goto ERROR	
   end
   
    --///////////////////////////////////////////////////////////////
   while 1= 1 begin-- procesar los grupo del oficial
      select top 1
            @i_grupo = grupo
        from #tmp_grupo
        where oficial = @w_oficial
        and grupo > @i_grupo
 order by grupo
 if @@rowcount = 0 break

select @w_str = '<groupSynchronizedData>'+
                    '<group>'
                    
      exec 
	  @w_validated = cobis..sp_validar_condiciones_grupo
      @i_grupo     = @i_grupo
	  
       --PRINT 'resultado validated '+ convert(varchar(10),@w_validated)+' del grupo '+convert(varchar(10),@i_grupo)
       IF @w_validated = 0
             select @w_validated_str='true'       
       ELSE
             select @w_validated_str='false'
 
        select @w_num_reg = @w_num_reg + 1
        select @w_str = @w_str +
                (select
                    gr_num_ciclo    AS cycle,
                    gr_grupo        AS groupId,
                    (select ltrim(rtrim(b.codigo))
                     from cobis..cl_catalogo b
                     where b.tabla= (select a.codigo from cobis..cl_tabla a where a.tabla= 'ad_dia_semana')
                     and codigo = gr_dia_reunion)                   AS meetingDay,
                    format(gr_hora_reunion, 'yyyy-MM-ddTHH:mm:ss.fffZ')     AS meetingHour,
                    gr_nombre       AS name,
                    gr_sucursal         AS office,
                    gr_oficial      AS officer,
                    validated = @w_validated_str
                from cobis..cl_grupo    AS [group]
                where gr_grupo = @i_grupo
                for xml auto , elements)

      if exists(select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V') begin
            select @w_cliente = 0
         
		 while 1=1 begin
                select top 1
                    @w_cliente = cg_ente
                from cobis..cl_cliente_grupo
                where cg_grupo = @i_grupo
                and cg_ente > @w_cliente
                and cg_estado = 'V'
                order by cg_ente
                if @@rowcount = 0 break

                    select @w_str1 = ''

                    select @w_str1 =
                        '<amountOfVoluntarySavings>' + isnull(convert(varchar,cg_ahorro_voluntario  ),'') + '</amountOfVoluntarySavings>' +
                        '<customerId>'               + isnull(convert(varchar,cg_ente               ),'') + '</customerId>'               +
                        '<cycle>'                    + isnull(convert(varchar,isnull(cg_nro_ciclo,0)),'') + '</cycle>'                    +
                        '<meetingPlace>'             + isnull((select ltrim(rtrim(b.codigo)) from cobis..cl_catalogo b , cobis..cl_tabla a
                                                        where b.tabla= a.codigo and a.tabla= 'cl_tdireccion'
                                                        and b.codigo = [members].cg_lugar_reunion),'')    + '</meetingPlace>' +
                        '<name>'                     + isnull((select en_nomlar from cobis..cl_ente where en_ente = [members].cg_ente),'') + '</name>' +
                        '<position>'                 + isnull((select ltrim(rtrim(b.codigo)) from cobis..cl_catalogo b , cobis..cl_tabla a
                                                        where b.tabla= a.codigo and a.tabla= 'cl_rol_grupo'
                                                        and b.codigo = [members].cg_rol), '')           + '</position>' +
                        '<rfc>'                      + isnull((select en_nit          from cobis..cl_ente where en_ente = [members].cg_ente),'') + '</rfc>' +
                        '<riskLevel>'                + isnull((select p_calif_cliente from cobis..cl_ente where en_ente = [members].cg_ente),'') + '</riskLevel>' +
                        '<checkRenapo>'              + isnull((select ltrim(rtrim(ea_consulto_renapo)) from cobis..cl_ente_aux where ea_ente = cg_ente),'') + '</checkRenapo>'
                    from cobis..cl_cliente_grupo AS [members]
                    where cg_grupo = @i_grupo
                    and cg_ente = @w_cliente
                    and cg_estado = 'V'

                    select @w_str1 = '<members>' + @w_str1

                    select @w_str2 = ''

                    select @w_str2 = (
                                    select
                                        convert(varchar,en_ente) AS  relatedPersonId,
                                        convert(varchar,(select re_relacion from cobis..cl_relacion
                                          where I.in_relacion = re_relacion) ) as typeOfRelationship,
                                        convert(varchar,(select re_descripcion from cobis..cl_relacion
                                          where I.in_relacion = re_relacion) ) as relationDescription
                                    from cobis..cl_instancia I, cobis..cl_ente  as [relations1]
                                    where in_ente_i = @w_cliente
                                    and in_ente_d = en_ente
                                    and in_ente_d   in (select cg_ente     from cobis..cl_cliente_grupo
                                                        where cg_grupo = 13 and cg_estado = 'V')
                                    and in_relacion in (select re_relacion from cobis..cl_relacion where re_relacion <> 209) -- CONYUGE
                                    for xml  raw('relations'), elements
                                    )


            select @w_str1 = @w_str1 + isnull(@w_str2,'') + '</members>'      

                select @w_str = @w_str + @w_str1
         end -- while 1 = 1


		
            select @w_cliente = 0
         if @i_operacion <>'O' and @i_operacion <> 'F' begin--cuando es O o F no debe sincronizar cada cliente --PENDIENTE: bajar en bloque para los miembros de un grupo
            while 1=1 begin-- lazo para generar xml de los miembros
                select top 1
                    @w_cliente = cg_ente
                from cobis..cl_cliente_grupo
                where cg_grupo = @i_grupo
                and cg_ente > @w_cliente
                and cg_estado = 'V'
                order by cg_ente
                if @@rowcount = 0 break
			
                  exec @w_return = cob_sincroniza..sp_sinc_arch_xml
                    @i_param1      = 'Q',
                    @i_param2      = '0',
                    @i_param3      = '1',
                    @i_param4      = @w_cliente
               if @w_return <> 0 begin
                     select @w_error = 150000 -- ERROR EN INSERCION
                     select @w_msg = 'Sincronizando CL: '+ convert(varchar, @w_cliente)
                    exec cobis..sp_cerror
                        @t_debug = 'N',
                       @t_file  = 'S',
                       @t_from  = @w_sp_name,
                       @i_num   = @w_error,
                       @i_msg   = @w_msg
               end 
            end -- while 1=1 -- lazo para generar xml de los miembros

        end
	 end
     else select @w_str = @w_str + '<members></members>'


    select @w_str = @w_str+'</group>'+'</groupSynchronizedData>'
    
     INSERT INTO cob_sincroniza..si_sincroniza_det
	 (sid_secuencial,       sid_id_entidad, sid_id_1,
      sid_id_2,             sid_xml,        sid_accion,
      sid_observacion,sid_descargado)
     VALUES
	 (@w_codigo,           @i_grupo,  0,              
	 0,                    @w_str,     @i_accion, 
	 @i_observacion,0)
	 
     if @@error <> 0
     begin
         select @w_error = 150000 -- ERROR EN INSERCION
         select @w_msg = 'Insertar en si_sincroniza_det'
         goto ERROR
     end

                                               
                     
    end -- while 1=1 -- procesar por grupo del oficial
    --///////////////////////////////////////////////////////////////
--    select @w_str = @w_str +
                    --'</group>' +
  --                  '</groupSynchronizedData>'

   UPDATE cob_sincroniza..si_sincroniza SET 
   si_num_reg         = @w_num_reg
   where si_secuencial= @w_codigo

    goto SIGUIENTE


ERROR:
    begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = 'N',
             @t_file  = 'S',
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
--        return @w_error
    end

SIGUIENTE:
end -- while 1=1 -- procesar por oficial
--///////////////////////////////////////////////////////////////
return 0

ERROR2:
PRINT 'error-------'
    begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = 'N',
             @t_file  = 'S',
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
        return @w_error
    end;
go
