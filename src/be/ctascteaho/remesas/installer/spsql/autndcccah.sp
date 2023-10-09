/*******************************************************************/
/*  Archivo:          autndcccah.sp                                */
/*  Stored procedure: sp_tr_autndc_ccah                            */
/*  Base de datos:    cob_remesas                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Permite almacenar las notas de credito y debito de cuentas      */
/* de ahorros en una tabla de transaciones por autorizar.          */
/* Estas transacciones son realizadas desde el modulo de TADMIN    */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          J. Tagle        Migración a CEN            */
/*******************************************************************/

use cob_remesas
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_tr_autndc_ccah')
   drop proc sp_tr_autndc_ccah
go

create proc sp_tr_autndc_ccah 
(
    @s_ssn              int,
    @s_ssn_branch       int            = null, 
    @s_srv              varchar(30),
    @s_lsrv             varchar(30),
    @s_user             varchar(30),
    @s_sesn             int,
    @s_term             varchar(32),
    @s_date             datetime,
    @s_ofi              smallint,
    @s_rol              smallint       = 1,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1),       
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_from             varchar(32)    = null,
    @t_rty              char(1)        = 'N',
    @t_show_version     bit            = 0,   
    @t_trn              smallint,      
    @t_ssn_corr         int            = null,
    @i_operacion        char(2),       
    @i_mon              tinyint        = null,
    @i_autorizante      varchar(30),   
    @i_funcionario      varchar(30)    = null,
    @i_producto         int            = null,
    @i_producto1        int            = 3,
    @i_cta              cuenta         = null,
    @i_cau              char(10)       = null,
    @i_val              money          = 0,
    @i_secuencial       int            = 0,
    @i_login            varchar(30)    = null,
    @i_trn              int            = null,
    @i_ssn_branch       int            = null,
    @i_concepto         varchar(50)    = null,
    @i_estado           char(1)        = 'I',
    @i_canal            smallint       = null,
    @i_idcaja           int            = 0,
    @i_dpto             tinyint        = 1,
    @i_codbanco         varchar(10)    = null,
    @i_tipchq           varchar(1)     = 'L',
    @i_nchq             int            = null,
    @i_ctachq           varchar(18)    = null,
    @i_filial           smallint       = 1,
    @i_sec_branch       int            = null,
    @i_ind              tinyint        = 0,   
    @i_tipo_trn         char(1)        = 'S',
    @i_origen_fon       varchar(100)   = null,
    @i_destino_fon      varchar(100)   = null,
    @o_genera_fac       char(1)        = 'S' out
)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_bco              smallint,
    @w_ofi              smallint,
    @w_par              int,
    @w_filial           tinyint,
    @w_oficina          smallint,
    @w_producto         tinyint,
    @w_server_local     descripcion,
    @w_sldcont          money,
    @w_slddisp          money,
    @w_nombre           varchar(40),
    @w_val_deb          money,
    @w_comision         money,
    @w_ind              tinyint,
    @w_oficina_p        smallint,
    @w_prod_banc        smallint,
    @w_categoria        char(1),
    @w_tipocta_super    char(1),
    @w_clave1           int,
    @w_clave2           int,
    @w_oficina_cta      smallint,
    @w_tran             int,
    @w_ssn_corr         int,
    @w_ssn_corr_c       int,
    @w_indicador        tinyint,
    @w_tm_cod_alterno   int
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_tr_autndc_ccah'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_tr_autndc_ccah, Version 4.0.0.6'
      return 0
   end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/' = @w_sp_name,
       s_ssn        = @s_ssn,
       s_srv        = @s_srv,
       s_lsrv       = @s_lsrv,
       s_user       = @s_user,
       s_sesn       = @s_sesn,
       s_term       = @s_term,
       s_date       = @s_date,
       s_ofi        = @s_ofi,
       s_rol        = @s_rol,
       s_org_err    = @s_org_err,
       s_error      = @s_error,
       s_sev        = @s_sev,
       s_msg        = @s_msg,
       s_org        = @s_org,   
       t_from       = @t_from,
       t_file       = @t_file, 
       t_rty        = @t_rty,
       t_trn        = @t_trn,
       i_operacion  = @i_operacion,
       i_mon        = @i_mon
    exec cobis..sp_end_debug
end

if @t_trn != 698
   begin
        exec cobis..sp_cerror
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_msg		   = 'ERROR EN CODIGO DE TRANSACCION',
           @i_num          = 201048 -- ERROR EN CODIGO DE TRANSACCION
       return 201048
   end

if @i_operacion = 'SF' /* Busqueda del nombre del funcionario */
begin   
    select  'LOGIN'     = fu_login,
            'NOMBRE'    = fu_nombre
    from   cobis..cl_funcionario, cob_cuentas..cc_funcionario_autoriz
    where  fu_login = @i_login
    and  fa_autorizante = fu_funcionario
    and  fa_tipo = 'S'

    if @@rowcount = 0
       begin
          exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
			@i_msg		= 'FUNCIONARIO NO ES AUTORIZANTE',
             @i_num          = 201329 -- FUNCIONARIO NO ES AUTORIZANTE
          return 201329
       end
end

/* Busqueda de 20 en 20 para seleccion */
if @i_operacion = 'S'
begin
    --set rowcount 5

    select  'SECUENCIAL'    = an_ssn,
            'NUM. CUENTA'   = an_cuenta,
            'NOMBRE'        = case an_producto 
                                when 3 then (select cc_nombre 
                                             from cob_cuentas..cc_ctacte where cc_cta_banco = a.an_cuenta)      
                                when 4 then (select ah_nombre 
                                             from cob_ahorros..ah_cuenta where ah_cta_banco = a.an_cuenta)
                                end,
            'COD. TRAN.'    = an_trn,
            'DESC. TRAN.'   = (select tn_descripcion
                               from cobis..cl_ttransaccion where tn_trn_code = a.an_trn) + 
                              (case when (an_trn = 48 and an_producto = 3) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla y
                                    where x.tabla  = y.codigo
                                    and x.codigo = a.an_causa
                                    --and y.tabla  = 'cc_causa_nc') 
                                    and y.tabla  = 'cc_causa_nc_manual')
                                when (an_trn = 50 and an_producto = 3) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla y
                                    where x.tabla = y.codigo
                                    and x.codigo = a.an_causa
                                    --and y.tabla = 'cc_causa_nd')
                                    and y.tabla = 'cc_causa_nd_manual')
                                when (an_trn = 2502 and an_producto = 3) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla y
                                    where x.tabla = y.codigo
                                    and x.codigo = a.an_causa
                                    and y.tabla = 'cc_causa_dev')  
                                when (an_trn = 253 and an_producto = 4) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla y
                                    where x.tabla  = y.codigo
                                    and x.codigo = a.an_causa
                                    --and y.tabla  = 'ah_causa_nc')
                                    and y.tabla  = 'ah_causa_nc_manual')
                                when (an_trn = 264 and an_producto = 4) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla    y
                                    where x.tabla = y.codigo
                                    and x.codigo = a.an_causa
                                    --and y.tabla = 'ah_causa_nd')
                                    and y.tabla = 'ah_causa_nd_manual')
                                when (an_trn = 240 and an_producto = 4) then ' POR: ' + (select x.valor
                                    from cobis..cl_catalogo x,
                                         cobis..cl_tabla    y
                                    where x.tabla = y.codigo
                                    and x.codigo = a.an_causa
                                    and y.tabla = 'cc_devolucion_cheque') 
                                else ' ' end 
                            ) + ' ' + an_concepto,
            'MONTO'         = an_valor,
            'MONEDA'        = an_moneda,
            'CAUSA'         = an_causa, 
            'INGRESADA POR' = an_user,
            'CONCEPTO'      = an_concepto,
            'SEC. BRANCH'   = an_ssn_branch,
            'ESTADO'        = an_estado,
            'CTA. CHQ.'     = an_ctachq,
            'NUM. CHQ.'     = an_nchq,
            'TIPO. CHQ.'    = an_tipchq,
            'COD. BANCO'    = an_codbanco,
            'NOMBRE BANCO'  = (select ba_descripcion 
                               from cob_remesas..re_banco 
                               where ba_filial = 1 
                               and convert(varchar, ba_banco) = a.an_codbanco),
            'PRODUCTO'      = an_producto,  --18 PCOELLO UNIFICACION DE AUTORIZACIONES
            'INDICADOR'     = an_indicador,   -- HSBC
            'OFICINA'       = an_ofi   -- ,
            -- 'ORIGEN DE RECURSOS'   = an_origen_rec,
            -- 'DESTINO DE RECURSOS'   = an_destino_rec
        from cob_remesas..re_autoriza_ndnc a
        where an_producto in (@i_producto, @i_producto1)
        and (@i_cta is null or an_cuenta = @i_cta)
        --and  an_autorizante = @i_autorizante
        and an_user in (select fu_login
                        from cobis..cl_funcionario
                        where fu_funcionario in (select fa_ejecutor
                                                 from cobis..cl_funcionario, cob_cuentas..cc_funcionario_autoriz
                                                 where fu_funcionario = fa_autorizante
                                                 and fa_tipo = 'D'
                                                 and fu_login = @i_autorizante))
        and  an_ssn > @i_secuencial
        and  an_estado = @i_estado
        and  an_fecha_valor_a = @s_date
        --and  an_ofi   = @s_ofi --GDI 
        and  an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
        order by an_ssn

    --set rowcount 0
    return 0
end

if @i_operacion = 'A' /* Autorizar */
begin   
    select @i_ssn_branch = isnull(@i_ssn_branch,@s_ssn)
    if @i_idcaja is null or @i_idcaja = 0
        select @i_idcaja = an_idcaja
        from cob_remesas..re_autoriza_ndnc
        where an_trn        = @i_trn
        and an_producto     = @i_producto
        and an_moneda       = @i_mon
        and an_ssn_branch   = @i_ssn_branch
        and an_cuenta       = @i_cta
        --and an_ofi      = @s_ofi
        and an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
        and an_estado   = 'I'
    if @i_canal is null
        if @i_idcaja is not null 
            select @i_canal = 4 
			
    if @i_producto = 3 /* Cuentas Corrientes */
    begin
        if @i_trn in (48,50)
        begin
            begin tran
            
            select @w_ssn_corr_c = tm_secuencial
            from cob_cuentas..cc_tran_monet
            where tm_ssn_branch = @i_ssn_branch
            and tm_oficina      = @s_ofi
            and tm_cod_alterno  = @w_tm_cod_alterno

            select @w_ssn_corr = isnull(@i_ssn_branch, @w_ssn_corr_c)
            
            execute @w_return = cob_cuentas..sp_ccndc_automatica
               @s_ssn          = @s_ssn,
               @s_ssn_branch   = @i_ssn_branch,
               @s_srv          = @s_srv,
               @s_user         = @i_autorizante,
               @s_term         = @s_term,
               @s_ofi          = @s_ofi,  
               @t_trn          = @i_trn,
               @i_idcaja       = @i_idcaja,
               @i_canal        = @i_canal,
               @i_cta          = @i_cta,
               @i_val          = @i_val,
               @i_cau          = @i_cau,
               @i_alt          = 15,  
               @i_mon          = @i_mon,
               @i_fecha        = @s_date,
               @i_concepto     = @i_concepto,
               @i_ind          = @i_ind,  --@w_indicador  HSB
               @i_tipo_trn     = @i_tipo_trn,
               @i_prod_cobis   = @i_producto,
               @i_origen_fon   = @i_origen_fon,
                @i_destino_fon  = @i_destino_fon,
               @o_genera_fac   = @o_genera_fac out

            if @w_return <> 0 
               begin
                  rollback tran
                  return @w_return
               end

            -- Actualizar el estado de la transaccion 
            update cob_remesas..re_autoriza_ndnc
            set an_estado       = 'A'
            where an_trn        = @i_trn
            and an_producto     = @i_producto
            and an_moneda       = @i_mon
            and an_ssn_branch   = @i_ssn_branch
            and an_cuenta       = @i_cta
            --and an_ofi      = @s_ofi--GDI
            and  an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
            and an_estado       = 'I'   
            --and an_autorizante   = @i_autorizante
            and an_user         = @i_funcionario   

            if @@rowcount = 0 or @@error <> 0
               begin   
                  rollback tran
            
                  exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
			@i_msg		= '',
                     @i_num          = 355039 -- ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR 
                  return 355039
               end

            if @i_trn = 48
               select @w_tran = 2919
            else
               select @w_tran = 2920

            -- Inserta en tabla de transacciones de servicio
            insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,
             ts_tsfecha, ts_usuario, ts_terminal,
             ts_oficina,ts_origen, ts_cta_banco,
             ts_clase, ts_valor,ts_causa,
             ts_estado, ts_producto, ts_nodo, ts_autorizacion,ts_indicador, ts_canal, ts_moneda) 
            values
             (@s_ssn, @s_ssn_branch, @w_tran, 
             @s_date, @s_user, @s_term,
             @s_ofi,'L', @i_cta,
             'A',@i_val, @i_cau,
             'C', @i_producto, @s_srv, @i_funcionario,@i_ind, @i_canal, @i_mon) -- @w_indicador) HSBC

            if @@error != 0
               begin
                  -- Error en creacion de transaccion de servicio
                  rollback tran
                  exec cobis..sp_cerror
                     @t_debug    = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
					@i_msg		= 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO',
                     @i_num    = 203005 -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                  return 203005
               end

            commit tran
        end
        else
        begin
            if @i_trn in (2502)  /* Nota de debito por cheque devuelto de camara */
            begin
                if @i_ssn_branch is null
                    select @s_ssn_branch = @s_ssn
                else
                    select @s_ssn_branch = @i_ssn_branch

                -- Validacion de existencia del departamento que hace la nota de debito 
                if not exists (select de_departamento 
                               from cobis..cl_departamento
                               where de_departamento = @i_dpto)
                begin
                    exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
						@i_msg		= 'Departamento no existe',
                       @i_num    = 101010 -- Departamento no existe
                    return 101010
                end

                /* Desglose del Codigo de banco */
                select @w_bco = convert (smallint, substring (@i_codbanco,1,3))
                select @w_ofi = convert (smallint, substring (@i_codbanco,4,3))
                select @w_par = convert (smallint, substring (@i_codbanco,7,6))
                
                /*  Captura de parametros de la oficina  */
                exec  @w_return = cobis..sp_parametros
                   @t_debug         = @t_debug,
                   @t_file          = @t_file,
                   @t_from          = @w_sp_name,
                   @s_lsrv          = @s_lsrv,
                   @i_nom_producto  = 'CUENTA CORRIENTE',
                   @o_filial        = @w_filial out, 
                   @o_oficina       = @w_oficina out,
                   @o_producto      = @w_producto out,
                   @o_server_local  = @w_server_local

                if @w_return != 0
                   return @w_return

                exec  @w_return = cob_cuentas..sp_tr_ndchqdev_loc_rem
                    @s_ssn          = @s_ssn,
                    @s_ssn_branch   = @i_ssn_branch,
                    @s_srv          = @s_srv,
                    @s_lsrv         = @s_lsrv,
                    @s_user         = @i_autorizante, --@s_user,
                    @s_sesn         = @s_sesn,
                    @s_term         = @s_term,
                    @s_date         = @s_date,
                    @s_ofi          = @s_ofi,
                    @s_rol          = @s_rol,
                    @s_org_err      = @s_org_err,
                    @s_error        = @s_error,
                    @s_sev          = @s_sev,
                    @s_msg          = @s_msg,
                    @s_org          = @s_org,
                    @t_debug        = @t_debug,
                    @t_from         = @w_sp_name,
                    @t_file         = @t_file,
                    @t_rty          = @t_rty,
                    @t_trn          = @i_trn, --@t_trn,
                    @i_idcaja       = @i_idcaja,         
                    @i_canal        = @i_canal,
                    @i_ctadb        = @i_cta,
                    @i_producto     = @w_producto,
                    @i_bco          = @w_bco,
                    @i_ofi          = @w_ofi,
                    @i_par          = @w_par,
                    @i_ctachq       = @i_ctachq,
                    @i_nchq         = @i_nchq,
                    @i_valch        = @i_val,
                    @i_tipchq       = @i_tipchq,
                    @i_dpto         = @i_dpto,
                    @i_mon          = @i_mon,  
                    @i_cau          = @i_cau,    
                    @i_oficina      = @w_oficina,
                    @i_filial       = @i_filial,
                    @i_fecha_valor_a = @s_date, --@i_fecha_valor_a,
                    @i_trn_caja     = 'N',
                    @o_sldcont      = @w_sldcont out,
                    @o_slddisp      = @w_slddisp out,
                    @o_nombre       = @w_nombre out,
                    @o_val_deb      = @w_val_deb out,
                    @o_comision     = @w_comision out,
                    @o_ind          = @w_ind out,
                    @o_oficina      = @w_oficina_p out,
                    @o_prod_banc    = @w_prod_banc out,
                    @o_categoria    = @w_categoria out,
                    @o_tipocta_super= @w_tipocta_super out

                if @w_return <> 0 
                   begin
                      rollback tran
                      return @w_return
                   end

                -- Actualizar el estado de la transaccion 
                update cob_remesas..re_autoriza_ndnc
                set an_estado       = 'A'
                where an_trn        = @i_trn
                and an_producto     = @i_producto
                and an_moneda       = @i_mon
                and an_ssn_branch   = @i_ssn_branch
                and an_cuenta       = @i_cta
                --and an_ofi      = @s_ofi
                and  an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
                and an_estado       = 'I'   
                --and an_autorizante   = @i_autorizante
                and an_user         = @i_funcionario   

                if @@rowcount = 0 or @@error <> 0
                   begin      
                      rollback tran
                      exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
						 @i_msg		= 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR',
                         @i_num          = 355039 -- ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR
                      return 355039
                   end

                commit tran
            end
        end
    end

    if @i_producto = 4 /* Cuentas de Ahorros */
    begin
        if @i_trn in (253,264)
        begin
            begin tran
            execute @w_return = cob_ahorros..sp_ahndc_automatica
                @s_ssn          = @s_ssn,
                @s_ssn_branch   = @i_ssn_branch,
                @s_srv          = @s_srv,
                @s_user         = @i_autorizante,
                @s_term         = @s_term,
                @s_ofi          = @s_ofi,  
                @t_trn          = @i_trn,
                @i_cta          = @i_cta,
                @i_val          = @i_val,
                @i_cau          = @i_cau,
                @i_alt          = 15,  
                @i_mon          = @i_mon,
                @i_fecha        = @s_date,
                @i_concepto     = @i_concepto,
                @i_idcaja       = @i_idcaja,
                @i_canal        = @i_canal
                -- @i_ind          = @i_ind, -- @w_indicador HSBC
                -- @i_tipo_trn     = @i_tipo_trn,
                -- @i_prod_cobis   = @i_producto,
                -- @i_origen_fon   = @i_origen_fon,
                -- @i_destino_fon  = @i_destino_fon,
                -- @o_genera_fac   = @o_genera_fac out

            if @w_return <> 0 
               begin
                  rollback tran
                  return @w_return
               end

            /* Actualizar el estado de la transaccion */   
            update cob_remesas..re_autoriza_ndnc
            set an_estado       = 'A'
            where an_trn        = @i_trn
            and an_producto     = @i_producto
            and an_moneda       = @i_mon
            and an_ssn_branch   = @i_ssn_branch
            and an_cuenta       = @i_cta
            --and an_ofi      = @s_ofi
            and  an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
            and an_estado       = 'I'   
            -- and an_autorizante   = @i_autorizante
            and an_user     = @i_funcionario

            if @@rowcount = 0 or @@error <> 0
            begin   
                rollback tran

                exec cobis..sp_cerror
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
				   @i_msg		   = 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR',
                   @i_num          = 355039 -- ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR
                return 355039
            end

            if @i_trn = 253
               select @w_tran = 2919
            else
               select @w_tran = 2920

            -- Inserta en tabla de transacciones de servicio
            insert into cob_ahorros..ah_tran_servicio
             (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,
             ts_tsfecha, ts_usuario, ts_terminal,
             ts_oficina,ts_origen, ts_cta_banco,
             ts_clase, ts_valor,ts_causa,
             ts_estado, ts_producto, ts_nodo, ts_cedruc1, ts_indicador, ts_moneda)
            values
             (@s_ssn, @s_ssn_branch, @w_tran, 
             @s_date, @s_user, @s_term,
             @s_ofi,'L', @i_cta,
             'A',@i_val, @i_cau,
             'C', @i_producto, @s_srv, @i_funcionario, @i_ind, @i_mon) -- @w_indicador) HSBC

            if @@error != 0
               begin
                  -- Error en creacion de transaccion de servicio
                  rollback tran
                  exec cobis..sp_cerror
                     @t_debug    = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
					 @i_msg		= 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO',
                     @i_num    = 203005 -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO 
                  return 203005
               end

            commit tran
        end
        else   
        begin
            if @i_trn in (240) /* Nota de debito por cheque devuelto */
            begin
                if @i_ssn_branch is null
                   select @s_ssn_branch = @s_ssn
                else
                   select @s_ssn_branch = @i_ssn_branch
                
                if not exists (select de_departamento 
                               from cobis..cl_departamento
                               where de_departamento = @i_dpto)
                   begin
                      exec cobis..sp_cerror
                         @t_debug  = @t_debug,
                         @t_file   = @t_file,
                         @t_from   = @w_sp_name,
			@i_msg		= '',
                         @i_num    = 101010 -- Departamento no existe
                      return 101010
                   end

                -- Desglose del Codigo de banco 
                select @w_bco = convert (smallint, substring (@i_codbanco,1,3))
                select @w_ofi = convert (smallint, substring (@i_codbanco,4,3))
                select @w_par = convert (int, substring (@i_codbanco,7,6))
                
                --  Captura de parametros de la oficina  
                exec  @w_return = cobis..sp_parametros 
                   @t_debug         = @t_debug,
                   @t_file          = @t_file,
                   @t_from          = @w_sp_name,
                   @s_lsrv          = @s_lsrv,
                   @i_nom_producto  = 'CUENTA DE AHORROS',
                   @o_filial        = @w_filial out, 
                   @o_oficina       = @w_oficina out,
                   @o_producto      = @w_producto out,
                   @o_server_local  = @w_server_local

                if @w_return != 0
                   return @w_return

                exec    @w_return = cob_ahorros..sp_tr_ndchqdev_loc_rem_aho
                    @s_ssn              = @s_ssn,
                    @s_ssn_branch       = @i_ssn_branch,
                    @s_srv              = @s_srv,
                    @s_lsrv             = @s_lsrv,
                    @s_user             = @i_autorizante, --@s_user,
                    @s_sesn             = @s_sesn,
                    @s_term             = @s_term,
                    @s_date             = @s_date,
                    @s_ofi              = @s_ofi,
                    @s_rol              = @s_rol,
                    @s_org_err          = @s_org_err,
                    @s_error            = @s_error,
                    @s_sev              = @s_sev,
                    @s_msg              = @s_msg,
                    @s_org              = @s_org,
                    @s_ssn_branch       = @s_ssn_branch,
                    @t_debug            = @t_debug,
                    @t_from             = @w_sp_name,
                    @t_file             = @t_file,
                    @t_rty              = @t_rty,
                    @t_trn              = @i_trn,--@t_trn,
                    @i_idcaja           = @i_idcaja,
                    @i_canal            = @i_canal,
                    @i_ctadb            = @i_cta, --@i_ctadb,
                    @i_codbanco         = @i_codbanco,
                    @i_producto         = @w_producto,
                    @i_oficina          = @w_oficina,
                    @i_bco              = @w_bco,
                    @i_ofi              = @w_ofi,
                    @i_par              = @w_par,
                    @i_ctachq           = @i_ctachq,
                    @i_nchq             = @i_nchq,
                    @i_valch            = @i_val,
                    @i_tipchq           = @i_tipchq,
                    @i_dpto             = @i_dpto,
                    @i_mon              = @i_mon,  
                    @i_cau              = @i_cau,    
                    @i_filial           = @i_filial,
                    @i_fecha_valor_a    = @s_date, --@i_fecha_valor_a,
                    @i_trn_caja         = 'N',
                    @o_sldcont          = @w_sldcont out,
                    @o_slddisp          = @w_slddisp out,
                    @o_nombre           = @w_nombre out,
                    @o_val_deb          = @w_val_deb out,
                    @o_comision         = @w_comision out,
                    @o_ind              = @w_ind out,
                    @o_clave1           = @w_clave1 out,
                    @o_clave2           = @w_clave2 out,
                    @o_oficina_cta      = @w_oficina_cta out,
                    @o_prod_banc        = @w_prod_banc out,
                    @o_categoria        = @w_categoria out,
                    @o_tipocta_super    = @w_tipocta_super out

                if @w_return <> 0 
                   begin
                      rollback tran
                      return @w_return
                   end

                /* Actualizar el estado de la transaccion */
                update cob_remesas..re_autoriza_ndnc
                set an_estado       = 'A'
                where an_trn        = @i_trn
                and an_producto     = @i_producto
                and an_moneda       = @i_mon
                and an_ssn_branch   = @i_ssn_branch
                and an_cuenta       = @i_cta
                --and an_ofi      = @s_ofi
                and an_estado       = 'I'   
                --and an_autorizante   = @i_autorizante
                and an_user         = @i_funcionario   
                and  an_ofi in ( select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante

                if @@rowcount = 0 or @@error <> 0
                   begin      
                      rollback tran
                   
                      exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
						 @i_msg		= 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR',
                         @i_num          = 355039 -- ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR
                      return 355039
                   end

                commit tran
            end
        end
    end

    return 0
end

if @i_operacion = 'R' /* Rechazar */
begin
   begin tran

   if @i_idcaja is null or @i_idcaja = 0
        select @i_idcaja = an_idcaja
        from cob_remesas..re_autoriza_ndnc
        where an_trn        = @i_trn
        and an_producto     = @i_producto
        and an_moneda       = @i_mon
        and an_ssn_branch   = @i_ssn_branch
        and an_cuenta       = @i_cta
        --and an_ofi      = @s_ofi
        and an_ofi in ( select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
        and an_estado       = 'A'

    if @i_canal is null
        if @i_idcaja is not null and @i_idcaja <> 0
            select @i_canal = 4 

    if exists (select 1
            from cob_remesas..re_autoriza_ndnc
            where an_ssn_branch = @i_ssn_branch
            and an_trn      = @i_trn
            --and an_ofi      = @s_ofi
            and  an_ofi in (select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
            and an_user     = @i_funcionario
            and an_producto = @i_producto
            and an_moneda   = @i_mon
            and an_cuenta   = @i_cta
            and an_estado   = 'A')
    begin
        select @i_codbanco = an_codbanco,
               @i_ctachq   = an_ctachq,
               @i_nchq     = an_nchq,
               @i_tipchq   = an_tipchq
        from cob_remesas..re_autoriza_ndnc
        where an_ssn_branch = @i_ssn_branch
        and an_trn      = @i_trn
        --and an_ofi      = @s_ofi
        and  an_ofi in ( select us_oficina from cobis..ad_usuario where us_login = @s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
        and an_user     = @i_funcionario
        and an_producto = @i_producto
        and an_moneda   = @i_mon
        and an_cuenta   = @i_cta
        and an_estado   = 'A'
      
        if @i_producto = 3 /* Cuentas Corrientes */
        begin         
            --Se obtiene el codigo alterno para no enviarlo quemado con 15
            select @w_tm_cod_alterno = tm_cod_alterno
            from cob_cuentas..cc_tran_monet 
            where tm_ssn_branch = @i_ssn_branch
            and tm_tipo_tran    = @i_trn
            and tm_cta_banco    = @i_cta
            and tm_usuario      = @i_autorizante
            and (tm_causa is null or tm_causa=@i_cau)
            and tm_valor        = @i_val
            and tm_concepto     = @i_concepto
            and (tm_estado is null or tm_estado <> 'R')
            --fin 
         
            if @i_trn in (48,50)
            begin
                select @w_ssn_corr_c = tm_secuencial
                from cob_cuentas..cc_tran_monet
                where tm_ssn_branch = @i_ssn_branch
                and tm_oficina      = @s_ofi
                and tm_cod_alterno  = @w_tm_cod_alterno

                select @w_ssn_corr = isnull(@i_ssn_branch, @w_ssn_corr_c)
                
                execute @w_return = cob_cuentas..sp_ccndc_automatica
                        @s_ssn          = @s_ssn,
                        @s_ssn_branch   = @s_ssn_branch,
                        @s_srv          = @s_srv,
                        @s_user         = @i_autorizante,
                        @s_term         = @s_term,
                        @s_ofi          = @s_ofi,  
                        @t_trn          = @i_trn,
                        @t_corr         = 'S',
                        @t_ssn_corr     = @w_ssn_corr,
                        @i_idcaja       = @i_idcaja,
                        @i_canal        = @i_canal,
                        @i_cta          = @i_cta,
                        @i_val          = @i_val,
                        @i_cau          = @i_cau,
                        @i_alt          = @w_tm_cod_alterno,  
                        @i_mon          = @i_mon,
                        @i_fecha        = @s_date,
                        @i_concepto     = @i_concepto,
                        @i_ind          = @i_ind,   -- HSBC
                        @i_tipo_trn     = @i_tipo_trn,
                        @i_prod_cobis   = @i_producto,
                        @o_genera_fac   = @o_genera_fac out

                if @w_return <> 0 
                   begin
                      rollback tran
                      return @w_return
                   end
            end
            else
            begin 
                if @i_trn in (2502)  /* Nota de debito por cheque devuelto de camara */
                begin
                    if @s_ssn_branch is null
                       select @s_ssn_branch = @s_ssn

                    -- Desglose del Codigo de banco 
                    select @w_bco = convert (smallint, substring (@i_codbanco,1,3))
                    select @w_ofi = convert (smallint, substring (@i_codbanco,4,3))
                    select @w_par = convert (smallint, substring (@i_codbanco,7,6))

                    select @w_ssn_corr_c = tm_secuencial
                    from cob_cuentas..cc_tran_monet
                    where tm_ssn_branch = @i_ssn_branch
                    and tm_oficina      = @s_ofi
                    and tm_cod_alterno  = 0

                    select @w_ssn_corr = isnull(@i_ssn_branch, @w_ssn_corr_c)
                    
                    --  Captura de parametros de la oficina  
                    exec    @w_return = cobis..sp_parametros
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @s_lsrv         = @s_lsrv,
                        @i_nom_producto = 'CUENTA CORRIENTE',
                        @o_filial       = @w_filial out,
                        @o_oficina      = @w_oficina out,
                        @o_producto     = @w_producto out,
                        @o_server_local = @w_server_local

                    if @w_return != 0
                       return @w_return

                    exec  @w_return = cob_cuentas..sp_tr_ndchqdev_loc_rem
                        @s_ssn          = @s_ssn,
                        @s_ssn_branch   = @s_ssn_branch,
                        @s_srv          = @s_srv,
                        @s_lsrv         = @s_lsrv,
                        @s_user         = @i_autorizante,
                        @s_sesn         = @s_sesn,
                        @s_term         = @s_term,
                        @s_date         = @s_date,
                        @s_ofi          = @s_ofi,
                        @s_rol          = @s_rol,
                        @s_org_err      = @s_org_err,
                        @s_error        = @s_error,
                        @s_sev          = @s_sev,
                        @s_msg          = @s_msg,
                        @s_org          = @s_org,
                        @t_debug        = @t_debug,
                        @t_from         = @w_sp_name,
                        @t_file         = @t_file,
                        @t_rty          = @t_rty,
                        @t_trn          = @i_trn,
                        @i_idcaja       = @i_idcaja,
                        @i_canal        = @i_canal,
                        @t_corr         = 'S',
                        @t_ssn_corr     = @w_ssn_corr,
                        @i_ctadb        = @i_cta,
                        @i_producto     = @w_producto,
                        @i_bco          = @w_bco,
                        @i_ofi          = @w_ofi,
                        @i_par          = @w_par,
                        @i_ctachq       = @i_ctachq,
                        @i_nchq         = @i_nchq,
                        @i_valch        = @i_val,
                        @i_tipchq       = @i_tipchq,
                        @i_dpto         = @i_dpto,
                        @i_mon          = @i_mon,  
                        @i_cau          = @i_cau,    
                        @i_oficina      = @w_oficina,
                        @i_filial       = @i_filial,
                        @i_fecha_valor_a= @s_date,
                        @i_trn_caja     = 'N',
                        @o_sldcont      = @w_sldcont out,
                        @o_slddisp      = @w_slddisp out,
                        @o_nombre       = @w_nombre out,
                        @o_val_deb      = @w_val_deb out,
                        @o_comision     = @w_comision out,
                        @o_ind          = @w_ind out,
                        @o_oficina      = @w_oficina_p out,
                        @o_prod_banc    = @w_prod_banc out,
                        @o_categoria    = @w_categoria out,
                        @o_tipocta_super= @w_tipocta_super out

                    if @w_return <> 0 
                       begin
                          rollback tran
                          return @w_return
                       end
                end
            end
        end   

        if @i_producto = 4 /* Cuentas de Ahorros */
        begin         
            select @w_tm_cod_alterno = tm_cod_alterno
            from cob_ahorros..ah_tran_monet 
            where tm_ssn_branch = @i_ssn_branch
            and tm_tipo_tran    = @i_trn
            and tm_cta_banco    = @i_cta
            and tm_usuario      = @i_autorizante
            and (tm_causa is null or tm_causa = @i_cau)
            and tm_valor        = @i_val
            and tm_concepto     = @i_concepto
            and (tm_estado is null or tm_estado <> 'R')

            if @i_trn in (253,264)
            begin
                select @w_ssn_corr_c = tm_secuencial
                from cob_ahorros..ah_tran_monet
                where tm_ssn_branch = @i_ssn_branch
                and tm_oficina   = @s_ofi
                and tm_cod_alterno = @w_tm_cod_alterno

                select @w_ssn_corr = isnull(@i_ssn_branch, @w_ssn_corr_c)

                execute @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_ssn          = @s_ssn,
                    @s_ssn_branch   = @s_ssn_branch,
                    @s_srv          = @s_srv,
                    @s_user         = @i_autorizante,
                    @s_term         = @s_term,
                    @s_ofi          = @s_ofi, 
                    @t_corr         = 'S',
                    @t_ssn_corr     = @w_ssn_corr,
                    @t_trn          = @i_trn,
                    @i_cta          = @i_cta,
                    @i_val          = @i_val,
                    @i_cau          = @i_cau,
                    @i_alt          = @w_tm_cod_alterno,  
                    @i_mon          = @i_mon,
                    @i_fecha        = @s_date,
                    @i_concepto     = @i_concepto,
                    @i_canal        = @i_canal,
                    @i_idcaja       = @i_idcaja,
                    @i_ind          = @i_ind,   -- HSBC,
                    @i_prod_cobis   = @i_producto,
                    @o_genera_fac   = @o_genera_fac out

                if @w_return <> 0 
                   begin
                      rollback tran
                      return @w_return
                   end
        end
        else
        begin
            if @i_trn in (240) -- Nota de debito por cheque devuelto 
            begin
                if @s_ssn_branch is null
                    select @s_ssn_branch = @s_ssn

                -- Desglose del Codigo de banco 
                select @w_bco = convert (smallint, substring (@i_codbanco,1,3))
                select @w_ofi = convert (smallint, substring (@i_codbanco,4,3))
                select @w_par = convert (int, substring (@i_codbanco,7,6))

                -- Captura de parametros de la oficina  
                exec    @w_return = cobis..sp_parametros 
                   @t_debug         = @t_debug,
                   @t_file          = @t_file,
                   @t_from          = @w_sp_name,
                   @s_lsrv          = @s_lsrv,
                   @i_nom_producto  = 'CUENTA DE AHORROS',
                   @o_filial        = @w_filial out, 
                   @o_oficina       = @w_oficina out,
                   @o_producto      = @w_producto out,
                   @o_server_local  = @w_server_local

                if @w_return != 0
                   return @w_return

                select @w_ssn_corr_c = tm_secuencial
                from cob_ahorros..ah_tran_monet
                where tm_ssn_branch = @i_ssn_branch
                and tm_oficina   = @s_ofi
                and tm_cod_alterno = 0

                select @w_ssn_corr = isnull(@i_ssn_branch, @w_ssn_corr_c)

                exec    @w_return = cob_ahorros..sp_tr_ndchqdev_loc_rem_aho
                        @s_ssn              = @s_ssn,
                        @s_ssn_branch       = @s_ssn_branch,
                        @s_srv              = @s_srv,
                        @s_lsrv             = @s_lsrv,
                        @s_user             = @i_autorizante, --@s_user,
                        @s_sesn             = @s_sesn,
                        @s_term             = @s_term,
                        @s_date             = @s_date,
                        @s_ofi              = @s_ofi,
                        @s_rol              = @s_rol,
                        @s_org_err          = @s_org_err,
                        @s_error            = @s_error,
                        @s_sev              = @s_sev,
                        @s_msg              = @s_msg,
                        @s_org              = @s_org,
                        @s_ssn_branch       = @s_ssn_branch,
                        @t_debug            = @t_debug,
                        @t_from             = @w_sp_name,
                        @t_file             = @t_file,
                        @t_rty              = @t_rty,
                        @t_trn              = @i_trn,--@t_trn,
                        @t_corr             = 'S',
                        @t_ssn_corr         = @w_ssn_corr,
                        @i_idcaja           = @i_idcaja,
                        @i_canal            = @i_canal,
                        @i_ctadb            = @i_cta, --@i_ctadb,
                        @i_codbanco         = @i_codbanco,
                        @i_producto         = @w_producto,
                        @i_oficina          = @w_oficina,
                        @i_bco              = @w_bco,
                        @i_ofi              = @w_ofi,
                        @i_par              = @w_par,
                        @i_ctachq           = @i_ctachq,
                        @i_nchq             = @i_nchq,
                        @i_valch            = @i_val,
                        @i_tipchq           = @i_tipchq,
                        @i_dpto             = @i_dpto,
                        @i_mon              = @i_mon,  
                        @i_cau              = @i_cau,    
                        @i_filial           = @i_filial,
                        @i_fecha_valor_a    = @s_date, --@i_fecha_valor_a,
                        @i_trn_caja         = 'N',
                        @o_sldcont          = @w_sldcont out,
                        @o_slddisp          = @w_slddisp out,
                        @o_nombre           = @w_nombre out,
                        @o_val_deb          = @w_val_deb out,
                        @o_comision         = @w_comision out,
                        @o_ind              = @w_ind out,
                        @o_clave1           = @w_clave1 out,
                        @o_clave2           = @w_clave2 out,
                        @o_oficina_cta      = @w_oficina_cta out,
                        @o_prod_banc        = @w_prod_banc out,
                        @o_categoria        = @w_categoria out,
                        @o_tipocta_super    = @w_tipocta_super out

                if @w_return <> 0 
                   begin
                      rollback tran
                      return @w_return
                   end
				end
			end
		end
	end

	-- Actualizar el estado de la transaccion 
	update cob_remesas..re_autoriza_ndnc
    set an_estado       = @i_estado
    where an_trn        = @i_trn
    and an_producto     = @i_producto
    and an_moneda       = @i_mon
    and an_ssn_branch   = @i_ssn_branch
    and an_cuenta       = @i_cta
    --and an_ofi      = @s_ofi
    --and an_estado   = 'I'   
    --and an_autorizante   = @i_autorizante
    and an_user         = @i_funcionario
    and  an_ofi in ( select us_oficina from cobis..ad_usuario where us_login = @s_user  and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante

    if @@rowcount = 0 or @@error <> 0
       begin
          rollback tran
          
          exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
			 @i_msg		= 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR',
             @i_num          = 355039 -- ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR
          return 355039
       end

    if @i_producto = 3
       begin
           if @i_trn = 48
              select @w_tran = 2917
           else
              select @w_tran = 2918
       
           -- Inserta en tabla de transacciones de servicio
           insert into cob_cuentas..cc_tran_servicio
            (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,
            ts_tsfecha, ts_usuario, ts_terminal,
            ts_oficina,ts_origen, ts_cta_banco,
            ts_clase, ts_valor,ts_causa,
            ts_estado, ts_producto, ts_nodo, ts_ssn_corr, ts_autorizacion, ts_canal, ts_moneda) --PCOELLO GRABAR DUENIO DE LA nC O nd
           values 
            (@s_ssn, @s_ssn_branch, @w_tran, 
            @s_date, @s_user, @s_term,
            @s_ofi,'L', @i_cta,
            'R',@i_val, @i_cau,
            'C', @i_producto, @s_srv, @w_ssn_corr, @i_funcionario, @i_canal, @i_mon) --PCOELLO GRABAR DUENIO DE LA nC O nd
       
           if @@error != 0
              begin
                 -- Error en creacion de transaccion de servicio
                 rollback tran
                 exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file    = @t_file,
                    @t_from    = @w_sp_name,
		         	@i_msg		= 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO',
                    @i_num    = 203005 -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                 return 203005
              end
       end
    else
       begin
          if @i_trn = 253
             select @w_tran = 2917
          else
             select @w_tran = 2918
       
           -- Inserta en tabla de transacciones de servicio
           insert into cob_ahorros..ah_tran_servicio
            (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,
            ts_tsfecha, ts_usuario, ts_terminal,
            ts_oficina,ts_origen, ts_cta_banco,
            ts_clase, ts_valor,ts_causa,
            ts_estado, ts_producto, ts_nodo, ts_cedruc1, ts_moneda) --PCOELLO GRABAR DUENIO DE LA nC O nd
           values  
            (@s_ssn, @s_ssn_branch, @w_tran, 
            @s_date, @s_user, @s_term,
            @s_ofi,'L', @i_cta,
            'R',@i_val, @i_cau,
            'C', @i_producto, @s_srv, @i_funcionario, @i_mon) --PCOELLO GRABAR DUENIO DE LA nC O nd
           if @@error != 0
              begin
                 -- Error en creacion de transaccion de servicio
                 rollback tran
                 exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file    = @t_file,
                    @t_from    = @w_sp_name,
			        @i_msg     = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO',
                    @i_num    = 203005 -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                 return 203005
              end
       end
    commit tran
    return 0
end

/* Busqueda de 20 en 20 para seleccion */
if @i_operacion = 'Q'
begin
    --set rowcount 20

    select  'Secuencial'    = an_ssn,
            'No. Cuenta'    = an_cuenta,
            'Nombre'        = case an_producto
                              when 3 then (select convert(varchar(30),cc_nombre)
                                           from cob_cuentas..cc_ctacte where cc_cta_banco = a.an_cuenta)      
                              when 4 then (select convert(varchar(30),ah_nombre)
                                           from cob_ahorros..ah_cuenta where ah_cta_banco = a.an_cuenta)
                              end,
            'Desc. Tran.'   = convert(varchar(64),(select tn_descripcion
                                                   from cobis..cl_ttransaccion where tn_trn_code = a.an_trn) + 
                                (case when (an_trn = 48 and an_producto = 3) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                             cobis..cl_tabla y
                                        where x.tabla  = y.codigo
                                        and x.codigo = a.an_causa
                                        --and y.tabla  = 'cc_causa_nc') 
                                        and y.tabla  = 'cc_causa_nc_manual')    
                                    when (an_trn = 50 and an_producto = 3) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                             cobis..cl_tabla y
                                        where x.tabla = y.codigo
                                        and x.codigo = a.an_causa
                                        --and y.tabla = 'cc_causa_nd')
                                        and y.tabla = 'cc_causa_nd_manual')
                                    when (an_trn = 2502 and an_producto = 3) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                             cobis..cl_tabla y
                                        where x.tabla = y.codigo
                                        and x.codigo = a.an_causa
                                        and y.tabla = 'cc_causa_dev')  
                                    when (an_trn = 253 and an_producto = 4) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                             cobis..cl_tabla    y
                                        where x.tabla  = y.codigo
                                        and x.codigo = a.an_causa
                                        --and y.tabla  = 'ah_causa_nc')
                                        and y.tabla  = 'ah_causa_nc_manual')
                                    when (an_trn = 264 and an_producto = 4) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                             cobis..cl_tabla y
                                        where x.tabla = y.codigo
                                        and x.codigo = a.an_causa
                                        --and y.tabla = 'ah_causa_nd')
                                        and y.tabla = 'ah_causa_nd_manual')
                                    when (an_trn = 240 and an_producto = 4) then ' POR: ' + (select x.valor
                                        from cobis..cl_catalogo x,
                                        cobis..cl_tabla y
                                        where x.tabla = y.codigo
                                        and x.codigo = a.an_causa
                                        and y.tabla = 'cc_devolucion_cheque') 
                                    else ' ' end 
                                )),
            'Monto'         = an_valor,
            'Causa'         = an_causa, 
            'Concepto'      = convert(varchar(50),an_concepto),
            'Ingresada Por' = an_user,
            'Estado'        = case an_estado
                              when 'I' then 'INGRESADA'
                              when 'R' then 'RECHAZADA'
                              when 'A' then 'APROBADA'
                              end,
            'Transaccion'   = an_trn
            ,'Oficina'      = an_ofi
        from cob_remesas..re_autoriza_ndnc a
        where an_user in (select fu_login
                          from cobis..cl_funcionario
                          where fu_funcionario in (select fa_ejecutor
                                                   from cobis..cl_funcionario, cob_cuentas..cc_funcionario_autoriz
                                                   where fu_funcionario = fa_autorizante
                                                   and fa_tipo = 'D'
                                                   and fu_login = @i_autorizante))
        and  an_ssn > @i_secuencial
        and  an_fecha_valor_a = @s_date
        --and  an_ofi   = @s_ofi --GDI
        and  an_ofi in ( select us_oficina from cobis..ad_usuario where us_login=@s_user and us_estado = 'V')--Muestra todas las Oficinas asociadas a la cuenta del autorizante
        and  an_estado = @i_estado
        and  an_producto in (@i_producto, @i_producto1)   
        and (@i_cta is null or an_cuenta = @i_cta)   
        order by   an_ssn

    --set rowcount 0
    return 0
end
   
go