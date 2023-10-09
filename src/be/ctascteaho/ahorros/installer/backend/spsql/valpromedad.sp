/************************************************************************/
/*  Archivo:                valpromedad.sp                             */
/*  Stored procedure:       sp_valida_prod_menoredad                    */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Pantalla de Consulta de funcionalidad del producto Menor de Edad.   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA        AUTOR           RAZON                                  */
/*  20/07/2016   Walther Toledo  Migracion a CEN                        */
/************************************************************************/

USE cob_ahorros
GO
if exists (select 1 from sysobjects where name = 'sp_valida_prod_menoredad')
   drop proc sp_valida_prod_menoredad
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_valida_prod_menoredad (
    @s_ssn           int         = null,
    @s_ssn_branch    int         = null,
    @s_srv           varchar(30) = null,
    @s_lsrv          varchar(30) = null,
    @s_user          varchar(30) = null,
    @s_sesn          int         = null,
    @s_term          varchar(10) = null,
    @s_date          datetime    = null,
    @s_ofi           smallint    = null,
    @s_rol           smallint    = 1,
    @s_org_err       char(1)     = null,
    @s_error         int         = null,
    @s_sev           tinyint     = null,
    @s_msg           varchar(64) = null,
    @s_org           char(1)     = null,
    @t_debug         char(1)     = 'N',
    @t_file          varchar(14) = null,
    @t_from          varchar(32) = null,
    @t_rty           char(1)     = 'N',
    @t_show_version  bit         = 0,  
    @t_trn           smallint    = null,
    @i_cta           cuenta      = null,
    @i_oficina       SMALLINT    = null,
    @i_codcliente    int         = 0,
    @i_tipo_trn      varchar(10) = null,
    @i_operacion     char(1)     = 'Q',
    @i_formato_fecha int         = 101
)
as
declare
    @w_sp_name      varchar(30),
    @w_num_libreta  int,
    @w_error        int,
    @w_msg          varchar(40),
    @w_pb_men_ed    int,
    @w_prox_may_ed  int,
    @w_slddis_max   float,
    @w_may_edad     tinyint,
    @w_val_conv_udi money,
    @w_ente         int,
    @w_tipo_per     char(1), --REQ465
    @w_cod_rel      int,
    @w_cod_tutor    int,
    -- var del cursor cuentas_cursor
    @w_NoCuenta     cuenta,   
    @w_Cliente      int,   
    @w_Nombre       varchar(255),   
    @w_NombreTut    varchar(255),   
    @w_fecha_aper    smalldatetime,
    @w_SaldoDispo   money,   
    @w_SaldoConta   money,   
    @w_NomProducto  varchar(30),
    @w_tot_val_udi  float,
    @w_fecha_nac    datetime,
    @w_fecha_proc   datetime,
    @w_fec_prx_nac  datetime,
    @w_fec_may_nac  datetime,
    @w_dif_prx_dias int,
    @w_id_mon_udi   tinyint

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_valida_prod_menoredad'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @t_trn <> 537
  begin
    -- TIPO DE TRANSACCION NO CORRESPONDE
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2902500
    return 1
  end

---- CONSULTA DE PARAMETROS GENERALES NECESARIOS PARA LA CONSULTA
--Parametro de Mayoria de Edad = 18 años
select @w_may_edad = pa_tinyint 
  from cobis..cl_parametro 
 where pa_producto = 'ADM' 
   and pa_nemonico = 'MDE'
if @@rowcount <> 1
begin /* Error en lectura de SSN */
  exec cobis..sp_cerror
    @i_num = 111020,
    @i_msg = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
  return 111020
end   
--Consulta de Param Proximidad Mayoria de Edad (dias)
select @w_prox_may_ed = pa_int
  from cobis..cl_parametro 
 where pa_nemonico = 'PRXMYE' 
   and pa_producto = 'AHO'
if @@rowcount <> 1
begin /* Error en lectura de SSN */
  exec cobis..sp_cerror
    @i_num = 111021,
    @i_msg = 'ERROR EN PARAMETRO DE PROXIMIDAD MAYORIA DE EDAD'
  return 111021
end

--Consulta de ProdBanc Menor de Edad
select @w_pb_men_ed = pa_int
  from cobis..cl_parametro 
 where pa_nemonico = 'PCAME'
   and pa_producto = 'AHO'
if @@rowcount <> 1
begin /* Error en lectura de SSN */
  exec cobis..sp_cerror
    @i_num = 111022,
    @i_msg = 'ERROR EN PARAMETRO PRODUCTO BANCARIO MAYORIA DE EDAD'
  return 111022
end
--Valor de Conversion UDIs
select @w_id_mon_udi = mo_moneda
  from cobis..cl_parametro, cobis..cl_moneda
 where pa_nemonico = 'IUDI' 
   and pa_char = mo_nemonico
   and pa_producto = 'AHO'

select @w_val_conv_udi = ct_factor1 
  FROM cob_conta..cb_cotizacion
 where ct_moneda = @w_id_mon_udi
   and ct_fecha = (select max(ct_fecha)
                      FROM cob_conta..cb_cotizacion
                     where ct_moneda = @w_id_mon_udi)
if @@rowcount <> 1
begin /* Error en lectura de SSN */
  exec cobis..sp_cerror
    @i_num = 111023,
    @i_msg = 'ERROR EN PARAMETRO CONVERSION UDIs'
  return 111023
end 

--Param Saldo Disp Maximo 1500
select @w_slddis_max = pa_float
  from cobis..cl_parametro 
 where pa_nemonico = 'UDIS'
   and pa_producto = 'AHO'
if @@rowcount <> 1
begin /* Error en lectura de SSN */
  exec cobis..sp_cerror
    @i_num = 111024,
    @i_msg = 'ERROR EN PARAMETRO SALDO MAXIMO DISPONIBLE EN UDIs'
  return 111024
end 

-- LEE PARAMETRO CODIGO RELACION TUTOR
select @w_cod_rel = pa_int
  from cobis..cl_parametro
 where pa_producto = 'MIS'
   and pa_nemonico = 'RELAT'
if @@rowcount <> 1
begin
  exec cobis..sp_cerror
    @i_num = 111040,
    @i_msg = 'ERROR EN PARAMETRO CODIGO RELACION'
  return 111040
end

--Inicio de @i_tipo_trn = 'CMEED'
if @i_tipo_trn = 'CMEED'
begin
    if @i_operacion = 'S'
    begin
        if @i_codcliente is null and @i_cta is null and @i_oficina is null
        begin
            print 'No se envio el cliente, la cuenta o la oficina'
            return 1
        end
        
        --Calculo del Valor MAximo UDIs a la Moneda Local
        set @w_tot_val_udi = @w_slddis_max * @w_val_conv_udi
        
        -- Inicio: Crear la tala temporal --
        select
            NoCuenta    = ah_cta_banco,
            Cliente     = en_ente, --ah_cliente
            Nombre      = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            NombreTut   = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            FechaAper   = ah_fecha_aper,
            SaldoDispo  = ah_disponible,
            SaldoConta  = ah_12h +  ah_24h + ah_disponible + ah_48h,
            NomProducto = (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc)
        into #tmp_cuentas_aho
        from cobis..cl_det_producto,
             cobis..cl_cliente,
             cobis..cl_ente,
             cob_ahorros..ah_cuenta a
        where  1 = 2
        -- Fin: Crear la tabla temporal --
       
        --Si no es corresponsal no debe presentar las cuentas de corresponsales   
        insert into #tmp_cuentas_aho
             (NoCuenta,            Cliente,          Nombre,
              FechaAper,           SaldoDispo,       SaldoConta,
              NomProducto              )
              --FechaMayEd
        select
             ah_cta_banco,         en_ente,          en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
             ah_fecha_aper,        ah_disponible,    ah_12h +  ah_24h + ah_disponible + ah_48h,
             (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc)
             --p_fecha_nac
        from cobis..cl_det_producto,
             cobis..cl_cliente,
             cobis..cl_ente,
             cob_ahorros..ah_cuenta a
        where cl_det_producto = dp_det_producto
        and   dp_cuenta       = ah_cta_banco
        and   cl_cliente      = en_ente
        and   ah_prod_banc    = @w_pb_men_ed
        and   dp_producto     = 4 -- AHORROS
        and   cl_cliente      = case @i_codcliente when 0 then cl_cliente else @i_codcliente end
        and  dp_cuenta        = isnull(@i_cta,dp_cuenta)
        and  ah_oficina       = isnull(@i_oficina,ah_oficina)
        and   cl_rol          = 'T'
        and   ah_disponible   > @w_tot_val_udi
        order by ah_cuenta
        if @@rowcount = 0
        begin
            select @w_error = 208158 --258003 -- NO EXISTEN REGISTROS
            select @w_msg = 'NO EXISTEN REGISTROS'

            /* No existen Registros */
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            --@i_num       = 208158,
            @i_num       = @w_error,
            @i_msg       = @w_msg,
            @i_sev       = 0
            return @w_error
        end
        
        --procesar los registros de #tmp_cuentas_aho para 'Verificar Tutor o Padres que no sea socios'       
        select    
            NoCuenta     ,    Cliente      ,    Nombre       ,    NombreTut,
            FechaAper    ,    SaldoDispo   ,    SaldoConta   ,    NomProducto  
        into #tmp_cuentas_menor_edad
        from #tmp_cuentas_aho
        where 1 = 2
        
        declare cuentas_cursor cursor for
        select 
            NoCuenta     ,    Cliente      ,    Nombre       ,    NombreTut,
            FechaAper    ,    SaldoDispo   ,    SaldoConta   ,    NomProducto
        from #tmp_cuentas_aho for read only
        
        open cuentas_cursor
        fetch cuentas_cursor into 
            @w_NoCuenta   ,    @w_Cliente    ,    @w_Nombre     ,    @w_NombreTut,
            @w_fecha_aper  ,    @w_SaldoDispo ,    @w_SaldoConta ,    @w_NomProducto
        
        if @@fetch_status = -1
        begin
            close cuentas_cursor
            deallocate cuentas_cursor
            return 201157
        end
        else if @@fetch_status = -2
        begin
            close cuentas_cursor
            deallocate cuentas_cursor        
            return 0
        end

        while @@fetch_status = 0
        begin
            /* VALIDA QUE EL MENOR TENGA TUTOR */
            select @w_cod_tutor = in_ente_d
              from cobis..cl_instancia
             where in_relacion = @w_cod_rel
               and in_ente_i   = @w_Cliente
               and in_lado     = 'D'

            if @@rowcount >= 1
            begin
                if not exists(  select dp_det_producto 
                                  from cobis..cl_cliente,
                                       cobis..cl_det_producto 
                                 where cl_det_producto = dp_det_producto
                                   and cl_cliente      = @w_cod_tutor
                                   and cl_rol          = 'T')
                begin
                    select @w_NombreTut = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
                      from cobis..cl_ente 
                     where en_ente = @w_cod_tutor
                
                    insert into #tmp_cuentas_menor_edad(
                        NoCuenta     ,    Cliente      ,    Nombre       ,    NombreTut,
                        FechaAper    ,    SaldoDispo   ,    SaldoConta   ,    NomProducto  )
                    values(
                        @w_NoCuenta  ,    @w_Cliente    ,    @w_Nombre     ,    @w_NombreTut,
                        @w_fecha_aper ,   @w_SaldoDispo ,    @w_SaldoConta ,    @w_NomProducto)
                end
            end
            else
            begin
                insert into #tmp_cuentas_menor_edad(
                    NoCuenta     ,    Cliente      ,    Nombre       ,    NombreTut,
                    FechaAper    ,    SaldoDispo   ,    SaldoConta   ,    NomProducto  )
                values(
                    @w_NoCuenta  ,    @w_Cliente    ,    @w_Nombre     ,    'N/A',
                    @w_fecha_aper ,    @w_SaldoDispo ,    @w_SaldoConta ,    @w_NomProducto)
            end

            fetch cuentas_cursor into
                @w_NoCuenta   ,    @w_Cliente    ,    @w_Nombre     ,    @w_NombreTut,
                @w_fecha_aper  ,    @w_SaldoDispo ,    @w_SaldoConta ,    @w_NomProducto
        
        end
        select    
        NoCuenta    as '508948',
        Cliente     as '508953',
        Nombre      as '3881',       
        NombreTut   as '3882',
        convert(varchar(15),FechaAper,@i_formato_fecha)
                    as '1102',
        SaldoDispo  as '1100',
        SaldoConta  as '1101',
        --NomProducto as '508950'
        NomProducto as '503093'
        from #tmp_cuentas_menor_edad

        --print (@@rowcount)
        if @@rowcount = 0
        begin
            select @w_error = 208158 --258003 -- NO EXISTEN REGISTROS
            select @w_msg = 'NO EXISTEN REGISTROS'

            /* No existen Registros */
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            --@i_num       = 208158,
            @i_num       = @w_error,
            @i_msg       = @w_msg,
            @i_sev       = 0
            return @w_error
        end
        set rowcount 0
        drop table #tmp_cuentas_aho
        drop table #tmp_cuentas_menor_edad
    end
end --Fin de @i_tipo_trn = 'CMEED'

--Inicio de @i_tipo_trn = 'PMAED'
if @i_tipo_trn = 'PMAED'
begin
    if @i_operacion = 'S'
    begin
        if @i_codcliente is null and @i_cta is null and @i_oficina is null
        begin
            print 'No se envio el cliente, la cuenta o la oficina'
            return 1
        end

        -- Inicio: Crear la tala temporal --
        select
            NoCuenta    = ah_cta_banco,
            Cliente     = en_ente, --ah_cliente
            Nombre      = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            FechaMayEd  = p_fecha_nac,
            FechaAper   = ah_fecha_aper,
            NombreTut   = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            SaldoDispo  = ah_disponible,
            SaldoConta  = ah_12h +  ah_24h + ah_disponible + ah_48h,
            -- Producto    = ah_prod_banc,            
            NomProducto = (select substring(pb_descripcion,1,30)
                             from cob_remesas..pe_pro_bancario 
                            where pb_pro_bancario = a.ah_prod_banc)
        into #tmp_cuentas_aho_1
        from cobis..cl_det_producto,
             cobis..cl_cliente,
             cobis..cl_ente,
             cob_ahorros..ah_cuenta a
        where  1 = 2
        -- Fin: Crear la tabla temporal --
       
        --Si no es corresponsal no debe presentar las cuentas de corresponsales      
        insert into #tmp_cuentas_aho_1
             (NoCuenta,                 Cliente,                    Nombre,
              FechaMayEd,               FechaAper,                  NombreTut,
              SaldoDispo,               SaldoConta,                 
              NomProducto )
        select
             ah_cta_banco,      en_ente,        en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
             p_fecha_nac,       ah_fecha_aper,  en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,   
             ah_disponible,     ah_12h +  ah_24h + ah_disponible + ah_48h,
             (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc)
        from cobis..cl_det_producto,
             cobis..cl_cliente,
             cobis..cl_ente,
             cob_ahorros..ah_cuenta a
        where cl_det_producto = dp_det_producto
        and   dp_cuenta       = ah_cta_banco
        and   cl_cliente      = en_ente
        and   ah_prod_banc    = @w_pb_men_ed
        and   dp_producto     = 4 -- AHORROS
        and   cl_cliente      = case @i_codcliente when 0 then cl_cliente else @i_codcliente end
        and  dp_cuenta        = isnull(@i_cta,dp_cuenta)
        and  ah_oficina       = isnull(@i_oficina,ah_oficina)
        and  cl_rol          = 'T'
        order by ah_cuenta
        if @@rowcount = 0
        begin
            select @w_error = 208158 --258003 -- NO EXISTEN REGISTROS
            select @w_msg = 'NO EXISTEN REGISTROS'

            /* No existen Registros */
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            --@i_num       = 208158,
            @i_num       = @w_error,
            @i_msg       = @w_msg,
            @i_sev       = 0
            return @w_error
        end

       --procesar los registros de #tmp_cuentas_aho para 'Verificar Tutor o Padres que no sea socios'       
        select
            NoCuenta,                   Cliente,                    Nombre,
            FechaMayEd,                 FechaAper,                  NombreTut,
            SaldoDispo,                 SaldoConta,
            NomProducto
        into #tmp_cuentas_menor_edad_1
        from #tmp_cuentas_aho_1
        where 1 = 2
        
        select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso

        declare cuentas_cursor cursor for
        select 
            NoCuenta,                   Cliente,                    Nombre,
            FechaMayEd,                 FechaAper,                  NombreTut,
            SaldoDispo,                 SaldoConta,
            NomProducto
        from #tmp_cuentas_aho_1 for read only
        
        open cuentas_cursor
        fetch cuentas_cursor into 
            @w_NoCuenta   ,             @w_Cliente    ,             @w_Nombre       ,
            @w_fecha_nac  ,             @w_fecha_aper  ,             @w_NombreTut    ,
            @w_SaldoDispo ,             @w_SaldoConta ,
            @w_NomProducto
        
        if @@fetch_status = -1
        begin
            close cuentas_cursor
            deallocate cuentas_cursor
            return 201157
        end
        else if @@fetch_status = -2
        begin
            close cuentas_cursor
            deallocate cuentas_cursor        
            return 0
        end

        while @@fetch_status = 0
        begin            
            --Fecha de Cumplimiento de MayoriaEdad = Fecha Nac + ParamProximidad(6 dias)
            set @w_fec_prx_nac = dateadd(day,-(@w_prox_may_ed),dateadd(year,@w_may_edad,@w_fecha_nac))
            --Fecha de Mayoria de Edad(18 años)
            set @w_fec_may_nac = dateadd(year,@w_may_edad,@w_fecha_nac)
            --print concat(convert(varchar(15),@w_fec_prx_nac,103),' <= ',convert(varchar(15),@w_fecha_proc,103))
            
            if(@w_fec_prx_nac <= @w_fecha_proc)
            begin
                set @w_fec_prx_nac  = dateadd(year, (year(@w_fecha_proc) - year(@w_fecha_nac)), @w_fecha_nac)
                
                /* VALIDA QUE EL MENOR TENGA TUTOR */
                select @w_cod_tutor = in_ente_d
                  from cobis..cl_instancia
                 where in_relacion = @w_cod_rel
                   and in_ente_i   = @w_Cliente
                   and in_lado     = 'D'            
                if @@rowcount >= 1
                begin
                    if not exists(  select dp_det_producto 
                                      from cobis..cl_cliente,
                                           cobis..cl_det_producto 
                                     where cl_det_producto = dp_det_producto
                                       and cl_cliente      = @w_cod_tutor)
                    begin
                        select @w_NombreTut = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
                          from cobis..cl_ente 
                         where en_ente = @w_cod_tutor
                         
                        insert into #tmp_cuentas_menor_edad_1(
                            NoCuenta,         Cliente,          Nombre,
                            NombreTut,        SaldoDispo,       SaldoConta,
                            NomProducto,      FechaMayEd,       FechaAper)
                        values(
                            @w_NoCuenta   ,   @w_Cliente    ,   @w_Nombre   ,    
                            @w_NombreTut  ,   @w_SaldoDispo ,   @w_SaldoConta ,
                            @w_NomProducto,   @w_fec_may_nac,   @w_fecha_aper
                            )
                    end
                end
                else
                begin
                    insert into #tmp_cuentas_menor_edad_1(
                        NoCuenta,         Cliente,          Nombre,
                        NombreTut,        SaldoDispo,       SaldoConta,
                        NomProducto,      FechaMayEd,       FechaAper)
                    values(
                        @w_NoCuenta   ,   @w_Cliente    ,   @w_Nombre   ,    
                        'N/A'  ,           @w_SaldoDispo ,   @w_SaldoConta ,
                        @w_NomProducto,   @w_fec_may_nac,   @w_fecha_aper
                        )
                end
            end

            fetch cuentas_cursor into 
                    @w_NoCuenta   ,    @w_Cliente    ,    @w_Nombre       ,
                    @w_fecha_nac  ,    @w_fecha_aper ,    @w_NombreTut    ,
                    @w_SaldoDispo ,    @w_SaldoConta ,    @w_NomProducto
        end
        
        select
        NoCuenta    as '508948',
        Cliente     as '508953',
        Nombre      as '3881', 
        convert(varchar(15),FechaMayEd,@i_formato_fecha)
                    as '1103',
        convert(varchar(15),FechaAper,@i_formato_fecha)
                    as '1102',
        NombreTut   as '3882',
        SaldoDispo  as '1100',
        SaldoConta  as '1101',
        NomProducto as '503093'
        from #tmp_cuentas_menor_edad_1
        if @@rowcount = 0
        begin
            --if @i_codcliente is null
            --   select @w_msg = 'CUENTA NO ES DE ESTA OFICINA'
            --else
            --   select @w_msg = 'CLIENTE NO TIENE CUENTA EN ESTA OFICINA'

            select @w_error = 208158 --258003 -- NO EXISTEN REGISTROS
            select @w_msg = 'NO EXISTEN REGISTROS'

            /* No existen Registros */
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            --@i_num       = 208158,
            @i_num       = @w_error,
            @i_msg       = @w_msg,
            @i_sev       = 0
            return @w_error
        end
        set rowcount 0
        drop table #tmp_cuentas_aho_1
        drop table #tmp_cuentas_menor_edad_1
    end
end --Fin de @i_tipo_trn = 'PMAED'

return 0


GO

