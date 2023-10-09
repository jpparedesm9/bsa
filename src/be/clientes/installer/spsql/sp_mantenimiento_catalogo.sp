use cobis
go
if not object_id('sp_mantenimiento_catalogo') is null
   drop proc sp_mantenimiento_catalogo
go
CREATE PROCEDURE sp_mantenimiento_catalogo(
        @s_ssn                  int         = null,
        @s_user                 login       = null,
        @s_term                 varchar(32) = null,
        @s_date                 datetime    = null,
        @s_srv                  varchar(30) = null,
        @s_sesn                 int         = null,
        @s_culture              varchar(10) = null,
        @s_lsrv                 varchar(30) = null,
        @s_ofi                  smallint    = NULL,
        @s_rol                  smallint    = NULL,
        @s_org_err              char(1)     = NULL,
        @s_error                int         = NULL,
        @s_sev                  tinyint     = NULL,
        @s_msg                  descripcion = NULL,
        @s_org                  char(1)     = NULL,
        @t_from                 varchar(32) = null,
        @t_trn                  int         = null,
        @t_show_version         bit         = 0   ,     -- Mostrar la version del programa
        @t_file                 varchar(14) = null,
        @t_debug                char(1)     = 'N' ,
        -------------------------------------------
        @i_operacion            char(1)           ,     -- Opcion con la que se ejecuta el programa
        @i_tabla_catalogo       varchar(80)  = null,
        @i_cod_pais             varchar(10)  = NULL,
        @i_pais_descrip         varchar(80)  = NULL,
        @i_estado               estado       = Null,
        -------------------------------------------
        @i_codigo               varchar(20)  = NULL,
        @i_descripcion          varchar(255) = NULL, --CC225 JMA
        @i_activ_comer          catalogo     = NULL,
        ---------------isic code-------------------
        @i_seccionCode         catalogo      = NULL,
        @i_seccion             varchar(80)   = NULL,
        @i_divisionCode        catalogo      = NULL,
        @i_division            varchar(80)   = NULL,
        @i_grupoCode           catalogo      = NULL,
        @i_grupo               varchar(80)   = NULL,
        @i_claseCode           catalogo      = NULL,
        @i_clase               varchar(80)   = NULL,
        -------------------------------------------
        @i_modo                 int          = null,     -- modo :0,1
        @i_ult_sec              varchar(10)  = null,
        @i_secuencial           int          = null,
        -------------------------------------------
        @i_codSector            catalogo     = null,
        @i_codSubSector         catalogo     = null,
        @i_codActEc             catalogo     = null,
        @i_codCaedge            varchar(255) = null,
        @i_codActEcon           catalogo     = null,
        @i_pais                 int          = null,
        @i_aclaracionFie        varchar(255) = null,
		@i_aclaracionFie2       varchar(255) = null,  	--CC225 JMA
		@i_aclaracionFie3       varchar(255) = null,	--CC225 JMA
		@i_aclaracionFie4       varchar(255) = null,	--CC225 JMA
        @i_valor                varchar(255) = null
)
as
declare
        @w_error                int,
        @w_sp_name              varchar(32),            -- Nombre stored proc
        @w_today                datetime,               -- fecha del dia  
        @w_tabla                smallint,
        @w_codigo               int,
        @w_secuencial           int,                    -- CEX-27433 JRE
        @w_descripcion          catalogo,              -- CEX-27433 JRE
        @w_etiqueta             catalogo,
        @w_etiqueta1            catalogo
-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_mantenimiento_catalogo, Version 4.0.0.6'
    return 0
end
--------------------------------------------------------------------------------------
select @w_today = getdate()
select @w_sp_name = 'sp_mantenimiento_catalogo'

if      (@t_trn <> 1036 and @i_operacion in ('S','I','U','V','W','Z'))
begin
-- No corresponde codigo de transaccion
   exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
   return 1
end 

/*
if (@i_tabla_catalogo = 'cl_paises_restringidos')
begin

        select @w_tabla = codigo from cobis..cl_tabla where tabla = rtrim(@i_tabla_catalogo)

        if (@i_operacion = 'S')
        begin
                set rowcount 20
                if @i_modo = 0
                        select  'Codigo'      = codigo,
                                'Pais'        = valor,
                                'Estado'      = estado
                        from cobis..cl_catalogo
                        where tabla = @w_tabla
                        order by codigo

                if @i_modo = 1
                        select  'Codigo'      = codigo,
                                'Pais'        = valor,
                                'Estado'      = estado
                        from cobis..cl_catalogo
                        where tabla = @w_tabla
                          and codigo > @i_ult_sec
                        order by codigo

                set rowcount 0

                return 0

        end

        if @i_operacion = 'I'
        begin               

               -- Verificar que se ingrese Pais --
                if @i_cod_pais is null
                begin
                        -- No existe Pais --
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101018 
                        return 1
                end


                -- Verificar que se ingrese una descripcion --
                if @i_pais_descrip is null
                begin
                        -- No existe descripcion --
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101103 
                        return 1
                end

                begin tran
                        

                        insert into cobis..cl_catalogo
                                     (tabla,    codigo,      valor,           estado)
                              values (@w_tabla, @i_cod_pais, @i_pais_descrip, @i_estado )
                        if @@error != 0
                        begin
                                -- Error en creacion de catalogo --
                                exec sp_cerror 
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 103015
                                return 1
                        end
          
                   --CEX-27433 JRE
                   select @w_secuencial = siguiente + 1
                   from cobis..cl_seqnos
                   where tabla = 'cl_pais_rest_his'

                   insert into cobis.. cl_pais_rest_his (   
                                            prh_sec,            prh_usuario,      prh_accion,       prh_codigo,
                                            prh_descripcion,      prh_fecha,    prh_terminal,         prh_hora)
                   values (
                                            @w_secuencial,          @s_user,             'I',      @i_cod_pais, 
                                          @i_pais_descrip,          @s_date,         @s_term,         @w_today)

                   if @@error != 0
                   begin
                   -- Error en creacion de catalogo --
                    exec sp_cerror 
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 103015
                   return 1
                   end
             
                   update cl_seqnos
                   set siguiente = @w_secuencial
                   where tabla = 'cl_pais_rest_his'               
                   --CEX-27433 JRE                   
                   
                commit tran

                return 0
          end


        -- Update --
        if @i_operacion = 'U'
        begin
                begin tran
                        
                        update cobis..cl_catalogo
                        set estado  = @i_estado
                        where tabla = @w_tabla
                          and codigo = @i_cod_pais

                         if @@error != 0
                         begin
                                -- 'Error en actualizacion de catalogo'--
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 105000
                                return 1
                         end
                         
                         
                   select @w_descripcion = c.valor
                   from cobis..cl_tabla t, cobis..cl_catalogo c
                   where t.tabla = 'cl_estado_ser' and t.codigo = c.tabla and
                      c.codigo = @i_estado
                         
                   --CEX-27433 JRE
                   select @w_secuencial = siguiente + 1
                   from cobis..cl_seqnos
                   where tabla = 'cl_pais_rest_his'

                   insert into cobis.. cl_pais_rest_his (
                                            prh_sec,          prh_usuario,          prh_accion,              prh_codigo,
                                    prh_descripcion,            prh_fecha,        prh_terminal,                prh_hora)
                   values (
                                      @w_secuencial,              @s_user,                 'U',               @i_estado, 
                                     @w_descripcion,              @s_date,             @s_term,                @w_today)

                   if @@error != 0
                   begin
                   -- Error en creacion de catalogo --
                    exec sp_cerror 
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 103015
                   return 1
                   end
             
                   update cl_seqnos
                   set siguiente = @w_secuencial
                   where tabla = 'cl_pais_rest_his'               
                   --CEX-27433 JRE                   
                   
                  commit tran

                  return 0

        end
end -- Fin (@i_tabla_catalogo = 'cl_paises_restringidos')
*/
-----------------------------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------------------------
if (@i_tabla_catalogo = 'cl_actividad_principal')
begin
		print 'entra por aca'
        if (@i_operacion = 'S')
        begin
                select @w_tabla = codigo from cobis..cl_tabla where tabla =  'cl_fuente_ingreso'
                set rowcount 20
                if @i_modo = 0
                        

                        select  'Codigo'           = ap_codigo,
                                'Descripcion'      = ap_descripcion,
                                'Cod FuenteIngreso'= ap_activ_comer,
                                'Fuente Ingreso'   = valor,
                                'Estado'           = ap_estado
                        from cobis..cl_actividad_principal, cl_catalogo
                        where tabla = @w_tabla
                        and ap_activ_comer = codigo
						and (ap_codigo   = @i_codigo or @i_codigo is null)
                        and (Upper(ap_descripcion)  like @i_descripcion +'%' or @i_descripcion is null) -- Inc 65485
                        order by ap_codigo

                if @i_modo = 1
                        select  'Codigo'           = ap_codigo,
                                'Descripcion'      = ap_descripcion,
                                'Cod FuenteIngreso'= ap_activ_comer,
                                'Fuente Ingreso'   = valor,
                                'Estado'           = ap_estado
                        from cobis..cl_actividad_principal, cl_catalogo
                        where tabla = @w_tabla
                        and ap_activ_comer = codigo
                        and ap_codigo > @i_ult_sec
                        order by ap_codigo

                set rowcount 0

                return 0

        end

        if @i_operacion = 'I'
        begin

                if @i_codigo is null
                begin
                        --El codigo de catalogo no puede ser nulo 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101102 

                        return 1
                end
                        

                if exists(select 1 from cl_actividad_principal where ap_codigo = @i_codigo)
                begin
                        -- El codigo para esta tabla ya existe 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101104

                        return 1                        
                end

                -- Verificar que se ingrese una descripcion 
                if @i_descripcion is null
                begin
                        -- No existe descripcion 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101103 
                        return 1
                end

                -- Verificar que se ingrese Fuente de Ingreso
                if @i_activ_comer is null
                begin
                        -- No existe Fuente de Ingreso 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 103101 
                        return 1
                end

                begin tran
                        insert into cobis..cl_actividad_principal(
                                ap_codigo, ap_descripcion, ap_activ_comer, ap_estado)
                        values (@i_codigo, @i_descripcion, @i_activ_comer, @i_estado)
                        if @@error <> 0
                        begin
                                --Error en creacion de catalogo 
                                exec sp_cerror 
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 103015
                                return 1
                        end
                        
                        -- inserta en el catalogo 
                        if exists (select 1 from cl_tabla where tabla = 'cl_actividad_principal') --MNU 2012.11.10 Catálogo Segmento Cliente
                        begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_actividad_principal'
                        
                           insert into cl_catalogo (tabla, codigo, valor, estado)
                           values (@w_tabla, @i_codigo, @i_descripcion, @i_estado)
                        
                           --  Error en insercion  
                           if @@error <> 0
                           begin
                           exec cobis..sp_cerror
                                @t_debug= @t_debug,
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 103098      
                            return 1
                           end
                        end
          
                commit tran

                return 0
          end


        -- Update 
        if @i_operacion = 'U'
        begin
                begin tran
                        update cobis..cl_actividad_principal
                        set ap_descripcion = @i_descripcion,
                            ap_activ_comer = @i_activ_comer,
                            ap_estado      = @i_estado
                        where ap_codigo = @i_codigo

                         if @@error <> 0
                         begin
                                --'Error en actualizacion de catalogo'
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 105000
                                return 1
                         end
                         
                         -- actualizar en catalago 
                        if exists (select 1 from cl_tabla where tabla = 'cl_actividad_principal') --MNU 2012.11.10 Catálogo Segmento Cliente
                           begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_actividad_principal'
                        
                           if exists (select 1 from cl_catalogo where tabla = @w_tabla and codigo = @i_codigo)
                           begin
                               update cl_catalogo
                               set valor  = @i_descripcion,
                                   estado = @i_estado
                               where tabla = @w_tabla 
                               and codigo  = @i_codigo
                        
                               if @@error <> 0
                               begin
                                  exec cobis..sp_cerror 
                                   @t_debug= @t_debug,
                                   @t_file = @t_file,
                                   @t_from = @w_sp_name,
                                   @i_num  = 105088  
                                  return 1
                               end
                           end
                        end
                         
                  commit tran

                  return 0

        end
end -- Fin (@i_tabla_catalogo = 'cl_actividad_principal')


-----------------------------------------------------------------------------------------------------------
--                                  Tabla cl_isic_code
-----------------------------------------------------------------------------------------------------------

if (@i_tabla_catalogo = 'cl_isic_code')
begin
        if (@i_operacion = 'S')
        begin
                set rowcount 20
                if @i_modo = 0  
                        select 'secuencial' =convert(int, is_secuencial),
                               is_codigo,
                               is_seccionCode,
                               is_seccion,
                               is_divisionCode,
                               is_division,
                               is_grupoCode,
                               is_grupo,
                               is_claseCode,
                               is_clase,
                               is_estado
                        from cobis..cl_isic_code
                        order by is_secuencial

                if @i_modo = 1
                         select 'secuencial' = convert(int, is_secuencial),
                                is_codigo,
                                is_seccionCode,
                                is_seccion,
                                is_divisionCode,
                                is_division,
                                is_grupoCode,
                                is_grupo,
                                is_claseCode,
                                is_clase,
                                is_estado
                         from cobis..cl_isic_code
                         where is_secuencial > @i_secuencial
                         order by is_secuencial

                set rowcount 0

                return 0

        end -- Fin (@i_operacion = 'S')
        ------------------------------------------------- Insert --------------------------------------------------------
        if @i_operacion = 'I'
        begin
                if @i_codigo is null
                begin
                        -- El codigo de catalogo no puede ser nulo  
                        exec sp_cerror
                                @t_debug        = @t_debug,
                                @t_file         = @t_file,
                                @t_from         = @w_sp_name,
                                @i_num          = 101102
                        return 1 

                end

                if exists(select 1 from cl_isic_code where is_codigo = @i_codigo)
                begin
                        -- El codigo para esta tabla ya existe 
                        exec sp_cerror
                                @t_debug        = @t_debug,
                                @t_file         = @t_file,
                                @t_from         = @w_sp_name,
                                @i_num          = 101104
                        return 1 
                end

                        
                begin tran

                insert into cobis..cl_isic_code(
                            is_codigo,
                            is_seccionCode,
                            is_seccion,
                            is_divisionCode,
                            is_division,
                            is_grupoCode,
                            is_grupo,
                            is_claseCode,
                            is_clase,
                            is_estado)
                     values(@i_codigo,
                            @i_seccionCode,
                            @i_seccion,
                            @i_divisionCode,
                            @i_division,
                            @i_grupoCode,
                            @i_grupo,
                            @i_claseCode,
                            @i_clase,
                            @i_estado)
                   
                if @@error <> 0
                begin
                        -- Error en creacion de catalogo
                        exec sp_cerror
                                @t_debug        = @t_debug,
                                @t_file         = @t_file,
                                @t_from         = @w_sp_name,
                                @i_num          = 103015
                        return 1 
                end
                
                select @w_codigo = convert(int,max(is_secuencial) )
                from cobis..cl_isic_code

                select @w_codigo

                commit tran
                return 0

        end -- Fin @i_operacion = 'I'
        ------------------------------------------------- Update --------------------------------------------------------
        if @i_operacion = 'U'
        begin
                begin tran
                        update cobis..cl_isic_code
                        set is_codigo       = @i_codigo,
                            is_seccionCode  = @i_seccionCode,
                            is_seccion      = @i_seccion ,
                            is_divisionCode = @i_divisionCode,
                            is_division     = @i_division,
                            is_grupoCode    = @i_grupoCode,
                            is_grupo        = @i_grupo,
                            is_claseCode    = @i_claseCode,
                            is_clase        = @i_clase,
                            is_estado       = @i_estado
                      where is_secuencial   = @i_secuencial

                        if @@error <> 0
                        begin
                                -- Error en creacion de catalogo 
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 105068
                                return 1 
                        end
                commit tran
                return 0
        end -- Fin @i_operacion = 'U'
end -- Fin (@i_tabla_catalogo = 'cl_isic_code')

----------------------------------------------------------------------------------------------------

--SECTOR ECONÓMICO
----------------------------------------------------------------------------------------------------

if (@i_tabla_catalogo = 'cl_sector_economico')
begin
        if (@i_operacion = 'S')
        begin
                select @w_tabla = codigo from cobis..cl_tabla where tabla =  'cl_sector_economico'

                set rowcount 20
                if @i_modo = 0
                        select  'Codigo'           = se_codigo,
                                'Descripcion'      = se_descripcion,
                                'Cod FuenteIngreso'= se_codFuentIng,
                                'Fuente Ingreso'   = valor,
                                'Estado'           = se_estado
                        from cobis..cl_sector_economico, cl_catalogo
                        where tabla = @w_tabla
                        and se_codigo = codigo
						and (se_codigo   = @i_codigo or @i_codigo is null)
                        and (Upper(se_descripcion)  like @i_descripcion +'%' or @i_descripcion is null) -- Inc 65485
                        order by se_codigo

                if @i_modo = 1
                        select  'Codigo'           = se_codigo,
                                'Descripcion'      = se_descripcion,
                                'Cod FuenteIngreso'= se_codFuentIng,
                                'Fuente Ingreso'   = valor,
                                'Estado'           = se_estado
                        from cobis..cl_sector_economico, cl_catalogo
                        where tabla = @w_tabla
                        and se_codigo = codigo
                        and se_codigo > @i_ult_sec
                        order by se_codigo

                set rowcount 0

                return 0

        end
        
        
        if (@i_operacion = 'V')
        begin

                set rowcount 20
                if @i_modo = 0
                        select  'Codigo'           = se_codigo,
                                'Descripcion'      = se_descripcion
                        from cobis..cl_sector_economico
                        where se_estado='V'
                        order by se_codigo

                if @i_modo = 1
                        select  'Codigo'           = se_codigo,
                                'Descripcion'      = se_descripcion
                        from cobis..cl_sector_economico
                        where se_estado='V'
                        and    se_codigo > @i_ult_sec
                        order by se_codigo

                set rowcount 0

                return 0

        end
        
        if (@i_operacion = 'Q')
        begin
            select  se_descripcion
            from cobis..cl_sector_economico
            where se_estado='V'
            and se_codigo=@i_codigo
            
            if @@rowcount = 0
            begin
                exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 101001
                return 1 
            end
            return 0

        end
        
        --BUSCA FUENTE DE INGRESO DE ACUERDO A SECTOR ECONOMICO
        
        if (@i_operacion = 'H')
        begin
        
            select  'Codigo'       = b.codigo,
                    'Descripcion'  = b.valor
                from cobis..cl_sector_economico c,
                      cobis..cl_tabla a,
                     cobis..cl_catalogo b
                 where a.tabla = 'cl_fuente_ingreso'
                 and a.codigo = b.tabla
                 and se_codFuentIng =  b.codigo
                and se_codigo=@i_codigo
            
            if @@rowcount = 0
            begin
                exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 107288
                return 107288 
            end
            return 0

        end
        

        if @i_operacion = 'I'
        begin

                if @i_codigo is null
                begin
                        -- El codigo de catalogo no puede ser nulo 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101102 

                        return 1
                end
                        

                if exists(select 1 from cl_sector_economico where se_codigo = @i_codigo)
                begin
                        -- El codigo para esta tabla ya existe 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101104

                        return 1                        
                end

                -- Verificar que se ingrese una descripcion 
                if @i_descripcion is null
                begin
                        -- No existe descripcion 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101103 
                        return 1
                end

               -- Verificar que se ingrese Fuente de Ingreso
                if @i_activ_comer is null
                begin
                        --No existe Fuente de Ingreso 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 107214 
                        return 1
                end

                begin tran
                        insert into cobis..cl_sector_economico(
                                se_codigo, se_descripcion, se_codFuentIng, se_estado)
                        values (@i_codigo, @i_descripcion, @i_activ_comer, @i_estado)
                        if @@error <> 0
                        begin
                                -- Error en creacion de sector economico 
                                exec sp_cerror 
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 107290
                                return 1
                        end
                        
                        --inserta en el catalogo 
                        if exists (select 1 from cl_tabla where tabla = 'cl_sector_economico') --MNU 2012.11.10 Catálogo Segmento Cliente
                        begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_sector_economico'
                        
                           insert into cl_catalogo (tabla, codigo, valor, estado)
                           values (@w_tabla, @i_codigo, @i_descripcion, @i_estado)
                        
                           --  Error en insercion  
                           if @@error <> 0
                           begin
                           exec cobis..sp_cerror
                                @t_debug= @t_debug,
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 103015      
                            return 1
                           end
                        end
                        
          
                commit tran

                return 0
          end


       -- Update ** */
        if @i_operacion = 'U'
        begin
                begin tran
                        update cobis..cl_sector_economico
                        set se_descripcion = @i_descripcion,
                            se_codFuentIng = @i_activ_comer,
                            se_estado      = @i_estado
                        where se_codigo = @i_codigo

                         if @@error <> 0
                         begin
                                -- 'Error en actualizacion sector economico'
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 107291
                                return 1
                         end
                         
                         -- actualizar en catalago 
                        if exists (select 1 from cl_tabla where tabla = 'cl_sector_economico') --MNU 2012.11.10 Catálogo Segmento Cliente
                           begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_sector_economico'
                        
                           if exists (select 1 from cl_catalogo where tabla = @w_tabla and codigo = @i_codigo)
                           begin
                               update cl_catalogo
                               set valor  = @i_descripcion,
                                   estado = @i_estado
                               where tabla = @w_tabla 
                               and codigo  = @i_codigo
                        
                               if @@error <> 0
                               begin
                                  exec cobis..sp_cerror 
                                   @t_debug= @t_debug,
                                   @t_file = @t_file,
                                   @t_from = @w_sp_name,
                                   @i_num  = 105000  
                                  return 1
                               end
                           end
                        end
                         
                         
                  commit tran

                  return 0

        end
end -- Fin (@i_tabla_catalogo = 'cl_sector_economico')



----------------------------------------------------------------------------------------------------
--SUB SECTOR ECONÓMICO
----------------------------------------------------------------------------------------------------

if (@i_tabla_catalogo = 'cl_subsector_ec')
begin
        if (@i_operacion = 'S')
        begin
                set rowcount 20
                if @i_modo = 0
                   begin     
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'COD. SECTOR ECO.'= se_codSector,
                                'ESTADO'           = se_estado
                        from cobis..cl_subsector_ec c,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where a.tabla = 'cl_subsector_ec'
                        and a.codigo = b.tabla
                        and c.se_codigo =  b.codigo
						and (se_codigo   = @i_codigo or @i_codigo is null)
                        and (Upper(se_descripcion)  like @i_descripcion +'%' or @i_descripcion is null) -- Inc 65485
                        
                        order by se_codigo
                    
                    end 
                    

                if @i_modo = 1
                begin
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'COD. SECTOR ECO.'= se_codSector,
                                'ESTADO'           = se_estado
                        from cobis..cl_subsector_ec c,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where a.tabla = 'cl_subsector_ec'
                        and a.codigo = b.tabla
                        and c.se_codigo =  b.codigo
                        and se_codigo > @i_ult_sec
                        order by se_codigo
                end
                set rowcount 0

                return 0

        end
    
    --Busca los subsectores economicos por sector economico
    if (@i_operacion = 'Q')
        begin
                set rowcount 20
                if @i_modo = 0
                   begin     
                        select  'CODIGO'           = se_codigo,
                                'VALOR'      = se_descripcion,
                                'COD. SECTOR ECO.'= se_codSector,
                                'ESTADO'           = se_estado
                        from cobis..cl_subsector_ec c,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where a.tabla = 'cl_subsector_ec'
                        and a.codigo = b.tabla
                        and c.se_codigo =  b.codigo
                        and se_codSector=@i_codSector
                        and b.estado='V'
                        order by se_codigo
                    
                    end 
                    

                if @i_modo = 1
                begin
                        select  'CODIGO'           = se_codigo,
                                'VALOR'      = se_descripcion,
                                'COD. SECTOR ECO.'= se_codSector,
                                'ESTADO'           = se_estado
                        from cobis..cl_subsector_ec c,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where a.tabla = 'cl_subsector_ec'
                        and a.codigo = b.tabla
                        and c.se_codigo =  b.codigo
                        and se_codSector=@i_codSector
                        and b.estado='V' 
                        and se_codigo > @i_ult_sec
                        order by se_codigo
                end
                set rowcount 0

                return 0

        end
        
    if (@i_operacion = 'V')
        begin
            select se_descripcion
              from cobis..cl_subsector_ec c,
                   cobis..cl_tabla a,
                   cobis..cl_catalogo b
            where a.tabla = 'cl_subsector_ec'
            and a.codigo = b.tabla
            and c.se_codigo =  b.codigo
            and se_codigo=@i_codigo
            and se_codSector=@i_codSector
            and b.estado='V'
        
            if @@rowcount = 0
            begin
                exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 101001
                return 1 
            end
            return 0

        end
        
        if @i_operacion = 'I'
        begin

                if @i_codigo is null
                begin
                        -- El codigo de catalogo no puede ser nulo
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101102 

                        return 1
                end
                        

                if exists(select 1 from cl_subsector_ec where se_codigo = @i_codigo)
                begin
                        -- El codigo para esta tabla ya existe 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101104

                        return 1                        
                end

                -- Verificar que se ingrese una descripcion 
                if @i_descripcion is null
                begin
                        -- No existe descripcion 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101103 
                        return 1
                end

                -- Verificar que se ingrese Sector Economico
                if @i_codSector is null
                begin
                        -- No existe Sector Economico 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101048 
                        return 1
                end

                begin tran
                        insert into cobis..cl_subsector_ec(
                                se_codigo, se_descripcion, se_codSector, se_estado)
                        values (@i_codigo, @i_descripcion, @i_codSector, @i_estado)
                        if @@error <> 0
                        begin
                                -- Error en creacion subsector económico 
                                exec sp_cerror 
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 107292
                                return 1
                        end
                        
                        
                        -- inserta en el catalogo 
                        if exists (select 1 from cl_tabla where tabla = 'cl_subsector_ec') --MNU 2012.11.10 Catálogo Segmento Cliente
                        begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_subsector_ec'
                        
                           insert into cl_catalogo (tabla, codigo, valor, estado)
                           values (@w_tabla, @i_codigo, @i_descripcion, @i_estado)
                        
                           --  Error en insercion 
                           if @@error <> 0
                           begin
                           exec cobis..sp_cerror
                                @t_debug= @t_debug,
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 103015      
                            return 1
                           end
                        end
          
                commit tran

                return 0
          end
        
        -- Update 
        if @i_operacion = 'U'
        begin
                begin tran
                        update cobis..cl_subsector_ec
                        set se_descripcion = @i_descripcion,
                            se_codSector = @i_codSector,
                            se_estado      = @i_estado
                        where se_codigo = @i_codigo

                         if @@error <> 0
                         begin
                                -- 'Error en actualizacion de subsector economico'
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 107293
                                return 1
                         end
                         
                          -- actualizar en catalago
                        if exists (select 1 from cl_tabla where tabla = 'cl_subsector_ec') --MNU 2012.11.10 Catálogo Segmento Cliente
                           begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_subsector_ec'
                        
                           if exists (select 1 from cl_catalogo where tabla = @w_tabla and codigo = @i_codigo)
                           begin
                               update cl_catalogo
                               set valor  = @i_descripcion,
                                   estado = @i_estado
                               where tabla = @w_tabla 
                               and codigo  = @i_codigo
                        
                               if @@error <> 0
                               begin
                                  exec cobis..sp_cerror 
                                   @t_debug= @t_debug,
                                   @t_file = @t_file,
                                   @t_from = @w_sp_name,
                                   @i_num  = 105000  
                                  return 1
                               end
                           end
                        end
                                      
                         
                         
                  commit tran

                  return 0
        end        

end -- Fin (@i_tabla_catalogo = 'cl_sector_economico')


----------------------------------------------------------------------------------------------------

--ACTIVIDAD ECONÓMICA
----------------------------------------------------------------------------------------------------
if (@i_tabla_catalogo = 'cl_actividad_ec')
begin
        if (@i_operacion = 'S')
        begin
                set rowcount 20
                if @i_modo = 0    
                    select 'CODIGO'      = ac_codigo,
                           'DESCRIPCION' = ac_descripcion
                    from cobis..cl_actividad_ec c,
                         cobis..cl_tabla a,
                         cobis..cl_catalogo b
                    where a.tabla = 'cl_actividad_ec'
                      and a.codigo = b.tabla
                      and c.ac_codigo =  b.codigo
                      and ac_estado='V'
                    order by ac_codigo ASC

                if @i_modo = 1
                    select 'CODIGO'      = ac_codigo,
                           'DESCRIPCION' = ac_descripcion
                    from cobis..cl_actividad_ec c,
                         cobis..cl_tabla a,
                         cobis..cl_catalogo b
                    where a.tabla = 'cl_actividad_ec'
                      and a.codigo = b.tabla
                      and c.ac_codigo =  b.codigo
                      and ac_estado='V'
                    and   ac_codigo > @i_codigo
                    order by ac_codigo ASC
                set rowcount 0

                return 0

        end

        
        if (@i_operacion = 'V')
        begin
                select ac_descripcion
                    from cobis..cl_actividad_ec c,
                         cobis..cl_tabla a,
                         cobis..cl_catalogo b
                    where a.tabla = 'cl_actividad_ec'
                      and a.codigo = b.tabla
                      and c.ac_codigo =  b.codigo
                      and ac_codigo=@i_codigo
                      and ac_codSubsector=@i_codSubSector
                      and ac_estado='V'
                
                if @@rowcount = 0
                begin
                   exec sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 101001
                   return 1 
                end
             return 0
        end

end -- Fin (@i_tabla_catalogo = 'cl_sector_economico')


----------------------------------------------------------------------------------------------------

--SUB ACTIVIDAD ECONÓMICA
----------------------------------------------------------------------------------------------------

if (@i_tabla_catalogo = 'cl_subactividad_ec')
begin
   --CONSULTANDO LAS SUBACTIVIDADES ECONOMICAS DEL SUB-SECTOR ECONOMICO
   if (@i_operacion = 'B')
      begin
	     
         set rowcount 20
         if @i_modo = 0
            begin
               select 'CODIGO' = se_codigo,
                  'VALOR' = se_descripcion,
                  'CAEDEC' = se_codCaedge
               from cobis..cl_subactividad_ec,
                  cobis..cl_tabla a,
                  cobis..cl_catalogo b
               where se_codigo = b.codigo
               and a.tabla = 'cl_subactividad_ec'
               and a.codigo = b.tabla
               and se_codActEc  in (select ac_codigo
                                       from cobis..cl_actividad_ec c,
                                       cobis..cl_tabla a,
                                       cobis..cl_catalogo b
                                       where a.tabla = 'cl_actividad_ec'
                                       and a.codigo = b.tabla
                                       and c.ac_codigo =  b.codigo
                                       and ac_codSubsector= @i_codSubSector
                                       and ac_estado='V')
               and se_estado='V'
               order by se_codigo
            end

         if @i_modo = 1
            begin
               select 'CODIGO' = se_codigo,
                  'VALOR' = se_descripcion,
                  'CAEDEC' = se_codCaedge
               from cobis..cl_subactividad_ec,
                  cobis..cl_tabla a,
                  cobis..cl_catalogo b
               where se_codigo = b.codigo
               and a.tabla = 'cl_subactividad_ec'
               and a.codigo = b.tabla
               and se_codActEc  in (select ac_codigo
                                       from cobis..cl_actividad_ec c,
                                       cobis..cl_tabla a,
                                       cobis..cl_catalogo b
                                       where a.tabla = 'cl_actividad_ec'
                                       and a.codigo = b.tabla
                                       and c.ac_codigo =  b.codigo
                                       and ac_codSubsector= @i_codSubSector
                                       and ac_estado='V')
               and se_estado='V'
               and se_codigo > @i_ult_sec
               order by se_codigo
            end
      end

   --CONSULTANDO LAS SUBACTIVIDADES ECONOMICAS DE UN SECTOR ECONOMICO
   if (@i_operacion = 'C')
      begin
	     
         set rowcount 20
         if @i_modo = 0
            begin
               select 'CODIGO' = se_codigo,
                  'VALOR' = se_descripcion
               from cobis..cl_subactividad_ec,
                  cobis..cl_tabla a,
                  cobis..cl_catalogo b
               where se_codigo = b.codigo
               and a.tabla = 'cl_subactividad_ec'
               and a.codigo = b.tabla
               and se_codActEc  in (select ac_codigo
                                       from cobis..cl_actividad_ec c,
                                       cobis..cl_tabla a,
                                       cobis..cl_catalogo b
                                       where a.tabla = 'cl_actividad_ec'
                                       and a.codigo = b.tabla
                                       and c.ac_codigo =  b.codigo
                                       and ac_codSubsector= @i_codSubSector
                                       and ac_estado='V')
               and se_estado='V'
			   
               order by se_codigo
            end

         if @i_modo = 1
            begin
               select 'CODIGO' = se_codigo,
                  'VALOR' = se_descripcion
               from cobis..cl_subactividad_ec,
                  cobis..cl_tabla a,
                  cobis..cl_catalogo b
               where se_codigo = b.codigo
               and a.tabla = 'cl_subactividad_ec'
               and a.codigo = b.tabla
               and se_codActEc  in (select ac_codigo
                                       from cobis..cl_actividad_ec c,
                                       cobis..cl_tabla a,
                                       cobis..cl_catalogo b
                                       where a.tabla = 'cl_actividad_ec'
                                       and a.codigo = b.tabla
                                       and c.ac_codigo =  b.codigo
                                       and ac_codSubsector= @i_codSubSector
                                       and ac_estado='V')
               and se_estado='V'
               and se_codigo > @i_ult_sec
               order by se_codigo
            end
      end


        if (@i_operacion = 'S')
        begin
		    
                set rowcount 3
                if @i_modo = 0    
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'COD. ACT. ECONOMICA'= se_codActEc,
                                'ESTADO'           = se_estado,
                                'COD. CAEGGE'      = se_codCaedge,
                                'ACLARACION FIE 1'   = se_aclaracionFie,
								'ACLARACION FIE 2'   = se_aclaracionFie2, --CC225 JMA
								'ACLARACION FIE 3'   = se_aclaracionFie3, --CC225 JMA
								'ACLARACION FIE 4'   = se_aclaracionFie4  --CC225 JMA
                        from cobis..cl_subactividad_ec,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where se_codigo = b.codigo
                        and a.tabla = 'cl_subactividad_ec'
                        and a.codigo = b.tabla
						and (se_codigo   = @i_codigo or @i_codigo is null)
                        and (Upper(se_descripcion)  like @i_descripcion +'%' or @i_descripcion is null) -- Inc 65485
                        order by se_codigo

                if @i_modo = 1
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'COD.ACT, ECONOMICA'= se_codActEc,
                                'ESTADO'           = se_estado,
                                'COD. CAEGGE'      = se_codCaedge,
                                'ACLARACION FIE 1'   = se_aclaracionFie,
								'ACLARACION FIE 2'   = se_aclaracionFie2,  --CC225 JMA
								'ACLARACION FIE 3'   = se_aclaracionFie3,  --CC225 JMA
								'ACLARACION FIE 4'   = se_aclaracionFie4   --CC225 JMA
                        from cobis..cl_subactividad_ec,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where se_codigo = b.codigo
                        and a.tabla = 'cl_subactividad_ec'
                        and a.codigo = b.tabla
                        and se_codigo > @i_ult_sec
                        order by se_codigo

                set rowcount 0

                return 0

        end

        --Busca subsctividades q correspondenden a un actividad economica
        if (@i_operacion = 'Q')
        begin
                set rowcount 3
                if @i_modo = 0    
                        select  'CODIGO'           = se_codigo,
                                'VALOR'      = se_descripcion,
                                'COD.ACTIVIDAD ECO.'= se_codActEc,
                                --'Actividad Económica'=b.valor,
                                'ESTADO'           = se_estado,
                                'COD. CAEGGE'      = se_codCaedge,
                                'ACLARACION FIE 1'   = se_aclaracionFie,
								'ACLARACION FIE 2'   = se_aclaracionFie2, --CC225 JMA
								'ACLARACION FIE 3'   = se_aclaracionFie3, --CC225 JMA
								'ACLARACION FIE 4'   = se_aclaracionFie4  --CC225 JMA
                        from cobis..cl_subactividad_ec,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where se_codigo = b.codigo
                        and a.tabla = 'cl_subactividad_ec'
                        and a.codigo = b.tabla
                        and se_codActEc=@i_codActEc
                        and se_estado='V'
                        order by se_codigo

                if @i_modo = 1
                        select  'CODIGO'           = se_codigo,
                                'VALOR'      = se_descripcion,
                                'COD. ACTIVIDAD ECO.'= se_codActEc,
                                'ESTADO'           = se_estado,
                                'COD. CAEGGE'      = se_codCaedge,
                                'ACLARACION FIE 1'   = se_aclaracionFie,
								'ACLARACION FIE 2'   = se_aclaracionFie2,  --CC225 JMA
								'ACLARACION FIE 3'   = se_aclaracionFie3,  --CC225 JMA
								'ACLARACION FIE 4'   = se_aclaracionFie4   --CC225 JMA
                        from cobis..cl_subactividad_ec,
                             cobis..cl_tabla a,
                             cobis..cl_catalogo b
                        where se_codigo = b.codigo
                        and a.tabla = 'cl_subactividad_ec'
                        and a.codigo = b.tabla
                        and se_codActEc=@i_codActEc
                        and   se_estado='V'
                        and se_codigo > @i_ult_sec
                        order by se_codigo

                set rowcount 0

                return 0

        end
        
        if (@i_operacion = 'A')
        begin
                set rowcount 20
                if @i_modo = 0
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'ESTADO'           = se_estado
                        from cobis..cl_subactividad_ec
                        where se_estado='V'
                        order by se_codigo

                if @i_modo = 1
                        select  'CODIGO'           = se_codigo,
                                'DESCRIPCION'      = se_descripcion,
                                'ESTADO'           = se_estado
                        from cobis..cl_subactividad_ec
                        where (se_codigo > @i_codigo or @i_codigo is null)
                        and se_estado='V'
                        order by se_codigo

                set rowcount 0

                return 0

        end
        
        if (@i_operacion = 'V')
        begin
                select  se_descripcion
                  from  cobis..cl_subactividad_ec,
                        cobis..cl_tabla a,
                        cobis..cl_catalogo b
                where   se_codigo = b.codigo
                  and   a.tabla = 'cl_subactividad_ec'
                  and   a.codigo = b.tabla
                  and   se_codigo = @i_codigo
                  and   se_codActEc=@i_codActEc
                  and   se_estado='V'    
                if @@rowcount = 0
                begin
                   exec sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 101001
                   return 1 
                end
                return 0

        end
        
        /*Dado una subactividad y sector, busca detalle*/
        if (@i_operacion = 'W')
        begin
                select  'CODIGO'              = c.se_codigo,
                        'DESCRIPCION'         = c.se_descripcion,
                        'COD. ACTIVIDAD. ECO.'   = c.se_codActEc,
                        'ACTIVIDAD. ECO.' = d.ac_descripcion,
                        'ESTADO'              = c.se_estado,
                        'COD. CAEGGE'         = c.se_codCaedge,
                        'ACLARACION FIE'      = c.se_aclaracionFie,
                        'COD.SUBSECTOR ECO.'  = e.se_codigo,
                        'SUBSECTOR ECO.' = e.se_descripcion,
                        'COD. SECTOR ECO.'     = f.se_codigo,
						'ACLARACION FIE 2'   = se_aclaracionFie2,  --CC225 JMA
						'ACLARACION FIE 3'   = se_aclaracionFie3,  --CC225 JMA
						'ACLARACION FIE 4'   = se_aclaracionFie4   --CC225 JMA
                from cobis..cl_subactividad_ec c,cl_actividad_ec d,cl_subsector_ec e, cl_sector_economico f,
                     cobis..cl_tabla a,
                     cobis..cl_catalogo b
                where  f.se_codigo = @i_codSector
                and e.se_codSector = f.se_codigo
                and e.se_codigo    = d.ac_codSubsector
                and d.ac_codigo    = c.se_codActEc
                and c.se_codigo    = @i_codigo
                and c.se_codigo    = b.codigo
                and a.tabla        = 'cl_subactividad_ec'
                and a.codigo       = b.tabla
                and c.se_estado    = 'V'    
                if @@rowcount = 0
                begin
                   exec sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 101001
                   return 1 
                end
                return 0

        end
        
        
        --Dado un sector ec. o sector y subsector busca subactividades ec.
        if (@i_operacion = 'Z')
        begin
           if @i_descripcion = 'S'
           begin
            select @i_descripcion = @i_valor,
                   @i_valor = null
           end 
		   --INC 60799
           if @i_descripcion = 'F'
           begin
            select @i_descripcion = null
           end 
		   
           set rowcount 3 --Inc64812
           if @i_modo = 0
           begin                
                   select  'CODIGO'           = c.se_codigo,
                           'DESCRIPCION'        = c.se_descripcion,
                           'COD. ACTIVIDAD ECO.'= c.se_codActEc,
                           'ACTIVIDAD ECO.'= d.ac_descripcion,
                           'ESTADO'           = c.se_estado,
                           'COD. CAEGGE'      = c.se_codCaedge,
                           'ACLARACION FIE'        = c.se_aclaracionFie,
                           'COD. SUBSECTOR ECO.'   = e.se_codigo,
                           'SUBSECTOR ECO.'  = e.se_descripcion,
                           'COD. SECTOR ECO.'      = f.se_codigo,
						   'ACLARACION FIE 2'   = se_aclaracionFie2,  --CC225 JMA
						   'ACLARACION FIE 3'   = se_aclaracionFie3,  --CC225 JMA
						   'ACLARACION FIE 4'   = se_aclaracionFie4   --CC225 JMA
                   from cobis..cl_subactividad_ec c,cl_actividad_ec d,cl_subsector_ec e, cl_sector_economico f,
                        cobis..cl_tabla a,
                        cobis..cl_catalogo b
                   where  f.se_codigo = @i_codSector
                   and (@i_codSubSector is null or e.se_codigo = @i_codSubSector)
                   and (@i_codActEc is null or d.ac_codigo = @i_codActEc)
                   and e.se_codSector = f.se_codigo
                   and e.se_codigo    = d.ac_codSubsector
                   and d.ac_codigo    = c.se_codActEc
                   and (@i_valor is null or (upper(c.se_aclaracionFie) like @i_valor or 
				                            upper(se_aclaracionFie2) like @i_valor or
											upper(se_aclaracionFie3) like @i_valor or
											upper(se_aclaracionFie4) like @i_valor))
                   and (@i_descripcion is null or upper(c.se_descripcion) like @i_descripcion)
                   and c.se_codigo = b.codigo
                   and a.tabla = 'cl_subactividad_ec'
                   and a.codigo = b.tabla
                   and c.se_estado='V'
                   order by c.se_codigo
                   
                   if @@rowcount = 0
                   begin
                      exec sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 151172
                       /* No existen registros */
                      return 1 
                   end
           end
           if @i_modo = 1
           begin                   
                   select  'CODIGO'           = c.se_codigo,
                           'DESCRIPCION'      = c.se_descripcion,
                           'COD. ACTIVIDAD ECO.'= c.se_codActEc,
                           'ACTIVIDAD ECO.'= d.ac_descripcion,
                           'ESTADO'           = c.se_estado,
                           'COD. CAEGGE'      = c.se_codCaedge,
                           'ACLARACION FIE'   = c.se_aclaracionFie,
                           'COD. SUBSECTOR ECO.'   = e.se_codigo,
                           'SUBSECTOR ECO'  = e.se_descripcion,
                           'COD SECTOR ECO.'      = f.se_codigo,
						   'ACLARACION FIE 2'   = se_aclaracionFie2,  --CC225 JMA
						   'ACLARACION FIE 3'   = se_aclaracionFie3,  --CC225 JMA
						   'ACLARACION FIE 4'   = se_aclaracionFie4   --CC225 JMA
                   from cobis..cl_subactividad_ec c,cl_actividad_ec d,cl_subsector_ec e, cl_sector_economico f,
                        cobis..cl_tabla a,
                        cobis..cl_catalogo b
                   where  f.se_codigo = @i_codSector
                   and (@i_codSubSector is null or e.se_codigo = @i_codSubSector)
                   and (@i_codActEc is null or d.ac_codigo = @i_codActEc)
                   and e.se_codSector = f.se_codigo
                   and e.se_codigo    = d.ac_codSubsector
                   and d.ac_codigo    = c.se_codActEc
                   --and (@i_valor = null or c.se_aclaracionFie like @i_valor)
                   --and (@i_descripcion = null or c.se_descripcion like @i_descripcion)
				   --and (@i_valor = null or c.se_descripcion like @i_valor)
                   --and (@i_descripcion = null or e.se_codigo like @i_descripcion)
					and (@i_valor is null or (upper(c.se_aclaracionFie) like @i_valor or --Inc64812
				                            upper(se_aclaracionFie2) like @i_valor or
											upper(se_aclaracionFie3) like @i_valor or
											upper(se_aclaracionFie4) like @i_valor))
                   and (@i_descripcion is null or (upper(c.se_descripcion) like @i_descripcion or
				   				                  upper(se_aclaracionFie2) like @i_descripcion or
												  upper(se_aclaracionFie3) like @i_descripcion or
											      upper(se_aclaracionFie4) like @i_descripcion))
                   and c.se_codigo = b.codigo
                   and a.tabla = 'cl_subactividad_ec'
                   and a.codigo = b.tabla
                   and c.se_estado='V'
                   and c.se_codigo > @i_ult_sec
                   order by c.se_codigo
                   
                   if @@rowcount = 0
                   begin
                      exec sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 141036
                       /* No existen registros */
                      return 1 
                   end
           end
           set rowcount 0

           return 0

        end
           
        
        if @i_operacion = 'I'
        begin

                if @i_codigo is null
                begin
                       -- El codigo de catalogo no puede ser nulo
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101102 

                        return 1
                end
                        

                if exists(select 1 from cl_subactividad_ec where se_codigo = @i_codigo)
                begin
                        -- El codigo para esta tabla ya existe 
                        exec sp_cerror 
                             @t_debug= @t_debug, 
                             @t_file = @t_file,
                             @t_from = @w_sp_name,
                             @i_num  = 101104

                        return 1                        
                end

                -- Verificar que se ingrese una descripcion 
                if @i_descripcion is null
                begin
                        --No existe descripcion 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101103 
                        return 1
                end

                -- Verificar que se ingrese Actividad Economica
                if @i_codActEc is null
                begin
                        -- No existe Actividad Economica 
                        exec sp_cerror 
                                @t_debug= @t_debug, 
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101027 
                        return 1
                end

                begin tran
                        insert into cobis..cl_subactividad_ec(
                                se_codigo, se_descripcion, se_codActEc, se_estado,se_codCaedge,se_aclaracionFie, se_aclaracionFie2, se_aclaracionFie3,se_aclaracionFie4)  --CC225 JMA
                        values (@i_codigo, @i_descripcion, @i_codActEc, @i_estado,@i_codCaedge,@i_aclaracionFie,@i_aclaracionFie2, @i_aclaracionFie3, @i_aclaracionFie4)  --CC225 JMA
                        if @@error <> 0
                        begin
                                -- Error en creacion de subacatividad ecoómica 
                                exec sp_cerror 
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 107294
                                return 1
                        end
                        
                        -- inserta en el catalogo 
                        if exists (select 1 from cl_tabla where tabla = 'cl_subactividad_ec') --MNU 2012.11.10 Catálogo Segmento Cliente
                        begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_subactividad_ec'
                        
                           insert into cl_catalogo (tabla, codigo, valor, estado)
                           values (@w_tabla, @i_codigo, @i_descripcion, @i_estado)
                        
                           --  Error en insercion  
                           if @@error <> 0
                           begin
                           exec cobis..sp_cerror
                                @t_debug= @t_debug,
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 103015      
                            return 1
                           end
                        end
                        
                        
          
                commit tran

                return 0
          end


        -- Update 
        if @i_operacion = 'U'
        begin
                begin tran
                        update cobis..cl_subactividad_ec
                        set se_descripcion   = @i_descripcion,
                            se_estado        = @i_estado,
                            se_codActEc      = @i_codActEc,
                            se_codCaedge     = @i_codCaedge,
                            se_aclaracionFie = @i_aclaracionFie,
                            se_aclaracionFie2 = @i_aclaracionFie2,  --CC225 JMA
							se_aclaracionFie3 = @i_aclaracionFie3,  --CC225 JMA
							se_aclaracionFie4 = @i_aclaracionFie4   --CC225 JMA
                        where se_codigo = @i_codigo

                         if @@error <> 0
                         begin
                                -- 'Error en actualizacion de catalogo'
                                exec sp_cerror
                                        @t_debug        = @t_debug,
                                        @t_file         = @t_file,
                                        @t_from         = @w_sp_name,
                                        @i_num          = 107295
                                return 1
                         end
                         
                         -- actualizar en catalago 
                        if exists (select 1 from cl_tabla where tabla = 'cl_subactividad_ec') --MNU 2012.11.10 Catálogo Segmento Cliente
                           begin
                           select @w_tabla = codigo
                                             from cl_tabla
                                             where tabla = 'cl_subactividad_ec'
                        
                           if exists (select 1 from cl_catalogo where tabla = @w_tabla and codigo = @i_codigo)
                           begin
                               update cl_catalogo
                               set valor  = @i_descripcion,
                                   estado = @i_estado
                               where tabla = @w_tabla 
                               and codigo  = @i_codigo
                        
                               if @@error <> 0
                               begin
                                  exec cobis..sp_cerror 
                                   @t_debug= @t_debug,
                                   @t_file = @t_file,
                                   @t_from = @w_sp_name,
                                   @i_num  = 105000  
                                  return 1
                               end
                           end
                        end
                         
                         
                  commit tran

                  return 0
        end
end -- Fin (@i_tabla_catalogo = 'cl_sector_economico')

----------------------------------------------------------------------------------------------------
--CONSULTA DE PAIS Y PROVINCIA
----------------------------------------------------------------------------------------------------
if (@i_tabla_catalogo = 'cl_depart_pais')
begin
   if (@i_operacion = 'Q')
   begin
      set rowcount 20
      if @i_modo = 0    
         select  'Codigo'      = dp_departamento,
                 'Descripcion' = dp_descripcion
           from cobis..cl_depart_pais,
                cobis..cl_tabla a,
                cobis..cl_catalogo b
          where dp_departamento = b.codigo
            and a.tabla   = 'cl_depart_pais'
            and a.codigo  = b.tabla
			and (@i_valor is null or dp_descripcion like @i_valor)
            and dp_pais   = @i_pais
            and dp_estado = 'V'
            order by dp_mnemonico

      if @i_modo = 1
         select  'Codigo'      = dp_departamento,
                 'Descripcion' = dp_descripcion                                
         from cobis..cl_depart_pais,
              cobis..cl_tabla a,
              cobis..cl_catalogo b
        where dp_departamento = b.codigo
          and a.tabla = 'cl_depart_pais'
          and a.codigo = b.tabla
		  and (@i_valor is null or dp_descripcion like @i_valor)
          and dp_pais = @i_pais
          and dp_estado = 'V'
          and dp_mnemonico > @i_ult_sec
          order by dp_mnemonico         
       set rowcount 0
       return 0
   end
   if (@i_operacion = 'V')
   begin
        select dp_descripcion
          from cobis..cl_depart_pais,
               cobis..cl_tabla a,
               cobis..cl_catalogo b
         where dp_departamento = b.codigo
           and a.tabla = 'cl_depart_pais'
           and a.codigo = b.tabla
           and dp_departamento = @i_codigo
           and dp_pais = @i_pais
           and dp_estado='V'    
        if @@rowcount = 0
        begin
           exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 101001
           return 1 
        end       
        return 0
   end
end

go
--sp_procxmode 'dbo.sp_mantenimiento_catalogo', 'Unchained'

