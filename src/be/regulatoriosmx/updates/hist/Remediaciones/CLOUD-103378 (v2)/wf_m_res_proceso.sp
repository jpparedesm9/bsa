use cob_workflow
go
if exists (select *
             from sysobjects
            where name = 'sp_m_res_proceso_wf')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_m_res_proceso_wf'
  drop procedure sp_m_res_proceso_wf
end

go
-- print 'CREANDO EL PROCEDIMIENTO sp_m_res_proceso_wf'
go
/************************************************************/
/*   ARCHIVO:         wf_m_res_proceso.sp                   */
/*   NOMBRE LOGICO:   sp_m_res_proceso_wf                   */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*   Actualiza las estadisticas de Procesos (Resumenes      */
/*   de Proceso.                                            */
/*      - Si @i_tipo = 'I' ==> Se Inicia el Proceso.        */
/*      - Si @i_tipo = 'F' ==> Se Finaliza o Cancela el     */
/*                             Proceso.                     */
/*      - Si @i_tipo = 'R' ==> Se Retrasa el Proceso.       */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR              RAZON                  */
/*   02-Ago-2000  Yury Cantos M.     Emision Inicial.       */
/*   03-Jul-2001  Mario Valarezo A.  Cambios en tabla.      */
/*   22-Sep-2004  Carlos Munoz       Manejo de fecha fin.   */
/************************************************************/
CREATE PROCEDURE sp_m_res_proceso_wf (
  @s_ssn                int         = null,
  @s_user               varchar(30) = null,
  @s_sesn               int         = null,
  @s_term               varchar(30) = null,
  @s_date               datetime    = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint    = null,
  @t_trn                int         = null,
  @t_debug              char(1)     = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,

  @s_rol                smallint    = null,
  @s_org_err            char(1)     = null,
  @s_error		int         = null,
  @s_sev                tinyint     = null,
  @s_msg                descripcion = null,
  @s_org                char(1)     = null,
  @t_rty                char(1)     = null,

  @i_tipo               char (1),
  @i_id_inst_proceso    int,

  @i_id_proceso         smallint    = null,
  @i_version_proc       smallint    = null
)
As declare
  @w_sp_name            varchar(64),
  @w_fecha              char(8),
  @w_tiempo_efe         int,
  @w_tiempo_std         int,
  @w_fecha_fin          char(8),
  @w_fecha_ini          char(8),
  @w_retrasado          bit,
  @w_tiempo_real        int,
  @w_num_a_tiempo       int,
  @w_num_retrasados     int,
  @w_feriados_contador  int,
  @w_ciudad				int

  select @w_sp_name = 'sp_m_res_proceso_wf'

  select @w_tiempo_std   = isnull(pr_tiempo_estandar, 0),
         @w_tiempo_efe   = isnull(pr_tiempo_efectivo, 0)
    from wf_proceso
   where pr_codigo_proceso = @i_id_proceso

  -- Si se inicia el Proceso.
  if @i_tipo = 'I'
  begin
    select @w_fecha = '99999999'

    if exists (select 1
                 from wf_r_proceso
                where rr_codigo_proceso  = @i_id_proceso
                  and rr_version_proceso = @i_version_proc
                  and rr_fecha           = @w_fecha
				  and rr_oficina         = @s_ofi)
    begin
      -- Si existe el registro de resumenes, actualiza.
      update wf_r_proceso
         set rr_num_a_tiempo    = rr_num_a_tiempo + 1,
             --rr_tiempo_real     = @w_tiempo_efe, -- Inicial
             rr_tiempo_estandar = @w_tiempo_std
       where rr_codigo_proceso  = @i_id_proceso
         and rr_version_proceso = @i_version_proc
         and rr_fecha           = @w_fecha
		 and rr_oficina         = @s_ofi

      if @@error != 0
      begin
        -- Error en la insercion de Resumenes de Proceso.
        return 3107506
      end
    end
    else
    begin
      -- Si no existe el registro de resumenes,
      -- lo inserta, caso contrario, no hace nada.
      insert into wf_r_proceso
             (rr_codigo_proceso, rr_version_proceso, rr_fecha,
              rr_num_a_tiempo, rr_num_retrasados, rr_tiempo_real,
              rr_tiempo_estandar,rr_oficina)
      values (@i_id_proceso, @i_version_proc, @w_fecha,
              1, 0, 0, @w_tiempo_std,@s_ofi) --- @w_tiempo_efe por cero en penultimo valor.

      if @@error != 0
      begin
        -- Error en la insercion de Resumenes de Proceso.
        return 3107504
      end
    end
  end

  -- Si terminas el proceso.
  if @i_tipo = 'F'
  begin
    select @w_fecha_fin   = convert (char(8), io_fecha_fin, 112),
           @w_retrasado   = io_retrasado
      from wf_inst_proceso
    where io_id_inst_proc = @i_id_inst_proceso   


    if @w_fecha_fin is null
    begin
      select @w_fecha_fin = convert (char(8), getdate(), 112)
    end
	
	
	select @w_fecha_ini = convert(char(8), io_fecha_crea, 112) from wf_inst_proceso where io_id_inst_proc = @i_id_inst_proceso
	
	--obtenemos la ciudad 
	select @w_ciudad = of_ciudad from cobis..cl_oficina where of_oficina = @s_ofi
	
    --contamos 	feriados
	exec @w_feriados_contador = wf_feriados 
	@i_operacion = 'C',
	@i_ciudad = @w_ciudad,
	@i_fecha_ini = @w_fecha_ini,
	@i_fecha_fin = @w_fecha_fin,
    @o_counter = @w_feriados_contador output
    
	--se resta los días de feriado transformado a minutos
    select @w_tiempo_real = datediff(minute, io_fecha_crea, isnull(io_fecha_fin,getdate())) - (@w_feriados_contador * 1440)
    from wf_inst_proceso
    where io_id_inst_proc = @i_id_inst_proceso   
    
    if @w_tiempo_real = 0 select @w_tiempo_real = 1
	
	 if @w_tiempo_real > @w_tiempo_std
	  begin
		select @w_retrasado = 1
	  end
	  else
	  begin
		select @w_retrasado = 0
	  end
    
    select @w_fecha = '99999999'
    
    --- Se actualiza el valor si existe
    if exists (select 1 from wf_r_proceso
               where rr_codigo_proceso  = @i_id_proceso
               and rr_version_proceso   = @i_version_proc
               and rr_fecha             = @w_fecha_fin
			   and rr_oficina           = @s_ofi)
    begin    
       if (select rr_tiempo_max 
            from wf_r_proceso 
            where rr_codigo_proceso = @i_id_proceso
            and rr_version_proceso  = @i_version_proc
            and rr_fecha            = @w_fecha_fin
			and rr_oficina          = @s_ofi	) < @w_tiempo_real
        begin
           update wf_r_proceso
           set rr_tiempo_real = rr_tiempo_real + @w_tiempo_real,
               rr_tiempo_estandar = rr_tiempo_estandar + @w_tiempo_std, rr_tiempo_max = @w_tiempo_real
           where rr_codigo_proceso   = @i_id_proceso
           and rr_version_proceso  = @i_version_proc
           and rr_fecha            = @w_fecha_fin  
		   and rr_oficina          = @s_ofi
        end
        else
        begin 
           update wf_r_proceso
           set rr_tiempo_real = rr_tiempo_real + @w_tiempo_real,
               rr_tiempo_estandar = rr_tiempo_estandar + @w_tiempo_std
           where rr_codigo_proceso   = @i_id_proceso
           and rr_version_proceso  = @i_version_proc
           and rr_fecha            = @w_fecha_fin
		   and rr_oficina          = @s_ofi
        end
       
       if @@error != 0
      begin
        return 3107504
      end      
    end
    
    select @w_num_a_tiempo     = rr_num_a_tiempo,
           @w_num_retrasados   = rr_num_retrasados
    from wf_r_proceso
    where rr_codigo_proceso  = @i_id_proceso
     and rr_version_proceso  = @i_version_proc
     and rr_fecha            = @w_fecha_fin
	 and rr_oficina          = @s_ofi
    
    if exists (select 1
               from  wf_r_proceso
               where rr_codigo_proceso  = @i_id_proceso
               and rr_version_proceso   = @i_version_proc
               and rr_fecha             = @w_fecha
			   and rr_oficina           = @s_ofi)
    begin
      -- Si esta retrasado.
      if @w_retrasado = 1
      begin
        -- Quito un retrasado a los que se est n ejecutando.
        update wf_r_proceso
           set rr_num_a_tiempo    = rr_num_a_tiempo   - 1,
               rr_tiempo_estandar = (@w_tiempo_std * (isnull(@w_num_retrasados, 0) + rr_num_a_tiempo))
         where rr_codigo_proceso  = @i_id_proceso
           and rr_version_proceso = @i_version_proc
           and rr_fecha           = @w_fecha
		   and rr_oficina         = @s_ofi

        if @@error != 0
        begin
          return 3107506
        end

        -- Si existe el registro de terminados para la fecha
        -- Aumento un retrasado con update.
        if exists (select 1
                     from wf_r_proceso
                    where rr_codigo_proceso  = @i_id_proceso
                      and rr_version_proceso = @i_version_proc
                      and rr_fecha           = @w_fecha_fin
					  and rr_oficina         = @s_ofi)
        begin
          update wf_r_proceso
             set rr_num_retrasados  = rr_num_retrasados + 1
           where rr_codigo_proceso  = @i_id_proceso
             and rr_version_proceso = @i_version_proc
             and rr_fecha           = @w_fecha_fin
	         and rr_oficina         = @s_ofi

          if @@error != 0
          begin
            return 3107506
          end
        end
        else
        begin
          -- Si no existe el registro de terminados para la fecha
          -- Inserto un retrasado.
          insert into wf_r_proceso
                 (rr_codigo_proceso, rr_version_proceso, rr_fecha,
                  rr_num_a_tiempo, rr_num_retrasados, rr_tiempo_real,
                  rr_tiempo_estandar, rr_tiempo_max,rr_oficina)
          values (@i_id_proceso, @i_version_proc, @w_fecha_fin,
                  0, 1, @w_tiempo_real, @w_tiempo_std, @w_tiempo_real,@s_ofi)

          if @@error != 0
          begin
            -- Error en la insercion de Resumenes de Proceso.
            return 3107504
          end
        end
      end


      -- Si NO esta retrasado.
      if @w_retrasado = 0
      begin
        -- Quito un a tiempo a los que se est n ejecutando.
        update wf_r_proceso
           set rr_num_a_tiempo    = rr_num_a_tiempo - 1
         where rr_codigo_proceso  = @i_id_proceso
           and rr_version_proceso = @i_version_proc
           and rr_fecha           = @w_fecha
		   and rr_oficina         = @s_ofi

        if @@error != 0
        begin
          return 3107506
        end

        -- Si existe el registro de a tiempo para la fecha
        -- Aumento un a tiempo con update.
        if exists (select 1
                     from wf_r_proceso
                    where rr_codigo_proceso  = @i_id_proceso
                      and rr_version_proceso = @i_version_proc
                      and rr_fecha           = @w_fecha_fin
					  and rr_oficina         = @s_ofi)
        begin
          update wf_r_proceso
             set rr_num_a_tiempo    = rr_num_a_tiempo + 1
           where rr_codigo_proceso  = @i_id_proceso
             and rr_version_proceso = @i_version_proc
             and rr_fecha           = @w_fecha_fin
		     and rr_oficina         = @s_ofi
			 
          if @@error != 0
          begin
            return 3107506
          end
        end
        else
        begin
          -- Si no existe el registro de a tiempo para la fecha
          -- Inserto un a tiempo.
          insert into wf_r_proceso
                 (rr_codigo_proceso, rr_version_proceso, rr_fecha,
                  rr_num_a_tiempo, rr_num_retrasados, rr_tiempo_real,
                  rr_tiempo_estandar, rr_tiempo_max,rr_oficina)
          values (@i_id_proceso, @i_version_proc, @w_fecha_fin,
                  1, 0, @w_tiempo_real, @w_tiempo_std, @w_tiempo_real,@s_ofi)

          if @@error != 0
          begin
            -- Error en la insercion de Resumenes de Proceso.
            return 3107504
          end
        end
      end
    end
  end

  -- Consideraciones por retraso.
  if @i_tipo = 'R'
  begin
    select @w_fecha_fin    = convert (char(8), io_fecha_fin, 112),
           @w_retrasado    = io_retrasado
      from wf_inst_proceso
    where io_id_inst_proc = @i_id_inst_proceso

    if @w_fecha_fin is null
    begin
      select @w_fecha_fin = '99999999'
    end

    select @w_fecha = @w_fecha_fin

    if exists (select 1
                 from wf_r_proceso
                where rr_codigo_proceso  = @i_id_proceso
                  and rr_version_proceso = @i_version_proc
                  and rr_fecha           = @w_fecha
				  and rr_oficina         = @s_ofi)
    begin
      -- Si existe el registro de resumenes, actualiza.
      update wf_r_proceso
         set rr_num_a_tiempo    = rr_num_a_tiempo   - 1,
             rr_num_retrasados  = rr_num_retrasados + 1
       where rr_codigo_proceso  = @i_id_proceso
         and rr_version_proceso = @i_version_proc
         and rr_fecha           = @w_fecha
		 and rr_oficina         = @s_ofi

      if @@error != 0
      begin
        -- Error en la insercion de Resumenes de Proceso.
        return 3107506
      end
    end
    else
    begin
      -- Si no existe el registro de resumenes,
      -- lo inserta, caso contrario, no hace nada.
      insert into wf_r_proceso
             (rr_codigo_proceso, rr_version_proceso, rr_fecha,
              rr_num_a_tiempo, rr_num_retrasados, rr_tiempo_real,
              rr_tiempo_estandar,rr_oficina)
      values (@i_id_proceso, @i_version_proc, @w_fecha,
              0, 1, @w_tiempo_efe, @w_tiempo_std,@s_ofi)

      if @@error != 0
      begin
        -- Error en la insercion de Resumenes de Proceso.
        return 3107504
      end
    end
  end

return 0
go
