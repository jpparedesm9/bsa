/****************************************************************/
/* ARCHIVO:         m_modsus.sp                                 */
/* NOMBRE LOGICO:   sp_modificar_suspencion                     */
/* PRODUCTO:        SERVICIOS BANCARIOS                         */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Este  stored  procedure  permite registrar la suspencion de  */
/* instrumentos en el inventario de instrumentos como en la     */
/* tabla de series de instrumentos negociados                   */
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR             RAZON                        */
/* 04/Ene/99     L. Chango         Emision Inicial              */
/****************************************************************/

use cob_sbancarios
go

if exists(select 1 from sysobjects where name = 'sp_modificar_suspencion')
    drop proc sp_modificar_suspencion
go

create proc sp_modificar_suspencion
(
    @s_date             datetime    = null,
    @s_user             login       = null,
    @s_sesn             int         = null,
    @s_ssn              int         = null,
    @s_rol              smallint,
    @s_term             varchar(30) = null,
    @s_srv              varchar(30) = null,
    @s_lsrv             varchar(30) = null,
    @s_ofi              smallint    = null,
    @s_org              char(1)     = null,
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_trn              smallint    = null, 
    @i_localizacion     char(1),    /* tipo de actualizacion instrumentos en custodia/instrumentos negociados*/
    @i_final            char(1)     = 'N',        /* Define si es la £ltima transmision o no (S/N) */
    @i_grupo1           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo2           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo3           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo4           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo5           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo6           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo7           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo8           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo9           varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo10          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo11          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo12          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo13          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo14          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo15          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo16          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo17          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo18          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo19          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    @i_grupo20          varchar(255)= null,  /* Contiene un registro con informacion sobre el instrumento a suspender */
    --
    @i_prod_cobis       int         = 42, 
    @i_lote             int         = null, 
    --
    @o_ssn          int out,        /* Contiene un registro con informacion sobre el instrumento a suspender */
    @o_cod_alter    int = null out
)
as
    

/* Declaracion de variables de uso Interno */ 
declare @w_return                      int,            /* valor que retorna */
        @w_sp_name                     varchar(32),    /* nombre del stored procedure*/
        @w_funcionario_mod             smallint,
        @w_fecha                       datetime,
        @w_hora                        varchar(10),    /* hora para transaccion de servicio */
        @w_registro                    varchar(255),   /* registro de remesa */
        @w_contador                    int,        /* contador de registros */
        @w_codigo_alterno              int,        /* contador auxiliar para ingresar datos en ts_inventario_ins*/
        @w_parametro                   tinyint,    /* n£mero de par metros que contiene cada grupo */
        @w_posicion                    smallint,   /* posicion en @w_registro del caracter @ */
        @w_token                       varchar(64),    /* valor del par metro */
        @w_ssn                         int,        /* contiene el identificador de la remesa en la tabla temporal */
        @w_secuencial                  int,        /* contiene el n£mero secuencial de los registros */
        @w_producto                    tinyint,
        @w_instrumento                 smallint,
        @w_sub_tipo                    int,
        @w_serie_literal               varchar(10),
        @w_serie_desde                 money,
        @w_serie_hasta                 money,
        @w_area                        smallint,
        @w_func_area                   smallint,
        @w_cod_operacion               int,
        @w_sec_producto                smallint,
        @w_motivo                      varchar(64),
        @w_producto_inv                tinyint,
        @w_instrumento_inv             smallint,
        @w_sub_tipo_inv                int,
        @w_serie_literal_inv           varchar(10),
        @w_serie_desde_inv             money,
        @w_serie_hasta_inv             money,
        @w_area_inv                    smallint,
        @w_func_area_inv               smallint,
        @w_asignacion_inv              char(1),
        @w_reservados_inv              int,
        @w_disponibles                 int,
    /*variables para puntos de reorden*/
        @v_secuencial                  int, -- tambi‚n se utiliza para trans de serivicios de imp lotes
        @v_area_reorden                smallint,
        @v_func_area_reorden           smallint,
        @v_fecha_creacion_reorden      datetime,
        @v_func_creador_reorden        smallint,
        @v_fecha_modif_reorden         datetime,
        @v_func_modif_reorden          smallint,
        @v_producto_reorden            tinyint,
        @v_instrumento_reorden         smallint,
        @v_sub_tipo_reorden            int,
        @v_maximo_reorden              int,
        @v_minimo_reorden              int,
        @v_actual_reorden              int,
        @w_reorden                     int,
    /* variables para transaccion de servicio del inventario */
        @v_producto_inv                tinyint,
        @v_instrumento_inv             smallint,
        @v_sub_tipo_inv                int,
        @v_serie_literal_inv           varchar(10),
        @v_serie_desde_inv             money,
        @v_serie_hasta_inv             money,
        @v_area_inv                    smallint,
        @v_func_area_inv               smallint,
        @v_asignacion_inv              char(1),
        @v_reservados_inv              int,
    /*variables para series de instrumentos negociados*/                         
        @w_operacion_series            int,
        @w_sec_producto_series         smallint,
        @w_estado_series               char(1),
        @w_literal_series              varchar(10),
        @w_desde_series                money,
        @w_hasta_series                money,
    /*variables para eliminar instrumentos que tienen enlace con CC*/
        @w_valor                       money,
        @w_beneficiario                varchar(64),
        @w_enlace_cc                   char(1),
        @w_moneda                      tinyint,
        @w_cta_ger                     varchar(24),  /*cuenta de gerencia para la oficina*/
        @w_causa_rev                   char(1),      /* Cod. causa de revocatoria */
        @w_conexion_cc                 estado,       /*existe interfaz con cta.cte.*/
        @w_fecha_susp                  datetime,     /*fecha de proceso mas la hora actual */
        @w_oficina_destino             int,
    /* Transaccion de servicios de Impresion en Lotes */
        @v_id_lote                     int,          /* Identificador del lote */
        @v_estado                      char(1),      /* Estado del instrumento */
        @v_func_imp                    smallint,     /* Funcionario que imprime */                   
        @v_fechaimp                    datetime,     /* Fecha de impresion */
        @v_func_aut                    smallint,     /* Funcionario que autoriza la impresion */
        @v_serielit                    varchar(10),  /* Serie literal del instrumento */     
        @v_serienum                    money,        /* Serie num‚rica del instrumento */            
        @w_seqnos                      int,    
        @w_sec_lote                    int,
        @w_debug                       char(1)

/* Asignar el nombre del stored procedure */
select  @w_sp_name = 'sp_modificar_suspencion'

/* Obtener la hora para transaccion de servicios */
select @w_hora  = convert(varchar(10),getdate(),108),
       @w_debug = 'S'
       
if @w_debug = 'S' print @w_sp_name

/* Verificacion de tipo de transaccion */
if @t_trn <> 29315
begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 2902500
    return 1
end

    /*codigo de funcionario*/
select @w_funcionario_mod=fu_funcionario
from   cobis..cl_funcionario
where  fu_login = @s_user

--CONECCION CON CTA.CTE.
select @w_conexion_cc = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'CCD'
and    pa_producto = 'SBA'

--Fecha de proceso con la hora actual, control
--de clave unica para sb_ins_suspendidos 
select @w_fecha_susp =  dateadd (ms, DATEPART(ms, getdate()), 
                        dateadd (ss, DATEPART(ss, getdate()), 
                        dateadd (mi, DATEPART(mi, getdate()),   
                        dateadd (hh, DATEPART(hh, getdate()),
                        fp_fecha))))
from    cobis..ba_fecha_proceso

/* Obtener  para el identificador de los registros del inventario en la tabla temporal  */
/* Solamente para la primera transmision */
if @o_ssn = 0 
    select @o_ssn = @s_ssn

select @w_contador = 1


/***************************SUSPENSION DE INSTRUMENTOS EN CUSTODIA****************************/
if @i_localizacion = 'C'  
begin
    select @w_codigo_alterno=0
    /* Lazo para procesar los grupos de registros */
    while @w_contador <= 20
    begin   
        if @w_contador = 1
            select @w_registro = @i_grupo1
        if @w_contador = 2
            select @w_registro = @i_grupo2
        if @w_contador = 3
            select @w_registro = @i_grupo3
        if @w_contador = 4
            select @w_registro = @i_grupo4
        if @w_contador = 5
            select @w_registro = @i_grupo5
        if @w_contador = 6
            select @w_registro = @i_grupo6
        if @w_contador = 7
            select @w_registro = @i_grupo7
        if @w_contador = 8
            select @w_registro = @i_grupo8
        if @w_contador = 9
            select @w_registro = @i_grupo9
        if @w_contador = 10
            select @w_registro = @i_grupo10
        if @w_contador = 11
            select @w_registro = @i_grupo11
        if @w_contador = 12
            select @w_registro = @i_grupo12
        if @w_contador = 13
            select @w_registro = @i_grupo13
        if @w_contador = 14
            select @w_registro = @i_grupo14
        if @w_contador = 15
            select @w_registro = @i_grupo15
        if @w_contador = 16
            select @w_registro = @i_grupo16
        if @w_contador = 17
            select @w_registro = @i_grupo17
        if @w_contador = 18
            select @w_registro = @i_grupo18
        if @w_contador = 19
            select @w_registro = @i_grupo19
        if @w_contador = 20
            select @w_registro = @i_grupo20

        /* Si el registro tiene valores procesar */
        if @w_registro is not null
        begin       
            select @w_parametro = 0
            while (@w_parametro < 10) /* 10 campos del grid que deben ser procesados*/
            begin           
                select @w_parametro = @w_parametro + 1
                select @w_posicion  = charindex ('@', @w_registro)
                select @w_token     = substring (@w_registro, 1, @w_posicion-1)

                if @w_parametro =1
                    select @w_producto = convert (tinyint,@w_token)
                if @w_parametro =2
                    select @w_instrumento = convert (smallint,@w_token)
                if @w_parametro =3
                    select @w_sub_tipo = convert (int,@w_token)
                if @w_parametro =4
                    if @w_token is null
                        select @w_serie_literal=''
                    else
                        select @w_serie_literal = convert (varchar(10),@w_token)
                if @w_parametro =5
                    select @w_serie_desde = convert (money,@w_token)
                if @w_parametro =6
                    select @w_serie_hasta = convert (money,@w_token)
                if @w_parametro =7
                    select @w_area = convert (smallint,@w_token)
                if @w_parametro =8
                    if @w_token is null
                        select @w_func_area = null
                    else
                        select @w_func_area = convert (smallint,@w_token)
                if @w_parametro =9
                    select @w_motivo = @w_token
                if @w_parametro = 10
                    select @w_causa_rev = @w_token
                        
                select @w_registro = substring(@w_registro, @w_posicion+1, datalength(@w_registro))
            end /* while */

            /* Verificar que el registro no haya sido suspendido */         
            if exists ( select 1 from sb_ins_suspendidos
                        where   is_producto      = @w_producto 
                        and     is_instrumento   = @w_instrumento 
                        and     is_sub_tipo      = @w_sub_tipo 
                        and     is_serie_literal = @w_serie_literal 
                        and     ((@w_serie_desde <= is_serie_desde 
                                    and is_serie_hasta <= @w_serie_hasta) 
                                 or (@w_serie_desde >= is_serie_desde 
                                     and @w_serie_desde <= is_serie_hasta) 
                                 or (@w_serie_hasta <= is_serie_hasta 
                                     and @w_serie_hasta >= is_serie_desde) 
                                 or (@w_serie_desde >= is_serie_desde 
                                     and is_serie_hasta >= @w_serie_hasta)) 
                        and     is_oficina      = @s_ofi
                        and     is_func_hab     is null
                        and     is_fecha_hab    is null
                        and     is_motivo_hab   is null
                )
            begin
                /* La serie indicada para el instrumento ya ha sido suspendida */   
                    exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 2902636
                return 1                    
            end


            /* Seleccionar el registro del inventario */
            select @w_producto_inv      = ii_producto,
                   @w_instrumento_inv   = ii_instrumento,
                   @w_sub_tipo_inv      = ii_sub_tipo,
                   @w_serie_literal_inv = ii_serie_literal,
                   @w_serie_desde_inv   = ii_serie_desde,
                   @w_serie_hasta_inv   = ii_serie_hasta,
                   @w_area_inv          = ii_area,
                   @w_func_area_inv     = ii_func_area,
                   @w_asignacion_inv    = ii_asignacion,
                   @w_reservados_inv    = ii_reservado
            from   sb_inventario_ins
            where  ii_oficina       = @s_ofi 
            and    ii_producto      = @w_producto 
            and    ii_instrumento   = @w_instrumento 
            and    ii_sub_tipo      = @w_sub_tipo 
            and    ii_serie_literal = isnull(@w_serie_literal,'')
            and    ii_serie_desde  <= @w_serie_desde 
            and    ii_serie_hasta  >= @w_serie_hasta 
            and    ii_area          = @w_area 
            --and    (ii_func_area     = @w_func_area or @w_func_area is null)

            if @@rowcount = 0
            begin
                print cast(@s_ofi as varchar) + '*' + cast(@w_producto as varchar) + '*' + cast ( @w_instrumento as varchar) +  '*' + cast ( @w_sub_tipo as varchar) + '*'
                print '*' + cast(@w_serie_literal as varchar) + '*' + cast( @w_serie_desde as varchar) + '*' + cast( @w_serie_hasta as varchar) +  '*' + cast (@w_area as varchar) + '*'
                print cast(@w_func_area as varchar)
                /*No existen registros */
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file, 
                    @t_from  = @w_sp_name,
                    @i_num   = 2902502
                return 1
            end

            begin tran
            /*ACTUALIZAR PUNTOS DE REORDEN*/
            /*seleccionar el registro origen a modificar*/
            select @v_area_reorden         = pr_area,
                   @v_func_area_reorden    = pr_func_area,
                   @v_producto_reorden     = pr_producto,
                   @v_instrumento_reorden  = pr_instrumento,
                   @v_sub_tipo_reorden     = pr_sub_tipo,
                   @v_maximo_reorden       = pr_maximo,
                   @v_minimo_reorden       = pr_minimo,
                   @v_actual_reorden       = pr_actual, 
                   @v_secuencial           = pr_secuencial  
            from   sb_puntos_reorden
            where  pr_oficina      = @s_ofi              and
                   pr_area         = @w_area_inv         and
                   --pr_func_area    = @w_func_area_inv    and
                   pr_producto     = @w_producto_inv     and     
                   pr_instrumento  = @w_instrumento_inv  and 
                   pr_sub_tipo     = @w_sub_tipo_inv 

            /* Calcular el reorden actual */
            select @w_reorden = @w_serie_hasta - @w_serie_desde + 1

            /*modificar registro origen*/
            update sb_puntos_reorden
            set    pr_actual       = @v_actual_reorden - @w_reorden,
                   pr_func_modif   = @w_funcionario_mod,
                   pr_fecha_modif  = @s_date,
                   pr_egreso       = pr_egreso + @w_reorden
            where  pr_secuencial   = @v_secuencial
    
            /*verificar errores*/
            if (@@error<>0 or @@rowcount=0)
            begin
                /*no se pudo actualizar registro en puntos de reorden*/
                exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902577
                rollback tran
                return 1    
            end 

            /* Transaccion de servicio: incertar registro antiguo*/     
            select @w_codigo_alterno = @w_codigo_alterno + 1
            insert into ts_puntos_reorden
                     (secuencial,        cod_alterno,         tipo_transaccion,       clase,                fecha,
                      hora,              usuario,             terminal,               oficina,              tabla,
                      lsrv,              srv,                 area,                   func_area,            fecha_modif,
                      func_modif,        producto,            instrumento,            sub_tipo,             maximo,
                      minimo,            actual)                                                            
            values  (@s_ssn,             @w_codigo_alterno,   @t_trn,                 'O',                  @s_date,
                     @w_hora,            @s_user,             @s_term,                @s_ofi,               'sb_puntos_reorden',
                     @s_lsrv,            @s_srv,              @v_area_reorden,        @v_func_area_reorden, @s_date,
                     @w_funcionario_mod, @v_producto_reorden, @v_instrumento_reorden, @v_sub_tipo_reorden,  @v_maximo_reorden,
                     @v_minimo_reorden,  @v_actual_reorden)
            
            /*Si no se pudo actualizar transaccion de servicio*/
            if (@@error<>0 or @@rowcount=0)
            begin
                exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902515
                rollback tran
                return 1    
            end 
    
            /* Transaccion de servicio: incertar registro actual*/          
            select @w_codigo_alterno = @w_codigo_alterno+1
            insert into ts_puntos_reorden
                     (secuencial, cod_alterno, tipo_transaccion,clase,fecha,hora,usuario,
                      terminal,   oficina,     tabla,lsrv,srv,area,func_area,fecha_modif,func_modif,
                      producto,   instrumento, sub_tipo,maximo,minimo,actual)
            values  (@s_ssn,@w_codigo_alterno,@t_trn,'C',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                     'sb_puntos_reorden',@s_lsrv,@s_srv,@v_area_reorden,
                     @v_func_area_reorden,@s_date,@w_funcionario_mod,
                     @v_producto_reorden,
                     @v_instrumento_reorden, @v_sub_tipo_reorden,
                     @v_maximo_reorden,@v_minimo_reorden,
                     @v_actual_reorden-@w_reorden)
        
            /*Si no se pudo actualizar transaccion de servicio*/
            if (@@error<>0 or @@rowcount=0)
            begin
                exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902515
                rollback tran
                return 1    
            end 

            /* ACTUALIZAR EL INVENTARIO DE INSTRUMENTOS */
            /* Si los suspendidos comprenden todo el registro */
            /* O si los suspendidos est n en la mitad del registro del inv */
            if (@w_serie_desde = @w_serie_desde_inv) and (@w_serie_hasta = @w_serie_hasta_inv)
            begin
                /* Borrar el registro del inventario */
                delete sb_inventario_ins
                where  ii_oficina       = @s_ofi 
                and    ii_producto      = @w_producto_inv 
                and    ii_instrumento   = @w_instrumento_inv 
                and    ii_sub_tipo      = @w_sub_tipo_inv 
                and    ii_serie_literal = @w_serie_literal_inv
                and    ii_serie_desde   = @w_serie_desde_inv 
                and    ii_serie_hasta   = @w_serie_hasta_inv 
                and    ii_area          = @w_area_inv 
                --and    ii_func_area    = @w_func_area_inv
    
                /*Si no se pudo eliminar*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902570
                    rollback tran
                    return 1    
                end

                /* Transaccion de servicio: insertar valor a eliminar*/     
                select @w_codigo_alterno = @w_codigo_alterno + 1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values(@s_ssn,@w_codigo_alterno,@t_trn,'D',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,@w_serie_literal_inv,@w_serie_desde_inv,
                    @w_serie_hasta_inv,@w_area_inv,@w_func_area_inv,@w_asignacion_inv)
    
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                    rollback tran
                    return 1    
                end 
            end

            /* Si los suspendidos pertenecen al inicio del registro del inv */
            if (@w_serie_desde = @w_serie_desde_inv) and (@w_serie_hasta < @w_serie_hasta_inv)
            begin
                /* Actualizar registro del inventario */
                update sb_inventario_ins
                set    ii_serie_desde  = @w_serie_hasta + 1,
                       ii_disponible   = ii_disponible - @w_reorden
                where  ii_oficina      = @s_ofi 
                and    ii_producto     = @w_producto 
                and    ii_instrumento  = @w_instrumento 
                and    ii_sub_tipo     = @w_sub_tipo 
                and    ii_serie_literal= @w_serie_literal
                and    ii_serie_desde  = @w_serie_desde 
                and    ii_serie_hasta  > @w_serie_hasta 
                and    ii_area         = @w_area 
                --and    (ii_func_area    = @w_func_area or @w_func_area is null)

                /* Transaccion de servicio: valor original */           
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_desde_inv,@w_serie_desde_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     

                /* Transaccion de servicio: valor nuevo */              
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_hasta + 1,@w_serie_desde_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     
            end 
            
            /* Si los suspendidos pertenecen al final del registro del inv */
            if (@w_serie_desde > @w_serie_desde_inv) and (@w_serie_hasta = @w_serie_hasta_inv)
            begin
                /* Actualizar registro del inventario */
                update sb_inventario_ins
                set    ii_serie_hasta  = @w_serie_desde - 1,
                       ii_disponible   = ii_disponible - @w_reorden
                where  ii_oficina       = @s_ofi 
                and    ii_producto      = @w_producto 
                and    ii_instrumento   = @w_instrumento 
                and    ii_sub_tipo      = @w_sub_tipo 
                and    ii_serie_literal = @w_serie_literal 
                and    ii_serie_desde   < @w_serie_desde 
                and    ii_serie_hasta   = @w_serie_hasta 
                and    ii_area          = @w_area 
                --and    ii_func_area     = @w_func_area 

                /* Transaccion de servicio: valor original */               
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_desde_inv,@w_serie_hasta_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     

                /* Transaccion de servicio: valor nuevo */              
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_desde_inv,@w_serie_desde - 1,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     
            end 

            /* Si los suspendidos se encuentran en la mitad del registro del inv */
            if (@w_serie_desde > @w_serie_desde_inv) and (@w_serie_hasta < @w_serie_hasta_inv)
            begin
                /* Calcular los disponibles */
                select @w_disponibles = (@w_serie_desde - 1) - @w_serie_desde_inv + 1
    
                /* Actualizar registro dejando las primeras series */
                update sb_inventario_ins
                set    ii_serie_hasta  = @w_serie_desde - 1,
                       ii_disponible   = @w_disponibles
                where  ii_oficina       = @s_ofi 
                and    ii_producto      = @w_producto 
                and    ii_instrumento   = @w_instrumento 
                and    ii_sub_tipo      = @w_sub_tipo 
                and    ii_serie_literal = @w_serie_literal 
                and    ii_serie_desde   = @w_serie_desde_inv
                and    ii_serie_hasta   = @w_serie_hasta_inv 
                and    ii_area          = @w_area 
                --and    (ii_func_area     = @w_func_area or @w_func_area is null)

                /* Transaccion de servicio: valor original */               
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_desde_inv,@w_serie_hasta_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     

                /* Transaccion de servicio: valor nuevo */              
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_desde_inv,@w_serie_desde - 1,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     

                /* Calcular los disponibles */
                select @w_disponibles = @w_serie_hasta_inv - (@w_serie_hasta + 1) + 1
                
                /* Insertar registro de las £ltimas series */
                insert into sb_inventario_ins
                (ii_oficina,ii_producto,ii_instrumento,ii_sub_tipo,ii_serie_literal,
                ii_serie_desde,ii_serie_hasta,ii_area,ii_func_area,ii_asignacion,
                ii_disponible,ii_reservado)

                values  (@s_ofi,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_hasta + 1,@w_serie_hasta_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv,@w_disponibles,@w_reservados_inv)

                /* Si ocurrio alg£n error en el ingreso */               
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902568
                    rollback tran
                    return 1    
                end

                /* Transaccion de servicio: incertar nuevo valor*/              
                select @w_codigo_alterno=@w_codigo_alterno+1
                insert into ts_inventario_ins
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,area,func_area,asignacion)

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_inventario_ins',@s_lsrv,@s_srv,@w_producto_inv,@w_instrumento_inv,@w_sub_tipo_inv,
                    @w_serie_literal_inv,@w_serie_hasta + 1,@w_serie_hasta_inv,
                    @w_area_inv,@w_func_area_inv,@w_asignacion_inv)
                
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                        rollback tran
                    return 1    
                end     
            end 

            --SECUENCIAL
            /* Buscar codigo para ins_suspendido */
            exec @w_return = sp_cseqnos
                @t_debug     = null,
                @t_file      = null,
                @t_from      = @w_sp_name,
                @i_tabla     = 'sb_ins_suspendidos',
                @o_siguiente = @w_seqnos out

            if @w_return <> 0
            begin
                /* 'No se puede obtener codigo para instrumento suspendido' */
                exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 2902593
                rollback
                return 1
            end

        

            /*ACTUALIZAR TABLA DE INSTRUMENTOS SUSPENDIDOS*/
            insert into sb_ins_suspendidos
            (is_oficina,is_producto,is_instrumento,is_sub_tipo,is_serie_literal,
            is_serie_desde,is_serie_hasta,is_localizacion,is_area,is_func_area,
            is_func_susp,is_fecha_susp,is_motivo_susp,is_secuencial)

            values  (@s_ofi,@w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_area,@w_func_area,
                @w_funcionario_mod,@w_fecha_susp,@w_motivo,@w_seqnos)

            /*Si no se pudo ingresar*/
            if (@@error<>0 or @@rowcount=0)
            begin
                /*no se pudo ingresar registro en instrumentos suspendidos*/
                exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902599
                rollback tran
                return 1    
            end         

            select @w_codigo_alterno=@w_codigo_alterno+1
            /*insertar registro en transaccion de servicio*/
            insert into ts_ins_suspendidos
            (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario, 
            terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
            serie_desde,serie_hasta,localizacion,area,func_area,motivo_susp) 

            values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,
                @s_user,@s_term,@s_ofi,'sb_ins_suspendidos',@s_lsrv,@s_srv,
                @w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_area,
                @w_func_area,@w_motivo)

            /*Si no se pudo actualizar transaccion de servicio*/
            if (@@error<>0 or @@rowcount=0)
            begin
                exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902515
                rollback tran
                return 1    
            end

            -- Si los instrumentos a ser suspendidos tienen interfaz con 
            -- cc entonces anularlos tambi‚n en cc  
            select  @w_enlace_cc = si_enlace_cc
            from sb_subtipos_ins
            where   si_cod_producto     = @w_producto
            and     si_cod_instrumento  = @w_instrumento
            and si_cod_subtipo      = @w_sub_tipo
            

            /**LLAMADA Al SP ANULA CHEQUES DE GERENCIA EN CC**/
            /*************************************************/
            if @w_enlace_cc = 'S' and @w_conexion_cc = 'S'
            begin
                select @w_codigo_alterno = @w_codigo_alterno + 1

                /*buscar la moneda del instrumento*/
                select @w_moneda= in_moneda
                from   sb_instrumentos
                where  in_cod_producto    = @w_producto and
                       in_cod_instrumento = @w_instrumento

                /* Buscar cuenta de gerencia para la oficina */
                select @w_cta_ger = cg_cuenta
                from cob_cuentas..cc_cta_gerencia
                where   cg_oficina = @s_ofi
                and     cg_moneda = @w_moneda
                                        
                exec @w_return = cob_cuentas..sp_tr_anl_chq_ncosto
                    @s_srv      = @s_srv,
                    @s_lsrv     = @s_lsrv,
                    @s_ssn      = @s_ssn,
                    @s_rol      = @s_rol,
                    @s_ofi      = @s_ofi,
                    @s_date     = @s_date,
                    @s_user     = @s_user,
                    @s_sesn     = @s_sesn,
                    @s_term     = @s_term,
                    @s_org      = @s_org,
                    @t_trn      = 2507,
                    @i_cta      = @w_cta_ger,
                    @i_mon      = @w_moneda,
                    @i_desde    = @w_serie_desde,
                    @i_hasta    = @w_serie_hasta,
                    @i_clase    = 'P',   /* cc_clase_np : (P)Permanente  */
                    @i_causa    = @w_causa_rev,
                    @i_aut      = @s_user,
                    @i_alt      = @w_codigo_alterno

                if @w_return <> 0
                begin
                    /* 'Error en anulacion de instrumento en CC' */
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 2902647
                    rollback
                    return 1
                end
            end
            commit tran
        end /*end if*/
        select @w_contador = @w_contador + 1
    end /*while*/
end



/***************************SUSPENSION DE INSTRUMENTOS NEGOCIADOS****************************/
if @i_localizacion='N'
begin
    if @o_cod_alter is null
        select @w_codigo_alterno=0
    else
        select @w_codigo_alterno=@o_cod_alter   

    /* Lazo para procesar los grupos de registros */
    while @w_contador <= 20
    begin
    
        if @w_contador = 1
            select @w_registro = @i_grupo1
        if @w_contador = 2
            select @w_registro = @i_grupo2
        if @w_contador = 3
            select @w_registro = @i_grupo3
        if @w_contador = 4
            select @w_registro = @i_grupo4
        if @w_contador = 5
            select @w_registro = @i_grupo5
        if @w_contador = 6
            select @w_registro = @i_grupo6
        if @w_contador = 7
            select @w_registro = @i_grupo7
        if @w_contador = 8
            select @w_registro = @i_grupo8
        if @w_contador = 9
            select @w_registro = @i_grupo9
        if @w_contador = 10
            select @w_registro = @i_grupo10
        if @w_contador = 11
            select @w_registro = @i_grupo11
        if @w_contador = 12
            select @w_registro = @i_grupo12
        if @w_contador = 13
            select @w_registro = @i_grupo13
        if @w_contador = 14
            select @w_registro = @i_grupo14
        if @w_contador = 15
            select @w_registro = @i_grupo15
        if @w_contador = 16
            select @w_registro = @i_grupo16
        if @w_contador = 17
            select @w_registro = @i_grupo17
        if @w_contador = 18
            select @w_registro = @i_grupo18
        if @w_contador = 19
            select @w_registro = @i_grupo19
        if @w_contador = 20
            select @w_registro = @i_grupo20
        
        /* Si el registro tiene valores procesar */
        if @w_registro is not null
        begin       
            select @w_parametro = 0
            while (@w_parametro < 12) /* 12 campos del grid que deben ser procesados*/
            begin           
                select @w_parametro = @w_parametro + 1
                select @w_posicion = charindex('@', @w_registro)
                select @w_token = substring(@w_registro, 1, @w_posicion-1)

                if @w_parametro =1
                    select @w_producto = convert (tinyint,@w_token)
                if @w_parametro =2
                    select @w_instrumento = convert (smallint,@w_token)
                if @w_parametro =3
                    select @w_sub_tipo = convert (int,@w_token)
                if @w_parametro =4
                    if @w_token is null
                        select @w_serie_literal=''
                    else
                        select @w_serie_literal = convert (varchar(10),@w_token)
                if @w_parametro =5
                    select @w_serie_desde = convert (money,@w_token)
                if @w_parametro =6
                    select @w_serie_hasta = convert (money,@w_token)
                if @w_parametro =7
                    select @w_cod_operacion = convert (int,@w_token)
                if @w_parametro =8
                    select @w_sec_producto = convert (smallint,@w_token)                    
                if @w_parametro =9
                    select @w_motivo = @w_token
                if @w_parametro =10
                    select @w_valor = convert(money,@w_token)   
                if @w_parametro =11
                    select @w_beneficiario = @w_token
                if @w_parametro = 12
                    select @w_causa_rev = @w_token
                        
                select @w_registro = substring(@w_registro, @w_posicion+1, datalength(@w_registro))
            end /* while */

            /* Verificar que el registro no haya sido suspendido */         
            if exists ( select 1 from sb_ins_suspendidos
                        where  is_producto      = @w_producto 
                        and is_instrumento   = @w_instrumento 
                        and is_sub_tipo      = @w_sub_tipo 
                        and is_serie_literal = @w_serie_literal 
                        and ((@w_serie_desde <= is_serie_desde 
                                and is_serie_hasta <= @w_serie_hasta) 
                             or (@w_serie_desde >= is_serie_desde 
                                 and @w_serie_desde <= is_serie_hasta) 
                             or (@w_serie_hasta <= is_serie_hasta 
                                 and @w_serie_hasta >= is_serie_desde) 
                             or (@w_serie_desde >= is_serie_desde 
                                 and is_serie_hasta >= @w_serie_hasta)) 
                        and  is_cod_operacion = @w_cod_operacion
                        and  is_func_hab      is null
                        and  is_fecha_hab     is null
                        and  is_motivo_hab    is null
                )           
            begin
                /* La serie indicada para el instrumento ya ha sido suspendida */   
                    exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 2902636
                return 1                    
            end

            begin tran
                /* Seleccionar el registro original de series negociadas */
                select @w_operacion_series = sn_cod_operacion,
                       @w_sec_producto_series  = sn_sec_producto,
                       @w_estado_series    = sn_estado,
                       @w_literal_series   = sn_serie_literal,
                       @w_desde_series     = sn_serie_desde,
                       @w_hasta_series     = sn_serie_hasta
                from   sb_series_neg
                where  sn_cod_operacion    = @w_cod_operacion 
                and    sn_sec_producto     = @w_sec_producto 
                and    sn_estado           = 'E' 
                and    sn_serie_literal    = @w_serie_literal  
                and    sn_serie_desde      <= @w_serie_desde 
                and    sn_serie_hasta      >= @w_serie_hasta
                
                /*buscar si el subtipo tiene o no enlace con CC */
                select @w_enlace_cc= si_enlace_cc 
                from   sb_subtipos_ins
                where  si_cod_producto    = @w_producto and
                       si_cod_instrumento = @w_instrumento and
                       si_cod_subtipo     = @w_sub_tipo
            
                /* Si existe enlace con CC anular instrumento en ctas. corrientes/ahorros */
                if @w_enlace_cc = 'S'
                begin
                    /*buscar la moneda del instrumento*/
                    select @w_moneda= in_moneda
                    from   sb_instrumentos
                    where  in_cod_producto=@w_producto and
                           in_cod_instrumento=@w_instrumento           
                
                    /* Buscar cuenta de gerencia para la oficina donde se origino la operacion*/                    
                    select @w_cta_ger = cg_cuenta
                    from   cob_cuentas..cc_cta_gerencia a, sb_operacion b
                    where  a.cg_oficina        = b.op_oficina 
                    and    b.op_cod_operacion  = @w_cod_operacion
                    and    a.cg_moneda     = @w_moneda
                    
                    /* Revocar el cheque */
                    exec @w_return = cob_cuentas..sp_revocatoria_cheques
                         @s_srv      = @s_srv,
                         @s_lsrv     = @s_lsrv,
                         @s_ssn      = @s_ssn,
                         @s_rol      = @s_rol,
                         @s_ofi      = @s_ofi,
                         @s_date     = @s_date,
                         @s_user     = @s_user,
                         @s_term     = @s_term,
                         @t_trn      = @t_trn,
                         @i_cta      = @w_cta_ger,
                         @i_cau      = 'T',      /* cc_causa_np : (T)Destruccion */
                         @i_cla      = 'P',      /* cc_clase_np : (P)Permanente  */
                         @i_nchq     = @w_serie_desde,
                         @i_valch    = @w_valor,
                         @i_mon      = @w_moneda,
                         @i_factor   = 1,
                         @i_fecha    = @s_date,
                         @i_benef    = @w_beneficiario               

                        if @w_return <> 0
                        begin
                            /* 'Error en anulacion de instrumento en CC' */
                            exec cobis..sp_cerror
                                @t_debug = @t_debug,
                                @t_file  = @t_file,
                                @t_from  = @w_sp_name,
                                @i_num   = 2902647
                            rollback
                            return 1
                        end 
                end
                    
                /*MODIFICAR ESTADO A SUSPENDIDO DEL REGISTRO EN SERIES DE INSTRUMENTOS NEGOCIADOS*/             
                /* Si las series a suspender corresponden a las mismas del registro */
                if @w_serie_desde = @w_desde_series and @w_serie_hasta = @w_hasta_series
                begin                   
                    update sb_series_neg
                    set    sn_estado='S'
                    where  sn_cod_operacion    = @w_cod_operacion 
                    and    sn_sec_producto     = @w_sec_producto 
                    and    sn_serie_literal    = @w_serie_literal
                    and    sn_serie_desde      = @w_serie_desde 
                    and    sn_serie_hasta      = @w_serie_hasta
                
                    /*si no se puede actualizar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo actualizar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      =  2902598
                        rollback tran
                        return 1    
                    end 
                end
                else
                begin
                    /*modificar registro con estado y series a suspender*/                  
                    update sb_series_neg
                    set    sn_estado       = 'S',
                           sn_serie_desde  = @w_serie_desde,
                           sn_serie_hasta  = @w_serie_hasta
                    where  sn_cod_operacion = @w_cod_operacion 
                    and    sn_sec_producto  = @w_sec_producto 
                    and    sn_serie_literal = @w_serie_literal 
                    and    sn_serie_desde  <= @w_serie_desde 
                    and    sn_serie_hasta  >= @w_serie_hasta
                
                    /*si no se puede actualizar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo actualizar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      =  2902598
                        rollback tran
                        return 1    
                    end                     
                end 

                /*CREAR REGISTROS RESTANTES EN LA TABLA DE SERIES DE PRODUCTOS NEGOCIADOS*/
                /*Si el instrumento suspendido es intermedio en la serie desde y hasta del instrumento seleccionado*/
                if @w_desde_series<@w_serie_desde and @w_hasta_series>@w_serie_hasta
                begin           
                    
        
                    /*crear el primer registro*/
                    insert into sb_series_neg
                    (sn_cod_operacion,sn_sec_producto,sn_estado,sn_serie_literal,
                    sn_serie_desde,sn_serie_hasta)

                    values(@w_operacion_series,@w_sec_producto_series,@w_estado_series,
                    @w_literal_series,@w_desde_series,@w_serie_desde-1)

                    /*si no se puede actualizar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo ingresar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      =  2902605
                        rollback tran
                        return 1    
                    end 

                    /*crear el segundo registro*/                   
        
                    insert into sb_series_neg
                    (sn_cod_operacion,sn_sec_producto,sn_estado,sn_serie_literal,
                    sn_serie_desde,sn_serie_hasta)

                    values(@w_operacion_series,@w_sec_producto_series,@w_estado_series,
                    @w_literal_series,@w_serie_hasta+1,@w_hasta_series)

                    /*si no se puede actualizar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo ingresar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      = 2902605
                        rollback tran
                        return 1    
                    end 
                end

                /* si la serie de los instrumentos a suspender esta al inicio*/
                if @w_serie_desde=@w_desde_series and @w_serie_hasta<@w_hasta_series
                begin                   
                    /*crear  registro*/
                    insert into sb_series_neg
                    (sn_cod_operacion,sn_sec_producto,sn_estado,sn_serie_literal,
                    sn_serie_desde,sn_serie_hasta)

                    values(@w_operacion_series,@w_sec_producto_series,@w_estado_series,
                    @w_literal_series,@w_serie_hasta+1,@w_hasta_series)

                    /*si no se puede actualizar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo ingresar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      = 2902605
                        rollback tran
                        return 1    
                    end 
                end

                /* si las serie de los instrumentos a suspender esta al final*/
                if @w_desde_series<@w_serie_desde and @w_serie_hasta=@w_hasta_series
                begin       
                    
                    /*crear  registro*/
                    insert into sb_series_neg
                    (sn_cod_operacion,sn_sec_producto,sn_estado,sn_serie_literal,
                    sn_serie_desde,sn_serie_hasta)

                    values(@w_operacion_series,@w_sec_producto_series,@w_estado_series,
                    @w_literal_series,@w_desde_series,@w_serie_desde-1)

                    /*si no se puede ingresar registro*/
                    if (@@error<>0 or @@rowcount=0)
                    begin
                        /*No se pudo actualizar registro de 
                        series de instrumentos negociados*/
                        exec cobis..sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      = 2902605
                        rollback tran
                        return 1    
                    end 
                end

                /*INGRESAR REGISTRO EN INSTRUMENTOS SUSPENDIDOS*/
                --SECUENCIAL
                /* Buscar codigo para secuencial de instrumento */
                exec @w_return = sp_cseqnos
                    @t_debug    = null,
                    @t_file     = null,
                    @t_from     = @w_sp_name,
                    @i_tabla    = 'sb_ins_suspendidos',
                    @o_siguiente    = @w_seqnos out

                if @w_return <> 0
                begin
                    /* 'No se puede obtener codigo para instrumento suspendido' */
                    exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902593
                    rollback
                    return 1
                end


                insert into sb_ins_suspendidos
                (is_oficina,is_producto,is_instrumento,is_sub_tipo,is_serie_literal,
                is_serie_desde,is_serie_hasta,is_localizacion,is_cod_operacion,is_sec_producto,
                is_func_susp,is_fecha_susp,is_motivo_susp,is_secuencial)

                values(@s_ofi,  @w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                    @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_cod_operacion,
                    @w_sec_producto,@w_funcionario_mod,@w_fecha_susp,@w_motivo, @w_seqnos)

                /*Si no se pudo ingresar*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    /*no se pudo ingresar registro en instrumentos suspendidos*/
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902599
                    rollback tran
                    return 1    
                end         

                select @w_codigo_alterno=@w_codigo_alterno+1
                /*insertar registro en transaccion de servicio*/
                insert into ts_ins_suspendidos
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,localizacion,cod_operacion,sec_producto,motivo_susp) 

                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,
                    @s_user,@s_term,@s_ofi,'sb_ins_suspendidos',@s_lsrv,@s_srv,
                    @w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                    @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_cod_operacion,
                    @w_sec_producto,@w_motivo)
    
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                    rollback tran
                    return 1    
                end             
                    
            commit tran
        end /*end if*/
        select @w_contador = @w_contador + 1
    end /*while*/
    select @o_cod_alter=@w_codigo_alterno
end 


/*************************SUSPENSION DE INSTRUMENTOS DE IMPRESION EN LOTES**************************/
if @i_localizacion = 'L' AND @i_prod_cobis = 42
begin
    select @w_codigo_alterno = 0
    
    
    --  LAZO PARA PROCESAR LOS GRUPOS DE REGISTROS 
    while @w_contador <= 20
    begin   
        if @w_contador = 1
            select @w_registro = @i_grupo1
        if @w_contador = 2
            select @w_registro = @i_grupo2
        if @w_contador = 3
            select @w_registro = @i_grupo3
        if @w_contador = 4
            select @w_registro = @i_grupo4
        if @w_contador = 5
            select @w_registro = @i_grupo5
        if @w_contador = 6
            select @w_registro = @i_grupo6
        if @w_contador = 7
            select @w_registro = @i_grupo7
        if @w_contador = 8
            select @w_registro = @i_grupo8
        if @w_contador = 9
            select @w_registro = @i_grupo9
        if @w_contador = 10
            select @w_registro = @i_grupo10
        if @w_contador = 11
            select @w_registro = @i_grupo11
        if @w_contador = 12
            select @w_registro = @i_grupo12
        if @w_contador = 13
            select @w_registro = @i_grupo13
        if @w_contador = 14
            select @w_registro = @i_grupo14
        if @w_contador = 15
            select @w_registro = @i_grupo15
        if @w_contador = 16
            select @w_registro = @i_grupo16
        if @w_contador = 17
            select @w_registro = @i_grupo17
        if @w_contador = 18
            select @w_registro = @i_grupo18
        if @w_contador = 19
            select @w_registro = @i_grupo19
        if @w_contador = 20
            select @w_registro = @i_grupo20
        
        
        
        --  SI EL REGISTRO TIENE VALORES PROCESAR 
        if @w_registro is not null
        begin       
        
        
            select @w_parametro = 0
        
            --  CAMPOS DEL GRID QUE DEBEN SER PROCESADOS
            while (@w_parametro < 12) 
            begin           
                select @w_parametro = @w_parametro + 1
                select @w_posicion = charindex('@', @w_registro)
                select @w_token = substring(@w_registro, 1, @w_posicion-1)

                if @w_parametro =1
                    select @w_producto = convert (tinyint,@w_token)
                if @w_parametro =2
                    select @w_instrumento = convert (smallint,@w_token)
                if @w_parametro =3
                    select @w_sub_tipo = convert (int,@w_token)
                if @w_parametro =4
                    if @w_token is null
                        select @w_serie_literal = ''
                    else
                        select @w_serie_literal = convert (varchar(10),@w_token)
                if @w_parametro =5
                    select @w_serie_desde = convert (money,@w_token)
                if @w_parametro =6
                    select @w_serie_hasta = convert (money,@w_token)
                if @w_parametro =8
                    select @w_sec_lote = convert (int,@w_token)
                if @w_parametro =9
                    select @w_motivo = @w_token
                if @w_parametro =10
                    select @w_valor = convert(money,@w_token)   
                if @w_parametro =11
                    select @w_beneficiario = @w_token
                if @w_parametro = 12
                    select @w_causa_rev = @w_token
                        
                select @w_registro = substring(@w_registro, @w_posicion + 1, datalength(@w_registro))
            end 
            --  FIN DEL WHILE PARA OBTENER LOS VALORES DEL GRID



            --  VERIFICAR QUE EL REGISTRO NO HAYA SIDO SUSPENDIDO           
            if exists ( select 1 from sb_ins_suspendidos
                    where   is_producto      = @w_producto 
                    and is_instrumento   = @w_instrumento 
                    and is_sub_tipo      = @w_sub_tipo 
                    and     is_serie_literal = @w_serie_literal 
                    and (   (@w_serie_desde <= is_serie_desde 
                            and is_serie_hasta <= @w_serie_hasta) 
                        or (@w_serie_desde >= is_serie_desde 
                             and @w_serie_desde <= is_serie_hasta) 
                         or (@w_serie_hasta <= is_serie_hasta 
                             and @w_serie_hasta >= is_serie_desde) 
                         or (@w_serie_desde >= is_serie_desde 
                             and is_serie_hasta >= @w_serie_hasta))
                    and     is_sec_lote     =  @w_sec_lote
                    and     is_func_hab     is null
                    and     is_fecha_hab    is null
                    and     is_motivo_hab   is null
                 )
            begin
                -- LA SERIE INDICADA PARA EL INSTRUMENTO YA HA SIDO SUSPENDIDA 
                    exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                            @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 2902636
                return 1                    
            end
            


            ------------------------------------------------------------------
            --  INICIO DE LA TRANSACCION DE SUSPENSION DEL INSTRUMENTO
            --  EN IMPRESION LOTES
            ------------------------------------------------------------------
            BEGIN TRAN 

                --  OBTENER VALORES ORIGINALES PARA REGISTRAR TRANSACCION DE SERVICIO
                select  @v_id_lote    = il_idlote,
                        @v_secuencial = il_secuencial,
                        @v_estado     = il_estado,
                        @v_func_imp   = il_func_imprime,              
                        @v_fechaimp   = il_fecha_impresion,
                        @v_func_aut   = il_func_autorizante,
                        @v_serielit   = il_serie_literal,         
                        @v_serienum   = il_serie_numerica             
                from    sb_impresion_lotes
                where   il_secuencial = @w_sec_lote
    
            
                --  ACTUALIZAR ESTADO DEL LOTE A SUSPENDIDO
                update  sb_impresion_lotes
                set     il_estado = 'S' 
                where   il_secuencial = @w_sec_lote
                if (@@error <> 0 or @@rowcount = 0)
                begin
                        exec cobis..sp_cerror
                            @t_debug  = @t_debug,
                            @t_file   = @t_file,
                            @t_from   = @w_sp_name,
                            @i_num    = 2902583
                            rollback
                            return 1
                end

                --  REGISTRAR TRANS DE SERVICIO CON LOS VALORES ORIGINALES 
                insert into ts_impresion_lotes
                values(@s_ssn,@v_secuencial,@t_trn,'O',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                    'sb_impresion_lotes',@s_lsrv,@s_srv,@v_id_lote,@v_secuencial,@v_estado,
                    @v_func_imp,@v_fechaimp,@v_func_aut,@v_serielit,@v_serienum)
                if (@@error <> 0 or @@rowcount = 0)
                begin 
                    exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,  
                    @i_num   = 2902515
                    rollback tran
                    return 1
                end     

            
                --  REGISTRAR TRANS DE SERVICIO CON LOS VALORES ACTUALES
                insert into ts_impresion_lotes
                values(@s_ssn,@w_sec_producto,@t_trn,'C',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                'sb_impresion_lotes',@s_lsrv,@s_srv,@v_id_lote,@v_secuencial,'S',
                @v_func_imp,@v_fechaimp,@v_func_aut,@v_serielit,@v_serienum)
                if (@@error <> 0 or @@rowcount = 0)
                begin 
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,  
                        @i_num   = 2902515
                    rollback tran
                    return 1
                end

            
            
                --  BUSCAR SI EL INSTRUMENTO A SUSPENDER TIENE ENLACE
                --  CON CUENTAS CORRIENTES
                select @w_enlace_cc= si_enlace_cc 
                from    sb_subtipos_ins
                where   si_cod_producto=@w_producto and
                    si_cod_instrumento=@w_instrumento and
                    si_cod_subtipo=@w_sub_tipo
            
            
                --  SI EL INSTRUMENTO TIENE ENLACE CON CUENTAS CORRIENTES
                --  AVISAR A ESTE MODULO DE LA SUSPENSION
                if @w_enlace_cc = 'S'
                begin
                    --  BUSCAR LA MONEDA DEL INSTRUMENTO
                    select  @w_moneda= in_moneda
                    from    sb_instrumentos
                    where   in_cod_producto=@w_producto and
                        in_cod_instrumento=@w_instrumento           
                
                    --  BUSCAR CUENTA DE GERENCIA PARA LA OFICINA DONDE SE IMPRIMI0 
                    --  EL DOCUMENTO 
                
                    select  @w_cta_ger = cg_cuenta
                    from    cob_cuentas..cc_cta_gerencia a, sb_impresion_lotes b
                    where   a.cg_oficina    = b.il_oficina_destino 
                    and     b.il_secuencial = @w_sec_lote
                    and     a.cg_moneda = @w_moneda

                    --  SUSPENDER EL CHEQUE EN CUENTAS CORRIENTES
                    exec @w_return = cob_cuentas..sp_revocatoria_cheques
                        @s_srv      = @s_srv,
                        @s_lsrv     = @s_lsrv,
                        @s_ssn      = @s_ssn,
                        @s_rol      = @s_rol,
                        @s_ofi      = @s_ofi,
                        @s_date     = @s_date,
                        @s_user     = @s_user,
                        @s_term     = @s_term,
                        @t_trn      = @t_trn,
                        @i_cta      = @w_cta_ger,
                        @i_cau      = 'T',      /* cc_causa_np : (T)Destruccion */
                        @i_cla      = 'P',      /* cc_clase_np : (P)Permanente  */
                        @i_nchq     = @w_serie_desde,
                        @i_valch    = @w_valor,
                        @i_mon      = @w_moneda,
                        @i_factor   = 1,
                        @i_fecha    = @s_date,
                        @i_benef    = @w_beneficiario               
                    if @w_return <> 0
                    begin
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 2902647
                        rollback
                        return 1
                    end 
                end

                --  REGISTRAR EL INSTRUMENTO EN LA TABLA DE SUSPENDIDOS
            
                --  OBTENER SECUENCIAL
                exec @w_return = sp_cseqnos
                    @t_debug    = null,
                    @t_file     = null,
                    @t_from     = @w_sp_name,
                    @i_tabla    = 'sb_ins_suspendidos',
                    @o_siguiente    = @w_seqnos out
                if @w_return <> 0
                begin
                    exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 2902593
                    rollback
                    return 1
                end

                --  INSERTAR EL INSTRUMENTO EN LA TABLA DE SUSPENDIDOS  
                insert into sb_ins_suspendidos
                (is_oficina,is_producto,is_instrumento,is_sub_tipo,is_serie_literal,
                is_serie_desde,is_serie_hasta,is_localizacion,is_sec_lote,
                is_func_susp,is_fecha_susp,is_motivo_susp,is_secuencial)

                values  (@s_ofi,@w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_sec_lote,
                @w_funcionario_mod,@w_fecha_susp,@w_motivo,@w_seqnos)
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902599
                    rollback tran
                    return 1    
                end         

                select @w_codigo_alterno = @w_codigo_alterno + 1

                --  INSERTAR REGISTRO EN TRANSACCION DE SERVICIO
                insert into ts_ins_suspendidos
                (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
                terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
                serie_desde,serie_hasta,localizacion,sec_lote,motivo_susp) 
    
                values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,
                    @s_user,@s_term,@s_ofi,'sb_ins_suspendidos',@s_lsrv,@s_srv,
                    @w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
                    @w_serie_desde,@w_serie_hasta,@i_localizacion,
                    @w_sec_lote,@w_motivo)
                if (@@error<>0 or @@rowcount=0)
                begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                    rollback tran
                    return 1    
                end

        
        
            COMMIT TRAN
            ------------------------------------------------------------------
            --  FIN : DE LA TRANSACCION DE SUSPENSION DEL INSTRUMENTO
            --  EN IMPRESION LOTES
            ------------------------------------------------------------------
        
        end 

        select @w_contador = @w_contador + 1
    end --  FIN lazo de registros while
end


---------------------------------------------------------
--  SUSSPENSION DE INSTRUMENTOS ORIGINADOS POR SIDAC
---------------------------------------------------------


if @i_localizacion = 'L' AND @i_prod_cobis = 48
begin
    
    -- PRINT 'ENTRANDO AL PROCESO SUSPENSION LOTE : %1!', @i_lote
    select  @w_sec_lote       = @i_lote,
            @w_secuencial     = null,
            @w_estado_series  = null  
                        
    select @w_secuencial   = il_secuencial,
           @w_serie_literal =  il_serie_literal,
           @w_estado_series = il_estado,   
           @w_producto     = il_producto,
           @w_instrumento  = il_instrumento,
           @w_sub_tipo     = il_subtipo,
           @w_serie_desde  = il_serie_numerica,
           @w_serie_hasta  = il_serie_numerica,    
           @w_valor    = il_valor, 
           @w_beneficiario  =il_beneficiario, 
           @w_oficina_destino   = il_oficina_destino 
    from   sb_impresion_lotes
    where  il_idlote = @w_sec_lote
    and    il_area_origen = @i_prod_cobis
    
    IF @w_secuencial IS  NULL
    BEGIN
        --    PRINT 'NO SE ENCONTRO LOTE'   
        exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 2903106 
        return 1                    
    END 

    --  PRINT 'SECUENCIAL  : %1!', @w_secuencial

    IF @w_estado_series = 'A'
    BEGIN
       -- LA SERIE INDICADA PARA EL INSTRUMENTO YA HA SIDO SUSPENDIDA 
       exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 2903107 --NOTA ASIGNAR CODIGO DE ERROR CORRECTO
       return 1                    
    END 

    ------------------------------------------------------------------
    --  INICIO DE LA TRANSACCION DE SUSPENSION DEL INSTRUMENTO
    --  EN IMPRESION LOTES
    ------------------------------------------------------------------
    BEGIN TRAN 

        --  print 'OBTENER VALORES ORIGINALES PARA REGISTRAR TRANSACCION DE SERVICIO'
        select @v_id_lote      = il_idlote,
               @v_secuencial   = il_secuencial,
               @v_estado       = il_estado,
               @v_func_imp     = il_func_imprime,              
               @v_fechaimp     = il_fecha_impresion,
               @v_func_aut     = il_func_autorizante,
               @v_serielit     = il_serie_literal,         
               @v_serienum     = il_serie_numerica             
        from   sb_impresion_lotes
        where  il_secuencial = @w_secuencial
        and    il_area_origen = 48
    
    
        --  print 'ACTUALIZAR ESTADO DEL LOTE A ANULADO'
        update  sb_impresion_lotes
        set     il_estado = 'A' 
        where   il_secuencial = @w_secuencial
                AND
                il_area_origen = 48
   
        if (@@error <> 0 or @@rowcount = 0)
        begin
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 2903108
           rollback
           return 1
        end

        --  print 'REGISTRAR TRANS DE SERVICIO CON LOS VALORES ORIGINALES'
        insert into ts_impresion_lotes
        values(
            @s_ssn,     @v_secuencial,      @t_trn,     'O',
            @s_date,    @w_hora,        @s_user,    @s_term,
            @s_ofi,     'sb_impresion_lotes',   @s_lsrv,    @s_srv,
            @v_id_lote, @v_secuencial,      @v_estado,  @v_func_imp,
            @v_fechaimp,    @v_func_aut,        @v_serielit,    @v_serienum)
        if (@@error <> 0 or @@rowcount = 0)
        begin 
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,  
               @i_num   = 2903109
            rollback tran
            return 1
        end     
    
        --  print 'REGISTRAR TRANS DE SERVICIO CON LOS VALORES ACTUALES'
        insert into ts_impresion_lotes
        values(@s_ssn,@w_sec_producto,@t_trn,'C',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
        'sb_impresion_lotes',@s_lsrv,@s_srv,@v_id_lote,@v_secuencial,'S',
        @v_func_imp,@v_fechaimp,@v_func_aut,@v_serielit,@v_serienum)
        if (@@error <> 0 or @@rowcount = 0)
        begin 
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,  
                @i_num   = 2903110
            rollback tran
            return 1
        end

        -- print 'BUSCAR SI EL INSTRUMENTO A SUSPENDER TIENE ENLACE CON CUENTAS CORRIENTES'
    
        select @w_enlace_cc= si_enlace_cc 
        from   sb_subtipos_ins
        where  si_cod_producto     = @w_producto 
        and    si_cod_instrumento  = @w_instrumento
        and    si_cod_subtipo      = @w_sub_tipo
    
    
        --    print 'SI EL INSTRUMENTO TIENE ENLACE CON CUENTAS CORRIENTES AVISAR A ESTE MODULO DE LA SUSPENSION'
        if @w_enlace_cc = 'S'
        begin
            --   print  'BUSCAR LA MONEDA DEL INSTRUMENTO'

            select  @w_moneda = null
            select  @w_moneda= in_moneda
            from    sb_instrumentos
            where   in_cod_producto=@w_producto and
                    in_cod_instrumento=@w_instrumento           

            if @w_moneda  is null
            begin                 
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,  
                    @i_num   = 2903111
                rollback tran
                return 1
            end

            --   print  'BUSCAR CUENTA DE GERENCIA PARA LA OFICINA DONDE SE IMPRIMI0 EL DOCUMENTO '

            select  @w_cta_ger = null
            select  @w_cta_ger = cg_cuenta
            from    cob_cuentas..cc_cta_gerencia
            where   cg_oficina  = @w_oficina_destino
            and     cg_moneda   = @w_moneda


            if @w_cta_ger is null
            begin
               --  print 'no se encontro cuenta de gerencia de la oficina: %1! moneda:%2!', @w_oficina_destino, @w_moneda
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,  
                    @i_num   = 2903112
               rollback tran
               return 1
            end 

            IF @w_estado_series = 'I'
            BEGIN
                    --  print 'ANULAR EL CHEQUE EN CUENTAS CORRIENTES cta gerencia : %1!',@w_cta_ger 
                    --  print '@w_serie_desde:%1! @w_valor:%2! @w_moneda:%3! @s_date:%4! @w_beneficiario:%5!', @w_serie_desde ,@w_valor, @w_moneda, @s_date, @w_beneficiario                
                    -->

                    exec @w_return = cob_cuentas..sp_tr_anl_chq_ncosto
                            @s_srv      = @s_srv,
                            @s_lsrv     = @s_lsrv,
                            @s_ssn      = @s_ssn,
                            @s_rol      = @s_rol,
                            @s_ofi      = @s_ofi,
                            @s_date     = @s_date,
                            @s_user     = @s_user,
                            @s_sesn     = @s_sesn,
                            @s_term     = @s_term,
                            @s_org      = @s_org,
                            @t_trn      = 2507,
                            --------------------------------
                            @i_cta      = @w_cta_ger,
                            @i_mon      = @w_moneda,
                            @i_desde    = @w_serie_desde,
                            @i_hasta    = @w_serie_desde,
                            @i_clase    = 'P',  /* cc_clase_np : (P)Permanente  */
                            @i_causa    = 'T',  /* cc_causa_np : (T)Destruccion */
                            @i_aut      = @s_user --,
                            --@i_alt        = @w_codigo_alterno

                    if @w_return <> 0
                    begin
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 2903113
                        rollback
                        return 1
                    end 
            END
            else
            begin
                -- SE INICIALIZAN PORQUE EN ESTADO DIFERENTE A I NO SE TIENEN ESTOS VALORES
                SELECT  @w_serie_desde = 0,
                        @w_serie_hasta = 0
            end
        end  --> FIN ENLACE CUENTAS CORRIENTES


        SELECT @w_motivo ='ANULACION CHEQUE DESDE SIDAC'
        

        --  REGISTRAR EL INSTRUMENTO EN LA TABLA DE SUSPENDIDOS
    
        --    print 'OBTENER SECUENCIAL sb_ins_suspendidos'
        exec @w_return = sp_cseqnos
            @t_debug     = null,
            @t_file      = null,
            @t_from      = @w_sp_name,
            @i_tabla     = 'sb_ins_suspendidos',
            @o_siguiente = @w_seqnos out
        if @w_return <> 0
        begin
            exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2903114
            rollback
            return 1
        end

        --    print     'INSERTAR EL INSTRUMENTO EN LA TABLA DE SUSPENDIDOS'
        insert into sb_ins_suspendidos
        (is_oficina,is_producto,is_instrumento,is_sub_tipo,is_serie_literal,
        is_serie_desde,is_serie_hasta,is_localizacion,is_sec_lote,
        is_func_susp,is_fecha_susp,is_motivo_susp,is_secuencial)

        values  (@s_ofi,@w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
        @w_serie_desde,@w_serie_hasta,@i_localizacion,@w_sec_lote,
        @w_funcionario_mod,@w_fecha_susp,@w_motivo,@w_seqnos)
        if (@@error<>0 or @@rowcount=0)
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 2903116
            rollback tran
            return 1    
        end         

        select @w_codigo_alterno = @w_codigo_alterno + 1

        print   'INSERTAR REGISTRO EN TRANSACCION DE SERVICIO'
        insert into ts_ins_suspendidos
        (secuencial,cod_alterno,tipo_transaccion,clase,fecha,hora,usuario,
        terminal,oficina,tabla,lsrv,srv,producto,instrumento,sub_tipo,serie_literal,
        serie_desde,serie_hasta,localizacion,sec_lote,motivo_susp) 
    
        values  (@s_ssn,@w_codigo_alterno,@t_trn,'N',@s_date,@w_hora,
            @s_user,@s_term,@s_ofi,'sb_ins_suspendidos',@s_lsrv,@s_srv,
            @w_producto,@w_instrumento,@w_sub_tipo,@w_serie_literal,
            @w_serie_desde,@w_serie_hasta,@i_localizacion,
            @w_sec_lote,@w_motivo)
        if (@@error<>0 or @@rowcount=0)
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 2903117
            rollback tran
            return 1    
        end
    COMMIT TRAN
    ------------------------------------------------------------------
    --  FIN : DE LA TRANSACCION DE SUSPENSION DEL INSTRUMENTO
    --  EN IMPRESION LOTES
    ------------------------------------------------------------------
end
return 0
go
