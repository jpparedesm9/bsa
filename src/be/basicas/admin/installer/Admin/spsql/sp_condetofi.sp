/************************************************************************/
/*   Archivo:         sp_condetofi.sp                                   */
/*   Stored procedure:   sp_condetofi                                   */
/*   Base de datos:      cobis                                          */
/*   Producto:          Admin                                           */
/*   Disenado por:        Juan Tagle                                    */
/*   Fecha de escritura: 13-Abril-2015                                  */
/************************************************************************/
/*                        IMPORTANTE                        */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Este programa consulta las oficinas del sistema                    */
/*                        MODIFICACIONES                                */
/************************************************************************/
/*   FECHA      AUTOR      RAZON                                        */
/*   13/Abr/2015   J.Tagle      Emision Inicial                         */
/*   11-04-2016    BBO          Migracion Sybase-Sqlserver FAL          */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_condetofi')
    drop  proc sp_condetofi
go

create proc sp_condetofi (
   @s_ssn            int       = NULL,
   @s_user            login       = NULL,
   @s_sesn            int       = NULL,
   @s_term            varchar(32) = NULL,
   @s_date            datetime    = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv            varchar(30) = NULL, 
   @s_rol            smallint    = NULL,
   @s_ofi            smallint    = NULL,
   @s_org_err         char(1)    = NULL,
   @s_error         int       = NULL,
   @s_sev            tinyint    = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1)      = NULL,
   @t_show_version     bit         = 0,
   @t_debug         char(1)    = 'N',
   @t_file            varchar(14) = null,
   @t_from            varchar(32) = null,
   @t_trn            smallint    = NULL,
   @i_operacion       char(1) = null,
   @i_culture          varchar(30) = null,
   @i_sig_ofi          int = null
)
as
declare @w_sp_name varchar(32),
        @w_compo integer,
      @w_rep integer,
      @w_nivel integer,
      @w_prodname varchar(10),
      @w_sec_inicial integer

if @t_show_version = 1
begin
    print 'Stored procedure sp_condetofi, Version 4.0.0.1'
    return 0
end
      
select @w_sp_name = 'sp_condetofi',
       @i_culture = UPPER(@i_culture)

if @t_trn = 15405
begin      

   -----------
   -- CONSULTA      
   -----------
   if @i_operacion = 'S'
   begin
      select top 1 @w_sec_inicial = do_sec from cl_det_oficina order by do_sec
      select @i_sig_ofi = @w_sec_inicial + @i_sig_ofi -1
   
      set rowcount 5
      select 
         '501018'   =   ltrim(rtrim(do_regional)),
         '501019'   =   ltrim(rtrim(do_cod_fie_asfi)),
         '501020'   =   do_cod_oficina,
         '501021'   =   ltrim(rtrim(do_dpto_pais)),
         '501022'   =   ltrim(rtrim(do_provincia)),
         '501023'   =   ltrim(rtrim(do_municipio)),
         '501024'   =   ltrim(rtrim(do_ciudad)),
         '501025'   =   ltrim(rtrim(do_localidad)),
         '501026'   =   convert (varchar(255),isnull(ltrim(rtrim(do_direccion))," ") + '-' + isnull(ltrim(rtrim(do_barrio))," ")),--do_direccion +' - '+do_barrio,
         '501027'   =   ltrim(rtrim(do_dependencia)),
         '501028'   =   ltrim(rtrim(do_tipo_oficina)),
         '501029'   =   ltrim(rtrim(do_clasificacion)),
         '501030'   =   ltrim(rtrim(do_nombre_of)),
         '501031'   =   ltrim(rtrim(do_jefe_agencia)),
         '501046'   =   ltrim(rtrim(do_ci_enc_pto_reclamo)),
         '501032'   =   ltrim(rtrim(do_enc_pto_reclamo)),
         '501033'   =   ltrim(rtrim(do_tel_1)),
         '501034'   =   ltrim(rtrim(do_tel_2)),
         '501035'   =   ltrim(rtrim(do_tel_3)),
         '501036'   =   ltrim(rtrim(do_celular)),
         '501037'   =   ltrim(rtrim(do_cordenadas_lat)),
         '501047'   =   ltrim(rtrim(do_cordenadas_lon)),
         '501038'   =   ltrim(rtrim(do_tipo_horario)),
         '501039'   =   ltrim(rtrim(do_horario_lunes)),
         '501040'   =   ltrim(rtrim(do_horario_sabado)),
         '501041'   =   ltrim(rtrim(do_horario_domingo)),
         '501042'   =   ltrim(rtrim(do_obs_horario)),
         '501043'   =   ltrim(rtrim(do_servicios)),
         '501044'   =   ltrim(rtrim(do_circular_com_asfi)),
         '501045'   =   do_fecha_asfi
      from cl_det_oficina
      where do_sec > @i_sig_ofi
      order by do_sec


      if @@rowcount = 0
      begin
       exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 107122

         return 1
      end
      
   end
   
   -----------
   -- INGRESO      
   -----------
   if @i_operacion = 'I'
   begin
   
   
   ---------------------------------------------------------------------------------------------------------


      set nocount ON
      create table #tmp_serv_of (
            id integer,
            servicios varchar(255)
            )

      declare @w_oficina_revisada integer,
         @w_cont_serv integer,
         @w_servicio_of varchar(255),
         @w_servicio_of_tmp varchar(255),
         @w_servicio_revisado integer,
         @w_flag integer

      select @w_oficina_revisada = -1

      while (1=1)
      begin
         select @w_flag = 0
         set rowcount 1
          select
            @w_oficina_revisada = of_oficina
          from cl_oficina
          where of_oficina > @w_oficina_revisada
          order by of_oficina
         
          if @@rowcount =0
            Break
          set rowcount 0

         ----------------------
         -- print 'Oficina: ' + convert(varchar, @w_oficina_revisada)

         select @w_servicio_revisado = -1
         
         select @w_cont_serv = count(c.codigo)
         from cl_ofic_servicio s,cl_tabla t, cl_catalogo c
         where s.os_oficina = @w_oficina_revisada
         and t.codigo=c.tabla
         and s.os_cat_servicio=c.codigo
         and t.tabla='cl_servicio'
         --order by c.codigo  --comentado migracion sybase-sql 19042016

         select @w_servicio_of = ''
         
         if @w_cont_serv > 0 
         begin
            -- print 'Tiene Servicios'
                  
            while (1=1)
            begin
               set rowcount 1
               
               select @w_servicio_of_tmp = c1.valor,
                      @w_servicio_revisado = convert(int,c1.codigo)
               from cl_ofic_servicio s1,
                  cl_tabla t1,
                  cl_catalogo c1
               where s1.os_oficina = @w_oficina_revisada
               and convert(int,c1.codigo) > @w_servicio_revisado
               and t1.codigo = c1.tabla
               and s1.os_cat_servicio = c1.codigo
               and t1.tabla = 'cl_servicio'
               order by c1.codigo         
         
               if @@rowcount =0
                  Break
            
               if @w_servicio_of_tmp <> ''
                  if @w_flag = 0
                  begin
                     select @w_servicio_of = @w_servicio_of + @w_servicio_of_tmp
                     select @w_flag = 1
                  end
                  else
                     select @w_servicio_of = @w_servicio_of + ', ' + @w_servicio_of_tmp

                     ----------------------
                ----------------------
              
                select @w_servicio_revisado = @w_servicio_revisado
               
            end
            -- print 'Servicios: ' + @w_servicio_of
            insert into #tmp_serv_of values (@w_oficina_revisada,@w_servicio_of)
         end
         ----------------------
        
          select @w_oficina_revisada = @w_oficina_revisada
         
      end
      set rowcount 0    

      --select * from #tmp_serv_of

      set nocount OFF
      
      truncate table cl_det_oficina
      
      insert into cl_det_oficina (	do_regional,		do_cod_fie_asfi, 	do_cod_oficina, 		do_dpto_pais, 		do_provincia,		do_municipio,
									do_ciudad,			do_localidad,		do_direccion,			do_dependencia,		do_tipo_oficina,	do_clasificacion,
									do_nombre_of,		do_jefe_agencia,	do_ci_enc_pto_reclamo,	do_enc_pto_reclamo,	do_tel_1,			do_tel_2,
									do_tel_3,do_celular,do_cordenadas_lat,	do_cordenadas_lon,		do_tipo_horario,	do_horario_lunes,	do_horario_sabado,
									do_horario_domingo,	do_servicios,		do_circular_com_asfi,	do_fecha_asfi,		do_obs_horario,		do_barrio       )
      select 
        a.of_regional + ' - ' + b.valor    as 'Regional'
      , a.of_cod_fie_asf   as 'Cod. FIE-ASFI'
      , a.of_oficina      as 'Cod. Oficina'
      , d.valor        as 'Dpto. Pais'  -- a.of_depart_pais   
      , f.valor        as 'Provincia' -- a.of_provincia
      , h.mu_descripcion      as 'Municipio'
      , i.ci_descripcion   as 'Ciudad'
      , j.ca_descripcion   as 'Localidad'
      , a.of_direccion    as 'Direccion'	  
      , case 
         when a.of_subtipo = 'A' and a.of_tip_punt_at <> 'AG' and a.of_tip_punt_at <> 'SUC'   
         then k.of_nombre
         when a.of_subtipo = 'A' and a.of_tip_punt_at = 'AG'
         then l.nombre
         when a.of_subtipo = 'A' and a.of_tip_punt_at = 'SUC'   
         then k.of_nombre
        end   as 'Dependencia'                           -- 10
      , a.of_tip_punt_at   as 'Tipo Oficina'
      , csec.valor      as 'Clasificacion'
      , a.of_nombre      as 'Nombre Of.'
      , fun.fu_nombre      as 'Jefe Agencia'
      , a.of_ci_encarg   as 'CI. Enc. Pto. Reclamo'
      , a.of_nomb_encarg   as 'Enc. Pto. Reclamo'  -- , funpr.en_nombre
      , telof1.to_valor   as 'Tel 1'
      , telof2.to_valor   as 'Tel 2'
      , telof3.to_valor   as 'Tel 3'
      , telof4.to_valor   as 'Celular'
      , convert(varchar,a.of_lat_coord)    +'-'+ convert(varchar,a.of_lat_grad) +'-'+         
        convert(varchar,a.of_lat_min)       +'-'+ convert(varchar,a.of_lat_seg)   as 'Cordenadas Latitud'
      , convert(varchar,a.of_long_coord)    +'-'+ convert(varchar,a.of_long_grad) +'-'+
        convert(varchar,a.of_long_min)    +'-'+ convert(varchar,a.of_long_seg)  as 'Cordenadas Longitud'
      , chor.valor      as 'Tipo Horario'      
      , convert(varchar(8),tiphor1.ho_hr_inicio, 108) +' - '+ convert(varchar(8),tiphor1.ho_hr_fin, 108)   as 'Horario Lunes'
      , convert(varchar(8),tiphor2.ho_hr_inicio, 108) +' - '+ convert(varchar(8),tiphor2.ho_hr_fin, 108)  as 'Horario Sabado'
      , convert(varchar(8),tiphor3.ho_hr_inicio, 108) +' - '+ convert(varchar(8),tiphor3.ho_hr_fin, 108)  as 'Horario Domingo'
      , tmp.servicios      as 'Servicios'
      , a.of_cir_comunic   as 'Circular Com. ASFI'
      , a.of_fec_aut_asf   as 'Fecha ASFI'
      , a.of_obs_horario   as 'Obs. Horario'

	  , ba.ba_descripcion as 'Barrio'
       FROM cl_oficina a 
       LEFT join cobis..cl_tabla tr ON tr.tabla = 'cl_regional' 
       LEFT join cobis..cl_catalogo b ON a.of_regional = b.codigo and tr.codigo=b.tabla 

       LEFT join cobis..cl_tabla td ON td.tabla = 'cl_depart_pais' 
       LEFT join cobis..cl_catalogo d ON a.of_depart_pais = d.codigo and td.codigo=d.tabla 

       LEFT join cobis..cl_tabla tp ON tp.tabla = 'cl_provincia' 
       LEFT join cobis..cl_catalogo f ON convert(varchar(10) , a.of_provincia ) = f.codigo and tp.codigo=f.tabla

	   LEFT join cobis..cl_barrio ba ON  a.of_barrio  = ba.ba_barrio 
	   
       LEFT join cobis..cl_ciudad i ON  a.of_ciudad  = i.ci_ciudad 

       LEFT join cobis..cl_canton j ON  i.ci_canton = j.ca_canton 

       LEFT join cobis..cl_municipio h ON j.ca_municipio = h.mu_municipio and f.codigo = convert(varchar(10),h.mu_cod_prov) 

       LEFT join cobis..cl_oficina k ON k.of_oficina = a.of_relac_ofic

       LEFT join cobis..cl_sucursal l ON l.sucursal = a.a_sucursal

       LEFT join cobis..cl_tabla tsec ON tsec.tabla = 'cl_sector' 
       LEFT join cobis..cl_catalogo csec ON convert(varchar(10), a.of_sector ) = csec.codigo and tsec.codigo=csec.tabla

       LEFT join cobis..cl_funcionario fun ON fun.fu_funcionario = a.of_jefe_agenc

       -- LEFT join cobis..cl_ente funpr ON convert(varchar,funpr.en_ced_ruc ) = a.of_ci_encarg
       
       LEFT join cobis..cl_telefono_of telof1 ON telof1.to_oficina = a.of_oficina and telof1.to_secuencial = 1 and telof1.to_ttelefono <> 'CE'
       LEFT join cobis..cl_telefono_of telof2 ON telof2.to_oficina = a.of_oficina and telof2.to_secuencial = 2 and telof2.to_ttelefono <> 'CE'
       LEFT join cobis..cl_telefono_of telof3 ON telof3.to_oficina = a.of_oficina and telof3.to_secuencial = 3 and telof3.to_ttelefono <> 'CE'
       LEFT join cobis..cl_telefono_of telof4 ON telof4.to_oficina = a.of_oficina and telof4.to_ttelefono = 'CE' and telof4.to_secuencial = ( select min(to_secuencial) from cobis..cl_telefono_of t where t.to_oficina = a.of_oficina and t.to_ttelefono = 'CE'   ) 

       LEFT join cobis..cl_tabla thor ON thor.tabla = 'cl_tipo_horario' 
       LEFT join cobis..cl_catalogo chor ON convert(varchar(10), a.of_tipo_horar ) = chor.codigo and thor.codigo = chor.tabla

       LEFT join cobis..ad_horario tiphor1 ON tiphor1.ho_tipo_horario = a.of_horario and tiphor1.ho_dia = '1'
       LEFT join cobis..ad_horario tiphor2 ON tiphor2.ho_tipo_horario = a.of_horario and tiphor2.ho_dia = '6'
       LEFT join cobis..ad_horario tiphor3 ON tiphor3.ho_tipo_horario = a.of_horario and tiphor3.ho_dia = '7'

       LEFT join #tmp_serv_of tmp ON tmp.id = a.of_oficina   
       

      order by a.of_filial, a.of_oficina
   ---------------------------------------------------------------------------------------------------------
      if @@rowcount = 0
      begin
       exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 107122

         return 1
      end
      
      select count(do_regional) from cl_det_oficina
      
   end

end 

return 0
go
