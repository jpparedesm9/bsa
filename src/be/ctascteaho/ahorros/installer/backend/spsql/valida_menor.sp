use cob_ahorros
go

/***********************************************************************/
/* ARCHIVO:         valida_menor.sp                                    */
/* NOMBRE LOGICO:   sp_valida_menor                                    */
/* PRODUCTO:        CUENTAS DE AHORROS                                 */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/* Esta aplicacion es parte de los paquetes bancarios propiedad        */
/* de COBISCorp.                                                       */
/* Su uso no    autorizado queda  expresamente   prohibido asi como    */
/* cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/* usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/* Este programa esta protegido por la ley de   derechos de autor      */
/* y por las    convenciones  internacionales   de  propiedad inte-    */
/* lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/* obtener ordenes  de secuestro o  retencion y para  perseguir        */
/* penalmente a los autores de cualquier   infraccion.                 */
/***********************************************************************/
/*                          PROPOSITO                                  */
/* Este stored procedure permite validar que un cliente menor          */
/* de edad tenga rol de Titular o Cotitular con firma autorizada       */
/* de un mayor de edad                                                 */
/* Tambien valida el caso en que si un propietario es extranjero       */
/* debe primero hacerse una solictud                                   */
/***********************************************************************/
/*                      MODIFICACIONES                                 */
/* FECHA         AUTOR            RAZON                                */
/* 16/may/05     D.Villagomez     Emision Inicial                      */
/* 08/Jul/06     P.Coello R.      Comentar envio de mensaje            */
/*                                de menor de edad                     */
/* 02/May/2016   Walther Toledo   Migración a CEN                      */
/* 15/Jul/2016   Jorge Salazar    Manejo de Cuentas Menor de Edad      */
/***********************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_valida_menor')
  drop proc sp_valida_menor
go

create proc sp_valida_menor
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_opcion       smallint = 0,-- 0 menor 1 extranjero
  @i_producto     smallint = 3,-- 3 Corrientes 4 ahorros
  @i_retorna      smallint = 0,-- Flag de Retorno de Datos Tutor
  @i_numsol       int = null,-- para opcion 1 nro de solicitud
  @i_param1       varchar(255) = null,-- PARAMETRO TITULAR 1 ejemplo '4@T@gaby@'
  @i_param2       varchar(255) = null,-- PARAMETRO TITULAR 2
  @i_param3       varchar(255) = null,-- PARAMETRO TITULAR 3
  @i_param4       varchar(255) = null,-- PARAMETRO TITULAR 4
  @i_param5       varchar(255) = null,-- PARAMETRO TITULAR 5
  @i_param6       varchar(255) = null,-- PARAMETRO TITULAR 6
  @i_param7       varchar(255) = null,-- PARAMETRO TITULAR 7
  @i_param8       varchar(255) = null,-- PARAMETRO TITULAR 8
  @i_param9       varchar(255) = null,-- PARAMETRO TITULAR 9
  @i_param10      varchar(255) = null,-- PARAMETRO TITULAR 10
  @i_param11      varchar(255) = null,-- PARAMETRO TITULAR 11
  @i_param12      varchar(255) = null,-- PARAMETRO TITULAR 12
  @i_param13      varchar(255) = null,-- PARAMETRO TITULAR 13
  @i_param14      varchar(255) = null,-- PARAMETRO TITULAR 14
  @i_param15      varchar(255) = null,-- PARAMETRO TITULAR 15
  @i_param16      varchar(255) = null,-- PARAMETRO TITULAR 16
  @i_param17      varchar(255) = null,-- PARAMETRO TITULAR 17
  @i_param18      varchar(255) = null,-- PARAMETRO TITULAR 18
  @i_param19      varchar(255) = null,-- PARAMETRO TITULAR 19
  @i_param20      varchar(255) = null,-- PARAMETRO TITULAR 20
  @i_prod_banc    smallint     = null,-- PRODUCTO BANCARIO
  @i_mon          tinyint      = null -- MONEDA
)
as
  -- DECLARACION DE VARIABLES DE USO INTERNO
  declare
    @w_return            int,-- VALOR RETORNO SPS
    @w_sp_name           varchar(32),-- NOMBRE DEL STORED PROCEDURE
    @w_cont              tinyint,-- CONTADOR NUMERO DE REGISTROS
    @w_cadena            varchar(255),-- REGISTRO DE PROCESO
    @w_parametro         tinyint,-- CONTADOR NUMERO DE CAMPOS
    @w_posicion          smallint,-- POSICION DEL SEPARADOR
    @w_token             varchar(255),-- CAMPO DE PROCESO
    @w_codcliente        int,-- CODIGO DE CLIENTE A EVALUAR
    @w_rol               varchar(1),-- ROL DE CLIENTE A EVALUAR
    @w_nombre            varchar(255),-- NOMBRE DE CLIENTE A EVALUAR
    @w_msg               varchar(132),-- MENSAJE PARA ERROR
    @w_existe_menor      varchar(1),-- SI HAY UN MENOR DE EDAD
    @w_existe_firma      varchar(1),-- SI HAY UNA FIRMA AUTORIZADA
    @w_es_menor          varchar(1),-- EVALUAR SI ES MENOR DE EDAD
    @w_fecha_hoy         datetime,
    @w_fecha_nac         datetime,
    @w_tipo_ente         char(1),
    @w_mayor_edad        tinyint,
    @w_dia_hoy           smallint,
    @w_num_anios         tinyint,
    @w_mes_hoy           tinyint,
    @w_mes_nac           tinyint,
    @w_dia_nac           tinyint,
    @w_nombre_menor      varchar(255),
    @w_en_tipo_ced       char(2),
    @w_es_extranjero     char(1),
    @w_existe_extranjero char(1),
    @w_tipo_cedula       varchar(2),
    @w_tipo_ced_emp      varchar(2),
    @w_estado_sol        char(2),
    @w_cod_rel           int,
    @w_cod_tutor         int,
    @w_cltint            varchar(10),
    @w_valor_udis        float, --JSA VALOR PARAMETRO UDIS
    @w_me_mercado        smallint,
    @w_rango_ini         smallint,
    @w_rango_fin         smallint,
    @w_cod_rango_edad    smallint,
    @w_cod_pcame         int,
    @w_cod_pcaaso        int,
    @w_subtipo           char(1),
    @w_sucursal          smallint,
    @w_producto          tinyint

  -- ASIGNAR EL NOMBRE DEL STORED PROCEDURE
  select
    @w_sp_name = 'sp_valida_menor'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @t_trn <> 350
  begin
    -- TIPO DE TRANSACCION NO CORRESPONDE
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2902500
    return 1
  end
  if @i_opcion = 0
  begin
    -- LEE PARAMETROS
    select
      @w_mayor_edad = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'MDE'

    if @@rowcount <> 1
    begin /* Error en lectura de SSN */
      exec cobis..sp_cerror
        @i_num = 111020,
        @i_msg = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
      return 111020
    end

    -- LEE PARAMETRO CODIGO RELACION TUTOR
    select
      @w_cod_rel = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'RELAT'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111040,
        @i_msg = 'ERROR EN PARAMETRO CODIGO RELACION'
      return 111040
    end
	
    --II JSA PARAMETROS PARA CUENTAS MENOR EDAD
	select
      @w_valor_udis = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'UDIS'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111021,
        @i_msg = 'ERROR EN PARAMETRO VALOR UDIS'
      return 111021
    end

	select
      @w_cod_pcame = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PCAME'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111022,
        @i_msg = 'ERROR EN PARAMETRO PRODUCTO PCAME'
      return 111022
    end

	select
      @w_cod_pcaaso = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PCAASO'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111023,
        @i_msg = 'ERROR EN PARAMETRO PRODUCTO PCAASO'
      return 111023
    end
    --II JSA PARAMETROS PARA CUENTAS MENOR EDAD


    select
      @w_fecha_hoy = convert(varchar(10), @s_date, 101)
    select
      @w_existe_menor = 'N',
      @w_existe_firma = 'N'
  end
  if @i_opcion = 1
  begin
    -- LEE PARAMETROS
    select
      @w_tipo_cedula = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
       and pa_nemonico = 'CEDU'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111020,
        @i_msg = 'ERROR EN PARAMETRO CODIGO TIPO CEDULA'
      return 111020
    end

    select
      @w_tipo_ced_emp = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
       and pa_nemonico = 'CEMP'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 111020,
        @i_msg = 'ERROR EN PARAMETRO CODIGO TIPO CEDULA'
      return 111020
    end

	select
      @w_cltint = 'BM'
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'CLIENT'

    if @w_cltint is null
      select
        @w_cltint = ''

    select
      @w_existe_extranjero = 'N'
  end

  -- INICIALIZAR CONTADOR
  select
    @w_cont = 1

  -- LAZO PARA PROCESO DE REGISTROS
  while @w_cont <= 20
  begin
    -- PROCESAR CADA UNO DE LOS PARAMETROS
    if @w_cont = 1
      select
        @w_cadena = @i_param1
    else if @w_cont = 2
      select
        @w_cadena = @i_param2
    else if @w_cont = 3
      select
        @w_cadena = @i_param3
    else if @w_cont = 4
      select
        @w_cadena = @i_param4
    else if @w_cont = 5
      select
        @w_cadena = @i_param5
    else if @w_cont = 6
      select
        @w_cadena = @i_param6
    else if @w_cont = 7
      select
        @w_cadena = @i_param7
    else if @w_cont = 8
      select
        @w_cadena = @i_param8
    else if @w_cont = 9
      select
        @w_cadena = @i_param9
    else if @w_cont = 10
      select
        @w_cadena = @i_param10
    else if @w_cont = 11
      select
        @w_cadena = @i_param11
    else if @w_cont = 12
      select
        @w_cadena = @i_param12
    else if @w_cont = 13
      select
        @w_cadena = @i_param13
    else if @w_cont = 14
      select
        @w_cadena = @i_param14
    else if @w_cont = 15
      select
        @w_cadena = @i_param15
    else if @w_cont = 16
      select
        @w_cadena = @i_param16
    else if @w_cont = 17
      select
        @w_cadena = @i_param17
    else if @w_cont = 18
      select
        @w_cadena = @i_param18
    else if @w_cont = 19
      select
        @w_cadena = @i_param19
    else if @w_cont = 20
      select
        @w_cadena = @i_param20

    if @i_opcion = 0
    begin
      select
        @w_es_menor = 'N'
    end

    if @i_opcion = 1
    begin
      select
        @w_es_extranjero = 'N'
    end

    -- SI LA CADENA ES NO NULA PROCESAR
    if @w_cadena is not null
    begin
      select
        @w_parametro = 0
      while @w_parametro < 3
      begin
        select
          @w_parametro = @w_parametro + 1
        select
          @w_posicion = charindex('@',
                                  @w_cadena)
        select
          @w_token = substring(@w_cadena,
                               1,
                               @w_posicion - 1)
        -- OBTENER CAMPOS DE CADA PARAMETRO
        if @w_parametro = 1
          select
            @w_codcliente = convert (int, @w_token)
        if @w_parametro = 2
          select
            @w_rol = @w_token
        if @w_parametro = 3
          select
            @w_nombre = @w_token

        select
          @w_cadena = substring(@w_cadena,
                                @w_posicion + 1,
                                datalength(@w_cadena))
      end -- FIN DEL WHILE -NUMERO DE CAMPOS A PROCESAR

      -- VALIDACION DE QUE EL CLIENTE ES MENOR DE EDAD
      select
        @w_fecha_nac = p_fecha_nac,
        @w_tipo_ente = en_subtipo,
        @w_en_tipo_ced = en_tipo_ced
      from   cobis..cl_ente
      where  en_ente = @w_codcliente

      if @@rowcount = 0
      begin
        -- TIPO DE TRANSACCION NO CORRESPONDE
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 2902500,
          @i_msg   = 'NO SE PUDO DETERMINAR INFORMACION EN CL_ENTE'
        return 1
      end

      if @i_opcion = 0
      begin
        if @w_tipo_ente = 'P'
        begin -- 1
          --print 'valida'
          --print '@w_mayor_edad %1!',@w_mayor_edad

          select
            @w_dia_hoy = datepart(dd,
                                  @w_fecha_hoy)
          -- Valida la mayoria de edad

          select
            @w_num_anios = datediff(yy,
                                    @w_fecha_nac,
                                    @w_fecha_hoy)

          --print '@w_num_anios %1!',@w_num_anios

          if @w_num_anios < @w_mayor_edad
          begin
            select
              @w_es_menor = 'S'
          end
          else
          begin -- 2
            if @w_num_anios = @w_mayor_edad
            begin -- 3
              --print 'igual anos'
              select
                @w_mes_hoy = datepart(mm,
                                      @w_fecha_hoy)
              select
                @w_mes_nac = datepart(mm,
                                      @w_fecha_nac)
              if @w_mes_hoy < @w_mes_nac
              begin
                -- print 'mes menor'
                select
                  @w_es_menor = 'S'
              end
              else
              begin -- 4
                if @w_mes_hoy = @w_mes_nac
                begin
                  select
                    @w_dia_nac = datepart(dd,
                                          @w_fecha_nac)
                  if @w_dia_hoy < @w_dia_nac
                  begin
                    select
                      @w_es_menor = 'S'
                  end
                end
              end -- 4
            end -- 3
          end -- 2
        end -- 1
        else
          select
            @w_es_menor = 'N' -- cuando es compania el ente

        if @w_es_menor = 'S'
        begin
          if @w_rol = 'F'
              or @w_rol = 'U'
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 2902500,
              @i_msg   = 'FIRMA AUTORIZADA/TUTOR NO PUEDE SER DE MENOR DE EDAD'
            return 1
          end
          else
          begin
            if @w_existe_menor = 'N'
              select
                @w_existe_menor = 'S',
                @w_nombre_menor = @w_nombre
          end
        end
        else -- NO ES MENOR DE EDAD
        begin
          if @w_rol = 'F'
          begin
            if @w_existe_firma = 'N'
            begin
              select
                @w_existe_firma = 'S'
            end
          end
        end
        --II JSA VALIDACIONES CUENTAS MENOR EDAD
    	if @w_rol in ('T','C') and @i_prod_banc is not null
		   and @w_tipo_ente = 'P'
		   --and @w_es_menor = 'S'
    	begin
           --Obtener codigo de mercado por producto bancario y tipo de cliente
    	   select
             @w_me_mercado = me_mercado
             from cob_remesas..pe_mercado
            where me_pro_bancario = @i_prod_banc
              and me_tipo_ente    = @w_tipo_ente
              and me_estado       = 'V'
    	
           if @@rowcount = 0
            begin
              exec cobis..sp_cerror
                @i_num = 111043,
                @i_msg = 'NO EXISTE MERCADO PARA EL PRODUCTO FINAL Y TIPO DE CLIENTE'
              return 111043
            end
    
           select @w_subtipo = isnull(of_subtipo, 'O')
             from cobis..cl_oficina
            where of_oficina = @s_ofi
    
           if @@rowcount = 0
            begin
              exec cobis..sp_cerror
                @i_num = 111044,
                @i_msg = 'NO EXISTE SUBTIPO DE LA OFICINA'
              return 111044
            end
    
    	   if @w_subtipo = 'O'
              select @w_sucursal = isnull(of_regional, @s_ofi)
                from cobis..cl_oficina
               where of_oficina = @s_ofi
           else
              select @w_sucursal = @s_ofi
    	   
           select @w_producto = pd_producto 
             from cobis..cl_producto 
            where pd_abreviatura = 'AHO'
    		
           if @@rowcount = 0
            begin
              exec cobis..sp_cerror
                @i_num = 111045,
                @i_msg = 'NO EXISTE EL PRODUCTO'
              return 111045
            end
    	   
    	   --Obtener codigo de rango del producto final por mercado
           select
             @w_cod_rango_edad = pf_cod_rango_edad
             from cob_remesas..pe_pro_final
            where pf_mercado  = @w_me_mercado
              and pf_moneda   = @i_mon
              and pf_producto = @w_producto
              and pf_sucursal = @w_sucursal 
    	
           if @w_cod_rango_edad is not null
           begin
           --Obtener valores del rango del producto final
             select
                @w_rango_ini = re_rango_ini,
                @w_rango_fin = re_rango_fin
               from cob_remesas..pe_pro_rango_edad
              where re_codigo  = @w_cod_rango_edad
                and @w_num_anios between re_rango_ini and re_rango_fin
    	
             if @@rowcount = 0
             begin
               exec cobis..sp_cerror
                 @i_num = 111046,
                 @i_msg = 'EDAD DEL(LOS) TITULAR(ES) ESTA FUERA DE RANGO DEL PRODUCTO BANCARIO'
               return 111046
             end		  
           end
    	end

    	if @w_existe_menor = 'S'
           and @w_existe_firma = 'N'
           and @w_rol = 'T'
        begin	  
    	  /* VALIDA QUE EL MENOR TENGA TUTOR */
          select
            @w_cod_tutor = in_ente_d
          from   cobis..cl_instancia
          where  in_relacion = @w_cod_rel
             and in_ente_i   = @w_codcliente
             and in_lado     = 'D'

    	  if @@rowcount <> 1
          begin            
             if @i_prod_banc = @w_cod_pcame
             begin
    		   select @w_msg = 'EL MENOR NO TIENE UN TUTOR ASOCIADO, SU SALDO MAXIMO DEBE SER DE ' + cast(@w_valor_udis as varchar) + ' UDIS'
    		   select @w_msg
             end
          end
          --else
    	  --begin
          --    if @i_prod_banc = @w_cod_pcame
          --    begin
          --      if not exists(select
          --                      1
          --                      from cobis..cl_cliente,
          --                           cobis..cl_det_producto
          --                     where cl_det_producto = dp_det_producto
          --                       and cl_rol in ('T', 'C')
          --                       and cl_cliente    = @w_cod_tutor
          --                       and dp_producto   = 4
          --                       and dp_estado_ser = 'V'
          --                       and dp_cuenta in
          --                                    (select
          --                                       ah_cta_banco
          --                                       from cob_ahorros..ah_cuenta
          --                                      where ah_estado in ('A')--('A', 'I')
          --                                        and ah_prod_banc = @w_cod_pcaaso))
          --      begin
          --         exec cobis..sp_cerror
          --           @i_num = 111047,
          --           @i_msg = 'EL TUTOR ASOCIADO NO TIENE UNA CUENTA DE APORTE SOCIAL ORDINARIA ACTIVA'
          --         return 111047
          --      end
          --    end
          --end
        end		  
		--FI JSA VALIDACIONES CUENTAS MENOR EDAD    

	  end-- fin opcion cero

      if @i_opcion = 1
      begin
        if @w_tipo_ente = 'P'
        begin
          -- SI ES CEDULA ES NACIONAL CUALQUIER OTRO TIPO INDICA QUE ES EXTRANJERO
          if @w_tipo_cedula = @w_en_tipo_ced
          begin
            select
              @w_es_extranjero = 'S',
              @w_existe_extranjero = 'S'
          end
          else
            select
              @w_es_extranjero = 'N'
        end

        if @w_tipo_ente = 'C'
        begin
          -- SI ES COMPANIA Y EL DOCUMENTO ES (SE) SOCIEDAD EXTRANJERO  DE LO CONTRARIO ES NACIONAL.
          if @w_tipo_ced_emp = @w_en_tipo_ced
          begin
            select
              @w_es_extranjero = 'S',
              @w_existe_extranjero = 'S'
          end
          else
            select
              @w_es_extranjero = 'N'

        end
      end

    end -- FIN DEL IF -CADENA NO NULA
    else
    begin
      --  SE LLEVA EL CONTADOR AL FINAL
      select
        @w_cont = 20
    end
    -- ACTUALIZAR CONTADOR
    select
      @w_cont = @w_cont + 1
  end -- FIN DEL WHILE -NUMERO DE PARAMETOS A PROCESAR

  if @i_opcion = 0
  begin
	if @w_existe_menor = 'S'
       and @w_existe_firma = 'N'
       and @w_rol = 'T'
    begin	  
	  /* VALIDA QUE EL MENOR TENGA TUTOR */
      select
        @w_cod_tutor = in_ente_d
      from   cobis..cl_instancia
      where  in_relacion = @w_cod_rel
         and in_ente_i   = @w_codcliente
         and in_lado     = 'D'

      --if @@rowcount <> 1
      --begin
        -- exec cobis..sp_cerror
          -- @i_num = 111041,
          -- @i_msg = 'EL MENOR NO TIENE UN TUTOR ASOCIADO, VERIFICAR RELACION'
        -- return 111041
      --end
      --else
	  if @@rowcount = 1
	  begin
        if @i_retorna = 1
        begin
          select
            'Cod.' = en_ente,
            'D.I.' = en_ced_ruc,
            'Tipo' = en_subtipo,
            'Nombre' = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
          from   cobis..cl_ente
          where  en_ente = @w_cod_tutor

          if @@rowcount = 0
          begin
            exec cobis..sp_cerror
              @i_num = 111042,
              @i_msg = 'NO EXISTE INFORMACION PARA EL TUTOR RELACIONADO'
            return 111042
          end
        end
      end
    end

    /* SE RETORNA INFORMACION CUANDO UN ADULTO TENGA TUTOR */
    if @w_es_menor = 'N'
       and @w_existe_firma = 'N'
       and @w_rol = 'T'
       and @i_retorna = 1
    begin
      /* VALIDA QUE EL ADULTO TENGA TUTOR */
      select
        @w_cod_tutor = in_ente_d
      from   cobis..cl_instancia
      where  in_relacion = @w_cod_rel
         and in_ente_i   = @w_codcliente
         and in_lado     = 'D'

      if @@rowcount = 1
      begin
        select
          'Cod.' = en_ente,
          'D.I.' = en_ced_ruc,
          'Tipo' = en_subtipo,
          'Nombre' = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
        from   cobis..cl_ente
        where  en_ente = @w_cod_tutor

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @i_num = 111042,
            @i_msg = 'NO EXISTE INFORMACION PARA EL TUTOR RELACIONADO'
          return 111042
        end
      end
    end
  end

  if @i_opcion = 1
  begin
    if @w_cltint = 'BM'
      select
        @w_cltint = @w_cltint
    else
    begin
      if @w_existe_extranjero = 'S'
      begin
        select
          @w_estado_sol = null

        if @i_producto = 3
        begin
          exec cob_interfase..sp_icte_select_cc_sol_cuenta
            @i_numsol     = @i_numsol,
            @o_estado_sol = @w_estado_sol out

        end

        if @i_producto = 4
        begin
          exec cob_interfase..sp_iaho_select_ah_sol_cuenta
            @i_numsol     = @i_numsol,
            @o_estado_sol = @w_estado_sol out
        end

        if @w_estado_sol is null
        begin
          /* El Numero de Solicitud no esta aprobada */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201304
          return 201304
        end
      end
    end
  end

  return 0

go

