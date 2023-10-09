/********************************************************/
/*  ARCHIVO:         b_series.sp                        */
/*  NOMBRE LOGICO:   sp_buscar_series                   */
/*  PRODUCTO:        Servicios Bancarios                */
/********************************************************/
/*                   IMPORTANTE                         */
/*  Esta aplicacion es parte de los  paquetes bancarios */
/*  propiedad de MACOSA S.A.                            */
/*  Su uso no autorizado queda  expresamente  prohibido */ 
/*  asi como cualquier alteracion o agregado hecho  por */ 
/*  alguno de sus usuarios sin el debido consentimiento */ 
/*  por escrito de MACOSA.                              */
/*  Este programa esta protegido por la ley de derechos */
/*  de autor y por las convenciones  internacionales de */
/*  propiedad intelectual.  Su uso  no  autorizado dara */
/*  derecho a MACOSA para obtener ordenes  de secuestro */
/*  o  retencion  y  para  perseguir  penalmente a  los */
/*  autores de cualquier infraccion.                    */
/********************************************************/
/*                     PROPOSITO                        */
/*  Permite realizar la busqueda de las series          */
/*  correspondientes                                    */
/*  a los instrumentos  asignados al funcionario que va */
/*  a realizar la impresion, ademas permite asignar     */
/*  series a los registros de impresion en lotes        */
/*******************************************************************/
/*                     MODIFICACIONES                              */
/*   FECHA        AUTOR               RAZON                        */
/*   24-Dic-98    Ana M.Lopez        Emision Inicial               */
/*   24-Agt-06    Y. martinez        DEF 6637                      */
/*   11-May-2007 Y. martinez         NYM SNR 588                   */
/*   20-Ago-2008 JC Ponce de Leon C  Validacion Cursores Abiertos  */
/*******************************************************************/

use cob_sbancarios
go

if exists (select 1 from sysobjects where name = 'sp_buscar_series')
    drop proc sp_buscar_series
go

create proc sp_buscar_series
(
    @s_ssn          int         = null,
    @s_date         datetime    = null,
    @s_term         varchar(30) = null,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         login,
    @s_ofi          smallint    = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14)     = null,
    @t_trn          smallint    = null,
    @i_producto     tinyint,
    @i_instrumento  smallint,
    @i_subtipo      int,
    @i_serielit     varchar(10) = null,
    @i_serienum     money       = null,
    @i_operacion    char(1),
    @i_idlote       int         = null,
    @i_grupo1   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo2   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo3   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo4   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo5   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo6   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo7   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo8   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo9   varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo10  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo11  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo12  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo13  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo14  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo15  varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @o_idseries int = 0 out     /* Id. del grupo de regs. a los que se les va a asignar series */
)
as


/* Declaracion de variables de uso Interno */ 
declare @w_return           int,            /* Retorno de la ejecucion de un sp */
        @w_sp_name          varchar(32),    /* nombre del stored procedure*/    
        @w_user             smallint,       /* codigo del funcionario */
        @w_numeracion       estado,         /* subtipo tiene o no num autom tica */
        @w_serie_literal    varchar(10),    /* serie literal del instrumento */
        @w_serie_desde      money,          /* serie numerica inicial */
        @w_serie_hasta      money,          /* serie numerica final */
        @w_secuencial       int,            /* secuencial en la tabla de impresion en lotes */
        @w_serielit         varchar(10),    /* serie literal para impresion */
        @w_serienum         money,          /* serie num‚rica para impresion */
        @w_numreg           int,            /* numero de instrumentos que se va a imprimir */
        @w_sdesde           money,          /* serie num‚rica desde */
        @w_hora             varchar(10),    /* hora para transaccion de servicio */
        @w_contador         int,            /* contador de registros */
        @w_usados           int,            /* numero de series de instrumentos ya asignadas */
        @w_numregas         int,            /* numero de registros a los que falta asignar serie */
        @w_salir            tinyint,        /* bandera que indica salir del cursor  */
        @w_idseries         int,            /* id. del grupo de reg. del lote asignados series */
        
        /* Variables utilizadas en las transacciones de servicio */
        @v_estado           estado,         /* estado de la impresion */
        @v_producto         smallint,       /* codigo del producto */   
        @v_instrumento      tinyint,        /* codigo del instrumento */    
        @v_subtipo          int,            /* codigo del subtipo */
        @v_serie_literal    varchar(10),    /* serie literal */
        @v_serie_desde      money,          /* serie desde */
        @v_serie_hasta      money,          /* serie hasta */
        @v_area             smallint,       /* area */
        @v_func_area        smallint,       /* codigo del funcionario */
        @v_asignacion       estado,         /* indica si el instrumento est  o no asignado */
        @v_reservados       int,            /* numero de instrumentos asignados */
        @v_fecha_modif      datetime,       /* fecha de modificacion de puntos de reorden */
        @v_func_modif       smallint,       /* funcionario modificador de puntos de reorden */
        @v_maximo           int,            /* numero m ximo de instrumentos para el funcionario */
        @v_minimo           int,            /* numero m¡nimo de instrumentos para el funcionario */
        @v_actual           int,            /* cantidad de instrumentos que posee el funcionario */
        @w_codigo_alterno   int,            /* secuencial para transaccion de servicio */
        @v_secuencial       int,            /* secuencial de puntos de reorden */
        @w_datos            varchar(240)    /* datos generales para envisr info a ctas NYM SNR 588 */

/* Asignar el nombre del stored procedure */
select  @w_sp_name = 'sp_buscar_series'


/* Asignar la hora en @w_hora */
select @w_hora = convert(varchar(10),getdate(),108)     


/* Verificacion de tipo de transaccion */
if @t_trn <> 29300
begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 2902500
    return 1
end

/* Buscar codigo del funcionario */
select @w_user = fu_funcionario
from cobis..cl_funcionario
where   fu_login = @s_user


/* Buscar a cuantos registros se van a asignar series */
select  @w_numreg = count(1)
from    sb_impresion_lotes
where   il_oficina_destino  = @s_ofi
and     il_producto         = @i_producto
and     il_instrumento      = @i_instrumento
and     il_subtipo          = @i_subtipo
and     il_estado           = 'D'
and     il_idlote           = @i_idlote -- Ubicar el lote correspondiente

select @w_numreg


/* Verificar si el funcionario tiene instrumentos disponibles */
select  pr_actual  
from    sb_puntos_reorden
where   pr_oficina  = @s_ofi
--and     pr_func_area  = @w_user
and     pr_producto     = @i_producto
and     pr_instrumento  = @i_instrumento
and     pr_sub_tipo     = @i_subtipo
and     pr_actual       >= @w_numreg    

/* Si no se encuentran registros */
if @@rowcount = 0
begin
    /* El funcionario no posee instrumentos disponibles */
    exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2902585
    return 1
end


/* Inicializar el codigo alterno */
select @w_codigo_alterno = 0

/*--------------------------Verificar existencia de series por funcionario-------------*/
if @i_operacion = 'V'
begin

    select @w_serielit = @i_serielit

    /* Si @i_serielit es null entonces verificar exclusivamente la serie numerica (serie literal nula) */
    if @i_serielit is null
      select @w_serielit = ''


    /* Verificar si la serie ingresada por el funcionario est  asignada al mismo */
    select 1 from sb_inventario_ins
    where  (ii_producto         = @i_producto) and
           (ii_oficina          = @s_ofi) and
           (ii_instrumento      = @i_instrumento)and
           (ii_sub_tipo         = @i_subtipo)and
           (ii_serie_literal    = isnull(@w_serielit,ii_serie_literal)) and
           (((ii_serie_desde ) <= @i_serienum) and
             (ii_serie_hasta   >= @i_serienum))


    /* Si no se encuentran registros */
    if @@rowcount = 0
    begin
        /* El numero de serie ingresado es incorrecto */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 2902586
            return 1
    end
end

/*--------------------- Buscar series de instrumentos para realizar impresiones -------------*/
/* Se ejecuta cuando el subtipo tiene numeracion automatica */
if @i_operacion = 'B'
begin
begin tran
    /* Inicializar la bandera que indica que sale del cursor */
    select @w_salir = 0

    /* Consultar el numero de registros a los que hay que asignar serie */
    select  @w_numregas = count(1)
    from    sb_impresion_lotes
    where   il_oficina_destino  = @s_ofi
    and     il_producto         = @i_producto
    and     il_instrumento      = @i_instrumento
    and     il_subtipo          = @i_subtipo
    and     il_estado           = 'D'       -- estado: pendiente
    and     il_idlote           = @i_idlote -- Ubicar el lote correspondiente

    /* Guardar numero de registros a los que se asigna series en una variable auxiliar */
    select @w_usados = @w_numregas

    /* Obtener el identificador del grupo de registros a los que se les va a asignar series */
    exec @w_return = sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'sb_idseries',
            @o_siguiente = @w_idseries out
    
    /* Verificar si se produjo algun error en la generacion de secuenciales */
    if @w_return <> 0
    begin
       exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 2902633
       rollback tran
       return 1
    end

    select @o_idseries = @w_idseries


    /* Buscar series de subtipos disponibles */
    declare cur_series1 cursor for
    select  ii_serie_literal,
            ii_serie_desde,
            ii_serie_hasta
    from    sb_inventario_ins
    where   ii_oficina      = @s_ofi
    and     ii_producto     = @i_producto
    and     ii_instrumento  = @i_instrumento
    and     ii_sub_tipo     = @i_subtipo
--  and     ii_func_area    = @w_user
--  and     ii_asignacion   = 'S'
    order by ii_serie_literal, ii_serie_desde

    /* Abrir cursor de busqueda de series y posicionarse en el primer item */
    open cur_series1
    fetch cur_series1 into 
        @w_serie_literal,
        @w_serie_desde,
        @w_serie_hasta

    /* Si el cursor no trae registros, el func no tiene ins asignados */
    if @@fetch_status <> 0
    begin
        /* El funcionario no posee instrumentos disponibles */
        close cur_series1
        deallocate cur_series1
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 2902585
        rollback
        return 1
    end

    /* Mientras existan datos en el cursor de series */
    while @@fetch_status = 0 and @w_salir = 0
    begin
        select @w_sdesde = @w_serie_desde
        
        /* Si ocurre un error */    
        if @@fetch_status = -1
        begin
            close cur_series1
            deallocate cur_series1
            /* 'Error en busqueda de series para instrumentos' */
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 2902571
            rollback
            return 1
        end

        /* Buscar registros de instrumentos a los que se asignar  la serie */
        declare cur_lotes1 cursor for
        select  il_secuencial
        from    sb_impresion_lotes
        where   il_oficina_destino  = @s_ofi
        and     il_producto         = @i_producto
        and     il_instrumento      = @i_instrumento
        and     il_subtipo          = @i_subtipo
        and     il_estado           = 'D'
        and     il_idlote           = @i_idlote
        order by il_secuencial

        /* Abrir cursor de busqueda de registros de imp en lotes y posicionarse en el primer item */
        open cur_lotes1
        fetch cur_lotes1 into 
            @w_secuencial
    
        /* Mientras existan datos en el cursor de lotes */
        while @@fetch_status = 0 and @w_salir = 0
        begin
            /* Si ocurre un error */    
            if @@fetch_status = -1
            begin
                close cur_lotes1
                deallocate cur_lotes1                
                close cur_series1
                deallocate cur_series1
                /* 'Error en busqueda de instrumentos para impresion' */
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 2902587
                rollback
                return 1
            end         
                        
            /* Asignar series en la tabla de impresion en lotes y cambiar el estado a 'P' */
            /* Trans de servicio: Buscar valores originales */              
            select  @v_estado = il_estado
            from    sb_impresion_lotes
            where   il_secuencial = @w_secuencial

            /* Actualizacion de codigo alterno */
            select @w_codigo_alterno = @w_codigo_alterno + 1

            /* Transaccion de servicio: valor anterior*/
            insert into ts_impresion_lotes(
            secuencial, cod_alterno, tipo_transaccion, clase, fecha, 
            hora, usuario, terminal,oficina, tabla, lsrv, srv,
            idlote, sec, estado, funcimprime, fechaimp, funcautoriza, serielit, serienum
            )
            values(@s_ssn,@w_codigo_alterno,@t_trn,'O',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
            'sb_impresion_lotes',@s_lsrv,@s_srv,@i_idlote, @w_secuencial, @v_estado, null, null, null,
            null,null)

            if (@@error <> 0 or @@rowcount = 0)
            begin
                close cur_lotes1
                deallocate cur_lotes1                
                close cur_series1
                deallocate cur_series1
                /* 'No se pueden actualizar transacciones de servicio' */
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,  
                    @i_num   = 2902515
                rollback tran
                return 1
            end     

            update sb_impresion_lotes
            set il_serie_literal  = @w_serie_literal, 
                il_serie_numerica = @w_serie_desde,
                il_estado         = 'I',
                il_idseries       = @o_idseries
            where il_secuencial = @w_secuencial   

            /* Verificar si se produjo algun error en la actualizacion */
            if (@@error <> 0 or @@rowcount = 0)
            begin
                close cur_lotes1
                deallocate cur_lotes1                
                close cur_series1
                deallocate cur_series1
                exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 2902583
                rollback tran
                return 1
            end

            --NYM SNR 588  actualizo y envio ifnroamcion a cuentas corrientes
            select @w_datos = convert(varchar(30),@w_secuencial) + '@' + 'I' + '@' + '@' +  convert(varchar(30),@w_serie_desde) +  '@' + '@' + '0' + '@'   
            --print '@w_datos  %1! @i_producto %2! @i_instrumento %3! @i_subtipo %4! @i_idlote %5!', @w_datos , @i_producto, @i_instrumento, @i_subtipo, @i_idlote
            exec @w_return =  sp_actualizar_lotes
                    @s_ssn          = @s_ssn,
                    @s_date         = @s_date,
                    @s_term         = @s_term,
                    @s_srv          = @s_srv,
                    @s_lsrv         = @s_lsrv,
                    @s_user         = @s_user,
                    @s_ofi          = @s_ofi,
                    @t_debug        = 'N',
                    @t_file         = null,
                    @t_trn          = 29301,
                    @i_alterno      = @w_codigo_alterno,
                    @i_producto     = @i_producto,
                    @i_instrumento  = @i_instrumento,
                    @i_subtipo      = @i_subtipo,
                    @i_enlace_cc    = 'S',
                    @i_grupo1       = @w_datos,
                    @i_idlote       = @i_idlote

            if @w_return <> 0 
            begin
                close cur_lotes1
                deallocate cur_lotes1
                close cur_series1
                deallocate cur_series1
                /* 'No se puede ACTUALIZAR ESTADO NI ENVIAR INFO A CTACTE */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file   = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 2902583
                rollback
                return 1
            End

            /* Actualizacion de codigo alterno */
            select @w_codigo_alterno = @w_codigo_alterno + 1

            /* Transaccion de servicio: valor actual*/
            insert into ts_impresion_lotes(
            secuencial, cod_alterno, tipo_transaccion, clase, fecha, 
            hora, usuario, terminal,oficina, tabla, lsrv, srv,
            idlote, sec, estado, funcimprime, fechaimp, funcautoriza, serielit, serienum
            )
            values(@s_ssn,@w_codigo_alterno,@t_trn,'C',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
            'sb_impresion_lotes',@s_lsrv, @s_srv, @i_idlote, @w_secuencial, 'P',null,null,null,
            @w_serie_literal,@w_serie_desde)

            if (@@error <> 0 or @@rowcount = 0)
            begin 
                close cur_lotes1
                deallocate cur_lotes1                
                close cur_series1
                deallocate cur_series1
                /* 'No se pueden actualizar transacciones de servicio' */
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,  
                    @i_num   = 2902515
                rollback tran
                return 1
            end
                
            select @w_serie_desde = @w_serie_desde + 1                                              
            select @w_numregas = @w_numregas - 1

            /* Si se ocupo todo el registro borrarlo del inventario */
            if @w_serie_desde > @w_serie_hasta
            begin
                /* Tomar valores para transaccion de servicio */
                select  @v_producto         = ii_producto,
                        @v_instrumento      = ii_instrumento,
                        @v_subtipo          = ii_sub_tipo,
                        @v_serie_literal    = ii_serie_literal,
                        @v_serie_desde      = ii_serie_desde,
                        @v_serie_hasta      = ii_serie_hasta,
                        @v_area             = ii_area,
                        @v_func_area        = ii_func_area,
                        @v_asignacion       = ii_asignacion,
                        @v_reservados       = ii_reservado
                from sb_inventario_ins
                where   ii_oficina  = @s_ofi and
                    ii_producto = @i_producto and
                    ii_instrumento  = @i_instrumento and
                    ii_sub_tipo = @i_subtipo and
                    ii_serie_literal= @w_serie_literal and
                    (ii_serie_desde )<=@w_sdesde and 
                    ii_serie_hasta >= @w_serie_hasta
    
                if @@rowcount = 0
                begin
                   close cur_lotes1
                   deallocate cur_lotes1                   
                   close cur_series1
                   deallocate cur_series1
                    /* 'No se pueden obtener valores originales'*/
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902516
                    rollback tran
                    return 1
                end

                /* Borrar del inventario el registro */ 
                delete  sb_inventario_ins
                where   ii_oficina          = @s_ofi
                and     ii_producto         = @i_producto
                and     ii_instrumento      = @i_instrumento
                and     ii_sub_tipo         = @i_subtipo
                --and   ii_func_area        = @w_user
                and     ii_serie_literal    = @w_serie_literal
                and     ii_serie_desde      = @w_sdesde
                and     ii_serie_hasta      = @w_serie_hasta
            
                /*Si no se pudo eliminar*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    close cur_lotes1
                    deallocate cur_lotes1
                    close cur_series1
                    deallocate cur_series1
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902570
                    rollback tran
                    return 1    
                end

                /* Actualizacion de codigo alterno */
                select @w_codigo_alterno = @w_codigo_alterno + 1

                /* Transaccion de servicio: insertar valor a eliminar*/ 
                select @w_codigo_alterno = @w_codigo_alterno + 1
                insert into ts_inventario_ins
                values(@s_ssn,@w_codigo_alterno,@t_trn,'D',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
                'sb_inventario_ins',@s_lsrv,@s_srv,@v_producto,@v_instrumento,@v_subtipo,@v_serie_literal,@v_serie_desde,
                @v_serie_hasta,@v_area,@v_func_area,@v_asignacion)
    
                /*Si no se pudo actualizar transaccion de servicio*/
                if (@@error<>0 or @@rowcount=0)
                begin
                    close cur_lotes1                
                    deallocate cur_lotes1
                    close cur_series1
                    deallocate cur_series1
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 2902515
                    rollback tran
                    return 1    
                end
            end

            /* Si ya se termino la asignacion, cerrar los cursores */
            if @w_numregas = 0 
            begin
                /* Cursor de registros de imp en lotes */
                close cur_lotes1
                deallocate cur_lotes1
                /* Cursor de series */
                close cur_series1
                deallocate cur_series1
                select @w_salir = 1
            end
            else            
            begin
                /* Consultar siguiente registro del cursor de lotes */
                fetch cur_lotes1 into 
                    @w_secuencial
                
                /* Si el registro de series no es suficiente consultar otro */
                if @w_serie_desde > @w_serie_hasta
                begin   
                    /* Consultar siguiente registro del cursor */
                    fetch cur_series1 into 
                    @w_serie_literal,
                    @w_serie_desde,
                    @w_serie_hasta
                end                 
            end
        end /* fin del while del cursor de lotes */

        if (Cursor_Status('LOCAL','cur_lotes1')<0) and (@w_salir = 1)
          begin
            -- 'El cursor esta cerrado y no lo cierra nuevamente'
            select @w_salir = 1
          end
        else
          begin
            select Cursor_Status('GLOBAL','cur_lotes1')
            close cur_lotes1
            deallocate cur_lotes1
         end
    end /* fin del while del cursor de series */    
    if (Cursor_Status('GLOBAL','cur_series1')<0)
      begin
        -- 'El cursor esta cerrado y no lo cierra nuevamente'
        select @w_salir = 1
      end
    else
     begin
       select Cursor_Status('GLOBAL','cur_series1')
       close cur_series1
       deallocate cur_series1
     end
   
    /* Actualizar el inventario */
    if @w_serie_desde <= @w_serie_hasta
    begin
        /* Tomar valores para transaccion de servicio */
        select  @v_producto     = ii_producto,
                @v_instrumento  = ii_instrumento,
                @v_subtipo      = ii_sub_tipo,
                @v_serie_literal= ii_serie_literal,
                @v_serie_desde  = ii_serie_desde,
                @v_serie_hasta  = ii_serie_hasta,
                @v_area         = ii_area,
                @v_func_area    = ii_func_area,
                @v_asignacion   = ii_asignacion,
                @v_reservados   = ii_reservado
        from    sb_inventario_ins
        where   ii_oficina          = @s_ofi and
                ii_producto         = @i_producto and
                ii_instrumento      = @i_instrumento and
                ii_sub_tipo         = @i_subtipo and
                ii_serie_literal    = @w_serie_literal and
                (ii_serie_desde )   <= @w_sdesde and 
                ii_serie_hasta      >= @w_serie_hasta

        if @@rowcount = 0
        begin
            /* 'No se pueden obtener valores originales'*/
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 2902516
            rollback tran
            return 1
        end

        /* Transaccion de servicio: valor anterior*/    
        select @w_codigo_alterno = @w_codigo_alterno + 1

        insert into ts_inventario_ins
        values(@s_ssn,@w_codigo_alterno,@t_trn,'O',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
        'sb_inventario_ins',@s_lsrv,@s_srv,@v_producto,@v_instrumento,@v_subtipo,@v_serie_literal,@v_serie_desde,
        @v_serie_hasta,@v_area,@v_func_area,@v_asignacion)

        if (@@error <> 0 or @@rowcount = 0)
        begin 
            /* 'No se pueden actualizar transacciones de servicio' */
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,  
                @i_num   = 2902515
            rollback tran
            return 1
        end

        update  sb_inventario_ins
        set     ii_serie_desde  = @w_serie_desde,
                ii_disponible   = ii_disponible - @w_usados --NYM DEF 6637
        where   ii_oficina      = @s_ofi
        and     ii_producto     = @i_producto
        and     ii_instrumento  = @i_instrumento
        and     ii_sub_tipo     = @i_subtipo
--      and     ii_func_area    = @w_user
        and     ii_serie_literal = @w_serie_literal
        and     ii_serie_hasta  = @w_serie_hasta

        /* error en la actualizacion */
        if (@@error <> 0 or @@rowcount = 0)
        begin 
            /* No se puede actualizar inventario de instrumentos  */
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,  
                @i_num   = 2902567
            rollback tran
            return 1
        end

        /* Transaccion de servicio: valor actual*/
        select @w_codigo_alterno = @w_codigo_alterno + 1

        insert into ts_inventario_ins
        values(@s_ssn,@w_codigo_alterno,@t_trn,'C',@s_date,@w_hora,@s_user,@s_term,@s_ofi,
        'sb_inventario_ins',@s_lsrv,@s_srv,@v_producto,@v_instrumento,@v_subtipo,@v_serie_literal,@v_serie_desde,
        @v_serie_hasta,@v_area,@v_func_area,@v_asignacion)

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

    /* Actualizar puntos de reorden */
    /* Seleccionar el registro destino a modificar */
    select  @v_secuencial       = pr_secuencial,
            @v_area             = pr_area,
            @v_func_area        = pr_func_area,
            @v_fecha_modif      = pr_fecha_modif,
            @v_func_modif       = pr_func_modif,
            @v_producto         = pr_producto,
            @v_instrumento      = pr_instrumento,
            @v_subtipo          = pr_sub_tipo,
            @v_maximo           = pr_maximo,
            @v_minimo           = pr_minimo,
            @v_actual           = pr_actual
    from sb_puntos_reorden
    where   pr_producto     = @i_producto
    and     pr_oficina      = @s_ofi
    and     pr_instrumento  = @i_instrumento
    and     pr_sub_tipo     = @i_subtipo        

    if @@rowcount = 0
    begin
        /* 'No se pueden obtener valores originales'*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2902516
        rollback tran
        return 1
    end
            
    update sb_puntos_reorden
    set     pr_actual   = pr_actual - @w_usados,
            pr_egreso   = pr_egreso + @w_usados
    where   pr_oficina  = @s_ofi
    and     pr_producto     = @i_producto
    and     pr_instrumento  = @i_instrumento
    and     pr_sub_tipo     = @i_subtipo            

    /* Verificacion de errores */
        if (@@error <> 0 or @@rowcount = 0)
    begin
        exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 2902577
            rollback tran               
        return 1
    end

    /* Actualizacion de codigo alterno */
    select @w_codigo_alterno = @w_codigo_alterno + 1


    /* Insercion en la tabla de servicios: Registro antiguo */                  
    insert into ts_puntos_reorden(
        secuencial, cod_alterno, tipo_transaccion, clase, fecha, hora,
        usuario, terminal, oficina, tabla, lsrv, srv,   
        area, func_area, fecha_modif, func_modif, producto, instrumento,
        sub_tipo, maximo, minimo, actual)
    values( @s_ssn,@w_codigo_alterno,@t_trn,'O',@s_date,@w_hora, @s_user,
        @s_term, @s_ofi, 'sb_puntos_reorden', @s_lsrv, @s_srv, 
        @v_area, @v_func_area,@v_fecha_modif, @v_func_modif, @v_producto,
        @v_instrumento, @v_subtipo, @v_maximo,@v_minimo, @v_actual)
    
    /*Si no se pudo actualizar transaccion de servicio*/ 
    if (@@error<>0)
    begin
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2902515
        rollback tran
        return 1    
    end 

    /* Actualizacion de codigo alterno */
    select @w_codigo_alterno = @w_codigo_alterno + 1

    /* Transaccion de servicio: Registro actual*/           
    insert into ts_puntos_reorden(
        secuencial, cod_alterno, tipo_transaccion, clase, fecha, hora,
        usuario, terminal, oficina, tabla, lsrv, srv,   
        area, func_area, fecha_modif, func_modif, producto, instrumento,
        sub_tipo, maximo, minimo, actual)
    values( @s_ssn,@w_codigo_alterno,@t_trn,'C',@s_date,@w_hora, @s_user,
        @s_term,@s_ofi,'sb_puntos_reorden',@s_lsrv,@s_srv,@v_area,
        @v_func_area,@v_fecha_modif,@v_func_modif,@v_producto,
        @v_instrumento, @v_subtipo, @v_maximo,@v_minimo, (@v_actual - @w_usados))

    /*Si no se pudo actualizar transaccion de servicio*/
    if (@@error<>0)
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
end
return 0
go
