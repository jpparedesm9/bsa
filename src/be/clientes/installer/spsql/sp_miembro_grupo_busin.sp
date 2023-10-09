/* ********************************************************************* */
/*      Archivo:                sp_miembro_grupo_busin.sp                */
/*      Stored procedure:       sp_miembro_grupo_busin                   */
/*      Base de datos:          cob_pac                                  */
/*      Producto: Clientes                                               */
/*      Disenado por:           Adriana Chiluisa                         */
/*      Fecha de escritura:     23-Mar-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Este programa procesa las transacciones del stored procedure     */
/*      Insercion del miebro del grupo                                   */
/*      Actualizacion del miebro del grupo                               */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*    FECHA           AUTOR                RAZON                         */
/*  23/Mar/2017     ACH           Version Inicial                        */
/*  24/Mar/2017     ACH           Se aniade Operacion U-S-Q              */
/*  19/Sep/2017     Paul Ortiz    Se corrige lugar de reunion            */
/*  20/Sep/2017     ACHP          Opcion S modo 3 recupere               */
/*                                tambien integrantes con                */
/*                                calif menor al param RVDGR             */
/*  29/JUL/2019     PXSG          Req. 118728 Renovsciones               */
/*  19/NOV/2020     ACH           ERROR.149444                           */
/*  05/May/2023     ACH           ERROR.200142, cambios op. S modo 2 y 3 */
/* ********************************************************************* */
use cob_pac
go

if exists (select * from sysobjects where name = 'sp_miembro_grupo_busin')
   drop proc sp_miembro_grupo_busin
go
IF OBJECT_ID ('sp_miembro_grupo_busin') IS NOT NULL
    DROP PROCEDURE sp_miembro_grupo_busin
GO

CREATE proc sp_miembro_grupo_busin (
    @s_ssn                  int             = null,
    @s_sesn                 int             = null,
    @s_culture              varchar(10)     = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_operacion            char(1),                -- Opcion con que se ejecuta el programa
    @i_modo                 tinyint         = null, -- Modo de busqueda
    @i_tipo                 char(1)         = null, -- Tipo de consulta
    @i_filial               tinyint         = null, -- Codigo de la filial
    @i_oficina              smallint        = null, -- Codigo de la oficina
    @i_ente                 int             = null, -- Codigo del ente que forma parte del grupo
    @i_grupo                int             = null, -- Codigo del grupo
    @i_usuario              login           = null,
    @i_oficial              int             = null, -- Codigo del oficial
    @i_fecha_asociacion     datetime        = null, -- Fecha de asociación del grupo--i_fecha_reg
    @i_rol                  catalogo        = null, -- Rol que desempeña el miembro de grupo
    @i_estado               catalogo        = null, -- Estado del Grupo Economico
    @i_calif_interna        catalogo        = null, -- Calificacion Interna
    @i_fecha_desasociacion  datetime        = NULL, -- Fecha de desasociacion del grupo
    @i_cg_ahorro_voluntario MONEY            =NULL,  -- ahorro voluntario nuevo campo
    @i_cg_lugar_reunion     VARCHAR(10)        =NULL,   -- nuevo campo lugar de reunion
    @i_cg_cuenta_individual  VARCHAR(45)    = NULL,
    @i_tramite              int             = NULL
)
as
declare @w_siguiente            int,
        @w_return               int,
        @w_num_cl_gr            int,
        @w_contador             int,
        @w_sp_name              varchar(32),
        @w_error                int,
        @w_ente                 int,
        @w_grupo                int,
        @w_usuario              login,
        @w_oficial              int,
        @w_fecha_asociacion     datetime,
        @w_rol                  catalogo,
        @w_estado               catalogo,
        @w_calif_interna        catalogo,
        @w_fecha_desasociacion  datetime,
        @v_ente                 int,
        @v_grupo                int,
        @v_usuario              login,
        @v_oficial              int,
        @v_fecha_asociacion     datetime,
        @v_rol                  catalogo,
        @v_estado               catalogo,
        @v_calif_interna        catalogo,
        @v_fecha_desasociacion  datetime,
        @v_cg_ahorro_voluntario money,--nuevo campo ahorro voluntario
        @v_cg_lugar_reunion     VARCHAR(10),-- nuevo campo lugar de reunion
        @w_tab_id_rol           int,
        @w_tab_id_calif         int,
        @w_tab_id_estado        int,
        @w_rol_desc             descripcion,
        @w_estado_desc          descripcion,
        @w_calif_interna_desc   descripcion,
        @w_cliente_nomlar       varchar(254),
        @w_cg_ahorro_voluntario money,--nuevo campo ahorro voluntario
        @w_cg_lugar_reunion     varchar(10),-- nuevo campo lugar de reunion
        @w_desc_direccion       varchar(254),
        @w_gr_tiene_ctain       CHAR(1),
        @w_integrantes          INT, --nuevo campo para validar numero de integrantes PXSG
        @cod_cli_presidente     INT,--codigo de presidente
        @w_param_max_inte       INT, --numero maximo de integrantes
        @w_calle                as varchar(125),--para generar la dirección del grupo
        @w_casa                 as varchar (10),--para generar la dirección del grupo
        @w_descripcion          as varchar(125),--para generar la dirección del grupo
        @w_colonia              as varchar(125),--para generar la dirección del grupo
        @w_municipio            as varchar(125),--para generar la dirección del grupo
        @w_estadoReu            as varchar(125),--para generar la dirección del grupo
        @w_num_meses_MESVCC     smallint,
        @w_fecha_proceso        datetime,
        @w_fecha_ini_param      datetime,
        @w_param_val_resp_min   int,
		@w_actualiza_movil      varchar(1),		
        @w_parm_ofi_movil       smallint,
	    @w_fecha_desasociacion_aux  datetime,
	     @w_minimo_integrantes   int,
	     @w_dias_op              int,
        @w_fecha_fin_op         datetime,
        @w_param_eliminacion    int  
-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_miembro_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name = 'sp_miembro_grupo_busin'

if @t_trn != 810
begin
    select @w_error = 151051 -- TRANSACCION NO PERMITIDA
    goto ERROR
end

select @w_minimo_integrantes =  pa_int from cobis..cl_parametro where pa_nemonico = 'MINIGR'and  pa_producto = 'CLI'
select @w_parm_ofi_movil = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OFIAPP' and pa_producto = 'CRE'
select @w_tab_id_rol = codigo from cobis..cl_tabla where tabla  = 'cl_rol_grupo'
select @w_tab_id_calif = codigo from cobis..cl_tabla where tabla  = 'cl_calif_cliente'
select @w_tab_id_estado = codigo from cobis..cl_tabla where tabla = 'cl_estado_ambito'

-- Para opción S - modo 2(Individual) y 3 (Grupal)
select  @w_fecha_proceso    = fp_fecha   from cobis..ba_fecha_proceso
select  @w_num_meses_MESVCC = pa_tinyint from cobis..cl_parametro where  pa_nemonico = 'MESVCC'
select  @w_fecha_ini_param  = dateadd(mm, -1*@w_num_meses_MESVCC, @w_fecha_proceso)
--Parametro para eliminacion de Integrantes
select @w_param_eliminacion = pa_int 
from cobis..cl_parametro
where  pa_nemonico='EICRVI'
and    pa_producto='CRE'

--Validaciones
if @i_operacion in ('I','D')
begin  --Inicio @i_operacion ('I','D')
   if exists (select (1) from cob_cartera..ca_operacion, cob_cartera..ca_estado, cob_credito..cr_tramite_grupal
               where op_estado = es_codigo
               and es_procesa = 'S'
               and op_cliente = @i_ente
               and op_operacion = tg_operacion
               and tg_grupo  <> @i_grupo) and @i_operacion = 'I'
   begin
      select @w_error = 149053 --TIENE OPERACIONES PENDIENTES CON OTRO GRUPO
      goto ERROR
   end
   
   select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso
   
   
   if exists (select (1) from cob_cartera..ca_operacion, cob_cartera..ca_estado, cob_credito..cr_tramite_grupal
               where op_estado = es_codigo
               and es_procesa = 'S'
               and op_cliente = @i_ente
               and op_operacion = tg_operacion
               and tg_grupo  = @i_grupo) and @i_operacion = 'D'
   begin
   	select @w_dias_op=DATEDIFF(dd, @w_fecha_proceso, op_fecha_fin)  from cob_cartera..ca_operacion, cob_cartera..ca_estado, cob_credito..cr_tramite_grupal
               where op_estado = es_codigo
               and es_procesa = 'S'
               and op_cliente =@i_ente
               and op_operacion = tg_operacion
               and tg_grupo  = @i_grupo
    
		print '@w_fecha_proceso--> '+ convert(varchar(50),@w_fecha_proceso) 
   	print '@w_dias_op--> '+       convert(varchar(50),@w_dias_op)            
    	if(@w_dias_op>@w_param_eliminacion)
    	begin
      select @w_error = 149053 --TIENE OPERACIONES PENDIENTES EN ESTE GRUPO
      goto ERROR
   end
   end
    -- INICIO DE DESASOCIACION
    if @i_tramite is null
    begin
        --Valida que no exista una solicitud en curso
        if exists (select 1 from cob_workflow..wf_inst_proceso
                    where io_campo_1 = @i_grupo
                      and io_estado not in ('TER', 'CAN', 'SUS', 'ELI')
					  and io_campo_7 = 'S')
        begin		    
		    print 'sp_mgp 1 Parametro ofi movil:' + convert(varchar(30),isnull(@w_parm_ofi_movil,0)) + '-oficina sesion:'+ convert(varchar(30),isnull(@s_ofi,0))
		    if ( @s_ofi = @w_parm_ofi_movil)
		    begin
                exec cob_pac..sp_grupo_busin
                @i_operacion       = 'M',
                @i_grupo           = @i_grupo,
				@t_trn             = 800,
                @o_actualiza_movil = @w_actualiza_movil OUTPUT
				print 'sp_mb @w_actualiza_movil--' + @w_actualiza_movil + '--'
				if(@w_actualiza_movil = 'N')
				begin
			        select @w_error = 103156  --Error el grupo tiene un trámite en ejecución. 
			        goto ERROR				
				end
		    end
			/*else
			begin
			    print 'sp_mb -- Oficina Diferente a la de la movil'
			    select @w_error = 103156  --Error el grupo tiene un trámite en ejecución. 
			    goto ERROR	
			end*/
        end
    end
    --Se Elimina por caso 118728 Renovaciones.
	/*
   if exists (select (1)
   from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo and cg_rol in ('P', 'T', 'S')) --Presidente, Tesorero y Secretario
   begin
      select @w_error = 149054 --MIEMBRO A MODIFICAR ES PARTE DE UNA DIRECTIVA EXISTENTE MODIFIQUE LOS MIEMBROS
      goto ERROR
   end
   */
end   --fin @i_operacion ('I','D')

if @i_rol in ('P', 'T', 'S') and @i_operacion in ('I', 'U')
begin
  if exists (select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_rol = @i_rol and @i_rol = 'P' and @i_ente <> cg_ente and cg_estado = 'V') --Presidente
  begin
     select @w_error = 208914 --PRESIDENTE YA EXISTE EN EL GRUPO
     goto ERROR
  end

  if exists (select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_rol = @i_rol and @i_rol = 'T' and @i_ente <> cg_ente and cg_estado = 'V') --Tesorero
  begin
     select @w_error = 208915 --TESORERO YA EXISTE EN EL GRUPO
     goto ERROR
  end
  
  if exists (select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_rol = @i_rol and @i_rol = 'S' and @i_ente <> cg_ente and cg_estado = 'V') --Secretario
  begin
     select @w_error = 208935 --SECRETARIO YA EXISTE EN EL GRUPO
     goto ERROR
  end
end

if @i_rol in ('P', 'T') and @i_operacion in ('D')
begin
 if exists (select (1)
   from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_rol = 'P') --Presidente
   begin
      select @w_error = 208912 --DEBE DE EXISTIR UN SOLO PRESIDENTE
      goto ERROR
   end

   if exists (select (1)
   from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_rol = 'T') --Presidente
   begin
      select @w_error = 208913 --DEBE DE EXISTIR UN SOLO TESORERO
      goto ERROR
   end
end

-- Insert --
if @i_operacion = 'I'
begin
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
        select @w_error = 151029 -- No existe el grupo --
        goto ERROR
     end

    -- Verificacion que el ente existe
     if not exists (select 1 from cobis..cl_ente where en_ente = @i_ente)
     begin
        select @w_error = 208907 -- NO EXISTE EL MIEMBRO
        goto ERROR
     end

    --Verifica si existe el grupo y el ente
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo and cg_fecha_desasociacion is null)
    begin
        select @w_error = 208903 -- YA EXISTE EL MIEMBRO EN EL GRUPO
        goto ERROR
    end

    --Verifica si existe el miembro en otros grupos
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo != @i_grupo and cg_fecha_desasociacion is null)
    BEGIN
        select @w_error = 208908 -- YA EXISTE EL MIEMBRO EN OTRO GRUPO --
        goto ERROR
    END
     --nuevas validaciones maximo 40--
    select @w_param_max_inte =pa_int from cobis..cl_parametro where pa_nemonico='MAXIGR' and pa_producto = 'CLI'
    select @w_integrantes  = count(cg_ente) from cobis..cl_cliente_grupo
    where cg_grupo = @i_grupo
    and cg_estado = 'V'
    if @w_integrantes  >= @w_param_max_inte
     BEGIN
       select @w_error = 208916 -- validación número de integrantes
        goto ERROR
     End

    --valida que solo un integrante tenga cg_lugar_reunion D o N--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_fecha_desasociacion is NULL and cg_lugar_reunion IS NOT NULL and @i_cg_lugar_reunion IS NOT NULL)
    BEGIN

        select @w_error = 208909 -- YA EXISTE UN MIEMBRO CON LUGAR DE REUNION --
        goto ERROR
    END

	--Valida que el integrante sea un Cliente
    IF ((select ea_estado from cobis..cl_ente_aux where ea_ente = @i_ente) <> 'A')
	BEGIN
		select @w_error = 103143 -- No se puede insertar porque el integrante no es in Cliente
        goto ERROR
	end
	
	--Valida la fecha 
		if datediff(dd,@w_fecha_proceso,@i_fecha_asociacion) >0
	begin
         SET @i_fecha_asociacion=@w_fecha_proceso
	end
    --actaliza  la fecha y el estado cuando la fecha es diferente de null--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo and cg_fecha_desasociacion IS NOT null)
    begin
        update cobis..cl_cliente_grupo
        set cg_estado = 'V', cg_fecha_desasociacion=NULL,cg_ahorro_voluntario=@i_cg_ahorro_voluntario ,cg_lugar_reunion=@i_cg_lugar_reunion,
		    cg_rol    = @i_rol
    where  cg_ente = @i_ente and cg_grupo = @i_grupo and cg_fecha_desasociacion IS not null
    END
    else
    BEGIN

        -- actualiza el grupo la fecha y el estado cuando la fecha es diferente de null
        --if exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo != @i_grupo and cg_fecha_desasociacion IS not null)
        --BEGIN
        -- update cobis..cl_cliente_grupo
        -- set cg_estado ='V', cg_fecha_desasociacion=NULL, cg_grupo=@i_grupo,cg_ahorro_voluntario=@i_cg_ahorro_voluntario ,cg_lugar_reunion=@i_cg_lugar_reunion
        --where  cg_ente = @i_ente and cg_fecha_desasociacion IS not null
        --END
		select @i_oficial = gr_oficial from cobis..cl_grupo where gr_grupo = @i_grupo

        insert into cobis..cl_cliente_grupo (cg_ente,          cg_grupo,         cg_usuario,    --1
                                             cg_terminal,      cg_oficial,       cg_fecha_reg,  --2
                                             cg_rol,           cg_estado,        cg_calif_interna, --3
                                             cg_fecha_desasociacion, cg_ahorro_voluntario, cg_lugar_reunion--4                           --4
                                            )
        values                              (@i_ente,          @i_grupo,         @s_user,         --1
                                             @s_term,          @i_oficial,       @i_fecha_asociacion,--2
                                             @i_rol,           @i_estado,        @i_calif_interna,--3
                                             @i_fecha_desasociacion, @i_cg_ahorro_voluntario, @i_cg_lugar_reunion --4  --4
                                            )

        -- si no se puede insertar, error --
        if @@error != 0
        begin
            select @w_error = 208902 -- ERROR EN INGRESO DEL MIEMBRO DE GRUPO
            goto ERROR
        end

        -- Transaccion servicio - cl_cliente_grupo --
        insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                             srv,        lsrv,             ente,   --2
                                             grupo,      usuario,          terminal,--3
                                             oficial,    fecha_reg,        rol,     --4
                                             estado,     calif_interna,    fecha_desasociacion--5
                                             )
        values                              (@s_ssn,      810,              'N',       --1
                                             @s_srv,      @s_lsrv,          @i_ente,   --2
                                             @i_grupo,    @s_user,          @s_term,   --3
                                             @i_oficial,  @i_fecha_asociacion, @i_rol, --4
                                             @i_estado,   @i_calif_interna, @i_fecha_desasociacion--5
                                             )
        -- Si no se puede insertar transaccion de servicio, error --
        if @@error != 0
        begin
            select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
            goto ERROR
        end
    end -- caso contrario del update

	-- Para eliminar desde el movil
	print 'sp_mgp 2 Parametro ofi movil:' + convert(varchar(30),isnull(@w_parm_ofi_movil,0)) + '-oficina sesion:'+ convert(varchar(30),isnull(@s_ofi,0))
    if ( @s_ofi = @w_parm_ofi_movil)
    begin
        exec cob_pac..sp_grupo_busin
        @i_operacion       = 'M',
        @i_grupo           = @i_grupo,
		@t_trn             = 800,		
        @o_actualiza_movil = @w_actualiza_movil OUTPUT
        
        if(@w_actualiza_movil = 'S')
        begin
            select @i_tramite = io_campo_3 from cob_workflow..wf_inst_proceso
        	where io_campo_1 = @i_grupo
        	and   io_estado  = 'EJE'		
               and io_campo_7 = 'S'			
        end
	end -- Fin para eliminar desde el movil
	
	 select @i_tramite = io_campo_3 from cob_workflow..wf_inst_proceso
        	where io_campo_1 = @i_grupo
        	and   io_estado  = 'EJE'		
         and io_campo_7 = 'S'
	
    --LGU-ini 22/ago/2017 AGREGAR CLIENTE A LA SOLICITUD
    if @i_tramite is not null
    begin			
        exec @w_return = cob_credito..sp_grupal_monto
        @s_ssn     = @s_ssn ,
        @s_rol     = @s_rol ,
        @s_ofi     = @s_ofi ,
        @s_sesn    = @s_sesn ,
        @s_user    = @s_user ,
        @s_term    = @s_term ,
        @s_date    = @s_date ,
        @s_srv     = @s_srv ,
        @s_lsrv    = @s_lsrv ,
        @i_operacion = 'I',
        @i_tramite   = @i_tramite,
        @i_ente      = @i_ente

        if @w_return <> 0
        begin
            select @w_error = 21008 --
            goto ERROR
        end
    end
    --LGU-fin AGREGAR CLIENTE A LA SOLICITUD

    select @w_gr_tiene_ctain = gr_tiene_ctain from cobis..cl_grupo where gr_grupo=@i_grupo
    IF ( @w_gr_tiene_ctain ='S')
    BEGIN
        UPDATE cobis..cl_ente_aux   SET ea_cta_banco=@i_cg_cuenta_individual where ea_ente=@i_ente
    END

    --actualizar lugar de reunion cuando existe un lugar de reunion
   IF @i_cg_lugar_reunion IS NOT NULL
    BEGIN
		select 	@w_calle        = di_calle,
		        --@w_descripcion	= di_descripcion,
       			--@w_casa         = di_casa,
       			@w_colonia 		= (select valor from cobis..cl_catalogo where codigo = di_parroquia
                                    and tabla = (select codigo from cobis..cl_tabla 
                                    where tabla = 'cl_parroquia')),
       			@w_municipio    = (select valor from cobis..cl_catalogo where codigo = di_ciudad
                                    and tabla = (select codigo from cobis..cl_tabla 
                    where tabla = 'cl_ciudad')),
       			@w_estadoReu    = (select valor from cobis..cl_catalogo where codigo = convert(varchar(10),di_provincia)
                                    and tabla = (select codigo from cobis..cl_tabla 
                                    where tabla = 'cl_provincia'))									
				from cobis..cl_direccion where di_ente=@i_ente
         	   	and di_tipo = @i_cg_lugar_reunion
		IF @@ROWCOUNT =0
		begin
            select @w_error = 208911 -- ERROR: EL CLIENTE NO TIENE LA DIRECCIÓN
            goto ERROR
        END

        ELSE
		BEGIN
			
			SET @w_desc_direccion = ''

   			IF(@w_calle IS NOT NULL)
  				SET @w_desc_direccion = ' CALLE '+@w_calle+', '

			IF(@w_colonia IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_colonia+', '

			IF(@w_municipio IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_municipio + ', '
            
            IF(@w_estadoReu IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_estadoReu
            


            UPDATE cobis..cl_grupo
            	SET gr_dir_reunion = @w_desc_direccion
                where gr_grupo = @i_grupo

    	END
	 END

    -- Actualizacion del grupo en el cliente
    update cobis..cl_ente set en_grupo = @i_grupo
    where  en_ente = @i_ente

--actualización en la cl_grupo cuando un miembro del grupo es presidente
   IF EXISTS (select 1 from cobis..cl_cliente_grupo where cg_grupo=@i_grupo and cg_rol='P')
   BEGIN
   select @cod_cli_presidente=cg_ente from cobis..cl_cliente_grupo where cg_grupo=@i_grupo and cg_rol='P'
   UPDATE cobis..cl_grupo SET gr_representante=@cod_cli_presidente where gr_grupo=@i_grupo

   END


end -- Fin Operacion I

if @i_operacion = 'U'
begin
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
         select @w_error = 151029 -- NO EXISTE GRUPO
         goto ERROR
     end

    --Verifica si existe el grupo y el ente a modificar
    if not exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo)
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO
         goto ERROR
    END

    -- Prestamo en tramite
    if exists ( select 1 from cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
                where tg_grupo = @i_grupo
                and tg_cliente = @i_ente
                and tg_referencia_grupal = op_banco
                and tg_monto   > 0
                and op_estado  = 0
                ) and @i_estado <> 'V'
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO
         goto ERROR
    END
    -- Prestamo vigente
    if exists ( select 1 from cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
                where tg_grupo = @i_grupo
                and tg_cliente = @i_ente
                and convert(varchar,tg_operacion) <> tg_prestamo
                and tg_operacion = op_operacion
                and op_estado  <>  3
                ) and @i_estado <> 'V'
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO
         goto ERROR
    END

     --valida que solo un integrante tenga  cg_lugar_reunion D o N--
    if exists ( select 1 from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_fecha_desasociacion is NULL and cg_lugar_reunion IS NOT NULL and @i_cg_lugar_reunion IS NOT NULL
    and cg_ente!=@i_ente)
    BEGIN

        select @w_error = 208909 -- YA EXISTE UN MIEMBRO CON LUGAR DE REUNION
        goto ERROR
    END

	--Valida la fecha 
	if datediff(dd,@w_fecha_proceso,@i_fecha_asociacion) >0
	begin
	    SET @i_fecha_asociacion=@w_fecha_proceso
	end	
    --Consulta de Datos
    select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_usuario             = cg_usuario,
           @w_oficial             = cg_oficial,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = cg_calif_interna,
           @w_fecha_desasociacion = cg_fecha_desasociacion,
           @w_cg_ahorro_voluntario = cg_ahorro_voluntario,
           @w_cg_lugar_reunion       = cg_lugar_reunion

    from  cobis..cl_cliente_grupo
    where cg_ente = @i_ente and cg_grupo = @i_grupo

    -- INI Guardar los datos anteriores que han cambiado --
    select @v_ente                 = @w_ente,
           @v_grupo                = @w_grupo,
           @v_usuario              = @w_usuario,
           @v_oficial              = @w_oficial,
           @v_fecha_asociacion     = @w_fecha_asociacion,
           @v_rol                  = @w_rol,
           @v_estado               = @w_estado,
           @v_calif_interna        = @w_calif_interna,
           @v_fecha_desasociacion  = @w_fecha_desasociacion,
           @v_cg_ahorro_voluntario = @w_cg_ahorro_voluntario,
           @v_cg_lugar_reunion     = @w_cg_lugar_reunion

    if @w_ente = @i_ente
        select @w_ente = null, @v_ente = null
    else
        select @w_ente = @i_ente

    if @w_grupo = @i_grupo
        select @w_grupo = null, @v_grupo = null
    else
        select @w_grupo = @i_grupo

    if @w_usuario = @i_usuario
        select @w_usuario = null, @v_usuario = null
    else
        select @w_usuario = @i_usuario

    if @w_oficial = @i_oficial
        select @w_oficial = null, @v_oficial = null
    else
        select @w_oficial = @i_oficial

    if @w_fecha_asociacion = @i_fecha_asociacion
        select @w_fecha_asociacion = null, @v_fecha_asociacion = null
    else
        select @w_fecha_asociacion = @i_fecha_asociacion

    if @w_rol = @i_rol
        select @w_rol = null, @v_rol = null
    else
        select @w_rol = @i_rol

    if @w_estado = @i_estado
        select @w_estado = null, @v_estado = null
    else
        select @w_estado = @i_estado

    if @w_calif_interna = @i_calif_interna
        select @w_calif_interna = null, @v_calif_interna = null
    else
        select @w_calif_interna = @i_calif_interna

    if @w_fecha_desasociacion = @i_fecha_desasociacion
        select @w_fecha_desasociacion = null, @v_fecha_desasociacion = null
    else
        select @w_fecha_desasociacion = @i_fecha_desasociacion

    -- Transaccion servicio - cl_cliente_grupo --
    insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                         srv,        lsrv,             ente,   --2
                                         grupo,      usuario,          terminal,--3
                                         oficial,    fecha_reg,        rol,     --4
                                         estado,     calif_interna,    fecha_desasociacion--5
                                         )
    values                              (@s_ssn,      810,              'P',       --1
                                         @s_srv,      @s_lsrv,          @i_ente,   --2
                                         @i_grupo,    @s_user,          @s_term,   --3
                                         @v_oficial,  @v_fecha_asociacion, @v_rol, --4
                                         @v_estado,   @v_calif_interna, @v_fecha_desasociacion--5
                                         )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR
    end
      --actualizar lugar de reunion cuando existe un lugar de reunion
       IF @i_cg_lugar_reunion IS NOT NULL
    BEGIN
		select 	@w_calle        = di_calle,
		        --@w_descripcion	= di_descripcion,
       			--@w_casa         = di_casa,
       			@w_colonia 		= (select valor from cobis..cl_catalogo where codigo = di_parroquia
                                    and tabla = (select codigo from cobis..cl_tabla 
                      where tabla = 'cl_parroquia')),
       			@w_municipio    = (select valor from cobis..cl_catalogo where codigo = di_ciudad
                                    and tabla = (select codigo from cobis..cl_tabla 
                                    where tabla = 'cl_ciudad')),
       			@w_estadoReu    = (select valor from cobis..cl_catalogo where codigo = convert(varchar(10),di_provincia)
                                    and tabla = (select codigo from cobis..cl_tabla 
                                    where tabla = 'cl_provincia'))
				from cobis..cl_direccion where di_ente=@i_ente
         	   	and di_tipo = @i_cg_lugar_reunion
		IF @@ROWCOUNT =0
		begin
            select @w_error = 208911 -- ERROR: EL CLIENTE NO TIENE LA DIRECCIÓN
            goto ERROR
        END

        ELSE
		BEGIN
            
            SET @w_desc_direccion = ''

   			IF(@w_calle IS NOT NULL)
  				SET @w_desc_direccion = ' CALLE '+@w_calle+', '

			IF(@w_colonia IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_colonia+', '

			IF(@w_municipio IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_municipio + ', '
            
            IF(@w_estadoReu IS NOT NULL)
  				SET @w_desc_direccion = @w_desc_direccion + @w_estadoReu
            
            UPDATE cobis..cl_grupo
            	SET gr_dir_reunion = @w_desc_direccion
                where gr_grupo = @i_grupo

    	END
	 END
    -- Actualizacion de registros
	select   @w_fecha_desasociacion_aux = cg_fecha_desasociacion 
	from     cobis..cl_cliente_grupo
	where    cg_ente  = @i_ente 
	and      cg_grupo = @i_grupo
	
	--Prueba: Si desde la movil, se va a dar check despues de eliminar 
	--un integrante y este muestra un mensaje de error
	if(@w_fecha_desasociacion_aux is not null)
	begin
	    select @i_estado = 'C'
	end
	
    update cobis..cl_cliente_grupo
    set    cg_rol                  = @i_rol,
           cg_estado               = @i_estado,
           cg_calif_interna        = @i_calif_interna,
           cg_ahorro_voluntario    = @i_cg_ahorro_voluntario,
           cg_lugar_reunion        = @i_cg_lugar_reunion,
		   cg_fecha_reg            = @i_fecha_asociacion
    where  cg_ente = @i_ente and cg_grupo = @i_grupo

    -- Si no se puede modificar, error --
    if @@rowcount = 0
    begin
        select @w_error = 208906  --ERROR EN LA ACTUALIZACIÓN DEL MIEMBRO
        goto ERROR
    end

    select @w_gr_tiene_ctain = gr_tiene_ctain from cobis..cl_grupo where gr_grupo=@i_grupo
     --PRINT ('-----------------------cuenta individual////@w_gr_tiene_ctain:')+ CONVERT(VARCHAR(30),@w_gr_tiene_ctain)
     IF ( @w_gr_tiene_ctain ='S')
    BEGIN
    UPDATE cobis..cl_ente_aux   SET ea_cta_banco=@i_cg_cuenta_individual where ea_ente=@i_ente
    END

    -- Transaccion servicio - cl_cliente_grupo --
    insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                         srv,        lsrv,             ente,   --2
                                         grupo,      usuario,          terminal,--3
                                         oficial,    fecha_reg,        rol,     --4
                                         estado,     calif_interna,    fecha_desasociacion--5
                                         )
    values                              (@s_ssn,      810,              'A',       --1
                                         @s_srv,      @s_lsrv,          @i_ente,   --2
                                         @i_grupo,    @s_user,          @s_term,   --3
                                         @w_oficial,  @w_fecha_asociacion, @w_rol, --4
                                         @w_estado,   @w_calif_interna, @w_fecha_desasociacion--5
                                         )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        return 1
    end

    --actualización en la cl_grupo cuando un miembro del grupo es presidente
   IF EXISTS (select 1 from cobis..cl_cliente_grupo where cg_grupo=@i_grupo and cg_rol='P')
   BEGIN
   select @cod_cli_presidente=cg_ente from cobis..cl_cliente_grupo where cg_grupo=@i_grupo and cg_rol='P'
   UPDATE cobis..cl_grupo SET gr_representante=@cod_cli_presidente where gr_grupo=@i_grupo
   END
end -- Fin Operacion U

if @i_operacion = 'D' -- Desasignar
begin		
     -- verificar que exista el grupo --
     if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
     begin
         select @w_error = 151029 -- NO EXISTE GRUPO
         goto ERROR
     end

    --Verifica si existe el grupo y el ente a modificar
    if not exists ( select 1 from cobis..cl_cliente_grupo where cg_ente = @i_ente and cg_grupo = @i_grupo)
    begin
         select @w_error = 208904 -- NO EXISTE EL MIEMBRO EN EL GRUPO A MODIFICAR
         goto ERROR
    end

   if exists (select (1) from cobis..cl_grupo where gr_grupo = @i_grupo and (gr_titular1 = @i_ente or gr_titular2 = @i_ente))
   begin
      select @w_error =149055 --ES TITULAR DE LA CUENTA GRUPAL
      goto ERROR
   end

    --Consulta de Datos
    select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_usuario             = cg_usuario,
           --@w_terminal            = cg_terminal,
           @w_oficial             = cg_oficial,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = cg_calif_interna,
           @w_fecha_desasociacion = cg_fecha_desasociacion
           --@w_tipo_relacion       = cg_tipo_relacion
    from  cobis..cl_cliente_grupo
    where cg_ente = @i_ente and cg_grupo = @i_grupo
	
	-- INICIO DE DESASOCIACION
    begin tran
	    -- desasignar en ente del grupo --
        update cobis..cl_cliente_grupo
        set    cg_fecha_desasociacion = @s_date,
               cg_estado              = @i_estado
        from   cobis..cl_cliente_grupo
        where  cg_ente = @i_ente and cg_grupo = @i_grupo
        -- si no se puede desasignar, error --
        if @@rowcount != 1
        begin
             select @w_error = 101109 -- ERROR EN DESASIGNACION DE GRUPO
             goto ERROR
        end

        update cobis..cl_ente
        set    en_grupo = null
        where  en_ente   = @i_ente
        and    en_grupo  = @i_grupo

	    -- Para eliminar desde el movil
		print 'sp_mgp 3 Parametro ofi movil:' + convert(varchar(30),isnull(@w_parm_ofi_movil,0)) + '-oficina sesion:'+ convert(varchar(30),isnull(@s_ofi,0))
        if ( @s_ofi = @w_parm_ofi_movil)
        begin 
            exec cob_pac..sp_grupo_busin
            @i_operacion       = 'M',
            @i_grupo           = @i_grupo,
            @t_trn             = 800,			
            @o_actualiza_movil = @w_actualiza_movil OUTPUT
            
            if(@w_actualiza_movil = 'S')
            begin
                select @i_tramite = io_campo_3 from cob_workflow..wf_inst_proceso
            	where io_campo_1 = @i_grupo
            	and   io_estado  = 'EJE'
				   and io_campo_7 = 'S'
			
            end
        end -- Fin para eliminar desde el movil	
        select @i_tramite = io_campo_3 from cob_workflow..wf_inst_proceso
        where io_campo_1 = @i_grupo
        and   io_estado  = 'EJE'
		  and io_campo_7 = 'S'
	    --LGU-ini 22/ago/2017 eliminar cliente de la solcitud
        if @i_tramite is not null
        begin
		    
		    if ((select count(1) 
		        from cobis..cl_cliente_grupo 
		        where cg_grupo  = @i_grupo and cg_estado = 'V') < @w_minimo_integrantes)
		        and exists(select 1 from cob_credito..cr_tramite where tr_tramite =  @i_tramite and tr_promocion = 'S')		        
		    begin
		        select @w_error = 208946 -- ERROR MINIMO DE INTEGRANTES
                goto ERROR
		    end  
		    
		    exec @w_return = cob_credito..sp_grupal_monto
                @s_ssn     = @s_ssn ,
                @s_rol     = @s_rol ,
                @s_ofi     = @s_ofi ,
                @s_sesn    = @s_sesn ,
                @s_user    = @s_user ,
                @s_term    = @s_term ,
                @s_date    = @s_date ,
                @s_srv     = @s_srv ,
                @s_lsrv    = @s_lsrv ,
                @i_operacion = 'D',
                @i_tramite   = @i_tramite,
                @i_ente      = @i_ente,
                @i_mant_grp  ='S'
                
                if @w_return <> 0
                begin
                    select @w_error = 21008 --
                    goto ERROR
                end
        --LGU-fin eliminar cliente de la solcitud
			if exists (select 1 from   cob_cartera..ca_garantia_liquida where gl_tramite = @i_tramite)
			begin
	            /*Se agrega el codigo para la devolucion de la garantia liquida*/
	            exec @w_return     = cob_custodia..sp_contabiliza_garantia
	            @s_date            = @s_date,
	            @s_user            = @s_user,
	            @s_ofi             = @s_ofi ,
	            @s_term            = @s_term,
	            @i_operacion       = 'PD',
	            @i_tramite         = @i_tramite,
	            @i_ente            = @i_ente,
	            @i_grupo           = @i_grupo
	            if @@error != 0
	            begin
	              select @w_error = 1901020 -- ERROR EN LA ACTUALIZACION DEL REGISTRO
	              goto ERROR
	            end
			end
		
        end

        -- Transaccion servicio - ts_cliente_grupo --
        insert into cobis..ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                                             srv,        lsrv,             ente,   --2
                                             grupo,      usuario,          terminal,--3
                                             oficial,    fecha_reg,        rol,     --4
                                             estado,     calif_interna,    fecha_desasociacion--5
                                             )
        values                              (@s_ssn,      810,              'B',       --1
                                             @s_srv,      @s_lsrv,          @i_ente,   --2
                                             @i_grupo,    @s_user,          @s_term,   --3
                                             @w_oficial,  @s_date,          @w_rol, --4
                                             @w_estado,   @w_calif_interna, @w_fecha_desasociacion--5
                                             )
        -- Si no se puede insertar transaccion de servicio, error --
        if @@error != 0
        begin
            select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
            goto ERROR
        end
    commit tran
end -- FIN OPCION D

if @i_operacion = 'S'
begin

    --set rowcount 20
    if @i_modo = 0
    begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''),
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'		       = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											      and dc_cliente = en_ente),
			      'NivelRiesgo'         = ea_nivel_riesgo,
			      'Renapo'              = ltrim(rtrim(ea_consulto_renapo))
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cobis..cl_ente_aux EA
        where cg_ente  = en_ente
        and   en_ente = ea_ente
        and   cg_grupo = @i_grupo
        and   cg_fecha_desasociacion is null
        order by cg_ente
   end

   if @i_modo = 1
   begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = en_nomlar,
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											and dc_cliente = en_ente) 
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN
        where cg_ente  = en_ente
        and   cg_grupo = @i_grupo
        and   cg_ente  > @i_ente
        and   cg_fecha_desasociacion is null
        order by cg_ente
   end

   if @i_modo = 2
   begin
        select @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDIN' and pa_producto = 'CRE'
    
        --Ref: pantalla SOLICITUD CREDITO INDIVIDUAL SANTANDER 
        --Ente Nuevo
        select 'Ente'                = en_ente,
               'Nombre_Cliente'      = en_nomlar,
               'Resultado'           = 0	 
        from cob_credito..cr_ej_regla_aplica_cuest, cobis..cl_ente 
        where er_tramite = @i_tramite
        and er_in_etapa = 'S'
        and er_cliente = en_ente
        and er_est_en_cred = 'V'
        and en_ente not in (select vd_cliente from cob_credito..cr_verifica_datos where vd_tramite =  @i_tramite)
        
        union
        
        --Alianza Nuevo
        select 'Ente'                = en_ente,
               'Nombre_Cliente'      = en_nomlar,
               'Resultado'           = 0	 
        from cob_credito..cr_ej_regla_aplica_cuest, cob_credito..cr_tramite, cobis..cl_ente
        where er_tramite = @i_tramite
        and er_cliente = tr_alianza
        and er_tramite = tr_tramite
        and er_in_etapa = 'S'
        and tr_alianza = en_ente
        and en_ente not in (select vd_cliente from cob_credito..cr_verifica_datos where vd_tramite =  @i_tramite)

        union
        
        --Cliente registrado
        select 'Ente'                = en_ente,
               'Nombre_Cliente'      = en_nomlar,
               'Resultado'           = vd_resultado	 
        from cob_credito..cr_ej_regla_aplica_cuest, cobis..cl_ente, cob_credito..cr_verifica_datos
        where er_tramite = @i_tramite
        and er_in_etapa = 'S'
        and er_cliente = en_ente
        and er_est_en_cred = 'V'
        and en_ente = vd_cliente
        and er_tramite = vd_tramite
        and vd_resultado <= @w_param_val_resp_min 
        
        union
        
        --Alianza registrado
        select 'Ente'                = en_ente,
               'Nombre_Cliente'      = en_nomlar,
               'Resultado'           = vd_resultado	 
        from cob_credito..cr_ej_regla_aplica_cuest, cob_credito..cr_tramite, cobis..cl_ente, cob_credito..cr_verifica_datos
        where er_tramite = @i_tramite
        and er_cliente = tr_alianza
        and er_tramite = tr_tramite
        and er_in_etapa = 'S'
        and tr_alianza = en_ente
        and en_ente = vd_cliente
        and er_tramite = vd_tramite
        and vd_resultado <= @w_param_val_resp_min
          
	   --f exists (select 1 from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = @i_ente)
	   --   begin
	   --
       --	   
       --	   -- Deudor que no pertenezca a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = 0
       --       from  cobis..cl_ente, cob_credito..cr_deudores
       --       where en_ente     = @i_ente
       --       and   de_tramite  = @i_tramite
       --       and   en_ente not in ( select vd_cliente from cob_credito..cr_verifica_datos)
	   --
       --	   -------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>
       --	   -------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>
       --	   -- Deudor que no pertenezca a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = 0
       --       from  cobis..cl_ente, cob_credito..cr_deudores
       --       where en_ente     = @i_ente
       --       and   de_tramite  = @i_tramite
       --       and   en_ente not in ( select vd_cliente from cob_credito..cr_verifica_datos)
       --       
       --       union -- Deudor que pertenezca a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = isnull(vd_resultado,0)
       --       from  cobis..cl_ente EN, cob_credito..cr_deudores DE, cob_credito..cr_verifica_datos VD
       --       where en_ente    = @i_ente
       --       and   de_tramite = @i_tramite
       --       and   de_tramite = vd_tramite
       --       and   en_ente    = vd_cliente
       --       and   en_ente    = de_cliente
       --       and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  VD.vd_cliente) < @w_fecha_ini_param
       --       
       --       union	-- Aval	que no pertenece a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = 0
       --       from  cob_credito..cr_tramite, cobis..cl_ente
       --       where tr_alianza  = en_ente
       --       and   tr_tramite  = @i_tramite
       --       and   tr_alianza not in ( select vd_cliente from cob_credito..cr_verifica_datos)
       --       
       --       union -- Aval	que pertenece a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = isnull(vd_resultado,0)
       --       from  cob_credito..cr_tramite TR, cobis..cl_ente EN, cob_credito..cr_verifica_datos VD
       --       where tr_alianza  = en_ente
       --       and   tr_tramite  = @i_tramite
       --       and   tr_tramite  = vd_tramite
       --       and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  TR.tr_alianza) < @w_fecha_ini_param               			   
	   --   end	   
	   --lse
	   --   begin
       --       print 'No existe en la tabla cr_verifica_datos'
		--	   -- Deudor que no pertenezca a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = 0
       --       from  cobis..cl_ente, cob_credito..cr_deudores
       --       where en_ente     = @i_ente
       --       and   de_tramite  = @i_tramite
		--       --and   en_ente not in ( select vd_cliente from cob_credito..cr_verifica_datos)
       --       
       --       --union -- Deudor que pertenezca a cr_verifica_datos
       --       --select top 1 'Ente'          = en_ente,
       --       --       'Nombre_Cliente'      = en_nomlar,
       --       --       'Resultado'           = 0
       --       --from  cobis..cl_ente EN, cob_credito..cr_deudores DE, cob_credito..cr_verifica_datos VD
       --       --where en_ente    = @i_ente
       --       --and   en_ente    = vd_cliente
       --       --and   en_ente    = de_cliente
       --       --and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  VD.vd_cliente) < @w_fecha_ini_param
       --       
       --       union	-- Aval	que no pertenece a cr_verifica_datos
       --       select 'Ente'                = en_ente,
       --              'Nombre_Cliente'      = en_nomlar,
       --              'Resultado'           = 0
       --       from  cob_credito..cr_tramite, cobis..cl_ente
       --       where tr_alianza  = en_ente
       --       and   tr_tramite  = @i_tramite
       --       --and   tr_alianza not in ( select vd_cliente from cob_credito..cr_verifica_datos)
       --       
       --       --union -- Aval	que pertenece a cr_verifica_datos
       --       --select top 1 'Ente'          = en_ente,
       --       --       'Nombre_Cliente'      = en_nomlar,
       --       --       'Resultado'           = 0
       --       --from  cob_credito..cr_tramite TR, cobis..cl_ente EN
       --       --where tr_alianza  = en_ente
       --       --and   tr_tramite  = @i_tramite
       --       --and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  TR.tr_alianza) < @w_fecha_ini_param		   
	   --   end
	   --
   end

    if @i_modo = 3
    begin
        select @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDGR' and pa_producto = 'CRE'

		--Nuevos
		select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = en_nomlar,
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											and dc_cliente = en_ente)
        from cob_credito..cr_ej_regla_aplica_cuest, cob_credito..cr_tramite_grupal TG, cobis..cl_cliente_grupo CG, cobis..cl_ente EN
        where er_tramite = @i_tramite
        and er_in_etapa = 'S'
        and er_est_en_cred = 'V'
        and er_tramite = TG.tg_tramite
        and er_cliente = TG.tg_cliente
        and TG.tg_participa_ciclo = 'S'
        and TG.tg_monto_aprobado > 0
        and TG.tg_grupo   = CG.cg_grupo
        and TG.tg_cliente = CG.cg_ente
        and CG.cg_ente = EN.en_ente
        and cg_fecha_desasociacion is null
        and EN.en_ente not in (select vd_cliente from cob_credito..cr_verifica_datos where vd_tramite =  TG.tg_tramite and vd_cliente = EN.en_ente)        
		
		union
		--Antiguos
		select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = en_nomlar,
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											and dc_cliente = en_ente)
        from cob_credito..cr_ej_regla_aplica_cuest, cob_credito..cr_tramite_grupal TG, cobis..cl_cliente_grupo CG, cobis..cl_ente EN
        where er_tramite = @i_tramite
        and er_in_etapa = 'S'
        and er_est_en_cred = 'V'
        and er_tramite = TG.tg_tramite
        and er_cliente = TG.tg_cliente
        and TG.tg_participa_ciclo = 'S'
        and TG.tg_monto_aprobado > 0
        and TG.tg_grupo   = CG.cg_grupo
        and TG.tg_cliente = CG.cg_ente
        and CG.cg_ente = EN.en_ente
        and cg_fecha_desasociacion is null
        and EN.en_ente not in (select vd_cliente from cob_credito..cr_verifica_datos 
                               where vd_tramite =  TG.tg_tramite and vd_cliente = EN.en_ente and vd_resultado > @w_param_val_resp_min)
        		
        --select 'Ente'       = cg_ente,
        --       'Id_Grupo'   = cg_grupo,
        --       'Fecha_Aso'  = cg_fecha_reg,
        --       'Rol'        = cg_rol,
        --       'Estado'     = cg_estado,
        --       'Cal_Interna'= (isnull(p_calif_cliente,'')),
        --       'Fecha_Desasociacion' = cg_fecha_desasociacion,
        --       'Nombre_Cliente'      = en_nomlar,
        --       'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
        --       'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
        --       'Cal_Interna'         = (isnull(p_calif_cliente,'')),
        --       'Lugar_Reunion'       = cg_lugar_reunion,
        --       'Ahorro_Voluntario'   = cg_ahorro_voluntario,
        --       'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
        --       'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
        --       'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
		--									and dc_cliente = en_ente)
        --from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cob_credito..cr_tramite_grupal TG
        --where CG.cg_ente NOT IN ( select vd_cliente from cob_credito..cr_verifica_datos)
        --and   CG.cg_ente    = EN.en_ente
        --and   CG.cg_grupo   = @i_grupo
		--and   TG.tg_tramite = @i_tramite
        --and   TG.tg_participa_ciclo = 'S'
		--and   TG.tg_grupo   = CG.cg_grupo
        --and   TG.tg_cliente = CG.cg_ente
		--and   TG.tg_monto_aprobado  > 0		
        --and   cg_fecha_desasociacion is null
		--
        --union
		--
        --select 'Ente'       = cg_ente,
        --       'Id_Grupo'   = cg_grupo,
        --       'Fecha_Aso'  = cg_fecha_reg,
        --       'Rol'        = cg_rol,
        --       'Estado'     = cg_estado,
        --       'Cal_Interna'= (isnull(p_calif_cliente,'')),
        --       'Fecha_Desasociacion' = cg_fecha_desasociacion,
        --       'Nombre_Cliente'      = en_nomlar,
        --       'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
        --       'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
        --       'Cal_Interna'         = (isnull(p_calif_cliente,'')),
        --       'Lugar_Reunion'       = cg_lugar_reunion,
        --       'Ahorro_Voluntario'   = cg_ahorro_voluntario,
        --       'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
        --       'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
        --       'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
		--									and dc_cliente = en_ente)
        --from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cob_credito..cr_verifica_datos, cob_credito..cr_tramite_grupal TG
        --where cg_ente    = en_ente
        --and   vd_cliente = en_ente
        --and   cg_grupo   = @i_grupo
		--and   TG.tg_tramite = @i_tramite
        --and   TG.tg_participa_ciclo = 'S'
		--and   TG.tg_grupo   = CG.cg_grupo
        --and   TG.tg_cliente = CG.cg_ente
		--and   TG.tg_monto_aprobado  > 0		
        --and   cg_fecha_desasociacion is NULL
        ----and   vd_fecha < @w_fecha_ini
        --and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  CG.cg_ente) <= @w_fecha_ini_param --Caso #149444
		--
        --union
		--
        --select 'Ente'       = cg_ente,
        --       'Id_Grupo'   = cg_grupo,
        --       'Fecha_Aso'  = cg_fecha_reg,
        --       'Rol'        = cg_rol,
        --       'Estado'     = cg_estado,
        --       'Cal_Interna'= (isnull(p_calif_cliente,'')),
        --       'Fecha_Desasociacion' = cg_fecha_desasociacion,
        --       'Nombre_Cliente'      = en_nomlar,
        --       'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
        --       'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
        --       'Cal_Interna'         = (isnull(p_calif_cliente,'')),
        --       'Lugar_Reunion'       = cg_lugar_reunion,
        --       'Ahorro_Voluntario'   = cg_ahorro_voluntario,
        --       'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
        --       'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
        --       'Nro Ciclo'           = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
		--									and dc_cliente = en_ente)
        --from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cob_credito..cr_verifica_datos, cob_credito..cr_tramite_grupal TG
        --where cg_ente      = en_ente
        --and   vd_cliente   = en_ente
        --and   cg_grupo     = @i_grupo
		--and   TG.tg_tramite = @i_tramite
        --and   TG.tg_participa_ciclo = 'S'
		--and   TG.tg_grupo   = CG.cg_grupo
        --and   TG.tg_cliente = CG.cg_ente
		--and   TG.tg_monto_aprobado  > 0			
        --and   cg_fecha_desasociacion is NULL
        ----and   vd_fecha < @w_fecha_ini
        --and   (select max(vd_fecha) from cob_credito..cr_verifica_datos where vd_cliente =  CG.cg_ente) >= @w_fecha_ini_param		
		--and   vd_resultado < @w_param_val_resp_min 
   end
   
  if @i_modo = 4 -- Para reporte
   begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = UPPER(isnull(en_nombre,''))+' '+UPPER(isnull(p_s_nombre,''))+' '+UPPER(isnull(p_p_apellido,''))+' '+UPPER(isnull(p_s_apellido,'')),
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'		     = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											and dc_cliente = en_ente)
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cob_credito..cr_tramite_grupal 
        where cg_ente    = en_ente
        and   cg_grupo   = @i_grupo
		and   tg_tramite = @i_tramite
		and   tg_cliente = en_ente
		and   tg_participa_ciclo = 'S'
		and   tg_monto > 0
        order by cg_ente
   end
   
    if @i_modo = 5  -- Integrantes que participen en el trámite
    begin
        select 'Ente'       = cg_ente,
               'Id_Grupo'   = cg_grupo,
               'Fecha_Aso'  = cg_fecha_reg,
               'Rol'        = cg_rol,
               'Estado'     = cg_estado,
               'Cal_Interna'= (isnull(p_calif_cliente,'')),
               'Fecha_Desasociacion' = cg_fecha_desasociacion,
               'Nombre_Cliente'      = en_nomlar,
               'Rol_Descrip'         = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
               'Estado_Descrip'      = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
               'Cal_Interna'         = (isnull(p_calif_cliente,'')),
               'Lugar_Reunion'       = cg_lugar_reunion,
               'Ahorro_Voluntario'   = cg_ahorro_voluntario,
               'Cuenta_Individual'   = (select ea_cta_banco from  cobis..cl_ente_aux where ea_ente=CG.cg_ente),
               'Resultado'           = isnull((select vd_resultado from cob_credito..cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = CG.cg_ente),0),
               'Nro Ciclo'		     = (select count(dc_cliente) from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo 
											and dc_cliente = en_ente)
        from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN, cob_credito..cr_tramite_grupal 
        where cg_ente    = en_ente
        and   cg_grupo   = @i_grupo
		and   tg_tramite = @i_tramite
		and   tg_cliente = en_ente
		and   tg_participa_ciclo = 'S'
		and   tg_monto > 0
        order by cg_ente
   end   
  
end -- FIN OPCION S

if @i_operacion = 'Q'
begin
    --Consulta de Datos
    select @w_ente                = cg_ente,
           @w_grupo               = cg_grupo,
           @w_fecha_asociacion    = cg_fecha_reg,
           @w_rol                 = cg_rol,
           @w_estado              = cg_estado,
           @w_calif_interna       = (isnull(p_calif_cliente,'')),
           @w_fecha_desasociacion = cg_fecha_desasociacion,
           @w_cliente_nomlar      = en_nomlar,
           @w_cg_ahorro_voluntario = cg_ahorro_voluntario,
           @w_cg_lugar_reunion     = cg_lugar_reunion,
           @w_rol_desc             = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = CG.cg_rol),
           @w_estado_desc          = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_estado and codigo = CG.cg_estado),
           @w_calif_interna_desc   = (isnull(p_calif_cliente,''))
    from  cobis..cl_cliente_grupo CG, cobis..cl_ente EN
    where cg_ente  = en_ente
    and   cg_ente  = @i_ente
    and   cg_grupo = @i_grupo
    and   cg_fecha_desasociacion is null

    select 'Ente'       = @w_ente,
           'Id_Grupo'   = @w_grupo,
           'Fecha_Aso'  = @w_fecha_asociacion,
           'Rol'        = @w_rol,
           'Estado'     = @w_estado,
           'Cal_Interna'= @w_calif_interna,
           'Fecha_Desasociacion' = @w_fecha_desasociacion,
           'Nombre_Cliente'      = @w_cliente_nomlar,
           'Rol_Descrip'         = @w_rol_desc,
           'Estado_Descrip'      = @w_estado_desc,
           'Cal_Interna'         = @w_calif_interna_desc,
           'Ahorro_Voluntario'   = @w_cg_ahorro_voluntario,
           'Lugar_Reunion'       = @w_cg_lugar_reunion
end -- FIN OPCION Q
--Obtener la calificacion del cliente-
if @i_operacion = 'L'
begin
    --Consulta de Datos
    select @w_ente                = en_ente,
           @w_calif_interna   = (isnull(p_calif_cliente,''))
    from  cobis..cl_ente EN
    where  en_ente = @i_ente

    select 'Ente'       = @w_ente,
           'Cal_Interna'= @w_calif_interna
end -- FIN OPCION L

return 0

ERROR:
    begin --Devolver mensaje de Error
        select @w_error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error

        return @w_error
    end
go
